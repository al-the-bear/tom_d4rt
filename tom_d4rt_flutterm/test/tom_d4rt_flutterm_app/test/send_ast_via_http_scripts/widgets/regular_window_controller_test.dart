// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────
//  RegularWindowController  –  Deep Visual Demo
//
//  Palette : Indigo 900 / Orange 400
//  Tabs    : Theory · Window Operations Lab · Architecture
// ─────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  print('RegularWindowController demo building');
  return _WindowControllerDemo();
}

// ── colour constants ────────────────────────────────────
const _kPrimary = Color(0xFF1A237E); // Indigo 900
const _kAccent = Color(0xFFFFA726); // Orange 400
const _kSurface = Color(0xFFE8EAF6); // Indigo 50
const _kCardBg = Color(0xFFFFFFFF);
const _kDarkText = Color(0xFF0D47A1); // Blue 900
const _kMuted = Color(0xFF9FA8DA); // Indigo 200
const _kCodeBg = Color(0xFFFFF3E0); // Orange 50
const _kHighlight = Color(0xFFFFF8E1); // Amber 50
const _kAbstractColor = Color(0xFF6A1B9A); // Purple 800
const _kConcreteColor = Color(0xFF2E7D32); // Green 800
const _kDelegateColor = Color(0xFFC62828); // Red 800
const _kSystemColor = Color(0xFF37474F); // BlueGrey 800
const _kWindowBorder = Color(0xFF3949AB); // Indigo 600

class _WindowControllerDemo extends StatefulWidget {
  @override
  State<_WindowControllerDemo> createState() => _WindowControllerDemoState();
}

class _WindowControllerDemoState extends State<_WindowControllerDemo>
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
        title: Text('RegularWindowController',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
        backgroundColor: _kPrimary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabCtrl,
          indicatorColor: _kAccent,
          indicatorWeight: 3,
          labelColor: _kAccent,
          unselectedLabelColor: Colors.white60,
          tabs: [
            Tab(icon: Icon(Icons.school, size: 16), text: 'Theory'),
            Tab(icon: Icon(Icons.desktop_windows, size: 16), text: 'Operations Lab'),
            Tab(icon: Icon(Icons.account_tree, size: 16), text: 'Architecture'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: [
          _TheoryTab(),
          _OperationsLabTab(),
          _ArchitectureTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  TAB 1 — THEORY
// ═══════════════════════════════════════════════════════════

class _TheoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // ── hero banner ───────────────────────────────
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_kPrimary, Color(0xFF283593)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(color: _kPrimary.withOpacity(0.3), blurRadius: 12, offset: Offset(0, 4)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.desktop_windows, color: _kAccent, size: 28),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('RegularWindowController',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w800)),
                        SizedBox(height: 3),
                        Text('Abstract base class for multi-window management',
                            style: TextStyle(color: _kAccent, fontSize: 11)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'RegularWindowController is the abstract contract that every '
                'platform-specific window controller must implement. It defines '
                'the fundamental operations for creating, managing, and destroying '
                'application windows in Flutter\'s multi-window architecture.',
                style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
              ),
            ],
          ),
        ),

        SizedBox(height: 20),

        // ── purpose & motivation ──────────────────────
        _SectionCard(
          title: 'Purpose & Motivation',
          icon: Icons.lightbulb_outline,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _InfoRow(
                label: 'Problem',
                value: 'Desktop apps need multiple independently-managed windows, '
                    'but each OS (macOS, Linux, Windows) has vastly different windowing APIs.',
              ),
              _InfoRow(
                label: 'Solution',
                value: 'RegularWindowController defines a portable interface that '
                    'abstracts platform-specific window management behind a single contract.',
              ),
              _InfoRow(
                label: 'Design',
                value: 'Uses the Controller pattern: each window gets a controller '
                    'instance that owns its lifecycle and state. Platform sub-classes '
                    'bridge the abstract API to native calls.',
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _kHighlight,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _kAccent.withOpacity(0.4)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: _kPrimary, size: 18),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'The controller does NOT own the widget tree. It manages the '
                        'native window frame, while Flutter renders content inside it.',
                        style: TextStyle(fontSize: 11, color: _kDarkText, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 14),

        // ── class hierarchy ──────────────────────────
        _SectionCard(
          title: 'Class Hierarchy',
          icon: Icons.account_tree,
          child: Column(
            children: [
              // Root: abstract base
              _HierarchyNode(
                label: 'RegularWindowController',
                subtitle: 'abstract base class',
                color: _kAbstractColor,
                isAbstract: true,
                depth: 0,
              ),
              // Platform implementations
              _HierarchyNode(
                label: 'RegularWindowControllerMacOS',
                subtitle: 'Cocoa / AppKit bridge',
                color: _kConcreteColor,
                isAbstract: false,
                depth: 1,
              ),
              _HierarchyNode(
                label: 'RegularWindowControllerLinux',
                subtitle: 'GTK / GDK bridge',
                color: _kConcreteColor,
                isAbstract: false,
                depth: 1,
              ),
              _HierarchyNode(
                label: 'RegularWindowControllerWindows',
                subtitle: 'Win32 / WinRT bridge',
                color: _kConcreteColor,
                isAbstract: false,
                depth: 1,
              ),

              SizedBox(height: 12),

              // Related classes
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _kCodeBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Related Types',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: _kDarkText)),
                    SizedBox(height: 8),
                    _RelatedType(
                      name: 'RegularWindowControllerDelegate',
                      role: 'Receives lifecycle callbacks from the controller',
                      color: _kDelegateColor,
                    ),
                    SizedBox(height: 6),
                    _RelatedType(
                      name: 'WindowController',
                      role: 'Parent abstract interface (if separate from regular)',
                      color: _kAbstractColor,
                    ),
                    SizedBox(height: 6),
                    _RelatedType(
                      name: 'WidgetsBinding',
                      role: 'Integrates window controller with Framework binding',
                      color: _kSystemColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 14),

        // ── core responsibilities ────────────────────
        _SectionCard(
          title: 'Core Responsibilities',
          icon: Icons.assignment,
          child: Column(
            children: [
              _ResponsibilityCard(
                number: '1',
                title: 'Window Creation',
                description: 'Allocates a native window with initial size, position, '
                    'and title. Sets up the rendering surface for Flutter content.',
                icon: Icons.add_box_outlined,
                color: Color(0xFF1565C0),
              ),
              SizedBox(height: 8),
              _ResponsibilityCard(
                number: '2',
                title: 'Geometry Management',
                description: 'Controls window position (offset), size (width/height), '
                    'and constraints (min/max). Responds to user-initiated resize events.',
                icon: Icons.crop_free,
                color: Color(0xFF00838F),
              ),
              SizedBox(height: 8),
              _ResponsibilityCard(
                number: '3',
                title: 'State Transitions',
                description: 'Manages window states: normal, minimized, maximized, '
                    'fullscreen. Notifies delegates of state changes.',
                icon: Icons.swap_vert,
                color: Color(0xFF6A1B9A),
              ),
              SizedBox(height: 8),
              _ResponsibilityCard(
                number: '4',
                title: 'Lifecycle Ownership',
                description: 'Drives the full lifecycle: initialization → showing → '
                    'hiding → close request → destruction. Coordinates with delegates.',
                icon: Icons.loop,
                color: Color(0xFFC62828),
              ),
              SizedBox(height: 8),
              _ResponsibilityCard(
                number: '5',
                title: 'Title & Appearance',
                description: 'Sets window title bar text, icon, and platform-specific '
                    'chrome controls (traffic lights, title bar color).',
                icon: Icons.title,
                color: Color(0xFF2E7D32),
              ),
            ],
          ),
        ),

        SizedBox(height: 14),

        // ── API surface ─────────────────────────────
        _SectionCard(
          title: 'Abstract API Surface',
          icon: Icons.api,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'These are the key members that every platform controller '
                'must implement:',
                style: TextStyle(fontSize: 11, color: Colors.black54, height: 1.4),
              ),
              SizedBox(height: 12),
              _ApiMember(
                name: 'size',
                type: 'Size',
                kind: 'getter',
                description: 'Current window size in logical pixels',
              ),
              _ApiMember(
                name: 'position',
                type: 'Offset',
                kind: 'getter',
                description: 'Window position on screen (top-left corner)',
              ),
              _ApiMember(
                name: 'title',
                type: 'String',
                kind: 'getter/setter',
                description: 'Title bar text',
              ),
              _ApiMember(
                name: 'setSize(Size)',
                type: 'void',
                kind: 'method',
                description: 'Programmatically resize the window',
              ),
              _ApiMember(
                name: 'setPosition(Offset)',
                type: 'void',
                kind: 'method',
                description: 'Move window to a screen coordinate',
              ),
              _ApiMember(
                name: 'close()',
                type: 'Future<void>',
                kind: 'method',
                description: 'Request orderly window closure',
              ),
              _ApiMember(
                name: 'destroy()',
                type: 'void',
                kind: 'method',
                description: 'Immediate window destruction (no confirmation)',
              ),
              _ApiMember(
                name: 'minimize()',
                type: 'void',
                kind: 'method',
                description: 'Minimize to taskbar / dock',
              ),
              _ApiMember(
                name: 'maximize()',
                type: 'void',
                kind: 'method',
                description: 'Maximize or restore to fill screen',
              ),
              _ApiMember(
                name: 'setFullscreen(bool)',
                type: 'void',
                kind: 'method',
                description: 'Enter or exit fullscreen mode',
              ),
              _ApiMember(
                name: 'focus()',
                type: 'void',
                kind: 'method',
                description: 'Bring window to front and give keyboard focus',
              ),
              _ApiMember(
                name: 'delegate',
                type: 'RegularWindowControllerDelegate?',
                kind: 'property',
                description: 'Lifecycle callback receiver',
              ),
            ],
          ),
        ),

        SizedBox(height: 14),

        // ── controller vs widget comparison ──────────
        _SectionCard(
          title: 'Controller vs. Widget Layer',
          icon: Icons.compare_arrows,
          child: _ComparisonTable(),
        ),

        SizedBox(height: 24),
      ],
    );
  }
}

// ── theory helpers ──────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  const _SectionCard({required this.title, required this.icon, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: _kPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(icon, color: _kPrimary, size: 16),
              ),
              SizedBox(width: 10),
              Text(title,
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w700, color: _kDarkText)),
            ],
          ),
          SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 70,
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: _kPrimary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(label,
                style: TextStyle(
                    fontSize: 10, fontWeight: FontWeight.w700, color: _kPrimary)),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 11, color: Colors.black87, height: 1.4)),
          ),
        ],
      ),
    );
  }
}

class _HierarchyNode extends StatelessWidget {
  final String label;
  final String subtitle;
  final Color color;
  final bool isAbstract;
  final int depth;
  const _HierarchyNode({
    required this.label,
    required this.subtitle,
    required this.color,
    required this.isAbstract,
    required this.depth,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: depth * 28.0, bottom: 6),
      child: Row(
        children: [
          if (depth > 0) ...[
            Container(width: 16, height: 1, color: color.withOpacity(0.4)),
            SizedBox(width: 4),
          ],
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: color.withOpacity(0.3),
                  style: isAbstract ? BorderStyle.solid : BorderStyle.solid,
                  width: isAbstract ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isAbstract ? Icons.category : Icons.memory,
                    size: 14,
                    color: color,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: color,
                            fontStyle: isAbstract ? FontStyle.italic : FontStyle.normal,
                          ),
                        ),
                        Text(subtitle,
                            style: TextStyle(fontSize: 9, color: Colors.black54)),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      isAbstract ? 'abstract' : 'concrete',
                      style: TextStyle(fontSize: 8, color: color, fontWeight: FontWeight.w600),
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
}

class _RelatedType extends StatelessWidget {
  final String name;
  final String role;
  final Color color;
  const _RelatedType({required this.name, required this.role, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        SizedBox(width: 8),
        Text(name, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: color)),
        SizedBox(width: 6),
        Expanded(
          child: Text('— $role', style: TextStyle(fontSize: 10, color: Colors.black54)),
        ),
      ],
    );
  }
}

class _ResponsibilityCard extends StatelessWidget {
  final String number;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  const _ResponsibilityCard({
    required this.number,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(number,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: color)),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, size: 14, color: color),
                    SizedBox(width: 6),
                    Text(title,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w700, color: color)),
                  ],
                ),
                SizedBox(height: 4),
                Text(description,
                    style: TextStyle(fontSize: 11, color: Colors.black87, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ApiMember extends StatelessWidget {
  final String name;
  final String type;
  final String kind;
  final String description;
  const _ApiMember({
    required this.name,
    required this.type,
    required this.kind,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: _kCodeBg,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: _kAccent.withOpacity(0.25)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: _kPrimary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(kind,
                  style: TextStyle(fontSize: 8, color: _kPrimary, fontWeight: FontWeight.w600)),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(name,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: _kDarkText,
                              fontFamily: 'monospace')),
                      SizedBox(width: 6),
                      Text('→ $type',
                          style: TextStyle(
                              fontSize: 10, color: _kConcreteColor, fontFamily: 'monospace')),
                    ],
                  ),
                  SizedBox(height: 2),
                  Text(description,
                      style: TextStyle(fontSize: 10, color: Colors.black54)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ComparisonTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // header row
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: _kPrimary.withOpacity(0.08),
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
          ),
          child: Row(
            children: [
              Expanded(
                  child: Text('Aspect',
                      style: TextStyle(
                          fontSize: 10, fontWeight: FontWeight.w700, color: _kPrimary))),
              Expanded(
                  child: Text('Controller Layer',
                      style: TextStyle(
                          fontSize: 10, fontWeight: FontWeight.w700, color: _kConcreteColor))),
              Expanded(
                  child: Text('Widget Layer',
                      style: TextStyle(
                          fontSize: 10, fontWeight: FontWeight.w700, color: _kDelegateColor))),
            ],
          ),
        ),
        _CompRow('Scope', 'Native window frame', 'Content inside window'),
        _CompRow('Controls', 'Size, position, title', 'Widget tree, layout'),
        _CompRow('Platform', 'OS-specific impl', 'Platform-agnostic'),
        _CompRow('Lifetime', 'Owns window lifecycle', 'Owned by framework'),
        _CompRow('Events', 'Resize, move, focus', 'Tap, scroll, gesture'),
        _CompRow('Thread', 'Platform thread', 'UI thread / isolate'),
      ],
    );
  }
}

class _CompRow extends StatelessWidget {
  final String aspect;
  final String controller;
  final String widget;
  const _CompRow(this.aspect, this.controller, this.widget);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          Expanded(
              child: Text(aspect,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.black87))),
          Expanded(
              child: Text(controller,
                  style: TextStyle(fontSize: 10, color: _kConcreteColor))),
          Expanded(
              child: Text(widget,
                  style: TextStyle(fontSize: 10, color: _kDelegateColor))),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  TAB 2 — WINDOW OPERATIONS LAB
// ═══════════════════════════════════════════════════════════

class _OperationsLabTab extends StatefulWidget {
  @override
  State<_OperationsLabTab> createState() => _OperationsLabTabState();
}

enum _WindowState { normal, minimized, maximized, fullscreen, destroyed }

class _SimulatedWindow {
  String id;
  String title;
  double x;
  double y;
  double width;
  double height;
  _WindowState state;
  bool hasFocus;
  Color chrome;

  _SimulatedWindow({
    required this.id,
    required this.title,
    this.x = 40,
    this.y = 40,
    double initialWidth = 180,
    double initialHeight = 120,
    this.chrome = _kWindowBorder,
  })  : width = initialWidth,
        height = initialHeight,
        state = _WindowState.normal,
        hasFocus = true;

  String get stateLabel {
    switch (state) {
      case _WindowState.normal:
        return 'Normal';
      case _WindowState.minimized:
        return 'Minimized';
      case _WindowState.maximized:
        return 'Maximized';
      case _WindowState.fullscreen:
        return 'Fullscreen';
      case _WindowState.destroyed:
        return 'Destroyed';
    }
  }

  IconData get stateIcon {
    switch (state) {
      case _WindowState.normal:
        return Icons.crop_din;
      case _WindowState.minimized:
        return Icons.minimize;
      case _WindowState.maximized:
        return Icons.crop_square;
      case _WindowState.fullscreen:
        return Icons.fullscreen;
      case _WindowState.destroyed:
        return Icons.delete_forever;
    }
  }
}

class _OperationsLabTabState extends State<_OperationsLabTab> {
  final List<_SimulatedWindow> _windows = [];
  int _nextId = 1;
  String? _selectedId;
  final List<String> _eventLog = [];

  void _log(String msg) {
    setState(() {
      final ts = TimeOfDay.now().format(context);
      _eventLog.insert(0, '[$ts] $msg');
      if (_eventLog.length > 40) _eventLog.removeLast();
    });
    print('WindowOp: $msg');
  }

  _SimulatedWindow? get _selected {
    if (_selectedId == null) return null;
    final idx = _windows.indexWhere((w) => w.id == _selectedId);
    return idx >= 0 ? _windows[idx] : null;
  }

  void _createWindow() {
    final id = 'win-$_nextId';
    _nextId++;
    final colors = [
      _kWindowBorder,
      Color(0xFF00695C),
      Color(0xFF6A1B9A),
      Color(0xFFC62828),
      Color(0xFF37474F),
      Color(0xFFEF6C00),
    ];
    final chrome = colors[_windows.length % colors.length];
    final win = _SimulatedWindow(
      id: id,
      title: 'Window $id',
      x: 20.0 + (_windows.length * 30) % 160,
      y: 20.0 + (_windows.length * 20) % 100,
      chrome: chrome,
    );
    setState(() {
      _windows.add(win);
      _focusWindow(id);
    });
    _log('controller.create("$id") → size=${win.width.toInt()}×${win.height.toInt()}');
  }

  void _focusWindow(String id) {
    setState(() {
      for (final w in _windows) {
        w.hasFocus = w.id == id;
      }
      _selectedId = id;
    });
    _log('controller.focus("$id")');
  }

  void _closeWindow(String id) {
    final win = _windows.firstWhere((w) => w.id == id);
    _log('controller.close("$id") → delegate.windowShouldClose()');
    setState(() {
      win.state = _WindowState.destroyed;
    });
    Future.delayed(Duration(milliseconds: 400), () {
      if (!mounted) return;
      setState(() {
        _windows.removeWhere((w) => w.id == id);
        if (_selectedId == id) {
          _selectedId = _windows.isNotEmpty ? _windows.last.id : null;
        }
      });
      _log('controller.destroy("$id") → native window released');
    });
  }

  void _resizeSelected(double dw, double dh) {
    final w = _selected;
    if (w == null || w.state == _WindowState.destroyed) return;
    setState(() {
      w.width = (w.width + dw).clamp(80, 300);
      w.height = (w.height + dh).clamp(60, 200);
    });
    _log('controller.setSize("${w.id}", ${w.width.toInt()}×${w.height.toInt()})');
  }

  void _moveSelected(double dx, double dy) {
    final w = _selected;
    if (w == null || w.state == _WindowState.destroyed) return;
    setState(() {
      w.x = (w.x + dx).clamp(0, 280);
      w.y = (w.y + dy).clamp(0, 180);
    });
    _log('controller.setPosition("${w.id}", ${w.x.toInt()}, ${w.y.toInt()})');
  }

  void _setWindowState(_WindowState newState) {
    final w = _selected;
    if (w == null || w.state == _WindowState.destroyed) return;
    setState(() {
      w.state = newState;
    });
    _log('controller.${newState.name}("${w.id}")');
  }

  void _renameSelected(String newTitle) {
    final w = _selected;
    if (w == null) return;
    setState(() {
      w.title = newTitle;
    });
    _log('controller.setTitle("${w.id}", "$newTitle")');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── toolbar ──────────────────────────────────
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          color: _kPrimary.withOpacity(0.06),
          child: Row(
            children: [
              _ToolButton(
                label: 'New Window',
                icon: Icons.add,
                color: _kConcreteColor,
                onTap: _createWindow,
              ),
              SizedBox(width: 6),
              if (_selected != null) ...[
                _ToolButton(
                  label: 'Close',
                  icon: Icons.close,
                  color: _kDelegateColor,
                  onTap: () => _closeWindow(_selectedId!),
                ),
                SizedBox(width: 6),
                _ToolButton(
                  label: 'Min',
                  icon: Icons.minimize,
                  color: _kSystemColor,
                  onTap: () => _setWindowState(_WindowState.minimized),
                ),
                SizedBox(width: 4),
                _ToolButton(
                  label: 'Max',
                  icon: Icons.crop_square,
                  color: _kSystemColor,
                  onTap: () => _setWindowState(_WindowState.maximized),
                ),
                SizedBox(width: 4),
                _ToolButton(
                  label: 'Restore',
                  icon: Icons.crop_din,
                  color: _kSystemColor,
                  onTap: () => _setWindowState(_WindowState.normal),
                ),
                SizedBox(width: 4),
                _ToolButton(
                  label: 'Full',
                  icon: Icons.fullscreen,
                  color: _kAbstractColor,
                  onTap: () => _setWindowState(_WindowState.fullscreen),
                ),
              ],
              Spacer(),
              Text('Windows: ${_windows.length}',
                  style: TextStyle(fontSize: 10, color: _kPrimary, fontWeight: FontWeight.w600)),
            ],
          ),
        ),

        // ── main area: canvas + controls ─────────────
        Expanded(
          child: Row(
            children: [
              // left: window canvas
              Expanded(
                flex: 3,
                child: _WindowCanvas(
                  windows: _windows,
                  selectedId: _selectedId,
                  onSelect: _focusWindow,
                ),
              ),
              // right: inspector & controls
              Container(width: 1, color: Colors.black12),
              SizedBox(
                width: 190,
                child: _InspectorPanel(
                  selected: _selected,
                  onResize: _resizeSelected,
                  onMove: _moveSelected,
                  onRename: _renameSelected,
                  windows: _windows,
                  onSelectWindow: _focusWindow,
                ),
              ),
            ],
          ),
        ),

        // ── event log ────────────────────────────────
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            border: Border(top: BorderSide(color: _kAccent, width: 2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Row(
                  children: [
                    Icon(Icons.terminal, size: 12, color: _kAccent),
                    SizedBox(width: 6),
                    Text('Controller Event Log',
                        style: TextStyle(
                            color: _kAccent, fontSize: 10, fontWeight: FontWeight.w700)),
                    Spacer(),
                    GestureDetector(
                      onTap: () => setState(() => _eventLog.clear()),
                      child: Text('Clear',
                          style: TextStyle(color: Colors.white38, fontSize: 9)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  itemCount: _eventLog.length,
                  itemBuilder: (_, i) => Text(
                    _eventLog[i],
                    style: TextStyle(
                        color: i == 0 ? Colors.greenAccent : Colors.white54,
                        fontSize: 9,
                        fontFamily: 'monospace'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── canvas that draws simulated windows ──────────────────

class _WindowCanvas extends StatelessWidget {
  final List<_SimulatedWindow> windows;
  final String? selectedId;
  final ValueChanged<String> onSelect;

  const _WindowCanvas({
    required this.windows,
    required this.selectedId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF1B2838),
      child: Stack(
        children: [
          // desktop wallpaper pattern
          Positioned.fill(
            child: CustomPaint(painter: _DesktopGridPainter()),
          ),
          // taskbar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 28,
              color: Color(0xFF0D1117),
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Icon(Icons.apps, color: Colors.white38, size: 14),
                  SizedBox(width: 8),
                  ...windows.map((w) => Padding(
                        padding: EdgeInsets.only(right: 4),
                        child: GestureDetector(
                          onTap: () => onSelect(w.id),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: w.id == selectedId
                                  ? w.chrome.withOpacity(0.3)
                                  : Colors.white10,
                              borderRadius: BorderRadius.circular(4),
                              border: w.hasFocus
                                  ? Border(
                                      bottom: BorderSide(
                                          color: w.chrome, width: 2))
                                  : null,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: w.state == _WindowState.destroyed
                                        ? Colors.red
                                        : w.state == _WindowState.minimized
                                            ? Colors.white30
                                            : w.chrome,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  w.title.length > 10
                                      ? '${w.title.substring(0, 9)}...'
                                      : w.title,
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 9),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                  Spacer(),
                  Text('Desktop',
                      style: TextStyle(color: Colors.white24, fontSize: 9)),
                ],
              ),
            ),
          ),
          // window frames
          ...windows.where((w) => w.state != _WindowState.destroyed && w.state != _WindowState.minimized).map((w) {
            final isMax = w.state == _WindowState.maximized;
            final isFull = w.state == _WindowState.fullscreen;
            final left = isMax || isFull ? 0.0 : w.x;
            final top = isMax || isFull ? 0.0 : w.y;
            final ww = isFull ? 400.0 : isMax ? 380.0 : w.width;
            final hh = isFull ? 280.0 : isMax ? 240.0 : w.height;

            return Positioned(
              left: left,
              top: top,
              width: ww,
              height: hh,
              child: GestureDetector(
                onTap: () => onSelect(w.id),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF2D3748),
                    borderRadius:
                        isFull ? null : BorderRadius.circular(6),
                    border: Border.all(
                      color: w.hasFocus ? w.chrome : Colors.white24,
                      width: w.hasFocus ? 2 : 1,
                    ),
                    boxShadow: w.hasFocus
                        ? [
                            BoxShadow(
                                color: w.chrome.withOpacity(0.3),
                                blurRadius: 12,
                                offset: Offset(0, 4))
                          ]
                        : [],
                  ),
                  child: Column(
                    children: [
                      // title bar
                      Container(
                        height: 22,
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: w.hasFocus ? w.chrome : Color(0xFF4A5568),
                          borderRadius: isFull
                              ? null
                              : BorderRadius.vertical(
                                  top: Radius.circular(5)),
                        ),
                        child: Row(
                          children: [
                            // traffic lights
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  shape: BoxShape.circle),
                            ),
                            SizedBox(width: 3),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  shape: BoxShape.circle),
                            ),
                            SizedBox(width: 3),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                w.title,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(w.stateIcon,
                                size: 10, color: Colors.white54),
                          ],
                        ),
                      ),
                      // content area
                      Expanded(
                        child: Container(
                          color: Color(0xFF1A202C),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.desktop_windows,
                                  color: w.chrome.withOpacity(0.4), size: 24),
                              SizedBox(height: 4),
                              Text(w.id,
                                  style: TextStyle(
                                      color: Colors.white38, fontSize: 9)),
                              Text(
                                '${ww.toInt()}×${hh.toInt()}',
                                style: TextStyle(
                                    color: Colors.white24, fontSize: 8),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _DesktopGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.03)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 30) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 30) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── tool buttons ────────────────────────────────────────

class _ToolButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _ToolButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12, color: color),
            SizedBox(width: 4),
            Text(label,
                style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: color)),
          ],
        ),
      ),
    );
  }
}

// ── inspector panel ─────────────────────────────────────

class _InspectorPanel extends StatelessWidget {
  final _SimulatedWindow? selected;
  final void Function(double, double) onResize;
  final void Function(double, double) onMove;
  final void Function(String) onRename;
  final List<_SimulatedWindow> windows;
  final ValueChanged<String> onSelectWindow;

  const _InspectorPanel({
    required this.selected,
    required this.onResize,
    required this.onMove,
    required this.onRename,
    required this.windows,
    required this.onSelectWindow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kCardBg,
      child: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Text('Window Inspector',
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w700, color: _kPrimary)),
          SizedBox(height: 8),

          if (selected == null)
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _kSurface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Icon(Icons.touch_app, size: 24, color: _kMuted),
                  SizedBox(height: 6),
                  Text('Create or select a window',
                      style: TextStyle(fontSize: 10, color: _kMuted)),
                ],
              ),
            )
          else ...[
            // window ID badge
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: selected!.chrome.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: selected!.chrome.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: selected!.chrome,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(selected!.id,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: selected!.chrome)),
                    ],
                  ),
                  SizedBox(height: 6),
                  _PropRow('Title', selected!.title),
                  _PropRow('State', selected!.stateLabel),
                  _PropRow('Position', '(${selected!.x.toInt()}, ${selected!.y.toInt()})'),
                  _PropRow('Size', '${selected!.width.toInt()} × ${selected!.height.toInt()}'),
                  _PropRow('Focus', selected!.hasFocus ? 'Yes' : 'No'),
                ],
              ),
            ),

            SizedBox(height: 10),

            // geometry controls
            Text('Resize',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _kDarkText)),
            SizedBox(height: 4),
            Row(
              children: [
                _SmallBtn('W−', () => onResize(-20, 0)),
                SizedBox(width: 4),
                _SmallBtn('W+', () => onResize(20, 0)),
                SizedBox(width: 8),
                _SmallBtn('H−', () => onResize(0, -20)),
                SizedBox(width: 4),
                _SmallBtn('H+', () => onResize(0, 20)),
              ],
            ),

            SizedBox(height: 10),

            Text('Move',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _kDarkText)),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SmallBtn('↑', () => onMove(0, -15)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SmallBtn('←', () => onMove(-15, 0)),
                SizedBox(width: 8),
                _SmallBtn('→', () => onMove(15, 0)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SmallBtn('↓', () => onMove(0, 15)),
              ],
            ),

            SizedBox(height: 10),

            Text('Title',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _kDarkText)),
            SizedBox(height: 4),
            _TitleEditor(
              current: selected!.title,
              onSubmit: onRename,
            ),
          ],

          SizedBox(height: 14),

          // window list
          Text('All Windows',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _kDarkText)),
          SizedBox(height: 6),
          ...windows.map((w) => GestureDetector(
                onTap: () => onSelectWindow(w.id),
                child: Container(
                  margin: EdgeInsets.only(bottom: 4),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: w.id == selected?.id
                        ? w.chrome.withOpacity(0.1)
                        : Colors.grey.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: w.id == selected?.id
                          ? w.chrome.withOpacity(0.4)
                          : Colors.transparent,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: w.state == _WindowState.destroyed
                              ? Colors.red
                              : w.chrome,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          '${w.title} (${w.stateLabel})',
                          style: TextStyle(fontSize: 9, color: Colors.black87),
                          overflow: TextOverflow.ellipsis,
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
}

class _PropRow extends StatelessWidget {
  final String label;
  final String value;
  const _PropRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 3),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Text(label,
                style: TextStyle(fontSize: 9, color: Colors.black45, fontWeight: FontWeight.w600)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(
                    fontSize: 9, color: _kDarkText, fontFamily: 'monospace')),
          ),
        ],
      ),
    );
  }
}

class _SmallBtn extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _SmallBtn(this.label, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: _kPrimary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: _kPrimary.withOpacity(0.2)),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.w700, color: _kPrimary)),
      ),
    );
  }
}

class _TitleEditor extends StatefulWidget {
  final String current;
  final ValueChanged<String> onSubmit;
  const _TitleEditor({required this.current, required this.onSubmit});

  @override
  State<_TitleEditor> createState() => _TitleEditorState();
}

class _TitleEditorState extends State<_TitleEditor> {
  late TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.current);
  }

  @override
  void didUpdateWidget(_TitleEditor old) {
    super.didUpdateWidget(old);
    if (old.current != widget.current) {
      _ctrl.text = widget.current;
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _ctrl,
            style: TextStyle(fontSize: 10),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
            ),
          ),
        ),
        SizedBox(width: 4),
        GestureDetector(
          onTap: () => widget.onSubmit(_ctrl.text),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: _kAccent,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text('Set',
                style: TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.w700)),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  TAB 3 — ARCHITECTURE
// ═══════════════════════════════════════════════════════════

class _ArchitectureTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // ── multi-window architecture diagram ─────────
        _SectionCard(
          title: 'Multi-Window Architecture',
          icon: Icons.architecture,
          child: Column(
            children: [
              // application layer
              _ArchLayer(
                label: 'Application',
                color: _kAccent,
                items: ['Main Window', 'Settings Window', 'Editor Window', 'Preview Window'],
              ),
              _ArchConnector(),
              // controller layer
              _ArchLayer(
                label: 'RegularWindowController (per window)',
                color: _kPrimary,
                items: ['Lifecycle mgmt', 'Geometry', 'Focus', 'Title / chrome'],
              ),
              _ArchConnector(),
              // delegate layer
              _ArchLayer(
                label: 'RegularWindowControllerDelegate',
                color: _kDelegateColor,
                items: ['windowShouldClose()', 'windowDidResize()', 'windowDidMove()', 'windowDidBecomeKey()'],
              ),
              _ArchConnector(),
              // platform layer
              _ArchLayer(
                label: 'Platform Implementation',
                color: _kConcreteColor,
                items: ['macOS (Cocoa)', 'Linux (GTK)', 'Windows (Win32)'],
              ),
              _ArchConnector(),
              // native layer
              _ArchLayer(
                label: 'Native Window System',
                color: _kSystemColor,
                items: ['NSWindow', 'GtkWindow', 'HWND'],
              ),
            ],
          ),
        ),

        SizedBox(height: 14),

        // ── lifecycle flow ──────────────────────────
        _SectionCard(
          title: 'Window Lifecycle Flow',
          icon: Icons.timeline,
          child: Column(
            children: [
              _LifecycleStep(
                step: 1,
                title: 'Instantiation',
                code: 'final ctrl = RegularWindowControllerMacOS();',
                detail: 'Platform-specific controller is created. No native window '
                    'exists yet. The controller is in an uninitialized state.',
                color: Color(0xFF1565C0),
              ),
              _LifecycleArrow(),
              _LifecycleStep(
                step: 2,
                title: 'Delegate Assignment',
                code: 'ctrl.delegate = MyWindowDelegate();',
                detail: 'A delegate is attached to receive lifecycle callbacks. '
                    'The delegate pattern decouples window management from business logic.',
                color: Color(0xFF00838F),
              ),
              _LifecycleArrow(),
              _LifecycleStep(
                step: 3,
                title: 'Window Creation',
                code: 'ctrl.create(size: Size(800, 600), title: "Editor");',
                detail: 'The native window is allocated with the specified geometry. '
                    'A Flutter rendering surface is attached to the window.',
                color: Color(0xFF2E7D32),
              ),
              _LifecycleArrow(),
              _LifecycleStep(
                step: 4,
                title: 'Active Phase',
                code: 'ctrl.setSize(...) / ctrl.focus() / ctrl.minimize()',
                detail: 'The window is alive and interactive. The controller mediates '
                    'all operations between Flutter and the native frame.',
                color: Color(0xFFEF6C00),
              ),
              _LifecycleArrow(),
              _LifecycleStep(
                step: 5,
                title: 'Close Request',
                code: 'delegate.windowShouldClose() → true/false',
                detail: 'User clicks close button. The delegate can veto the close '
                    '(e.g. unsaved changes dialog). Returns true to allow, false to cancel.',
                color: Color(0xFFC62828),
              ),
              _LifecycleArrow(),
              _LifecycleStep(
                step: 6,
                title: 'Destruction',
                code: 'ctrl.destroy()',
                detail: 'The native window is released, rendering surface detached, '
                    'and all resources freed. The controller is now invalidated.',
                color: Color(0xFF37474F),
              ),
            ],
          ),
        ),

        SizedBox(height: 14),

        // ── event routing diagram ───────────────────
        _SectionCard(
          title: 'Event Routing',
          icon: Icons.call_split,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The controller acts as an event bridge between the native '
                'window system and the Flutter framework:',
                style: TextStyle(fontSize: 11, color: Colors.black54, height: 1.4),
              ),
              SizedBox(height: 12),
              _EventRoute(
                source: 'User resize',
                path: 'OS → Controller → Delegate → setState',
                effect: 'Widget tree relayouts to new size',
                color: Color(0xFF1565C0),
              ),
              _EventRoute(
                source: 'User move',
                path: 'OS → Controller → Delegate → onMove()',
                effect: 'Position updated, multi-monitor awareness',
                color: Color(0xFF00838F),
              ),
              _EventRoute(
                source: 'Focus change',
                path: 'OS → Controller → Delegate → onFocus()',
                effect: 'Title bar chrome updates, keyboard routing',
                color: Color(0xFF6A1B9A),
              ),
              _EventRoute(
                source: 'Close button',
                path: 'OS → Controller → Delegate → shouldClose()',
                effect: 'Confirmation dialog or immediate close',
                color: Color(0xFFC62828),
              ),
              _EventRoute(
                source: 'Programmatic resize',
                path: 'App → Controller → OS',
                effect: 'Native window geometry updated',
                color: Color(0xFF2E7D32),
              ),
              _EventRoute(
                source: 'Programmatic focus',
                path: 'App → Controller → OS → activate',
                effect: 'Window brought to front, becomes key',
                color: Color(0xFFEF6C00),
              ),
            ],
          ),
        ),

        SizedBox(height: 14),

        // ── window registry pattern ──────────────────
        _SectionCard(
          title: 'Window Registry Pattern',
          icon: Icons.inventory_2,
          child: _WindowRegistryVisual(),
        ),

        SizedBox(height: 14),

        // ── usage patterns ──────────────────────────
        _SectionCard(
          title: 'Common Usage Patterns',
          icon: Icons.pattern,
          child: Column(
            children: [
              _UsagePattern(
                title: 'Single-Window Desktop App',
                description: 'One controller for the main window. Created at startup, '
                    'destroyed on quit. The simplest pattern — most existing Flutter '
                    'desktop apps use this implicitly.',
                visual: _SingleWindowVisual(),
              ),
              SizedBox(height: 12),
              _UsagePattern(
                title: 'Multi-Window Document Editor',
                description: 'One controller per document window. A registry tracks '
                    'all open windows. Close request checks for unsaved changes. '
                    'App quits when last window closes.',
                visual: _MultiDocVisual(),
              ),
              SizedBox(height: 12),
              _UsagePattern(
                title: 'Inspector / Tool Windows',
                description: 'A main window with floating tool windows (inspector, '
                    'palette, layers). Tool windows share the main window\'s state '
                    'but have independent geometry and lifecycle.',
                visual: _InspectorWindowVisual(),
              ),
              SizedBox(height: 12),
              _UsagePattern(
                title: 'Detachable Panels',
                description: 'Panels that can be dragged out of the main window into '
                    'their own window. Requires dynamic controller creation and '
                    'widget tree re-parenting.',
                visual: _DetachableVisual(),
              ),
            ],
          ),
        ),

        SizedBox(height: 14),

        // ── platform adaptation ──────────────────────
        _SectionCard(
          title: 'Platform Adaptation Matrix',
          icon: Icons.grid_on,
          child: Column(
            children: [
              _PlatformRow(
                header: true,
                feature: 'Feature',
                macos: 'macOS',
                linux: 'Linux',
                windows: 'Windows',
              ),
              _PlatformRow(
                feature: 'Title bar',
                macos: 'NSWindow titlebar',
                linux: 'GTK header bar',
                windows: 'Win32 caption',
              ),
              _PlatformRow(
                feature: 'Close button',
                macos: 'Traffic light',
                linux: 'Header btn',
                windows: 'Title bar X',
              ),
              _PlatformRow(
                feature: 'Resize',
                macos: 'Edge + corner',
                linux: 'Edge drag',
                windows: 'Border drag',
              ),
              _PlatformRow(
                feature: 'Fullscreen',
                macos: 'Green button / API',
                linux: 'F11 / API',
                windows: 'F11 / API',
              ),
              _PlatformRow(
                feature: 'Minimize to',
                macos: 'Dock',
                linux: 'Taskbar',
                windows: 'Taskbar',
              ),
              _PlatformRow(
                feature: 'Window z-order',
                macos: 'NSWindowLevel',
                linux: 'GDK hints',
                windows: 'SetWindowPos',
              ),
              _PlatformRow(
                feature: 'Multi-monitor',
                macos: 'NSScreen',
                linux: 'GdkDisplay',
                windows: 'EnumDisplays',
              ),
            ],
          ),
        ),

        SizedBox(height: 14),

        // ── best practices ──────────────────────────
        _SectionCard(
          title: 'Best Practices',
          icon: Icons.verified,
          child: Column(
            children: [
              _PracticeItem(
                number: '1',
                title: 'Always set a delegate before showing',
                detail: 'Without a delegate, close requests cannot be intercepted. '
                    'This leads to data loss if the user has unsaved changes.',
                isGood: true,
              ),
              _PracticeItem(
                number: '2',
                title: 'Don\'t call destroy() directly',
                detail: 'Use close() instead, which triggers the delegate\'s '
                    'shouldClose callback. Direct destroy() bypasses confirmation.',
                isGood: false,
              ),
              _PracticeItem(
                number: '3',
                title: 'Track all controllers in a registry',
                detail: 'A central registry enables "Close All" and "Quit" operations '
                    'that iterate through all windows orderly.',
                isGood: true,
              ),
              _PracticeItem(
                number: '4',
                title: 'Always check window state before operations',
                detail: 'Calling setSize on a maximized window may be ignored or cause '
                    'unexpected behavior. Restore first, then resize.',
                isGood: true,
              ),
              _PracticeItem(
                number: '5',
                title: 'Test on all target platforms',
                detail: 'Platform subclasses may have subtle differences in event '
                    'ordering. What works on macOS may behave differently on Linux.',
                isGood: true,
              ),
            ],
          ),
        ),

        SizedBox(height: 24),
      ],
    );
  }
}

// ── architecture helpers ────────────────────────────────

class _ArchLayer extends StatelessWidget {
  final String label;
  final Color color;
  final List<String> items;
  const _ArchLayer({required this.label, required this.color, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w700, color: color)),
          SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 4,
            alignment: WrapAlignment.center,
            children: items
                .map((item) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(item,
                          style: TextStyle(fontSize: 9, color: color)),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _ArchConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Icon(Icons.arrow_downward, size: 16, color: _kMuted),
    );
  }
}

class _LifecycleStep extends StatelessWidget {
  final int step;
  final String title;
  final String code;
  final String detail;
  final Color color;
  const _LifecycleStep({
    required this.step,
    required this.title,
    required this.code,
    required this.detail,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('$step',
                style: TextStyle(
                    color: Colors.white, fontSize: 12, fontWeight: FontWeight.w800)),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w700, color: color)),
                SizedBox(height: 4),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: _kCodeBg,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(code,
                      style: TextStyle(
                          fontSize: 10,
                          color: _kDarkText,
                          fontFamily: 'monospace')),
                ),
                SizedBox(height: 4),
                Text(detail,
                    style: TextStyle(fontSize: 10, color: Colors.black54, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LifecycleArrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Icon(Icons.south, size: 14, color: _kMuted),
    );
  }
}

class _EventRoute extends StatelessWidget {
  final String source;
  final String path;
  final String effect;
  final Color color;
  const _EventRoute({
    required this.source,
    required this.path,
    required this.effect,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(source,
                      style: TextStyle(
                          fontSize: 9, fontWeight: FontWeight.w700, color: color)),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(path,
                      style: TextStyle(
                          fontSize: 9,
                          color: Colors.black54,
                          fontFamily: 'monospace')),
                ),
              ],
            ),
            SizedBox(height: 3),
            Text('Effect: $effect',
                style: TextStyle(fontSize: 9, color: Colors.black45)),
          ],
        ),
      ),
    );
  }
}

// ── window registry visual ──────────────────────────────

class _WindowRegistryVisual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final entries = [
      _RegistryEntry('main-window', 'Main Editor', true, Color(0xFF1565C0)),
      _RegistryEntry('settings', 'Settings', true, Color(0xFF00838F)),
      _RegistryEntry('about', 'About', false, Color(0xFF6A1B9A)),
      _RegistryEntry('prefs-2', 'Preferences', true, Color(0xFF2E7D32)),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'A registry tracks all created controllers so the application can '
          'enumerate, focus, or close windows programmatically:',
          style: TextStyle(fontSize: 11, color: Colors.black54, height: 1.4),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.inventory, size: 12, color: _kAccent),
                  SizedBox(width: 6),
                  Text('WindowRegistry',
                      style: TextStyle(
                          color: _kAccent,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'monospace')),
                  Spacer(),
                  Text('${entries.length} windows',
                      style: TextStyle(color: Colors.white38, fontSize: 9)),
                ],
              ),
              SizedBox(height: 8),
              ...entries.map((e) => Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: e.color.withOpacity(0.4)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: e.isActive ? Colors.greenAccent : Colors.white24,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(e.id,
                                    style: TextStyle(
                                        color: e.color,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'monospace')),
                                Text(e.title,
                                    style: TextStyle(
                                        color: Colors.white54, fontSize: 9)),
                              ],
                            ),
                          ),
                          Text(
                            e.isActive ? 'active' : 'hidden',
                            style: TextStyle(
                              color: e.isActive ? Colors.greenAccent : Colors.white24,
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              SizedBox(height: 6),
              Text(
                '// registry.closeAll() → iterates and calls close() on each',
                style: TextStyle(
                    color: Colors.white30, fontSize: 9, fontFamily: 'monospace'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RegistryEntry {
  final String id;
  final String title;
  final bool isActive;
  final Color color;
  const _RegistryEntry(this.id, this.title, this.isActive, this.color);
}

// ── usage pattern widgets ───────────────────────────────

class _UsagePattern extends StatelessWidget {
  final String title;
  final String description;
  final Widget visual;
  const _UsagePattern({
    required this.title,
    required this.description,
    required this.visual,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kMuted.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w700, color: _kDarkText)),
          SizedBox(height: 6),
          Text(description,
              style: TextStyle(fontSize: 10, color: Colors.black54, height: 1.4)),
          SizedBox(height: 10),
          visual,
        ],
      ),
    );
  }
}

class _SingleWindowVisual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Color(0xFF1B2838),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Container(
          width: 160,
          height: 55,
          decoration: BoxDecoration(
            color: Color(0xFF2D3748),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: _kWindowBorder, width: 2),
          ),
          child: Column(
            children: [
              Container(
                height: 14,
                decoration: BoxDecoration(
                  color: _kWindowBorder,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(3)),
                ),
                alignment: Alignment.center,
                child: Text('Main Window',
                    style: TextStyle(color: Colors.white, fontSize: 8)),
              ),
              Expanded(
                child: Center(
                  child: Text('Flutter App',
                      style: TextStyle(color: Colors.white38, fontSize: 9)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MultiDocVisual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Color(0xFF1B2838),
        borderRadius: BorderRadius.circular(6),
      ),
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _MiniWindow('doc1.txt', Color(0xFF1565C0), 60),
          _MiniWindow('doc2.md', Color(0xFF00838F), 55),
          _MiniWindow('img.png', Color(0xFF6A1B9A), 50),
        ],
      ),
    );
  }
}

class _InspectorWindowVisual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Color(0xFF1B2838),
        borderRadius: BorderRadius.circular(6),
      ),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          // main window (larger)
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF2D3748),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: _kWindowBorder, width: 2),
              ),
              child: Column(
                children: [
                  Container(
                    height: 12,
                    decoration: BoxDecoration(
                      color: _kWindowBorder,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(3)),
                    ),
                    alignment: Alignment.center,
                    child: Text('Editor', style: TextStyle(color: Colors.white, fontSize: 7)),
                  ),
                  Expanded(
                    child: Center(
                      child: Text('Canvas',
                          style: TextStyle(color: Colors.white30, fontSize: 8)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 6),
          // tool windows (smaller)
          Column(
            children: [
              Expanded(
                child: Container(
                  width: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFF2D3748),
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: Color(0xFF6A1B9A)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 10,
                        decoration: BoxDecoration(
                            color: Color(0xFF6A1B9A),
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(2))),
                        alignment: Alignment.center,
                        child: Text('Props',
                            style: TextStyle(color: Colors.white, fontSize: 6)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 4),
              Expanded(
                child: Container(
                  width: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFF2D3748),
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: Color(0xFF00838F)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 10,
                        decoration: BoxDecoration(
                            color: Color(0xFF00838F),
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(2))),
                        alignment: Alignment.center,
                        child: Text('Layers',
                            style: TextStyle(color: Colors.white, fontSize: 6)),
                      ),
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
}

class _DetachableVisual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Color(0xFF1B2838),
        borderRadius: BorderRadius.circular(6),
      ),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          // main window with gap where panel was
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF2D3748),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: _kWindowBorder, width: 2),
              ),
              child: Column(
                children: [
                  Container(
                    height: 12,
                    decoration: BoxDecoration(
                      color: _kWindowBorder,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(3)),
                    ),
                    alignment: Alignment.center,
                    child: Text('IDE', style: TextStyle(color: Colors.white, fontSize: 7)),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text('Code',
                                style: TextStyle(color: Colors.white30, fontSize: 8)),
                          ),
                        ),
                        Container(
                          width: 30,
                          decoration: BoxDecoration(
                            border: Border(left: BorderSide(color: Colors.white12)),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.open_in_new, size: 10, color: Colors.white24),
                                Text('detached',
                                    style: TextStyle(color: Colors.white24, fontSize: 6)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 8),
          // arrow
          Icon(Icons.arrow_forward, size: 12, color: _kAccent),
          SizedBox(width: 8),
          // detached panel as its own window
          Container(
            width: 60,
            decoration: BoxDecoration(
              color: Color(0xFF2D3748),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: _kAccent, width: 2),
            ),
            child: Column(
              children: [
                Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: _kAccent,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(3)),
                  ),
                  alignment: Alignment.center,
                  child: Text('Terminal',
                      style: TextStyle(color: Colors.white, fontSize: 7)),
                ),
                Expanded(
                  child: Center(
                    child: Text('\$',
                        style: TextStyle(color: Colors.white38, fontSize: 12)),
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

class _MiniWindow extends StatelessWidget {
  final String title;
  final Color color;
  final double height;
  const _MiniWindow(this.title, this.color, this.height);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: height,
      decoration: BoxDecoration(
        color: Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color),
      ),
      child: Column(
        children: [
          Container(
            height: 12,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.vertical(top: Radius.circular(3)),
            ),
            alignment: Alignment.center,
            child: Text(title,
                style: TextStyle(color: Colors.white, fontSize: 7)),
          ),
          Expanded(
            child: Center(
              child: Icon(Icons.description, size: 12, color: color.withOpacity(0.4)),
            ),
          ),
        ],
      ),
    );
  }
}

// ── platform adaptation matrix ──────────────────────────

class _PlatformRow extends StatelessWidget {
  final bool header;
  final String feature;
  final String macos;
  final String linux;
  final String windows;
  const _PlatformRow({
    this.header = false,
    required this.feature,
    required this.macos,
    required this.linux,
    required this.windows,
  });

  @override
  Widget build(BuildContext context) {
    final bg = header ? _kPrimary.withOpacity(0.08) : Colors.transparent;
    final textStyle = header
        ? TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: _kPrimary)
        : TextStyle(fontSize: 9, color: Colors.black87);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          SizedBox(width: 70, child: Text(feature, style: textStyle.copyWith(fontWeight: FontWeight.w600))),
          Expanded(child: Text(macos, style: textStyle)),
          Expanded(child: Text(linux, style: textStyle)),
          Expanded(child: Text(windows, style: textStyle)),
        ],
      ),
    );
  }
}

// ── best practices ──────────────────────────────────────

class _PracticeItem extends StatelessWidget {
  final String number;
  final String title;
  final String detail;
  final bool isGood;
  const _PracticeItem({
    required this.number,
    required this.title,
    required this.detail,
    required this.isGood,
  });

  @override
  Widget build(BuildContext context) {
    final color = isGood ? _kConcreteColor : _kDelegateColor;
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isGood ? Icons.check : Icons.warning_amber,
                size: 12,
                color: color,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontSize: 11, fontWeight: FontWeight.w700, color: color)),
                  SizedBox(height: 3),
                  Text(detail,
                      style: TextStyle(fontSize: 10, color: Colors.black54, height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

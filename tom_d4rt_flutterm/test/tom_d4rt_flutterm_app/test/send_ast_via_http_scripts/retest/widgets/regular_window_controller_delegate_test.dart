// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────
//  RegularWindowControllerDelegate  –  Deep Visual Demo
//
//  Palette : Slate 700 (BlueGrey) / Teal 300
//  Tabs    : Theory · Lifecycle · Patterns
// ─────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  print('RegularWindowControllerDelegate demo building');
  return _DelegateDemo();
}

// ── colour constants ────────────────────────────────────
const _kPrimary = Color(0xFF455A64); // BlueGrey 700
const _kAccent = Color(0xFF4DB6AC); // Teal 300
const _kSurface = Color(0xFFECEFF1); // BlueGrey 50
const _kCardBg = Color(0xFFFFFFFF);
const _kDarkText = Color(0xFF263238); // BlueGrey 900
const _kMuted = Color(0xFFB0BEC5); // BlueGrey 200
const _kCodeBg = Color(0xFFE0F2F1); // Teal 50
const _kHighlight = Color(0xFFFFF8E1); // Amber 50
const _kLifecycleCreate = Color(0xFF2E7D32);
const _kLifecycleActive = Color(0xFF1565C0);
const _kLifecycleClose = Color(0xFFE65100);
const _kLifecycleDestroy = Color(0xFFC62828);
const _kErrorColor = Color(0xFFD32F2F);

class _DelegateDemo extends StatefulWidget {
  @override
  State<_DelegateDemo> createState() => _DelegateDemoState();
}

class _DelegateDemoState extends State<_DelegateDemo>
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
        title: Text('RegularWindowControllerDelegate',
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
            Tab(text: 'Lifecycle'),
            Tab(text: 'Patterns'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: [
          _TheoryTab(),
          _LifecycleTab(),
          _PatternsTab(),
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
          _buildMixinStructureCard(),
          SizedBox(height: 14),
          _buildMethodsCard(),
          SizedBox(height: 14),
          _buildExperimentalApiCard(),
          SizedBox(height: 14),
          _buildRelationshipCard(),
          SizedBox(height: 14),
          _buildPlatformImplCard(),
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
                  color: _kPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.window, color: _kPrimary, size: 28),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('RegularWindowControllerDelegate',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: _kDarkText)),
                    SizedBox(height: 3),
                    Text('Mixin for window lifecycle callbacks',
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
              'RegularWindowControllerDelegate is a mixin class that provides '
              'lifecycle callback methods for multi-window Flutter applications. '
              'A delegate receives notifications when a window is about to close, '
              'has been destroyed, or undergoes other state changes. This is part '
              'of Flutter\'s experimental multi-window API.',
              style: TextStyle(
                  fontSize: 12.5, color: _kDarkText, height: 1.5),
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              _tagBadge('Experimental', _kErrorColor),
              SizedBox(width: 6),
              _tagBadge('Multi-Window', _kLifecycleActive),
              SizedBox(width: 6),
              _tagBadge('Mixin Class', _kPrimary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMixinStructureCard() {
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
          Text('Mixin Declaration',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kPrimary)),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCodeBg,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'mixin class RegularWindowControllerDelegate {\n'
              '  void onWindowCloseRequested(\n'
              '    RegularWindowController controller,\n'
              '  ) {\n'
              '    controller.destroy();\n'
              '  }\n'
              '\n'
              '  void onWindowDestroyed() {}\n'
              '}',
              style: TextStyle(
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  color: _kDarkText,
                  height: 1.5),
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.info_outline, size: 16, color: _kPrimary),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'As a mixin class, it can be used with both "with" and '
                  '"extends". The default onWindowCloseRequested simply '
                  'calls destroy() — override to add custom behavior.',
                  style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.grey[700],
                      height: 1.4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMethodsCard() {
    final methods = <Map<String, dynamic>>[
      {
        'name': 'onWindowCloseRequested',
        'sig': 'void onWindowCloseRequested(\n  RegularWindowController controller\n)',
        'desc': 'Called when the user requests to close the window (e.g., '
            'clicking the close button, pressing Alt+F4). The controller '
            'parameter lets you decide: call controller.destroy() to '
            'proceed, or present a save dialog first.',
        'icon': Icons.close,
        'color': _kLifecycleClose,
      },
      {
        'name': 'onWindowDestroyed',
        'sig': 'void onWindowDestroyed()',
        'desc': 'Called after the window has been fully destroyed. Use this '
            'for cleanup: release resources, remove from window list, '
            'persist state. The controller is no longer usable at this point.',
        'icon': Icons.delete_forever,
        'color': _kLifecycleDestroy,
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
          Text('Delegate Methods',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kPrimary)),
          SizedBox(height: 12),
          ...methods.map((m) => Container(
                margin: EdgeInsets.only(bottom: 12),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (m['color'] as Color).withOpacity(0.05),
                  border: Border.all(
                      color: (m['color'] as Color).withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(m['icon'] as IconData,
                            size: 18, color: m['color'] as Color),
                        SizedBox(width: 8),
                        Text(m['name'] as String,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'monospace',
                                color: m['color'] as Color)),
                      ],
                    ),
                    SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _kCodeBg,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(m['sig'] as String,
                          style: TextStyle(
                              fontSize: 10.5,
                              fontFamily: 'monospace',
                              color: _kDarkText)),
                    ),
                    SizedBox(height: 8),
                    Text(m['desc'] as String,
                        style: TextStyle(
                            fontSize: 11.5,
                            color: Colors.grey[700],
                            height: 1.4)),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildExperimentalApiCard() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFF3E0),
        border: Border.all(color: Color(0xFFFFB74D)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.science, size: 20, color: _kLifecycleClose),
              SizedBox(width: 8),
              Text('Experimental Windowing API',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _kLifecycleClose)),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'This delegate is part of Flutter\'s experimental multi-window '
            'API. Key points about the current state:',
            style: TextStyle(fontSize: 12, color: _kDarkText, height: 1.4),
          ),
          SizedBox(height: 10),
          _bulletPoint('Available behind experimental flag in Flutter engine'),
          _bulletPoint('API may change in future Flutter releases'),
          _bulletPoint('Platform support varies (macOS, Linux, Windows)'),
          _bulletPoint('Not yet stable for production use'),
          _bulletPoint('Each window gets its own widget tree and event loop'),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kCardBg,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Icon(Icons.link, size: 14, color: Colors.grey[600]),
                SizedBox(width: 6),
                Text('flutter.dev/go/multi-window',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: _kLifecycleActive)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 5,
            height: 5,
            margin: EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              color: _kLifecycleClose,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(text,
                style: TextStyle(
                    fontSize: 11.5, color: _kDarkText, height: 1.3)),
          ),
        ],
      ),
    );
  }

  Widget _buildRelationshipCard() {
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
          Text('Relationship Map',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kPrimary)),
          SizedBox(height: 12),
          _relationRow('RegularWindowController', 'Manages the window',
              Icons.window, _kLifecycleActive),
          _arrowDown(),
          _relationRow(
              'RegularWindowControllerDelegate',
              'Receives lifecycle events',
              Icons.notifications_active,
              _kAccent),
          _arrowDown(),
          _relationRow('Your App Code', 'Handles close/destroy',
              Icons.code, _kLifecycleCreate),
          SizedBox(height: 14),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'The controller owns the window reference and provides methods '
              'like destroy(), activate(), minimize(). The delegate is a '
              'callback interface that lets your code react to window events.',
              style: TextStyle(
                  fontSize: 11.5, color: Colors.grey[700], height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _relationRow(
      String name, String role, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, size: 18, color: color),
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
                      fontFamily: 'monospace',
                      color: color)),
              Text(role,
                  style: TextStyle(
                      fontSize: 11, color: Colors.grey[600])),
            ],
          ),
        ),
      ],
    );
  }

  Widget _arrowDown() {
    return Padding(
      padding: EdgeInsets.only(left: 14, top: 2, bottom: 2),
      child: Icon(Icons.arrow_downward, size: 16, color: Colors.grey[400]),
    );
  }

  Widget _buildPlatformImplCard() {
    final platforms = <Map<String, dynamic>>[
      {
        'name': 'macOS',
        'impl': 'RegularWindowControllerMacOS',
        'icon': Icons.laptop_mac,
        'detail': 'Uses NSWindow delegate for close events',
      },
      {
        'name': 'Linux',
        'impl': 'RegularWindowControllerLinux',
        'icon': Icons.desktop_windows,
        'detail': 'Uses GTK window signals (delete-event)',
      },
      {
        'name': 'Windows',
        'impl': 'RegularWindowControllerWin32',
        'icon': Icons.desktop_windows,
        'detail': 'Uses Win32 WM_CLOSE message handling',
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
          Text('Platform Implementations',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kPrimary)),
          SizedBox(height: 4),
          Text('Each platform routes native close events to the delegate',
              style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          SizedBox(height: 12),
          ...platforms.map((p) => Container(
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _kSurface,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Icon(p['icon'] as IconData,
                        size: 20, color: _kPrimary),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p['name'] as String,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _kDarkText)),
                          Text(p['impl'] as String,
                              style: TextStyle(
                                  fontSize: 10.5,
                                  fontFamily: 'monospace',
                                  color: _kAccent)),
                          SizedBox(height: 2),
                          Text(p['detail'] as String,
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
}

Widget _tagBadge(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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
//  TAB 2  –  Lifecycle
// ═══════════════════════════════════════════════════════════

class _LifecycleTab extends StatefulWidget {
  @override
  State<_LifecycleTab> createState() => _LifecycleTabState();
}

class _LifecycleTabState extends State<_LifecycleTab> {
  _WindowPhase _currentPhase = _WindowPhase.idle;
  final List<_LifecycleEvent> _events = [];
  bool _hasUnsavedChanges = false;
  bool _showConfirmDialog = false;

  void _resetSimulation() {
    setState(() {
      _currentPhase = _WindowPhase.idle;
      _events.clear();
      _hasUnsavedChanges = false;
      _showConfirmDialog = false;
    });
    print('Lifecycle simulation reset');
  }

  void _simulateCreate() {
    setState(() {
      _currentPhase = _WindowPhase.created;
      _events.add(_LifecycleEvent('Window Created',
          'RegularWindowController factory invoked', _kLifecycleCreate));
    });
    print('Window created');
  }

  void _simulateActivate() {
    setState(() {
      _currentPhase = _WindowPhase.active;
      _events.add(_LifecycleEvent('Window Activated',
          'User brought window to focus', _kLifecycleActive));
    });
    print('Window activated');
  }

  void _simulateCloseRequest() {
    if (_hasUnsavedChanges) {
      setState(() {
        _showConfirmDialog = true;
        _events.add(_LifecycleEvent('Close Requested',
            'onWindowCloseRequested → showing save prompt',
            _kLifecycleClose));
      });
      print('Close requested — unsaved changes detected');
    } else {
      setState(() {
        _currentPhase = _WindowPhase.closing;
        _events.add(_LifecycleEvent('Close Requested',
            'onWindowCloseRequested → calling destroy()',
            _kLifecycleClose));
      });
      print('Close requested — proceeding to destroy');
      Future.delayed(Duration(milliseconds: 600), () {
        if (mounted) _simulateDestroy();
      });
    }
  }

  void _simulateDestroy() {
    setState(() {
      _currentPhase = _WindowPhase.destroyed;
      _showConfirmDialog = false;
      _events.add(_LifecycleEvent('Window Destroyed',
          'onWindowDestroyed → cleanup complete', _kLifecycleDestroy));
    });
    print('Window destroyed');
  }

  void _confirmClose() {
    setState(() {
      _showConfirmDialog = false;
      _hasUnsavedChanges = false;
      _currentPhase = _WindowPhase.closing;
      _events.add(_LifecycleEvent('User Confirmed',
          'Changes discarded, calling destroy()', _kLifecycleClose));
    });
    Future.delayed(Duration(milliseconds: 600), () {
      if (mounted) _simulateDestroy();
    });
  }

  void _cancelClose() {
    setState(() {
      _showConfirmDialog = false;
      _events.add(_LifecycleEvent('User Cancelled',
          'Close aborted — window stays open', _kLifecycleActive));
    });
    print('Close cancelled by user');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPhaseVisualizerCard(),
          SizedBox(height: 14),
          _buildControlPanel(),
          SizedBox(height: 14),
          if (_showConfirmDialog) _buildConfirmDialogCard(),
          if (_showConfirmDialog) SizedBox(height: 14),
          _buildEventLogCard(),
          SizedBox(height: 14),
          _buildLifecycleDiagramCard(),
          SizedBox(height: 14),
          _buildStateTransitionsCard(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPhaseVisualizerCard() {
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
          Text('Window Phase Visualizer',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _kDarkText)),
          SizedBox(height: 12),
          Row(
            children: _WindowPhase.values.map((phase) {
              final isActive = _currentPhase == phase;
              final isPast = _currentPhase.index > phase.index;
              Color dotColor;
              switch (phase) {
                case _WindowPhase.idle:
                  dotColor = Colors.grey;
                  break;
                case _WindowPhase.created:
                  dotColor = _kLifecycleCreate;
                  break;
                case _WindowPhase.active:
                  dotColor = _kLifecycleActive;
                  break;
                case _WindowPhase.closing:
                  dotColor = _kLifecycleClose;
                  break;
                case _WindowPhase.destroyed:
                  dotColor = _kLifecycleDestroy;
                  break;
              }
              return Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: isActive
                            ? dotColor
                            : isPast
                                ? dotColor.withOpacity(0.3)
                                : Colors.grey[200],
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isActive
                              ? dotColor
                              : Colors.grey[300]!,
                          width: isActive ? 2 : 1,
                        ),
                      ),
                      child: isActive
                          ? Icon(Icons.radio_button_checked,
                              size: 14, color: Colors.white)
                          : isPast
                              ? Icon(Icons.check,
                                  size: 14, color: Colors.white)
                              : null,
                    ),
                    SizedBox(height: 4),
                    Text(
                      phase.name,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight:
                            isActive ? FontWeight.w700 : FontWeight.normal,
                        color: isActive ? dotColor : Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              gradient: LinearGradient(
                colors: [
                  _kLifecycleCreate,
                  _kLifecycleActive,
                  _kLifecycleClose,
                  _kLifecycleDestroy,
                ],
                stops: [0.0, 0.33, 0.66, 1.0],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlPanel() {
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
          Text('Simulation Controls',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _kDarkText)),
          SizedBox(height: 12),
          Row(
            children: [
              _simButton('Create', Icons.add_circle, _kLifecycleCreate,
                  _currentPhase == _WindowPhase.idle ? _simulateCreate : null),
              SizedBox(width: 6),
              _simButton(
                  'Activate',
                  Icons.flash_on,
                  _kLifecycleActive,
                  _currentPhase == _WindowPhase.created
                      ? _simulateActivate
                      : null),
              SizedBox(width: 6),
              _simButton(
                  'Close',
                  Icons.close,
                  _kLifecycleClose,
                  _currentPhase == _WindowPhase.active
                      ? _simulateCloseRequest
                      : null),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _hasUnsavedChanges = !_hasUnsavedChanges;
                    });
                    print('Unsaved changes: $_hasUnsavedChanges');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: _hasUnsavedChanges
                          ? _kLifecycleClose.withOpacity(0.1)
                          : Colors.grey[100],
                      border: Border.all(
                        color: _hasUnsavedChanges
                            ? _kLifecycleClose.withOpacity(0.4)
                            : Colors.grey[300]!,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _hasUnsavedChanges
                              ? Icons.warning
                              : Icons.check_circle,
                          size: 14,
                          color: _hasUnsavedChanges
                              ? _kLifecycleClose
                              : _kLifecycleCreate,
                        ),
                        SizedBox(width: 6),
                        Text(
                          _hasUnsavedChanges
                              ? 'Unsaved Changes'
                              : 'No Changes',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: _hasUnsavedChanges
                                ? _kLifecycleClose
                                : _kLifecycleCreate,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              GestureDetector(
                onTap: _resetSimulation,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.refresh, size: 14, color: Colors.grey[600]),
                      SizedBox(width: 4),
                      Text('Reset',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600])),
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

  Widget _simButton(
      String label, IconData icon, Color color, VoidCallback? onTap) {
    final enabled = onTap != null;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: enabled ? color.withOpacity(0.1) : Colors.grey[100],
            border: Border.all(
              color:
                  enabled ? color.withOpacity(0.4) : Colors.grey[300]!,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children: [
              Icon(icon,
                  size: 18,
                  color: enabled ? color : Colors.grey[400]),
              SizedBox(height: 2),
              Text(label,
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: enabled ? color : Colors.grey[400])),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmDialogCard() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFF3E0),
        border: Border.all(color: _kLifecycleClose),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber, size: 22, color: _kLifecycleClose),
              SizedBox(width: 8),
              Text('Save Changes?',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _kLifecycleClose)),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'The delegate detected unsaved changes in '
            'onWindowCloseRequested. Instead of calling '
            'controller.destroy(), it shows this prompt.',
            style: TextStyle(fontSize: 12, color: _kDarkText, height: 1.4),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: _cancelClose,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: _kCardBg,
                    border: Border.all(color: Colors.grey[400]!),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('Cancel',
                      style: TextStyle(
                          fontSize: 12, color: Colors.grey[700])),
                ),
              ),
              SizedBox(width: 8),
              GestureDetector(
                onTap: _confirmClose,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: _kLifecycleDestroy,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('Discard & Close',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEventLogCard() {
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
              Icon(Icons.receipt_long, size: 18, color: _kPrimary),
              SizedBox(width: 8),
              Text('Lifecycle Event Log',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: _kDarkText)),
            ],
          ),
          SizedBox(height: 10),
          if (_events.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Center(
                child: Text(
                  'Press "Create" to start the lifecycle simulation',
                  style: TextStyle(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[500]),
                ),
              ),
            )
          else
            ..._events.reversed.map((e) => Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        margin: EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                          color: e.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(e.title,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: e.color)),
                            Text(e.detail,
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

  Widget _buildLifecycleDiagramCard() {
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
          Text('Complete Lifecycle Flow',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _kPrimary)),
          SizedBox(height: 12),
          _flowItem(1, 'Application creates RegularWindowController',
              _kLifecycleCreate, 'factory constructor'),
          _flowConnector(),
          _flowItem(2, 'Window opens, delegate attached',
              _kLifecycleCreate, 'delegate param in constructor'),
          _flowConnector(),
          _flowItem(3, 'User interacts with window',
              _kLifecycleActive, 'normal operation'),
          _flowConnector(),
          _flowItem(4, 'User clicks close / Alt+F4',
              _kLifecycleClose, 'native event'),
          _flowConnector(),
          _flowItem(5, 'onWindowCloseRequested(controller) called',
              _kLifecycleClose, 'delegate method'),
          _flowConnector(),
          Row(
            children: [
              SizedBox(width: 30),
              Expanded(
                child: Row(
                  children: [
                    _branchBox('Save?', _kLifecycleClose),
                    SizedBox(width: 6),
                    Icon(Icons.arrow_forward, size: 12,
                        color: Colors.grey[400]),
                    SizedBox(width: 6),
                    _branchBox('Yes → abort', Colors.green),
                    SizedBox(width: 6),
                    _branchBox('No → destroy', _kLifecycleDestroy),
                  ],
                ),
              ),
            ],
          ),
          _flowConnector(),
          _flowItem(6, 'controller.destroy() called',
              _kLifecycleDestroy, 'if proceeding'),
          _flowConnector(),
          _flowItem(7, 'onWindowDestroyed() called',
              _kLifecycleDestroy, 'cleanup callback'),
        ],
      ),
    );
  }

  Widget _flowItem(
      int num, String desc, Color color, String note) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text('$num',
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
              Text(desc,
                  style: TextStyle(fontSize: 11.5, color: _kDarkText)),
              Text(note,
                  style: TextStyle(
                      fontSize: 10,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[500])),
            ],
          ),
        ),
      ],
    );
  }

  Widget _flowConnector() {
    return Padding(
      padding: EdgeInsets.only(left: 11, top: 1, bottom: 1),
      child: Container(
        width: 2,
        height: 10,
        color: Colors.grey[300],
      ),
    );
  }

  Widget _branchBox(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
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

  Widget _buildStateTransitionsCard() {
    final transitions = <Map<String, dynamic>>[
      {
        'from': 'idle',
        'to': 'created',
        'trigger': 'Factory constructor',
        'color': _kLifecycleCreate,
      },
      {
        'from': 'created',
        'to': 'active',
        'trigger': 'Window gains focus',
        'color': _kLifecycleActive,
      },
      {
        'from': 'active',
        'to': 'closing',
        'trigger': 'Close button / shortcut',
        'color': _kLifecycleClose,
      },
      {
        'from': 'closing',
        'to': 'active',
        'trigger': 'Delegate aborts close',
        'color': _kLifecycleActive,
      },
      {
        'from': 'closing',
        'to': 'destroyed',
        'trigger': 'controller.destroy()',
        'color': _kLifecycleDestroy,
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
          Text('State Transitions',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _kPrimary)),
          SizedBox(height: 12),
          ...transitions.map((t) => Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        t['from'] as String,
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'monospace',
                            color: Colors.grey[700]),
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.arrow_forward,
                        size: 14,
                        color: t['color'] as Color),
                    SizedBox(width: 6),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: (t['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        t['to'] as String,
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w600,
                            color: t['color'] as Color),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(t['trigger'] as String,
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
}

// ═══════════════════════════════════════════════════════════
//  TAB 3  –  Patterns
// ═══════════════════════════════════════════════════════════

class _PatternsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSaveBeforeClosePattern(),
          SizedBox(height: 14),
          _buildResourceCleanupPattern(),
          SizedBox(height: 14),
          _buildMultiWindowPattern(),
          SizedBox(height: 14),
          _buildConfirmationPattern(),
          SizedBox(height: 14),
          _buildCompositePattern(),
          SizedBox(height: 14),
          _buildBestPracticesCard(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSaveBeforeClosePattern() {
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
              Icon(Icons.save, size: 20, color: _kLifecycleCreate),
              SizedBox(width: 8),
              Text('Pattern: Save Before Close',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _kPrimary)),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'The most common delegate pattern: check for unsaved '
            'changes before allowing the window to close.',
            style: TextStyle(
                fontSize: 12, color: Colors.grey[700], height: 1.4),
          ),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCodeBg,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'class DocumentDelegate\n'
              '    with RegularWindowControllerDelegate {\n'
              '  final DocumentStore store;\n'
              '\n'
              '  DocumentDelegate(this.store);\n'
              '\n'
              '  @override\n'
              '  void onWindowCloseRequested(\n'
              '    RegularWindowController controller,\n'
              '  ) {\n'
              '    if (store.hasUnsavedChanges) {\n'
              '      _showSaveDialog(controller);\n'
              '    } else {\n'
              '      controller.destroy();\n'
              '    }\n'
              '  }\n'
              '\n'
              '  void _showSaveDialog(\n'
              '    RegularWindowController controller,\n'
              '  ) {\n'
              '    // Show dialog, then\n'
              '    // controller.destroy() if confirmed\n'
              '  }\n'
              '\n'
              '  @override\n'
              '  void onWindowDestroyed() {\n'
              '    store.dispose();\n'
              '  }\n'
              '}',
              style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: _kDarkText,
                  height: 1.45),
            ),
          ),
          SizedBox(height: 10),
          _patternNote(
            'Key insight: onWindowCloseRequested receives the controller, '
            'so the delegate can decide asynchronously whether to destroy.',
          ),
        ],
      ),
    );
  }

  Widget _buildResourceCleanupPattern() {
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
              Icon(Icons.cleaning_services,
                  size: 20, color: _kLifecycleDestroy),
              SizedBox(width: 8),
              Text('Pattern: Resource Cleanup',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _kPrimary)),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Use onWindowDestroyed to release resources that were '
            'allocated for the window.',
            style: TextStyle(
                fontSize: 12, color: Colors.grey[700], height: 1.4),
          ),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCodeBg,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'class MediaDelegate\n'
              '    with RegularWindowControllerDelegate {\n'
              '  StreamSubscription? _subscription;\n'
              '  Timer? _autoSaveTimer;\n'
              '\n'
              '  @override\n'
              '  void onWindowDestroyed() {\n'
              '    _subscription?.cancel();\n'
              '    _autoSaveTimer?.cancel();\n'
              '    CacheManager.releaseAll();\n'
              '    print("Resources released");\n'
              '  }\n'
              '}',
              style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: _kDarkText,
                  height: 1.45),
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              _cleanupItem('Streams', Icons.stream, _kLifecycleActive),
              SizedBox(width: 8),
              _cleanupItem('Timers', Icons.timer, _kLifecycleClose),
              SizedBox(width: 8),
              _cleanupItem('Cache', Icons.memory, _kLifecycleDestroy),
              SizedBox(width: 8),
              _cleanupItem('Listeners', Icons.hearing, _kPrimary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cleanupItem(String label, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            Icon(icon, size: 18, color: color),
            SizedBox(height: 2),
            Text(label,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildMultiWindowPattern() {
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
              Icon(Icons.grid_view, size: 20, color: _kLifecycleActive),
              SizedBox(width: 8),
              Text('Pattern: Multi-Window Coordination',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _kPrimary)),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'When managing multiple windows, the delegate can coordinate '
            'between them — e.g., closing all child windows when the main '
            'window closes.',
            style: TextStyle(
                fontSize: 12, color: Colors.grey[700], height: 1.4),
          ),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCodeBg,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'class AppDelegate\n'
              '    with RegularWindowControllerDelegate {\n'
              '  final List<RegularWindowController>\n'
              '      childWindows = [];\n'
              '\n'
              '  @override\n'
              '  void onWindowCloseRequested(\n'
              '    RegularWindowController controller,\n'
              '  ) {\n'
              '    // Close all child windows first\n'
              '    for (final child in childWindows) {\n'
              '      child.destroy();\n'
              '    }\n'
              '    childWindows.clear();\n'
              '    controller.destroy();\n'
              '  }\n'
              '}',
              style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: _kDarkText,
                  height: 1.45),
            ),
          ),
          SizedBox(height: 12),
          // Visual representation of multi-window
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _windowBox('Main', _kPrimary, true),
              SizedBox(width: 12),
              Column(
                children: [
                  _windowBox('Child 1', _kAccent, false),
                  SizedBox(height: 4),
                  _windowBox('Child 2', _kAccent, false),
                  SizedBox(height: 4),
                  _windowBox('Child 3', _kAccent, false),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _windowBox(String label, Color color, bool isMain) {
    return Container(
      width: isMain ? 80 : 60,
      height: isMain ? 80 : 22,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color, width: isMain ? 2 : 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(label,
            style: TextStyle(
                fontSize: isMain ? 11 : 9,
                fontWeight: FontWeight.w600,
                color: color)),
      ),
    );
  }

  Widget _buildConfirmationPattern() {
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
              Icon(Icons.help_outline,
                  size: 20, color: _kLifecycleClose),
              SizedBox(width: 8),
              Text('Pattern: Async Confirmation',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _kPrimary)),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'The delegate can show dialogs asynchronously before '
            'deciding to close. The window stays open until '
            'destroy() is explicitly called.',
            style: TextStyle(
                fontSize: 12, color: Colors.grey[700], height: 1.4),
          ),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCodeBg,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '@override\n'
              'void onWindowCloseRequested(\n'
              '  RegularWindowController controller,\n'
              ') async {\n'
              '  final confirm = await showDialog<bool>(\n'
              '    context: _context,\n'
              '    builder: (_) => AlertDialog(\n'
              '      title: Text("Close Window?"),\n'
              '      actions: [\n'
              '        TextButton(\n'
              '          onPressed: () =>\n'
              '              Navigator.pop(_, false),\n'
              '          child: Text("Cancel"),\n'
              '        ),\n'
              '        TextButton(\n'
              '          onPressed: () =>\n'
              '              Navigator.pop(_, true),\n'
              '          child: Text("Close"),\n'
              '        ),\n'
              '      ],\n'
              '    ),\n'
              '  );\n'
              '  if (confirm == true) {\n'
              '    controller.destroy();\n'
              '  }\n'
              '}',
              style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: _kDarkText,
                  height: 1.45),
            ),
          ),
          SizedBox(height: 10),
          _patternNote(
            'The async pattern works because the window is not destroyed '
            'until destroy() is explicitly called. The system just notifies '
            'the delegate.',
          ),
        ],
      ),
    );
  }

  Widget _buildCompositePattern() {
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
          Row(
            children: [
              Icon(Icons.layers, size: 20, color: _kAccent),
              SizedBox(width: 8),
              Text('Pattern: Composite Delegate',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _kPrimary)),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Combine multiple behaviors by composing delegate logic with '
            'a forwarding delegate that chains handlers.',
            style: TextStyle(
                fontSize: 12, color: Colors.grey[700], height: 1.4),
          ),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCodeBg,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'class CompositeDelegate\n'
              '    with RegularWindowControllerDelegate {\n'
              '  final List<RegularWindowControllerDelegate>\n'
              '      _delegates;\n'
              '\n'
              '  CompositeDelegate(this._delegates);\n'
              '\n'
              '  @override\n'
              '  void onWindowCloseRequested(\n'
              '    RegularWindowController c,\n'
              '  ) {\n'
              '    // Let each delegate run pre-close logic\n'
              '    for (final d in _delegates) {\n'
              '      d.onWindowCloseRequested(c);\n'
              '    }\n'
              '  }\n'
              '\n'
              '  @override\n'
              '  void onWindowDestroyed() {\n'
              '    for (final d in _delegates) {\n'
              '      d.onWindowDestroyed();\n'
              '    }\n'
              '  }\n'
              '}',
              style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: _kDarkText,
                  height: 1.45),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _delegateChip('SaveDelegate'),
              SizedBox(width: 4),
              Icon(Icons.add, size: 14, color: Colors.grey[500]),
              SizedBox(width: 4),
              _delegateChip('LogDelegate'),
              SizedBox(width: 4),
              Icon(Icons.add, size: 14, color: Colors.grey[500]),
              SizedBox(width: 4),
              _delegateChip('CleanupDelegate'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _delegateChip(String name) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: _kAccent.withOpacity(0.12),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(name,
          style: TextStyle(
              fontSize: 9,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
              color: _kPrimary)),
    );
  }

  Widget _buildBestPracticesCard() {
    final practices = <Map<String, String>>[
      {
        'title': 'Always call destroy() eventually',
        'detail': 'If you override onWindowCloseRequested, ensure every '
            'code path eventually calls controller.destroy() or the '
            'window will never close.',
      },
      {
        'title': 'Don\'t use the controller in onWindowDestroyed',
        'detail': 'By the time onWindowDestroyed is called, the window is '
            'gone. The controller is no longer functional.',
      },
      {
        'title': 'Handle async carefully',
        'detail': 'If showing a dialog in onWindowCloseRequested, the user '
            'might click close again. Guard against double invocation.',
      },
      {
        'title': 'Test with rapid close events',
        'detail': 'Users sometimes mash the close button. Ensure your '
            'delegate handles multiple rapid close requests gracefully.',
      },
      {
        'title': 'Keep cleanup fast',
        'detail': 'onWindowDestroyed should complete quickly. Schedule '
            'expensive cleanup (like file sync) separately.',
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
              Icon(Icons.school, size: 18, color: _kPrimary),
              SizedBox(width: 8),
              Text('Best Practices',
                  style: TextStyle(
                      fontSize: 13,
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

  Widget _patternNote(String text) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kHighlight,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline, size: 16, color: Color(0xFFE65100)),
          SizedBox(width: 8),
          Expanded(
            child: Text(text,
                style: TextStyle(
                    fontSize: 11.5,
                    color: _kDarkText,
                    height: 1.4)),
          ),
        ],
      ),
    );
  }
}

// ── data models ─────────────────────────────────────────

enum _WindowPhase { idle, created, active, closing, destroyed }

class _LifecycleEvent {
  final String title;
  final String detail;
  final Color color;
  const _LifecycleEvent(this.title, this.detail, this.color);
}

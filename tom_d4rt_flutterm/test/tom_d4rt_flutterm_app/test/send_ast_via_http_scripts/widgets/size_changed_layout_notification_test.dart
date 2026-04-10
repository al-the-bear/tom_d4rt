import 'package:flutter/material.dart';

const Color _primary = Color(0xFF4A148C);
const Color _accent = Color(0xFFB2FF59);
const Color _bg = Color(0xFF0F0D14);
const Color _panel = Color(0xFF1E1A2A);
const Color _panel2 = Color(0xFF29213A);
const Color _muted = Color(0xFFB8B4C4);
const Color _ok = Color(0xFF66BB6A);
const Color _warn = Color(0xFFFFB74D);
const Color _info = Color(0xFF4FC3F7);

Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _bg,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: _primary,
        secondary: _accent,
        surface: _panel,
      ),
    ),
    home: const _SizeChangedLayoutNotificationDemo(),
  );
}

class _SizeChangedLayoutNotificationDemo extends StatefulWidget {
  const _SizeChangedLayoutNotificationDemo();

  @override
  State<_SizeChangedLayoutNotificationDemo> createState() =>
      _SizeChangedLayoutNotificationDemoState();
}

class _SizeChangedLayoutNotificationDemoState
    extends State<_SizeChangedLayoutNotificationDemo>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _panel,
        title: const Text(
          'SizeChangedLayoutNotification',
          style: TextStyle(
            color: _accent,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _accent,
          labelColor: _accent,
          unselectedLabelColor: _muted,
          tabs: const [
            Tab(text: 'Basics'),
            Tab(text: 'Scopes'),
            Tab(text: 'Integration'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _BasicsTab(),
          _ScopesTab(),
          _IntegrationTab(),
        ],
      ),
    );
  }
}

class _BasicsTab extends StatefulWidget {
  const _BasicsTab();

  @override
  State<_BasicsTab> createState() => _BasicsTabState();
}

class _BasicsTabState extends State<_BasicsTab>
    with AutomaticKeepAliveClientMixin {
  double _width = 160;
  double _height = 80;
  int _eventCount = 0;
  final List<String> _events = <String>[];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (notification) {
        final stamp = TimeOfDay.now().format(context);
        setState(() {
          _eventCount += 1;
          _events.insert(
            0,
            '$stamp  |  size -> ${_width.toStringAsFixed(0)} x ${_height.toStringAsFixed(0)}',
          );
          if (_events.length > 18) {
            _events.removeLast();
          }
        });
        return false;
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title('What This Notification Is'),
            const SizedBox(height: 8),
            _panelBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _Bullet(
                    'Dispatched by SizeChangedLayoutNotifier when child size changes after the first layout.',
                  ),
                  _Bullet(
                    'Inherits from LayoutChangedNotification, which itself extends Notification.',
                  ),
                  _Bullet(
                    'Usually listened to by NotificationListener<SizeChangedLayoutNotification>.',
                  ),
                  _Bullet(
                    'Commonly used with Material ink effects and overlays that depend on geometry.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _title('Live Size Lab'),
            const SizedBox(height: 8),
            _panelBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Resize the child widget. Every post-initial size change dispatches SizeChangedLayoutNotification.',
                    style: TextStyle(color: _muted, fontSize: 11),
                  ),
                  const SizedBox(height: 12),
                  _label('Width: ${_width.toStringAsFixed(0)}'),
                  Slider(
                    value: _width,
                    min: 80,
                    max: 320,
                    activeColor: _accent,
                    inactiveColor: _muted.withValues(alpha: 0.35),
                    onChanged: (value) {
                      setState(() {
                        _width = value;
                      });
                    },
                  ),
                  _label('Height: ${_height.toStringAsFixed(0)}'),
                  Slider(
                    value: _height,
                    min: 48,
                    max: 220,
                    activeColor: _accent,
                    inactiveColor: _muted.withValues(alpha: 0.35),
                    onChanged: (value) {
                      setState(() {
                        _height = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _panel2,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _primary.withValues(alpha: 0.55)),
                    ),
                    child: Center(
                      child: SizeChangedLayoutNotifier(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 280),
                          width: _width,
                          height: _height,
                          curve: Curves.easeOutCubic,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: _accent.withValues(alpha: 0.8)),
                            boxShadow: [
                              BoxShadow(
                                color: _accent.withValues(alpha: 0.18),
                                blurRadius: 16,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              '${_width.toStringAsFixed(0)} x ${_height.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _title('Event Stream'),
            const SizedBox(height: 8),
            _panelBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _metric('Notifications', '$_eventCount', _info),
                      const SizedBox(width: 8),
                      _metric(
                        'Current Area',
                        (_width * _height).toStringAsFixed(0),
                        _warn,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _eventCount = 0;
                            _events.clear();
                          });
                        },
                        child: const Text('Clear log'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 220,
                    decoration: BoxDecoration(
                      color: _bg,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _panel2),
                    ),
                    child: _events.isEmpty
                        ? const Center(
                            child: Text(
                              'No notifications yet. Move a slider to change size.',
                              style: TextStyle(color: _muted, fontSize: 11),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: _events.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 4),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: _panel,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  _events[index],
                                  style: const TextStyle(
                                    color: _accent,
                                    fontSize: 10,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _panelBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label('Listener Pattern'),
                  const SizedBox(height: 6),
                  _code(
                    'NotificationListener<SizeChangedLayoutNotification>(\n'
                    '  onNotification: (notification) {\n'
                    '    // React to geometry updates\n'
                    '    return false;\n'
                    '  },\n'
                    '  child: SizeChangedLayoutNotifier(child: yourWidget),\n'
                    ')',
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

class _ScopesTab extends StatefulWidget {
  const _ScopesTab();

  @override
  State<_ScopesTab> createState() => _ScopesTabState();
}

class _ScopesTabState extends State<_ScopesTab>
    with AutomaticKeepAliveClientMixin {
  bool _innerExpanded = false;
  bool _outerExpanded = false;
  bool _nestedExpanded = false;
  int _outerCount = 0;
  int _innerCount = 0;
  int _nestedCount = 0;
  final List<double> _listHeights = <double>[64, 76, 92, 58, 84];
  int _listEvents = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (notification) {
        setState(() {
          _outerCount += 1;
        });
        return false;
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title('Scope Behavior'),
            const SizedBox(height: 8),
            _panelBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _Bullet('Notifications bubble upward through ancestors.'),
                  _Bullet('A parent listener receives notifications from all descendants inside its subtree.'),
                  _Bullet('Nested listeners can observe more local events while outer listeners see aggregate activity.'),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _title('Outer vs Inner Listener'),
            const SizedBox(height: 8),
            _panelBox(
              child: NotificationListener<SizeChangedLayoutNotification>(
                onNotification: (notification) {
                  setState(() {
                    _innerCount += 1;
                  });
                  return false;
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _metric('Outer count', '$_outerCount', _info),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _metric('Inner count', '$_innerCount', _ok),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _toggleCard(
                            title: 'Inner Box',
                            active: _innerExpanded,
                            onTap: () {
                              setState(() {
                                _innerExpanded = !_innerExpanded;
                              });
                            },
                            color: _ok,
                            child: SizeChangedLayoutNotifier(
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 260),
                                height: _innerExpanded ? 140 : 72,
                                decoration: BoxDecoration(
                                  color: _ok.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: _ok),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _toggleCard(
                            title: 'Sibling Box',
                            active: _outerExpanded,
                            onTap: () {
                              setState(() {
                                _outerExpanded = !_outerExpanded;
                              });
                            },
                            color: _warn,
                            child: SizeChangedLayoutNotifier(
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 260),
                                height: _outerExpanded ? 126 : 68,
                                decoration: BoxDecoration(
                                  color: _warn.withValues(alpha: 0.14),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: _warn),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            _title('Nested Notifier Chain'),
            const SizedBox(height: 8),
            _panelBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _metric('Nested listener count', '$_nestedCount', _accent),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _nestedExpanded = !_nestedExpanded;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _panel2,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _primary.withValues(alpha: 0.5)),
                      ),
                      child: NotificationListener<SizeChangedLayoutNotification>(
                        onNotification: (notification) {
                          setState(() {
                            _nestedCount += 1;
                          });
                          return false;
                        },
                        child: SizeChangedLayoutNotifier(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 280),
                            curve: Curves.easeOutCubic,
                            height: _nestedExpanded ? 190 : 96,
                            decoration: BoxDecoration(
                              color: _primary.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: _accent),
                            ),
                            child: Center(
                              child: SizeChangedLayoutNotifier(
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 280),
                                  width: _nestedExpanded ? 190 : 120,
                                  height: _nestedExpanded ? 120 : 64,
                                  decoration: BoxDecoration(
                                    color: _accent.withValues(alpha: 0.17),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: _accent),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Nested child',
                                      style: TextStyle(color: _accent),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _title('List Item Scenario'),
            const SizedBox(height: 8),
            _panelBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _metric('Item resize events', '$_listEvents', _warn),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _listEvents = 0;
                            _listHeights.setAll(0, <double>[64, 76, 92, 58, 84]);
                          });
                        },
                        child: const Text('Reset items'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...List<Widget>.generate(_listHeights.length, (index) {
                    final value = _listHeights[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: SizeChangedLayoutNotifier(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 260),
                          curve: Curves.easeOut,
                          height: value,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: _panel2,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: _panel),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'List item ${index + 1} • ${value.toStringAsFixed(0)} px',
                                  style: const TextStyle(color: _muted, fontSize: 11),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.unfold_more, size: 18),
                                onPressed: () {
                                  setState(() {
                                    _listHeights[index] = value + 24;
                                    _listEvents += 1;
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.unfold_less, size: 18),
                                onPressed: () {
                                  setState(() {
                                    _listHeights[index] = (value - 24).clamp(48, 200);
                                    _listEvents += 1;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IntegrationTab extends StatefulWidget {
  const _IntegrationTab();

  @override
  State<_IntegrationTab> createState() => _IntegrationTabState();
}

class _IntegrationTabState extends State<_IntegrationTab>
    with AutomaticKeepAliveClientMixin {
  bool _expandedCard = false;
  int _inkFixEvents = 0;
  bool _openComposer = false;
  int _overlayEvents = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (notification) {
        setState(() {
          _inkFixEvents += 1;
        });
        return false;
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title('Material Ink Integration'),
            const SizedBox(height: 8),
            _panelBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Material uses layout-changed notifications to keep ink features aligned after geometry updates.',
                    style: TextStyle(color: _muted, fontSize: 11),
                  ),
                  const SizedBox(height: 10),
                  _metric('Layout notifications', '$_inkFixEvents', _info),
                  const SizedBox(height: 10),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _expandedCard = !_expandedCard;
                        });
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: SizeChangedLayoutNotifier(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          width: double.infinity,
                          height: _expandedCard ? 210 : 112,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: _panel2,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: _accent.withValues(alpha: 0.6)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.touch_app, color: _accent),
                                  SizedBox(width: 8),
                                  Text(
                                    'Tap to expand/collapse',
                                    style: TextStyle(color: _accent, fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _expandedCard
                                    ? 'Expanded surface demonstrates repeated size updates while preserving visual reaction zones.'
                                    : 'Collapsed state.',
                                style: const TextStyle(color: _muted, fontSize: 11),
                              ),
                              const Spacer(),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  'height: ${_expandedCard ? 210 : 112}',
                                  style: const TextStyle(color: _muted, fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _title('Overlay Anchor Pattern'),
            const SizedBox(height: 8),
            _panelBox(
              child: NotificationListener<SizeChangedLayoutNotification>(
                onNotification: (notification) {
                  setState(() {
                    _overlayEvents += 1;
                  });
                  return false;
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _metric('Anchor updates', '$_overlayEvents', _warn),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _openComposer = !_openComposer;
                            });
                          },
                          child: Text(_openComposer ? 'Close composer' : 'Open composer'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Stack(
                      children: [
                        SizeChangedLayoutNotifier(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 280),
                            width: double.infinity,
                            height: _openComposer ? 220 : 92,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: _panel2,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: _info.withValues(alpha: 0.6)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Composer panel',
                                  style: TextStyle(color: _info, fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 8),
                                if (_openComposer)
                                  const Expanded(
                                    child: TextField(
                                      maxLines: null,
                                      expands: true,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0x22111111),
                                        border: OutlineInputBorder(),
                                        hintText: 'Type message...',
                                      ),
                                    ),
                                  )
                                else
                                  const Text(
                                    'Collapsed preview',
                                    style: TextStyle(color: _muted, fontSize: 11),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: _openComposer ? 186 : 58,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 280),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: _accent.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: _accent),
                            ),
                            child: const Text(
                              'Anchored action',
                              style: TextStyle(color: _accent, fontSize: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            _title('When To Use'),
            const SizedBox(height: 8),
            _panelBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _UseCaseRow(
                    icon: Icons.gesture,
                    title: 'Ink effects on animated surfaces',
                    subtitle: 'Keep splash and highlight placement synchronized with changing layout bounds.',
                    color: _accent,
                  ),
                  SizedBox(height: 8),
                  _UseCaseRow(
                    icon: Icons.layers,
                    title: 'Overlay anchors and callouts',
                    subtitle: 'Update dependent positions when source widget dimensions shift.',
                    color: _info,
                  ),
                  SizedBox(height: 8),
                  _UseCaseRow(
                    icon: Icons.table_rows,
                    title: 'Dynamic list rows',
                    subtitle: 'Observe row expansion and collapse and trigger parent-level reactions.',
                    color: _warn,
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

class _UseCaseRow extends StatelessWidget {
  const _UseCaseRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 12),
              ),
              Text(
                subtitle,
                style: const TextStyle(color: _muted, fontSize: 11),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6),
            decoration: const BoxDecoration(color: _accent, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: _muted, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _title(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: _accent,
      fontWeight: FontWeight.w700,
      fontSize: 14,
    ),
  );
}

Widget _panelBox({required Widget child}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _panel,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _panel2),
    ),
    child: child,
  );
}

Widget _metric(String label, String value, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: _muted, fontSize: 9),
        ),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        ),
      ],
    ),
  );
}

Widget _label(String text) {
  return Text(
    text,
    style: const TextStyle(color: _muted, fontSize: 11),
  );
}

Widget _code(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _bg,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _panel2),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: _accent,
        fontSize: 10,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _toggleCard({
  required String title,
  required bool active,
  required VoidCallback onTap,
  required Color color,
  required Widget child,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text(
          active ? 'Expanded' : 'Collapsed',
          style: const TextStyle(color: _muted, fontSize: 10),
        ),
        const SizedBox(height: 6),
        child,
      ],
    ),
  );
}

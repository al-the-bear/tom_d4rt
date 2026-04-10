import 'package:flutter/material.dart';

const Color _bg = Color(0xFF0F1714);
const Color _panel = Color(0xFF1A2A24);
const Color _panel2 = Color(0xFF294036);
const Color _text = Color(0xFFD7F3E7);
const Color _green = Color(0xFF78E3B6);
const Color _amber = Color(0xFFFFCE77);
const Color _coral = Color(0xFFFF9D7A);
const Color _cyan = Color(0xFF8ADFFF);
const Color _violet = Color(0xFFCAA9FF);

Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _bg,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: _green,
        secondary: _amber,
        surface: _panel,
      ),
    ),
    home: const _StandardComponentTypeDemo(),
  );
}

class _StandardComponentTypeDemo extends StatefulWidget {
  const _StandardComponentTypeDemo();

  @override
  State<_StandardComponentTypeDemo> createState() => _StandardComponentTypeDemoState();
}

class _StandardComponentTypeDemoState extends State<_StandardComponentTypeDemo>
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
          'StandardComponentType Deep Demo',
          style: TextStyle(color: _green, fontSize: 15, fontWeight: FontWeight.w700),
        ),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _green,
          labelColor: _green,
          unselectedLabelColor: _text,
          tabs: const [
            Tab(text: 'Type Gallery'),
            Tab(text: 'Live Scaffold'),
            Tab(text: 'Finder Keys'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _TypeGalleryTab(),
          _LiveScaffoldTab(),
          _FinderKeysTab(),
        ],
      ),
    );
  }
}

class _TypeGalleryTab extends StatefulWidget {
  const _TypeGalleryTab();

  @override
  State<_TypeGalleryTab> createState() => _TypeGalleryTabState();
}

class _TypeGalleryTabState extends State<_TypeGalleryTab>
    with AutomaticKeepAliveClientMixin {
  StandardComponentType _selected = StandardComponentType.backButton;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _TypeInfo info = _info[_selected]!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section('What StandardComponentType Represents'),
          const SizedBox(height: 8),
          _panelBox(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Bullet('StandardComponentType identifies common framework controls used by finder utilities.'),
                _Bullet('Each enum entry maps to a stable key used by test discovery and UI automation.'),
                _Bullet('Use these types to avoid brittle text/icon matching in tests.'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _section('Component Type Selector'),
          const SizedBox(height: 8),
          _panelBox(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: StandardComponentType.values.map((StandardComponentType value) {
                final bool active = value == _selected;
                final _TypeInfo row = _info[value]!;
                return GestureDetector(
                  onTap: () => setState(() => _selected = value),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    decoration: BoxDecoration(
                      color: active ? row.color.withValues(alpha: 0.2) : Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: active ? row.color : _panel2),
                    ),
                    child: Text(
                      value.name,
                      style: TextStyle(
                        color: active ? row.color : _text,
                        fontSize: 11,
                        fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 14),
          _section('Selected Type Profile'),
          const SizedBox(height: 8),
          _panelBox(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: info.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: info.color.withValues(alpha: 0.85)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(info.icon, color: info.color),
                      const SizedBox(width: 8),
                      Text(info.title, style: TextStyle(color: info.color, fontSize: 12, fontWeight: FontWeight.w700)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(info.summary, style: const TextStyle(color: _text, fontSize: 11)),
                  const SizedBox(height: 8),
                  Text('Key: ${_readableKey(_selected.key)}', style: TextStyle(color: info.color, fontSize: 10, fontFamily: 'monospace')),
                  const SizedBox(height: 8),
                  ...info.notes.map(
                    (String n) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.chevron_right_rounded, color: info.color, size: 16),
                          const SizedBox(width: 4),
                          Expanded(child: Text(n, style: const TextStyle(color: _text, fontSize: 10))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          _section('Visual Context Cards'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              children: [
                _contextCard(
                  icon: Icons.arrow_back_rounded,
                  color: _green,
                  title: 'Navigation Surface',
                  body: 'BackButton appears where users return to previous route context.',
                  badge: StandardComponentType.backButton,
                ),
                _contextCard(
                  icon: Icons.close_rounded,
                  color: _coral,
                  title: 'Dismiss Surface',
                  body: 'CloseButton exits modal/dialog style surfaces.',
                  badge: StandardComponentType.closeButton,
                ),
                _contextCard(
                  icon: Icons.more_horiz_rounded,
                  color: _amber,
                  title: 'Overflow Surface',
                  body: 'MoreButton reveals additional actions in compact headers.',
                  badge: StandardComponentType.moreButton,
                ),
                _contextCard(
                  icon: Icons.menu_rounded,
                  color: _cyan,
                  title: 'Drawer Surface',
                  body: 'DrawerButton controls side navigation drawer visibility.',
                  badge: StandardComponentType.drawerButton,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _contextCard({
    required IconData icon,
    required Color color,
    required String title,
    required String body,
    required StandardComponentType badge,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 7),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: color.withValues(alpha: 0.8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 11)),
                const SizedBox(height: 4),
                Text(body, style: const TextStyle(color: _text, fontSize: 10)),
                const SizedBox(height: 6),
                Text(
                  badge.name,
                  style: TextStyle(color: color, fontSize: 9, fontFamily: 'monospace'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _readableKey(Key key) {
    if (key is ValueKey<Object?>) {
      return 'ValueKey(${key.value})';
    }
    return key.toString();
  }
}

class _LiveScaffoldTab extends StatefulWidget {
  const _LiveScaffoldTab();

  @override
  State<_LiveScaffoldTab> createState() => _LiveScaffoldTabState();
}

class _LiveScaffoldTabState extends State<_LiveScaffoldTab>
    with AutomaticKeepAliveClientMixin {
  bool _showBack = true;
  bool _showClose = false;
  bool _showMore = true;
  bool _showDrawer = true;
  bool _modalOpen = false;
  bool _drawerOpen = false;

  final List<String> _events = <String>[];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section('Interactive Header Simulator'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              children: [
                _toggle('BackButton', _showBack, _green, (bool v) {
                  setState(() => _showBack = v);
                  _log('show back -> $v');
                }),
                _toggle('CloseButton', _showClose, _coral, (bool v) {
                  setState(() => _showClose = v);
                  _log('show close -> $v');
                }),
                _toggle('MoreButton', _showMore, _amber, (bool v) {
                  setState(() => _showMore = v);
                  _log('show more -> $v');
                }),
                _toggle('DrawerButton', _showDrawer, _cyan, (bool v) {
                  setState(() => _showDrawer = v);
                  _log('show drawer -> $v');
                }),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _section('Mock App Bar'),
          const SizedBox(height: 8),
          _panelBox(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: _panel2,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _green.withValues(alpha: 0.8)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Row(
                      children: [
                        if (_showBack)
                          _controlIcon(
                            icon: Icons.arrow_back_rounded,
                            color: _green,
                            label: 'Back',
                            type: StandardComponentType.backButton,
                            onTap: () => _log('BackButton pressed'),
                          ),
                        if (_showClose)
                          _controlIcon(
                            icon: Icons.close_rounded,
                            color: _coral,
                            label: 'Close',
                            type: StandardComponentType.closeButton,
                            onTap: () {
                              setState(() => _modalOpen = false);
                              _log('CloseButton pressed -> modal closed');
                            },
                          ),
                        const Expanded(
                          child: Center(
                            child: Text('Header Zone', style: TextStyle(color: _text, fontWeight: FontWeight.w700)),
                          ),
                        ),
                        if (_showMore)
                          _controlIcon(
                            icon: Icons.more_horiz_rounded,
                            color: _amber,
                            label: 'More',
                            type: StandardComponentType.moreButton,
                            onTap: () => _log('MoreButton pressed -> open overflow menu'),
                          ),
                        if (_showDrawer)
                          _controlIcon(
                            icon: Icons.menu_rounded,
                            color: _cyan,
                            label: 'Drawer',
                            type: StandardComponentType.drawerButton,
                            onTap: () {
                              setState(() => _drawerOpen = !_drawerOpen);
                              _log('DrawerButton pressed -> drawer ${_drawerOpen ? 'open' : 'closed'}');
                            },
                          ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: _bg),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    height: _drawerOpen ? 88 : 0,
                    curve: Curves.easeOutCubic,
                    width: double.infinity,
                    color: _cyan.withValues(alpha: 0.14),
                    child: _drawerOpen
                        ? const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Drawer content simulated here.\nUse StandardComponentType.drawerButton finder key in tests.',
                              style: TextStyle(color: _text, fontSize: 11),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          _section('Scenario Actions'),
          const SizedBox(height: 8),
          _panelBox(
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() => _modalOpen = true);
                      _log('Modal opened');
                    },
                    icon: const Icon(Icons.open_in_new_rounded, size: 16),
                    label: const Text('Open Modal'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _showBack = true;
                        _showClose = false;
                        _showMore = true;
                        _showDrawer = true;
                        _drawerOpen = false;
                        _modalOpen = false;
                      });
                      _log('Reset to default header arrangement');
                    },
                    icon: const Icon(Icons.restore_rounded, size: 16),
                    label: const Text('Reset'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          if (_modalOpen) ...[
            _section('Modal Preview'),
            const SizedBox(height: 8),
            _panelBox(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _coral.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: _coral.withValues(alpha: 0.8)),
                ),
                child: const Text(
                  'Modal is active. CloseButton is usually the semantically appropriate standard component type.',
                  style: TextStyle(color: _text, fontSize: 11),
                ),
              ),
            ),
            const SizedBox(height: 14),
          ],
          _section('Interaction Log'),
          const SizedBox(height: 8),
          _panelBox(
            child: Container(
              height: 210,
              decoration: BoxDecoration(
                color: _bg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _panel2),
              ),
              child: _events.isEmpty
                  ? const Center(child: Text('No events yet.', style: TextStyle(color: _text, fontSize: 11)))
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: _events.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(
                            color: _panel,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            _events[index],
                            style: const TextStyle(color: _amber, fontSize: 10, fontFamily: 'monospace'),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _toggle(String label, bool value, Color color, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: const TextStyle(color: _text, fontSize: 11)),
      value: value,
      activeThumbColor: color,
      onChanged: onChanged,
    );
  }

  Widget _controlIcon({
    required IconData icon,
    required Color color,
    required String label,
    required StandardComponentType type,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: Tooltip(
        message: '${type.name} | ${_readableKey(type.key)}',
        child: InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              shape: BoxShape.circle,
              border: Border.all(color: color.withValues(alpha: 0.9)),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
        ),
      ),
    );
  }

  String _readableKey(Key key) {
    if (key is ValueKey<Object?>) {
      return 'ValueKey(${key.value})';
    }
    return key.toString();
  }

  void _log(String text) {
    final String t = TimeOfDay.now().format(context);
    setState(() {
      _events.insert(0, '$t | $text');
      if (_events.length > 45) {
        _events.removeLast();
      }
    });
  }
}

class _FinderKeysTab extends StatefulWidget {
  const _FinderKeysTab();

  @override
  State<_FinderKeysTab> createState() => _FinderKeysTabState();
}

class _FinderKeysTabState extends State<_FinderKeysTab>
    with AutomaticKeepAliveClientMixin {
  StandardComponentType _focus = StandardComponentType.backButton;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _TypeInfo info = _info[_focus]!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section('Finder Key Mapping Inspector'),
          const SizedBox(height: 8),
          _panelBox(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Bullet('Each StandardComponentType exposes a canonical key used by testing finders.'),
                _Bullet('The mapping allows resilient lookup independent of localized labels or icon style changes.'),
                _Bullet('This tab demonstrates key selection and expected finder snippets.'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _section('Select Type'),
          const SizedBox(height: 8),
          _panelBox(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: StandardComponentType.values.map((type) {
                final bool active = type == _focus;
                final _TypeInfo item = _info[type]!;
                return GestureDetector(
                  onTap: () => setState(() => _focus = type),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    decoration: BoxDecoration(
                      color: active ? item.color.withValues(alpha: 0.2) : Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: active ? item.color : _panel2),
                    ),
                    child: Text(
                      type.name,
                      style: TextStyle(
                        color: active ? item.color : _text,
                        fontSize: 11,
                        fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 14),
          _section('Key Details'),
          const SizedBox(height: 8),
          _panelBox(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: info.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: info.color.withValues(alpha: 0.85)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(info.title, style: TextStyle(color: info.color, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  Text('Enum: ${_focus.name}', style: const TextStyle(color: _text, fontSize: 11)),
                  const SizedBox(height: 4),
                  Text('Key: ${_readableKey(_focus.key)}', style: TextStyle(color: info.color, fontSize: 10, fontFamily: 'monospace')),
                  const SizedBox(height: 8),
                  _code(
                    'final Finder finder = find.byKey(${_readableKey(_focus.key)});\n'
                    '// or using convenience finders, depending on test API\n'
                    '// expected type: ${_focus.name}',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          _section('Cross-Type Matrix'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              children: StandardComponentType.values.map((type) {
                final _TypeInfo row = _info[type]!;
                final bool active = type == _focus;
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: active ? row.color.withValues(alpha: 0.16) : _panel2,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: active ? row.color.withValues(alpha: 0.85) : _panel2),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(type.name, style: TextStyle(color: active ? row.color : _text, fontSize: 11, fontWeight: FontWeight.w700)),
                      ),
                      Text(
                        _readableKey(type.key),
                        style: TextStyle(
                          color: active ? row.color : _text,
                          fontSize: 10,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 14),
          _section('Testing Guidance'),
          const SizedBox(height: 8),
          _panelBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _Bullet('Prefer key-based finder usage for components represented by StandardComponentType.'),
                _Bullet('Avoid coupling tests to translated strings in action buttons.'),
                _Bullet('Use matrix checks to ensure all expected standard controls exist in target screens.'),
                _Bullet('When a component type is absent by design, document that explicitly in scenario tests.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _readableKey(Key key) {
    if (key is ValueKey<Object?>) {
      return 'ValueKey(${key.value})';
    }
    return key.toString();
  }
}

class _TypeInfo {
  const _TypeInfo({
    required this.title,
    required this.summary,
    required this.notes,
    required this.icon,
    required this.color,
  });

  final String title;
  final String summary;
  final List<String> notes;
  final IconData icon;
  final Color color;
}

const Map<StandardComponentType, _TypeInfo> _info = {
  StandardComponentType.backButton: _TypeInfo(
    title: 'BackButton Type',
    summary: 'Represents canonical back navigation affordance.',
    notes: [
      'Common in app bars when there is route history.',
      'Used by finder shortcuts for robust navigation tests.',
    ],
    icon: Icons.arrow_back_rounded,
    color: _green,
  ),
  StandardComponentType.closeButton: _TypeInfo(
    title: 'CloseButton Type',
    summary: 'Represents dismissal affordance for modals and overlays.',
    notes: [
      'Often replaces BackButton in modal contexts.',
      'Useful in dialog workflows and custom surface tests.',
    ],
    icon: Icons.close_rounded,
    color: _coral,
  ),
  StandardComponentType.moreButton: _TypeInfo(
    title: 'MoreButton Type',
    summary: 'Represents overflow or additional actions menu trigger.',
    notes: [
      'Appears in constrained top bars and cards.',
      'Helps tests target overflow actions reliably.',
    ],
    icon: Icons.more_horiz_rounded,
    color: _amber,
  ),
  StandardComponentType.drawerButton: _TypeInfo(
    title: 'DrawerButton Type',
    summary: 'Represents side drawer toggle control.',
    notes: [
      'Typically visible in scaffold headers with drawer navigation.',
      'Supports explicit open/close behavior checks.',
    ],
    icon: Icons.menu_rounded,
    color: _cyan,
  ),
};

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
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(color: _green, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(color: _text, fontSize: 11))),
        ],
      ),
    );
  }
}

Widget _section(String text) {
  return Text(
    text,
    style: const TextStyle(color: _green, fontSize: 14, fontWeight: FontWeight.w700),
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

Widget _code(String text) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _bg,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _panel2),
    ),
    child: Text(
      text,
      style: const TextStyle(color: _violet, fontSize: 10, fontFamily: 'monospace'),
    ),
  );
}

import 'package:flutter/material.dart';

// =============================================================================
// RouteInformationReportingType — URL Bar Behaviour Lab
// -----------------------------------------------------------------------------
// A deep-demo harness that teaches the three modes of Flutter's
// RouteInformationReportingType enum (part of package:flutter/widgets.dart)
// by simulating a browser-style URL bar and history stack that behave
// differently depending on the chosen reporting mode.
//
// The enum has exactly three values:
//
//   - RouteInformationReportingType.none       — no route update reported to
//                                                the engine. The URL bar is
//                                                not changed, and the browser
//                                                history stack is untouched.
//   - RouteInformationReportingType.neglect    — a route update is reported,
//                                                but the engine REPLACES the
//                                                current history entry rather
//                                                than pushing a new one. No
//                                                new back-button entry is
//                                                created.
//   - RouteInformationReportingType.navigate   — a standard update: a new
//                                                history entry is pushed and
//                                                the URL bar changes.
//
// These modes show up in:
//
//   - Router.routeInformationReportingType
//   - RouteInformationProvider.routerReportsNewRouteInformation(...)
//   - RouterConfig.routeInformationReportingType (indirectly, via Router)
//
// This demo does NOT wire up a real Router: Router wiring requires a backing
// RouteInformationProvider and a RouterDelegate, which would distract from
// the pedagogical goal. Instead, we simulate the three behaviours on a
// miniature URL bar + history stack so learners can see at a glance what each
// reporting mode actually changes in the observable world.
// =============================================================================

dynamic build(BuildContext context) {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'RouteInformationReportingType — URL Bar Behaviour Lab',
    home: UrlBarBehaviourLabDemo(),
  );
}

// =============================================================================
// Palette — browser chrome grey, slate (none), amber (neglect), green
// (navigate).
// =============================================================================

class _LabPalette {
  const _LabPalette._();

  // Browser chrome
  static const Color chromeTitleBar = Color(0xFFE9ECEF);
  static const Color chromeBorder = Color(0xFFCED4DA);
  static const Color chromeUrlBar = Color(0xFFF8F9FA);
  static const Color chromeInk = Color(0xFF212529);
  static const Color chromeMutedInk = Color(0xFF6C757D);

  // Window control dots
  static const Color dotRed = Color(0xFFFF5F56);
  static const Color dotAmber = Color(0xFFFFBD2E);
  static const Color dotGreen = Color(0xFF27C93F);

  // Mode colours
  static const Color slateNone = Color(0xFF64748B); // none
  static const Color amberNeglect = Color(0xFFD97706); // neglect
  static const Color greenNavigate = Color(0xFF059669); // navigate

  // Section backgrounds
  static const Color background = Color(0xFFF4F5F7);
  static const Color card = Colors.white;
  static const Color teachingPanel = Color(0xFF1F2937);
  static const Color teachingInk = Color(0xFFE5E7EB);
  static const Color codeBlock = Color(0xFF0F172A);
  static const Color codeInk = Color(0xFFE2E8F0);
}

// =============================================================================
// Model types for the demo.
// =============================================================================

/// A single entry on the mock history stack.
class _HistoryEntry {
  _HistoryEntry({
    required this.path,
    required this.label,
    required this.timestamp,
    required this.createdByMode,
  });

  final String path;
  final String label;
  final DateTime timestamp;
  final RouteInformationReportingType createdByMode;
}

/// A single preset link the user can tap.
class _PresetLink {
  const _PresetLink({
    required this.label,
    required this.path,
    required this.icon,
  });

  final String label;
  final String path;
  final IconData icon;
}

/// A single entry in the timeline log.
class _TimelineEntry {
  _TimelineEntry({
    required this.timestamp,
    required this.mode,
    required this.actionDescription,
  });

  final DateTime timestamp;
  final RouteInformationReportingType mode;
  final String actionDescription;
}

// =============================================================================
// Root demo widget.
// =============================================================================

class UrlBarBehaviourLabDemo extends StatefulWidget {
  const UrlBarBehaviourLabDemo({super.key});

  @override
  State<UrlBarBehaviourLabDemo> createState() => _UrlBarBehaviourLabDemoState();
}

class _UrlBarBehaviourLabDemoState extends State<UrlBarBehaviourLabDemo> {
  // The six preset links users can tap to simulate link clicks.
  static const List<_PresetLink> _presetLinks = <_PresetLink>[
    _PresetLink(label: 'Home', path: '/', icon: Icons.home_outlined),
    _PresetLink(
      label: 'Articles',
      path: '/articles',
      icon: Icons.article_outlined,
    ),
    _PresetLink(
      label: 'Article 42',
      path: '/articles/42',
      icon: Icons.menu_book_outlined,
    ),
    _PresetLink(
      label: 'Settings',
      path: '/settings',
      icon: Icons.settings_outlined,
    ),
    _PresetLink(
      label: 'Profile',
      path: '/profile',
      icon: Icons.person_outline,
    ),
    _PresetLink(label: 'About', path: '/about', icon: Icons.info_outline),
  ];

  // The currently selected reporting mode. The switch statements all use
  // this value — which is how the enum's values end up driving real code
  // paths.
  RouteInformationReportingType _mode = RouteInformationReportingType.navigate;

  // The mock history stack. history[_cursor] is the entry currently shown
  // in the URL bar. Entries after _cursor are "forward" entries.
  final List<_HistoryEntry> _history = <_HistoryEntry>[
    _HistoryEntry(
      path: '/',
      label: 'Home',
      timestamp: DateTime.now(),
      createdByMode: RouteInformationReportingType.navigate,
    ),
  ];
  int _cursor = 0;

  // Log of recent navigation attempts. Only the last 20 are kept.
  final List<_TimelineEntry> _timeline = <_TimelineEntry>[];

  // A transient string shown in the URL bar when a `none` navigation happens:
  // since the URL bar does not update, we briefly flash a hint so learners can
  // still see that an event occurred.
  String? _urlBarFlash;
  int _flashToken = 0;

  // Records the most recent action's mode, used by the sequence diagram
  // in the history strip.
  RouteInformationReportingType? _lastActionMode;

  @override
  void initState() {
    super.initState();
    _appendTimeline(
      _TimelineEntry(
        timestamp: DateTime.now(),
        mode: RouteInformationReportingType.navigate,
        actionDescription: 'initial load /',
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // State mutations.
  // ---------------------------------------------------------------------------

  void _onModeChanged(RouteInformationReportingType next) {
    setState(() {
      _mode = next;
    });
    _appendTimeline(
      _TimelineEntry(
        timestamp: DateTime.now(),
        mode: next,
        actionDescription: 'mode set to ${_modeName(next)}',
      ),
    );
    debugPrint(
      '[UrlBarBehaviourLab] mode changed to ${_modeName(next)}',
    );
  }

  void _onLinkTapped(_PresetLink link) {
    final DateTime now = DateTime.now();
    final _HistoryEntry newEntry = _HistoryEntry(
      path: link.path,
      label: link.label,
      timestamp: now,
      createdByMode: _mode,
    );

    // This is where the enum's value actually drives behaviour.
    switch (_mode) {
      case RouteInformationReportingType.none:
        // No URL bar change, no history mutation. We merely flash a hint.
        _flashUrlBar('(URL not reported · ${link.path})');
        debugPrint(
          '[UrlBarBehaviourLab] none → suppressed reporting of ${link.path}',
        );
        break;
      case RouteInformationReportingType.neglect:
        // URL bar changes, but the TOP history entry is REPLACED, not pushed.
        // Any forward history beyond cursor is dropped.
        setState(() {
          if (_history.isEmpty) {
            _history.add(newEntry);
            _cursor = 0;
          } else {
            _history[_cursor] = newEntry;
            if (_cursor < _history.length - 1) {
              _history.removeRange(_cursor + 1, _history.length);
            }
          }
        });
        debugPrint(
          '[UrlBarBehaviourLab] neglect → replaced entry with ${link.path}',
        );
        break;
      case RouteInformationReportingType.navigate:
        // Standard push. Forward history is dropped, new entry appended.
        setState(() {
          if (_cursor < _history.length - 1) {
            _history.removeRange(_cursor + 1, _history.length);
          }
          _history.add(newEntry);
          _cursor = _history.length - 1;
        });
        debugPrint(
          '[UrlBarBehaviourLab] navigate → pushed ${link.path} '
          '(history size ${_history.length})',
        );
        break;
    }

    setState(() {
      _lastActionMode = _mode;
    });

    _appendTimeline(
      _TimelineEntry(
        timestamp: now,
        mode: _mode,
        actionDescription: '${_verbForMode(_mode)} ${link.path}',
      ),
    );
  }

  void _onBackPressed() {
    if (_cursor > 0) {
      setState(() {
        _cursor -= 1;
      });
      _appendTimeline(
        _TimelineEntry(
          timestamp: DateTime.now(),
          mode: _mode,
          actionDescription: 'back → ${_history[_cursor].path}',
        ),
      );
      debugPrint(
        '[UrlBarBehaviourLab] back → now at ${_history[_cursor].path}',
      );
    } else {
      _flashUrlBar('(no previous entry)');
    }
  }

  void _onForwardPressed() {
    if (_cursor < _history.length - 1) {
      setState(() {
        _cursor += 1;
      });
      _appendTimeline(
        _TimelineEntry(
          timestamp: DateTime.now(),
          mode: _mode,
          actionDescription: 'forward → ${_history[_cursor].path}',
        ),
      );
      debugPrint(
        '[UrlBarBehaviourLab] forward → now at ${_history[_cursor].path}',
      );
    } else {
      _flashUrlBar('(no forward entry)');
    }
  }

  void _onReloadPressed() {
    _appendTimeline(
      _TimelineEntry(
        timestamp: DateTime.now(),
        mode: _mode,
        actionDescription: 'reload ${_history[_cursor].path}',
      ),
    );
    _flashUrlBar('(reloading ${_history[_cursor].path}…)');
    debugPrint(
      '[UrlBarBehaviourLab] reload ${_history[_cursor].path}',
    );
  }

  void _onResetPressed() {
    setState(() {
      _history
        ..clear()
        ..add(
          _HistoryEntry(
            path: '/',
            label: 'Home',
            timestamp: DateTime.now(),
            createdByMode: RouteInformationReportingType.navigate,
          ),
        );
      _cursor = 0;
      _timeline.clear();
      _lastActionMode = null;
    });
    _appendTimeline(
      _TimelineEntry(
        timestamp: DateTime.now(),
        mode: RouteInformationReportingType.navigate,
        actionDescription: 'reset lab',
      ),
    );
  }

  void _flashUrlBar(String message) {
    final int token = ++_flashToken;
    setState(() {
      _urlBarFlash = message;
    });
    Future<void>.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      if (token != _flashToken) return;
      setState(() {
        _urlBarFlash = null;
      });
    });
  }

  void _appendTimeline(_TimelineEntry entry) {
    setState(() {
      _timeline.insert(0, entry);
      if (_timeline.length > 20) {
        _timeline.removeRange(20, _timeline.length);
      }
    });
  }

  // ---------------------------------------------------------------------------
  // Derived values.
  // ---------------------------------------------------------------------------

  _HistoryEntry get _active => _history[_cursor];

  String get _fullUrl => 'https://demo.app${_active.path}';

  Color _colorForMode(RouteInformationReportingType mode) {
    return switch (mode) {
      RouteInformationReportingType.none => _LabPalette.slateNone,
      RouteInformationReportingType.neglect => _LabPalette.amberNeglect,
      RouteInformationReportingType.navigate => _LabPalette.greenNavigate,
    };
  }

  String _modeName(RouteInformationReportingType mode) {
    return switch (mode) {
      RouteInformationReportingType.none => 'none',
      RouteInformationReportingType.neglect => 'neglect',
      RouteInformationReportingType.navigate => 'navigate',
    };
  }

  String _modeSymbol(RouteInformationReportingType mode) {
    return switch (mode) {
      RouteInformationReportingType.none => '🚫',
      RouteInformationReportingType.neglect => '↻',
      RouteInformationReportingType.navigate => '➡️',
    };
  }

  String _modeDescription(RouteInformationReportingType mode) {
    return switch (mode) {
      RouteInformationReportingType.none =>
        'No route update reported.\nURL bar & history untouched.',
      RouteInformationReportingType.neglect =>
        'Update reported, but the\ncurrent entry is REPLACED.',
      RouteInformationReportingType.navigate =>
        'Standard update: new history\nentry is pushed.',
    };
  }

  String _verbForMode(RouteInformationReportingType mode) {
    return switch (mode) {
      RouteInformationReportingType.none => 'suppress',
      RouteInformationReportingType.neglect => 'replace',
      RouteInformationReportingType.navigate => 'push',
    };
  }

  // ---------------------------------------------------------------------------
  // Build.
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _LabPalette.background,
      appBar: AppBar(
        backgroundColor: _LabPalette.chromeTitleBar,
        foregroundColor: _LabPalette.chromeInk,
        elevation: 0,
        title: const Text(
          'RouteInformationReportingType — URL Bar Behaviour Lab',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Reset lab',
            onPressed: _onResetPressed,
            icon: const Icon(Icons.refresh),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildMockBrowser(),
              const SizedBox(height: 24),
              _buildReportingSelector(),
              const SizedBox(height: 24),
              _buildLinkRow(),
              const SizedBox(height: 24),
              _buildHistoryStrip(),
              const SizedBox(height: 24),
              _buildTimelineLog(),
              const SizedBox(height: 24),
              _buildTeachingPanel(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 1 — Mock browser chrome.
  // ---------------------------------------------------------------------------

  Widget _buildMockBrowser() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: _LabPalette.chromeBorder),
      ),
      color: _LabPalette.card,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildBrowserTitleBar(),
          _buildNavigationBar(),
          _buildPageArea(),
        ],
      ),
    );
  }

  Widget _buildBrowserTitleBar() {
    return Container(
      decoration: const BoxDecoration(
        color: _LabPalette.chromeTitleBar,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
        border: Border(
          bottom: BorderSide(color: _LabPalette.chromeBorder),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: <Widget>[
          _buildWindowDot(_LabPalette.dotRed),
          const SizedBox(width: 8),
          _buildWindowDot(_LabPalette.dotAmber),
          const SizedBox(width: 8),
          _buildWindowDot(_LabPalette.dotGreen),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'demo.app — ${_active.label}',
              style: const TextStyle(
                fontSize: 12,
                color: _LabPalette.chromeMutedInk,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildWindowDot(Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: 0.6), width: 0.5),
      ),
    );
  }

  Widget _buildNavigationBar() {
    final bool canGoBack = _cursor > 0;
    final bool canGoForward = _cursor < _history.length - 1;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: const BoxDecoration(
        color: _LabPalette.card,
        border: Border(
          bottom: BorderSide(color: _LabPalette.chromeBorder),
        ),
      ),
      child: Row(
        children: <Widget>[
          _buildChromeButton(
            icon: Icons.arrow_back,
            tooltip: 'Back',
            enabled: canGoBack,
            onPressed: _onBackPressed,
          ),
          const SizedBox(width: 4),
          _buildChromeButton(
            icon: Icons.arrow_forward,
            tooltip: 'Forward',
            enabled: canGoForward,
            onPressed: _onForwardPressed,
          ),
          const SizedBox(width: 4),
          _buildChromeButton(
            icon: Icons.refresh,
            tooltip: 'Reload',
            enabled: true,
            onPressed: _onReloadPressed,
          ),
          const SizedBox(width: 12),
          Expanded(child: _buildUrlBar()),
          const SizedBox(width: 12),
          _buildModeBadge(_mode),
        ],
      ),
    );
  }

  Widget _buildChromeButton({
    required IconData icon,
    required String tooltip,
    required bool enabled,
    required VoidCallback onPressed,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: enabled ? onPressed : null,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: enabled
                ? _LabPalette.chromeTitleBar
                : _LabPalette.chromeTitleBar.withValues(alpha: 0.4),
          ),
          child: Icon(
            icon,
            size: 18,
            color: enabled
                ? _LabPalette.chromeInk
                : _LabPalette.chromeMutedInk.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }

  Widget _buildUrlBar() {
    final String? flash = _urlBarFlash;
    final bool flashing = flash != null;
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: _LabPalette.chromeUrlBar,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: flashing
              ? _colorForMode(_mode)
              : _LabPalette.chromeBorder,
          width: flashing ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            flashing ? Icons.info_outline : Icons.lock_outline,
            size: 14,
            color: flashing
                ? _colorForMode(_mode)
                : _LabPalette.chromeMutedInk,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              flash ?? _fullUrl,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                color: flashing
                    ? _colorForMode(_mode)
                    : _LabPalette.chromeInk,
                fontStyle: flashing ? FontStyle.italic : FontStyle.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Icon(
            Icons.star_border,
            size: 16,
            color: _LabPalette.chromeMutedInk.withValues(alpha: 0.7),
          ),
        ],
      ),
    );
  }

  Widget _buildModeBadge(RouteInformationReportingType mode) {
    final Color c = _colorForMode(mode);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: c.withValues(alpha: 0.45)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(_modeSymbol(mode), style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 6),
          Text(
            _modeName(mode),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: c,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageArea() {
    return Container(
      height: 180,
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: const BoxDecoration(
        color: _LabPalette.card,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _active.label,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: _LabPalette.chromeInk,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'path: ${_active.path}',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: _LabPalette.chromeMutedInk,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'This is a placeholder page for ${_active.label}. In a real Flutter '
            'app using Router/RouterConfig, the RouteInformationReportingType '
            'would control whether this page change is reported to the '
            'platform engine.',
            style: const TextStyle(
              fontSize: 13,
              color: _LabPalette.chromeInk,
              height: 1.4,
            ),
          ),
          const Spacer(),
          Row(
            children: <Widget>[
              Icon(
                Icons.schedule,
                size: 14,
                color: _LabPalette.chromeMutedInk,
              ),
              const SizedBox(width: 6),
              Text(
                'created ${_formatTime(_active.timestamp)} via '
                '${_modeName(_active.createdByMode)}',
                style: const TextStyle(
                  fontSize: 11,
                  color: _LabPalette.chromeMutedInk,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 2 — Reporting mode selector.
  // ---------------------------------------------------------------------------

  Widget _buildReportingSelector() {
    return Card(
      elevation: 1,
      color: _LabPalette.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: _LabPalette.chromeBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _SectionHeader(
              number: 2,
              title: 'Reporting mode selector',
              subtitle:
                  'Pick which RouteInformationReportingType value controls the '
                  'simulator below.',
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 620;
                final List<Widget> cards = <Widget>[
                  _buildModeCard(RouteInformationReportingType.none),
                  _buildModeCard(RouteInformationReportingType.neglect),
                  _buildModeCard(RouteInformationReportingType.navigate),
                ];
                if (narrow) {
                  return Column(
                    children: <Widget>[
                      for (final Widget w in cards) ...<Widget>[
                        w,
                        const SizedBox(height: 10),
                      ],
                    ],
                  );
                }
                return Row(
                  children: <Widget>[
                    for (int i = 0; i < cards.length; i++) ...<Widget>[
                      Expanded(child: cards[i]),
                      if (i != cards.length - 1) const SizedBox(width: 12),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModeCard(RouteInformationReportingType mode) {
    final bool selected = _mode == mode;
    final Color c = _colorForMode(mode);
    return InkWell(
      onTap: () => _onModeChanged(mode),
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: selected
              ? c.withValues(alpha: 0.10)
              : _LabPalette.chromeTitleBar.withValues(alpha: 0.4),
          border: Border.all(
            color: selected ? c : _LabPalette.chromeBorder,
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  _modeSymbol(mode),
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(width: 10),
                Text(
                  _modeName(mode),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: c,
                    letterSpacing: 0.3,
                  ),
                ),
                const Spacer(),
                if (selected)
                  Icon(Icons.check_circle, color: c, size: 18)
                else
                  Icon(
                    Icons.radio_button_unchecked,
                    color: _LabPalette.chromeMutedInk.withValues(alpha: 0.6),
                    size: 18,
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              _modeDescription(mode),
              style: TextStyle(
                fontSize: 12,
                height: 1.35,
                color: _LabPalette.chromeInk.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 3 — Navigation simulator (link row).
  // ---------------------------------------------------------------------------

  Widget _buildLinkRow() {
    return Card(
      elevation: 1,
      color: _LabPalette.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: _LabPalette.chromeBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _SectionHeader(
              number: 3,
              title: 'Navigation simulator',
              subtitle:
                  'Tap a link to simulate navigation under the current '
                  'reporting mode.',
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: <Widget>[
                for (final _PresetLink link in _presetLinks)
                  _buildLinkButton(link),
              ],
            ),
            const SizedBox(height: 14),
            _buildModeHint(),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkButton(_PresetLink link) {
    final Color c = _colorForMode(_mode);
    final bool isActive = _active.path == link.path;
    return InkWell(
      onTap: () => _onLinkTapped(link),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isActive
              ? c.withValues(alpha: 0.14)
              : _LabPalette.chromeTitleBar.withValues(alpha: 0.6),
          border: Border.all(
            color: isActive ? c : _LabPalette.chromeBorder,
            width: isActive ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              link.icon,
              size: 16,
              color: isActive ? c : _LabPalette.chromeInk,
            ),
            const SizedBox(width: 8),
            Text(
              link.label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive ? c : _LabPalette.chromeInk,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              link.path,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: _LabPalette.chromeMutedInk,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModeHint() {
    final Color c = _colorForMode(_mode);
    final String hint = switch (_mode) {
      RouteInformationReportingType.none =>
        'In `none`, taps will NOT change the URL bar or history. You will see '
            'a one-second "(URL not reported)" flash in the URL bar instead.',
      RouteInformationReportingType.neglect =>
        'In `neglect`, taps update the URL bar but REPLACE the current history '
            'entry. The Back button will skip past the replaced entry.',
      RouteInformationReportingType.navigate =>
        'In `navigate`, taps push a new history entry and update the URL bar. '
            'Back/Forward buttons work as a normal browser.',
    };
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: c.withValues(alpha: 0.08),
        border: Border.all(color: c.withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.lightbulb_outline, size: 16, color: c),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              hint,
              style: TextStyle(
                fontSize: 12,
                height: 1.4,
                color: _LabPalette.chromeInk.withValues(alpha: 0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 4 — History stack visualiser + sequence diagram.
  // ---------------------------------------------------------------------------

  Widget _buildHistoryStrip() {
    return Card(
      elevation: 1,
      color: _LabPalette.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: _LabPalette.chromeBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _SectionHeader(
              number: 4,
              title: 'History stack visualiser',
              subtitle:
                  'The list below is the browser history. The cursor marks '
                  'the currently visible entry; forward entries fade.',
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 720;
                final Widget strip = _buildHistoryColumn();
                final Widget diagram = _buildSequenceDiagram();
                if (narrow) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      strip,
                      const SizedBox(height: 18),
                      diagram,
                    ],
                  );
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(flex: 3, child: strip),
                    const SizedBox(width: 22),
                    Expanded(flex: 2, child: diagram),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryColumn() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _LabPalette.chromeTitleBar.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _LabPalette.chromeBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.layers_outlined,
                size: 16,
                color: _LabPalette.chromeMutedInk,
              ),
              const SizedBox(width: 6),
              Text(
                'history stack (${_history.length} entries, cursor '
                '@ ${_cursor + 1}/${_history.length})',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _LabPalette.chromeMutedInk,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (int i = 0; i < _history.length; i++)
            _buildHistoryEntryTile(i),
        ],
      ),
    );
  }

  Widget _buildHistoryEntryTile(int index) {
    final _HistoryEntry entry = _history[index];
    final bool isActive = index == _cursor;
    final bool isForward = index > _cursor;
    final Color modeColor = _colorForMode(entry.createdByMode);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Container(
            width: 28,
            alignment: Alignment.center,
            child: Text(
              '#${index + 1}',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: _LabPalette.chromeMutedInk.withValues(
                  alpha: isForward ? 0.5 : 1.0,
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Opacity(
              opacity: isForward ? 0.5 : 1.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? modeColor.withValues(alpha: 0.10)
                      : _LabPalette.card,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isActive
                        ? modeColor
                        : _LabPalette.chromeBorder,
                    width: isActive ? 2.0 : 1.0,
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.link,
                      size: 14,
                      color: modeColor,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            entry.label,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: _LabPalette.chromeInk,
                              decoration: isForward
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          Text(
                            entry.path,
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 11,
                              color: _LabPalette.chromeMutedInk,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildModeBadge(entry.createdByMode),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 70,
            child: isActive
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('👆', style: TextStyle(fontSize: 12)),
                      const SizedBox(width: 4),
                      Text(
                        'cursor',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: modeColor,
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildSequenceDiagram() {
    final RouteInformationReportingType? lastMode = _lastActionMode;
    final Color c = lastMode == null
        ? _LabPalette.chromeMutedInk
        : _colorForMode(lastMode);
    final String label = lastMode == null
        ? 'no action yet'
        : 'last action: ${_modeName(lastMode)}';
    final String urlArrowText = lastMode == null
        ? '—'
        : (lastMode == RouteInformationReportingType.none
              ? 'suppress'
              : 'update');
    final String historyArrowText = lastMode == null
        ? '—'
        : (switch (lastMode) {
            RouteInformationReportingType.none => 'no-op',
            RouteInformationReportingType.neglect => 'replace top',
            RouteInformationReportingType.navigate => 'push',
          });
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: c.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Sequence diagram',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: _LabPalette.chromeMutedInk,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: c,
            ),
          ),
          const SizedBox(height: 14),
          _buildDiagramBox('Router', c),
          _buildDiagramArrow('routeInformationReportingType = ${lastMode == null ? '—' : _modeName(lastMode)}', c),
          _buildDiagramBox('RouteInformationProvider', c),
          _buildDiagramArrow('URL bar: $urlArrowText', c),
          _buildDiagramBox('Platform URL bar', c),
          _buildDiagramArrow('History: $historyArrowText', c),
          _buildDiagramBox('Browser history stack', c),
        ],
      ),
    );
  }

  Widget _buildDiagramBox(String label, Color c) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: _LabPalette.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: c.withValues(alpha: 0.6)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: c,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _LabPalette.chromeInk,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiagramArrow(String label, Color c) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 14),
      child: Row(
        children: <Widget>[
          Container(
            width: 2,
            height: 18,
            color: c.withValues(alpha: 0.6),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontStyle: FontStyle.italic,
                color: c,
              ),
            ),
          ),
          Icon(Icons.arrow_downward, size: 14, color: c),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 5 — Timeline log.
  // ---------------------------------------------------------------------------

  Widget _buildTimelineLog() {
    return Card(
      elevation: 1,
      color: _LabPalette.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: _LabPalette.chromeBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _SectionHeader(
              number: 5,
              title: 'Timeline log',
              subtitle:
                  'The 20 most recent actions, colour-coded by reporting mode.',
            ),
            const SizedBox(height: 14),
            Container(
              height: 240,
              decoration: BoxDecoration(
                color: _LabPalette.chromeTitleBar.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _LabPalette.chromeBorder),
              ),
              child: _timeline.isEmpty
                  ? const Center(
                      child: Text(
                        'no events yet',
                        style: TextStyle(
                          fontSize: 12,
                          color: _LabPalette.chromeMutedInk,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      itemCount: _timeline.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 4),
                      itemBuilder: (BuildContext context, int i) =>
                          _buildTimelineTile(_timeline[i]),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineTile(_TimelineEntry entry) {
    final Color c = _colorForMode(entry.mode);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: c.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: <Widget>[
          Text(
            _formatTime(entry.timestamp),
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: _LabPalette.chromeMutedInk,
            ),
          ),
          const SizedBox(width: 10),
          Text('·',
              style: TextStyle(color: _LabPalette.chromeMutedInk, fontSize: 12)),
          const SizedBox(width: 10),
          Text(
            'mode=${_modeName(entry.mode)}',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: c,
            ),
          ),
          const SizedBox(width: 10),
          Text('·',
              style: TextStyle(color: _LabPalette.chromeMutedInk, fontSize: 12)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              entry.actionDescription,
              style: const TextStyle(
                fontSize: 12,
                color: _LabPalette.chromeInk,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            _modeSymbol(entry.mode),
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 6 — Teaching panel.
  // ---------------------------------------------------------------------------

  Widget _buildTeachingPanel() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: _LabPalette.teachingPanel,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _LabPalette.teachingPanel.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.school_outlined,
                color: _LabPalette.teachingInk.withValues(alpha: 0.9),
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                '6 · Teaching panel',
                style: TextStyle(
                  color: _LabPalette.teachingInk,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildComparisonTable(),
          const SizedBox(height: 18),
          _buildCodeBlock(),
          const SizedBox(height: 18),
          _buildScenarioList(),
        ],
      ),
    );
  }

  Widget _buildComparisonTable() {
    const List<_TableRow> rows = <_TableRow>[
      _TableRow(
        question: 'URL bar updates?',
        none: 'no',
        neglect: 'yes',
        navigate: 'yes',
      ),
      _TableRow(
        question: 'History pushed?',
        none: 'no',
        neglect: 'replaced (top)',
        navigate: 'yes (pushed)',
      ),
      _TableRow(
        question: 'Back button creates entry?',
        none: 'n/a — no change',
        neglect: 'no (top replaced)',
        navigate: 'yes',
      ),
      _TableRow(
        question: 'Typical use case',
        none: 'internal nav already reported by route itself',
        neglect: 'search queries, tab swaps, undo-able local state',
        navigate: 'user-driven navigation (link tap, menu)',
      ),
      _TableRow(
        question: 'Example flutter API',
        none: 'Router.neglect(context, …)',
        neglect: 'Router.neglect() + report=true',
        navigate: 'Router.navigate(context, …)',
      ),
    ];
    return Container(
      decoration: BoxDecoration(
        color: _LabPalette.teachingPanel.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: _LabPalette.teachingInk.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        children: <Widget>[
          _buildTableHeader(),
          for (final _TableRow row in rows) _buildTableRow(row),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _LabPalette.teachingPanel.withValues(alpha: 0.95),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        border: Border(
          bottom: BorderSide(
            color: _LabPalette.teachingInk.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              'question',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: _LabPalette.teachingInk.withValues(alpha: 0.7),
                letterSpacing: 0.5,
              ),
            ),
          ),
          _buildTableHeaderCell('none', _LabPalette.slateNone),
          _buildTableHeaderCell('neglect', _LabPalette.amberNeglect),
          _buildTableHeaderCell('navigate', _LabPalette.greenNavigate),
        ],
      ),
    );
  }

  Widget _buildTableHeaderCell(String label, Color c) {
    return Expanded(
      flex: 2,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: c.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: c.withValues(alpha: 0.6)),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: c,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTableRow(_TableRow row) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: _LabPalette.teachingInk.withValues(alpha: 0.08),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              row.question,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _LabPalette.teachingInk.withValues(alpha: 0.9),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              row.none,
              style: TextStyle(
                fontSize: 11,
                color: _LabPalette.teachingInk.withValues(alpha: 0.8),
                height: 1.35,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              row.neglect,
              style: TextStyle(
                fontSize: 11,
                color: _LabPalette.teachingInk.withValues(alpha: 0.8),
                height: 1.35,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              row.navigate,
              style: TextStyle(
                fontSize: 11,
                color: _LabPalette.teachingInk.withValues(alpha: 0.8),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeBlock() {
    const String code =
        '// Reading / setting the reporting mode on a Router:\n'
        '//\n'
        'Router.of(context).routeInformationReportingType\n'
        '\n'
        '// Via a RouterConfig when constructing MaterialApp.router:\n'
        'MaterialApp.router(\n'
        '  routerConfig: RouterConfig<Object>(\n'
        '    routeInformationProvider: myProvider,\n'
        '    routeInformationParser: myParser,\n'
        '    routerDelegate: myDelegate,\n'
        '    // not a direct field — Router chooses the mode when calling\n'
        '    // RouteInformationProvider.routerReportsNewRouteInformation.\n'
        '  ),\n'
        ')\n'
        '\n'
        '// Called by Router on route change:\n'
        'provider.routerReportsNewRouteInformation(\n'
        '  info,\n'
        '  type: RouteInformationReportingType.navigate,\n'
        ');';
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _LabPalette.codeBlock,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: _LabPalette.teachingInk.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.code,
                size: 14,
                color: _LabPalette.codeInk.withValues(alpha: 0.7),
              ),
              const SizedBox(width: 6),
              Text(
                'setting the mode',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  color: _LabPalette.codeInk.withValues(alpha: 0.75),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const SelectableText(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: _LabPalette.codeInk,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScenarioList() {
    const List<_Scenario> scenarios = <_Scenario>[
      _Scenario(
        mode: RouteInformationReportingType.none,
        text:
            'A bottom-sheet inline filter updates local UI state only — no URL '
            'change. The route itself already reported its path once.',
      ),
      _Scenario(
        mode: RouteInformationReportingType.neglect,
        text:
            'Typing in a search box updates the `?q=` query in the URL but '
            'should NOT pollute history with every keystroke.',
      ),
      _Scenario(
        mode: RouteInformationReportingType.navigate,
        text:
            'User taps a link to /articles/42. A new history entry is pushed '
            'so Back returns to the previous article list.',
      ),
      _Scenario(
        mode: RouteInformationReportingType.neglect,
        text:
            'Tab swap inside a dashboard: URL changes to reflect the current '
            'tab, but Back should not step through each tab you visited.',
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          'real-world scenarios',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: _LabPalette.teachingInk.withValues(alpha: 0.7),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 10),
        for (final _Scenario s in scenarios) _buildScenarioBullet(s),
      ],
    );
  }

  Widget _buildScenarioBullet(_Scenario s) {
    final Color c = _colorForMode(s.mode);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: c,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: c.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              _modeName(s.mode),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: c,
                letterSpacing: 0.4,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              s.text,
              style: TextStyle(
                fontSize: 12,
                height: 1.4,
                color: _LabPalette.teachingInk.withValues(alpha: 0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helpers.
  // ---------------------------------------------------------------------------

  String _formatTime(DateTime dt) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(dt.hour)}:${two(dt.minute)}:${two(dt.second)}';
  }
}

// =============================================================================
// Small helper classes + widgets.
// =============================================================================

class _TableRow {
  const _TableRow({
    required this.question,
    required this.none,
    required this.neglect,
    required this.navigate,
  });

  final String question;
  final String none;
  final String neglect;
  final String navigate;
}

class _Scenario {
  const _Scenario({required this.mode, required this.text});

  final RouteInformationReportingType mode;
  final String text;
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.number,
    required this.title,
    required this.subtitle,
  });

  final int number;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _LabPalette.chromeInk,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '$number',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: _LabPalette.chromeInk,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: _LabPalette.chromeMutedInk,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

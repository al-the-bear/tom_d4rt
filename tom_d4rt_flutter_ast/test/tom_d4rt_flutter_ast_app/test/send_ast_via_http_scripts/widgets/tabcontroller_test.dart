// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// =====================================================================
// TabController — Visual Deep Demo (static snapshot edition)
// =====================================================================
//
// TabController is a *live* controller that ties together a TabBar
// (the row of tabs) and a TabBarView (the swipeable content area).
// In normal Flutter code you would either:
//
//   (a) Wrap your subtree in a `DefaultTabController(length: N)` and let
//       Flutter create and manage the controller for you, or
//
//   (b) Construct a `TabController(length: N, vsync: this)` from inside
//       a State that mixes in `SingleTickerProviderStateMixin`, hold it
//       across the State's lifecycle, and dispose it when the State
//       unmounts.
//
// Because this demo file is a *static snapshot* — rendered exactly
// once, with no setState, no async, no AnimationController, no Timer,
// no Stream — we deliberately do NOT instantiate a TabController
// directly. We use a small live `DefaultTabController` only for the
// hands-on demo card (it manages its own internal controller and does
// not require the demo to thread vsync or dispose anything). Every
// other section paints hand-drawn diagrams of what the controller's
// API does.
//
// Sections (top → bottom):
//   1.  Hero / Title card
//   2.  Anatomy of the TabController constructor
//   3.  Live DefaultTabController demo (4 tabs, real TabBar+TabBarView)
//   4.  Animation timeline visual (300 ms slide from tab 0 to tab 1)
//   5.  index vs animation.value vs previousIndex explainer
//   6.  indexIsChanging callout
//   7.  addListener pattern card
//   8.  The TabController · TabBar · TabBarView triad
//   9.  DefaultTabController vs explicit TabController
//  10.  vsync — TickerProvider requirement
//  11.  animationDuration — slow vs default vs snappy
//  12.  animateTo signature card
//  13.  Common pitfalls
//  14.  Footer
//
// Visual language: cards, soft shadows, indigo / teal / amber accents,
// monospace where we want to evoke source code.
//
// This file is hand-authored to be analyzer-clean and long enough to
// serve as a documentation poster for TabController.
// =====================================================================

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------
// Color palette — declared once so every section reads consistently.
// ---------------------------------------------------------------------

const Color _kInk = Color(0xFF1A1F36);
const Color _kInkSoft = Color(0xFF4A5072);
const Color _kPaper = Color(0xFFF7F8FC);
const Color _kPaperWarm = Color(0xFFFDF9F2);
const Color _kIndigo = Color(0xFF4F46E5);
const Color _kIndigoSoft = Color(0xFFE0E7FF);
const Color _kTeal = Color(0xFF0D9488);
const Color _kTealSoft = Color(0xFFCCFBF1);
const Color _kAmber = Color(0xFFD97706);
const Color _kAmberSoft = Color(0xFFFEF3C7);
const Color _kRose = Color(0xFFE11D48);
const Color _kRoseSoft = Color(0xFFFFE4E6);
const Color _kEmerald = Color(0xFF059669);
const Color _kEmeraldSoft = Color(0xFFD1FAE5);
const Color _kSlate = Color(0xFF334155);
const Color _kSlateSoft = Color(0xFFE2E8F0);
const Color _kViolet = Color(0xFF7C3AED);
const Color _kVioletSoft = Color(0xFFEDE9FE);

// ---------------------------------------------------------------------
// Entry point — required signature.
// ---------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    title: 'TabController — Visual Deep Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: _kPaper,
      fontFamily: 'Roboto',
      colorScheme: ColorScheme.fromSeed(
        seedColor: _kIndigo,
        brightness: Brightness.light,
      ),
    ),
    home: Scaffold(
      backgroundColor: _kPaper,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _heroSection(),
              const SizedBox(height: 36),
              _anatomySection(),
              const SizedBox(height: 36),
              _liveDemoSection(),
              const SizedBox(height: 36),
              _timelineSection(),
              const SizedBox(height: 36),
              _indexExplainerSection(),
              const SizedBox(height: 36),
              _indexIsChangingSection(),
              const SizedBox(height: 36),
              _addListenerSection(),
              const SizedBox(height: 36),
              _triadSection(),
              const SizedBox(height: 36),
              _defaultVsExplicitSection(),
              const SizedBox(height: 36),
              _vsyncSection(),
              const SizedBox(height: 36),
              _animationDurationSection(),
              const SizedBox(height: 36),
              _animateToSection(),
              const SizedBox(height: 36),
              _pitfallsSection(),
              const SizedBox(height: 36),
              _footerSection(),
            ],
          ),
        ),
      ),
    ),
  );
}

// =====================================================================
// 1. HERO
// =====================================================================

Widget _heroSection() {
  return Container(
    padding: const EdgeInsets.all(36),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          _kIndigo,
          _kIndigo.withValues(alpha: 0.82),
          _kViolet.withValues(alpha: 0.78),
        ],
      ),
      borderRadius: BorderRadius.circular(28),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kIndigo.withValues(alpha: 0.30),
          blurRadius: 28,
          offset: const Offset(0, 14),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.40),
                ),
              ),
              child: const Text(
                'flutter / material',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'monospace',
                  letterSpacing: 0.6,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.40),
                ),
              ),
              child: const Text(
                'controller · ChangeNotifier · Listenable',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'monospace',
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        const Text(
          'TabController',
          style: TextStyle(
            color: Colors.white,
            fontSize: 56,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.6,
            height: 1.0,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Coordinates the selected tab between a TabBar and a TabBarView.\n'
          'Owns an Animation<double> that drives the indicator slide and\n'
          'the page transition in lockstep.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.94),
            fontSize: 18,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: <Widget>[
            _heroBadge('length', 'int'),
            _heroBadge('initialIndex', 'int'),
            _heroBadge('vsync', 'TickerProvider'),
            _heroBadge('animationDuration', 'Duration?'),
            _heroBadge('index', 'int'),
            _heroBadge('animation', 'Animation<double>?'),
          ],
        ),
      ],
    ),
  );
}

Widget _heroBadge(String label, String type) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.16),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.white.withValues(alpha: 0.30)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(width: 8),
        Text(
          type,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.78),
            fontSize: 12,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// 2. ANATOMY OF THE CONSTRUCTOR
// =====================================================================

Widget _anatomySection() {
  return _sectionShell(
    accent: _kIndigo,
    accentSoft: _kIndigoSoft,
    eyebrow: 'section · 02',
    title: 'Anatomy of the constructor',
    subtitle:
        'TabController takes four constructor arguments. length and vsync '
        'are required; initialIndex and animationDuration are optional.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _kInk,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Text(
            "TabController({\n"
            "  int             initialIndex      = 0,\n"
            "  Duration?       animationDuration,           // default 300ms\n"
            "  required int    length,\n"
            "  required TickerProvider vsync,\n"
            "})",
            style: TextStyle(
              color: Color(0xFFE2E8F0),
              fontSize: 14,
              height: 1.55,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _argCard(
                'length',
                'int (required)',
                'Total number of tabs. Must equal both the number of '
                    'TabBar.tabs and the number of TabBarView.children. A '
                    'mismatch is a runtime error.',
                _kIndigo,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _argCard(
                'initialIndex',
                'int = 0',
                'The tab that is selected when the controller is created. '
                    'Must be in [0, length). Setting it later is done via '
                    'animateTo or by assigning to index.',
                _kTeal,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _argCard(
                'vsync',
                'TickerProvider',
                'Source of the animation Ticker. Almost always `this`, '
                    'where `this` is a State that mixes in '
                    'SingleTickerProviderStateMixin.',
                _kAmber,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _argCard(
                'animationDuration',
                'Duration?',
                'How long animateTo / programmatic index changes take. '
                    'Defaults to kTabScrollDuration (300 ms). Pass '
                    'Duration.zero to disable animations.',
                _kRose,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        _calloutBar(
          accent: _kIndigo,
          accentSoft: _kIndigoSoft,
          icon: Icons.info_outline,
          title: 'Constructed inside a State',
          body: 'The controller must outlive its TabBar / TabBarView and be '
              'disposed in State.dispose(). Anywhere you would otherwise '
              'create one yourself, ask first if DefaultTabController would '
              'do — it usually does.',
        ),
      ],
    ),
  );
}

Widget _argCard(String name, String type, String body, Color accent) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: accent.withValues(alpha: 0.25)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.08),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            type,
            style: TextStyle(
              color: accent,
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            color: _kInk,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          body,
          style: const TextStyle(
            color: _kInkSoft,
            fontSize: 12.5,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// 3. LIVE DEMO — DefaultTabController + TabBar + TabBarView
// =====================================================================
//
// We wire up a *real* DefaultTabController here. It manages its own
// controller internally; we never have to call `new TabController(...)`
// nor dispose anything. This is the only section in the file that
// renders an interactive widget — everything else is hand-painted.
// =====================================================================

Widget _liveDemoSection() {
  return _sectionShell(
    accent: _kTeal,
    accentSoft: _kTealSoft,
    eyebrow: 'section · 03',
    title: 'Live: DefaultTabController · 4 tabs',
    subtitle:
        'A working TabBar + TabBarView, hosted by DefaultTabController. '
        'The controller is created and disposed for us; we just describe '
        'the shape of our UI.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kPaperWarm,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kTeal.withValues(alpha: 0.25)),
          ),
          child: DefaultTabController(
            length: 4,
            initialIndex: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  elevation: 0,
                  child: const TabBar(
                    labelColor: _kTeal,
                    unselectedLabelColor: _kInkSoft,
                    indicatorColor: _kTeal,
                    indicatorWeight: 3,
                    tabs: <Widget>[
                      Tab(text: 'Inbox', icon: Icon(Icons.inbox_outlined)),
                      Tab(text: 'Drafts', icon: Icon(Icons.edit_outlined)),
                      Tab(text: 'Sent', icon: Icon(Icons.send_outlined)),
                      Tab(
                        text: 'Spam',
                        icon: Icon(Icons.report_gmailerrorred_outlined),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 220,
                  child: TabBarView(
                    children: <Widget>[
                      _demoPage(
                        accent: _kIndigo,
                        title: 'Inbox',
                        body: '24 unread messages',
                        icon: Icons.inbox_outlined,
                      ),
                      _demoPage(
                        accent: _kAmber,
                        title: 'Drafts',
                        body: '3 unfinished drafts',
                        icon: Icons.edit_outlined,
                      ),
                      _demoPage(
                        accent: _kEmerald,
                        title: 'Sent',
                        body: '127 sent this month',
                        icon: Icons.send_outlined,
                      ),
                      _demoPage(
                        accent: _kRose,
                        title: 'Spam',
                        body: '8 quarantined senders',
                        icon: Icons.report_gmailerrorred_outlined,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _factCard(
                accent: _kTeal,
                label: 'length',
                value: '4',
                helper: 'Number of tabs and panels.',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _factCard(
                accent: _kIndigo,
                label: 'initialIndex',
                value: '0',
                helper: 'Inbox is selected on first build.',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _factCard(
                accent: _kAmber,
                label: 'vsync',
                value: 'auto',
                helper: 'DefaultTabController provides its own.',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _factCard(
                accent: _kRose,
                label: 'duration',
                value: '300 ms',
                helper: 'kTabScrollDuration default.',
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _demoPage({
  required Color accent,
  required String title,
  required String body,
  required IconData icon,
}) {
  return Container(
    margin: const EdgeInsets.all(8),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: accent.withValues(alpha: 0.30)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.10),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: accent, size: 36),
        ),
        const SizedBox(height: 14),
        Text(
          title,
          style: TextStyle(
            color: accent,
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          body,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: _kInkSoft,
            fontSize: 13.5,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

Widget _factCard({
  required Color accent,
  required String label,
  required String value,
  required String helper,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accent.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            color: accent,
            fontSize: 11,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w800,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: _kInk,
            fontSize: 22,
            fontWeight: FontWeight.w900,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          helper,
          style: const TextStyle(
            color: _kInkSoft,
            fontSize: 11.5,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// 4. ANIMATION TIMELINE (300ms slide from tab 0 → tab 1)
// =====================================================================

Widget _timelineSection() {
  return _sectionShell(
    accent: _kAmber,
    accentSoft: _kAmberSoft,
    eyebrow: 'section · 04',
    title: 'Animation timeline · tab 0 → tab 1',
    subtitle:
        'When animateTo(1) is called, the controller drives an internal '
        'animation from 0.0 → 1.0 over animationDuration. Here are five '
        'frozen frames at 0%, 25%, 50%, 75%, 100% of that 300 ms.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _timelineRuler(),
        const SizedBox(height: 14),
        Row(
          children: <Widget>[
            Expanded(child: _timelineFrame(0.0, '0 ms', '0.00')),
            const SizedBox(width: 8),
            Expanded(child: _timelineFrame(0.25, '75 ms', '0.25')),
            const SizedBox(width: 8),
            Expanded(child: _timelineFrame(0.50, '150 ms', '0.50')),
            const SizedBox(width: 8),
            Expanded(child: _timelineFrame(0.75, '225 ms', '0.75')),
            const SizedBox(width: 8),
            Expanded(child: _timelineFrame(1.0, '300 ms', '1.00')),
          ],
        ),
        const SizedBox(height: 18),
        _calloutBar(
          accent: _kAmber,
          accentSoft: _kAmberSoft,
          icon: Icons.timer_outlined,
          title: 'animation.value · double in [0.0, length-1]',
          body: 'The animation reports the controller\'s position as a '
              'double. While the indicator slides from tab 0 to tab 1, '
              'animation.value sweeps from 0.0 to 1.0. Going from tab 1 '
              'to tab 3 would sweep from 1.0 to 3.0.',
        ),
      ],
    ),
  );
}

Widget _timelineRuler() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
    decoration: BoxDecoration(
      color: _kAmberSoft.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: <Widget>[
        const Icon(Icons.flag_outlined, color: _kAmber, size: 16),
        const SizedBox(width: 8),
        const Text(
          'animation.value',
          style: TextStyle(
            color: _kAmber,
            fontSize: 12,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w800,
          ),
        ),
        const Spacer(),
        const Text(
          'duration: 300 ms (kTabScrollDuration)',
          style: TextStyle(
            color: _kAmber,
            fontSize: 11.5,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _timelineFrame(double value, String time, String valueLabel) {
  // Each frame is a tiny representation of two tab labels with a sliding
  // indicator at horizontal position `value` (0..1).
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kAmber.withValues(alpha: 0.35)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: _kAmberSoft,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            time,
            style: const TextStyle(
              color: _kAmber,
              fontSize: 10,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Mini TabBar
        SizedBox(
          height: 22,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Text(
                    'A',
                    style: TextStyle(
                      color: value < 0.5 ? _kInk : _kInkSoft,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'B',
                    style: TextStyle(
                      color: value > 0.5 ? _kInk : _kInkSoft,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        // Indicator track + sliding indicator.
        SizedBox(
          height: 6,
          child: Stack(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: _kSlateSoft,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.5,
                alignment: Alignment(-1.0 + value * 2.0, 0.0),
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: _kAmber,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          valueLabel,
          style: const TextStyle(
            color: _kInk,
            fontSize: 13,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          'animation.value',
          style: TextStyle(
            color: _kInkSoft,
            fontSize: 9.5,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// 5. INDEX vs animation.value vs previousIndex
// =====================================================================

Widget _indexExplainerSection() {
  return _sectionShell(
    accent: _kEmerald,
    accentSoft: _kEmeraldSoft,
    eyebrow: 'section · 05',
    title: 'index · animation.value · previousIndex',
    subtitle:
        'Three values, three concepts. They look similar and are easy to '
        'confuse. Here is what each one tells you and when it changes.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _bigConceptCard(
                accent: _kEmerald,
                label: 'index',
                type: 'int',
                snapshot: '1',
                description:
                    'The currently selected tab. An integer in [0, length). '
                    'Updates immediately when animateTo or setter assignment '
                    'starts the transition — not when it ends.',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _bigConceptCard(
                accent: _kAmber,
                label: 'animation.value',
                type: 'double',
                snapshot: '0.62',
                description:
                    'The interpolated position. While the indicator slides '
                    'from 0 to 1 it sweeps through 0.0 → 1.0. Useful for '
                    'driving fade / parallax effects in sync.',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _bigConceptCard(
                accent: _kIndigo,
                label: 'previousIndex',
                type: 'int',
                snapshot: '0',
                description:
                    'The tab the controller was on before the current '
                    'transition started. Equals index when no transition '
                    'is in progress.',
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        _timelineTable(),
      ],
    ),
  );
}

Widget _bigConceptCard({
  required Color accent,
  required String label,
  required String type,
  required String snapshot,
  required String description,
}) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: accent.withValues(alpha: 0.30)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.10),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                type,
                style: TextStyle(
                  color: accent,
                  fontSize: 11,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const Spacer(),
            Text(
              snapshot,
              style: TextStyle(
                color: accent,
                fontSize: 24,
                fontWeight: FontWeight.w900,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(
            color: _kInk,
            fontSize: 18,
            fontWeight: FontWeight.w900,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(
            color: _kInkSoft,
            fontSize: 12.5,
            height: 1.55,
          ),
        ),
      ],
    ),
  );
}

Widget _timelineTable() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kPaperWarm,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _kEmerald.withValues(alpha: 0.20)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Snapshot · animateTo(2) called from index 0',
          style: TextStyle(
            color: _kInk,
            fontSize: 14,
            fontWeight: FontWeight.w900,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(child: _timelineHeader('moment')),
            Expanded(child: _timelineHeader('index')),
            Expanded(child: _timelineHeader('previousIndex')),
            Expanded(child: _timelineHeader('animation.value')),
            Expanded(child: _timelineHeader('indexIsChanging')),
          ],
        ),
        const SizedBox(height: 6),
        _timelineRow('before call', '0', '0', '0.00', 'false'),
        _timelineRow('+0 ms', '2', '0', '0.00', 'true'),
        _timelineRow('+75 ms', '2', '0', '0.50', 'true'),
        _timelineRow('+150 ms', '2', '0', '1.00', 'true'),
        _timelineRow('+225 ms', '2', '0', '1.50', 'true'),
        _timelineRow('+300 ms (end)', '2', '0', '2.00', 'false'),
      ],
    ),
  );
}

Widget _timelineHeader(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Text(
      text,
      style: const TextStyle(
        color: _kEmerald,
        fontSize: 11,
        fontFamily: 'monospace',
        fontWeight: FontWeight.w800,
        letterSpacing: 0.4,
      ),
    ),
  );
}

Widget _timelineRow(
  String moment,
  String index,
  String prev,
  String value,
  String changing,
) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 6),
    decoration: const BoxDecoration(
      border: Border(
        top: BorderSide(color: _kSlateSoft, width: 1),
      ),
    ),
    child: Row(
      children: <Widget>[
        Expanded(child: _timelineCell(moment, _kInkSoft)),
        Expanded(child: _timelineCell(index, _kInk)),
        Expanded(child: _timelineCell(prev, _kInk)),
        Expanded(child: _timelineCell(value, _kAmber)),
        Expanded(
          child: _timelineCell(
            changing,
            changing == 'true' ? _kRose : _kEmerald,
          ),
        ),
      ],
    ),
  );
}

Widget _timelineCell(String text, Color color) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: 12.5,
      fontFamily: 'monospace',
      fontWeight: FontWeight.w700,
    ),
  );
}

// =====================================================================
// 6. indexIsChanging
// =====================================================================

Widget _indexIsChangingSection() {
  return _sectionShell(
    accent: _kRose,
    accentSoft: _kRoseSoft,
    eyebrow: 'section · 06',
    title: 'indexIsChanging · the in-flight flag',
    subtitle:
        'A boolean that is true while a programmatic animation is in '
        'flight. Useful for distinguishing user-driven swipes from '
        'programmatic transitions inside listeners.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _kInk,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Text(
            "controller.addListener(() {\n"
            "  if (controller.indexIsChanging) {\n"
            "    // animateTo / setter is mid-flight\n"
            "    return;\n"
            "  }\n"
            "  // user finished a swipe, or animation just settled\n"
            "  recordTabVisit(controller.index);\n"
            "});",
            style: TextStyle(
              color: Color(0xFFE2E8F0),
              fontSize: 13,
              height: 1.6,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: <Widget>[
            Expanded(
              child: _stateChip(
                color: _kEmerald,
                colorSoft: _kEmeraldSoft,
                title: 'false · idle',
                body:
                    'Steady state. index has not been programmatically set '
                    'this frame. animation.value is integer-valued and '
                    'previousIndex == index.',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _stateChip(
                color: _kRose,
                colorSoft: _kRoseSoft,
                title: 'true · in flight',
                body:
                    'A programmatic transition is running. animation.value '
                    'sweeps between previousIndex and index. The flag '
                    'flips back to false on AnimationStatus.completed.',
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        _calloutBar(
          accent: _kRose,
          accentSoft: _kRoseSoft,
          icon: Icons.swipe_outlined,
          title: 'Swipes are not "changing"',
          body: 'When the user drags TabBarView with their finger, '
              'indexIsChanging stays false. The flag only marks '
              '*programmatic* changes initiated by animateTo or by '
              'assigning to controller.index.',
        ),
      ],
    ),
  );
}

Widget _stateChip({
  required Color color,
  required Color colorSoft,
  required String title,
  required String body,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: colorSoft.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withValues(alpha: 0.30)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          body,
          style: const TextStyle(
            color: _kInk,
            fontSize: 12.5,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// 7. addListener pattern card
// =====================================================================

Widget _addListenerSection() {
  return _sectionShell(
    accent: _kViolet,
    accentSoft: _kVioletSoft,
    eyebrow: 'section · 07',
    title: 'addListener · React to tab changes',
    subtitle:
        'TabController is a ChangeNotifier. Subscribe with addListener to '
        'be notified whenever index, animation.value, or any other '
        'observable state changes.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _kInk,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Text(
            "@override\n"
            "void initState() {\n"
            "  super.initState();\n"
            "  _controller = TabController(length: 4, vsync: this);\n"
            "  _controller.addListener(_onTabChanged);\n"
            "}\n"
            "\n"
            "@override\n"
            "void dispose() {\n"
            "  _controller.removeListener(_onTabChanged);\n"
            "  _controller.dispose();\n"
            "  super.dispose();\n"
            "}\n"
            "\n"
            "void _onTabChanged() {\n"
            "  if (!_controller.indexIsChanging) return;\n"
            "  analytics.logTabSelected(_controller.index);\n"
            "}",
            style: TextStyle(
              color: Color(0xFFE2E8F0),
              fontSize: 12.5,
              height: 1.55,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _ruleCard(
                accent: _kViolet,
                ordinal: '1',
                rule: 'Listener fires for every tick',
                detail:
                    'Because the controller exposes animation.value as '
                    'observable state, listeners fire many times per '
                    'transition. Throttle inside the callback.',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ruleCard(
                accent: _kIndigo,
                ordinal: '2',
                rule: 'Always remove what you add',
                detail:
                    'Pair every addListener with a removeListener in '
                    'dispose. The controller will dispose anyway, but '
                    'leaks creep in when listeners reference State.',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ruleCard(
                accent: _kEmerald,
                ordinal: '3',
                rule: 'Filter on indexIsChanging',
                detail:
                    'If you only want to react when the selected tab '
                    'truly changes (not on every animation tick), guard '
                    'with controller.indexIsChanging.',
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _ruleCard({
  required Color accent,
  required String ordinal,
  required String rule,
  required String detail,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: accent.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            ordinal,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w900,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          rule,
          style: const TextStyle(
            color: _kInk,
            fontSize: 14.5,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          detail,
          style: const TextStyle(
            color: _kInkSoft,
            fontSize: 12,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// 8. THE TRIAD: TabController · TabBar · TabBarView
// =====================================================================

Widget _triadSection() {
  return _sectionShell(
    accent: _kIndigo,
    accentSoft: _kIndigoSoft,
    eyebrow: 'section · 08',
    title: 'The triad · controller · TabBar · TabBarView',
    subtitle:
        'TabController is the single source of truth. TabBar paints the '
        'header, TabBarView paints the body. Both read from and write to '
        'the same controller.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _kPaperWarm,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _kIndigo.withValues(alpha: 0.20)),
          ),
          child: Column(
            children: <Widget>[
              _triadNode(
                color: _kIndigo,
                title: 'TabController',
                subtitle: 'index · animation · indexIsChanging',
                icon: Icons.developer_board_outlined,
              ),
              const SizedBox(height: 14),
              _triadArrows(),
              const SizedBox(height: 14),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _triadNode(
                      color: _kTeal,
                      title: 'TabBar',
                      subtitle: 'header · taps · indicator',
                      icon: Icons.tab_outlined,
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: _triadNode(
                      color: _kAmber,
                      title: 'TabBarView',
                      subtitle: 'body · swipes · pages',
                      icon: Icons.view_carousel_outlined,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _flowCard(
                accent: _kTeal,
                title: 'User taps a Tab',
                steps: <String>[
                  'TabBar receives the tap.',
                  'TabBar calls controller.animateTo(i).',
                  'Controller animates index, fires listeners.',
                  'TabBarView observes the controller and slides.',
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _flowCard(
                accent: _kAmber,
                title: 'User swipes the body',
                steps: <String>[
                  'TabBarView gets the drag gesture.',
                  'It moves controller.offset directly.',
                  'On settle, controller snaps to nearest int.',
                  'TabBar redraws the indicator from controller.',
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        _calloutBar(
          accent: _kIndigo,
          accentSoft: _kIndigoSoft,
          icon: Icons.link,
          title: 'One controller — many listeners',
          body: 'Both TabBar and TabBarView find the controller via '
              'their `controller:` parameter or, when not given, via '
              'DefaultTabController.of(context). Either both look up '
              'the same controller, or you pass it explicitly to both.',
        ),
      ],
    ),
  );
}

Widget _triadNode({
  required Color color,
  required String title,
  required String subtitle,
  required IconData icon,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withValues(alpha: 0.35)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.10),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: _kInk,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  color: _kInkSoft,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _triadArrows() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      _arrowLabel('drives', _kTeal),
      const SizedBox(width: 24),
      _arrowLabel('drives', _kAmber),
    ],
  );
}

Widget _arrowLabel(String label, Color color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Icon(Icons.south, color: color, size: 18),
      const SizedBox(width: 6),
      Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w800,
        ),
      ),
    ],
  );
}

Widget _flowCard({
  required Color accent,
  required String title,
  required List<String> steps,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: accent.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: accent,
            fontSize: 14,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 10),
        for (int i = 0; i < steps.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 18,
                  height: 18,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 1, right: 8),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      color: accent,
                      fontSize: 10,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    steps[i],
                    style: const TextStyle(
                      color: _kInk,
                      fontSize: 12.5,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

// =====================================================================
// 9. DefaultTabController vs explicit TabController
// =====================================================================

Widget _defaultVsExplicitSection() {
  return _sectionShell(
    accent: _kTeal,
    accentSoft: _kTealSoft,
    eyebrow: 'section · 09',
    title: 'DefaultTabController vs explicit TabController',
    subtitle:
        'Two ways to wire up the controller. Choose the simpler one '
        'unless you have a real reason to manage the controller yourself.',
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _comparisonColumn(
            accent: _kEmerald,
            heading: 'DefaultTabController',
            tagline: 'Inherited widget · zero boilerplate',
            code:
                "DefaultTabController(\n"
                "  length: 4,\n"
                "  initialIndex: 0,\n"
                "  child: Scaffold(\n"
                "    appBar: AppBar(\n"
                "      bottom: TabBar(tabs: [...]),\n"
                "    ),\n"
                "    body: TabBarView(children: [...]),\n"
                "  ),\n"
                ")",
            bullets: <String>[
              'No State · no vsync · no dispose.',
              'TabBar / TabBarView find it via context.',
              'Best for static tab counts and stateless screens.',
              'Cannot be reached from outside the subtree.',
            ],
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _comparisonColumn(
            accent: _kIndigo,
            heading: 'TabController (explicit)',
            tagline: 'Stateful · full control',
            code:
                "class _S extends State<X>\n"
                "    with SingleTickerProviderStateMixin {\n"
                "  late final TabController c;\n"
                "  @override void initState() {\n"
                "    super.initState();\n"
                "    c = TabController(length: 4, vsync: this);\n"
                "  }\n"
                "  @override void dispose() {\n"
                "    c.dispose();\n"
                "    super.dispose();\n"
                "  }\n"
                "}",
            bullets: <String>[
              'You hold the reference and call animateTo / index =.',
              'Required when you need addListener for analytics.',
              'Required when length depends on dynamic state.',
              'Must dispose · must provide vsync.',
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _comparisonColumn({
  required Color accent,
  required String heading,
  required String tagline,
  required String code,
  required List<String> bullets,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: accent.withValues(alpha: 0.30)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              heading,
              style: TextStyle(
                color: accent,
                fontSize: 16,
                fontWeight: FontWeight.w900,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          tagline,
          style: const TextStyle(
            color: _kInkSoft,
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kInk,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            code,
            style: const TextStyle(
              color: Color(0xFFE2E8F0),
              fontSize: 12,
              height: 1.55,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 12),
        for (final String b in bullets)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 4, right: 8),
                  child: Icon(Icons.circle, size: 6, color: accent),
                ),
                Expanded(
                  child: Text(
                    b,
                    style: const TextStyle(
                      color: _kInk,
                      fontSize: 12.5,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

// =====================================================================
// 10. vsync — TickerProvider requirement
// =====================================================================

Widget _vsyncSection() {
  return _sectionShell(
    accent: _kAmber,
    accentSoft: _kAmberSoft,
    eyebrow: 'section · 10',
    title: 'vsync · the TickerProvider requirement',
    subtitle:
        'TabController owns an internal animation. Like every animation '
        'in Flutter, it needs a Ticker, and a Ticker needs a vsync.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _kInk,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Text(
            "class _S extends State<X>\n"
            "    with SingleTickerProviderStateMixin {\n"
            "  late final TabController controller =\n"
            "      TabController(length: 4, vsync: this);\n"
            "}",
            style: TextStyle(
              color: Color(0xFFE2E8F0),
              fontSize: 13,
              height: 1.6,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _vsyncMixinCard(
                title: 'SingleTickerProviderStateMixin',
                tagline: 'one ticker — one controller',
                body:
                    'Use when the State owns exactly one animation '
                    'controller (a TabController counts). Slightly cheaper '
                    'than the multi version.',
                accent: _kEmerald,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _vsyncMixinCard(
                title: 'TickerProviderStateMixin',
                tagline: 'many tickers — many controllers',
                body:
                    'Use when the State owns more than one '
                    'AnimationController / TabController. Pays for the '
                    'extra bookkeeping with flexibility.',
                accent: _kIndigo,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        _calloutBar(
          accent: _kAmber,
          accentSoft: _kAmberSoft,
          icon: Icons.warning_amber_outlined,
          title: 'You cannot avoid vsync',
          body: 'There is no parameter-less TabController constructor. '
              'If you do not want to think about vsync, use '
              'DefaultTabController instead — it provides one internally.',
        ),
      ],
    ),
  );
}

Widget _vsyncMixinCard({
  required String title,
  required String tagline,
  required String body,
  required Color accent,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: accent.withValues(alpha: 0.30)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.bolt_outlined, color: accent, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: _kInk,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          tagline,
          style: TextStyle(
            color: accent,
            fontSize: 12,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          body,
          style: const TextStyle(
            color: _kInkSoft,
            fontSize: 12.5,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// 11. animationDuration — slow vs default vs snappy
// =====================================================================

Widget _animationDurationSection() {
  return _sectionShell(
    accent: _kRose,
    accentSoft: _kRoseSoft,
    eyebrow: 'section · 11',
    title: 'animationDuration · pacing the slide',
    subtitle:
        'Controls how long programmatic animateTo transitions take. '
        'Defaults to kTabScrollDuration (300 ms). User-driven swipes are '
        'unaffected.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _durationCard(
                accent: _kEmerald,
                label: '150 ms',
                tagline: 'snappy',
                code: 'TabController(\n'
                    '  length: 4,\n'
                    '  vsync: this,\n'
                    '  animationDuration:\n'
                    '      Duration(milliseconds: 150),\n'
                    ')',
                description:
                    'Use when tabs change a lot. Risks feeling abrupt to '
                    'users who expect Material defaults.',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _durationCard(
                accent: _kIndigo,
                label: '300 ms',
                tagline: 'default',
                code: 'TabController(\n'
                    '  length: 4,\n'
                    '  vsync: this,\n'
                    '  // animationDuration omitted\n'
                    ')',
                description:
                    'kTabScrollDuration. Matches every other Material '
                    'tab view. The safe choice.',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _durationCard(
                accent: _kAmber,
                label: '500 ms',
                tagline: 'cinematic',
                code: 'TabController(\n'
                    '  length: 4,\n'
                    '  vsync: this,\n'
                    '  animationDuration:\n'
                    '      Duration(milliseconds: 500),\n'
                    ')',
                description:
                    'For tutorial / onboarding screens. Long durations '
                    'block follow-up taps and frustrate power users.',
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kRoseSoft.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kRose.withValues(alpha: 0.30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Duration.zero · disable animation entirely',
                style: TextStyle(
                  color: _kRose,
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Passing Duration.zero turns animateTo into a synchronous '
                'jump — no slide, no easing, no fade. The TabBar indicator '
                'and TabBarView page change instantly. Useful for tests '
                'and for users with reduce-motion accessibility settings.',
                style: TextStyle(
                  color: _kInk,
                  fontSize: 12.5,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _durationCard({
  required Color accent,
  required String label,
  required String tagline,
  required String code,
  required String description,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: accent.withValues(alpha: 0.30)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                color: accent,
                fontSize: 22,
                fontWeight: FontWeight.w900,
                fontFamily: 'monospace',
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                tagline,
                style: TextStyle(
                  color: accent,
                  fontSize: 11,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kInk,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            code,
            style: const TextStyle(
              color: Color(0xFFE2E8F0),
              fontSize: 11,
              height: 1.5,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(
            color: _kInkSoft,
            fontSize: 12,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// 12. animateTo — signature card
// =====================================================================

Widget _animateToSection() {
  return _sectionShell(
    accent: _kIndigo,
    accentSoft: _kIndigoSoft,
    eyebrow: 'section · 12',
    title: 'animateTo · the verb',
    subtitle:
        'The primary way to move to another tab from code. Sets index '
        'immediately, then animates the underlying animation.value into '
        'place over animationDuration.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _kInk,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Text(
            "void animateTo(\n"
            "  int      value, {\n"
            "  Duration? duration,                      // override\n"
            "  Curve     curve   = Curves.ease,          // easing\n"
            "})",
            style: TextStyle(
              color: Color(0xFFE2E8F0),
              fontSize: 13,
              height: 1.55,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _argCard(
                'value',
                'int (positional)',
                'The target tab. Must be in [0, length). Out-of-range '
                    'values throw assertions in debug.',
                _kIndigo,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _argCard(
                'duration',
                'Duration?',
                'Per-call override of animationDuration. Pass to slow '
                    'down a single transition without rebuilding the '
                    'controller. Null falls back to the controller '
                    'default.',
                _kTeal,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _argCard(
                'curve',
                'Curve = Curves.ease',
                'Easing applied between previousIndex and index. The '
                    'default Curves.ease produces the standard Material '
                    'feel.',
                _kAmber,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kIndigoSoft.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kIndigo.withValues(alpha: 0.30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Setter sugar · controller.index = i',
                style: TextStyle(
                  color: _kIndigo,
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Assigning to controller.index is equivalent to calling '
                'animateTo with the controller-level animationDuration '
                'and Curves.ease. Use whichever reads better in context. '
                'Both flip indexIsChanging to true and notify listeners.',
                style: TextStyle(
                  color: _kInk,
                  fontSize: 12.5,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// 13. PITFALLS
// =====================================================================

Widget _pitfallsSection() {
  return _sectionShell(
    accent: _kRose,
    accentSoft: _kRoseSoft,
    eyebrow: 'section · 13',
    title: 'Common pitfalls',
    subtitle:
        'A condensed list of the mistakes that have shipped in real apps '
        'and what to do instead.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _pitfallRow(
          accent: _kRose,
          icon: Icons.error_outline,
          title: 'length mismatch',
          body: 'TabBar.tabs.length, TabBarView.children.length, and '
              'TabController.length must all be equal. Otherwise you get '
              'a runtime assertion in debug and unpredictable behaviour '
              'in release.',
        ),
        _pitfallRow(
          accent: _kAmber,
          icon: Icons.memory_outlined,
          title: 'forgetting to dispose',
          body: 'When you build a TabController explicitly, you own its '
              'lifecycle. Always dispose it in State.dispose to release '
              'the underlying Ticker. Use DefaultTabController to dodge '
              'this entirely.',
        ),
        _pitfallRow(
          accent: _kEmerald,
          icon: Icons.layers_outlined,
          title: 'two controllers, one view',
          body: 'Passing different controllers to TabBar and TabBarView '
              'silently breaks them. Pass the same instance to both, or '
              'rely on DefaultTabController to provide a shared one.',
        ),
        _pitfallRow(
          accent: _kIndigo,
          icon: Icons.repeat_outlined,
          title: 'firing setState inside the listener',
          body: 'addListener fires many times per transition. Calling '
              'setState every tick is fine for tiny widgets, but for '
              'expensive subtrees, rebuild only when '
              'indexIsChanging flips false.',
        ),
        _pitfallRow(
          accent: _kViolet,
          icon: Icons.bolt_outlined,
          title: 'changing length after construction',
          body: 'TabController.length is final. To change it, dispose '
              'the old controller and create a new one — typically by '
              'driving its construction off a key or a piece of state '
              'that flips when length changes.',
        ),
        _pitfallRow(
          accent: _kTeal,
          icon: Icons.settings_outlined,
          title: 'reading animation before attach',
          body: 'controller.animation is null until at least one '
              'descendant TabBar or TabBarView attaches to it. Reading '
              'it inside initState before the first frame returns null.',
        ),
      ],
    ),
  );
}

Widget _pitfallRow({
  required Color accent,
  required IconData icon,
  required String title,
  required String body,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accent.withValues(alpha: 0.25)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: accent, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: _kInk,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: const TextStyle(
                  color: _kInkSoft,
                  fontSize: 12.5,
                  height: 1.55,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// 14. FOOTER
// =====================================================================

Widget _footerSection() {
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: _kInk,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kIndigo.withValues(alpha: 0.30),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.menu_book_outlined,
            color: Colors.white,
            size: 22,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'TabController — Visual Deep Demo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Static snapshot. No live TabController is constructed; '
                'a single DefaultTabController hosts the only interactive '
                'card. The rest of the file is hand-painted documentation, '
                'safe for AST round-trip testing.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.78),
                  fontSize: 13,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  _footerChip('material.dart'),
                  _footerChip('TabController'),
                  _footerChip('DefaultTabController'),
                  _footerChip('TabBar'),
                  _footerChip('TabBarView'),
                  _footerChip('Tab'),
                  _footerChip('TickerProvider'),
                  _footerChip('Animation<double>'),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _footerChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(999),
      border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontFamily: 'monospace',
      ),
    ),
  );
}

// =====================================================================
// SHARED · callout bar
// =====================================================================

Widget _calloutBar({
  required Color accent,
  required Color accentSoft,
  required IconData icon,
  required String title,
  required String body,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: accentSoft.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accent.withValues(alpha: 0.25)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: accent, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: const TextStyle(
                  color: _kInk,
                  fontSize: 12.5,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION SHELL — shared scaffold for sections 02..13
// =====================================================================

Widget _sectionShell({
  required Color accent,
  required Color accentSoft,
  required String eyebrow,
  required String title,
  required String subtitle,
  required Widget child,
}) {
  return Container(
    padding: const EdgeInsets.all(28),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: accent.withValues(alpha: 0.18)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.06),
          blurRadius: 24,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: accentSoft,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                eyebrow,
                style: TextStyle(
                  color: accent,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                  letterSpacing: 0.8,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          title,
          style: const TextStyle(
            color: _kInk,
            fontSize: 30,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.6,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            color: _kInkSoft.withValues(alpha: 0.95),
            fontSize: 15,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 22),
        child,
      ],
    ),
  );
}

// =====================================================================
// END OF FILE
// =====================================================================

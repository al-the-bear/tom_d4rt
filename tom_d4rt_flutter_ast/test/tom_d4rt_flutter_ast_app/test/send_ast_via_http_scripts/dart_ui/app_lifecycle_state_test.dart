// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
//
// Deep visual demo for dart:ui AppLifecycleState enum.
//
// Design plan:
//   Section 1 - Gradient header banner introducing the enum and its purpose.
//   Section 2 - Five state cards (detached, resumed, inactive, hidden, paused),
//               each rendering name, index, icon, gradient palette and a short
//               narrative description in a Material 3 color container style.
//   Section 3 - Transition state-machine diagram, drawn as a vertical chain of
//               boxes connected with Icons.arrow_downward to show legal moves
//               between the five lifecycle values.
//   Section 4 - Platform notes matrix comparing how Android, iOS and Web
//               surface each state, rendered as a table-like grid of rows.
//   Section 5 - Decision matrix - "what should your app do in each state",
//               organised as bulleted cards with action recipes.
//   Section 6 - Recipes - three concrete code snippet panels (save state,
//               release resources, refresh data) styled like an IDE block.
//   Section 7 - Glossary and key-takeaways grid for quick reference.
//
// The whole tree is a StatelessWidget returning MaterialApp -> Scaffold ->
// SingleChildScrollView -> Column. No timers, no async, no navigation;
// purely declarative widgets so the AST runner can execute it deterministically.

import 'package:flutter/material.dart';

void main() => runApp(const AppLifecycleStateDemoApp());

class AppLifecycleStateDemoApp extends StatelessWidget {
  const AppLifecycleStateDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('AppLifecycleState Deep Demo starting');
    return MaterialApp(
      title: 'AppLifecycleState Deep Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const _DemoScaffold(),
    );
  }
}

class _DemoScaffold extends StatelessWidget {
  const _DemoScaffold();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    print('=== Section 1: Gradient Header Banner ===');
    final header = _buildHeader(scheme);

    print('=== Section 2: State Cards (the five values) ===');
    final stateCards = _buildStateCards(scheme);

    print('=== Section 3: Transition State-Machine Diagram ===');
    final transitionDiagram = _buildTransitionDiagram(scheme);

    print('=== Section 4: Platform Notes Matrix ===');
    final platformMatrix = _buildPlatformMatrix(scheme);

    print('=== Section 5: Decision Matrix - What Should Your App Do ===');
    final decisionMatrix = _buildDecisionMatrix(scheme);

    print('=== Section 6: Recipes (Save State / Release / Refresh) ===');
    final recipes = _buildRecipes(scheme);

    print('=== Section 7: Glossary and Takeaways ===');
    final glossary = _buildGlossary(scheme);

    print('AppLifecycleState Deep Demo build assembled');

    return Scaffold(
      backgroundColor: scheme.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            header,
            const SizedBox(height: 28.0),
            _sectionTitle('1. The five values at a glance', scheme),
            const SizedBox(height: 12.0),
            stateCards,
            const SizedBox(height: 32.0),
            _sectionTitle('2. Transition diagram', scheme),
            const SizedBox(height: 12.0),
            transitionDiagram,
            const SizedBox(height: 32.0),
            _sectionTitle('3. Platform notes: Android vs iOS vs Web', scheme),
            const SizedBox(height: 12.0),
            platformMatrix,
            const SizedBox(height: 32.0),
            _sectionTitle('4. Decision matrix - what should your app do?', scheme),
            const SizedBox(height: 12.0),
            decisionMatrix,
            const SizedBox(height: 32.0),
            _sectionTitle('5. Recipes', scheme),
            const SizedBox(height: 12.0),
            recipes,
            const SizedBox(height: 32.0),
            _sectionTitle('6. Glossary and key takeaways', scheme),
            const SizedBox(height: 12.0),
            glossary,
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }

  // -----------------------------------------------------------------
  // Header
  // -----------------------------------------------------------------
  Widget _buildHeader(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            scheme.primary,
            scheme.tertiary,
            scheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.25),
            blurRadius: 18.0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: scheme.onPrimary.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.phone_iphone,
                  size: 40.0,
                  color: scheme.onPrimary,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'dart:ui  AppLifecycleState',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: scheme.onPrimary,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'States your Flutter app moves through at runtime',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: scheme.onPrimary.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            decoration: BoxDecoration(
              color: scheme.onPrimary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              'enum values: detached, resumed, inactive, hidden, paused',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                color: scheme.onPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------
  // Section 2: state cards
  // -----------------------------------------------------------------
  Widget _buildStateCards(ColorScheme scheme) {
    final List<_LifecycleEntry> entries = <_LifecycleEntry>[
      _LifecycleEntry(
        state: AppLifecycleState.detached,
        icon: Icons.link_off,
        bg: scheme.errorContainer,
        fg: scheme.onErrorContainer,
        headline: 'Engine attached, no view',
        body:
            'The Flutter engine is hosted but no platform view is attached. '
            'This is the very first state on startup, and the last state '
            'before the host process tears the engine down.',
      ),
      _LifecycleEntry(
        state: AppLifecycleState.resumed,
        icon: Icons.play_circle,
        bg: scheme.primaryContainer,
        fg: scheme.onPrimaryContainer,
        headline: 'Foreground, interactive',
        body:
            'The application is visible, focused and receiving user input. '
            'This is the only state in which it is appropriate to play '
            'animations, start expensive computations or refresh live data.',
      ),
      _LifecycleEntry(
        state: AppLifecycleState.inactive,
        icon: Icons.pause_circle_outline,
        bg: scheme.tertiaryContainer,
        fg: scheme.onTertiaryContainer,
        headline: 'Visible but not focused',
        body:
            'The application is visible but does not have input focus. '
            'Examples: a system dialog is in front, a phone call is ringing, '
            'the user is in the iOS app switcher, or split-screen with '
            'another app focused.',
      ),
      _LifecycleEntry(
        state: AppLifecycleState.hidden,
        icon: Icons.visibility_off,
        bg: scheme.secondaryContainer,
        fg: scheme.onSecondaryContainer,
        headline: 'All views hidden',
        body:
            'All Flutter views in the application are hidden, either because '
            'the user dismissed the app or because the platform routed it '
            'off screen. The engine is still running but no pixels are '
            'visible to the user.',
      ),
      _LifecycleEntry(
        state: AppLifecycleState.paused,
        icon: Icons.bedtime,
        bg: scheme.surfaceContainerHighest,
        fg: scheme.onSurface,
        headline: 'Backgrounded, frozen',
        body:
            'The application is suspended in the background. No callbacks '
            'are dispatched, no frames are rendered. The OS may reclaim '
            'the process at any time. Persist anything you cannot afford '
            'to lose before entering this state.',
      ),
    ];

    final List<Widget> cards = <Widget>[];
    for (int i = 0; i < entries.length; i++) {
      cards.add(_buildStateCard(entries[i], i, scheme));
    }

    return Column(children: cards);
  }

  Widget _buildStateCard(
    _LifecycleEntry entry,
    int index,
    ColorScheme scheme,
  ) {
    final String enumName = entry.state.toString().split('.').last;
    print('State card: $enumName (index $index)');
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: entry.bg,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: entry.fg.withValues(alpha: 0.25),
          width: 1.4,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    color: entry.fg.withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(entry.icon, color: entry.fg, size: 24.0),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            enumName,
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: entry.fg,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 2.0,
                            ),
                            decoration: BoxDecoration(
                              color: entry.fg.withValues(alpha: 0.16),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              'index $index',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w600,
                                color: entry.fg,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        entry.headline,
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                          color: entry.fg.withValues(alpha: 0.85),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Text(
              entry.body,
              style: TextStyle(
                fontSize: 13.0,
                height: 1.4,
                color: entry.fg.withValues(alpha: 0.9),
              ),
            ),
            const SizedBox(height: 12.0),
            Row(
              children: <Widget>[
                _miniStateChip(
                  label: 'visible',
                  active: entry.state == AppLifecycleState.resumed ||
                      entry.state == AppLifecycleState.inactive,
                  fg: entry.fg,
                ),
                const SizedBox(width: 8.0),
                _miniStateChip(
                  label: 'focused',
                  active: entry.state == AppLifecycleState.resumed,
                  fg: entry.fg,
                ),
                const SizedBox(width: 8.0),
                _miniStateChip(
                  label: 'frames',
                  active: entry.state != AppLifecycleState.paused &&
                      entry.state != AppLifecycleState.detached,
                  fg: entry.fg,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniStateChip({
    required String label,
    required bool active,
    required Color fg,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: active
            ? fg.withValues(alpha: 0.22)
            : fg.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: fg.withValues(alpha: active ? 0.5 : 0.2),
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            active ? Icons.check : Icons.close,
            size: 12.0,
            color: fg.withValues(alpha: active ? 0.9 : 0.5),
          ),
          const SizedBox(width: 4.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.0,
              color: fg.withValues(alpha: active ? 0.9 : 0.5),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------
  // Section 3: transition state-machine diagram
  // -----------------------------------------------------------------
  Widget _buildTransitionDiagram(ColorScheme scheme) {
    // We render the canonical "cold start" path top to bottom. Each node
    // is a box and each transition is rendered with Icons.arrow_downward.
    final List<_TransitionNode> forwardPath = <_TransitionNode>[
      _TransitionNode(
        label: 'detached',
        icon: Icons.link_off,
        color: scheme.error,
        note: 'engine attached, no view',
      ),
      _TransitionNode(
        label: 'inactive',
        icon: Icons.pause_circle_outline,
        color: scheme.tertiary,
        note: 'view attached, not focused yet',
      ),
      _TransitionNode(
        label: 'resumed',
        icon: Icons.play_circle,
        color: scheme.primary,
        note: 'foreground and interactive',
      ),
      _TransitionNode(
        label: 'inactive',
        icon: Icons.pause_circle_outline,
        color: scheme.tertiary,
        note: 'user pulled down notification panel',
      ),
      _TransitionNode(
        label: 'hidden',
        icon: Icons.visibility_off,
        color: scheme.secondary,
        note: 'views hidden',
      ),
      _TransitionNode(
        label: 'paused',
        icon: Icons.bedtime,
        color: scheme.outline,
        note: 'frozen in background',
      ),
      _TransitionNode(
        label: 'detached',
        icon: Icons.link_off,
        color: scheme.error,
        note: 'engine torn down',
      ),
    ];

    final List<Widget> nodes = <Widget>[];
    for (int i = 0; i < forwardPath.length; i++) {
      nodes.add(_transitionNodeBox(forwardPath[i], scheme));
      if (i != forwardPath.length - 1) {
        nodes.add(_transitionArrow(scheme));
      }
    }

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: scheme.outlineVariant, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Typical cold start to teardown',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: scheme.onSurface,
              fontSize: 14.0,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            'Boxes are states. Arrows are platform-driven transitions.',
            style: TextStyle(
              fontSize: 11.0,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16.0),
          ...nodes,
          const SizedBox(height: 16.0),
          _resumeBackPathLegend(scheme),
        ],
      ),
    );
  }

  Widget _transitionNodeBox(_TransitionNode node, ColorScheme scheme) {
    return Container(
      width: 260.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: node.color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: node.color, width: 1.6),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: node.color.withValues(alpha: 0.15),
            blurRadius: 6.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Icon(node.icon, color: node.color, size: 24.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  node.label,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    color: node.color,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  node.note,
                  style: TextStyle(
                    fontSize: 11.0,
                    color: scheme.onSurface.withValues(alpha: 0.75),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _transitionArrow(ColorScheme scheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        children: <Widget>[
          Container(
            width: 2.0,
            height: 12.0,
            color: scheme.outline,
          ),
          Icon(
            Icons.arrow_downward,
            size: 20.0,
            color: scheme.outline,
          ),
        ],
      ),
    );
  }

  Widget _resumeBackPathLegend(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: scheme.primaryContainer.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: scheme.primary.withValues(alpha: 0.4),
          width: 1.0,
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.replay,
            color: scheme.primary,
            size: 22.0,
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'A warm resume reverses the path: paused -> hidden -> '
              'inactive -> resumed. Detached at the start of the chain '
              'is only seen once per engine instance.',
              style: TextStyle(
                fontSize: 12.0,
                color: scheme.onSurface,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------
  // Section 4: platform matrix
  // -----------------------------------------------------------------
  Widget _buildPlatformMatrix(ColorScheme scheme) {
    final List<_PlatformRow> rows = <_PlatformRow>[
      _PlatformRow(
        state: AppLifecycleState.detached,
        android: 'Activity not yet created, or already destroyed.',
        ios: 'UIApplication not yet linked to a UIWindowScene.',
        web: 'Document exists but no Flutter view has been mounted.',
      ),
      _PlatformRow(
        state: AppLifecycleState.resumed,
        android: 'Activity.onResume has been called, in foreground.',
        ios: 'UIScene activation state foregroundActive.',
        web: 'Tab is focused and visible (document.hasFocus is true).',
      ),
      _PlatformRow(
        state: AppLifecycleState.inactive,
        android: 'Activity.onPause has fired, but window still visible.',
        ios: 'UIScene activation state foregroundInactive.',
        web: 'Tab is visible but not focused (different window active).',
      ),
      _PlatformRow(
        state: AppLifecycleState.hidden,
        android: 'Activity.onStop fired, surface no longer visible.',
        ios: 'UIScene activation state background, view hidden.',
        web: 'document.visibilityState is hidden (tab switched).',
      ),
      _PlatformRow(
        state: AppLifecycleState.paused,
        android: 'Process placed in cached state, no further callbacks.',
        ios: 'Application has fully entered background after grace period.',
        web: 'Equivalent to hidden on the web - same observable result.',
      ),
    ];

    final List<Widget> rowWidgets = <Widget>[
      _platformHeaderRow(scheme),
    ];
    for (final _PlatformRow row in rows) {
      rowWidgets.add(_platformDataRow(row, scheme));
    }

    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: scheme.outlineVariant, width: 1.0),
      ),
      child: Column(children: rowWidgets),
    );
  }

  Widget _platformHeaderRow(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.12),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(13.0)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              'state',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: scheme.primary,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: <Widget>[
                Icon(Icons.android, color: scheme.primary, size: 16.0),
                const SizedBox(width: 6.0),
                Text(
                  'Android',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: scheme.primary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: <Widget>[
                Icon(Icons.phone_iphone, color: scheme.primary, size: 16.0),
                const SizedBox(width: 6.0),
                Text(
                  'iOS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: scheme.primary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: <Widget>[
                Icon(Icons.public, color: scheme.primary, size: 16.0),
                const SizedBox(width: 6.0),
                Text(
                  'Web',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: scheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _platformDataRow(_PlatformRow row, ColorScheme scheme) {
    final String name = row.state.toString().split('.').last;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: scheme.outlineVariant, width: 1.0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: scheme.secondaryContainer,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: scheme.onSecondaryContainer,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                row.android,
                style: TextStyle(
                  fontSize: 11.5,
                  color: scheme.onSurface,
                  height: 1.35,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                row.ios,
                style: TextStyle(
                  fontSize: 11.5,
                  color: scheme.onSurface,
                  height: 1.35,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              row.web,
              style: TextStyle(
                fontSize: 11.5,
                color: scheme.onSurface,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------
  // Section 5: decision matrix
  // -----------------------------------------------------------------
  Widget _buildDecisionMatrix(ColorScheme scheme) {
    final List<_DecisionEntry> entries = <_DecisionEntry>[
      _DecisionEntry(
        state: AppLifecycleState.detached,
        verdict: 'Set up only what is needed to bootstrap.',
        items: <String>[
          'Do not touch widgets, the view is not attached.',
          'Initialise services that do not require the view tree.',
          'Avoid heavy IO: the user has not even seen anything yet.',
        ],
        accent: scheme.error,
      ),
      _DecisionEntry(
        state: AppLifecycleState.resumed,
        verdict: 'Resume full activity.',
        items: <String>[
          'Restart animations and timers that were stopped.',
          'Re-subscribe to streams, websockets, push channels.',
          'Refresh any data that may have become stale while away.',
          'Re-enable expensive sensors (camera, location, microphone).',
        ],
        accent: scheme.primary,
      ),
      _DecisionEntry(
        state: AppLifecycleState.inactive,
        verdict: 'Pause but stay ready - this is often transient.',
        items: <String>[
          'Pause non-critical animations to save CPU.',
          'Hide secrets (password fields, sensitive forms) for screenshots.',
          'Do NOT release expensive resources yet, you may resume in ms.',
        ],
        accent: scheme.tertiary,
      ),
      _DecisionEntry(
        state: AppLifecycleState.hidden,
        verdict: 'Stop visible work, prepare for the worst.',
        items: <String>[
          'Pause all animations and rendering work.',
          'Persist transient UI state (scroll positions, draft text).',
          'Release UI-only caches (image decoders, video controllers).',
        ],
        accent: scheme.secondary,
      ),
      _DecisionEntry(
        state: AppLifecycleState.paused,
        verdict: 'You are about to disappear - flush everything.',
        items: <String>[
          'Save all unsaved user data synchronously.',
          'Close database, network and file handles.',
          'Cancel scheduled work that should not run in background.',
          'Be aware the process may be killed at any moment.',
        ],
        accent: scheme.outline,
      ),
    ];

    final List<Widget> cards = <Widget>[];
    for (final _DecisionEntry entry in entries) {
      cards.add(_decisionCard(entry, scheme));
    }
    return Column(children: cards);
  }

  Widget _decisionCard(_DecisionEntry entry, ColorScheme scheme) {
    final String name = entry.state.toString().split('.').last;
    final List<Widget> bullets = <Widget>[];
    for (final String item in entry.items) {
      bullets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.arrow_forward,
                size: 14.0,
                color: entry.accent,
              ),
              const SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: scheme.onSurface,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: entry.accent.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: entry.accent.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: entry.accent.withValues(alpha: 0.5),
                  ),
                ),
                child: Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: entry.accent,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  entry.verdict,
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          ...bullets,
        ],
      ),
    );
  }

  // -----------------------------------------------------------------
  // Section 6: recipes (code snippets)
  // -----------------------------------------------------------------
  Widget _buildRecipes(ColorScheme scheme) {
    return Column(
      children: <Widget>[
        _codeBlock(
          title: 'Recipe 1 - save state when hidden or paused',
          icon: Icons.save,
          accent: scheme.primary,
          scheme: scheme,
          code: '''class _DraftPageState extends State<DraftPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.hidden ||
        state == AppLifecycleState.paused) {
      _persistDraft(_controller.text);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}''',
        ),
        const SizedBox(height: 14.0),
        _codeBlock(
          title: 'Recipe 2 - release expensive resources when hidden',
          icon: Icons.power_settings_new,
          accent: scheme.tertiary,
          scheme: scheme,
          code: '''@override
void didChangeAppLifecycleState(AppLifecycleState state) {
  switch (state) {
    case AppLifecycleState.resumed:
      _camera.start();
      break;
    case AppLifecycleState.inactive:
      // transient; keep camera but mute previews
      _camera.mutePreview();
      break;
    case AppLifecycleState.hidden:
    case AppLifecycleState.paused:
      _camera.stop();
      break;
    case AppLifecycleState.detached:
      _camera.dispose();
      break;
  }
}''',
        ),
        const SizedBox(height: 14.0),
        _codeBlock(
          title: 'Recipe 3 - refresh stale data on resume',
          icon: Icons.refresh,
          accent: scheme.secondary,
          scheme: scheme,
          code: '''DateTime? _lastResumed;

@override
void didChangeAppLifecycleState(AppLifecycleState state) {
  if (state == AppLifecycleState.resumed) {
    final now = DateTime.now();
    if (_lastResumed == null ||
        now.difference(_lastResumed!) > const Duration(minutes: 5)) {
      context.read<FeedBloc>().add(const FeedRefreshRequested());
    }
    _lastResumed = now;
  }
}''',
        ),
      ],
    );
  }

  Widget _codeBlock({
    required String title,
    required IconData icon,
    required Color accent,
    required ColorScheme scheme,
    required String code,
  }) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: scheme.inverseSurface,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: accent.withValues(alpha: 0.5), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: accent, size: 18.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: scheme.onInverseSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: scheme.surface.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: scheme.onInverseSurface.withValues(alpha: 0.18),
              ),
            ),
            child: Text(
              code,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                height: 1.45,
                color: scheme.onInverseSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------
  // Section 7: glossary
  // -----------------------------------------------------------------
  Widget _buildGlossary(ColorScheme scheme) {
    final List<_GlossaryEntry> entries = <_GlossaryEntry>[
      _GlossaryEntry(
        term: 'WidgetsBindingObserver',
        body: 'Mixin you add to a State class so that '
            'didChangeAppLifecycleState is delivered to your code.',
        icon: Icons.extension,
      ),
      _GlossaryEntry(
        term: 'didChangeAppLifecycleState',
        body: 'Callback invoked by the framework whenever the app moves '
            'between AppLifecycleState values.',
        icon: Icons.swap_horiz,
      ),
      _GlossaryEntry(
        term: 'AppLifecycleListener',
        body: 'Higher level helper class that exposes onResume, onHide, '
            'onPause, onDetach, onInactive callbacks separately - often '
            'easier than implementing didChangeAppLifecycleState.',
        icon: Icons.event_note,
      ),
      _GlossaryEntry(
        term: 'visible',
        body: 'True in resumed and inactive. False in hidden, paused and '
            'detached.',
        icon: Icons.visibility,
      ),
      _GlossaryEntry(
        term: 'focused',
        body: 'True only in resumed. Anything else means input is not '
            'reaching your widgets.',
        icon: Icons.center_focus_strong,
      ),
      _GlossaryEntry(
        term: 'rendering frames',
        body: 'The engine schedules frames whenever the app is not paused '
            'or detached. In hidden state frames may still be requested '
            'but the platform discards them.',
        icon: Icons.movie,
      ),
    ];

    final List<Widget> tiles = <Widget>[];
    for (final _GlossaryEntry e in entries) {
      tiles.add(_glossaryTile(e, scheme));
    }

    final Widget takeaways = Container(
      margin: const EdgeInsets.only(top: 18.0),
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            scheme.primaryContainer,
            scheme.tertiaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.flag, color: scheme.onPrimaryContainer),
              const SizedBox(width: 8.0),
              Text(
                'Key takeaways',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: scheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          _takeaway(
            'There are exactly five values: detached, resumed, inactive, '
            'hidden, paused.',
            scheme,
          ),
          _takeaway(
            'Save work no later than hidden - paused may never get its '
            'callback finished.',
            scheme,
          ),
          _takeaway(
            'inactive is transient; do not tear down expensive resources '
            'there.',
            scheme,
          ),
          _takeaway(
            'On web, paused is observationally the same as hidden.',
            scheme,
          ),
          _takeaway(
            'Use AppLifecycleListener for cleaner code than the raw '
            'observer mixin.',
            scheme,
          ),
        ],
      ),
    );

    return Column(
      children: <Widget>[
        ...tiles,
        takeaways,
      ],
    );
  }

  Widget _glossaryTile(_GlossaryEntry e, ColorScheme scheme) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(e.icon, color: scheme.primary, size: 18.0),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  e.term,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    color: scheme.primary,
                    fontSize: 13.0,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  e.body,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: scheme.onSurface,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _takeaway(String text, ColorScheme scheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.check_circle,
            size: 16.0,
            color: scheme.onPrimaryContainer,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12.5,
                color: scheme.onPrimaryContainer,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------
  // Helpers
  // -----------------------------------------------------------------
  Widget _sectionTitle(String text, ColorScheme scheme) {
    return Row(
      children: <Widget>[
        Container(
          width: 6.0,
          height: 22.0,
          decoration: BoxDecoration(
            color: scheme.primary,
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.bold,
              color: scheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// Data classes for the demo - small immutable records so each section
// can read its content from a typed structure instead of map<String,
// dynamic> bags.
// =====================================================================

class _LifecycleEntry {
  const _LifecycleEntry({
    required this.state,
    required this.icon,
    required this.bg,
    required this.fg,
    required this.headline,
    required this.body,
  });

  final AppLifecycleState state;
  final IconData icon;
  final Color bg;
  final Color fg;
  final String headline;
  final String body;
}

class _TransitionNode {
  const _TransitionNode({
    required this.label,
    required this.icon,
    required this.color,
    required this.note,
  });

  final String label;
  final IconData icon;
  final Color color;
  final String note;
}

class _PlatformRow {
  const _PlatformRow({
    required this.state,
    required this.android,
    required this.ios,
    required this.web,
  });

  final AppLifecycleState state;
  final String android;
  final String ios;
  final String web;
}

class _DecisionEntry {
  const _DecisionEntry({
    required this.state,
    required this.verdict,
    required this.items,
    required this.accent,
  });

  final AppLifecycleState state;
  final String verdict;
  final List<String> items;
  final Color accent;
}

class _GlossaryEntry {
  const _GlossaryEntry({
    required this.term,
    required this.body,
    required this.icon,
  });

  final String term;
  final String body;
  final IconData icon;
}

// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// Visual deep demo: Flutter ScaffoldState
// =======================================
//
// This file is a hand-authored, analyzer-clean visual deep demo for the
// `ScaffoldState` API. It is meant to be rendered by a Flutter test harness
// that ships d4rt scripts to a running app and snapshots the resulting widget
// tree. It is NOT a runnable program by itself: there is exactly one entry
// point — `dynamic build(BuildContext)` — and it returns a widget tree.
//
// The demo describes the surface area of `ScaffoldState`:
//
//   * Methods that mutate scaffold UI:
//       - showBottomSheet<T>(builder)        — persistent sheet inside body
//       - showSnackBar(snackBar)             — DEPRECATED on ScaffoldState,
//                                              use ScaffoldMessenger.of(ctx)
//       - openDrawer()                       — slide the start-side drawer in
//       - openEndDrawer()                    — slide the end-side drawer in
//       - closeDrawer()                      — animate the start drawer out
//       - closeEndDrawer()                   — animate the end drawer out
//
//   * Read-only predicates exposed by the state object:
//       - hasDrawer        : bool — Scaffold was given a `drawer:` widget
//       - hasEndDrawer     : bool — Scaffold was given an `endDrawer:` widget
//       - isDrawerOpen     : bool — start drawer is currently visible
//       - isEndDrawerOpen  : bool — end drawer is currently visible
//
//   * Lookup forms:
//       - Scaffold.of(context)        — throws if no Scaffold ancestor
//       - Scaffold.maybeOf(context)   — returns null if no ancestor
//       - GlobalKey<ScaffoldState>()  — survives rebuilds and lets the
//                                       owning widget poke at the state
//
//   * Adjacent: ScaffoldMessenger / ScaffoldMessengerState
//       - The modern way to show snack bars and material banners. Snack bars
//         shown via the messenger persist across route pushes inside the same
//         scaffold-messenger subtree.
//
// HARD RULES enforced by this file:
//   * Single static `dynamic build(BuildContext)` entry point.
//   * No runApp / main / StatefulWidget / setState / async / streams.
//   * No `.withOpacity` — uses `withValues(alpha: ...)` everywhere.
//   * `_Private` prefix on every helper.
//   * No inline `// ignore:` directives.
//
// What you should see when this is rendered:
//
//   1. Hero card showing a "scaffold from above" diagram (appBar slab on top,
//      body in the middle, drawer on the left, end-drawer on the right,
//      bottom sheet sliding up from the bottom edge, FAB hovering on the
//      bottom-right).
//   2. Anatomy panel listing every relevant ScaffoldState method, grouped
//      by purpose (drawers / bottom sheets / snack bars / predicates).
//   3. Drawer + end-drawer mock with four phone-shaped frames showing the
//      four stable states.
//   4. Bottom-sheet mock with three phone frames: collapsed handle, expanded
//      sheet, and a "dragging" mid-state.
//   5. ScaffoldMessenger deprecation note panel.
//   6. `Scaffold.of` vs `Scaffold.maybeOf` vs `GlobalKey<ScaffoldState>`
//      three-card panel with code listings.
//   7. Lifecycle / state-flow diagram: `openDrawer()` triggers an animation,
//      and that animation is what eventually flips `isDrawerOpen` to true.
//   8. Code-listing card showing a real `Scaffold.of(context)` invocation.
//   9. Pitfalls panel.
//  10. Footer.

import 'package:flutter/material.dart';

// =============================================================================
// Palette and shared visual tokens
// =============================================================================

const Color _kBg = Color(0xFFF4F6FB);
const Color _kSurface = Color(0xFFFFFFFF);
const Color _kInk = Color(0xFF0F172A);
const Color _kInkSoft = Color(0xFF334155);
const Color _kInkMuted = Color(0xFF64748B);
const Color _kRule = Color(0xFFE2E8F0);
const Color _kAccent = Color(0xFF2563EB);
const Color _kAccentSoft = Color(0xFFDBEAFE);
const Color _kGood = Color(0xFF059669);
const Color _kGoodSoft = Color(0xFFD1FAE5);
const Color _kWarn = Color(0xFFD97706);
const Color _kWarnSoft = Color(0xFFFEF3C7);
const Color _kBad = Color(0xFFDC2626);
const Color _kBadSoft = Color(0xFFFEE2E2);
const Color _kPurple = Color(0xFF7C3AED);
const Color _kPurpleSoft = Color(0xFFEDE9FE);
const Color _kTeal = Color(0xFF0D9488);
const Color _kTealSoft = Color(0xFFCCFBF1);
const Color _kPhoneBezel = Color(0xFF1F2937);
const Color _kPhoneScreen = Color(0xFFF9FAFB);
const Color _kPhoneAppBar = Color(0xFF6366F1);
const Color _kPhoneFab = Color(0xFFEC4899);
const Color _kPhoneDrawer = Color(0xFFFFFFFF);
const Color _kPhoneScrim = Color(0xFF000000);
const Color _kPhoneSheet = Color(0xFFFFFFFF);

const String _kMono = 'monospace';

// =============================================================================
// Entry point
// =============================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ScaffoldState — visual deep demo',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: _kAccent),
      scaffoldBackgroundColor: _kBg,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontSize: 13.5, color: _kInkSoft, height: 1.45),
      ),
    ),
    home: Scaffold(
      backgroundColor: _kBg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(28, 28, 28, 64),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1180),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _PrivateTitleBar(),
                const SizedBox(height: 24),
                _PrivateHeroCard(),
                const SizedBox(height: 28),
                _PrivateAnatomyPanel(),
                const SizedBox(height: 28),
                _PrivateDrawerStatesMock(),
                const SizedBox(height: 28),
                _PrivateBottomSheetMock(),
                const SizedBox(height: 28),
                _PrivateMessengerDeprecationPanel(),
                const SizedBox(height: 28),
                _PrivateLookupTriptych(),
                const SizedBox(height: 28),
                _PrivateLifecycleFlowDiagram(),
                const SizedBox(height: 28),
                _PrivateCodeListingCard(),
                const SizedBox(height: 28),
                _PrivatePitfallsPanel(),
                const SizedBox(height: 28),
                _PrivateFooter(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// Title bar
// =============================================================================

class _PrivateTitleBar extends StatelessWidget {
  const _PrivateTitleBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kRule),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: _kAccentSoft,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _kAccent.withValues(alpha: 0.35)),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.dashboard_customize_outlined,
                color: _kAccent, size: 28),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'ScaffoldState — Visual Deep Demo',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: _kInk,
                    letterSpacing: -0.4,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Drawers, bottom sheets, snack bars, and the lookup story for '
                  'the state behind every Scaffold.',
                  style: TextStyle(
                    fontSize: 13,
                    color: _kInkMuted,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          _PrivateBadge(
            label: 'flutter / material',
            fg: _kAccent,
            bg: _kAccentSoft,
          ),
          const SizedBox(width: 8),
          _PrivateBadge(
            label: 'analyzer-clean',
            fg: _kGood,
            bg: _kGoodSoft,
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Reusable badge / tag
// =============================================================================

class _PrivateBadge extends StatelessWidget {
  const _PrivateBadge({
    required this.label,
    required this.fg,
    required this.bg,
  });
  final String label;
  final Color fg;
  final Color bg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: fg.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.5,
          color: fg,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

// =============================================================================
// Section header
// =============================================================================

class _PrivateSectionHeader extends StatelessWidget {
  const _PrivateSectionHeader({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.color,
  });
  final String index;
  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 0, 2, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.13),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: color.withValues(alpha: 0.4)),
            ),
            alignment: Alignment.center,
            child: Text(
              index,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: 14,
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
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: _kInk,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: _kInkMuted,
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
}

// =============================================================================
// Reusable card shell
// =============================================================================

class _PrivateCard extends StatelessWidget {
  const _PrivateCard({
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });
  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kRule),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.03),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

// =============================================================================
// 1. HERO CARD — "Scaffold from above" diagram
// =============================================================================

class _PrivateHeroCard extends StatelessWidget {
  const _PrivateHeroCard();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _PrivateSectionHeader(
          index: '1',
          title: 'Scaffold, viewed from above',
          subtitle:
              'A Scaffold is the host. ScaffoldState is the runtime handle to its '
              'movable parts: drawers, bottom sheets, snack bars, FAB.',
          color: _kAccent,
        ),
        _PrivateCard(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 360,
                child: _PrivateScaffoldFromAboveDiagram(),
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: <Widget>[
                  _PrivateLegendChip(
                    color: _kPhoneAppBar,
                    label: 'AppBar (top slab)',
                  ),
                  _PrivateLegendChip(
                    color: _kPhoneScreen,
                    label: 'body (center)',
                    border: true,
                  ),
                  _PrivateLegendChip(
                    color: _kPhoneDrawer,
                    label: 'drawer / endDrawer',
                    border: true,
                  ),
                  _PrivateLegendChip(
                    color: _kPhoneSheet,
                    label: 'bottomSheet',
                    border: true,
                  ),
                  _PrivateLegendChip(
                    color: _kPhoneFab,
                    label: 'floatingActionButton',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PrivateLegendChip extends StatelessWidget {
  const _PrivateLegendChip({
    required this.color,
    required this.label,
    this.border = false,
  });
  final Color color;
  final String label;
  final bool border;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _kBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kRule),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
              border: border ? Border.all(color: _kInkMuted) : null,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: _kInkSoft,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateScaffoldFromAboveDiagram extends StatelessWidget {
  const _PrivateScaffoldFromAboveDiagram();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext ctx, BoxConstraints cons) {
        final double w = cons.maxWidth;
        final double h = cons.maxHeight;
        final double appBarH = 44;
        final double drawerW = w * 0.18;
        final double endDrawerW = w * 0.18;
        final double sheetH = h * 0.22;
        final double bodyLeft = drawerW + 8;
        final double bodyRight = endDrawerW + 8;
        return Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: _kBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _kRule),
                ),
              ),
            ),
            Positioned(
              left: 12,
              top: 12,
              right: 12,
              height: appBarH,
              child: _PrivateBox(
                color: _kPhoneAppBar,
                label: 'AppBar',
                textColor: Colors.white,
              ),
            ),
            Positioned(
              left: 12,
              top: 12 + appBarH + 8,
              width: drawerW,
              bottom: 12,
              child: _PrivateBox(
                color: _kPhoneDrawer,
                label: 'drawer',
                bordered: true,
                textColor: _kInkSoft,
              ),
            ),
            Positioned(
              right: 12,
              top: 12 + appBarH + 8,
              width: endDrawerW,
              bottom: 12,
              child: _PrivateBox(
                color: _kPhoneDrawer,
                label: 'endDrawer',
                bordered: true,
                textColor: _kInkSoft,
              ),
            ),
            Positioned(
              left: bodyLeft + 12,
              top: 12 + appBarH + 8,
              right: bodyRight + 12,
              bottom: 12,
              child: _PrivateBox(
                color: _kPhoneScreen,
                label: 'body',
                bordered: true,
                textColor: _kInkMuted,
              ),
            ),
            Positioned(
              left: bodyLeft + 12,
              right: bodyRight + 12,
              bottom: 12,
              height: sheetH,
              child: _PrivateBox(
                color: _kPhoneSheet,
                label: 'bottomSheet',
                bordered: true,
                textColor: _kInkSoft,
              ),
            ),
            Positioned(
              right: endDrawerW + 28,
              bottom: sheetH + 24,
              width: 56,
              height: 56,
              child: Container(
                decoration: BoxDecoration(
                  color: _kPhoneFab,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: _kPhoneFab.withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.add, color: Colors.white, size: 26),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PrivateBox extends StatelessWidget {
  const _PrivateBox({
    required this.color,
    required this.label,
    this.bordered = false,
    required this.textColor,
  });
  final Color color;
  final String label;
  final bool bordered;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: bordered ? Border.all(color: _kRule) : null,
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }
}

// =============================================================================
// 2. ANATOMY PANEL — ScaffoldState API, grouped
// =============================================================================

class _PrivateAnatomyPanel extends StatelessWidget {
  const _PrivateAnatomyPanel();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _PrivateSectionHeader(
          index: '2',
          title: 'Anatomy of ScaffoldState',
          subtitle:
              'Each method or property below is a member you read or invoke '
              'on the live ScaffoldState handle.',
          color: _kPurple,
        ),
        _PrivateCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _PrivateAnatomyGroup(
                title: 'Drawers',
                color: _kAccent,
                rows: const <_PrivateAnatomyRow>[
                  _PrivateAnatomyRow(
                    name: 'openDrawer()',
                    sig: 'void',
                    text:
                        'Animates the start-side drawer open. Has no effect '
                        'if `Scaffold.drawer` is null.',
                  ),
                  _PrivateAnatomyRow(
                    name: 'openEndDrawer()',
                    sig: 'void',
                    text:
                        'Same as openDrawer but for `Scaffold.endDrawer`.',
                  ),
                  _PrivateAnatomyRow(
                    name: 'closeDrawer()',
                    sig: 'void',
                    text:
                        'Animates the start drawer closed if it is currently '
                        'open. Cheap no-op otherwise.',
                  ),
                  _PrivateAnatomyRow(
                    name: 'closeEndDrawer()',
                    sig: 'void',
                    text: 'Counterpart for the end drawer.',
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _PrivateAnatomyGroup(
                title: 'Bottom sheets',
                color: _kTeal,
                rows: const <_PrivateAnatomyRow>[
                  _PrivateAnatomyRow(
                    name: 'showBottomSheet<T>(builder)',
                    sig: 'PersistentBottomSheetController',
                    text:
                        'Shows a *persistent* bottom sheet anchored to the '
                        'scaffold body. Returns a controller you can `close()` '
                        'or whose `closed` Future you can await elsewhere.',
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _PrivateAnatomyGroup(
                title: 'Snack bars (deprecated on ScaffoldState)',
                color: _kWarn,
                rows: const <_PrivateAnatomyRow>[
                  _PrivateAnatomyRow(
                    name: 'showSnackBar(snackBar)',
                    sig: 'ScaffoldFeatureController',
                    text:
                        'Deprecated. Prefer ScaffoldMessenger.of(context). The '
                        'messenger handles snack bars per messenger subtree, '
                        'not per scaffold widget.',
                  ),
                  _PrivateAnatomyRow(
                    name: 'hideCurrentSnackBar()',
                    sig: 'void',
                    text:
                        'Also deprecated on ScaffoldState. Use the messenger '
                        'equivalent.',
                  ),
                  _PrivateAnatomyRow(
                    name: 'removeCurrentSnackBar()',
                    sig: 'void',
                    text:
                        'Removes without animating. Same deprecation note.',
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _PrivateAnatomyGroup(
                title: 'Predicates (read-only)',
                color: _kGood,
                rows: const <_PrivateAnatomyRow>[
                  _PrivateAnatomyRow(
                    name: 'hasDrawer',
                    sig: 'bool',
                    text:
                        'True iff the Scaffold widget was given a non-null '
                        '`drawer:` argument. Says nothing about open/closed.',
                  ),
                  _PrivateAnatomyRow(
                    name: 'hasEndDrawer',
                    sig: 'bool',
                    text: 'Counterpart for `endDrawer:`.',
                  ),
                  _PrivateAnatomyRow(
                    name: 'isDrawerOpen',
                    sig: 'bool',
                    text:
                        'True only while the start drawer is fully or partially '
                        'visible. Flips at the end of the open animation.',
                  ),
                  _PrivateAnatomyRow(
                    name: 'isEndDrawerOpen',
                    sig: 'bool',
                    text: 'Counterpart for the end drawer.',
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _PrivateAnatomyGroup(
                title: 'Static parameters on Scaffold itself',
                color: _kPurple,
                rows: const <_PrivateAnatomyRow>[
                  _PrivateAnatomyRow(
                    name: 'Scaffold.floatingActionButton',
                    sig: 'Widget?',
                    text:
                        'There is no showFloatingActionButton method. The FAB '
                        'is configured statically on the Scaffold widget. To '
                        'animate it in/out, swap the parameter and let Flutter '
                        'tween the change.',
                  ),
                  _PrivateAnatomyRow(
                    name: 'Scaffold.bottomSheet',
                    sig: 'Widget?',
                    text:
                        'A persistent sheet that is always visible. Distinct '
                        'from `showBottomSheet`, which is imperative.',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PrivateAnatomyRow {
  const _PrivateAnatomyRow({
    required this.name,
    required this.sig,
    required this.text,
  });
  final String name;
  final String sig;
  final String text;
}

class _PrivateAnatomyGroup extends StatelessWidget {
  const _PrivateAnatomyGroup({
    required this.title,
    required this.color,
    required this.rows,
  });
  final String title;
  final Color color;
  final List<_PrivateAnatomyRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8,
                height: 22,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: color,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...List<Widget>.generate(rows.length, (int i) {
            final _PrivateAnatomyRow r = rows[i];
            return Padding(
              padding: EdgeInsets.only(bottom: i == rows.length - 1 ? 0 : 10),
              child: _PrivateAnatomyRowView(row: r, color: color),
            );
          }),
        ],
      ),
    );
  }
}

class _PrivateAnatomyRowView extends StatelessWidget {
  const _PrivateAnatomyRowView({required this.row, required this.color});
  final _PrivateAnatomyRow row;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kRule),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  row.name,
                  style: TextStyle(
                    fontFamily: _kMono,
                    fontSize: 13,
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _kBg,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _kRule),
                ),
                child: Text(
                  row.sig,
                  style: const TextStyle(
                    fontFamily: _kMono,
                    fontSize: 11,
                    color: _kInkMuted,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            row.text,
            style: const TextStyle(
              fontSize: 12.5,
              color: _kInkSoft,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 3. DRAWER STATES MOCK — four phone frames
// =============================================================================

class _PrivateDrawerStatesMock extends StatelessWidget {
  const _PrivateDrawerStatesMock();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _PrivateSectionHeader(
          index: '3',
          title: 'Drawer & end-drawer — four stable states',
          subtitle:
              'isDrawerOpen / isEndDrawerOpen reflect what the user actually '
              'sees. hasDrawer / hasEndDrawer only reflect configuration.',
          color: _kAccent,
        ),
        _PrivateCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              LayoutBuilder(
                builder: (BuildContext ctx, BoxConstraints cons) {
                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: <Widget>[
                      _PrivatePhoneMock(
                        title: 'drawer closed',
                        subtitle: 'isDrawerOpen == false',
                        kind: _PrivatePhoneKind.drawerClosed,
                        accent: _kInkMuted,
                      ),
                      _PrivatePhoneMock(
                        title: 'drawer open',
                        subtitle: 'isDrawerOpen == true',
                        kind: _PrivatePhoneKind.drawerOpen,
                        accent: _kAccent,
                      ),
                      _PrivatePhoneMock(
                        title: 'endDrawer closed',
                        subtitle: 'isEndDrawerOpen == false',
                        kind: _PrivatePhoneKind.endDrawerClosed,
                        accent: _kInkMuted,
                      ),
                      _PrivatePhoneMock(
                        title: 'endDrawer open',
                        subtitle: 'isEndDrawerOpen == true',
                        kind: _PrivatePhoneKind.endDrawerOpen,
                        accent: _kPurple,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 18),
              _PrivateNoteBanner(
                color: _kAccent,
                icon: Icons.info_outline,
                title: 'Reading the predicates',
                body:
                    'hasDrawer is fixed at construction. isDrawerOpen flips '
                    'asynchronously: openDrawer() schedules an animation, and '
                    'isDrawerOpen does not become true until the animation '
                    'controller reports the drawer is at least partially '
                    'visible.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

enum _PrivatePhoneKind {
  drawerClosed,
  drawerOpen,
  endDrawerClosed,
  endDrawerOpen,
  sheetCollapsed,
  sheetExpanded,
  sheetDragging,
}

class _PrivatePhoneMock extends StatelessWidget {
  const _PrivatePhoneMock({
    required this.title,
    required this.subtitle,
    required this.kind,
    required this.accent,
  });
  final String title;
  final String subtitle;
  final _PrivatePhoneKind kind;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 360,
            decoration: BoxDecoration(
              color: _kPhoneBezel,
              borderRadius: BorderRadius.circular(28),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: _kInk.withValues(alpha: 0.18),
                  blurRadius: 14,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: _PrivatePhoneScreen(kind: kind),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: _kInk,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.5,
              color: accent,
              fontFamily: _kMono,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivatePhoneScreen extends StatelessWidget {
  const _PrivatePhoneScreen({required this.kind});
  final _PrivatePhoneKind kind;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext ctx, BoxConstraints cons) {
        final double w = cons.maxWidth;
        final double h = cons.maxHeight;
        final double appBarH = 36;
        final List<Widget> layers = <Widget>[
          Positioned.fill(
            child: Container(color: _kPhoneScreen),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: appBarH,
            child: Container(
              color: _kPhoneAppBar,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: <Widget>[
                  Icon(
                    kind == _PrivatePhoneKind.endDrawerOpen ||
                            kind == _PrivatePhoneKind.endDrawerClosed
                        ? Icons.arrow_back
                        : Icons.menu,
                    color: Colors.white,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'AppBar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    kind == _PrivatePhoneKind.drawerOpen ||
                            kind == _PrivatePhoneKind.drawerClosed
                        ? Icons.more_vert
                        : Icons.menu,
                    color: Colors.white,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: appBarH,
            bottom: 0,
            child: _PrivatePhoneBody(kind: kind),
          ),
        ];
        // Drawer overlays
        if (kind == _PrivatePhoneKind.drawerOpen) {
          layers.add(Positioned(
            left: 0,
            right: 0,
            top: appBarH,
            bottom: 0,
            child: Container(color: _kPhoneScrim.withValues(alpha: 0.45)),
          ));
          layers.add(Positioned(
            left: 0,
            top: appBarH,
            bottom: 0,
            width: w * 0.65,
            child: _PrivateDrawerInside(side: 'start'),
          ));
        } else if (kind == _PrivatePhoneKind.endDrawerOpen) {
          layers.add(Positioned(
            left: 0,
            right: 0,
            top: appBarH,
            bottom: 0,
            child: Container(color: _kPhoneScrim.withValues(alpha: 0.45)),
          ));
          layers.add(Positioned(
            right: 0,
            top: appBarH,
            bottom: 0,
            width: w * 0.65,
            child: _PrivateDrawerInside(side: 'end'),
          ));
        }
        // Sheet overlays
        if (kind == _PrivatePhoneKind.sheetCollapsed) {
          layers.add(Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 36,
            child: _PrivateSheetSurface(label: 'handle'),
          ));
        } else if (kind == _PrivatePhoneKind.sheetExpanded) {
          layers.add(Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: h * 0.62,
            child: _PrivateSheetSurface(label: 'expanded'),
          ));
        } else if (kind == _PrivatePhoneKind.sheetDragging) {
          layers.add(Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: h * 0.36,
            child: _PrivateSheetSurface(label: 'dragging'),
          ));
        }
        return Stack(children: layers);
      },
    );
  }
}

class _PrivatePhoneBody extends StatelessWidget {
  const _PrivatePhoneBody({required this.kind});
  final _PrivatePhoneKind kind;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _PrivateBodyLine(width: 0.9),
          const SizedBox(height: 6),
          _PrivateBodyLine(width: 0.7),
          const SizedBox(height: 6),
          _PrivateBodyLine(width: 0.85),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              _PrivateBodyTile(),
              const SizedBox(width: 6),
              _PrivateBodyTile(),
              const SizedBox(width: 6),
              _PrivateBodyTile(),
            ],
          ),
          const SizedBox(height: 12),
          _PrivateBodyLine(width: 0.6),
          const SizedBox(height: 6),
          _PrivateBodyLine(width: 0.75),
          const Spacer(),
        ],
      ),
    );
  }
}

class _PrivateBodyLine extends StatelessWidget {
  const _PrivateBodyLine({required this.width});
  final double width;
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: width,
      child: Container(
        height: 7,
        decoration: BoxDecoration(
          color: _kRule,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}

class _PrivateBodyTile extends StatelessWidget {
  const _PrivateBodyTile();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          color: _kBg,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: _kRule),
        ),
      ),
    );
  }
}

class _PrivateDrawerInside extends StatelessWidget {
  const _PrivateDrawerInside({required this.side});
  final String side;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kPhoneDrawer,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 56,
            decoration: BoxDecoration(
              color: side == 'start' ? _kAccentSoft : _kPurpleSoft,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              side == 'start' ? 'drawer header' : 'endDrawer header',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: side == 'start' ? _kAccent : _kPurple,
              ),
            ),
          ),
          const SizedBox(height: 8),
          ...List<Widget>.generate(5, (int i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: _kRule,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: _kRule,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _PrivateSheetSurface extends StatelessWidget {
  const _PrivateSheetSurface({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kPhoneSheet,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.18),
            blurRadius: 14,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #130, P-LayoutBuilder
      // adaptive): the collapsed sheet variant (height: 36 → 20 px inner)
      // cannot fit the fixed children (drag-handle 4 + sb 6 + label text ~14
      // + sb 4 ≈ 28 px) plus the Expanded filler, firing "RenderFlex overflow
      // ~9 px on the bottom". A LayoutBuilder selects between a *compact*
      // layout (drag handle only — fits 20 px) when inner height < 28 px and
      // the *full* layout (drag handle + label + filler) for the dragging /
      // expanded variants (which have ~97 / ~205 px inner height). All
      // visuals are preserved: the drag handle is always visible (the
      // pedagogical "this is a sheet surface" cue); the label text appears
      // only when there is room; the paper-coloured filler box appears only
      // for the larger variants where it is visually meaningful.
      child: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints cons) {
          final bool compact = cons.maxHeight < 28;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: _kInkMuted.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              if (!compact) ...<Widget>[
                const SizedBox(height: 6),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10,
                    color: _kInkMuted,
                    fontFamily: _kMono,
                  ),
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: _kBg,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _kRule),
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _PrivateNoteBanner extends StatelessWidget {
  const _PrivateNoteBanner({
    required this.color,
    required this.icon,
    required this.title,
    required this.body,
  });
  final Color color;
  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    color: _kInkSoft,
                    fontSize: 12.5,
                    height: 1.45,
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

// =============================================================================
// 4. BOTTOM SHEET MOCK — three phone frames
// =============================================================================

class _PrivateBottomSheetMock extends StatelessWidget {
  const _PrivateBottomSheetMock();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _PrivateSectionHeader(
          index: '4',
          title: 'showBottomSheet — visual states',
          subtitle:
              'Persistent bottom sheets are part of the Scaffold body region. '
              'They scroll the FAB up when expanded.',
          color: _kTeal,
        ),
        _PrivateCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: <Widget>[
                  _PrivatePhoneMock(
                    title: 'collapsed handle',
                    subtitle: 'visible peek only',
                    kind: _PrivatePhoneKind.sheetCollapsed,
                    accent: _kInkMuted,
                  ),
                  _PrivatePhoneMock(
                    title: 'dragging up',
                    subtitle: 'mid-animation',
                    kind: _PrivatePhoneKind.sheetDragging,
                    accent: _kWarn,
                  ),
                  _PrivatePhoneMock(
                    title: 'fully expanded',
                    subtitle: 'controller.closed unresolved',
                    kind: _PrivatePhoneKind.sheetExpanded,
                    accent: _kTeal,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _PrivateNoteBanner(
                color: _kTeal,
                icon: Icons.swipe_vertical_outlined,
                title: 'showBottomSheet returns a controller',
                body:
                    'The PersistentBottomSheetController gives you `.close()` '
                    'to dismiss imperatively, and `.closed` (a Future) that '
                    'completes when the user drags the sheet away. In this '
                    'demo we describe it without invoking it.',
              ),
              const SizedBox(height: 12),
              _PrivateCodeBlock(
                code: '''final controller = scaffoldState.showBottomSheet<void>(
  (BuildContext ctx) => const SizedBox(
    height: 240,
    child: Center(child: Text('Persistent sheet')),
  ),
);

// later, somewhere else:
controller.close();''',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// Code block primitive
// =============================================================================

class _PrivateCodeBlock extends StatelessWidget {
  const _PrivateCodeBlock({required this.code});
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0B1220),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kInk.withValues(alpha: 0.2)),
      ),
      child: SelectableText(
        code,
        style: const TextStyle(
          color: Color(0xFFE2E8F0),
          fontFamily: _kMono,
          fontSize: 12.5,
          height: 1.45,
        ),
      ),
    );
  }
}

// =============================================================================
// 5. MESSENGER DEPRECATION PANEL
// =============================================================================

class _PrivateMessengerDeprecationPanel extends StatelessWidget {
  const _PrivateMessengerDeprecationPanel();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _PrivateSectionHeader(
          index: '5',
          title: 'ScaffoldMessenger — the modern way',
          subtitle:
              'showSnackBar on ScaffoldState is deprecated. ScaffoldMessenger '
              'lives above the Scaffold and survives route transitions.',
          color: _kWarn,
        ),
        _PrivateCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #130, P1):
              // Row(crossAxisAlignment.stretch) inside the page-root
              // SCV > Column(stretch) chain receives unbounded vertical
              // constraints; stretch then demands a tight height which would
              // be infinite, firing "BoxConstraints forces an infinite height".
              // IntrinsicHeight resolves the cross-axis height to the tallest
              // child's intrinsic height before stretch fires — visual
              // (two height-matched _PrivateBeforeAfterCard panels) preserved.
              IntrinsicHeight(child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: _PrivateBeforeAfterCard(
                      header: 'Before — deprecated',
                      tone: _kBad,
                      toneSoft: _kBadSoft,
                      icon: Icons.warning_amber_outlined,
                      code: '''// This still works but is deprecated.
Scaffold.of(context).showSnackBar(
  const SnackBar(content: Text('saved!')),
);''',
                      bullets: const <String>[
                        'Scoped to one Scaffold widget.',
                        'Disappears if the route is replaced before the snack bar finishes.',
                        'Issues an analyzer warning under deprecated_member_use.',
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _PrivateBeforeAfterCard(
                      header: 'After — preferred',
                      tone: _kGood,
                      toneSoft: _kGoodSoft,
                      icon: Icons.verified_outlined,
                      code: '''ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(content: Text('saved!')),
);''',
                      bullets: const <String>[
                        'Scoped to the messenger subtree (default: MaterialApp).',
                        'Snack bar can outlive the originating route.',
                        'Returns a ScaffoldFeatureController for hide/remove.',
                      ],
                    ),
                  ),
                ],
              )),
              const SizedBox(height: 18),
              _PrivateNoteBanner(
                color: _kWarn,
                icon: Icons.history_edu_outlined,
                title: 'Why the move?',
                body:
                    'Snack bars frequently outlive the screen that emits them. '
                    'The messenger lives one tier up, so navigating away does '
                    'not yank the message off-screen.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PrivateBeforeAfterCard extends StatelessWidget {
  const _PrivateBeforeAfterCard({
    required this.header,
    required this.tone,
    required this.toneSoft,
    required this.icon,
    required this.code,
    required this.bullets,
  });
  final String header;
  final Color tone;
  final Color toneSoft;
  final IconData icon;
  final String code;
  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: toneSoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tone.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: tone, size: 18),
              const SizedBox(width: 8),
              Text(
                header,
                style: TextStyle(
                  color: tone,
                  fontWeight: FontWeight.w700,
                  fontSize: 13.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _PrivateCodeBlock(code: code),
          const SizedBox(height: 10),
          ...bullets.map((String b) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: tone,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      b,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: _kInkSoft,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

// =============================================================================
// 6. LOOKUP TRIPTYCH — Scaffold.of vs Scaffold.maybeOf vs GlobalKey
// =============================================================================

class _PrivateLookupTriptych extends StatelessWidget {
  const _PrivateLookupTriptych();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _PrivateSectionHeader(
          index: '6',
          title: 'Three ways to reach the ScaffoldState',
          subtitle:
              'Pick the lookup style that matches your tolerance for missing '
              'ancestors and your need to keep a stable handle.',
          color: _kPurple,
        ),
        _PrivateCard(
          padding: const EdgeInsets.all(20),
          child: LayoutBuilder(
            builder: (BuildContext ctx, BoxConstraints cons) {
              final bool wide = cons.maxWidth > 880;
              final List<Widget> cards = <Widget>[
                _PrivateLookupCard(
                  title: 'Scaffold.of(context)',
                  badge: 'strict',
                  badgeColor: _kBad,
                  bullets: const <String>[
                    'Throws FlutterError if no Scaffold ancestor is found.',
                    'Use when you are sure the surrounding Scaffold exists.',
                    'Preferred form inside callbacks of children.',
                  ],
                  code: '''// Inside a child of Scaffold:
final state = Scaffold.of(context);
state.openDrawer();''',
                ),
                _PrivateLookupCard(
                  title: 'Scaffold.maybeOf(context)',
                  badge: 'tolerant',
                  badgeColor: _kWarn,
                  bullets: const <String>[
                    'Returns null instead of throwing.',
                    'Useful for shared widgets reused outside Scaffold.',
                    'You must null-check before calling methods on it.',
                  ],
                  code: '''final ScaffoldState? state =
    Scaffold.maybeOf(context);
state?.openEndDrawer();''',
                ),
                _PrivateLookupCard(
                  title: 'GlobalKey<ScaffoldState>',
                  badge: 'stable handle',
                  badgeColor: _kGood,
                  bullets: const <String>[
                    'Attach the key to the Scaffold itself.',
                    'Survives rebuilds, no BuildContext required at call time.',
                    'Tradeoff: GlobalKeys are heavier than InheritedWidget lookups.',
                  ],
                  code: '''final GlobalKey<ScaffoldState> _scaffoldKey =
    GlobalKey<ScaffoldState>();

Scaffold(
  key: _scaffoldKey,
  drawer: const Drawer(),
  body: ...,
);

// later:
_scaffoldKey.currentState?.openDrawer();''',
                ),
              ];
              if (wide) {
                // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #130, P1):
                // Row(stretch)+Expanded inside SCV-descended Column chain;
                // IntrinsicHeight bounds the cross-axis height to the tallest
                // card before stretch demands an infinite tight height.
                return IntrinsicHeight(child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    for (int i = 0; i < cards.length; i++) ...<Widget>[
                      Expanded(child: cards[i]),
                      if (i != cards.length - 1) const SizedBox(width: 16),
                    ],
                  ],
                ));
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  for (int i = 0; i < cards.length; i++) ...<Widget>[
                    cards[i],
                    if (i != cards.length - 1) const SizedBox(height: 16),
                  ],
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PrivateLookupCard extends StatelessWidget {
  const _PrivateLookupCard({
    required this.title,
    required this.badge,
    required this.badgeColor,
    required this.bullets,
    required this.code,
  });
  final String title;
  final String badge;
  final Color badgeColor;
  final List<String> bullets;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kRule),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: _kMono,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: _kInk,
                  ),
                ),
              ),
              _PrivateBadge(
                label: badge,
                fg: badgeColor,
                bg: badgeColor.withValues(alpha: 0.12),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _PrivateCodeBlock(code: code),
          const SizedBox(height: 10),
          ...bullets.map((String b) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: badgeColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      b,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: _kInkSoft,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

// =============================================================================
// 7. LIFECYCLE / STATE FLOW DIAGRAM
// =============================================================================

class _PrivateLifecycleFlowDiagram extends StatelessWidget {
  const _PrivateLifecycleFlowDiagram();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _PrivateSectionHeader(
          index: '7',
          title: 'Lifecycle — openDrawer triggers an animation',
          subtitle:
              'isDrawerOpen does not flip synchronously. The animation is the '
              'state transition; the predicate is what observers read.',
          color: _kAccent,
        ),
        _PrivateCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _PrivateFlowRow(
                steps: const <_PrivateFlowStep>[
                  _PrivateFlowStep(
                    color: _kAccent,
                    label: 'openDrawer()',
                    detail: 'Caller invokes the method.',
                  ),
                  _PrivateFlowStep(
                    color: _kPurple,
                    label: 'AnimationController',
                    detail: 'Controller starts forward.',
                  ),
                  _PrivateFlowStep(
                    color: _kTeal,
                    label: 'frame tick',
                    detail: 'Drawer slides in across frames.',
                  ),
                  _PrivateFlowStep(
                    color: _kGood,
                    label: 'isDrawerOpen → true',
                    detail: 'Predicate flips when visible.',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _PrivateFlowRow(
                steps: const <_PrivateFlowStep>[
                  _PrivateFlowStep(
                    color: _kBad,
                    label: 'closeDrawer()',
                    detail: 'Caller invokes the close.',
                  ),
                  _PrivateFlowStep(
                    color: _kPurple,
                    label: 'controller.reverse()',
                    detail: 'Animation runs backward.',
                  ),
                  _PrivateFlowStep(
                    color: _kTeal,
                    label: 'frame tick',
                    detail: 'Drawer slides out across frames.',
                  ),
                  _PrivateFlowStep(
                    color: _kInkMuted,
                    label: 'isDrawerOpen → false',
                    detail: 'Predicate flips when hidden.',
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _PrivateNoteBanner(
                color: _kAccent,
                icon: Icons.timeline_outlined,
                title: 'Practical implication',
                body:
                    'If you call openDrawer() and then immediately read '
                    'isDrawerOpen on the next line, the value may still be '
                    'false — the open animation has not yet started its first '
                    'frame. Read the predicate after a frame, or rely on the '
                    'returned controller events instead.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PrivateFlowStep {
  const _PrivateFlowStep({
    required this.color,
    required this.label,
    required this.detail,
  });
  final Color color;
  final String label;
  final String detail;
}

class _PrivateFlowRow extends StatelessWidget {
  const _PrivateFlowRow({required this.steps});
  final List<_PrivateFlowStep> steps;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext ctx, BoxConstraints cons) {
        final bool wide = cons.maxWidth > 720;
        if (!wide) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              for (int i = 0; i < steps.length; i++) ...<Widget>[
                _PrivateFlowChip(step: steps[i]),
                if (i != steps.length - 1)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Icon(Icons.arrow_downward,
                        color: _kInkMuted, size: 16),
                  ),
              ],
            ],
          );
        }
        // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #130, P1):
        // Row(stretch)+Expanded inside SCV-descended Column chain;
        // IntrinsicHeight resolves the cross-axis height to the tallest
        // flow chip before stretch demands an infinite tight height.
        return IntrinsicHeight(child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            for (int i = 0; i < steps.length; i++) ...<Widget>[
              Expanded(child: _PrivateFlowChip(step: steps[i])),
              if (i != steps.length - 1)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Icon(Icons.arrow_forward,
                      color: _kInkMuted, size: 18),
                ),
            ],
          ],
        ));
      },
    );
  }
}

class _PrivateFlowChip extends StatelessWidget {
  const _PrivateFlowChip({required this.step});
  final _PrivateFlowStep step;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: step.color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: step.color.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            step.label,
            style: TextStyle(
              fontFamily: _kMono,
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: step.color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            step.detail,
            style: const TextStyle(
              fontSize: 11.5,
              color: _kInkSoft,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 8. CODE LISTING CARD — real Scaffold.of(context) example
// =============================================================================

class _PrivateCodeListingCard extends StatelessWidget {
  const _PrivateCodeListingCard();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _PrivateSectionHeader(
          index: '8',
          title: 'Real-world snippet — drawer toggle button',
          subtitle:
              'A leaf widget that opens the start drawer when tapped, '
              'tolerating the absence of a Scaffold ancestor.',
          color: _kPurple,
        ),
        _PrivateCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _PrivateCodeBlock(
                code: '''class _MenuButton extends StatelessWidget {
  const _MenuButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu),
      tooltip: 'Open drawer',
      onPressed: () {
        // We are inside the Scaffold body, so .of is safe.
        final ScaffoldState scaffold = Scaffold.of(context);
        if (scaffold.hasDrawer && !scaffold.isDrawerOpen) {
          scaffold.openDrawer();
        }
      },
    );
  }
}''',
              ),
              const SizedBox(height: 14),
              _PrivateCallChainDiagram(),
              const SizedBox(height: 14),
              _PrivateNoteBanner(
                color: _kPurple,
                icon: Icons.lightbulb_outline,
                title: 'Why combine hasDrawer and !isDrawerOpen?',
                body:
                    'Calling openDrawer() on a Scaffold without a drawer is a '
                    'silent no-op, but the guard documents intent. Skipping '
                    'the call when already open avoids restarting the '
                    'animation from a partial position.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PrivateCallChainDiagram extends StatelessWidget {
  const _PrivateCallChainDiagram();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kRule),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Call chain',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: _kInk,
            ),
          ),
          const SizedBox(height: 10),
          _PrivateCallStep(
            label: 'IconButton.onPressed',
            sub: 'tap event from gesture detector',
            tone: _kAccent,
          ),
          _PrivateCallArrow(),
          _PrivateCallStep(
            label: 'Scaffold.of(context)',
            sub: 'walks up to the nearest ScaffoldState',
            tone: _kPurple,
          ),
          _PrivateCallArrow(),
          _PrivateCallStep(
            label: 'scaffold.hasDrawer && !isDrawerOpen',
            sub: 'guard: only when drawer exists and is closed',
            tone: _kTeal,
          ),
          _PrivateCallArrow(),
          _PrivateCallStep(
            label: 'scaffold.openDrawer()',
            sub: 'starts the animation controller forward',
            tone: _kGood,
          ),
        ],
      ),
    );
  }
}

class _PrivateCallStep extends StatelessWidget {
  const _PrivateCallStep({
    required this.label,
    required this.sub,
    required this.tone,
  });
  final String label;
  final String sub;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: tone,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: _kMono,
                    fontSize: 12.5,
                    color: tone,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  sub,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: _kInkSoft,
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

class _PrivateCallArrow extends StatelessWidget {
  const _PrivateCallArrow();
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Icon(Icons.arrow_downward, size: 14, color: _kInkMuted),
    );
  }
}

// =============================================================================
// 9. PITFALLS PANEL
// =============================================================================

class _PrivatePitfallsPanel extends StatelessWidget {
  const _PrivatePitfallsPanel();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _PrivateSectionHeader(
          index: '9',
          title: 'Pitfalls',
          subtitle:
              'The two patterns that account for most ScaffoldState bugs in '
              'the wild.',
          color: _kBad,
        ),
        _PrivateCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              _PrivatePitfallCard(
                title: 'Calling Scaffold.of(context) from the Scaffold owner',
                bad:
                    'You build the Scaffold and then in the same build() call '
                    'Scaffold.of(context). This walks up from the same '
                    'context and finds nothing, throwing FlutterError.',
                good:
                    'Wrap in a Builder, or split the action into a child '
                    'widget. Children of the Scaffold see the InheritedWidget '
                    'and Scaffold.of works.',
                badCode: '''Scaffold(
  body: ElevatedButton(
    onPressed: () {
      // BAD: this context is the parent of the Scaffold,
      // not a descendant. Throws.
      Scaffold.of(context).openDrawer();
    },
    child: const Text('Open'),
  ),
);''',
                goodCode: '''Scaffold(
  body: Builder(
    builder: (innerCtx) => ElevatedButton(
      onPressed: () => Scaffold.of(innerCtx).openDrawer(),
      child: const Text('Open'),
    ),
  ),
);''',
              ),
              SizedBox(height: 16),
              _PrivatePitfallCard(
                title: 'Treating hasDrawer like isDrawerOpen',
                bad:
                    'hasDrawer is true whenever the Scaffold was *given* a '
                    'drawer parameter. It says nothing about whether the '
                    'drawer is currently visible.',
                good:
                    'For animation-aware code, gate on isDrawerOpen. For '
                    'configuration-aware code (e.g., is there even a drawer '
                    'icon to render?), gate on hasDrawer.',
                badCode: '''if (scaffold.hasDrawer) {
  // BAD: triggers even when the drawer is already open.
  scaffold.openDrawer();
}''',
                goodCode: '''if (scaffold.hasDrawer && !scaffold.isDrawerOpen) {
  scaffold.openDrawer();
}''',
              ),
              SizedBox(height: 16),
              _PrivatePitfallCard(
                title: 'Holding a ScaffoldState across rebuilds',
                bad:
                    'Caching the result of Scaffold.of(context) into a field '
                    'is fragile. After a rebuild, the State element may have '
                    'been re-attached and your reference is stale.',
                good:
                    'Either look up via Scaffold.of(context) at call time, '
                    'or attach a GlobalKey<ScaffoldState> to the Scaffold and '
                    'go through key.currentState — that is what the GlobalKey '
                    'mechanism is designed for.',
                badCode: '''late ScaffoldState _cached;
@override
void initState() {
  super.initState();
  // BAD: context not yet attached.
  _cached = Scaffold.of(context);
}''',
                goodCode: '''final GlobalKey<ScaffoldState> _key =
    GlobalKey<ScaffoldState>();

// later:
_key.currentState?.openDrawer();''',
              ),
              SizedBox(height: 16),
              _PrivatePitfallCard(
                title: 'Looking for showFloatingActionButton — it does not exist',
                bad:
                    'There is no showFloatingActionButton method on '
                    'ScaffoldState. The FAB is configured statically as the '
                    'Scaffold.floatingActionButton parameter.',
                good:
                    'Drive FAB visibility by changing the parameter on the '
                    'Scaffold widget itself. Flutter will animate the in/out '
                    'transition for you when the parameter changes.',
                badCode: '''// Doesn't compile — no such method.
scaffold.showFloatingActionButton(...);''',
                goodCode: '''Scaffold(
  floatingActionButton: showFab
      ? FloatingActionButton(
          onPressed: _onFab,
          child: const Icon(Icons.add),
        )
      : null,
  body: ...,
);''',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PrivatePitfallCard extends StatelessWidget {
  const _PrivatePitfallCard({
    required this.title,
    required this.bad,
    required this.good,
    required this.badCode,
    required this.goodCode,
  });
  final String title;
  final String bad;
  final String good;
  final String badCode;
  final String goodCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kRule),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.error_outline, color: _kBad, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _kInk,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (BuildContext ctx, BoxConstraints cons) {
              final bool wide = cons.maxWidth > 720;
              final Widget badPanel = _PrivatePitfallSide(
                tone: _kBad,
                toneSoft: _kBadSoft,
                heading: 'Pitfall',
                body: bad,
                code: badCode,
                icon: Icons.close,
              );
              final Widget goodPanel = _PrivatePitfallSide(
                tone: _kGood,
                toneSoft: _kGoodSoft,
                heading: 'Better',
                body: good,
                code: goodCode,
                icon: Icons.check,
              );
              if (wide) {
                // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #130, P1):
                // Row(stretch)+Expanded inside SCV-descended Column chain;
                // IntrinsicHeight bounds cross-axis height to the taller of
                // (badPanel, goodPanel) before stretch fires.
                return IntrinsicHeight(child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(child: badPanel),
                    const SizedBox(width: 12),
                    Expanded(child: goodPanel),
                  ],
                ));
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  badPanel,
                  const SizedBox(height: 12),
                  goodPanel,
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PrivatePitfallSide extends StatelessWidget {
  const _PrivatePitfallSide({
    required this.tone,
    required this.toneSoft,
    required this.heading,
    required this.body,
    required this.code,
    required this.icon,
  });
  final Color tone;
  final Color toneSoft;
  final String heading;
  final String body;
  final String code;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: toneSoft,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: tone, size: 16),
              const SizedBox(width: 6),
              Text(
                heading,
                style: TextStyle(
                  color: tone,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: const TextStyle(
              fontSize: 12.5,
              color: _kInkSoft,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 10),
          _PrivateCodeBlock(code: code),
        ],
      ),
    );
  }
}

// =============================================================================
// 10. FOOTER
// =============================================================================

class _PrivateFooter extends StatelessWidget {
  const _PrivateFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kRule),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.menu_book_outlined, color: _kAccent, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'ScaffoldState — visual deep demo',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _kInk,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Hand-authored fixture for the d4rt analyzer-free interpreter '
                  'corpus. No runtime side effects, no mutation, no async.',
                  style: TextStyle(
                    fontSize: 12,
                    color: _kInkMuted,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          _PrivateBadge(
            label: 'static',
            fg: _kInkMuted,
            bg: _kBg,
          ),
          const SizedBox(width: 8),
          _PrivateBadge(
            label: 'analyzer-clean',
            fg: _kGood,
            bg: _kGoodSoft,
          ),
        ],
      ),
    );
  }
}

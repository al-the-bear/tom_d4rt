// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
// Material 3 Badge — Deep Visual Demo
// -----------------------------------------------------------------------------
// A hand-authored gallery for the Tom D4rt flutter_ast HTTP test corpus.
// Renders an opinionated tour of the Material Badge widget: dot mode, label
// mode, count mode with overflow, navigation surfaces, alignment grid,
// themed wrappers via BadgeThemeData, anatomy diagram, decision matrix,
// code snippet card, and a swatch palette for stylistic exploration.
//
// Goals:
//   * Demonstrate every observable knob of `Badge` and `Badge.count`.
//   * Show how `BadgeThemeData` cascades through `Theme` wrappers.
//   * Provide enough visual structure that the AST snapshot is meaningful
//     to humans reading the rendered output, not just the parser.
//
// The build function is a pure widget tree — no async, no controllers, no
// timers. Localised interactivity uses `StatefulBuilder` so that scoped
// state (a count slider, a toggle for dot mode) lives next to its UI.
// =============================================================================

import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// Palette constants
// -----------------------------------------------------------------------------
// A curated palette used across cards. Centralising these values keeps the
// gradient and shadow declarations dense without scattering magic numbers.

const Color _inkDeep = Color(0xFF101326);
const Color _inkMid = Color(0xFF1F2440);
const Color _inkSoft = Color(0xFF2C325A);
const Color _paperLight = Color(0xFFFBFAF7);
const Color _paperWarm = Color(0xFFFFF3E8);
const Color _paperCool = Color(0xFFEDF3FF);
const Color _accentMagenta = Color(0xFFE8447F);
const Color _accentTangerine = Color(0xFFFF8A3D);
const Color _accentMint = Color(0xFF34C9A1);
const Color _accentLagoon = Color(0xFF3BA7C9);
const Color _accentIris = Color(0xFF7A6CF0);
const Color _accentRose = Color(0xFFD96289);
const Color _accentSlate = Color(0xFF4E5A8A);
const Color _accentLemon = Color(0xFFE9C46A);

// -----------------------------------------------------------------------------
// Top level harness
// -----------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('Badge deep visual demo: build() entered');

  final sections = <Widget>[
    _heroBanner(),
    _basicModesCard(),
    _countOverflowCard(),
    _navigationSurfacesCard(),
    _alignmentGridCard(),
    _offsetExplorerCard(),
    _badgeThemeWrapperCard(),
    _anatomyDiagramCard(),
    _decisionMatrixCard(),
    _codeSnippetCard(),
    _paletteWrapCard(),
    _interactiveCountCard(),
    _accessibilityCard(),
    _closingNote(),
  ];

  print('Badge deep visual demo: ${sections.length} sections assembled');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Badge Deep Visual Demo',
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _accentIris,
      brightness: Brightness.light,
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF4F5FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              for (int i = 0; i < sections.length; i++) ...<Widget>[
                sections[i],
                if (i != sections.length - 1) const SizedBox(height: 26),
              ],
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// Section: Hero banner
// =============================================================================
//
// The hero banner introduces the Badge widget with a stacked title, subtitle,
// and a row of demo badges. It uses a saturated diagonal gradient and a
// double-shadow to feel like a glossy header card. The badges shown here
// preview the three primary "modes" the rest of the gallery dives into:
// dot, label, and count with overflow.
// =============================================================================

Widget _heroBanner() {
  return Container(
    padding: const EdgeInsets.fromLTRB(26, 28, 26, 26),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_accentIris, _accentMagenta, _accentTangerine],
        stops: <double>[0.0, 0.55, 1.0],
      ),
      borderRadius: BorderRadius.circular(24),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _accentMagenta.withValues(alpha: 0.32),
          blurRadius: 28,
          offset: const Offset(0, 14),
        ),
        BoxShadow(
          color: _accentIris.withValues(alpha: 0.18),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                'MATERIAL 3 • BADGE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  letterSpacing: 1.6,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Spacer(),
            const Icon(Icons.auto_awesome, color: Colors.white, size: 22),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Badge — a tiny status overlay\nfor icons and surfaces',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            height: 1.18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Badges call out unseen items, pending counts and live status without '
          'stealing focus from the underlying control. They sit above icons, '
          'navigation chips and avatars, communicating in a single coloured '
          'glyph what would otherwise require a full sentence of UI copy. The '
          'sections below dissect every visible knob — alignment, offset, '
          'theming, count overflow — so a designer can pattern-match shape '
          'and tone, while an engineer can read the wiring next to the visual.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.92),
            fontSize: 13,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const _HeroBadgeChip(
              icon: Icons.mail_outline,
              label: 'dot',
              badge: Badge(child: Icon(Icons.mail_outline,
                  size: 30, color: Colors.white)),
            ),
            const _HeroBadgeChip(
              icon: Icons.notifications_outlined,
              label: 'label',
              badge: Badge(
                label: Text('NEW'),
                child: Icon(Icons.notifications_outlined,
                    size: 30, color: Colors.white),
              ),
            ),
            _HeroBadgeChip(
              icon: Icons.shopping_cart_outlined,
              label: 'count',
              badge: Badge.count(
                count: 42,
                child: const Icon(Icons.shopping_cart_outlined,
                    size: 30, color: Colors.white),
              ),
            ),
            _HeroBadgeChip(
              icon: Icons.inbox_outlined,
              label: 'overflow',
              badge: Badge.count(
                count: 1000,
                child: const Icon(Icons.inbox_outlined,
                    size: 30, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class _HeroBadgeChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget badge;
  const _HeroBadgeChip({
    required this.icon,
    required this.label,
    required this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        badge,
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            letterSpacing: 1.1,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// Section: Basic modes
// =============================================================================
//
// Three flavours of Badge live side by side: the dot indicator (a four-pixel
// circle that just whispers "something new"), the label variant (an arbitrary
// child widget rendered as a pill), and the count constructor with both small
// and overflowing values. Looking at all three at once is the clearest way to
// see how Badge changes silhouette depending on which named arguments are
// supplied.
// =============================================================================

Widget _basicModesCard() {
  return _SectionCard(
    title: 'Basic modes',
    subtitle: 'dot • label • Badge.count',
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[_paperLight, _paperCool],
    ),
    shadowColor: _accentLagoon,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _BodyProse(
          'A Badge with no `label` argument renders as a tiny solid dot, sized '
          'by `smallSize`. Supply `label:` with any widget — typically a short '
          'Text — to switch to pill mode, where Material picks `largeSize` and '
          'horizontal padding suitable for one to three glyphs. The named '
          '`Badge.count` constructor wraps an integer into the label slot and '
          'automatically swaps in `999+` when the value exceeds the standard '
          'count limit. The three rows below show those three modes lined up '
          'against the same icon for direct silhouette comparison.',
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const _LabelledTile(
              caption: 'Badge()',
              child: Badge(
                child: Icon(Icons.email_outlined,
                    size: 36, color: _inkMid),
              ),
            ),
            const _LabelledTile(
              caption: 'Badge(label:)',
              child: Badge(
                label: Text('3'),
                child: Icon(Icons.email_outlined,
                    size: 36, color: _inkMid),
              ),
            ),
            _LabelledTile(
              caption: 'Badge.count(7)',
              child: Badge.count(
                count: 7,
                child: const Icon(Icons.email_outlined,
                    size: 36, color: _inkMid),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _LabelledTile(
              caption: 'count: 99',
              child: Badge.count(
                count: 99,
                child: const Icon(Icons.shopping_cart_outlined,
                    size: 36, color: _inkMid),
              ),
            ),
            _LabelledTile(
              caption: 'count: 100',
              child: Badge.count(
                count: 100,
                child: const Icon(Icons.shopping_cart_outlined,
                    size: 36, color: _inkMid),
              ),
            ),
            _LabelledTile(
              caption: 'count: 1000',
              child: Badge.count(
                count: 1000,
                child: const Icon(Icons.shopping_cart_outlined,
                    size: 36, color: _inkMid),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// Section: Count overflow
// =============================================================================
//
// Material's Badge.count uses an internal threshold and renders "999+" once
// the count exceeds it. To make that ramp visible at a glance, this section
// stamps several powers-of-ten counts in a row and annotates each with the
// produced label text. The colour-coded chips below the row make the rollover
// behaviour explicit, so consumers can pick a custom label if they need a
// non-default overflow string such as "9k+" or "lots".
// =============================================================================

Widget _countOverflowCard() {
  final counts = <int>[1, 9, 25, 99, 100, 250, 999, 1000, 9999];
  return _SectionCard(
    title: 'Count overflow ramp',
    subtitle: '1 → 9999',
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Color(0xFFFFF7E6), Color(0xFFFFE3D2)],
    ),
    shadowColor: _accentTangerine,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _BodyProse(
          'Badge.count clamps its visible label at a built-in threshold and '
          'falls back to a "+" suffix. The exact pivot point is enforced by '
          'Material so that single-line layouts do not jump width when a '
          'counter ticks from two to three digits. The ramp below shows the '
          'visual progression: notice how the pill width stays steady once '
          'overflow kicks in, and how custom backgrounds combine with the '
          'default text colour to produce a calm read.',
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 18,
          runSpacing: 18,
          children: <Widget>[
            for (final c in counts)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Badge.count(
                    count: c,
                    backgroundColor: _accentTangerine,
                    child: Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: _accentTangerine.withValues(alpha: 0.22),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.inbox_outlined,
                          color: _inkMid),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'count: $c',
                    style: const TextStyle(
                      fontSize: 11,
                      color: _inkSoft,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// Section: Navigation surfaces
// =============================================================================
//
// Badges show up most frequently on navigation surfaces: tab bars, drawer
// items, app bar icon buttons, navigation rails. This section renders four
// such surfaces so the badge's behaviour as a child of each can be inspected.
// Each row pairs the destination/icon with a short prose note describing the
// idiomatic use case.
// =============================================================================

Widget _navigationSurfacesCard() {
  return _SectionCard(
    title: 'On navigation surfaces',
    subtitle: 'NavigationBar • BottomNavigationBar • IconButton • Avatar',
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Color(0xFFEAF3FF), Color(0xFFD9E3FF)],
    ),
    shadowColor: _accentSlate,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _BodyProse(
          'Material 3 navigation widgets accept badge-decorated children '
          'directly. The NavigationBar destination supports its own '
          '`NavigationDestination` slot but a plain Badge around an Icon is '
          'still the easiest route for ad-hoc indicators. App bar IconButtons '
          'and floating avatars also lean on Badge to communicate unread '
          'counts. The mini-surfaces below are fully laid out, so the AST '
          'consumer sees how badges nest inside complex parents.',
        ),
        const SizedBox(height: 18),
        _MiniSurface(
          caption: 'NavigationBar with badges on Inbox and Updates',
          child: NavigationBar(
            selectedIndex: 1,
            backgroundColor: Colors.white,
            indicatorColor: _accentIris.withValues(alpha: 0.18),
            onDestinationSelected: (_) {},
            destinations: const <NavigationDestination>[
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Badge(
                  label: Text('12'),
                  child: Icon(Icons.inbox_outlined),
                ),
                selectedIcon: Badge(
                  label: Text('12'),
                  child: Icon(Icons.inbox),
                ),
                label: 'Inbox',
              ),
              NavigationDestination(
                icon: Badge(child: Icon(Icons.update_outlined)),
                selectedIcon: Badge(child: Icon(Icons.update)),
                label: 'Updates',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outlined),
                selectedIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        _MiniSurface(
          caption: 'BottomNavigationBar with overflowing count',
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: _accentMagenta,
            unselectedItemColor: _inkSoft,
            currentIndex: 0,
            onTap: (_) {},
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
                label: 'Dash',
              ),
              BottomNavigationBarItem(
                icon: Badge.count(
                  count: 1042,
                  child: const Icon(Icons.mail_outline),
                ),
                label: 'Mail',
              ),
              const BottomNavigationBarItem(
                icon: Badge(
                  label: Text('LIVE'),
                  backgroundColor: _accentMint,
                  textColor: Colors.white,
                  child: Icon(Icons.videocam_outlined),
                ),
                label: 'Live',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: 'Settings',
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        _MiniSurface(
          caption: 'AppBar IconButtons with mixed badge modes',
          child: Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: const Badge(
                    child: Icon(Icons.notifications_outlined),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Badge.count(
                    count: 3,
                    child: const Icon(Icons.message_outlined),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Badge(
                    label: Text('!'),
                    backgroundColor: _accentTangerine,
                    child: Icon(Icons.warning_amber_outlined),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Badge(
                    label: Text('PRO'),
                    backgroundColor: _accentIris,
                    textColor: Colors.white,
                    child: Icon(Icons.star_outline),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),
        _MiniSurface(
          caption: 'Avatar with badge corner status',
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Badge(
                  alignment: AlignmentDirectional.bottomEnd,
                  backgroundColor: _accentMint,
                  child: CircleAvatar(
                    radius: 26,
                    backgroundColor: _accentLagoon.withValues(alpha: 0.2),
                    child: const Icon(Icons.person, color: _inkMid),
                  ),
                ),
                Badge(
                  alignment: AlignmentDirectional.bottomEnd,
                  backgroundColor: _accentLemon,
                  child: CircleAvatar(
                    radius: 26,
                    backgroundColor: _accentTangerine.withValues(alpha: 0.2),
                    child: const Icon(Icons.person_2, color: _inkMid),
                  ),
                ),
                Badge(
                  alignment: AlignmentDirectional.bottomEnd,
                  backgroundColor: _accentSlate,
                  child: CircleAvatar(
                    radius: 26,
                    backgroundColor: _accentSlate.withValues(alpha: 0.2),
                    child: const Icon(Icons.person_3, color: _inkMid),
                  ),
                ),
                Badge.count(
                  count: 5,
                  alignment: AlignmentDirectional.bottomEnd,
                  child: CircleAvatar(
                    radius: 26,
                    backgroundColor: _accentMagenta.withValues(alpha: 0.2),
                    child: const Icon(Icons.person_4, color: _inkMid),
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

// =============================================================================
// Section: Alignment grid
// =============================================================================
//
// Badge exposes an `alignment` argument that takes any `AlignmentGeometry`.
// In practice the four corner directions are the most useful, but Material
// will honour any value, including centre. The grid below stamps the canonical
// corners plus a couple of unusual variants — top-centre and centre — so the
// reader can see what "overlay at an arbitrary alignment" produces visually.
// =============================================================================

Widget _alignmentGridCard() {
  final entries = <(String, AlignmentGeometry)>[
    ('topStart', AlignmentDirectional.topStart),
    ('topCenter', AlignmentDirectional.topCenter),
    ('topEnd', AlignmentDirectional.topEnd),
    ('centerStart', AlignmentDirectional.centerStart),
    ('center', AlignmentDirectional.center),
    ('centerEnd', AlignmentDirectional.centerEnd),
    ('bottomStart', AlignmentDirectional.bottomStart),
    ('bottomCenter', AlignmentDirectional.bottomCenter),
    ('bottomEnd', AlignmentDirectional.bottomEnd),
  ];
  return _SectionCard(
    title: 'Alignment grid',
    subtitle: '9 anchor points',
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Color(0xFFF6FFF9), Color(0xFFDEFBEE)],
    ),
    shadowColor: _accentMint,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _BodyProse(
          'Alignment determines which edge or corner the badge hugs. The '
          'default is `topEnd`, mirroring the typical notification glyph in '
          'system status bars. Use `topStart` for RTL-mirrored designs that '
          'want to call attention before the icon, or `bottomEnd` for avatar '
          'presence dots. The full nine-cell grid below pins one badge per '
          'cell so each value can be compared side by side without scrolling.',
        ),
        const SizedBox(height: 18),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 1.1,
          children: <Widget>[
            for (final entry in entries)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: _accentMint.withValues(alpha: 0.16),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Badge(
                      label: const Text('3'),
                      alignment: entry.$2,
                      child: Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          color: _accentMint.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.layers_outlined,
                            color: _inkMid),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      entry.$1,
                      style: const TextStyle(
                        fontSize: 11,
                        color: _inkSoft,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// Section: Offset explorer
// =============================================================================
//
// `offset` lets you nudge the badge away from its alignment anchor in logical
// pixels. Negative Y moves up, positive X moves towards the right edge in LTR.
// The explorer below renders the same icon with a handful of representative
// offsets so the rendered position differential is easy to read.
// =============================================================================

Widget _offsetExplorerCard() {
  final offsets = <(String, Offset)>[
    ('Offset.zero', Offset.zero),
    ('(4, -4)', Offset(4, -4)),
    ('(-4, -4)', Offset(-4, -4)),
    ('(8, 0)', Offset(8, 0)),
    ('(0, 8)', Offset(0, 8)),
    ('(12, -10)', Offset(12, -10)),
  ];
  return _SectionCard(
    title: 'Offset explorer',
    subtitle: 'Fine-tune via Offset',
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Color(0xFFFDECEC), Color(0xFFF9D5E0)],
    ),
    shadowColor: _accentRose,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _BodyProse(
          'When alignment alone isn\'t enough, `offset` slides the badge by '
          'logical pixels relative to its anchor. This is invaluable for '
          'docking a small dot just outside the bounds of a rounded button, '
          'or for clearing a focus ring without changing the badge\'s '
          'conceptual corner. Each tile below uses the same icon and the same '
          'default `topEnd` alignment, varying only the offset; tiny shifts '
          'produce surprisingly different reads.',
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: <Widget>[
            for (final entry in offsets)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Badge(
                    label: const Text('•'),
                    backgroundColor: _accentRose,
                    offset: entry.$2,
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: _accentRose.withValues(alpha: 0.4)),
                      ),
                      child: const Icon(Icons.tag_outlined, color: _inkMid),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    entry.$1,
                    style: const TextStyle(
                      fontSize: 11,
                      color: _inkSoft,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// Section: BadgeThemeData wrappers
// =============================================================================
//
// Theme wrappers let you set defaults so an entire subtree of badges shares a
// look without per-call duplication. The block below builds three themed
// branches — small, large, and accent — each via `Theme(data: ...)` with a
// custom `BadgeThemeData`. The badges inside inherit the colours, sizes and
// padding directly, demonstrating the cascade.
// =============================================================================

Widget _badgeThemeWrapperCard() {
  final base = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: _accentIris,
  );
  final smallTheme = base.copyWith(
    badgeTheme: const BadgeThemeData(
      backgroundColor: _accentLagoon,
      textColor: Colors.white,
      smallSize: 6,
      largeSize: 14,
      textStyle: TextStyle(fontSize: 9, fontWeight: FontWeight.w600),
      padding: EdgeInsets.symmetric(horizontal: 4),
    ),
  );
  final largeTheme = base.copyWith(
    badgeTheme: const BadgeThemeData(
      backgroundColor: _accentMagenta,
      textColor: Colors.white,
      smallSize: 12,
      largeSize: 22,
      textStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
      padding: EdgeInsets.symmetric(horizontal: 6),
    ),
  );
  final accentTheme = base.copyWith(
    badgeTheme: BadgeThemeData(
      backgroundColor: _accentLemon,
      textColor: _inkDeep,
      smallSize: 9,
      largeSize: 18,
      textStyle: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.8,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 7),
      alignment: AlignmentDirectional.topStart,
    ),
  );
  return _SectionCard(
    title: 'BadgeThemeData cascade',
    subtitle: 'small • large • accent',
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Color(0xFFF1EEFF), Color(0xFFDED8FF)],
    ),
    shadowColor: _accentIris,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _BodyProse(
          'Wrap any subtree in `Theme` with a `BadgeThemeData` to set defaults '
          'for `backgroundColor`, `textColor`, `padding`, `largeSize`, '
          '`smallSize`, `alignment` and the text style. Local arguments on a '
          'Badge still win when present, but anything left null inherits the '
          'theme. The three branches below all consume the same icon, but '
          'because each branch is themed differently the dots and pills come '
          'out at different sizes, colours and anchor points.',
        ),
        const SizedBox(height: 18),
        _ThemedBranch(
          label: 'small • lagoon',
          theme: smallTheme,
        ),
        const SizedBox(height: 14),
        _ThemedBranch(
          label: 'large • magenta',
          theme: largeTheme,
        ),
        const SizedBox(height: 14),
        _ThemedBranch(
          label: 'accent • lemon (topStart)',
          theme: accentTheme,
        ),
      ],
    ),
  );
}

class _ThemedBranch extends StatelessWidget {
  final String label;
  final ThemeData theme;
  const _ThemedBranch({required this.label, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _inkDeep.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: _inkSoft,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Theme(
              data: theme,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const Badge(child: Icon(Icons.mail_outline, size: 32)),
                  const Badge(
                    label: Text('3'),
                    child: Icon(Icons.chat_bubble_outline, size: 32),
                  ),
                  Badge.count(
                    count: 24,
                    child: const Icon(Icons.notifications_outlined, size: 32),
                  ),
                  const Badge(
                    label: Text('NEW'),
                    child: Icon(Icons.local_offer_outlined, size: 32),
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

// =============================================================================
// Section: Anatomy diagram
// =============================================================================
//
// A schematic showing how Badge overlays its child. The diagram uses a
// CustomPainter inside a Stack to draw the child rectangle, the alignment
// anchor, the offset vector and the badge bubble. Labels are positioned with
// regular Flutter widgets on top so the AST tooling sees real text widgets,
// not painted glyphs.
// =============================================================================

Widget _anatomyDiagramCard() {
  return _SectionCard(
    title: 'Anatomy of a Badge',
    subtitle: 'child • anchor • offset • bubble',
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Color(0xFFFFFFFF), Color(0xFFE9ECF7)],
    ),
    shadowColor: _accentSlate,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _BodyProse(
          'A Badge wraps exactly one child. The child establishes the bounding '
          'box; the badge overlay is positioned relative to that box using '
          '`alignment` (the conceptual corner) plus `offset` (a pixel nudge). '
          'When `label` is omitted, the overlay is a `smallSize`-diameter dot; '
          'when present, the overlay is a pill of height `largeSize` whose '
          'width grows to fit the label. The diagram below labels each part.',
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 280,
          child: CustomPaint(
            painter: _BadgeAnatomyPainter(),
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 28,
                  top: 22,
                  child: Text(
                    'child bounding box',
                    style: TextStyle(
                      fontSize: 11,
                      color: _inkDeep.withValues(alpha: 0.85),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Positioned(
                  left: 178,
                  top: 70,
                  child: Text(
                    'alignment\nanchor',
                    style: TextStyle(
                      fontSize: 11,
                      color: _accentMagenta,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Positioned(
                  left: 232,
                  top: 36,
                  child: Text(
                    'badge bubble',
                    style: TextStyle(
                      fontSize: 11,
                      color: _accentIris,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Positioned(
                  left: 210,
                  top: 96,
                  child: Text(
                    'offset →',
                    style: TextStyle(
                      fontSize: 11,
                      color: _accentTangerine,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Positioned(
                  left: 28,
                  bottom: 28,
                  right: 28,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: _inkDeep.withValues(alpha: 0.08),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Text(
                      'Badge(label: Text("3"), alignment: topEnd, '
                      'offset: Offset(4,-4))',
                      style: TextStyle(
                        fontSize: 11,
                        color: _inkMid,
                        fontFamily: 'monospace',
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

class _BadgeAnatomyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final childRect = Rect.fromLTWH(70, 60, 140, 110);
    final paintChild = Paint()
      ..color = _accentSlate.withValues(alpha: 0.12)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndRadius(childRect, const Radius.circular(14)),
        paintChild);

    final paintChildBorder = Paint()
      ..color = _accentSlate
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    canvas.drawRRect(
        RRect.fromRectAndRadius(childRect, const Radius.circular(14)),
        paintChildBorder);

    // Anchor dot at topEnd of child
    final anchor = Offset(childRect.right, childRect.top);
    final anchorPaint = Paint()..color = _accentMagenta;
    canvas.drawCircle(anchor, 4, anchorPaint);

    // Offset arrow
    final tip = anchor.translate(20, -16);
    final arrowPaint = Paint()
      ..color = _accentTangerine
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(anchor, tip, arrowPaint);
    final headPaint = Paint()..color = _accentTangerine;
    final headPath = Path()
      ..moveTo(tip.dx, tip.dy)
      ..lineTo(tip.dx - 6, tip.dy + 2)
      ..lineTo(tip.dx - 3, tip.dy + 6)
      ..close();
    canvas.drawPath(headPath, headPaint);

    // Badge bubble at tip
    final bubbleRect = Rect.fromCenter(
        center: tip.translate(8, 0), width: 22, height: 18);
    final bubblePaint = Paint()..color = _accentIris;
    canvas.drawRRect(
        RRect.fromRectAndRadius(bubbleRect, const Radius.circular(9)),
        bubblePaint);
    final tp = TextPainter(
      text: const TextSpan(
        text: '3',
        style: TextStyle(
            color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(
      canvas,
      bubbleRect.center.translate(-tp.width / 2, -tp.height / 2),
    );

    // Icon glyph inside child (a heart) for context
    final iconPaint = Paint()..color = _accentSlate;
    final iconCenter = childRect.center;
    final heart = Path()
      ..moveTo(iconCenter.dx, iconCenter.dy + 14)
      ..cubicTo(iconCenter.dx - 30, iconCenter.dy - 6,
          iconCenter.dx - 16, iconCenter.dy - 24, iconCenter.dx, iconCenter.dy - 8)
      ..cubicTo(iconCenter.dx + 16, iconCenter.dy - 24,
          iconCenter.dx + 30, iconCenter.dy - 6, iconCenter.dx, iconCenter.dy + 14)
      ..close();
    canvas.drawPath(heart, iconPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// Section: Decision matrix
// =============================================================================
//
// A small table that contrasts Badge, Badge.count and a hand-built overlay.
// The intent is to give product engineers a quick "which one do I use" guide
// based on the data they have on hand and the desired affordance.
// =============================================================================

Widget _decisionMatrixCard() {
  return _SectionCard(
    title: 'When to use which',
    subtitle: 'Decision matrix',
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Color(0xFFFFFAF0), Color(0xFFFFE7C2)],
    ),
    shadowColor: _accentLemon,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _BodyProse(
          'Pick the smallest widget that carries the data you have. A dot is '
          'enough when only "something" matters; a label-bearing Badge suits '
          'short status strings such as "NEW" or "LIVE"; Badge.count is the '
          'right choice whenever your data is numeric and may overflow. Drop '
          'down to a custom Stack only when none of the above offer enough '
          'control over the overlay shape.',
        ),
        const SizedBox(height: 18),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: _accentLemon.withValues(alpha: 0.22),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.all(8),
          child: Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(1.2),
              1: FlexColumnWidth(1.0),
              2: FlexColumnWidth(1.0),
              3: FlexColumnWidth(1.2),
            },
            border: TableBorder.symmetric(
              inside: BorderSide(
                color: _inkDeep.withValues(alpha: 0.08),
                width: 1,
              ),
            ),
            children: const <TableRow>[
              TableRow(children: <Widget>[
                _MatrixHead('Question'),
                _MatrixHead('Badge()'),
                _MatrixHead('Badge.count'),
                _MatrixHead('Custom overlay'),
              ]),
              TableRow(children: <Widget>[
                _MatrixCell('Only need "unseen" hint?'),
                _MatrixCell('✓ dot mode'),
                _MatrixCell('— overkill'),
                _MatrixCell('— overkill'),
              ]),
              TableRow(children: <Widget>[
                _MatrixCell('Short text label?'),
                _MatrixCell('✓ via label:'),
                _MatrixCell('— numeric only'),
                _MatrixCell('possible, more code'),
              ]),
              TableRow(children: <Widget>[
                _MatrixCell('Numeric counter?'),
                _MatrixCell('manual stringify'),
                _MatrixCell('✓ auto overflow'),
                _MatrixCell('possible, more code'),
              ]),
              TableRow(children: <Widget>[
                _MatrixCell('Non-pill shape?'),
                _MatrixCell('— pill only'),
                _MatrixCell('— pill only'),
                _MatrixCell('✓ Stack+Positioned'),
              ]),
              TableRow(children: <Widget>[
                _MatrixCell('Themable across subtree?'),
                _MatrixCell('✓ BadgeThemeData'),
                _MatrixCell('✓ BadgeThemeData'),
                _MatrixCell('— roll your own'),
              ]),
            ],
          ),
        ),
      ],
    ),
  );
}

class _MatrixHead extends StatelessWidget {
  final String text;
  const _MatrixHead(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: _inkDeep,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _MatrixCell extends StatelessWidget {
  final String text;
  const _MatrixCell(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Text(
        text,
        style: const TextStyle(fontSize: 11.5, color: _inkSoft, height: 1.45),
      ),
    );
  }
}

// =============================================================================
// Section: Code snippet card
// =============================================================================
//
// A dark monospace card with the canonical snippet for each Badge mode plus
// a themed wrapper. The snippet is rendered as a SelectableText so it can be
// copied during demos or training material, but the AST consumer just sees
// a Text widget tree.
// =============================================================================

Widget _codeSnippetCard() {
  const snippet = '''
// Dot
const Badge(child: Icon(Icons.mail_outline));

// Label
const Badge(
  label: Text('NEW'),
  backgroundColor: Color(0xFFE8447F),
  textColor: Colors.white,
  child: Icon(Icons.notifications_outlined),
);

// Count with overflow
const Badge.count(
  count: 1024,
  child: Icon(Icons.inbox_outlined),
);

// Themed cascade
Theme(
  data: theme.copyWith(
    badgeTheme: const BadgeThemeData(
      backgroundColor: Color(0xFF3BA7C9),
      textColor: Colors.white,
      largeSize: 22,
      smallSize: 12,
      padding: EdgeInsets.symmetric(horizontal: 6),
    ),
  ),
  child: subtree,
);''';
  return _SectionCard(
    title: 'Canonical snippets',
    subtitle: 'copy/paste recipes',
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[_inkDeep, _inkMid],
    ),
    shadowColor: _inkDeep,
    titleColor: Colors.white,
    body: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.32),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: const Text(
        snippet,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          height: 1.45,
          color: Color(0xFFD7DEEF),
        ),
      ),
    ),
  );
}

// =============================================================================
// Section: Palette wrap
// =============================================================================
//
// A free-form Wrap with badged chips, each rendered in a different colour
// pairing. This is the sandbox for designers picking a tone for a new
// feature: scan the palette, point at one, copy the colour hex.
// =============================================================================

Widget _paletteWrapCard() {
  final palette = <(String, Color, Color)>[
    ('iris', _accentIris, Colors.white),
    ('magenta', _accentMagenta, Colors.white),
    ('tangerine', _accentTangerine, Colors.white),
    ('mint', _accentMint, Colors.white),
    ('lagoon', _accentLagoon, Colors.white),
    ('rose', _accentRose, Colors.white),
    ('slate', _accentSlate, Colors.white),
    ('lemon', _accentLemon, _inkDeep),
    ('ink', _inkDeep, Colors.white),
    ('paper', _paperWarm, _inkDeep),
  ];
  return _SectionCard(
    title: 'Palette swatches',
    subtitle: 'badged chips',
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Color(0xFFFFFFFF), Color(0xFFFFF0F4)],
    ),
    shadowColor: _accentMagenta,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _BodyProse(
          'A free-floating wrap of badge chips with various colour pairings. '
          'Use this kind of swatch board to test that label text remains '
          'readable against a chosen background, and to pick a colour that '
          'reads well in both light and dark themes. The wrap layout means '
          'tiles flow naturally to the next line as the available width '
          'shrinks, which is how a real palette panel in a design tool would '
          'behave.',
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: <Widget>[
            for (final entry in palette)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: entry.$2.withValues(alpha: 0.28),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Badge(
                      label: Text(
                        entry.$1,
                        style: TextStyle(
                          color: entry.$3,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      backgroundColor: entry.$2,
                      child: Icon(Icons.palette_outlined,
                          color: entry.$2, size: 22),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      entry.$1,
                      style: const TextStyle(
                        fontSize: 12,
                        color: _inkSoft,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// Section: Interactive count slider
// =============================================================================
//
// Scoped interactivity via StatefulBuilder: a slider drives a count that a
// Badge.count picks up live. This is the only stateful widget in the file
// and demonstrates the recommended pattern for local UX state without using
// a root-level StatefulWidget (which the harness explicitly forbids).
// =============================================================================

Widget _interactiveCountCard() {
  return _SectionCard(
    title: 'Interactive count slider',
    subtitle: 'StatefulBuilder scope',
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Color(0xFFF1F9FF), Color(0xFFD9EEFF)],
    ),
    shadowColor: _accentLagoon,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _BodyProse(
          'A `StatefulBuilder` keeps the slider value local to this section. '
          'No widget outside this card knows or cares about the count. Try '
          'dragging the handle from 0 to 1200 to watch the badge silhouette '
          'morph: empty (hidden), pill with a single digit, pill with three '
          'digits, then the overflow form. Local state like this is how the '
          'AST harness models interaction without booting a root '
          'StatefulWidget.',
        ),
        const SizedBox(height: 18),
        StatefulBuilder(
          builder: (BuildContext ctx, void Function(void Function()) setLocal) {
            return _CountStage();
          },
        ),
      ],
    ),
  );
}

class _CountStage extends StatefulWidget {
  @override
  State<_CountStage> createState() => _CountStageState();
}

class _CountStageState extends State<_CountStage> {
  double _count = 7;

  @override
  Widget build(BuildContext context) {
    final intCount = _count.round();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _accentLagoon.withValues(alpha: 0.18),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Badge.count(
            count: intCount,
            backgroundColor: _accentLagoon,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: _accentLagoon.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.inbox_outlined,
                  size: 40, color: _inkMid),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'count = $intCount',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: _inkMid,
            ),
          ),
          Slider(
            min: 0,
            max: 1200,
            divisions: 60,
            value: _count,
            label: intCount.toString(),
            activeColor: _accentLagoon,
            onChanged: (double v) {
              setState(() {
                _count = v;
              });
            },
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Section: Accessibility notes
// =============================================================================
//
// A short accessibility briefing summarising contrast, screen reader and
// localisation considerations. The card uses a calm two-tone gradient and a
// small icon strip to anchor each bullet visually.
// =============================================================================

Widget _accessibilityCard() {
  final bullets = <(IconData, String, String)>[
    (
      Icons.contrast,
      'Contrast',
      'Confirm the label text colour against the background hits at least the '
          'WCAG AA contrast ratio (4.5:1 for text under 14pt). The default '
          'Material colour pairings are tuned for both light and dark themes; '
          'custom palettes should be re-checked manually.',
    ),
    (
      Icons.record_voice_over,
      'Screen reader',
      'A Badge does not automatically announce its label. Pair the wrapped '
          'icon with a `Semantics` widget or an `IconButton` whose tooltip '
          'includes the count, e.g. "3 unread messages". Otherwise the badge '
          'is invisible to assistive tech.',
    ),
    (
      Icons.translate,
      'Localisation',
      'Badge.count formats numbers via the ambient locale. If you supply a '
          'manual label such as "NEW", route the string through your '
          'localisations rather than hard-coding it, so right-to-left and '
          'translated builds remain in sync.',
    ),
  ];
  return _SectionCard(
    title: 'Accessibility & i18n',
    subtitle: 'contrast • screen reader • locale',
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Color(0xFFEFF7EE), Color(0xFFD5EBD2)],
    ),
    shadowColor: _accentMint,
    body: Column(
      children: <Widget>[
        for (final bullet in bullets)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: _accentMint.withValues(alpha: 0.22),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(bullet.$1, color: _accentMint),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        bullet.$2,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: _inkDeep,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        bullet.$3,
                        style: const TextStyle(
                          fontSize: 12,
                          height: 1.5,
                          color: _inkSoft,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

// =============================================================================
// Section: Closing note
// =============================================================================
//
// A small footer card with a closing thought. The intent is to leave the
// rendered output with a clear "end-of-document" affordance instead of just
// fading into background colour.
// =============================================================================

Widget _closingNote() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_inkMid, _inkDeep],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _inkDeep.withValues(alpha: 0.4),
          blurRadius: 18,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        const Icon(Icons.flag_outlined, color: Colors.white),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'End of Badge deep visual demo. Use this file as a '
            'reference card when wiring badges into icon buttons, '
            'navigation surfaces and avatars across the workspace.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withValues(alpha: 0.92),
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Shared building blocks
// =============================================================================

class _SectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Gradient gradient;
  final Color shadowColor;
  final Color titleColor;
  final Widget body;
  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.shadowColor,
    required this.body,
    this.titleColor = _inkDeep,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(22),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: shadowColor.withValues(alpha: 0.28),
            blurRadius: 20,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: shadowColor.withValues(alpha: 0.14),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: titleColor,
                        letterSpacing: 0.1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: titleColor.withValues(alpha: 0.66),
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: shadowColor,
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: shadowColor.withValues(alpha: 0.5),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          body,
        ],
      ),
    );
  }
}

class _BodyProse extends StatelessWidget {
  final String text;
  const _BodyProse(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12.5,
        color: _inkMid,
        height: 1.55,
      ),
    );
  }
}

class _LabelledTile extends StatelessWidget {
  final String caption;
  final Widget child;
  const _LabelledTile({required this.caption, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: _inkDeep.withValues(alpha: 0.06),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: child,
        ),
        const SizedBox(height: 8),
        Text(
          caption,
          style: const TextStyle(
            fontSize: 11,
            color: _inkSoft,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _MiniSurface extends StatelessWidget {
  final String caption;
  final Widget child;
  const _MiniSurface({required this.caption, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          caption,
          style: const TextStyle(
            fontSize: 11,
            color: _inkSoft,
            letterSpacing: 0.5,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: _accentSlate.withValues(alpha: 0.18),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}

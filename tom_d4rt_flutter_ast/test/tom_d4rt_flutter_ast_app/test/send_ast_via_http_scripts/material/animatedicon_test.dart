// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep visual demo: AnimatedIcon and AnimatedIcons.
//
// Flutter ships a small fixed family of morphing icons (AnimatedIconData
// instances exposed as static fields on AnimatedIcons). Each instance
// describes a 0..1 morph between two static glyphs, e.g. menu -> arrow,
// play -> pause. AnimatedIcon takes one of those AnimatedIconData values
// plus an Animation<double> (the "progress") and draws the interpolated
// glyph at the given progress.
//
// In d4rt we cannot run live AnimationControllers; instead we capture
// snapshots with AlwaysStoppedAnimation<double>(t). This file lays out
// a "frame strip" for every built-in AnimatedIconData at five progress
// values, and additionally explores sizing, colour, RTL, and use-case
// composition. The result is a single Scaffold with a long ScrollView.
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Section 0 - palette and shared style helpers.
// ---------------------------------------------------------------------------

const Color kInkPrimary = Color(0xFF1F2933);
const Color kInkSecondary = Color(0xFF52606D);
const Color kInkMuted = Color(0xFF9AA5B1);
const Color kSurfaceA = Color(0xFFF7F8FA);
const Color kSurfaceB = Color(0xFFEDF1F5);
const Color kSurfaceC = Color(0xFFE3E8EE);
const Color kAccentBlue = Color(0xFF2563EB);
const Color kAccentTeal = Color(0xFF0EA5A1);
const Color kAccentPink = Color(0xFFDB2777);
const Color kAccentAmber = Color(0xFFD97706);
const Color kAccentViolet = Color(0xFF7C3AED);
const Color kAccentLime = Color(0xFF65A30D);
const Color kAccentRose = Color(0xFFE11D48);
const Color kAccentNavy = Color(0xFF1E3A8A);

// The five canonical progress snapshots used throughout.
const List<double> kSnapshots = <double>[0.0, 0.25, 0.5, 0.75, 1.0];

// Helper: monospace text style for code snippets.
TextStyle codeStyle({double size = 12, Color color = kInkPrimary}) {
  return TextStyle(
    fontFamily: 'monospace',
    fontSize: size,
    height: 1.45,
    color: color,
  );
}

// Helper: single tile that wraps an AnimatedIcon snapshot in a labelled box.
Widget tileSnapshot({
  required AnimatedIconData icon,
  required double progress,
  required Color color,
  required Color background,
  required Color border,
  double size = 48,
  String? semanticLabel,
  TextDirection textDirection = TextDirection.ltr,
}) {
  return Container(
    width: size + 28,
    height: size + 44,
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: border, width: 1),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Directionality(
          textDirection: textDirection,
          child: AnimatedIcon(
            icon: icon,
            progress: AlwaysStoppedAnimation<double>(progress),
            size: size,
            color: color,
            semanticLabel: semanticLabel,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          progress.toStringAsFixed(2),
          style: const TextStyle(
            fontSize: 10,
            color: kInkMuted,
            fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 1 - Header / introduction card.
// ---------------------------------------------------------------------------

Widget buildIntroHeader() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          kAccentNavy,
          kAccentBlue,
          kAccentViolet,
        ],
      ),
      borderRadius: BorderRadius.circular(18),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kAccentBlue.withValues(alpha: 0.35),
          blurRadius: 24,
          offset: const Offset(0, 12),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                ),
              ),
              child: const Center(
                child: AnimatedIcon(
                  icon: AnimatedIcons.menu_arrow,
                  progress: AlwaysStoppedAnimation<double>(0.5),
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'AnimatedIcon . AnimatedIcons',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.2,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Bundled morphing icons - progress-driven 0..1 glyphs',
                    style: TextStyle(
                      color: Color(0xFFD7E0F8),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.18),
            ),
          ),
          child: const Text(
            'AnimatedIcon animates between two static glyphs over a fixed '
            'parameter t in [0, 1]. AnimatedIcons exposes a small built-in '
            'set; the source of motion is any Animation<double>. In this '
            'demo we drive every example with AlwaysStoppedAnimation<double>'
            '(t) snapshots so the renders are pure functions of t.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            _introChip('14 morphs', kAccentTeal),
            const SizedBox(width: 8),
            _introChip('5 snapshots / row', kAccentAmber),
            const SizedBox(width: 8),
            _introChip('static composition', kAccentPink),
          ],
        ),
      ],
    ),
  );
}

Widget _introChip(String label, Color tint) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
      ),
    ),
  );
}

// Generic section banner used between large blocks.
Widget buildSectionBanner({
  required String number,
  required String title,
  required String subtitle,
  required Color tint,
  required IconData glyph,
}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.fromLTRB(0, 28, 0, 12),
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[
          tint.withValues(alpha: 0.95),
          tint.withValues(alpha: 0.55),
        ],
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: tint.withValues(alpha: 0.30),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Icon(glyph, color: Colors.white, size: 22),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Section $number',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.3,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.92),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 2 - Frame strip for each AnimatedIconData (14 rows x 5 columns).
// ---------------------------------------------------------------------------

// Each row builds: name label, transition description, 5 snapshot tiles.
// Every row varies its decoration so that no two cards look identical.

Widget buildFrameStripBlock() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildSectionBanner(
        number: '02',
        title: 'Frame strip - every AnimatedIconData',
        subtitle: 'Snapshots at t = 0.00, 0.25, 0.50, 0.75, 1.00',
        tint: kAccentBlue,
        glyph: Icons.movie_filter_outlined,
      ),
      _rowAddEvent(),
      _rowArrowMenu(),
      _rowCloseMenu(),
      _rowEllipsisSearch(),
      _rowEventAdd(),
      _rowHomeMenu(),
      _rowListView(),
      _rowMenuArrow(),
      _rowMenuClose(),
      _rowMenuHome(),
      _rowPausePlay(),
      _rowPlayPause(),
      _rowSearchEllipsis(),
      _rowViewList(),
    ],
  );
}

Widget _frameStripCard({
  required String name,
  required String description,
  required AnimatedIconData icon,
  required Color iconColor,
  required Color tileBackground,
  required Color tileBorder,
  required BoxDecoration cardDecoration,
  EdgeInsets cardPadding = const EdgeInsets.all(16),
  String? semanticLabel,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: cardPadding,
    decoration: cardDecoration,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: iconColor.withValues(alpha: 0.4),
                ),
              ),
              child: Text(
                'AnimatedIcons.$name',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: iconColor,
                ),
              ),
            ),
            const Spacer(),
            Text(
              semanticLabel ?? '',
              style: const TextStyle(
                fontSize: 10,
                color: kInkMuted,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          description,
          style: const TextStyle(
            fontSize: 12.5,
            color: kInkSecondary,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            tileSnapshot(
              icon: icon,
              progress: kSnapshots[0],
              color: iconColor,
              background: tileBackground,
              border: tileBorder,
              semanticLabel: semanticLabel,
            ),
            tileSnapshot(
              icon: icon,
              progress: kSnapshots[1],
              color: iconColor,
              background: tileBackground,
              border: tileBorder,
              semanticLabel: semanticLabel,
            ),
            tileSnapshot(
              icon: icon,
              progress: kSnapshots[2],
              color: iconColor,
              background: tileBackground,
              border: tileBorder,
              semanticLabel: semanticLabel,
            ),
            tileSnapshot(
              icon: icon,
              progress: kSnapshots[3],
              color: iconColor,
              background: tileBackground,
              border: tileBorder,
              semanticLabel: semanticLabel,
            ),
            tileSnapshot(
              icon: icon,
              progress: kSnapshots[4],
              color: iconColor,
              background: tileBackground,
              border: tileBorder,
              semanticLabel: semanticLabel,
            ),
          ],
        ),
      ],
    ),
  );
}

// Row 1 - add_event.
Widget _rowAddEvent() {
  return _frameStripCard(
    name: 'add_event',
    description: 'plus glyph morphs into a calendar/event glyph - '
        'used for confirming that a new event was scheduled.',
    icon: AnimatedIcons.add_event,
    iconColor: kAccentBlue,
    tileBackground: const Color(0xFFEFF6FF),
    tileBorder: const Color(0xFFBFDBFE),
    semanticLabel: 'add event',
    cardDecoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFFD9E4F4)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kAccentBlue.withValues(alpha: 0.08),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
  );
}

// Row 2 - arrow_menu.
Widget _rowArrowMenu() {
  return _frameStripCard(
    name: 'arrow_menu',
    description: 'back-arrow morphs into a hamburger menu - '
        'used when leaving a detail screen returns the user to a drawer host.',
    icon: AnimatedIcons.arrow_menu,
    iconColor: kAccentTeal,
    tileBackground: const Color(0xFFE6FFFA),
    tileBorder: const Color(0xFF99F6E4),
    semanticLabel: 'arrow to menu',
    cardDecoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFFFFFFF), Color(0xFFF0FDFA)],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFA7F3D0)),
    ),
    cardPadding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
  );
}

// Row 3 - close_menu.
Widget _rowCloseMenu() {
  return _frameStripCard(
    name: 'close_menu',
    description: 'close (X) morphs into a hamburger menu - '
        'used when dismissing an overlay returns the user to a menu state.',
    icon: AnimatedIcons.close_menu,
    iconColor: kAccentPink,
    tileBackground: const Color(0xFFFDF2F8),
    tileBorder: const Color(0xFFFBCFE8),
    semanticLabel: 'close to menu',
    cardDecoration: BoxDecoration(
      color: const Color(0xFFFFF7FB),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: const Color(0xFFF9A8D4)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kAccentPink.withValues(alpha: 0.10),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    cardPadding: const EdgeInsets.all(20),
  );
}

// Row 4 - ellipsis_search.
Widget _rowEllipsisSearch() {
  return _frameStripCard(
    name: 'ellipsis_search',
    description: 'three-dot overflow morphs into a magnifying glass - '
        'used when pressing the more-menu reveals a search field.',
    icon: AnimatedIcons.ellipsis_search,
    iconColor: kAccentAmber,
    tileBackground: const Color(0xFFFFFBEB),
    tileBorder: const Color(0xFFFDE68A),
    semanticLabel: 'ellipsis to search',
    cardDecoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFFCD34D), width: 1.4),
    ),
    cardPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
  );
}

// Row 5 - event_add.
Widget _rowEventAdd() {
  return _frameStripCard(
    name: 'event_add',
    description: 'calendar/event glyph morphs into a plus - '
        'inverse of add_event; used when tapping a calendar opens new-event UI.',
    icon: AnimatedIcons.event_add,
    iconColor: kAccentViolet,
    tileBackground: const Color(0xFFF5F3FF),
    tileBorder: const Color(0xFFDDD6FE),
    semanticLabel: 'event to add',
    cardDecoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[Color(0xFFFAF5FF), Color(0xFFF3E8FF)],
      ),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: const Color(0xFFC4B5FD)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kAccentViolet.withValues(alpha: 0.12),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    cardPadding: const EdgeInsets.all(14),
  );
}

// Row 6 - home_menu.
Widget _rowHomeMenu() {
  return _frameStripCard(
    name: 'home_menu',
    description: 'home glyph morphs into a hamburger menu - '
        'used when tapping a home button surfaces a drawer.',
    icon: AnimatedIcons.home_menu,
    iconColor: kAccentLime,
    tileBackground: const Color(0xFFF7FEE7),
    tileBorder: const Color(0xFFD9F99D),
    semanticLabel: 'home to menu',
    cardDecoration: BoxDecoration(
      color: const Color(0xFFFAFFE5),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFFBEF264), width: 1.6),
    ),
    cardPadding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
  );
}

// Row 7 - list_view.
Widget _rowListView() {
  return _frameStripCard(
    name: 'list_view',
    description: 'list/lines glyph morphs into a grid view glyph - '
        'used by gallery toggles to switch from list layout to grid layout.',
    icon: AnimatedIcons.list_view,
    iconColor: kAccentRose,
    tileBackground: const Color(0xFFFFF1F2),
    tileBorder: const Color(0xFFFECDD3),
    semanticLabel: 'list to grid',
    cardDecoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: const Color(0xFFFDA4AF)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kAccentRose.withValues(alpha: 0.14),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    cardPadding: const EdgeInsets.all(22),
  );
}

// Row 8 - menu_arrow.
Widget _rowMenuArrow() {
  return _frameStripCard(
    name: 'menu_arrow',
    description: 'hamburger menu morphs into a back-arrow - '
        'classic drawer-open / page-push transition.',
    icon: AnimatedIcons.menu_arrow,
    iconColor: kAccentNavy,
    tileBackground: const Color(0xFFEFF6FF),
    tileBorder: const Color(0xFFC7D2FE),
    semanticLabel: 'menu to arrow',
    cardDecoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFE0E7FF), Color(0xFFFFFFFF)],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFFA5B4FC)),
    ),
    cardPadding: const EdgeInsets.all(15),
  );
}

// Row 9 - menu_close.
Widget _rowMenuClose() {
  return _frameStripCard(
    name: 'menu_close',
    description: 'hamburger menu morphs into a close (X) - '
        'used by drawers/overlays to flag dismiss-action availability.',
    icon: AnimatedIcons.menu_close,
    iconColor: kAccentAmber,
    tileBackground: const Color(0xFFFFF7ED),
    tileBorder: const Color(0xFFFED7AA),
    semanticLabel: 'menu to close',
    cardDecoration: BoxDecoration(
      color: const Color(0xFFFFFAF0),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: const Color(0xFFF59E0B), width: 2),
    ),
    cardPadding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
  );
}

// Row 10 - menu_home.
Widget _rowMenuHome() {
  return _frameStripCard(
    name: 'menu_home',
    description: 'hamburger menu morphs into a home glyph - '
        'inverse of home_menu; used when a drawer collapse should return home.',
    icon: AnimatedIcons.menu_home,
    iconColor: kAccentTeal,
    tileBackground: const Color(0xFFECFEFF),
    tileBorder: const Color(0xFFA5F3FC),
    semanticLabel: 'menu to home',
    cardDecoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFF22D3EE)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF22D3EE).withValues(alpha: 0.18),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    cardPadding: const EdgeInsets.all(18),
  );
}

// Row 11 - pause_play.
Widget _rowPausePlay() {
  return _frameStripCard(
    name: 'pause_play',
    description: 'pause bars morph into a play triangle - '
        'used on transport bars when a track ends or is stopped.',
    icon: AnimatedIcons.pause_play,
    iconColor: kAccentPink,
    tileBackground: const Color(0xFFFCE7F3),
    tileBorder: const Color(0xFFF9A8D4),
    semanticLabel: 'pause to play',
    cardDecoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[Color(0xFFFFF1F2), Color(0xFFFCE7F3)],
      ),
      borderRadius: BorderRadius.circular(28),
      border: Border.all(color: const Color(0xFFEC4899)),
    ),
    cardPadding: const EdgeInsets.all(24),
  );
}

// Row 12 - play_pause.
Widget _rowPlayPause() {
  return _frameStripCard(
    name: 'play_pause',
    description: 'play triangle morphs into pause bars - '
        'the canonical media transport toggle on mobile players.',
    icon: AnimatedIcons.play_pause,
    iconColor: kAccentBlue,
    tileBackground: const Color(0xFFF0F9FF),
    tileBorder: const Color(0xFF7DD3FC),
    semanticLabel: 'play to pause',
    cardDecoration: BoxDecoration(
      color: const Color(0xFFF8FAFC),
      borderRadius: BorderRadius.circular(13),
      border: Border.all(color: const Color(0xFF38BDF8), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF38BDF8).withValues(alpha: 0.20),
          blurRadius: 16,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    cardPadding: const EdgeInsets.all(17),
  );
}

// Row 13 - search_ellipsis.
Widget _rowSearchEllipsis() {
  return _frameStripCard(
    name: 'search_ellipsis',
    description: 'magnifying glass morphs into three-dot overflow - '
        'inverse of ellipsis_search; used when collapsing a search field.',
    icon: AnimatedIcons.search_ellipsis,
    iconColor: kAccentViolet,
    tileBackground: const Color(0xFFEDE9FE),
    tileBorder: const Color(0xFFC4B5FD),
    semanticLabel: 'search to ellipsis',
    cardDecoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(11),
      border: Border.all(color: const Color(0xFFA78BFA)),
    ),
    cardPadding: const EdgeInsets.fromLTRB(15, 13, 15, 17),
  );
}

// Row 14 - view_list.
Widget _rowViewList() {
  return _frameStripCard(
    name: 'view_list',
    description: 'grid view glyph morphs into a list/lines glyph - '
        'inverse of list_view; reverts to list layout after a grid view.',
    icon: AnimatedIcons.view_list,
    iconColor: kAccentLime,
    tileBackground: const Color(0xFFECFCCB),
    tileBorder: const Color(0xFFBEF264),
    semanticLabel: 'grid to list',
    cardDecoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: <Color>[Color(0xFFFEFCE8), Color(0xFFF7FEE7)],
      ),
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: const Color(0xFF84CC16), width: 1.4),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF84CC16).withValues(alpha: 0.15),
          blurRadius: 12,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    cardPadding: const EdgeInsets.all(19),
  );
}

// ---------------------------------------------------------------------------
// Section 3 - Size ladder for menu_arrow.
// ---------------------------------------------------------------------------

Widget buildSizeLadderBlock() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildSectionBanner(
        number: '03',
        title: 'Size ladder - AnimatedIcons.menu_arrow',
        subtitle: 'Same icon, same progress (0.5), six sizes',
        tint: kAccentTeal,
        glyph: Icons.straighten_outlined,
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: kInkSecondary.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            _sizeRung(24, kAccentBlue),
            _sizeRung(32, kAccentTeal),
            _sizeRung(48, kAccentPink),
            _sizeRung(64, kAccentAmber),
            _sizeRung(96, kAccentViolet),
            _sizeRung(128, kAccentNavy),
          ],
        ),
      ),
    ],
  );
}

Widget _sizeRung(double size, Color color) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: size + 16,
        height: size + 16,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              color.withValues(alpha: 0.10),
              color.withValues(alpha: 0.02),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.35)),
        ),
        child: Center(
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow,
            progress: const AlwaysStoppedAnimation<double>(0.5),
            color: color,
            size: size,
          ),
        ),
      ),
      const SizedBox(height: 6),
      Text(
        '${size.toInt()} px',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 4 - Colour palette: same icon, 8 colours, progress 0.5.
// ---------------------------------------------------------------------------

class _ColorVariant {
  final String label;
  final Color color;
  final Color background;
  final Color border;
  const _ColorVariant(this.label, this.color, this.background, this.border);
}

Widget buildColorPaletteBlock() {
  const _ColorVariant v0 = _ColorVariant(
      'navy', kAccentNavy, Color(0xFFE0E7FF), Color(0xFFC7D2FE));
  const _ColorVariant v1 = _ColorVariant(
      'blue', kAccentBlue, Color(0xFFDBEAFE), Color(0xFFBFDBFE));
  const _ColorVariant v2 = _ColorVariant(
      'teal', kAccentTeal, Color(0xFFCCFBF1), Color(0xFF99F6E4));
  const _ColorVariant v3 = _ColorVariant(
      'lime', kAccentLime, Color(0xFFD9F99D), Color(0xFFBEF264));
  const _ColorVariant v4 = _ColorVariant(
      'amber', kAccentAmber, Color(0xFFFEF3C7), Color(0xFFFDE68A));
  const _ColorVariant v5 = _ColorVariant(
      'rose', kAccentRose, Color(0xFFFFE4E6), Color(0xFFFECDD3));
  const _ColorVariant v6 = _ColorVariant(
      'pink', kAccentPink, Color(0xFFFCE7F3), Color(0xFFFBCFE8));
  const _ColorVariant v7 = _ColorVariant(
      'violet', kAccentViolet, Color(0xFFEDE9FE), Color(0xFFC4B5FD));

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildSectionBanner(
        number: '04',
        title: 'Colour palette - AnimatedIcons.play_pause',
        subtitle: 'Eight colour variants, progress 0.5',
        tint: kAccentPink,
        glyph: Icons.palette_outlined,
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Wrap(
          spacing: 14,
          runSpacing: 14,
          children: <Widget>[
            _colorTile(v0),
            _colorTile(v1),
            _colorTile(v2),
            _colorTile(v3),
            _colorTile(v4),
            _colorTile(v5),
            _colorTile(v6),
            _colorTile(v7),
          ],
        ),
      ),
    ],
  );
}

Widget _colorTile(_ColorVariant v) {
  return Container(
    width: 110,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: v.background,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: v.border, width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: v.color.withValues(alpha: 0.15),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        AnimatedIcon(
          icon: AnimatedIcons.play_pause,
          progress: const AlwaysStoppedAnimation<double>(0.5),
          color: v.color,
          size: 56,
        ),
        const SizedBox(height: 8),
        Text(
          v.label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: v.color,
            letterSpacing: 0.4,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 5 - RTL contrast demo.
// ---------------------------------------------------------------------------

Widget buildRtlContrastBlock() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildSectionBanner(
        number: '05',
        title: 'Directionality - LTR vs RTL',
        subtitle: 'menu_arrow, arrow_menu, list_view, play_pause side-by-side',
        tint: kAccentViolet,
        glyph: Icons.swap_horiz,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: _rtlPanel('LTR', TextDirection.ltr, kAccentBlue)),
          const SizedBox(width: 12),
          Expanded(child: _rtlPanel('RTL', TextDirection.rtl, kAccentRose)),
        ],
      ),
    ],
  );
}

Widget _rtlPanel(String label, TextDirection direction, Color tint) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: tint.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: tint,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              direction == TextDirection.ltr
                  ? 'TextDirection.ltr'
                  : 'TextDirection.rtl',
              style: codeStyle(size: 11, color: kInkSecondary),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _rtlRow(AnimatedIcons.menu_arrow, 'menu_arrow', direction, tint),
        const SizedBox(height: 8),
        _rtlRow(AnimatedIcons.arrow_menu, 'arrow_menu', direction, tint),
        const SizedBox(height: 8),
        _rtlRow(AnimatedIcons.list_view, 'list_view', direction, tint),
        const SizedBox(height: 8),
        _rtlRow(AnimatedIcons.play_pause, 'play_pause', direction, tint),
      ],
    ),
  );
}

Widget _rtlRow(
  AnimatedIconData icon,
  String name,
  TextDirection direction,
  Color tint,
) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: tint.withValues(alpha: 0.25)),
    ),
    child: Row(
      children: <Widget>[
        Directionality(
          textDirection: direction,
          child: AnimatedIcon(
            icon: icon,
            progress: const AlwaysStoppedAnimation<double>(0.0),
            color: tint,
            size: 28,
          ),
        ),
        const SizedBox(width: 6),
        Directionality(
          textDirection: direction,
          child: AnimatedIcon(
            icon: icon,
            progress: const AlwaysStoppedAnimation<double>(0.5),
            color: tint,
            size: 28,
          ),
        ),
        const SizedBox(width: 6),
        Directionality(
          textDirection: direction,
          child: AnimatedIcon(
            icon: icon,
            progress: const AlwaysStoppedAnimation<double>(1.0),
            color: tint,
            size: 28,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            name,
            style: codeStyle(size: 12, color: kInkPrimary),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 6 - Use cases (composed mini screens).
// ---------------------------------------------------------------------------

Widget buildUseCasesBlock() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildSectionBanner(
        number: '06',
        title: 'Use cases - composed mini screens',
        subtitle: 'AppBar morph, FAB toggle, expanding search',
        tint: kAccentAmber,
        glyph: Icons.dashboard_customize_outlined,
      ),
      _useCaseAppBarMorph(),
      const SizedBox(height: 12),
      _useCaseFabPlayPause(),
      const SizedBox(height: 12),
      _useCaseSearchExpand(),
    ],
  );
}

// 6a - AppBar morphing menu/back.
Widget _useCaseAppBarMorph() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFE2E8F0)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kAccentBlue.withValues(alpha: 0.06),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '6a . AppBar morphing menu / arrow',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: kInkPrimary,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'On drawer-open or page-push, the leading icon morphs '
          'menu -> arrow. Below: three frozen states.',
          style: TextStyle(
            fontSize: 12,
            color: kInkSecondary,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 14),
        _fakeAppBar('Drawer closed', 0.0, 'menu'),
        const SizedBox(height: 10),
        _fakeAppBar('Mid-transition', 0.5, 'morph'),
        const SizedBox(height: 10),
        _fakeAppBar('Drawer open / pushed', 1.0, 'back'),
      ],
    ),
  );
}

Widget _fakeAppBar(String caption, double progress, String tag) {
  return Container(
    height: 60,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[Color(0xFF1E40AF), Color(0xFF2563EB)],
      ),
      borderRadius: BorderRadius.circular(10),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kAccentBlue.withValues(alpha: 0.18),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: AlwaysStoppedAnimation<double>(progress),
          color: Colors.white,
          size: 28,
        ),
        const SizedBox(width: 12),
        const Text(
          'Inbox',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            tag,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          caption,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 11,
          ),
        ),
      ],
    ),
  );
}

// 6b - FAB play/pause toggle, both states with arrow between.
Widget _useCaseFabPlayPause() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFFFF1F2), Color(0xFFFCE7F3)],
      ),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: const Color(0xFFFBCFE8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '6b . FAB play / pause',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: kAccentPink,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Card pattern: a single FAB whose AnimatedIcon switches '
          'between AnimatedIcons.play_pause progress 0 and 1.',
          style: TextStyle(
            fontSize: 12,
            color: kInkSecondary,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _fakeFab(0.0, 'play', kAccentBlue),
            const Icon(Icons.arrow_forward, color: kInkMuted, size: 30),
            _fakeFab(0.5, 'morph', kAccentViolet),
            const Icon(Icons.arrow_forward, color: kInkMuted, size: 30),
            _fakeFab(1.0, 'pause', kAccentPink),
          ],
        ),
      ],
    ),
  );
}

Widget _fakeFab(double progress, String label, Color tint) {
  return Column(
    children: <Widget>[
      Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: tint,
          shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: tint.withValues(alpha: 0.4),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: AnimatedIcon(
            icon: AnimatedIcons.play_pause,
            progress: AlwaysStoppedAnimation<double>(progress),
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
      const SizedBox(height: 6),
      Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: tint,
        ),
      ),
    ],
  );
}

// 6c - Search field expand (ellipsis_search / search_ellipsis).
Widget _useCaseSearchExpand() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFBEB),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFFDE68A), width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '6c . Search field expand',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: kAccentAmber,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Leading icon morphs ellipsis (collapsed) -> magnifying glass '
          '(expanded). The expanded state reveals an inline TextField.',
          style: TextStyle(
            fontSize: 12,
            color: kInkSecondary,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 14),
        _searchBar(0.0, 'collapsed', false),
        const SizedBox(height: 8),
        _searchBar(0.5, 'mid', true),
        const SizedBox(height: 8),
        _searchBar(1.0, 'expanded', true),
      ],
    ),
  );
}

Widget _searchBar(double progress, String state, bool showField) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(28),
      border: Border.all(color: const Color(0xFFFCD34D)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kAccentAmber.withValues(alpha: 0.10),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        AnimatedIcon(
          icon: AnimatedIcons.ellipsis_search,
          progress: AlwaysStoppedAnimation<double>(progress),
          color: kAccentAmber,
          size: 24,
        ),
        const SizedBox(width: 10),
        if (showField)
          Expanded(
            child: Text(
              progress >= 1.0 ? 'Search messages...' : '...',
              style: TextStyle(
                color: kInkSecondary.withValues(alpha: progress),
                fontSize: 13,
                fontStyle: FontStyle.italic,
              ),
            ),
          )
        else
          const Expanded(
            child: Text(
              '- more options -',
              style: TextStyle(
                color: kInkMuted,
                fontSize: 12,
              ),
            ),
          ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: kAccentAmber.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            state,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: kAccentAmber,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 7 - Code-card showing the typical AnimationController pattern.
// ---------------------------------------------------------------------------

Widget buildCodeCardBlock() {
  const String snippet = '''
class Toggle extends StatefulWidget {
  const Toggle({super.key});
  @override
  State<Toggle> createState() => _ToggleState();
}

class _ToggleState extends State<Toggle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _toggle() {
    if (_ctrl.status == AnimationStatus.completed) {
      _ctrl.reverse();
    } else {
      _ctrl.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _toggle,
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _ctrl,
        size: 32,
      ),
    );
  }
}
''';

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildSectionBanner(
        number: '07',
        title: 'Code . typical AnimationController pattern',
        subtitle: 'd4rt cannot run this - shown for reference only',
        tint: kAccentNavy,
        glyph: Icons.code,
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFF1E293B)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: kAccentNavy.withValues(alpha: 0.30),
              blurRadius: 18,
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
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEF4444),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF59E0B),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFF22C55E),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 14),
                Text(
                  'toggle.dart',
                  style: codeStyle(
                    size: 11,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              snippet,
              style: codeStyle(
                size: 12,
                color: const Color(0xFFE2E8F0),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 8 - Pitfalls panel.
// ---------------------------------------------------------------------------

Widget buildPitfallsBlock() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildSectionBanner(
        number: '08',
        title: 'Pitfalls and limitations',
        subtitle: 'What AnimatedIcon will not do',
        tint: kAccentRose,
        glyph: Icons.warning_amber,
      ),
      _pitfallTile(
        kAccentRose,
        'Fixed icon set',
        'AnimatedIcons exposes a small, hard-coded set of morphs '
            '(menu/arrow, play/pause, list/grid, ...). You cannot supply '
            'your own SVG. For custom morphs reach for Lottie, Rive (Flare), '
            'or CustomPainter with hand-rolled Path tweening.',
      ),
      _pitfallTile(
        kAccentAmber,
        'Progress must be 0..1',
        'AnimatedIcon paints undefined/clipped output if progress.value '
            'leaves the [0, 1] range. Wrap controllers in CurvedAnimation, '
            'or clamp their .value, before feeding them in.',
      ),
      _pitfallTile(
        kAccentBlue,
        'No automatic motion',
        'AnimatedIcon does not animate by itself - it just renders the '
            'glyph at progress.value. You still need an AnimationController '
            'or another Animation<double> source to actually move it.',
      ),
      _pitfallTile(
        kAccentTeal,
        'Reverse pairs are separate',
        'menu_arrow and arrow_menu are not the same icon played backwards; '
            'they are two distinct AnimatedIconData definitions. Pick the '
            'one whose progress=1.0 matches your "active" UI state.',
      ),
      _pitfallTile(
        kAccentViolet,
        'No size override mid-animation',
        'Inside an AnimatedIcon, the size is fixed per build. If you need '
            'a tween from 24 to 32 px while the morph runs, animate the '
            'enclosing SizedBox / IconTheme - the icon itself does not '
            'tween its size.',
      ),
      _pitfallTile(
        kAccentPink,
        'Theme colour fallback',
        'If you omit the color parameter, AnimatedIcon falls back to '
            'IconTheme.of(context).color. Make sure your IconTheme is '
            'defined high enough - bare AppBar foregrounds can surprise.',
      ),
    ],
  );
}

Widget _pitfallTile(Color tint, String title, String body) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(12),
      border: Border(
        left: BorderSide(color: tint, width: 4),
        right: BorderSide(color: tint.withValues(alpha: 0.3)),
        top: BorderSide(color: tint.withValues(alpha: 0.3)),
        bottom: BorderSide(color: tint.withValues(alpha: 0.3)),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.error_outline, size: 16, color: tint),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 13.5,
                color: tint,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          body,
          style: const TextStyle(
            fontSize: 12.5,
            height: 1.45,
            color: kInkSecondary,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 9 - Footer table of all AnimatedIconData best-fit use cases.
// ---------------------------------------------------------------------------

Widget buildFooterTable() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      buildSectionBanner(
        number: '09',
        title: 'Reference table - best-fit use case',
        subtitle: 'Every AnimatedIconData and where it shines',
        tint: kAccentLime,
        glyph: Icons.table_chart_outlined,
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Column(
          children: <Widget>[
            _tableHeader(),
            _tableRow(
                'add_event',
                'plus -> calendar',
                'Confirming a new calendar entry was just added.',
                kAccentBlue),
            _tableRow(
                'arrow_menu',
                'arrow -> menu',
                'Returning from a detail screen back to a drawer host.',
                kAccentTeal),
            _tableRow(
                'close_menu',
                'close -> menu',
                'Dismissing a sheet that returns to a hamburger state.',
                kAccentPink),
            _tableRow(
                'ellipsis_search',
                'ellipsis -> search',
                'Overflow menu morphs into the search affordance on tap.',
                kAccentAmber),
            _tableRow(
                'event_add',
                'calendar -> plus',
                'Calendar entry tapped to launch new-event flow.',
                kAccentViolet),
            _tableRow(
                'home_menu',
                'home -> menu',
                'Home button press opens the app drawer.',
                kAccentLime),
            _tableRow(
                'list_view',
                'list -> grid',
                'Toggling a gallery/list from list layout to grid.',
                kAccentRose),
            _tableRow(
                'menu_arrow',
                'menu -> arrow',
                'Drawer-open or page-push transition (canonical).',
                kAccentNavy),
            _tableRow(
                'menu_close',
                'menu -> close',
                'Drawer/overlay flagging that it can be dismissed.',
                kAccentAmber),
            _tableRow(
                'menu_home',
                'menu -> home',
                'Closing a drawer that returns the user to home.',
                kAccentTeal),
            _tableRow(
                'pause_play',
                'pause -> play',
                'Track ended or stopped - show resume affordance.',
                kAccentPink),
            _tableRow(
                'play_pause',
                'play -> pause',
                'Media transport: starting playback shows pause.',
                kAccentBlue),
            _tableRow(
                'search_ellipsis',
                'search -> ellipsis',
                'Collapsing a search field back to overflow menu.',
                kAccentViolet),
            _tableRow(
                'view_list',
                'grid -> list',
                'Reverting from grid layout to list layout.',
                kAccentLime,
                isLast: true),
          ],
        ),
      ),
    ],
  );
}

Widget _tableHeader() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: const BoxDecoration(
      color: kSurfaceC,
      borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
    ),
    child: Row(
      children: const <Widget>[
        Expanded(
          flex: 3,
          child: Text(
            'AnimatedIcons.*',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: kInkPrimary,
              letterSpacing: 0.6,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'Morph',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: kInkPrimary,
              letterSpacing: 0.6,
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Text(
            'Best-fit use case',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: kInkPrimary,
              letterSpacing: 0.6,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _tableRow(
  String name,
  String morph,
  String fit,
  Color tint, {
  bool isLast = false,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color:
              isLast ? Colors.transparent : kInkMuted.withValues(alpha: 0.18),
        ),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 28,
                height: 28,
                child: AnimatedIcon(
                  icon: _iconByName(name),
                  progress: const AlwaysStoppedAnimation<double>(0.5),
                  color: tint,
                  size: 24,
                ),
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  name,
                  style: codeStyle(size: 11.5, color: kInkPrimary),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            morph,
            style: TextStyle(
              fontSize: 11.5,
              color: tint,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Text(
            fit,
            style: const TextStyle(
              fontSize: 11.5,
              color: kInkSecondary,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

AnimatedIconData _iconByName(String name) {
  if (name == 'add_event') return AnimatedIcons.add_event;
  if (name == 'arrow_menu') return AnimatedIcons.arrow_menu;
  if (name == 'close_menu') return AnimatedIcons.close_menu;
  if (name == 'ellipsis_search') return AnimatedIcons.ellipsis_search;
  if (name == 'event_add') return AnimatedIcons.event_add;
  if (name == 'home_menu') return AnimatedIcons.home_menu;
  if (name == 'list_view') return AnimatedIcons.list_view;
  if (name == 'menu_arrow') return AnimatedIcons.menu_arrow;
  if (name == 'menu_close') return AnimatedIcons.menu_close;
  if (name == 'menu_home') return AnimatedIcons.menu_home;
  if (name == 'pause_play') return AnimatedIcons.pause_play;
  if (name == 'play_pause') return AnimatedIcons.play_pause;
  if (name == 'search_ellipsis') return AnimatedIcons.search_ellipsis;
  return AnimatedIcons.view_list;
}

// ---------------------------------------------------------------------------
// Section 10 - closing footer.
// ---------------------------------------------------------------------------

Widget buildClosingFooter() {
  return Container(
    margin: const EdgeInsets.only(top: 24),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF0F172A),
          Color(0xFF1E293B),
          Color(0xFF334155),
        ],
      ),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.movie_filter,
                color: Color(0xFF93C5FD), size: 24),
            const SizedBox(width: 8),
            Text(
              'AnimatedIcon - bundled morphing glyphs',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.95),
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          '14 morphs. 5 snapshots per row. 0..1 progress driven by any '
          'Animation<double>. In d4rt, we draw with AlwaysStoppedAnimation '
          '- in production you bind to an AnimationController.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.75),
            fontSize: 12,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                progress: AlwaysStoppedAnimation<double>(1.0),
                color: Color(0xFF93C5FD),
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'end . animatedicon_test.dart',
                style: codeStyle(
                  size: 11,
                  color: const Color(0xFF93C5FD),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Entry point.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return Scaffold(
    backgroundColor: kSurfaceA,
    appBar: AppBar(
      backgroundColor: kAccentNavy,
      foregroundColor: Colors.white,
      title: const Text('AnimatedIcon . deep visual demo'),
      elevation: 0,
      leading: const Padding(
        padding: EdgeInsets.all(12),
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: AlwaysStoppedAnimation<double>(0.5),
          color: Colors.white,
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                '14 morphs . 5 snapshots',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Section 1 - header / intro.
          buildIntroHeader(),

          // Section 2 - frame strip for every AnimatedIconData.
          buildFrameStripBlock(),

          // Section 3 - size ladder.
          buildSizeLadderBlock(),

          // Section 4 - colour palette.
          buildColorPaletteBlock(),

          // Section 5 - RTL contrast.
          buildRtlContrastBlock(),

          // Section 6 - composed use cases.
          buildUseCasesBlock(),

          // Section 7 - code-card.
          buildCodeCardBlock(),

          // Section 8 - pitfalls panel.
          buildPitfallsBlock(),

          // Section 9 - footer table.
          buildFooterTable(),

          // Section 10 - closing footer.
          buildClosingFooter(),
        ],
      ),
    ),
  );
}

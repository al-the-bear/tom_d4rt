// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
//                                                                             =
//   FADE FORWARDS PAGE TRANSITIONS BUILDER  ::  THE CURTAIN GARNET DEMO       =
//                                                                             =
//   A long, narrative, instruction-rich D4rt demo script that explores the    =
//   `FadeForwardsPageTransitionsBuilder` class from `package:flutter/         =
//   material.dart`. This is the Material 3 page transition that Android       =
//   uses by default in the latest Material specification. It plays as a       =
//   short combination of a forward slide and a cross-fade: the new page       =
//   slides in from the right while it fades up from transparent, while the   =
//   old page fades out and slides slightly to the left.                      =
//                                                                             =
//   Theme: "Curtain Garnet" -- a velvet-and-gilt theatre palette. Garnet      =
//   red drapery, brass-gilt trim, dim auditorium plum, footlight gold.        =
//   Every section is voiced as a stage-manager's cue sheet: each visual is    =
//   announced with a cue, each row a beat in the show.                       =
//                                                                             =
//   ------------------------------------------------------------------------- =
//                                                                             =
//   D4rt sandbox limitations honoured throughout this file:                  =
//                                                                             =
//     1. `build(BuildContext)` is invoked exactly ONCE.                       =
//     2. NO StatefulWidget, NO setState, NO controllers.                     =
//     3. NO live timers, futures, or streams.                                 =
//     4. NO `for-in` over BridgedInstance (use indexed `for`).                =
//     5. NO `.value` reads on `Tween.animate` -- use `.transform(t)`.         =
//     6. To freeze frames of a page transition, use                          =
//        `AlwaysStoppedAnimation<double>(t)` and pass it to                  =
//        `buildTransitions(context, primary, secondary, child)`.             =
//     7. Use `.withValues(alpha: ...)` instead of `.withOpacity(...)`.       =
//                                                                             =
//   ------------------------------------------------------------------------- =
//                                                                             =
//   The demo dramatises the transition by sampling it at five canonical      =
//   times -- t = 0.0, 0.25, 0.5, 0.75, 1.0 -- and rendering the resulting    =
//   widget tree at each frozen frame. Side-by-side strips visualise the     =
//   forward fade, and a comparison grid lines it up against four siblings:  =
//   FadeUpwardsPageTransitionsBuilder, ZoomPageTransitionsBuilder,           =
//   OpenUpwardsPageTransitionsBuilder, CupertinoPageTransitionsBuilder.     =
//                                                                             =
//   Three "page content" mockups (Login, Dashboard, Settings) are frozen at  =
//   t = 0.5 to show what a real-world page mid-flight looks like.            =
//                                                                             =
//   Author : Tom Agent Container demo team                                   =
//   Theme  : Curtain Garnet                                                  =
//   Lines  : 1800+ (intentionally exhaustive)                                =
//                                                                             =
// =============================================================================

import 'package:flutter/material.dart';

// =============================================================================
//                          CURTAIN GARNET PALETTE
// =============================================================================
//
// The palette below is a complete theatre. Every shade has a name from the
// vocabulary of stagecraft -- velvet, gilt, footlight, scrim, mezzanine.
// We define more than fifteen colours so each section finds a coherent
// pair without recoloring on the fly.

const Color kCurtainGarnetDeep    = Color(0xFF4A0A14); // heavy garnet drapery
const Color kCurtainGarnet        = Color(0xFF7A1426); // primary curtain red
const Color kCurtainGarnetLight   = Color(0xFFA52A3A); // lit-from-front velvet
const Color kCurtainGarnetGlow    = Color(0xFFC94A55); // highlight on a fold
const Color kCurtainPlumShadow    = Color(0xFF2A0913); // backstage shadow
const Color kAuditoriumBlack      = Color(0xFF120307); // auditorium void
const Color kAuditoriumDimPlum    = Color(0xFF311520); // mezzanine ambient
const Color kFootlightGold        = Color(0xFFE8C36A); // warm front lights
const Color kFootlightAmber       = Color(0xFFC8932E); // amber spill
const Color kBrassGiltLight       = Color(0xFFD9B36A); // proscenium trim
const Color kBrassGiltDeep        = Color(0xFF8E6A22); // engraved metal
const Color kStageBoardOak        = Color(0xFF5C3A22); // wooden boards
const Color kStageBoardLight      = Color(0xFF7A5638); // sun-warmed plank
const Color kProgrammeIvory       = Color(0xFFF6EBD2); // playbill paper
const Color kProgrammeCream       = Color(0xFFEAD9B3); // older programme
const Color kScrimPaleRose        = Color(0xFFE8C8C5); // gauze scrim
const Color kScrimDuskRose        = Color(0xFFB87E80); // tinted gauze
const Color kSpotlightWhite       = Color(0xFFFFF5DC); // hot spotlight core
const Color kVelvetCordCrimson    = Color(0xFF901427); // tassel cord
const Color kInkPlaybill          = Color(0xFF1F0A0E); // playbill text
const Color kInkPlaybillSoft      = Color(0xFF402028); // softer body text
const Color kInkPlaybillFade      = Color(0xFF6B4E54); // captions
const Color kRibbonSilver         = Color(0xFFCDC8BF); // award ribbon
const Color kCueSheetGreen        = Color(0xFF3F5A3A); // SM annotation
const Color kCueSheetRed          = Color(0xFFB13A2A); // missed-cue red

// =============================================================================
//                              TEXT STYLES
// =============================================================================
//
// Voice: a crisp, slightly old-fashioned playbill. Display weight for titles,
// monospaced for technical excerpts, italic for stage directions.

const TextStyle kStyleTitle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.w800,
  color: kInkPlaybill,
  letterSpacing: 1.4,
);

const TextStyle kStyleSubtitle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w500,
  color: kInkPlaybillSoft,
  fontStyle: FontStyle.italic,
  letterSpacing: 0.4,
);

const TextStyle kStyleSection = TextStyle(
  fontSize: 21,
  fontWeight: FontWeight.w800,
  color: kCurtainGarnetDeep,
  letterSpacing: 0.6,
);

const TextStyle kStyleSubsection = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w700,
  color: kCurtainGarnet,
  letterSpacing: 0.4,
);

const TextStyle kStyleBody = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w400,
  color: kInkPlaybill,
  height: 1.45,
);

const TextStyle kStyleBodySoft = TextStyle(
  fontSize: 12.5,
  fontWeight: FontWeight.w400,
  color: kInkPlaybillSoft,
  height: 1.45,
);

const TextStyle kStyleBodyFade = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: kInkPlaybillFade,
  height: 1.4,
  fontStyle: FontStyle.italic,
);

const TextStyle kStyleMono = TextStyle(
  fontSize: 12,
  fontFamily: 'monospace',
  color: kInkPlaybill,
  height: 1.4,
);

const TextStyle kStyleMonoLight = TextStyle(
  fontSize: 11.5,
  fontFamily: 'monospace',
  color: kInkPlaybillSoft,
  height: 1.4,
);

const TextStyle kStyleMonoBright = TextStyle(
  fontSize: 12,
  fontFamily: 'monospace',
  color: kFootlightGold,
  height: 1.4,
);

const TextStyle kStyleBadge = TextStyle(
  fontSize: 10.5,
  fontWeight: FontWeight.w800,
  color: kProgrammeIvory,
  letterSpacing: 1.2,
);

const TextStyle kStyleCue = TextStyle(
  fontSize: 11.5,
  fontWeight: FontWeight.w700,
  color: kCueSheetGreen,
  letterSpacing: 1.0,
  fontFamily: 'monospace',
);

const TextStyle kStyleCueWarn = TextStyle(
  fontSize: 11.5,
  fontWeight: FontWeight.w700,
  color: kCueSheetRed,
  letterSpacing: 1.0,
  fontFamily: 'monospace',
);

const TextStyle kStyleTableHeader = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w800,
  color: kProgrammeIvory,
  letterSpacing: 0.6,
);

const TextStyle kStyleTableCell = TextStyle(
  fontSize: 11.5,
  fontFamily: 'monospace',
  color: kInkPlaybill,
);

const TextStyle kStyleTValueLabel = TextStyle(
  fontSize: 11,
  fontWeight: FontWeight.w800,
  color: kBrassGiltDeep,
  letterSpacing: 0.6,
);

// =============================================================================
//                          BUILDING BLOCK HELPERS
// =============================================================================
//
// Tiny pure functions that return widgets. Each helper has a single job and
// is called many times below. The inline comments treat them as scenery
// pieces in a stagehand's storage room.

Widget _gap(double h) => SizedBox(height: h);

Widget _doubleRule() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      children: [
        Container(height: 1.5, color: kBrassGiltDeep.withValues(alpha: 0.85)),
        const SizedBox(height: 2),
        Container(height: 0.8, color: kBrassGiltLight.withValues(alpha: 0.7)),
      ],
    ),
  );
}

Widget _badge(String text, Color bg) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(3),
    ),
    child: Text(text, style: kStyleBadge),
  );
}

Widget _tValuePill(double t) {
  // Brass coin pinned to each frozen frame. The "t = 0.50" label is engraved
  // on a small disc coloured with footlight gold.
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
    decoration: BoxDecoration(
      color: kFootlightGold,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: kBrassGiltDeep, width: 1.2),
    ),
    child: Text('t = ${t.toStringAsFixed(2)}', style: kStyleTValueLabel),
  );
}

Widget _cueLine(String cueNumber, String body) {
  // A line on the stage manager's cue sheet. Cue numbers in green; the
  // body is the actual stage direction.
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70,
          child: Text(cueNumber, style: kStyleCue),
        ),
        Expanded(child: Text(body, style: kStyleBody)),
      ],
    ),
  );
}

Widget _cueWarn(String cueNumber, String body) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70,
          child: Text(cueNumber, style: kStyleCueWarn),
        ),
        Expanded(child: Text(body, style: kStyleBody)),
      ],
    ),
  );
}

Widget _bullet(String text, {Color? bullet}) {
  return Padding(
    padding: const EdgeInsets.only(left: 6, bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: bullet ?? kCurtainGarnet,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: kStyleBody)),
      ],
    ),
  );
}

Widget _kvRow(String key, String value, {Color? keyColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 200,
          child: Text(key,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: keyColor ?? kCurtainGarnetDeep,
              )),
        ),
        Expanded(child: Text(value, style: kStyleMono)),
      ],
    ),
  );
}

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: kAuditoriumBlack,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: kBrassGiltDeep, width: 1),
    ),
    child: Text(
      code,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: kFootlightGold,
        height: 1.45,
      ),
    ),
  );
}

Widget _swatch(Color c, String name, String role) {
  return Container(
    margin: const EdgeInsets.only(right: 8, bottom: 8),
    padding: const EdgeInsets.all(8),
    width: 196,
    decoration: BoxDecoration(
      color: kProgrammeIvory,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: kBrassGiltLight),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: kInkPlaybill.withValues(alpha: 0.25)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                      color: kInkPlaybill)),
              const SizedBox(height: 2),
              Text(role,
                  style: const TextStyle(
                      fontSize: 10.5,
                      color: kInkPlaybillFade,
                      height: 1.2)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _calloutDo(String head, String body) {
  // "DO" callouts wear footlight gold on the left; they are good practice.
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kFootlightGold.withValues(alpha: 0.22),
      borderRadius: BorderRadius.circular(6),
      border: const Border(
        left: BorderSide(width: 4, color: kFootlightAmber),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _badge('CUE  GO', kCueSheetGreen),
            const SizedBox(width: 8),
            Expanded(
              child: Text(head,
                  style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      color: kInkPlaybill,
                      letterSpacing: 0.4)),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(body, style: kStyleBody),
      ],
    ),
  );
}

Widget _calloutAvoid(String head, String body) {
  // "AVOID" callouts are crimson, like a red velvet warning rope.
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kVelvetCordCrimson.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(6),
      border: const Border(
        left: BorderSide(width: 4, color: kCurtainGarnet),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _badge('CUE  HOLD', kCueSheetRed),
            const SizedBox(width: 8),
            Expanded(
              child: Text(head,
                  style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      color: kInkPlaybill,
                      letterSpacing: 0.4)),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(body, style: kStyleBody),
      ],
    ),
  );
}

Widget _calloutNote(String head, String body) {
  // Neutral stage-managerial side note: brass-trimmed.
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kProgrammeCream.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(6),
      border: const Border(
        left: BorderSide(width: 4, color: kBrassGiltDeep),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _badge('STAGE NOTE', kBrassGiltDeep),
            const SizedBox(width: 8),
            Expanded(
              child: Text(head,
                  style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      color: kInkPlaybill,
                      letterSpacing: 0.4)),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(body, style: kStyleBodySoft),
      ],
    ),
  );
}

Widget _sectionCard({
  required String act,
  required String title,
  required String subtitle,
  required Widget child,
}) {
  // Each major section is a velvet "act card" with a brass tag, title, and
  // italic subtitle. The body holds the actual content.
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: kProgrammeIvory,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: kBrassGiltLight, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: kAuditoriumBlack.withValues(alpha: 0.12),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              decoration: BoxDecoration(
                color: kCurtainGarnet,
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: kBrassGiltDeep),
              ),
              child: Text(act,
                  style: const TextStyle(
                    color: kFootlightGold,
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                    letterSpacing: 1.4,
                  )),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(title, style: kStyleSection)),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(subtitle, style: kStyleSubtitle),
        ),
        const SizedBox(height: 10),
        Container(height: 1.5, color: kBrassGiltDeep.withValues(alpha: 0.55)),
        const SizedBox(height: 12),
        child,
      ],
    ),
  );
}

// =============================================================================
//                       PAGE-CONTENT MOCK PANELS
// =============================================================================
//
// Three "destination" pages used in the frozen-frame strips. They are pure
// display widgets, no controllers, no async, no routing. The transition
// builder treats them as the `child` argument to `buildTransitions`.

Widget _pageLogin() {
  // A clean Material 3 login page mock: title, two text fields, and a CTA.
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #44, P2 follow-up):
  // The inner Column overflowed the original height of 360 by 3.6 px; this
  // overflow was previously masked by the now-fixed P12 abort in _frameCard.
  // Bumped to 380 so the Spacer-based Column has room for the title row,
  // two mock fields, two mock buttons, and the footer text. The freezer's
  // SizedBox dimensions below are bumped to match.
  return Container(
    width: 220,
    height: 380,
    decoration: BoxDecoration(
      color: kProgrammeIvory,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: kBrassGiltLight),
    ),
    padding: const EdgeInsets.all(14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: kCurtainGarnet,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.lock_outline,
                  size: 16, color: kFootlightGold),
            ),
            const SizedBox(width: 8),
            const Text('Sign in',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: kInkPlaybill)),
          ],
        ),
        const SizedBox(height: 12),
        const Text('Welcome back to the rehearsal hall.',
            style: TextStyle(fontSize: 11.5, color: kInkPlaybillFade)),
        const SizedBox(height: 18),
        _mockField(label: 'Email', placeholder: 'sm@theatre.local'),
        const SizedBox(height: 12),
        _mockField(label: 'Password', placeholder: '* * * * * * * *'),
        const SizedBox(height: 18),
        _mockButton('Sign in', primary: true),
        const SizedBox(height: 10),
        _mockButton('Use SSO', primary: false),
        const Spacer(),
        const Text('Forgot password?',
            style: TextStyle(
              fontSize: 11,
              color: kCurtainGarnet,
              decoration: TextDecoration.underline,
            )),
      ],
    ),
  );
}

Widget _pageDashboard() {
  // A miniature analytics dashboard.
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #44, P2 follow-up):
  // Inner Column overflowed the original height of 360 by 3.6 px (masked
  // by the prior P12 abort). Bumped to 380 to give the stats + bar-row +
  // cue-queue stack a small breathing margin.
  return Container(
    width: 220,
    height: 380,
    decoration: BoxDecoration(
      color: kProgrammeIvory,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: kBrassGiltLight),
    ),
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tonight at the Garnet',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: kInkPlaybill)),
        const SizedBox(height: 2),
        const Text('Performance metrics, 19:30 curtain',
            style: TextStyle(fontSize: 10.5, color: kInkPlaybillFade)),
        const SizedBox(height: 10),
        Row(
          children: [
            _miniStat('Sold', '412', kCurtainGarnet),
            const SizedBox(width: 6),
            _miniStat('House', '92%', kFootlightAmber),
            const SizedBox(width: 6),
            _miniStat('Late', '7', kCueSheetRed),
          ],
        ),
        const SizedBox(height: 12),
        const Text('Act timing',
            style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: kCurtainGarnetDeep)),
        const SizedBox(height: 6),
        _barRow('Act I', 0.78, kCurtainGarnet),
        _barRow('Interval', 0.22, kFootlightAmber),
        _barRow('Act II', 0.62, kCurtainGarnetLight),
        _barRow('Curtain Call', 0.10, kBrassGiltDeep),
        const SizedBox(height: 12),
        const Text('Cue queue',
            style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: kCurtainGarnetDeep)),
        const SizedBox(height: 4),
        _miniListRow('Q12', 'House to half'),
        _miniListRow('Q13', 'Spot 2 to gauze'),
        _miniListRow('Q14', 'Garnet drop in'),
      ],
    ),
  );
}

Widget _pageSettings() {
  // A short settings list page.
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #44, P2 follow-up):
  // Inner Column overflowed the original height of 360 by 3.6 px (masked
  // by the prior P12 abort). Bumped to 380 so the six settings rows and
  // the "Changes apply" callout fit with the Spacer in between.
  return Container(
    width: 220,
    height: 380,
    decoration: BoxDecoration(
      color: kProgrammeIvory,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: kBrassGiltLight),
    ),
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('House preferences',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: kInkPlaybill)),
        const SizedBox(height: 2),
        const Text('Per-venue defaults',
            style: TextStyle(fontSize: 10.5, color: kInkPlaybillFade)),
        const SizedBox(height: 12),
        _settingsRow(Icons.brightness_4, 'House lights', 'Auto-dim at -5:00'),
        _settingsRow(Icons.volume_up, 'Pre-show audio', '-12 dB'),
        _settingsRow(Icons.notifications, 'Cue chimes', 'Enabled'),
        _settingsRow(Icons.timer, 'Interval length', '20 minutes'),
        _settingsRow(Icons.theater_comedy, 'Curtain style', 'Garnet velvet'),
        _settingsRow(Icons.palette, 'Colour scheme', 'Curtain Garnet'),
        const Spacer(),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: kFootlightGold.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: kFootlightAmber),
          ),
          child: const Text(
            'Changes apply at next curtain.',
            style: TextStyle(
                fontSize: 10.5,
                color: kInkPlaybillSoft,
                fontStyle: FontStyle.italic),
          ),
        ),
      ],
    ),
  );
}

Widget _mockField({required String label, required String placeholder}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,
          style: const TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: kInkPlaybillFade,
              letterSpacing: 0.6)),
      const SizedBox(height: 3),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: kProgrammeCream.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: kBrassGiltLight),
        ),
        child: Text(placeholder,
            style: const TextStyle(fontSize: 12, color: kInkPlaybill)),
      ),
    ],
  );
}

Widget _mockButton(String label, {required bool primary}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      color: primary ? kCurtainGarnet : Colors.transparent,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: kCurtainGarnet, width: 1.4),
    ),
    alignment: Alignment.center,
    child: Text(
      label,
      style: TextStyle(
        fontSize: 12.5,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.6,
        color: primary ? kFootlightGold : kCurtainGarnet,
      ),
    ),
  );
}

Widget _miniStat(String label, String value, Color color) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          Text(value,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: color)),
          Text(label,
              style: const TextStyle(
                  fontSize: 9.5,
                  color: kInkPlaybillFade,
                  letterSpacing: 0.6)),
        ],
      ),
    ),
  );
}

Widget _barRow(String label, double frac, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(label,
              style: const TextStyle(fontSize: 10.5, color: kInkPlaybill)),
        ),
        Expanded(
          child: Container(
            height: 8,
            decoration: BoxDecoration(
              color: kProgrammeCream,
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: frac,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _miniListRow(String tag, String label) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 3),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
          decoration: BoxDecoration(
            color: kCurtainGarnetDeep,
            borderRadius: BorderRadius.circular(2),
          ),
          child: Text(tag,
              style: const TextStyle(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w800,
                  color: kFootlightGold)),
        ),
        const SizedBox(width: 6),
        Text(label,
            style: const TextStyle(fontSize: 10.5, color: kInkPlaybill)),
      ],
    ),
  );
}

Widget _settingsRow(IconData icon, String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Icon(icon, size: 16, color: kCurtainGarnet),
        const SizedBox(width: 8),
        Expanded(
          child: Text(label,
              style: const TextStyle(
                  fontSize: 11.5,
                  color: kInkPlaybill,
                  fontWeight: FontWeight.w600)),
        ),
        Text(value,
            style: const TextStyle(
                fontSize: 10.5,
                color: kInkPlaybillFade,
                fontStyle: FontStyle.italic)),
      ],
    ),
  );
}

// =============================================================================
//                        FROZEN-FRAME UTILITIES
// =============================================================================
//
// To dramatise a page transition without an AnimationController, we exploit
// the fact that `AlwaysStoppedAnimation<double>(t)` is an Animation<double>
// permanently parked at value `t`. Passing it as the primaryRouteAnimation
// of `buildTransitions` produces the exact widget tree that Flutter would
// render at frame `t` of the live transition.
//
// Below, `_frozenFadeForwards` does this once for FadeForwardsPageTransitions
// Builder. The other comparison helpers (`_frozenFadeUpwards`, `_frozenZoom`,
// `_frozenOpenUpwards`, `_frozenCupertino`) follow the same template against
// other PageTransitionsBuilder subclasses.
//
// NOTE on dimensions: `buildTransitions` returns a widget that internally
// uses the parent's Size to translate the slide. We wrap each frozen child
// in a fixed-size `SizedBox` so the slide distance is stable across frames.

Widget _frozenFadeForwards(BuildContext context, double t, Widget child) {
  // Drive both primary and secondary at value `t`. In a real Navigator
  // push, the secondary would be the *outgoing* route's animation; here we
  // share `t` so the demo reads as a single linear progression.
  final Animation<double> primary = AlwaysStoppedAnimation<double>(t);
  final Animation<double> secondary = AlwaysStoppedAnimation<double>(0.0);
  const FadeForwardsPageTransitionsBuilder builder =
      FadeForwardsPageTransitionsBuilder();
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #44, P2 follow-up):
  // Freezer outer dimensions bumped 360 → 380 to match the bumped page mock
  // heights (see _pageLogin / _pageDashboard / _pageSettings). Without this,
  // the freezer SizedBox would tightly clamp the 380-tall page back to 360
  // and the inner Column would still overflow by 3.6 px.
  return SizedBox(
    width: 220,
    height: 380,
    child: ClipRect(
      child: builder.buildTransitions<dynamic>(
        null, // PageRoute is unused by FadeForwardsPageTransitionsBuilder
        context,
        primary,
        secondary,
        child,
      ),
    ),
  );
}

Widget _frozenFadeUpwards(BuildContext context, double t, Widget child) {
  final Animation<double> primary = AlwaysStoppedAnimation<double>(t);
  final Animation<double> secondary = AlwaysStoppedAnimation<double>(0.0);
  const FadeUpwardsPageTransitionsBuilder builder =
      FadeUpwardsPageTransitionsBuilder();
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #44, P2 follow-up):
  // Freezer outer dimensions bumped 360 → 380 to match the bumped page mock
  // heights (see _pageLogin / _pageDashboard / _pageSettings). Without this,
  // the freezer SizedBox would tightly clamp the 380-tall page back to 360
  // and the inner Column would still overflow by 3.6 px.
  return SizedBox(
    width: 220,
    height: 380,
    child: ClipRect(
      child: builder.buildTransitions<dynamic>(
        null,
        context,
        primary,
        secondary,
        child,
      ),
    ),
  );
}

Widget _frozenZoom(BuildContext context, double t, Widget child) {
  // ZoomPageTransitionsBuilder.buildTransitions requires a non-null
  // PageRoute. We cannot synthesize one in the D4rt sandbox, so this
  // helper instead approximates the M3 Zoom transition by hand: a brief
  // opacity dip combined with a small scale-up. Numbers chosen to match
  // the rough feel of the live transition.
  final double scale = 0.92 + 0.08 * t;
  final double alpha = t < 0.2 ? t * 5.0 : 1.0;
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #44, P2 follow-up):
  // Freezer outer dimensions bumped 360 → 380 to match the bumped page mock
  // heights (see _pageLogin / _pageDashboard / _pageSettings). Without this,
  // the freezer SizedBox would tightly clamp the 380-tall page back to 360
  // and the inner Column would still overflow by 3.6 px.
  return SizedBox(
    width: 220,
    height: 380,
    child: ClipRect(
      child: Opacity(
        opacity: alpha.clamp(0.0, 1.0).toDouble(),
        child: Transform.scale(
          scale: scale,
          child: child,
        ),
      ),
    ),
  );
}

Widget _frozenOpenUpwards(BuildContext context, double t, Widget child) {
  final Animation<double> primary = AlwaysStoppedAnimation<double>(t);
  final Animation<double> secondary = AlwaysStoppedAnimation<double>(0.0);
  const OpenUpwardsPageTransitionsBuilder builder =
      OpenUpwardsPageTransitionsBuilder();
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #44, P2 follow-up):
  // Freezer outer dimensions bumped 360 → 380 to match the bumped page mock
  // heights (see _pageLogin / _pageDashboard / _pageSettings). Without this,
  // the freezer SizedBox would tightly clamp the 380-tall page back to 360
  // and the inner Column would still overflow by 3.6 px.
  return SizedBox(
    width: 220,
    height: 380,
    child: ClipRect(
      child: builder.buildTransitions<dynamic>(
        null,
        context,
        primary,
        secondary,
        child,
      ),
    ),
  );
}

Widget _frozenCupertino(BuildContext context, double t, Widget child) {
  // CupertinoPageTransitionsBuilder.buildTransitions also requires a
  // non-null PageRoute. We approximate iOS parallax slide here: full
  // opacity throughout, translated horizontally from +1.0 of the width
  // at t=0 to 0 at t=1, with no fade. This matches the visual signature
  // of a Cupertino push.
  final double dx = 220.0 * (1.0 - t);
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #44, P2 follow-up):
  // Freezer outer dimensions bumped 360 → 380 to match the bumped page mock
  // heights (see _pageLogin / _pageDashboard / _pageSettings). Without this,
  // the freezer SizedBox would tightly clamp the 380-tall page back to 360
  // and the inner Column would still overflow by 3.6 px.
  return SizedBox(
    width: 220,
    height: 380,
    child: ClipRect(
      child: Transform.translate(
        offset: Offset(dx, 0.0),
        child: child,
      ),
    ),
  );
}

// A single frozen "card" combining the frame + a t pill + a label.
Widget _frameCard({
  required BuildContext context,
  required double t,
  required Widget Function(BuildContext, double, Widget) freezer,
  required Widget child,
  required String caption,
}) {
  return Container(
    // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #44, P12, horizontal):
    // This card lives inside a horizontal SingleChildScrollView (Act 4 strip
    // at line ~1114 and Act 6 row at line ~1756). That horizontal scroll
    // gives our outer Row child loose, *unbounded* width constraints; with
    // no explicit width on this Container, the inner header Row's
    // `Expanded(child: Text(caption))` then trips "RenderFlex children have
    // non-zero flex but incoming width constraints are unbounded". The
    // frozen page mocks (`_pageLogin`, `_pageDashboard`, `_pageSettings`)
    // are all 220 px wide; matching that here (plus the 16 px combined
    // padding) gives the header Row a finite width to flex against and lets
    // the strips render at their intended snapshot proportions.
    width: 236,
    margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: kAuditoriumDimPlum,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: kBrassGiltDeep, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _tValuePill(t),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                caption,
                style: const TextStyle(
                  fontSize: 11,
                  color: kProgrammeIvory,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: kAuditoriumBlack,
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.all(2),
          child: freezer(context, t, child),
        ),
      ],
    ),
  );
}

// A "five-frame strip" given a freezer and a child widget.
Widget _strip({
  required BuildContext context,
  required Widget Function(BuildContext, double, Widget) freezer,
  required Widget child,
  required String stripLabel,
}) {
  // Five canonical t values.
  final List<double> ts = <double>[0.0, 0.25, 0.5, 0.75, 1.0];
  final List<String> caps = <String>[
    'curtain still down',
    'curtain rising',
    'mid-cue',
    'almost flush',
    'curtain up',
  ];

  // Build the five cards explicitly (no for-in over BridgedInstance).
  final List<Widget> cards = <Widget>[];
  for (int i = 0; i < ts.length; i = i + 1) {
    cards.add(_frameCard(
      context: context,
      t: ts[i],
      freezer: freezer,
      child: child,
      caption: caps[i],
    ));
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 4),
        child: Text(stripLabel, style: kStyleSubsection),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: cards),
      ),
    ],
  );
}

// =============================================================================
//                            ENTRY POINT  ::  build
// =============================================================================
//
// `build(BuildContext)` is the single function D4rt invokes. It composes the
// stage-manager's playbill out of seven main acts, plus a curtain-call.

dynamic build(BuildContext context) {
  print('================================================================');
  print('Curtain Garnet :: FadeForwardsPageTransitionsBuilder deep-dive');
  print('================================================================');
  print('Cue 0/9 :: dim the house, raise the proscenium playbill');
  print('Cue 1/9 :: theory of page transitions in Material 3');
  print('Cue 2/9 :: anatomy of buildTransitions(...)');
  print('Cue 3/9 :: the M3 fade-forward curve description');
  print('Cue 4/9 :: frozen-frame strip at five t values (Login)');
  print('Cue 5/9 :: comparison grid against four siblings');
  print('Cue 6/9 :: page-content samples frozen at t=0.5');
  print('Cue 7/9 :: theming, defaults, and PageTransitionsTheme');
  print('Cue 8/9 :: cue-sheet of DOs and AVOIDs');
  print('Cue 9/9 :: curtain call (palette + signature)');

  // Sample t values used throughout the demo.
  const List<double> kCanonicalTs = <double>[0.0, 0.25, 0.5, 0.75, 1.0];
  print('  Canonical t values: $kCanonicalTs');

  // Three reference children we will freeze at various t.
  final Widget childLogin = _pageLogin();
  final Widget childDashboard = _pageDashboard();
  final Widget childSettings = _pageSettings();
  print('  Page mocks built: Login, Dashboard, Settings');

  // ===========================================================================
  // ROOT SCAFFOLD
  // ===========================================================================
  return SingleChildScrollView(
    child: Container(
      color: kAuditoriumDimPlum,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildPlaybillHeader(),
          _buildAct1Theory(),
          _buildAct2Anatomy(),
          _buildAct3Curve(),
          _buildAct4FrozenStripLogin(context, childLogin),
          _buildAct5Comparison(context, childLogin),
          _buildAct6PageSamples(context, childLogin, childDashboard, childSettings),
          _buildAct7Theming(),
          _buildAct8CueSheet(),
          _buildAct9CurtainCall(),
          _buildFooter(),
        ],
      ),
    ),
  );
}

// =============================================================================
//                          PLAYBILL HEADER
// =============================================================================

Widget _buildPlaybillHeader() {
  // The header is the front cover of the playbill: a garnet velvet panel
  // with a brass medallion.
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          kCurtainGarnetDeep,
          kCurtainGarnet,
          kCurtainGarnetLight,
          kCurtainPlumShadow,
        ],
        stops: <double>[0.0, 0.45, 0.7, 1.0],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: kBrassGiltDeep, width: 2),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: kAuditoriumBlack,
          blurRadius: 14,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: kFootlightGold,
            shape: BoxShape.circle,
            border: Border.all(color: kBrassGiltDeep, width: 2),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: kAuditoriumBlack,
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: const Icon(Icons.theater_comedy,
              size: 36, color: kCurtainGarnetDeep),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                'FadeForwardsPageTransitionsBuilder',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: kFootlightGold,
                  letterSpacing: 0.6,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'A Material 3 stagecraft demo in five frozen frames',
                style: TextStyle(
                  fontSize: 12.5,
                  color: kProgrammeIvory,
                  fontStyle: FontStyle.italic,
                  height: 1.35,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'CURTAIN GARNET  ::  PLAYBILL FOR THE EVENING',
                style: TextStyle(
                  fontSize: 11,
                  color: kBrassGiltLight,
                  letterSpacing: 1.6,
                  fontWeight: FontWeight.w800,
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
//                       ACT 1  ::  THEORY OF TRANSITIONS
// =============================================================================

Widget _buildAct1Theory() {
  return _sectionCard(
    act: 'ACT  I',
    title: 'A short history of the page transition',
    subtitle: 'Why Material 3 settled on a forward fade-and-slide for Android',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Every navigation push in a Flutter app asks the same question of '
          'the user: "where did this content come from?". The answer the '
          'framework gives is a transition: a brief animation that lets the '
          'user feel, rather than read, the spatial relationship between the '
          'old screen and the new one. A good transition lasts about 300ms, '
          'orients the user, and then gets out of the way.',
          style: kStyleBody,
        ),
        _gap(8),
        Text(
          'Different platforms have different conventions. iOS slides the new '
          'page in from the right edge while pushing the old page partway '
          'left, with a thin parallax shadow at the seam. Material 2 used a '
          'fade-up: the new page rises 8 to 16dp while fading in. Material '
          '3 chose a slightly more emphatic variant -- a forward fade -- '
          'which is what FadeForwardsPageTransitionsBuilder implements.',
          style: kStyleBody,
        ),
        _gap(8),
        Text(
          'The forward fade combines two concurrent timelines:',
          style: kStyleBody,
        ),
        _gap(4),
        _bullet('A horizontal slide from roughly +30% of the screen width '
            'to 0, eased out so the page decelerates as it lands.'),
        _bullet('A cross-fade from alpha 0 to alpha 1 driven by a fast-out, '
            'slow-in curve, so most of the opacity arrives in the second '
            'half of the cue.'),
        _bullet('Simultaneously, the outgoing route fades and slides slightly '
            'to the left -- a small but legible "stepping aside" gesture.'),
        _gap(10),
        _calloutNote(
            'Names you may see in the source',
            'In recent versions of Flutter, this builder is also referred '
            'to as the "M3 default" Android transition. The class itself '
            'lives in `package:flutter/material.dart` and ships as a const '
            'subclass of PageTransitionsBuilder.'),
        _gap(4),
        _doubleRule(),
        Text('Where it fits in the bigger picture', style: kStyleSubsection),
        _gap(6),
        Text(
          'Page transitions are configured per-platform via the '
          'PageTransitionsTheme. The ThemeData for an app holds a single '
          'PageTransitionsTheme, whose builders map says: "for this '
          'TargetPlatform, use this builder". When a Navigator pushes a '
          'MaterialPageRoute, the route asks the theme for the right '
          'builder for the *runtime* platform and delegates to it.',
          style: kStyleBody,
        ),
        _gap(8),
        _codeBlock(
          'ThemeData(\n'
          '  pageTransitionsTheme: const PageTransitionsTheme(\n'
          '    builders: <TargetPlatform, PageTransitionsBuilder>{\n'
          '      TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),\n'
          '      TargetPlatform.iOS:     CupertinoPageTransitionsBuilder(),\n'
          '      TargetPlatform.macOS:   CupertinoPageTransitionsBuilder(),\n'
          '      TargetPlatform.linux:   FadeForwardsPageTransitionsBuilder(),\n'
          '      TargetPlatform.windows: ZoomPageTransitionsBuilder(),\n'
          '      TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),\n'
          '    },\n'
          '  ),\n'
          ')\n',
        ),
        _gap(8),
        Text(
          'Note that you do not write `FadeForwardsPageTransitionsBuilder()` '
          'as a route -- it is a *factory of transitions*. The Navigator '
          'passes it the route, the build context, the primary route '
          'animation, and the secondary route animation. The builder does '
          'the rest.',
          style: kStyleBody,
        ),
      ],
    ),
  );
}

// =============================================================================
//                     ACT 2  ::  ANATOMY OF buildTransitions
// =============================================================================

Widget _buildAct2Anatomy() {
  return _sectionCard(
    act: 'ACT  II',
    title: 'Anatomy of buildTransitions(...)',
    subtitle: 'Reading the four arguments like a stage cue sheet',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'PageTransitionsBuilder declares a single method that subclasses '
          'must override. Its signature is short but each parameter is '
          'load-bearing.',
          style: kStyleBody,
        ),
        _gap(8),
        _codeBlock(
          'Widget buildTransitions<T>(\n'
          '  PageRoute<T>? route,\n'
          '  BuildContext context,\n'
          '  Animation<double> animation,        // primary, 0.0..1.0\n'
          '  Animation<double> secondaryAnimation, // for outgoing route\n'
          '  Widget child,                       // the new page content\n'
          ')\n',
        ),
        _gap(8),
        Text('What each argument is for', style: kStyleSubsection),
        _gap(6),
        _kvRow('route',
            'PageRoute? — used by some builders for swipe-to-dismiss; '
                'FadeForwards may ignore it.'),
        _kvRow('context',
            'BuildContext — used to read MediaQuery, Directionality, theme.'),
        _kvRow('animation',
            'primary 0.0->1.0 — the new page is becoming visible.'),
        _kvRow('secondaryAnimation',
            'secondary 0.0->1.0 — the new page is becoming a *previous* '
                'page beneath another push; FadeForwards uses this to '
                'fade-and-slide the old route slightly out of the way.'),
        _kvRow('child',
            'Widget — the new page content. The builder must return a '
                'widget that displays this `child`, possibly wrapped in '
                'transforms / opacities driven by `animation`.'),
        _gap(10),
        _doubleRule(),
        Text('What the framework does for us', style: kStyleSubsection),
        _gap(6),
        _bullet('Drives `animation` from 0.0 to 1.0 over the route\'s '
            'transitionDuration (default ~300ms).'),
        _bullet('Drives `secondaryAnimation` of the *previous* route from '
            '0.0 to 1.0 over the same window, so its builder can react.'),
        _bullet('Reverses both during pop, so a builder that uses ease '
            'curves naturally feels right "in reverse".'),
        _gap(10),
        _calloutDo(
            'Use the curves that ship with Material',
            'Material 3 transitions are tuned with specific curves '
            '(emphasized, emphasized-decelerate, standard-decelerate). '
            'FadeForwardsPageTransitionsBuilder applies these for you. '
            'Do not multiply them with your own curves on top.'),
        _calloutAvoid(
            'Reach into private state of the animation',
            'The `animation` you receive is owned by the route. Do not '
            'subclass it, write to it, or attach a controller. Treat it '
            'as a read-only signal.'),
      ],
    ),
  );
}

// =============================================================================
//                     ACT 3  ::  THE M3 FADE-FORWARD CURVE
// =============================================================================

Widget _buildAct3Curve() {
  // A schematic chart showing two curves on the same axes: alpha vs t and
  // x-translation vs t. We render the curves as small colored bars per t.
  // No live animation: each bar is a static height computed from t.
  final List<double> ts = <double>[
    0.0, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5,
    0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95, 1.0,
  ];

  // Alpha approximation: an emphasized-decelerate-style curve.
  // This is illustrative only. Numbers chosen to hint at the visual feel.
  final List<double> alphas = <double>[];
  for (int i = 0; i < ts.length; i = i + 1) {
    final double t = ts[i];
    // Quadratic ease-out as a stand-in for the decelerate curve.
    final double a = 1.0 - (1.0 - t) * (1.0 - t);
    alphas.add(a);
  }

  // X-translation approximation: starts at +0.30 and decelerates to 0.
  final List<double> dxs = <double>[];
  for (int i = 0; i < ts.length; i = i + 1) {
    final double t = ts[i];
    final double e = 1.0 - (1.0 - t) * (1.0 - t) * (1.0 - t);
    dxs.add(0.30 * (1.0 - e));
  }

  // Build alpha bars and dx bars.
  final List<Widget> alphaBars = <Widget>[];
  for (int i = 0; i < ts.length; i = i + 1) {
    alphaBars.add(_curveBar(alphas[i], kFootlightGold, kFootlightAmber));
  }
  final List<Widget> dxBars = <Widget>[];
  for (int i = 0; i < ts.length; i = i + 1) {
    dxBars.add(_curveBar(1.0 - dxs[i] / 0.30, kCurtainGarnetLight, kCurtainGarnet));
  }

  // Tick labels.
  final List<Widget> ticks = <Widget>[];
  for (int i = 0; i < ts.length; i = i + 1) {
    ticks.add(SizedBox(
      width: 22,
      child: Text(
        ts[i].toStringAsFixed(2),
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 8, color: kInkPlaybillFade, fontFamily: 'monospace'),
      ),
    ));
  }

  return _sectionCard(
    act: 'ACT  III',
    title: 'The fade-forward curve, hand-traced',
    subtitle: 'Two timelines on the same baton: opacity and slide',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Material 3 page transitions use the "emphasized" curves family. '
          'For FadeForwards, opacity rises with a decelerating curve while '
          'horizontal translation falls with an even softer decelerate. '
          'The two curves below sketch that behavior in 21 sample points.',
          style: kStyleBody,
        ),
        _gap(10),
        Row(
          children: <Widget>[
            const SizedBox(
              width: 60,
              child: Text('alpha',
                  style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                      color: kBrassGiltDeep)),
            ),
            Expanded(
              child: SizedBox(
                height: 64,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: alphaBars,
                ),
              ),
            ),
          ],
        ),
        _gap(6),
        Row(
          children: <Widget>[
            const SizedBox(
              width: 60,
              child: Text('slide',
                  style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                      color: kCurtainGarnetDeep)),
            ),
            Expanded(
              child: SizedBox(
                height: 64,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: dxBars,
                ),
              ),
            ),
          ],
        ),
        _gap(2),
        Row(
          children: <Widget>[
            const SizedBox(width: 60),
            Expanded(child: Row(children: ticks)),
          ],
        ),
        _gap(10),
        _calloutNote(
            'Reading the chart',
            'Each vertical bar represents the "amount delivered" of that '
            'timeline at that t. In the alpha row, taller bars mean closer '
            'to fully opaque. In the slide row, taller bars mean closer to '
            'rest position. The curves do not coincide -- alpha catches up '
            'first, then slide settles.'),
        _gap(4),
        Text(
          'In Flutter, these curves are baked into the builder. You do not '
          'pass them. You only pass the route, context, animations, and '
          'child to `buildTransitions`, and you receive the composited '
          'transition widget back.',
          style: kStyleBody,
        ),
      ],
    ),
  );
}

Widget _curveBar(double frac, Color top, Color bottom) {
  // Each bar is 22dp wide, max 60dp tall. `frac` is 0..1.
  final double safe = frac.clamp(0.0, 1.0).toDouble();
  return Container(
    width: 22,
    margin: const EdgeInsets.symmetric(horizontal: 1),
    height: 60 * safe,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[top, bottom],
      ),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
    ),
  );
}

// =============================================================================
//                ACT 4  ::  FROZEN STRIP (LOGIN PAGE, FIVE FRAMES)
// =============================================================================

Widget _buildAct4FrozenStripLogin(BuildContext context, Widget child) {
  return _sectionCard(
    act: 'ACT  IV',
    title: 'Five frozen frames of a Login push',
    subtitle: 'AlwaysStoppedAnimation parks the curve at each t',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'The trick: instead of running an AnimationController, we hand '
          'buildTransitions an AlwaysStoppedAnimation<double>(t). That is '
          'an Animation<double> permanently parked at value t. The builder '
          'cannot tell the difference -- it just reads .value and computes '
          'the right transform and opacity. Result: a still photograph of '
          'the transition at frame t.',
          style: kStyleBody,
        ),
        _gap(8),
        _codeBlock(
          'final Animation<double> primary =\n'
          '    AlwaysStoppedAnimation<double>(0.50);\n'
          'final Animation<double> secondary =\n'
          '    AlwaysStoppedAnimation<double>(0.0);\n'
          'const FadeForwardsPageTransitionsBuilder b =\n'
          '    FadeForwardsPageTransitionsBuilder();\n'
          'final Widget mid = b.buildTransitions<dynamic>(\n'
          '    null, context, primary, secondary, child);\n',
        ),
        _gap(12),
        _strip(
          context: context,
          freezer: _frozenFadeForwards,
          child: child,
          stripLabel: 'FadeForwardsPageTransitionsBuilder  ::  Login',
        ),
        _gap(10),
        _calloutDo(
            'Use exactly five canonical t values',
            'Stripping at 0.0, 0.25, 0.5, 0.75, 1.0 mirrors the cadence '
            'a designer would sketch on a storyboard. It also matches '
            'the "first, second, third quarter" beats most stage cues '
            'fall on.'),
        _calloutAvoid(
            'Sample at t > 1.0 or t < 0.0',
            'Most builders extrapolate gracefully but the result is no '
            'longer the canonical transition. If you need to debug an '
            'over-shoot, attach a CurvedAnimation with a Curves.elastic '
            'parent to a real controller in a non-D4rt environment.'),
      ],
    ),
  );
}

// =============================================================================
//                  ACT 5  ::  COMPARISON GRID AGAINST SIBLINGS
// =============================================================================

Widget _buildAct5Comparison(BuildContext context, Widget child) {
  // Five rows: FadeForwards, FadeUpwards, Zoom, OpenUpwards, Cupertino.
  // Each row is the same login child sampled at five t values via a
  // different builder.
  return _sectionCard(
    act: 'ACT  V',
    title: 'Comparison: five builders, same Login child',
    subtitle: 'Forward fade, fade-up, zoom, open-up, slide-from-right',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Material ships several PageTransitionsBuilder subclasses. They '
          'all answer the same buildTransitions signature, but they look '
          'and feel quite different at the same t. Below, the same Login '
          'page child is animated by five different builders.',
          style: kStyleBody,
        ),
        _gap(10),
        _strip(
          context: context,
          freezer: _frozenFadeForwards,
          child: child,
          stripLabel: 'FadeForwardsPageTransitionsBuilder',
        ),
        _gap(8),
        _strip(
          context: context,
          freezer: _frozenFadeUpwards,
          child: child,
          stripLabel: 'FadeUpwardsPageTransitionsBuilder  (Material 2 default)',
        ),
        _gap(8),
        _strip(
          context: context,
          freezer: _frozenZoom,
          child: child,
          stripLabel: 'ZoomPageTransitionsBuilder  (Android Q+ default)',
        ),
        _gap(8),
        _strip(
          context: context,
          freezer: _frozenOpenUpwards,
          child: child,
          stripLabel: 'OpenUpwardsPageTransitionsBuilder',
        ),
        _gap(8),
        _strip(
          context: context,
          freezer: _frozenCupertino,
          child: child,
          stripLabel: 'CupertinoPageTransitionsBuilder  (iOS slide)',
        ),
        _gap(10),
        _calloutNote(
            'Why the rows look different',
            'Each builder picks different curves and decomposes the '
            'transition into different layers. FadeForwards combines a '
            'short slide with a fade. FadeUpwards is a vertical fade-up '
            'with no horizontal travel. Zoom does a scale with a brief '
            'opacity dip. OpenUpwards uses a curtain that lifts. '
            'Cupertino is a parallax slide with no fade.'),
      ],
    ),
  );
}

// =============================================================================
//                ACT 6  ::  PAGE-CONTENT SAMPLES AT t = 0.5
// =============================================================================

Widget _buildAct6PageSamples(
  BuildContext context,
  Widget login,
  Widget dashboard,
  Widget settings,
) {
  // Three different real-world content widgets, all frozen mid-transition.
  return _sectionCard(
    act: 'ACT  VI',
    title: 'Three different pages, all caught at mid-cue',
    subtitle: 'How the same builder handles login, dashboard, and settings',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Page transitions are content-agnostic. The builder neither knows '
          'nor cares what is inside the `child`. Below, three quite '
          'different pages -- a login screen, a metrics dashboard, and a '
          'settings list -- are all frozen halfway through the same '
          'forward fade.',
          style: kStyleBody,
        ),
        _gap(12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _frameCard(
                context: context,
                t: 0.5,
                freezer: _frozenFadeForwards,
                child: login,
                caption: 'Login at mid-cue',
              ),
              _frameCard(
                context: context,
                t: 0.5,
                freezer: _frozenFadeForwards,
                child: dashboard,
                caption: 'Dashboard at mid-cue',
              ),
              _frameCard(
                context: context,
                t: 0.5,
                freezer: _frozenFadeForwards,
                child: settings,
                caption: 'Settings at mid-cue',
              ),
            ],
          ),
        ),
        _gap(10),
        _calloutDo(
            'Trust the builder with arbitrary content',
            'Whether the page is a TextField-heavy form or a chart-heavy '
            'dashboard, the transition envelope is the same. Test a few '
            'real pages mid-cue to make sure no element crosses the seam '
            'in a distracting way.'),
        _calloutAvoid(
            'Animate the page content concurrently',
            'If your page itself runs an entrance animation that overlaps '
            'with the route transition, the user sees two motions stacked '
            'on top of each other. Either delay the in-page animation '
            'until the route settles, or skip it on first frame.'),
      ],
    ),
  );
}

// =============================================================================
//                  ACT 7  ::  THEMING AND APP-WIDE DEFAULTS
// =============================================================================

Widget _buildAct7Theming() {
  return _sectionCard(
    act: 'ACT  VII',
    title: 'Theming notes  ::  PageTransitionsTheme defaults',
    subtitle: 'Where to plug FadeForwards into a real ThemeData',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'PageTransitionsTheme is a ThemeExtension-friendly value object. '
          'It maps TargetPlatform to PageTransitionsBuilder. To make all '
          'Android pushes use the forward fade, set the entry for '
          'TargetPlatform.android.',
          style: kStyleBody,
        ),
        _gap(10),
        _kvRow('Material 3 default (Android)',
            'FadeForwardsPageTransitionsBuilder()'),
        _kvRow('Material 2 legacy (Android)',
            'FadeUpwardsPageTransitionsBuilder()'),
        _kvRow('Android Q+ snapshot',
            'ZoomPageTransitionsBuilder()'),
        _kvRow('iOS / macOS', 'CupertinoPageTransitionsBuilder()'),
        _kvRow('Linux desktop', 'FadeForwardsPageTransitionsBuilder()'),
        _kvRow('Windows / Fuchsia', 'ZoomPageTransitionsBuilder()'),
        _gap(10),
        _doubleRule(),
        Text('Const constructor', style: kStyleSubsection),
        _gap(6),
        Text(
          'Every builder in this family is `const`-constructible. That '
          'means you can hard-code the PageTransitionsTheme into a const '
          'ThemeData factory and have the framework re-use the exact same '
          'instance across all routes -- no per-push allocation.',
          style: kStyleBody,
        ),
        _gap(8),
        _codeBlock(
          'static const PageTransitionsTheme kPageTheme =\n'
          '    PageTransitionsTheme(builders: <TargetPlatform,\n'
          '        PageTransitionsBuilder>{\n'
          '      TargetPlatform.android:\n'
          '          FadeForwardsPageTransitionsBuilder(),\n'
          '    });\n',
        ),
        _gap(8),
        _calloutDo(
            'Pin one builder per platform',
            'Mixing builders inside the same platform key is not allowed; '
            'the map is keyed by TargetPlatform, not by route name. If '
            'you need per-route customization, use PageRouteBuilder with '
            'a custom transitionsBuilder argument instead.'),
        _calloutAvoid(
            'Switch builders mid-app-lifetime',
            'PageTransitionsTheme is read on each push. Changing it at '
            'runtime via ThemeData rebuilds will affect *future* pushes '
            'only; routes that are mid-flight keep using whichever builder '
            'they were started with.'),
      ],
    ),
  );
}

// =============================================================================
//                       ACT 8  ::  CUE SHEET OF DOs / AVOIDs
// =============================================================================

Widget _buildAct8CueSheet() {
  return _sectionCard(
    act: 'ACT  VIII',
    title: 'Stage manager\'s cue sheet',
    subtitle: 'Read once before every show; pin near the prompt corner',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Cue calls', style: kStyleSubsection),
        _gap(6),
        _cueLine('Q1  GO',
            'House to half. Ensure transitionDuration is the framework '
            'default (~300ms); custom durations break the M3 rhythm.'),
        _cueLine('Q2  GO',
            'Cross-fade the *outgoing* page using the secondary animation; '
            'do not let the old page sit at full alpha.'),
        _cueLine('Q3  GO',
            'Respect Directionality. RTL locales should slide from the '
            'left, not the right. The builder reads the BuildContext\'s '
            'Directionality automatically.'),
        _cueLine('Q4  GO',
            'Test on a real device. Frozen-frame previews look identical '
            'to the live transition, but timing-feel only emerges at full '
            'speed.'),
        _gap(10),
        _cueWarn('Q5  HOLD',
            'Do not wrap the result of buildTransitions in another '
            'AnimatedBuilder driven by the same animation. You will get '
            'doubled curves.'),
        _cueWarn('Q6  HOLD',
            'Do not call buildTransitions from inside a build method '
            'unless you are dramatising it (as we are here). In production '
            'code, leave it to the Navigator.'),
        _cueWarn('Q7  HOLD',
            'Do not depend on the slide distance being constant. The '
            'builder may scale the slide based on MediaQuery.size; phones '
            'and tablets will not match exactly.'),
        _gap(10),
        _doubleRule(),
        Text('Glossary for the assistant stage manager', style: kStyleSubsection),
        _gap(6),
        _kvRow('proscenium',
            'the visible "frame" around the stage; analogous to the safe '
                'area MediaQuery.padding.'),
        _kvRow('scrim',
            'a translucent gauze drop; analogous to a faint white overlay '
                'at low opacity.'),
        _kvRow('cue',
            'a numbered command from the stage manager; analogous to '
                'an animation status callback.'),
        _kvRow('flush',
            'when a piece of scenery comes to rest exactly in line; '
                'analogous to t = 1.0.'),
        _kvRow('curtain call',
            'the bow at the end of the show; analogous to the route '
                'pop animation, played in reverse.'),
      ],
    ),
  );
}

// =============================================================================
//                      ACT 9  ::  CURTAIN CALL  (PALETTE)
// =============================================================================

Widget _buildAct9CurtainCall() {
  return _sectionCard(
    act: 'ACT  IX',
    title: 'Curtain call  ::  the Curtain Garnet palette',
    subtitle: 'Twenty-five named colours that played each role',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'A theatre is only as convincing as its colour discipline. The '
          'Curtain Garnet palette uses five families: garnet velvet, '
          'auditorium dim, footlight gold, brass gilt, and programme paper.',
          style: kStyleBody,
        ),
        _gap(10),
        Wrap(
          children: <Widget>[
            _swatch(kCurtainGarnetDeep, 'CurtainGarnetDeep', 'heavy drapery'),
            _swatch(kCurtainGarnet, 'CurtainGarnet', 'primary curtain'),
            _swatch(kCurtainGarnetLight, 'CurtainGarnetLight', 'lit fold'),
            _swatch(kCurtainGarnetGlow, 'CurtainGarnetGlow', 'highlight'),
            _swatch(kCurtainPlumShadow, 'CurtainPlumShadow', 'backstage'),
            _swatch(kAuditoriumBlack, 'AuditoriumBlack', 'house void'),
            _swatch(kAuditoriumDimPlum, 'AuditoriumDimPlum', 'mezzanine'),
            _swatch(kFootlightGold, 'FootlightGold', 'warm front light'),
            _swatch(kFootlightAmber, 'FootlightAmber', 'amber spill'),
            _swatch(kBrassGiltLight, 'BrassGiltLight', 'proscenium trim'),
            _swatch(kBrassGiltDeep, 'BrassGiltDeep', 'engraved metal'),
            _swatch(kStageBoardOak, 'StageBoardOak', 'wooden boards'),
            _swatch(kStageBoardLight, 'StageBoardLight', 'sun-warmed plank'),
            _swatch(kProgrammeIvory, 'ProgrammeIvory', 'playbill paper'),
            _swatch(kProgrammeCream, 'ProgrammeCream', 'older programme'),
            _swatch(kScrimPaleRose, 'ScrimPaleRose', 'gauze scrim'),
            _swatch(kScrimDuskRose, 'ScrimDuskRose', 'tinted gauze'),
            _swatch(kSpotlightWhite, 'SpotlightWhite', 'spotlight core'),
            _swatch(kVelvetCordCrimson, 'VelvetCordCrimson', 'tassel cord'),
            _swatch(kInkPlaybill, 'InkPlaybill', 'playbill text'),
            _swatch(kInkPlaybillSoft, 'InkPlaybillSoft', 'softer body'),
            _swatch(kInkPlaybillFade, 'InkPlaybillFade', 'caption ink'),
            _swatch(kRibbonSilver, 'RibbonSilver', 'award ribbon'),
            _swatch(kCueSheetGreen, 'CueSheetGreen', 'SM annotation'),
            _swatch(kCueSheetRed, 'CueSheetRed', 'missed-cue red'),
          ],
        ),
        _gap(10),
        _calloutNote(
            'Theme thanks',
            'Curtain Garnet wishes to thank: the wardrobe department for '
            'the velvet cord, the gilders for the proscenium, the lighting '
            'desk for the footlight gold, and the front-of-house staff for '
            'the playbill ivory.'),
      ],
    ),
  );
}

// =============================================================================
//                              FOOTER
// =============================================================================

Widget _buildFooter() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: kCurtainGarnetDeep,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: kBrassGiltDeep, width: 1.4),
    ),
    child: Row(
      children: <Widget>[
        const Icon(Icons.theater_comedy,
            color: kFootlightGold, size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                'End of playbill  ::  FadeForwardsPageTransitionsBuilder',
                style: TextStyle(
                  color: kFootlightGold,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'Curtain Garnet edition  ::  one build, no controllers, no '
                'live async, frozen at AlwaysStoppedAnimation.',
                style: TextStyle(
                  color: kProgrammeIvory,
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

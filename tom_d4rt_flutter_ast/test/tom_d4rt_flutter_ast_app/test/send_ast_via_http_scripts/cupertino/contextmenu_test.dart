// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, unused_element_parameter, unused_field, unnecessary_import
// =============================================================================
//             OBSIDIAN AMBER --- CupertinoContextMenu deep dive
// =============================================================================
//
//  TARGET WIDGET .... CupertinoContextMenu  (package:flutter/cupertino.dart)
//                     CupertinoContextMenuAction
//
//  CONTEXT .......... The CupertinoContextMenu is the iOS long-press popover.
//                     On an iPhone, when you press-and-hold a photograph in
//                     the Photos app, a shock of haptic feedback fires; the
//                     background dims to a smoked obsidian; the photo lifts
//                     out of the page, hovering at the centre of the screen
//                     under an invisible spotlight; and a tidy stack of
//                     amber-lit action rows --- Copy, Share, Delete ---
//                     unfolds beneath it. CupertinoContextMenu is the Flutter
//                     embodiment of that gesture: a wrapper that turns any
//                     child widget into a press-and-hold target which opens a
//                     full-screen ceremonial popover containing the child
//                     (enlarged or replaced by a previewBuilder) and a list
//                     of CupertinoContextMenuAction rows.
//
//                     Apple's HIG describes context menus as "secondary
//                     gestures": they must never be the only path to a
//                     command, only an accelerator. They are tactile, fast,
//                     and faintly theatrical. The visual grammar is precise:
//                     dimmed background, focused subject hovering above its
//                     row, soft drop shadow, single hairline divider between
//                     each action row, destructive actions in red, default
//                     action in bold, optional trailing glyph aligned to the
//                     right of every row.
//
//                     This demo dramatises the SHAPE and SLOTS of the
//                     CupertinoContextMenu and its sibling
//                     CupertinoContextMenuAction. Because the menu only
//                     OPENS in response to a real long-press gesture, and
//                     this demo is rendered as a static snapshot, we cannot
//                     show the menu in its open ceremonial state from a
//                     stateless render alone. Instead we display:
//                     (a) real CupertinoContextMenu instances in their
//                     closed/dormant state, so the reader sees the legal
//                     wrapper widget; (b) hand-drawn mock-ups of the open
//                     ceremonial popover, where we paint exactly the same
//                     pixels the framework would paint when the menu is
//                     open; and (c) a row-by-row gallery of every
//                     CupertinoContextMenuAction property combination.
//
//  CONSTRUCTORS (the actual API)
//
//      CupertinoContextMenu({
//        Key? key,
//        required List<Widget> actions,
//        required Widget child,
//        bool enableHapticFeedback = false,
//      })
//
//      CupertinoContextMenu.builder({
//        Key? key,
//        required List<Widget> actions,
//        required CupertinoContextMenuBuilder builder,
//        bool enableHapticFeedback = false,
//      })
//
//      CupertinoContextMenuAction({
//        Key? key,
//        required Widget child,
//        bool isDefaultAction = false,
//        bool isDestructiveAction = false,
//        VoidCallback? onPressed,
//        IconData? trailingIcon,
//      })
//
//  PROPERTIES UNDER GLASS  (CupertinoContextMenu)
//
//      child          --- The widget that is shown when the menu is closed.
//                         It is the "tappable region". When the user long-
//                         presses it, the framework re-parents the same
//                         widget into the ceremonial popover. Common
//                         choices: an Image, a Card, a list-tile, a media
//                         thumbnail. iOS expects a self-contained chunk
//                         of UI: the menu animates it bodily onto a stage.
//      actions        --- The list of rows that appear beneath the lifted
//                         child. Each entry should be a
//                         CupertinoContextMenuAction. The framework will
//                         draw hairline dividers automatically between
//                         them. iOS HIG suggests 3-5 actions; more than 6
//                         is generally a smell.
//      enableHapticFeedback --- When true the framework fires a HapticFeedback.
//                         heavyImpact pulse when the menu opens. iOS native
//                         apps fire it almost universally. Default false in
//                         Flutter to preserve battery on non-iOS builds.
//
//  PROPERTIES UNDER GLASS  (CupertinoContextMenu.builder)
//
//      builder        --- A CupertinoContextMenuBuilder = Widget Function(
//                           BuildContext context,
//                           Animation<double> animation,
//                         ). Allows the wrapped child to morph during the
//                         opening animation. For instance, a small thumbnail
//                         can blossom into a full-screen preview as
//                         `animation.value` slides from 0.0 to 1.0. The
//                         animation argument exposes the menu's progress; at
//                         0.0 it is fully closed, at 1.0 fully open. A
//                         photo gallery preview is the canonical use case.
//
//  PROPERTIES UNDER GLASS  (CupertinoContextMenuAction)
//
//      child          --- The headline widget of the action row. Almost
//                         always a Text. May also be a Row(Text, badge) if
//                         your label needs an inline marker.
//      onPressed      --- VoidCallback? fired when the user releases on top
//                         of the action. If null the row is disabled (greyed).
//      isDefaultAction --- When true the label is drawn in BOLD. iOS uses
//                         this for the primary action in the stack: "Reply"
//                         in Mail, "Open" in Files. There should be at most
//                         one default action per menu.
//      isDestructiveAction --- When true the label and trailing icon are drawn
//                         in iOS systemRed. Use ONLY for actions that cannot
//                         be undone trivially: Delete, Erase, Discard. Apple
//                         is very strict about this; the red colour is a
//                         visual contract with the user.
//      trailingIcon   --- IconData? drawn at the right edge of the row,
//                         aligned to a 16-pt safe-area inset. iOS expects
//                         every action to declare a trailing icon when
//                         feasible. Examples: CupertinoIcons.share,
//                         CupertinoIcons.doc_on_doc, CupertinoIcons.trash.
//
//  STATIC SURFACES (CupertinoContextMenu)
//
//      kOpenBorderRadius --- The hard-coded border radius of the lifted
//                         child while the menu is open. Approximately 12.0
//                         in modern Flutter.
//      animationOpensAt --- The fraction of the open animation at which
//                         the menu visually "snaps" to its open state.
//                         Usually ~0.75. Below this fraction the menu is
//                         considered "still opening".
//
//  WHAT WE DO NOT TOUCH
//
//      Any StatefulWidget / setState       [no live mutation]
//      Any Timer / Future / Stream         [no async]
//      Any real long-press gesture         [demo is static]
//      Any HapticFeedback fire             [we only read the flag]
//
//  D4RT CONSTRAINTS
//
//      * build() is invoked exactly ONCE. We return a single snapshot.
//      * No StatefulWidget, no setState, no controllers driven, no timers.
//      * No `for-in` over BridgedInstance: indexed loops only.
//      * Use `.withValues(alpha: ...)` instead of `.withOpacity()`.
//      * Imports: cupertino, material, foundation.
//
//  THEME ............ OBSIDIAN AMBER
//
//                     A late-night reading lamp on a black oak desk. The
//                     room is dark; the desk is volcanic, glassy obsidian.
//                     A single amber bulb glows over a half-empty teacup
//                     and a leather-bound notebook. The page is the colour
//                     of warm vellum. The ink is dark wax brown. The
//                     accent is a quiet amber, the gold of a long-burnt
//                     candle. Highlights are honey. Destructive moments
//                     are blood-red, drawn with a single careful flourish.
//
//                     Visual grammar:
//                       background:   obsidian-black           #0B0B0E
//                       surface:      smoked midnight          #15161C
//                       paper:        warm vellum              #F4ECDC
//                       ink:          dark wax                 #2A2118
//                       amber:        candlelight              #E6A340
//                       honey:        warm gold                #F5C97C
//                       danger:       cinnabar red             #B7321C
//                       hairline:     pencil grey              #4A4239
//
//                     Prose tone: a librarian's late-night annotation,
//                     half scholarly half theatrical, the kind of voice
//                     that lingers in marginalia.
//
//  FILE LAYOUT (visual sections)
//
//      Section  1 .... Title banner with palette swatches and obsidian sigil
//      Section  2 .... Dossier of CupertinoContextMenu purpose and gesture
//      Section  3 .... Anatomy diagram of the open ceremonial popover
//      Section  4 .... Anatomy of the closed dormant child wrapper
//      Section  5 .... Recipe gallery (image, list-tile, media card, ...)
//      Section  6 .... CupertinoContextMenuAction property matrix
//      Section  7 .... Real live CupertinoContextMenu instances
//      Section  8 .... Comparison vs Material PopupMenuButton
//      Section  9 .... Common pitfalls and how to avoid them
//      Section 10 .... Glossary
//      Section 11 .... Recap and parting note
//
// =============================================================================

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// =============================================================================
//                          OBSIDIAN AMBER PALETTE
// =============================================================================

const Color _kObsidian = Color(0xFF0B0B0E);
const Color _kMidnight = Color(0xFF15161C);
const Color _kPaper = Color(0xFFF4ECDC);
const Color _kInk = Color(0xFF2A2118);
const Color _kAmber = Color(0xFFE6A340);
const Color _kHoney = Color(0xFFF5C97C);
const Color _kDanger = Color(0xFFB7321C);
const Color _kHairline = Color(0xFF4A4239);
const Color _kSmoke = Color(0xFF22232B);
const Color _kCharcoal = Color(0xFF1B1C22);
const Color _kVellum2 = Color(0xFFEFE4CC);
const Color _kAmberDim = Color(0xFFB8821F);
const Color _kDangerDim = Color(0xFF7A2110);
const Color _kIvory = Color(0xFFFBF6E9);

// =============================================================================
//                          TYPOGRAPHY HELPERS
// =============================================================================

TextStyle _titleStyle() {
  return const TextStyle(
    color: _kAmber,
    fontSize: 22.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.6,
  );
}

TextStyle _subtitleStyle() {
  return const TextStyle(
    color: _kHoney,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.4,
  );
}

TextStyle _bodyStyle() {
  return const TextStyle(
    color: _kPaper,
    fontSize: 12.5,
    fontWeight: FontWeight.w400,
    height: 1.45,
  );
}

TextStyle _captionStyle() {
  return const TextStyle(
    color: _kHoney,
    fontSize: 11.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.3,
  );
}

TextStyle _monoStyle() {
  return const TextStyle(
    color: _kVellum2,
    fontSize: 11.5,
    fontWeight: FontWeight.w400,
    fontFamily: 'monospace',
    height: 1.5,
  );
}

TextStyle _labelStyle() {
  return const TextStyle(
    color: _kAmber,
    fontSize: 13.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );
}

TextStyle _dangerStyle() {
  return const TextStyle(
    color: _kDanger,
    fontSize: 13.5,
    fontWeight: FontWeight.w500,
  );
}

// =============================================================================
//                          DECORATION HELPERS
// =============================================================================

BoxDecoration _cardDecoration() {
  return BoxDecoration(
    color: _kMidnight,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(color: _kHairline, width: 0.8),
  );
}

BoxDecoration _paperDecoration() {
  return BoxDecoration(
    color: _kPaper,
    borderRadius: BorderRadius.circular(12.0),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: _kAmber.withValues(alpha: 0.18),
        blurRadius: 22.0,
        spreadRadius: 1.0,
        offset: const Offset(0.0, 6.0),
      ),
    ],
  );
}

BoxDecoration _amberAccent() {
  return BoxDecoration(
    color: _kAmber.withValues(alpha: 0.14),
    borderRadius: BorderRadius.circular(8.0),
    border: Border.all(color: _kAmber.withValues(alpha: 0.45), width: 0.8),
  );
}

BoxDecoration _dangerAccent() {
  return BoxDecoration(
    color: _kDanger.withValues(alpha: 0.12),
    borderRadius: BorderRadius.circular(8.0),
    border: Border.all(color: _kDanger.withValues(alpha: 0.50), width: 0.8),
  );
}

// =============================================================================
//                          SECTION 1 -- TITLE BANNER
// =============================================================================

Widget _swatch(Color color, String name, String hex) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 14.0,
          height: 14.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3.0),
            border: Border.all(color: _kHairline, width: 0.5),
          ),
        ),
        const SizedBox(width: 6.0),
        Text(name, style: _captionStyle()),
        const SizedBox(width: 4.0),
        Text(hex, style: _monoStyle()),
      ],
    ),
  );
}

Widget _obsidianSigil() {
  return Container(
    width: 44.0,
    height: 44.0,
    decoration: BoxDecoration(
      color: _kObsidian,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kAmber, width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kAmber.withValues(alpha: 0.30),
          blurRadius: 12.0,
          spreadRadius: 0.5,
        ),
      ],
    ),
    child: const Center(
      child: Icon(CupertinoIcons.hand_draw, color: _kAmber, size: 22.0),
    ),
  );
}

Widget _titleBanner() {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _kCharcoal,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kAmber.withValues(alpha: 0.6), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _obsidianSigil(),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('OBSIDIAN AMBER', style: _captionStyle()),
                  const SizedBox(height: 2.0),
                  Text('CupertinoContextMenu', style: _titleStyle()),
                  const SizedBox(height: 2.0),
                  Text('iOS long-press popover, deep field guide',
                      style: _subtitleStyle()),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(height: 1.0, color: _kHairline),
        const SizedBox(height: 10.0),
        Text('palette', style: _labelStyle()),
        const SizedBox(height: 6.0),
        Wrap(
          children: <Widget>[
            _swatch(_kObsidian, 'obsidian', '#0B0B0E'),
            _swatch(_kMidnight, 'midnight', '#15161C'),
            _swatch(_kPaper, 'paper', '#F4ECDC'),
            _swatch(_kInk, 'ink', '#2A2118'),
            _swatch(_kAmber, 'amber', '#E6A340'),
            _swatch(_kHoney, 'honey', '#F5C97C'),
            _swatch(_kDanger, 'danger', '#B7321C'),
            _swatch(_kHairline, 'hairline', '#4A4239'),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
//                  SECTION HEADER HELPER (reused across sections)
// =============================================================================

Widget _sectionHeader(String number, String title, String subtitle) {
  return Padding(
    padding: const EdgeInsets.only(top: 24.0, bottom: 10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 34.0,
          height: 34.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _kAmber.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: _kAmber, width: 0.8),
          ),
          child: Text(number,
              style: const TextStyle(
                  color: _kAmber, fontWeight: FontWeight.w700, fontSize: 14.0)),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: _titleStyle()),
              const SizedBox(height: 2.0),
              Text(subtitle, style: _subtitleStyle()),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _proseBlock(String body) {
  return Container(
    margin: const EdgeInsets.only(top: 6.0, bottom: 6.0),
    padding: const EdgeInsets.all(12.0),
    decoration: _cardDecoration(),
    child: Text(body, style: _bodyStyle()),
  );
}

Widget _codeBlock(String code) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: _kObsidian,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: _kAmber.withValues(alpha: 0.45), width: 0.8),
    ),
    child: Text(code, style: _monoStyle()),
  );
}

// =============================================================================
//                       SECTION 2 -- DOSSIER (iOS UX)
// =============================================================================

Widget _dossierSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('02', 'Dossier', 'A field guide to the iOS long-press popover'),
      _proseBlock(
        'The CupertinoContextMenu is the Flutter realisation of one of iOS\'s most '
        'recognisable gestures: the long-press lift. When the user holds a finger '
        'on a target for ~500ms, the surrounding interface dims, the target lifts '
        'out of the page, a haptic pulse fires, and a stack of action rows '
        'unfolds beneath the lifted subject. The gesture is everywhere on iOS: '
        'on photos in the Photos app, on links in Safari, on messages in Mail, '
        'on apps on the Home Screen, on files in Files.',
      ),
      _proseBlock(
        'Apple\'s Human Interface Guidelines treat context menus as a strictly '
        'SECONDARY accelerator. They must never be the only path to a command. '
        'Every action exposed in a context menu must also be reachable through '
        'a primary, visible control --- usually a navigation bar item, a swipe '
        'action, or a detail-view button. The role of the context menu is to '
        'be a power-user shortcut, not a hidden affordance.',
      ),
      _proseBlock(
        'Visually the menu has a fixed, almost ceremonial shape. The background '
        'is dimmed to a deep smoky overlay, roughly 70% black. The lifted '
        'subject hovers at its natural position (or floats to centre, for very '
        'small targets) with a soft drop shadow and a 12-pt corner radius. '
        'Below it a vertical stack of action rows appears, set in a frosted '
        'glass material with hairline dividers between rows. Action labels '
        'are left-aligned, trailing icons right-aligned, with a 16-pt safe '
        'inset on either side.',
      ),
      _proseBlock(
        'Action rows obey a strict typographic contract. Default action: bold '
        'label. Destructive action: red label and red trailing icon, drawn '
        'in iOS systemRed. Ordinary action: standard weight, primary label '
        'colour for the active appearance. Disabled action: greyed label, '
        'no haptic on tap, no dismissal. iOS expects three to five actions '
        'in a single context menu; more than six is a code smell and should '
        'be split into a sub-menu or moved to a navigation bar.',
      ),
      _proseBlock(
        'The gesture is partially undoable: while the menu is opening the '
        'user can release at any time to abort, and the lifted subject will '
        'snap back into place. Once the menu has fully bloomed (animation '
        'fraction >= animationOpensAt, roughly 0.75), tapping outside the '
        'menu dismisses it, while tapping a row commits to its onPressed '
        'callback and closes the menu in a single tween.',
      ),
    ],
  );
}

// =============================================================================
//                  SECTION 3 -- ANATOMY OF THE OPEN POPOVER
// =============================================================================

Widget _openPopoverMock() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 16.0),
    decoration: BoxDecoration(
      color: _kObsidian.withValues(alpha: 0.94),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kHairline, width: 0.8),
    ),
    child: Column(
      children: <Widget>[
        // The lifted subject (a faux photograph)
        Container(
          width: 200.0,
          height: 130.0,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[_kAmber, _kHoney, _kPaper],
            ),
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.55),
                blurRadius: 22.0,
                spreadRadius: 1.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: const Center(
            child: Icon(CupertinoIcons.photo, color: _kInk, size: 42.0),
          ),
        ),
        const SizedBox(height: 18.0),
        // The action stack (frosted glass)
        Container(
          width: 230.0,
          decoration: BoxDecoration(
            color: _kVellum2.withValues(alpha: 0.96),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: _kHairline.withValues(alpha: 0.4)),
          ),
          child: Column(
            children: <Widget>[
              _mockActionRow('Copy', CupertinoIcons.doc_on_doc, false, false),
              _mockDivider(),
              _mockActionRow('Share', CupertinoIcons.share, true, false),
              _mockDivider(),
              _mockActionRow('Edit', CupertinoIcons.pencil, false, false),
              _mockDivider(),
              _mockActionRow('Delete', CupertinoIcons.trash, false, true),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _mockActionRow(String label, IconData icon, bool isDefault, bool isDestructive) {
  final Color textColor = isDestructive ? _kDanger : _kInk;
  final FontWeight weight = isDefault ? FontWeight.w700 : FontWeight.w500;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 13.0),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Text(label,
              style: TextStyle(
                  color: textColor, fontWeight: weight, fontSize: 14.5)),
        ),
        Icon(icon, color: textColor, size: 18.0),
      ],
    ),
  );
}

Widget _mockDivider() {
  return Container(height: 0.5, color: _kHairline.withValues(alpha: 0.35));
}

Widget _anatomyCallout(String label, String description) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.only(top: 5.0, right: 8.0),
          decoration: const BoxDecoration(
              color: _kAmber, shape: BoxShape.circle),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: _bodyStyle(),
              children: <InlineSpan>[
                TextSpan(text: '$label  ', style: _labelStyle()),
                TextSpan(text: description),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _anatomySection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('03', 'Anatomy (open state)',
          'The ceremonial popover: subject, stack, and frame'),
      _proseBlock(
        'Below is a hand-painted mock of the open ceremonial popover. The '
        'CupertinoContextMenu builds this entire scene by itself: there is '
        'no need for you to declare a Dialog, an overlay, or a Stack. You '
        'only pass it the child (the subject) and a list of actions (the '
        'stack). The dimmed background, the frosted-glass card, the corner '
        'radius, the hairline dividers, the drop shadow --- all are framework '
        'territory.',
      ),
      _openPopoverMock(),
      const SizedBox(height: 12.0),
      Container(
        padding: const EdgeInsets.all(12.0),
        decoration: _cardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Callouts', style: _labelStyle()),
            const SizedBox(height: 6.0),
            _anatomyCallout('background', 'a deep smoked overlay (~70% black) dims the rest of the page; declarative, no widget needed.'),
            _anatomyCallout('subject', 'your `child` widget, lifted bodily out of the page with a 12-pt corner radius and a soft drop shadow.'),
            _anatomyCallout('stack', 'the actions list, drawn as a frosted glass card with hairline dividers between rows.'),
            _anatomyCallout('row label', 'a single line of text, left-aligned, with a font weight that flips to bold when isDefaultAction is true.'),
            _anatomyCallout('trailing icon', 'optional IconData drawn at the right edge of the row; aligns to a 16-pt safe inset.'),
            _anatomyCallout('destructive colour', 'when isDestructiveAction is true the label and icon turn iOS systemRed.'),
            _anatomyCallout('haptic pulse', 'fires once on open when enableHapticFeedback is true; controlled at the menu level, not per-action.'),
          ],
        ),
      ),
    ],
  );
}

// =============================================================================
//             SECTION 4 -- ANATOMY OF THE CLOSED CHILD WRAPPER
// =============================================================================

Widget _closedAnatomy() {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: _cardDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('closed / dormant', style: _labelStyle()),
        const SizedBox(height: 6.0),
        Text(
          'When the menu is not open the CupertinoContextMenu renders ONLY its '
          'child. There is no chrome, no hairline, no shadow. The wrapper is '
          'invisible; only the gesture detector is active. Visually the child '
          'looks exactly as if you had never wrapped it.',
          style: _bodyStyle(),
        ),
        const SizedBox(height: 12.0),
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('without wrapper', style: _captionStyle()),
                  const SizedBox(height: 6.0),
                  Container(
                    width: double.infinity,
                    height: 90.0,
                    decoration: BoxDecoration(
                      color: _kAmber.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Center(
                      child: Icon(CupertinoIcons.photo,
                          color: _kInk, size: 28.0),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('with CupertinoContextMenu wrapper',
                      style: _captionStyle()),
                  const SizedBox(height: 6.0),
                  Container(
                    width: double.infinity,
                    height: 90.0,
                    decoration: BoxDecoration(
                      color: _kAmber.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Center(
                      child: Icon(CupertinoIcons.photo,
                          color: _kInk, size: 28.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          'Both sides look identical: the wrapper is intentionally transparent '
          'until the long-press gesture fires.',
          style: _bodyStyle(),
        ),
      ],
    ),
  );
}

Widget _closedSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('04', 'Anatomy (closed state)',
          'The dormant wrapper renders only the child'),
      _closedAnatomy(),
    ],
  );
}

// =============================================================================
//                       SECTION 5 -- RECIPE GALLERY
// =============================================================================

Widget _recipeCard(String title, String description, Widget recipe) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: _cardDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: _labelStyle()),
        const SizedBox(height: 4.0),
        Text(description, style: _bodyStyle()),
        const SizedBox(height: 10.0),
        recipe,
      ],
    ),
  );
}

// recipe 1 -- image with edit/share/delete
Widget _recipeImage() {
  return CupertinoContextMenu(
    actions: <Widget>[
      CupertinoContextMenuAction(
        trailingIcon: CupertinoIcons.pencil,
        onPressed: () {
          if (kDebugMode) {
            print('edit');
          }
        },
        child: const Text('Edit'),
      ),
      CupertinoContextMenuAction(
        trailingIcon: CupertinoIcons.share,
        onPressed: () {
          if (kDebugMode) {
            print('share');
          }
        },
        child: const Text('Share'),
      ),
      CupertinoContextMenuAction(
        isDestructiveAction: true,
        trailingIcon: CupertinoIcons.trash,
        onPressed: () {
          if (kDebugMode) {
            print('delete');
          }
        },
        child: const Text('Delete'),
      ),
    ],
    child: Container(
      width: 180.0,
      height: 130.0,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_kAmber, _kHoney, _kPaper],
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: const Center(
        child: Icon(CupertinoIcons.photo, color: _kInk, size: 40.0),
      ),
    ),
  );
}

// recipe 2 -- list-tile with copy/select-all/forward
Widget _recipeListTile() {
  return CupertinoContextMenu(
    actions: <Widget>[
      CupertinoContextMenuAction(
        isDefaultAction: true,
        trailingIcon: CupertinoIcons.arrowshape_turn_up_right,
        onPressed: () {
          if (kDebugMode) {
            print('reply');
          }
        },
        child: const Text('Reply'),
      ),
      CupertinoContextMenuAction(
        trailingIcon: CupertinoIcons.doc_on_doc,
        onPressed: () {
          if (kDebugMode) {
            print('copy');
          }
        },
        child: const Text('Copy'),
      ),
      CupertinoContextMenuAction(
        trailingIcon: CupertinoIcons.checkmark_square,
        onPressed: () {
          if (kDebugMode) {
            print('select all');
          }
        },
        child: const Text('Select All'),
      ),
      CupertinoContextMenuAction(
        trailingIcon: CupertinoIcons.share_up,
        onPressed: () {
          if (kDebugMode) {
            print('forward');
          }
        },
        child: const Text('Forward'),
      ),
    ],
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
      decoration: BoxDecoration(
        color: _kPaper,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 36.0,
            height: 36.0,
            decoration: const BoxDecoration(
                color: _kAmber, shape: BoxShape.circle),
            child: const Center(
              child: Icon(CupertinoIcons.envelope, color: _kInk, size: 18.0),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Solveig Roth',
                    style: TextStyle(
                        color: _kInk, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2.0),
                Text('Re: tomorrow\'s harbour walk',
                    style: TextStyle(
                        color: _kInk.withValues(alpha: 0.65),
                        fontSize: 12.0)),
              ],
            ),
          ),
          const Icon(CupertinoIcons.chevron_right, color: _kInk, size: 16.0),
        ],
      ),
    ),
  );
}

// recipe 3 -- media card with custom previewBuilder via .builder factory
Widget _recipeBuilderCard() {
  return CupertinoContextMenu.builder(
    actions: <Widget>[
      CupertinoContextMenuAction(
        trailingIcon: CupertinoIcons.play_arrow,
        onPressed: () {
          if (kDebugMode) {
            print('play');
          }
        },
        child: const Text('Play'),
      ),
      CupertinoContextMenuAction(
        trailingIcon: CupertinoIcons.add_circled,
        onPressed: () {
          if (kDebugMode) {
            print('add to playlist');
          }
        },
        child: const Text('Add to Playlist'),
      ),
      CupertinoContextMenuAction(
        isDestructiveAction: true,
        trailingIcon: CupertinoIcons.minus_circle,
        onPressed: () {
          if (kDebugMode) {
            print('remove');
          }
        },
        child: const Text('Remove'),
      ),
    ],
    enableHapticFeedback: true,
    builder: (BuildContext context, Animation<double> animation) {
      // The framework calls this with animation.value sliding 0.0 -> 1.0
      // as the menu opens. We morph the card from a small thumb into a
      // poster-sized preview.
      return Container(
        width: 200.0,
        height: 130.0,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[_kInk, _kSmoke, _kCharcoal],
          ),
          borderRadius: BorderRadius.circular(
              CupertinoContextMenu.kOpenBorderRadius),
          border: Border.all(color: _kAmber, width: 1.0),
        ),
        child: const Center(
          child: Icon(CupertinoIcons.music_note,
              color: _kAmber, size: 36.0),
        ),
      );
    },
  );
}

// recipe 4 -- minimal text wrap
Widget _recipeText() {
  return CupertinoContextMenu(
    actions: <Widget>[
      CupertinoContextMenuAction(
        trailingIcon: CupertinoIcons.doc_on_doc,
        child: const Text('Copy'),
      ),
      CupertinoContextMenuAction(
        trailingIcon: CupertinoIcons.eye,
        child: const Text('Look Up'),
      ),
      CupertinoContextMenuAction(
        trailingIcon: CupertinoIcons.text_quote,
        child: const Text('Translate'),
      ),
    ],
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: _kPaper,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        'long-press to see what an iOS context menu offers around a paragraph',
        style: TextStyle(color: _kInk, fontSize: 13.0),
      ),
    ),
  );
}

// recipe 5 -- thumbnail row with destructive-only actions
Widget _recipeThumbDanger() {
  return CupertinoContextMenu(
    enableHapticFeedback: true,
    actions: <Widget>[
      CupertinoContextMenuAction(
        isDestructiveAction: true,
        trailingIcon: CupertinoIcons.delete,
        onPressed: () {
          if (kDebugMode) {
            print('move to trash');
          }
        },
        child: const Text('Move to Trash'),
      ),
      CupertinoContextMenuAction(
        isDestructiveAction: true,
        trailingIcon: CupertinoIcons.xmark_octagon,
        onPressed: () {
          if (kDebugMode) {
            print('erase permanently');
          }
        },
        child: const Text('Erase Permanently'),
      ),
    ],
    child: Container(
      width: 120.0,
      height: 80.0,
      decoration: BoxDecoration(
        color: _kDanger.withValues(alpha: 0.30),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _kDanger, width: 0.8),
      ),
      child: const Center(
        child: Icon(CupertinoIcons.trash, color: _kDanger, size: 26.0),
      ),
    ),
  );
}

Widget _recipeGallerySection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('05', 'Recipe gallery',
          'Five canonical CupertinoContextMenu shapes'),
      _proseBlock(
        'Each card below contains a REAL CupertinoContextMenu in its closed '
        'state. On a touch device a long-press will open the ceremonial '
        'popover with the actions shown in code beside each recipe. In this '
        'static snapshot you see only the dormant wrapper.',
      ),
      _recipeCard(
        'Image with edit / share / delete',
        'The classic Photos-app gesture. Three actions, the last one '
        'destructive (red, with a trash glyph). No default action.',
        _recipeImage(),
      ),
      _recipeCard(
        'List-tile with reply / copy / select-all / forward',
        'A four-action menu for an email row. Reply is the default action '
        '(bold). Trailing icons match iOS Mail.',
        _recipeListTile(),
      ),
      _recipeCard(
        'Media card with .builder factory and previewBuilder',
        'Uses CupertinoContextMenu.builder so the card can morph through '
        'the animation. enableHapticFeedback is on; a strong tap pulse fires '
        'when the menu opens.',
        _recipeBuilderCard(),
      ),
      _recipeCard(
        'Text paragraph with system actions',
        'A bare wrap of a Text widget exposes the iOS system trio: Copy, '
        'Look Up, Translate. Useful in reading apps.',
        _recipeText(),
      ),
      _recipeCard(
        'Thumbnail with destructive-only actions',
        'A trash bin thumbnail with two destructive rows. Apple\'s HIG '
        'normally discourages all-red menus, but for a trash-management view '
        'it can be appropriate.',
        _recipeThumbDanger(),
      ),
    ],
  );
}

// =============================================================================
//        SECTION 6 -- CupertinoContextMenuAction PROPERTY MATRIX
// =============================================================================

Widget _matrixHeaderRow() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: _kAmber.withValues(alpha: 0.18),
      borderRadius:
          const BorderRadius.vertical(top: Radius.circular(8.0)),
    ),
    child: Row(
      children: <Widget>[
        Expanded(flex: 5, child: Text('Variant', style: _labelStyle())),
        Expanded(flex: 4, child: Text('Props', style: _labelStyle())),
        Expanded(flex: 4, child: Text('Visual', style: _labelStyle())),
      ],
    ),
  );
}

Widget _matrixRow(
    String variant, String props, Widget visual, bool last) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    decoration: BoxDecoration(
      border: last
          ? null
          : Border(
              bottom: BorderSide(
                  color: _kHairline.withValues(alpha: 0.4), width: 0.6)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(flex: 5, child: Text(variant, style: _bodyStyle())),
        Expanded(flex: 4, child: Text(props, style: _monoStyle())),
        Expanded(flex: 4, child: visual),
      ],
    ),
  );
}

// Each "visual" is a hand-drawn mock of how the action row should look.
Widget _drawnAction(String label, IconData? icon,
    {bool defaultAction = false, bool destructive = false, bool disabled = false}) {
  Color color;
  if (destructive) {
    color = _kDanger;
  } else if (disabled) {
    color = _kInk.withValues(alpha: 0.35);
  } else {
    color = _kInk;
  }
  final FontWeight weight = defaultAction ? FontWeight.w700 : FontWeight.w500;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: _kVellum2,
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Text(label,
              style: TextStyle(color: color, fontSize: 12.0, fontWeight: weight)),
        ),
        if (icon != null) ...<Widget>[
          const SizedBox(width: 4.0),
          Icon(icon, color: color, size: 14.0),
        ],
      ],
    ),
  );
}

Widget _actionMatrixSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('06', 'CupertinoContextMenuAction matrix',
          'Every legal property combination at a glance'),
      _proseBlock(
        'The CupertinoContextMenuAction has five public knobs: child, '
        'onPressed, isDefaultAction, isDestructiveAction, and trailingIcon. '
        'The matrix below enumerates the canonical combinations. The Visual '
        'column is a hand-painted mock of how each row will appear on iOS.',
      ),
      Container(
        decoration: BoxDecoration(
          color: _kMidnight,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: _kHairline, width: 0.6),
        ),
        child: Column(
          children: <Widget>[
            _matrixHeaderRow(),
            _matrixRow(
              'Ordinary action',
              'child: Text\nonPressed: cb',
              _drawnAction('Copy', null),
              false,
            ),
            _matrixRow(
              'Ordinary + trailing icon',
              'trailingIcon: share',
              _drawnAction('Share', CupertinoIcons.share),
              false,
            ),
            _matrixRow(
              'Default action',
              'isDefaultAction: true',
              _drawnAction('Reply', CupertinoIcons.arrowshape_turn_up_right,
                  defaultAction: true),
              false,
            ),
            _matrixRow(
              'Default + no icon',
              'isDefaultAction: true',
              _drawnAction('Open', null, defaultAction: true),
              false,
            ),
            _matrixRow(
              'Destructive action',
              'isDestructiveAction: true\ntrailingIcon: trash',
              _drawnAction('Delete', CupertinoIcons.trash, destructive: true),
              false,
            ),
            _matrixRow(
              'Destructive + no icon',
              'isDestructiveAction: true',
              _drawnAction('Discard', null, destructive: true),
              false,
            ),
            _matrixRow(
              'Disabled (onPressed = null)',
              'onPressed: null',
              _drawnAction('Edit', CupertinoIcons.pencil, disabled: true),
              false,
            ),
            _matrixRow(
              'Long label, with icon',
              'trailingIcon: doc_on_doc',
              _drawnAction('Copy to Clipboard', CupertinoIcons.doc_on_doc),
              true,
            ),
          ],
        ),
      ),
      const SizedBox(height: 10.0),
      _proseBlock(
        'NOTE: isDefaultAction and isDestructiveAction are mutually meaningful '
        'but never combined: an action that is both default and destructive '
        'would be a contradiction in intent. The framework does not throw, '
        'but the visual outcome (bold red) is inappropriate per HIG.',
      ),
    ],
  );
}

// =============================================================================
//         SECTION 7 -- REAL LIVE CupertinoContextMenu INSTANCES
// =============================================================================

Widget _liveSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('07', 'Live instances',
          'Real wrappers in the dormant state, ready for long-press'),
      _proseBlock(
        'Below are five live CupertinoContextMenu instances mounted into the '
        'page. Each is wrapped in the surrounding CupertinoApp + '
        'CupertinoPageScaffold rooted at the build() function. On a real iOS '
        'device, a long-press on any of these targets will open the '
        'ceremonial popover.',
      ),
      Container(
        padding: const EdgeInsets.all(14.0),
        decoration: _cardDecoration(),
        child: Column(
          children: <Widget>[
            Text('1 . image with three actions', style: _labelStyle()),
            const SizedBox(height: 10.0),
            _liveBox(_recipeImage()),
            const SizedBox(height: 18.0),
            Text('2 . list-tile with reply/copy/select-all/forward',
                style: _labelStyle()),
            const SizedBox(height: 10.0),
            _liveBox(_recipeListTile()),
            const SizedBox(height: 18.0),
            Text('3 . media card with builder factory', style: _labelStyle()),
            const SizedBox(height: 10.0),
            _liveBox(_recipeBuilderCard()),
            const SizedBox(height: 18.0),
            Text('4 . text paragraph', style: _labelStyle()),
            const SizedBox(height: 10.0),
            _liveBox(_recipeText()),
            const SizedBox(height: 18.0),
            Text('5 . destructive-only thumbnail', style: _labelStyle()),
            const SizedBox(height: 10.0),
            _liveBox(_recipeThumbDanger()),
          ],
        ),
      ),
    ],
  );
}

Widget _liveBox(Widget child) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _kObsidian,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kHairline, width: 0.6),
    ),
    child: Center(child: child),
  );
}

// =============================================================================
//        SECTION 8 -- COMPARISON vs Material PopupMenuButton
// =============================================================================

Widget _comparisonRow(String aspect, String cupertino, String material) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      border: Border(
          bottom: BorderSide(
              color: _kHairline.withValues(alpha: 0.4), width: 0.5)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(flex: 4, child: Text(aspect, style: _labelStyle())),
        Expanded(flex: 5, child: Text(cupertino, style: _bodyStyle())),
        Expanded(flex: 5, child: Text(material, style: _bodyStyle())),
      ],
    ),
  );
}

Widget _comparisonSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('08', 'CupertinoContextMenu vs PopupMenuButton',
          'Different gestures, different mental models'),
      _proseBlock(
        'PopupMenuButton is Material\'s anchored drop-down: a tap on a button '
        'opens a small inline list near the anchor. CupertinoContextMenu is '
        'an iOS long-press popover: a press-and-hold gesture on any widget '
        'opens a full-screen ceremonial overlay. They solve adjacent '
        'problems with very different visual language.',
      ),
      Container(
        decoration: BoxDecoration(
          color: _kMidnight,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: _kHairline, width: 0.6),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: _kAmber.withValues(alpha: 0.18),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(flex: 4, child: Text('Aspect', style: _labelStyle())),
                  Expanded(flex: 5, child: Text('CupertinoContextMenu', style: _labelStyle())),
                  Expanded(flex: 5, child: Text('PopupMenuButton', style: _labelStyle())),
                ],
              ),
            ),
            _comparisonRow('gesture', 'long-press (~500ms) on the wrapped child', 'single tap on the anchor button'),
            _comparisonRow('overlay', 'full-screen dimmed scrim, subject lifted bodily', 'small floating card anchored to the button'),
            _comparisonRow('subject', 'the wrapped child appears in the overlay', 'only the menu items appear; no "subject"'),
            _comparisonRow('haptic', 'optional via enableHapticFeedback', 'no built-in haptic'),
            _comparisonRow('action API', 'CupertinoContextMenuAction with default/destructive flags', 'PopupMenuItem with value + child'),
            _comparisonRow('result delivery', 'each action has its own onPressed callback', 'a single onSelected callback receives the chosen value'),
            _comparisonRow('typical home', 'photos, files, messages, media cards', 'overflow ":" buttons, toolbars, list-item actions'),
            _comparisonRow('animation', 'multi-phase lift + dim + bloom', 'simple slide-in scale'),
            _comparisonRow('default action visual', 'bold label', 'no native equivalent'),
            _comparisonRow('destructive visual', 'iOS systemRed label and icon', 'must be styled manually'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(8.0)),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(flex: 4, child: Text('use when', style: _labelStyle())),
                  Expanded(flex: 5, child: Text('the target is a meaningful subject (photo, file) and the user might naturally long-press it', style: _bodyStyle())),
                  Expanded(flex: 5, child: Text('the target is an anonymous overflow button and you want a quick anchored drop-down', style: _bodyStyle())),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// =============================================================================
//             SECTION 9 -- COMMON PITFALLS AND HOW TO AVOID THEM
// =============================================================================

Widget _pitfall(String title, String description, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.50), width: 0.8),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: color, size: 22.0),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title,
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w700,
                      fontSize: 13.5)),
              const SizedBox(height: 4.0),
              Text(description, style: _bodyStyle()),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _pitfallsSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('09', 'Common pitfalls',
          'Mistakes that catch newcomers to CupertinoContextMenu'),
      _pitfall(
        'must live in a Cupertino-aware context',
        'CupertinoContextMenu uses Cupertino ancestors (CupertinoTheme, '
        'MediaQuery, Localizations) when it opens. Mounting it under a bare '
        'WidgetsApp with no CupertinoApp or MaterialApp wrapper will fail at '
        'open time. Always wrap your tree in CupertinoApp or MaterialApp '
        '(both provide the required ancestors).',
        CupertinoIcons.exclamationmark_triangle,
        _kAmber,
      ),
      _pitfall(
        'hero animation requirement',
        'The opening animation uses a hero-style flight: the framework needs '
        'an Overlay above the wrapped child. CupertinoApp and MaterialApp '
        'both install Navigator with an Overlay, so this is automatic in '
        'normal apps. If you mount a CupertinoContextMenu inside a custom '
        'host that lacks an Overlay (rare), the open animation will throw.',
        CupertinoIcons.flame,
        _kHoney,
      ),
      _pitfall(
        'do not overstack actions',
        'iOS HIG suggests 3-5 actions, 6 absolute max. More than that '
        'creates a wall of text that defeats the gesture\'s purpose as an '
        'accelerator. If you have more, split into sub-menus or move the '
        'rare actions out of the context menu entirely.',
        CupertinoIcons.layers_alt,
        _kAmber,
      ),
      _pitfall(
        'context menu must NOT be the only path',
        'The context menu is a SECONDARY accelerator. Every action exposed '
        'here must also be reachable through a primary, visible control. '
        'If the only way to delete a photo is to long-press it, novice users '
        'will be stranded. Always pair with a visible button or swipe action.',
        CupertinoIcons.eye_slash,
        _kHoney,
      ),
      _pitfall(
        'destructive colour is a contract',
        'iOS systemRed on an action row is a visual contract: this row will '
        'do something the user cannot undo with a single tap. Reserve '
        'isDestructiveAction for Delete, Erase, Discard, and Sign Out. Do '
        'NOT use it for routine "cancel" rows.',
        CupertinoIcons.flag,
        _kDanger,
      ),
      _pitfall(
        'one default action at most',
        'isDefaultAction renders the row in BOLD. Having two bold rows in '
        'the same menu defeats its purpose --- the user cannot tell which '
        'one is primary. Either pick one default or none.',
        CupertinoIcons.star,
        _kAmber,
      ),
      _pitfall(
        'do not animate the child yourself',
        'The framework already drives the lift / dim / bloom animation. '
        'Wrapping your child in an extra AnimatedContainer or rebuilt '
        'AnimationController will fight the framework\'s tween and produce '
        'a stuttering open. Use CupertinoContextMenu.builder if you need '
        'access to the framework\'s own animation.',
        CupertinoIcons.gear,
        _kHoney,
      ),
      _pitfall(
        'do not nest CupertinoContextMenu inside CupertinoContextMenu',
        'A long-press inside an already-open menu has no defined behaviour. '
        'Keep the gesture flat: the wrapped child should be a leaf widget '
        'with no further long-press handlers.',
        CupertinoIcons.nosign,
        _kDanger,
      ),
      _pitfall(
        'enableHapticFeedback only fires on iOS',
        'On Android and desktop the haptic call is a no-op. Setting the '
        'flag is safe cross-platform, but do not design your UX around '
        'the haptic; treat it as a bonus on iOS only.',
        CupertinoIcons.waveform,
        _kAmber,
      ),
    ],
  );
}

// =============================================================================
//                       SECTION 10 -- GLOSSARY
// =============================================================================

Widget _glossaryEntry(String term, String definition) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: _kSmoke,
      borderRadius: BorderRadius.circular(6.0),
      border: Border(
          left: BorderSide(
              color: _kAmber.withValues(alpha: 0.7), width: 3.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(term, style: _labelStyle()),
        const SizedBox(height: 3.0),
        Text(definition, style: _bodyStyle()),
      ],
    ),
  );
}

Widget _glossarySection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('10', 'Glossary', 'Marginalia from the field guide'),
      _glossaryEntry('long-press',
          'a touch held in place for >=~500ms without significant motion. The '
          'iOS pattern that triggers CupertinoContextMenu.'),
      _glossaryEntry('subject',
          'the wrapped child widget that the menu lifts into the popover.'),
      _glossaryEntry('stack',
          'the vertical list of action rows beneath the lifted subject.'),
      _glossaryEntry('default action',
          'an action drawn in bold; signals the primary choice in the menu.'),
      _glossaryEntry('destructive action',
          'an action drawn in iOS systemRed; signals an irreversible choice.'),
      _glossaryEntry('trailing icon',
          'an IconData drawn at the right edge of an action row, aligned to '
          'a 16-pt safe inset.'),
      _glossaryEntry('frosted glass',
          'the iOS visual material used for the action stack: a translucent '
          'card that blurs whatever is behind it.'),
      _glossaryEntry('scrim',
          'the dimmed full-screen overlay behind the lifted subject; '
          'typically ~70% black.'),
      _glossaryEntry('hairline',
          'a 0.5 to 1.0 logical-pixel divider, the iOS standard separator.'),
      _glossaryEntry('hero animation',
          'a flight animation that moves a widget from its origin position '
          'to a destination position via an Overlay; used by the framework '
          'to lift the subject into the popover.'),
      _glossaryEntry('builder factory',
          'the CupertinoContextMenu.builder constructor, which exposes the '
          'open animation so the child can morph as the menu opens.'),
      _glossaryEntry('animationOpensAt',
          'the fraction (~0.75) of the open animation at which the menu is '
          'considered fully open and can accept taps.'),
      _glossaryEntry('kOpenBorderRadius',
          'the fixed corner radius of the lifted subject while open (~12.0).'),
      _glossaryEntry('haptic',
          'a tactile vibration; HapticFeedback.heavyImpact on iOS when '
          'enableHapticFeedback is true.'),
      _glossaryEntry('overflow menu',
          'a Material idiom (the three-dot button) which is the closest '
          'kin to CupertinoContextMenu, though gesture and visuals differ.'),
    ],
  );
}

// =============================================================================
//                       SECTION 11 -- RECAP AND PARTING
// =============================================================================

Widget _recapBullet(String head, String body) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 6.0,
          height: 6.0,
          margin: const EdgeInsets.only(top: 7.0, right: 8.0),
          decoration:
              const BoxDecoration(color: _kAmber, shape: BoxShape.circle),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: _bodyStyle(),
              children: <InlineSpan>[
                TextSpan(text: '$head  ', style: _labelStyle()),
                TextSpan(text: body),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _recapSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('11', 'Recap', 'Parting marginalia for the lamp-lit desk'),
      Container(
        padding: const EdgeInsets.all(14.0),
        decoration: _cardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _recapBullet('gesture',
                'long-press a wrapped child to summon the ceremonial popover.'),
            _recapBullet('subject',
                'the wrapped child is lifted bodily; corner radius and shadow '
                'are framework-owned.'),
            _recapBullet('actions',
                'a list of CupertinoContextMenuAction. Three to five is the '
                'sweet spot.'),
            _recapBullet('default',
                'isDefaultAction: true draws the row in bold. At most one '
                'per menu.'),
            _recapBullet('destructive',
                'isDestructiveAction: true draws the row in iOS systemRed. '
                'Reserve for irreversible actions.'),
            _recapBullet('trailing icon',
                'optional IconData on the right edge; iOS strongly prefers '
                'every row to have one.'),
            _recapBullet('haptic',
                'enableHapticFeedback fires a heavy impact on open. iOS only.'),
            _recapBullet('builder factory',
                'CupertinoContextMenu.builder receives the open Animation '
                'and can morph the child as it lifts.'),
            _recapBullet('contract',
                'the context menu is a SECONDARY accelerator; never the only '
                'path to a command.'),
            _recapBullet('ancestor',
                'must live under CupertinoApp or MaterialApp; needs Overlay '
                'and Cupertino theme.'),
          ],
        ),
      ),
      const SizedBox(height: 14.0),
      Container(
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: _kAmber.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: _kAmber.withValues(alpha: 0.55), width: 0.8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('parting note', style: _labelStyle()),
            const SizedBox(height: 6.0),
            Text(
              'The CupertinoContextMenu is a ceremony, not a button. Use it '
              'where the user might reasonably pause, hold, and consider. '
              'Photographs. Files. Messages. Long-form text. Treat the gesture '
              'as a small, deliberate ritual: dim the room, lift the subject, '
              'unfold the choices, accept the user\'s answer with grace. The '
              'shape and motion are gifts of iOS; your job is only to pick '
              'a subject worth lifting.',
              style: _bodyStyle(),
            ),
          ],
        ),
      ),
    ],
  );
}

// =============================================================================
//                          PRINT SUMMARY HELPER
// =============================================================================

void _printSummary() {
  if (kDebugMode) {
    print('CupertinoContextMenu deep demo executing');
    print('  kOpenBorderRadius: ${CupertinoContextMenu.kOpenBorderRadius}');
    print('  animationOpensAt: ${CupertinoContextMenu.animationOpensAt}');
    print('  five recipes mounted in section 5');
    print('  five live instances mounted in section 7');
    print('  property matrix has eight variants');
    print('  pitfalls catalogued: nine');
    print('  glossary entries: fifteen');
  }
}

// =============================================================================
//                          build() ENTRY POINT
// =============================================================================

dynamic build(BuildContext context) {
  _printSummary();
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _kObsidian,
    ),
    home: CupertinoTheme(
      data: const CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: _kAmber,
        scaffoldBackgroundColor: _kObsidian,
        barBackgroundColor: _kCharcoal,
      ),
      child: CupertinoPageScaffold(
        backgroundColor: _kObsidian,
        navigationBar: const CupertinoNavigationBar(
          backgroundColor: _kCharcoal,
          middle: Text('CupertinoContextMenu',
              style: TextStyle(color: _kAmber)),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _titleBanner(),
                _dossierSection(),
                _anatomySection(),
                _closedSection(),
                _recipeGallerySection(),
                _actionMatrixSection(),
                _liveSection(),
                _comparisonSection(),
                _pitfallsSection(),
                _glossarySection(),
                _recapSection(),
                const SizedBox(height: 32.0),
                Center(
                  child: Text('— end of obsidian amber dossier —',
                      style: _captionStyle()),
                ),
                const SizedBox(height: 32.0),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

// ignore_for_file: avoid_print, unused_local_variable
import 'package:flutter/material.dart';

// =============================================================================
//                  DIALOG & BOTTOM SHEET — VISUAL DEEP DEMO
// -----------------------------------------------------------------------------
//  A hand-rolled, analyzer-clean walkthrough of Flutter's modal anatomy:
//      Dialog, AlertDialog, SimpleDialog, BottomSheet, ModalBottomSheet.
//
//  Style: plum / cream / charcoal palette.
//  No StatefulWidget, no async, no showDialog, no showModalBottomSheet —
//  the modals are rendered as STATIC widget trees inside Center+Material so
//  the anatomy can be inspected directly.
// =============================================================================

const Color _plum = Color(0xFF5C2A4E);
const Color _plumDeep = Color(0xFF3B1A33);
const Color _plumSoft = Color(0xFF8C5E80);
const Color _cream = Color(0xFFF7EFE5);
const Color _creamDeep = Color(0xFFE9DCC9);
const Color _charcoal = Color(0xFF2A2A2E);
const Color _slate = Color(0xFF4F4F58);
const Color _mist = Color(0xFFB7B0AE);
const Color _danger = Color(0xFFB8324A);
const Color _success = Color(0xFF2F7D5B);
const Color _info = Color(0xFF2D6494);
const Color _warning = Color(0xFFC97A1B);

const TextStyle _h1 = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w800,
  color: _cream,
  letterSpacing: -0.5,
);
const TextStyle _h2 = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w700,
  color: _plumDeep,
  letterSpacing: -0.3,
);
const TextStyle _h3 = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w700,
  color: _plum,
);
const TextStyle _body = TextStyle(
  fontSize: 14,
  color: _charcoal,
  height: 1.45,
);
const TextStyle _caption = TextStyle(
  fontSize: 12,
  color: _slate,
  fontStyle: FontStyle.italic,
);
const TextStyle _mono = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _charcoal,
);

// =============================================================================
//  build — entry point
// =============================================================================

dynamic build(BuildContext context) {
  return Container(
    color: _cream,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _section1HeroHeader(),
          _section2Concept(),
          _section3AlertDialogAnatomy(),
          _section4BottomSheetAnatomy(),
          _section5AlertDialogGallery(),
          _section6SimpleDialogGallery(),
          _section7DialogVsAlertVsSimple(),
          _section8BottomSheetModes(),
          _section9BottomSheetSizing(),
          _section10DragHandle(),
          _section11ModalBottomSheetShape(),
          _section12RealWorldRecipes(),
          _section13ComparisonTable(),
          _section14Glossary(),
          _section15Epilogue(),
        ],
      ),
    ),
  );
}

// =============================================================================
//  SHARED PRIMITIVES
// =============================================================================

Widget _sectionShell({
  required String number,
  required String title,
  required String subtitle,
  required Widget body,
  Color background = _cream,
}) {
  return Container(
    color: background,
    padding: const EdgeInsets.fromLTRB(28, 36, 28, 36),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: _plum,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                number,
                style: const TextStyle(
                  color: _cream,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(title, style: _h2)),
          ],
        ),
        const SizedBox(height: 6),
        Text(subtitle, style: _caption),
        const SizedBox(height: 22),
        body,
      ],
    ),
  );
}

Widget _scrim({required Widget child, double alpha = 0.45}) {
  return Stack(
    alignment: Alignment.center,
    children: <Widget>[
      Container(color: Color.fromRGBO(0, 0, 0, alpha)),
      child,
    ],
  );
}

Widget _stage({required Widget child, double height = 320}) {
  return Container(
    height: height,
    decoration: BoxDecoration(
      color: _plumDeep,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _plumSoft, width: 1.5),
    ),
    clipBehavior: Clip.antiAlias,
    child: _scrim(child: child),
  );
}

Widget _label(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(3),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 10.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
      ),
    ),
  );
}

Widget _bullet(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 6, right: 10),
          child: Icon(Icons.circle, size: 6, color: _plum),
        ),
        Expanded(child: Text(text, style: _body)),
      ],
    ),
  );
}

Widget _calloutCard({
  required IconData icon,
  required Color iconColor,
  required String title,
  required String body,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _creamDeep),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: iconColor, size: 26),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: _h3),
              const SizedBox(height: 4),
              Text(body, style: _body),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 1 — HERO HEADER
// =============================================================================

Widget _section1HeroHeader() {
  return Container(
    padding: const EdgeInsets.fromLTRB(28, 56, 28, 48),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_plumDeep, _plum, _plumSoft],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: _cream,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'DEEP DEMO',
                style: TextStyle(
                  color: _plumDeep,
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                  letterSpacing: 1.8,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.layers_outlined, color: _cream, size: 22),
          ],
        ),
        const SizedBox(height: 18),
        const Text('Dialog & Bottom Sheet', style: _h1),
        const SizedBox(height: 6),
        const Text(
          'Modal anatomy, sizing, and the rituals of the dismissable layer',
          style: TextStyle(
            fontSize: 15,
            color: _creamDeep,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 26),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: <Widget>[
            _heroPill(Icons.crop_square, 'Dialog'),
            _heroPill(Icons.warning_amber_rounded, 'AlertDialog'),
            _heroPill(Icons.list_alt, 'SimpleDialog'),
            _heroPill(Icons.vertical_align_bottom, 'BottomSheet'),
            _heroPill(Icons.swipe_up, 'ModalBottomSheet'),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _creamDeep.withValues(alpha: 0.3)),
          ),
          child: const Text(
            'A modal interrupts. A bottom sheet invites. A dialog confirms. '
            'They share scrim, focus trap, and route, but speak different '
            'tones to the user.',
            style: TextStyle(
              fontSize: 13.5,
              color: _cream,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _heroPill(IconData icon, String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Color.fromRGBO(255, 255, 255, 0.12),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: _creamDeep.withValues(alpha: 0.35)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, color: _cream, size: 16),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: _cream,
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 2 — CONCEPT
// =============================================================================

Widget _section2Concept() {
  return _sectionShell(
    number: '02',
    title: 'Modal vs non-modal',
    subtitle: 'The four shared ingredients of any interrupt layer',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Both Dialog and BottomSheet are members of the same family: '
          'temporary surfaces pushed above the current screen. They differ '
          'mainly in tone, size, and anchor — not in the underlying machinery.',
          style: _body,
        ),
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _conceptCard(
              icon: Icons.lock_outline,
              title: 'Modal',
              body:
                  'Blocks all interaction underneath. Has a scrim. Must be '
                  'dismissed (tap outside, system back, action button) before '
                  'work resumes.',
              tint: _plum,
            )),
            const SizedBox(width: 12),
            Expanded(child: _conceptCard(
              icon: Icons.lock_open_outlined,
              title: 'Non-modal',
              body:
                  'User can still interact with content underneath. '
                  'Persistent bottom sheets are the canonical example. No '
                  'scrim, no focus trap.',
              tint: _slate,
            )),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _conceptCard(
              icon: Icons.gradient,
              title: 'Scrim',
              body:
                  'Translucent veil between modal and page. Communicates '
                  '"the rest is inert" and absorbs taps that should dismiss '
                  'the modal.',
              tint: _info,
            )),
            const SizedBox(width: 12),
            Expanded(child: _conceptCard(
              icon: Icons.route,
              title: 'Route',
              body:
                  'showDialog and showModalBottomSheet push a fullscreen '
                  'PopupRoute. The modal lives inside the navigator stack; '
                  'system back pops it.',
              tint: _warning,
            )),
          ],
        ),
        const SizedBox(height: 20),
        _calloutCard(
          icon: Icons.lightbulb_outline,
          iconColor: _warning,
          title: 'Rule of thumb',
          body:
              'If the user must choose, use a Dialog. If the user might '
              'choose, use a BottomSheet. If the user must SEE, use a '
              'SnackBar. If the user must REPLY, use a Dialog with input.',
        ),
      ],
    ),
  );
}

Widget _conceptCard({
  required IconData icon,
  required String title,
  required String body,
  required Color tint,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _creamDeep),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: tint.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(icon, size: 18, color: tint),
            ),
            const SizedBox(width: 10),
            Text(title, style: _h3),
          ],
        ),
        const SizedBox(height: 10),
        Text(body, style: _body),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 3 — ANATOMY OF AN ALERTDIALOG
// =============================================================================

Widget _section3AlertDialogAnatomy() {
  return _sectionShell(
    number: '03',
    title: 'Anatomy of an AlertDialog',
    subtitle: 'Title, content, actions — wrapped in shape, elevation, scrim',
    background: _creamDeep,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _stage(
          height: 360,
          child: _anatomyAlertMock(),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            _label('A — title', _plum),
            _label('B — content', _info),
            _label('C — actions', _success),
            _label('D — scrim', _slate),
            _label('E — shape', _warning),
            _label('F — elevation', _danger),
          ],
        ),
        const SizedBox(height: 18),
        _bullet('A · title: usually one line, h6 weight. Short verb-noun.'),
        _bullet('B · content: free-form widget. Often a paragraph or a form.'),
        _bullet('C · actions: zero, one or two TextButtons. Right-aligned.'),
        _bullet('D · scrim: 40-50% black veil. Tap-outside-to-dismiss zone.'),
        _bullet('E · shape: RoundedRectangleBorder, default 28dp radius (M3).'),
        _bullet('F · elevation: 24dp default. Casts a soft shadow on scrim.'),
      ],
    ),
  );
}

Widget _anatomyAlertMock() {
  return Center(
    child: SizedBox(
      width: 320,
      child: Material(
        color: Colors.transparent,
        child: AlertDialog(
          backgroundColor: Colors.white,
          elevation: 24,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          icon: const Icon(Icons.info_outline, color: _info, size: 36),
          title: const Text('Anatomy', textAlign: TextAlign.center),
          titleTextStyle: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w700,
            color: _plumDeep,
          ),
          content: const Text(
            'Each labelled region maps to a property on AlertDialog. '
            'Hover the labels to recall the API surface.',
            textAlign: TextAlign.center,
          ),
          contentTextStyle: const TextStyle(
            fontSize: 13.5,
            color: _charcoal,
            height: 1.4,
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: <Widget>[
            TextButton(
              onPressed: () {},
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(backgroundColor: _plum),
              child: const Text('Got it'),
            ),
          ],
        ),
      ),
    ),
  );
}

// =============================================================================
//  SECTION 4 — ANATOMY OF A BOTTOMSHEET
// =============================================================================

Widget _section4BottomSheetAnatomy() {
  return _sectionShell(
    number: '04',
    title: 'Anatomy of a BottomSheet',
    subtitle: 'Drag handle, content, sheet edge — anchored to the bottom',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _stage(
          height: 380,
          child: _anatomyBottomSheetMock(),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            _label('A — drag handle', _plum),
            _label('B — content', _info),
            _label('C — sheet edge', _success),
            _label('D — scrim', _slate),
            _label('E — top radius', _warning),
            _label('F — safe area', _danger),
          ],
        ),
        const SizedBox(height: 18),
        _bullet('A · drag handle: 32x4 dp pill, 8dp top margin, theme outline.'),
        _bullet('B · content: any widget. Often ListView/Column of ListTiles.'),
        _bullet('C · sheet edge: 16dp top radius, 0dp bottom radius.'),
        _bullet('D · scrim: same as Dialog. Tap-outside dismisses (modal only).'),
        _bullet('E · top radius: customizable via shape: RoundedRectangleBorder.'),
        _bullet('F · safe area: SafeArea(top: false) keeps content above gestures.'),
      ],
    ),
  );
}

Widget _anatomyBottomSheetMock() {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 22),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: _mist,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 14),
          const Text('Sheet anatomy', style: _h3),
          const SizedBox(height: 6),
          const Text(
            'A bottom sheet always touches the bottom edge of the screen '
            'and extends upward as far as its content requires.',
            style: _body,
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              const Icon(Icons.share, color: _plum, size: 20),
              const SizedBox(width: 12),
              const Expanded(child: Text('Share', style: _body)),
              Icon(Icons.chevron_right, color: _mist),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              const Icon(Icons.copy, color: _plum, size: 20),
              const SizedBox(width: 12),
              const Expanded(child: Text('Copy link', style: _body)),
              Icon(Icons.chevron_right, color: _mist),
            ],
          ),
        ],
      ),
    ),
  );
}

// =============================================================================
//  SECTION 5 — ALERTDIALOG GALLERY
// =============================================================================

Widget _section5AlertDialogGallery() {
  return _sectionShell(
    number: '05',
    title: 'AlertDialog gallery',
    subtitle: 'Five tones for five everyday questions',
    background: _creamDeep,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _galleryRow(<Widget>[
          _galleryDialog(_alertConfirm(), 'Confirm'),
          _galleryDialog(_alertDestructive(), 'Destructive'),
        ]),
        const SizedBox(height: 14),
        _galleryRow(<Widget>[
          _galleryDialog(_alertInfo(), 'Info'),
          _galleryDialog(_alertError(), 'Error'),
        ]),
        const SizedBox(height: 14),
        _galleryRow(<Widget>[
          _galleryDialog(_alertSuccess(), 'Success'),
          _galleryDialog(_alertNeutral(), 'Neutral'),
        ]),
      ],
    ),
  );
}

Widget _galleryRow(List<Widget> kids) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(child: kids[0]),
      const SizedBox(width: 12),
      Expanded(child: kids[1]),
    ],
  );
}

Widget _galleryDialog(Widget dialog, String tag) {
  return Container(
    height: 280,
    decoration: BoxDecoration(
      color: _plumDeep,
      borderRadius: BorderRadius.circular(10),
    ),
    clipBehavior: Clip.antiAlias,
    child: Stack(
      children: <Widget>[
        Container(color: Color.fromRGBO(0, 0, 0, 0.45)),
        Center(child: dialog),
        Positioned(
          left: 8,
          top: 8,
          child: _label(tag, _plum),
        ),
      ],
    ),
  );
}

Widget _alertConfirm() {
  return SizedBox(
    width: 240,
    child: Material(
      color: Colors.transparent,
      child: AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Save changes?'),
        content: const Text('Your draft will be kept on this device.'),
        actions: <Widget>[
          TextButton(onPressed: () {}, child: const Text('Discard')),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(backgroundColor: _plum),
            child: const Text('Save'),
          ),
        ],
      ),
    ),
  );
}

Widget _alertDestructive() {
  return SizedBox(
    width: 240,
    child: Material(
      color: Colors.transparent,
      child: AlertDialog(
        backgroundColor: Colors.white,
        icon: const Icon(Icons.delete_outline, color: _danger, size: 30),
        title: const Text('Delete file?', textAlign: TextAlign.center),
        content: const Text(
          'This action cannot be undone.',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton(onPressed: () {}, child: const Text('Cancel')),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(backgroundColor: _danger),
            child: const Text('Delete'),
          ),
        ],
      ),
    ),
  );
}

Widget _alertInfo() {
  return SizedBox(
    width: 240,
    child: Material(
      color: Colors.transparent,
      child: AlertDialog(
        backgroundColor: Colors.white,
        icon: const Icon(Icons.info_outline, color: _info, size: 30),
        title: const Text('New version', textAlign: TextAlign.center),
        content: const Text(
          'Version 2.3.0 is available. Update now?',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton(onPressed: () {}, child: const Text('Later')),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(backgroundColor: _info),
            child: const Text('Update'),
          ),
        ],
      ),
    ),
  );
}

Widget _alertError() {
  return SizedBox(
    width: 240,
    child: Material(
      color: Colors.transparent,
      child: AlertDialog(
        backgroundColor: Colors.white,
        icon: const Icon(Icons.report, color: _danger, size: 30),
        title: const Text('Sync failed', textAlign: TextAlign.center),
        content: const Text(
          'We could not reach the server. Check your connection.',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton(onPressed: () {}, child: const Text('Dismiss')),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(backgroundColor: _danger),
            child: const Text('Retry'),
          ),
        ],
      ),
    ),
  );
}

Widget _alertSuccess() {
  return SizedBox(
    width: 240,
    child: Material(
      color: Colors.transparent,
      child: AlertDialog(
        backgroundColor: Colors.white,
        icon: const Icon(Icons.check_circle, color: _success, size: 30),
        title: const Text('All set!', textAlign: TextAlign.center),
        content: const Text(
          'Your profile has been updated.',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(backgroundColor: _success),
            child: const Text('OK'),
          ),
        ],
      ),
    ),
  );
}

Widget _alertNeutral() {
  return SizedBox(
    width: 240,
    child: Material(
      color: Colors.transparent,
      child: AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Are you sure?'),
        content: const Text('Continuing will log you out.'),
        actions: <Widget>[
          TextButton(onPressed: () {}, child: const Text('No')),
          TextButton(onPressed: () {}, child: const Text('Yes')),
        ],
      ),
    ),
  );
}

// =============================================================================
//  SECTION 6 — SIMPLEDIALOG GALLERY
// =============================================================================

Widget _section6SimpleDialogGallery() {
  return _sectionShell(
    number: '06',
    title: 'SimpleDialog gallery',
    subtitle: 'A list-of-choices dialog with no primary action',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _galleryRow(<Widget>[
          _galleryDialog(_simpleLanguage(), 'Language'),
          _galleryDialog(_simpleAccount(), 'Account'),
        ]),
        const SizedBox(height: 14),
        _galleryRow(<Widget>[
          _galleryDialog(_simpleTheme(), 'Theme'),
          _galleryDialog(_simpleSort(), 'Sort by'),
        ]),
        const SizedBox(height: 16),
        _calloutCard(
          icon: Icons.list_alt,
          iconColor: _info,
          title: 'When to use SimpleDialog',
          body:
              'Use when the user must pick one item from a short list and '
              'no additional action is needed afterwards. Each tap '
              'effectively confirms the choice.',
        ),
      ],
    ),
  );
}

Widget _simpleLanguage() {
  return SizedBox(
    width: 240,
    child: Material(
      color: Colors.transparent,
      child: SimpleDialog(
        backgroundColor: Colors.white,
        title: const Text('Language'),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () {},
            child: const Text('English'),
          ),
          SimpleDialogOption(
            onPressed: () {},
            child: const Text('Français'),
          ),
          SimpleDialogOption(
            onPressed: () {},
            child: const Text('Deutsch'),
          ),
          SimpleDialogOption(
            onPressed: () {},
            child: const Text('Español'),
          ),
        ],
      ),
    ),
  );
}

Widget _simpleAccount() {
  return SizedBox(
    width: 240,
    child: Material(
      color: Colors.transparent,
      child: SimpleDialog(
        backgroundColor: Colors.white,
        title: const Text('Choose account'),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () {},
            child: Row(children: const <Widget>[
              CircleAvatar(
                radius: 12,
                backgroundColor: _plum,
                child: Text('A', style: TextStyle(color: _cream, fontSize: 11)),
              ),
              SizedBox(width: 10),
              Text('alice@example'),
            ]),
          ),
          SimpleDialogOption(
            onPressed: () {},
            child: Row(children: const <Widget>[
              CircleAvatar(
                radius: 12,
                backgroundColor: _info,
                child: Text('B', style: TextStyle(color: _cream, fontSize: 11)),
              ),
              SizedBox(width: 10),
              Text('bob@example'),
            ]),
          ),
          SimpleDialogOption(
            onPressed: () {},
            child: Row(children: const <Widget>[
              Icon(Icons.add, color: _slate, size: 22),
              SizedBox(width: 10),
              Text('Add account…'),
            ]),
          ),
        ],
      ),
    ),
  );
}

Widget _simpleTheme() {
  return SizedBox(
    width: 240,
    child: Material(
      color: Colors.transparent,
      child: SimpleDialog(
        backgroundColor: Colors.white,
        title: const Text('Theme'),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () {},
            child: Row(children: const <Widget>[
              Icon(Icons.brightness_5, color: _warning),
              SizedBox(width: 10),
              Text('Light'),
            ]),
          ),
          SimpleDialogOption(
            onPressed: () {},
            child: Row(children: const <Widget>[
              Icon(Icons.brightness_2, color: _info),
              SizedBox(width: 10),
              Text('Dark'),
            ]),
          ),
          SimpleDialogOption(
            onPressed: () {},
            child: Row(children: const <Widget>[
              Icon(Icons.brightness_auto, color: _slate),
              SizedBox(width: 10),
              Text('System'),
            ]),
          ),
        ],
      ),
    ),
  );
}

Widget _simpleSort() {
  return SizedBox(
    width: 240,
    child: Material(
      color: Colors.transparent,
      child: SimpleDialog(
        backgroundColor: Colors.white,
        title: const Text('Sort by'),
        children: <Widget>[
          SimpleDialogOption(onPressed: () {}, child: const Text('Name (A → Z)')),
          SimpleDialogOption(onPressed: () {}, child: const Text('Date (newest)')),
          SimpleDialogOption(onPressed: () {}, child: const Text('Size')),
          SimpleDialogOption(onPressed: () {}, child: const Text('Type')),
        ],
      ),
    ),
  );
}

// =============================================================================
//  SECTION 7 — DIALOG vs ALERT vs SIMPLE
// =============================================================================

Widget _section7DialogVsAlertVsSimple() {
  return _sectionShell(
    number: '07',
    title: 'Dialog vs AlertDialog vs SimpleDialog',
    subtitle: 'One base, two opinionated subclasses',
    background: _creamDeep,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _compareCard(
              title: 'Dialog',
              icon: Icons.crop_square,
              tint: _slate,
              points: const <String>[
                'Base class — arbitrary child',
                'You own the layout',
                'No assumptions about content',
                'Use when nothing else fits',
              ],
            )),
            const SizedBox(width: 10),
            Expanded(child: _compareCard(
              title: 'AlertDialog',
              icon: Icons.warning_amber_rounded,
              tint: _danger,
              points: const <String>[
                'Title + content + actions',
                'Right-aligned buttons',
                'Optional icon header',
                'Use for confirmations',
              ],
            )),
            const SizedBox(width: 10),
            Expanded(child: _compareCard(
              title: 'SimpleDialog',
              icon: Icons.list_alt,
              tint: _info,
              points: const <String>[
                'Title + list of options',
                'Each tap = confirm',
                'No primary button',
                'Use for choose-one lists',
              ],
            )),
          ],
        ),
        const SizedBox(height: 18),
        _calloutCard(
          icon: Icons.tips_and_updates_outlined,
          iconColor: _warning,
          title: 'The decision tree',
          body:
              'Need yes/no? AlertDialog. Need pick-one-from-list? '
              'SimpleDialog. Need a custom form? Dialog with a child of your '
              'choosing.',
        ),
      ],
    ),
  );
}

Widget _compareCard({
  required String title,
  required IconData icon,
  required Color tint,
  required List<String> points,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _creamDeep),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: tint.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, size: 22, color: tint),
        ),
        const SizedBox(height: 10),
        Text(title, style: _h3),
        const SizedBox(height: 8),
        for (final String p in points)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Icon(Icons.check, size: 14, color: _plum),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(p, style: const TextStyle(fontSize: 12.5)),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 8 — BOTTOMSHEET MODES
// =============================================================================

Widget _section8BottomSheetModes() {
  return _sectionShell(
    number: '08',
    title: 'BottomSheet modes',
    subtitle: 'Modal (route) vs persistent (in-tree)',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _modeCard(
              title: 'Modal',
              caption:
                  'Pushed via showModalBottomSheet — fullscreen route, '
                  'scrim, focus trap, tap-outside dismisses.',
              tint: _plum,
              stage: _modalSheetMock(),
            )),
            const SizedBox(width: 12),
            Expanded(child: _modeCard(
              title: 'Persistent',
              caption:
                  'Hosted by Scaffold.bottomSheet — no scrim, page stays '
                  'interactive. Lives between content and FAB.',
              tint: _info,
              stage: _persistentSheetMock(),
            )),
          ],
        ),
        const SizedBox(height: 14),
        _calloutCard(
          icon: Icons.swipe_up,
          iconColor: _plum,
          title: 'Drag behaviour',
          body:
              'Modal sheets dismiss on downward fling. Persistent sheets '
              'do not dismiss themselves — you control them with the '
              'PersistentBottomSheetController.',
        ),
      ],
    ),
  );
}

Widget _modeCard({
  required String title,
  required String caption,
  required Color tint,
  required Widget stage,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        children: <Widget>[
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: tint,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(title, style: _h3),
        ],
      ),
      const SizedBox(height: 6),
      Text(caption, style: _body),
      const SizedBox(height: 10),
      stage,
    ],
  );
}

Widget _modalSheetMock() {
  return Container(
    height: 220,
    decoration: BoxDecoration(
      color: _plumDeep,
      borderRadius: BorderRadius.circular(10),
    ),
    clipBehavior: Clip.antiAlias,
    child: Stack(
      children: <Widget>[
        Container(color: Color.fromRGBO(0, 0, 0, 0.45)),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Container(
                    width: 32,
                    height: 4,
                    decoration: BoxDecoration(
                      color: _mist,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Modal sheet', style: _h3),
                const SizedBox(height: 4),
                const Text('Scrim above, content here.', style: _body),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _persistentSheetMock() {
  return Container(
    height: 220,
    decoration: BoxDecoration(
      color: _creamDeep,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _mist),
    ),
    clipBehavior: Clip.antiAlias,
    child: Stack(
      children: <Widget>[
        Positioned(
          top: 16,
          left: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _mist),
            ),
            child: const Text(
              'Page content remains tappable',
              style: TextStyle(fontSize: 12, color: _slate),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              border: Border.all(color: _mist),
            ),
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text('Persistent sheet', style: _h3),
                const SizedBox(height: 4),
                const Text('No scrim, no route.', style: _caption),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 9 — BOTTOMSHEET SIZING
// =============================================================================

Widget _section9BottomSheetSizing() {
  return _sectionShell(
    number: '09',
    title: 'BottomSheet sizing',
    subtitle: 'fitContent vs expanded · isScrollControlled true vs false',
    background: _creamDeep,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _sizingCard(
              title: 'fitContent',
              caption: 'Height = intrinsic content height.',
              stage: _sizingStage(height: 110),
            )),
            const SizedBox(width: 12),
            Expanded(child: _sizingCard(
              title: 'expanded',
              caption: 'Fills available space (up to ~50%).',
              stage: _sizingStage(height: 180),
            )),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _sizingCard(
              title: 'isScrollControlled: false',
              caption: 'Maximum height capped at ~50% of screen.',
              stage: _sizingStage(height: 130),
            )),
            const SizedBox(width: 12),
            Expanded(child: _sizingCard(
              title: 'isScrollControlled: true',
              caption: 'Can grow up to full screen height.',
              stage: _sizingStage(height: 220),
            )),
          ],
        ),
        const SizedBox(height: 16),
        _calloutCard(
          icon: Icons.straighten,
          iconColor: _info,
          title: 'When to set isScrollControlled',
          body:
              'Set isScrollControlled: true whenever your sheet contains a '
              'scrollable, a keyboard-aware form, or content taller than '
              'half the screen. Without it, content is clipped.',
        ),
      ],
    ),
  );
}

Widget _sizingCard({
  required String title,
  required String caption,
  required Widget stage,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _creamDeep),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(title, style: _h3),
        const SizedBox(height: 4),
        Text(caption, style: _caption),
        const SizedBox(height: 10),
        stage,
      ],
    ),
  );
}

Widget _sizingStage({required double height}) {
  return Container(
    height: 240,
    decoration: BoxDecoration(
      color: _plumDeep,
      borderRadius: BorderRadius.circular(8),
    ),
    clipBehavior: Clip.antiAlias,
    child: Stack(
      children: <Widget>[
        Container(color: Color.fromRGBO(0, 0, 0, 0.35)),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: height,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Container(
                    width: 28,
                    height: 3,
                    decoration: BoxDecoration(
                      color: _mist,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${height.toInt()} dp',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: _slate,
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
//  SECTION 10 — DRAG HANDLE
// =============================================================================

Widget _section10DragHandle() {
  return _sectionShell(
    number: '10',
    title: 'Drag handle',
    subtitle: 'showDragHandle true vs false — when to expose the affordance',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _dragHandleCard(
              title: 'showDragHandle: true',
              tint: _success,
              stage: _dragHandleStage(showHandle: true),
            )),
            const SizedBox(width: 12),
            Expanded(child: _dragHandleCard(
              title: 'showDragHandle: false',
              tint: _danger,
              stage: _dragHandleStage(showHandle: false),
            )),
          ],
        ),
        const SizedBox(height: 14),
        _bullet('Expose the handle when the sheet is draggable.'),
        _bullet('Hide the handle for confirmation-style sheets.'),
        _bullet('Handle is 32×4 dp, theme outline color, 8 dp top inset.'),
        _bullet('Tap on handle has no special meaning — only drag matters.'),
      ],
    ),
  );
}

Widget _dragHandleCard({
  required String title,
  required Color tint,
  required Widget stage,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _creamDeep),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: tint,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(title, style: _h3),
          ],
        ),
        const SizedBox(height: 10),
        stage,
      ],
    ),
  );
}

Widget _dragHandleStage({required bool showHandle}) {
  return Container(
    height: 200,
    decoration: BoxDecoration(
      color: _plumDeep,
      borderRadius: BorderRadius.circular(8),
    ),
    clipBehavior: Clip.antiAlias,
    child: Stack(
      children: <Widget>[
        Container(color: Color.fromRGBO(0, 0, 0, 0.4)),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 130,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
            ),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (showHandle)
                  Center(
                    child: Container(
                      width: 32,
                      height: 4,
                      decoration: BoxDecoration(
                        color: _mist,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                if (showHandle) const SizedBox(height: 10),
                const Text('Title', style: _h3),
                const SizedBox(height: 6),
                const Text(
                  'Drag this surface to dismiss.',
                  style: _body,
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
//  SECTION 11 — MODALBOTTOMSHEET SHAPE
// =============================================================================

Widget _section11ModalBottomSheetShape() {
  return _sectionShell(
    number: '11',
    title: 'ModalBottomSheet shape',
    subtitle: 'Rounded top · square · custom border',
    background: _creamDeep,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _shapeCard(
              title: 'Rounded',
              code: 'Radius.circular(16)',
              radius: const BorderRadius.vertical(top: Radius.circular(16)),
            )),
            const SizedBox(width: 10),
            Expanded(child: _shapeCard(
              title: 'Pill-top',
              code: 'Radius.circular(28)',
              radius: const BorderRadius.vertical(top: Radius.circular(28)),
            )),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _shapeCard(
              title: 'Square',
              code: 'Radius.zero',
              radius: BorderRadius.zero,
            )),
            const SizedBox(width: 10),
            Expanded(child: _shapeCard(
              title: 'Asymmetric',
              code: 'L: 24, R: 4',
              radius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(4),
              ),
            )),
          ],
        ),
      ],
    ),
  );
}

Widget _shapeCard({
  required String title,
  required String code,
  required BorderRadius radius,
}) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _creamDeep),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(title, style: _h3),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: _creamDeep,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(code, style: _mono),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 130,
          decoration: BoxDecoration(
            color: _plumDeep,
            borderRadius: BorderRadius.circular(6),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: <Widget>[
              Container(color: Color.fromRGBO(0, 0, 0, 0.35)),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: radius,
                  ),
                  alignment: Alignment.center,
                  child: const Text('Sheet', style: _caption),
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
//  SECTION 12 — REAL-WORLD RECIPES
// =============================================================================

Widget _section12RealWorldRecipes() {
  return _sectionShell(
    number: '12',
    title: 'Real-world recipes',
    subtitle: 'Three patterns you will use every week',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _recipe(
          title: 'Confirm delete',
          tag: 'Dialog',
          tint: _danger,
          stage: _stage(child: _recipeConfirmDelete()),
          notes: const <String>[
            'Destructive action — red primary button',
            'Cancel button on the left, Delete on the right',
            'Include the item name so users do not second-guess',
          ],
        ),
        const SizedBox(height: 16),
        _recipe(
          title: 'Share menu',
          tag: 'BottomSheet',
          tint: _info,
          stage: _stage(child: _recipeShare()),
          notes: const <String>[
            'Grid of share targets — apps + system',
            'Drag handle visible',
            'No primary action — tap = share',
          ],
        ),
        const SizedBox(height: 16),
        _recipe(
          title: 'Action menu',
          tag: 'BottomSheet',
          tint: _plum,
          stage: _stage(child: _recipeActionMenu()),
          notes: const <String>[
            'List of icon + label actions',
            'Destructive action coloured danger',
            'Optional divider before destructive group',
          ],
        ),
      ],
    ),
  );
}

Widget _recipe({
  required String title,
  required String tag,
  required Color tint,
  required Widget stage,
  required List<String> notes,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _creamDeep),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: tint,
                borderRadius: BorderRadius.circular(3),
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
            const SizedBox(width: 10),
            Text(title, style: _h3),
          ],
        ),
        const SizedBox(height: 12),
        stage,
        const SizedBox(height: 10),
        for (final String n in notes) _bullet(n),
      ],
    ),
  );
}

Widget _recipeConfirmDelete() {
  return Center(
    child: SizedBox(
      width: 300,
      child: Material(
        color: Colors.transparent,
        child: AlertDialog(
          backgroundColor: Colors.white,
          icon: const Icon(Icons.delete_outline, color: _danger, size: 32),
          title: const Text(
            'Delete "Q3 plan.pdf"?',
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'The file will be removed from this device and all synced '
            'locations.',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(onPressed: () {}, child: const Text('Cancel')),
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(backgroundColor: _danger),
              child: const Text('Delete'),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _recipeShare() {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 22),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: _mist,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text('Share via', style: _h3),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _shareTarget(Icons.message, 'Messages'),
              _shareTarget(Icons.mail_outline, 'Mail'),
              _shareTarget(Icons.copy, 'Copy'),
              _shareTarget(Icons.cloud_upload, 'Drive'),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _shareTarget(IconData icon, String label) {
  return Column(
    children: <Widget>[
      Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: _creamDeep,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: _plum, size: 22),
      ),
      const SizedBox(height: 6),
      Text(label, style: _caption),
    ],
  );
}

Widget _recipeActionMenu() {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: _mist,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 8),
          _actionRow(Icons.edit_outlined, 'Edit', _plum),
          _actionRow(Icons.share, 'Share', _plum),
          _actionRow(Icons.copy, 'Duplicate', _plum),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            height: 1,
            color: _creamDeep,
          ),
          _actionRow(Icons.delete_outline, 'Delete', _danger),
        ],
      ),
    ),
  );
}

Widget _actionRow(IconData icon, String label, Color tint) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    child: Row(
      children: <Widget>[
        Icon(icon, color: tint, size: 20),
        const SizedBox(width: 14),
        Text(label, style: TextStyle(fontSize: 14, color: tint)),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 13 — COMPARISON TABLE
// =============================================================================

Widget _section13ComparisonTable() {
  return _sectionShell(
    number: '13',
    title: 'Comparison table',
    subtitle: 'Dialog · BottomSheet · SnackBar · PopupMenu · Drawer',
    background: _creamDeep,
    body: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _creamDeep),
      ),
      child: Column(
        children: <Widget>[
          _tableHeaderRow(),
          _tableRow('Dialog', 'Center', 'Yes', 'No', 'Tap-out / button'),
          _tableRow('BottomSheet', 'Bottom', 'Modal yes', 'Yes', 'Drag / scrim'),
          _tableRow('SnackBar', 'Bottom', 'No', 'No', 'Auto / swipe'),
          _tableRow('PopupMenu', 'Anchored', 'No', 'No', 'Tap-out'),
          _tableRow('Drawer', 'Side', 'Yes', 'Yes', 'Tap-out / drag'),
        ],
      ),
    ),
  );
}

Widget _tableHeaderRow() {
  return Container(
    decoration: BoxDecoration(
      color: _plum,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Row(
      children: const <Widget>[
        Expanded(flex: 2, child: Text('Surface', style: _tableHeaderStyle)),
        Expanded(flex: 2, child: Text('Anchor', style: _tableHeaderStyle)),
        Expanded(flex: 2, child: Text('Scrim', style: _tableHeaderStyle)),
        Expanded(flex: 2, child: Text('Draggable', style: _tableHeaderStyle)),
        Expanded(flex: 3, child: Text('Dismiss', style: _tableHeaderStyle)),
      ],
    ),
  );
}

const TextStyle _tableHeaderStyle = TextStyle(
  color: _cream,
  fontWeight: FontWeight.w700,
  fontSize: 12,
  letterSpacing: 0.4,
);

Widget _tableRow(
  String surface,
  String anchor,
  String scrim,
  String drag,
  String dismiss,
) {
  return Container(
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: _creamDeep)),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            surface,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: _plumDeep,
              fontSize: 13,
            ),
          ),
        ),
        Expanded(flex: 2, child: Text(anchor, style: _body)),
        Expanded(flex: 2, child: Text(scrim, style: _body)),
        Expanded(flex: 2, child: Text(drag, style: _body)),
        Expanded(flex: 3, child: Text(dismiss, style: _body)),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 14 — GLOSSARY
// =============================================================================

Widget _section14Glossary() {
  return _sectionShell(
    number: '14',
    title: 'Glossary',
    subtitle: 'Fourteen terms you should never confuse again',
    body: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _creamDeep),
      ),
      child: Column(
        children: <Widget>[
          _glossaryRow(
            'Scrim',
            'Translucent veil between modal and page.',
          ),
          _glossaryRow(
            'Modal',
            'Blocks interaction underneath. Must be dismissed first.',
          ),
          _glossaryRow(
            'Persistent',
            'Stays in tree, page underneath remains interactive.',
          ),
          _glossaryRow(
            'PopupRoute',
            'Route subclass used by showDialog & showModalBottomSheet.',
          ),
          _glossaryRow(
            'Barrier',
            'Tappable region behind a modal that dismisses it.',
          ),
          _glossaryRow(
            'Drag handle',
            '32×4 dp pill that signals "drag to dismiss".',
          ),
          _glossaryRow(
            'isScrollControlled',
            'Allows the sheet to grow past 50% screen height.',
          ),
          _glossaryRow(
            'enableDrag',
            'Whether the user can dismiss the sheet by dragging.',
          ),
          _glossaryRow(
            'showDragHandle',
            'Whether the drag handle is visible (defaults to theme).',
          ),
          _glossaryRow(
            'useSafeArea',
            'Avoids notches and gesture insets on showModalBottomSheet.',
          ),
          _glossaryRow(
            'AlertDialog',
            'Title + content + actions row, right-aligned buttons.',
          ),
          _glossaryRow(
            'SimpleDialog',
            'Title + list of SimpleDialogOption items.',
          ),
          _glossaryRow(
            'Dialog',
            'Bare base — host any child you want.',
          ),
          _glossaryRow(
            'surfaceTintColor',
            'M3 elevation tint applied on top of backgroundColor.',
          ),
        ],
      ),
    ),
  );
}

Widget _glossaryRow(String term, String definition) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: _creamDeep)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 140,
          child: Text(
            term,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: _plum,
              fontSize: 13,
            ),
          ),
        ),
        Expanded(child: Text(definition, style: _body)),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 15 — EPILOGUE
// =============================================================================

Widget _section15Epilogue() {
  return Container(
    padding: const EdgeInsets.fromLTRB(28, 36, 28, 56),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_plum, _plumDeep],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Row(
          children: <Widget>[
            Icon(Icons.flag_outlined, color: _cream, size: 22),
            SizedBox(width: 10),
            Text(
              'Epilogue',
              style: TextStyle(
                color: _cream,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Text(
          'Dialogs and bottom sheets are the punctuation marks of a UI: '
          'tiny interruptions that change the meaning of the surrounding '
          'sentence. Use them sparingly, dress them consistently, and let '
          'their tone match the gravity of the question.',
          style: TextStyle(
            color: _cream,
            fontSize: 14,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.22),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _creamDeep.withValues(alpha: 0.3)),
          ),
          child: const Text(
            'Closing rule: never block the user with a dialog you would not '
            'block your past-self with. If the action can be undone, prefer '
            'a SnackBar with Undo. Modals are expensive — spend them well.',
            style: TextStyle(
              color: _cream,
              fontSize: 13,
              height: 1.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: <Widget>[
            const Icon(Icons.check_circle, color: _cream, size: 18),
            const SizedBox(width: 8),
            const Text(
              'End of deep demo',
              style: TextStyle(
                color: _cream,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

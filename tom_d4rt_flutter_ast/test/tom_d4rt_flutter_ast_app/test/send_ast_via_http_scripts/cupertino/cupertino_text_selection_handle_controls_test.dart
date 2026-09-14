// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// Hand-written demo for CupertinoTextSelectionHandleControls.
// Wires real CupertinoTextField widgets configured with the touch-style
// iOS handle controls so the harness reader can interact with the live
// selection bubble + draggable handles.
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

// ============================================================================
// COLOUR PALETTES — each scenario gets its own scheme so the harness reads
// like a flip-through reference. Keep them as Color(0xFF...) constants so
// nothing pulls in material.dart.
// ============================================================================

const Color _palette1Header = Color(0xFF1F4E8A);
const Color _palette1Body = Color(0xFFE7F0FA);
const Color _palette1Border = Color(0xFFB7CCE5);
const Color _palette1Caption = Color(0xFF34527A);

const Color _palette2Header = Color(0xFF2A6F4D);
const Color _palette2Body = Color(0xFFE5F4EC);
const Color _palette2Border = Color(0xFFB5DCC4);
const Color _palette2Caption = Color(0xFF335E48);

const Color _palette3Header = Color(0xFF8A2A55);
const Color _palette3Body = Color(0xFFFCE6EF);
const Color _palette3Border = Color(0xFFE3B6CB);
const Color _palette3Caption = Color(0xFF6E2444);

const Color _palette4Header = Color(0xFF6F4F1F);
const Color _palette4Body = Color(0xFFFAF1DD);
const Color _palette4Border = Color(0xFFE0CCA0);
const Color _palette4Caption = Color(0xFF5C4220);

const Color _palette5Header = Color(0xFF3E3A8A);
const Color _palette5Body = Color(0xFFEDECF7);
const Color _palette5Border = Color(0xFFC0BDE2);
const Color _palette5Caption = Color(0xFF34326A);

const Color _palette6Header = Color(0xFF2C5F6F);
const Color _palette6Body = Color(0xFFE3F1F4);
const Color _palette6Border = Color(0xFFB6D6DC);
const Color _palette6Caption = Color(0xFF254E5B);

const Color _palette7Header = Color(0xFF6B2C8A);
const Color _palette7Body = Color(0xFFF1E5F8);
const Color _palette7Border = Color(0xFFD1B6E2);
const Color _palette7Caption = Color(0xFF55236E);

// ----------------------------------------------------------------------------
// Pre-populated controllers — keeping them at top-level so the demo always
// boots with prose already in place. Real selection drag handles need real
// text, otherwise the bubble menu has nothing to grab.
// ----------------------------------------------------------------------------

final TextEditingController _ctrlSingleLine = TextEditingController(
  text: 'Tap and hold to summon the round handles.',
);

final TextEditingController _ctrlMultiline = TextEditingController(
  text:
      'CupertinoTextSelectionHandleControls is the touch-friendly variant of '
      'the iOS selection controls. When you long-press inside this paragraph, '
      'two round handles appear and you can drag them across line breaks. The '
      'handles snap to character boundaries — try pulling the left one between '
      'two short words, then the right one to the next line.\n\n'
      'Notice how the handle anchors sit just below the baseline so they do '
      'not occlude the glyph being targeted. The bubble menu floats above '
      'the selection until you scroll, at which point Cupertino re-positions '
      'it to stay onscreen.',
);

final TextEditingController _ctrlPassword = TextEditingController(
  text: 'hunter2-secret-passphrase',
);

final TextEditingController _ctrlPasswordContrast = TextEditingController(
  text: 'plain text for contrast — cut/copy work here',
);

final TextEditingController _ctrlReadOnly = TextEditingController(
  text:
      'This field is read-only. Selection handles still appear and copy is '
      'available, but the bubble menu omits Paste because the field cannot '
      'accept incoming clipboard content.',
);

final TextEditingController _ctrlListSection = TextEditingController(
  text: 'Edit me from inside the grouped list',
);

final TextEditingController _ctrlListSectionNotes = TextEditingController(
  text:
      'Selection works exactly the same when the field is hosted inside a '
      'CupertinoListSection.insetGrouped container.',
);

final TextEditingController _ctrlSideBySideTouch = TextEditingController(
  text: 'Touch handles — round drag points',
);

final TextEditingController _ctrlSideBySideDesktop = TextEditingController(
  text: 'Desktop — I-beam selection only',
);

final TextEditingController _ctrlAnatomyLive = TextEditingController(
  text:
      'Live field that the anatomy diagram describes. Try a long-press to '
      'see buildToolbar render the bubble menu and buildHandle render the '
      'two round drag handles.',
);

// ----------------------------------------------------------------------------
// Focus nodes — scenarios that want to coexist need their own focus so the
// caret/selection state of one does not steal from another.
// ----------------------------------------------------------------------------

final FocusNode _focusSingle = FocusNode(debugLabel: 'singleLine');
final FocusNode _focusMulti = FocusNode(debugLabel: 'multiline');
final FocusNode _focusPassword = FocusNode(debugLabel: 'password');
final FocusNode _focusPasswordContrast = FocusNode(
  debugLabel: 'passwordContrast',
);
final FocusNode _focusReadOnly = FocusNode(debugLabel: 'readOnly');
final FocusNode _focusListSection = FocusNode(debugLabel: 'listSection');
final FocusNode _focusListSectionNotes = FocusNode(
  debugLabel: 'listSectionNotes',
);
final FocusNode _focusTouch = FocusNode(debugLabel: 'touch');
final FocusNode _focusDesktop = FocusNode(debugLabel: 'desktop');
final FocusNode _focusAnatomy = FocusNode(debugLabel: 'anatomy');

// ----------------------------------------------------------------------------
// Tiny helpers for the section chrome. Keeping them as plain widget builders
// (not StatelessWidgets) so the harness file remains a single flat function.
// ----------------------------------------------------------------------------

Widget _sectionTitle(int index, String title, Color headerColor) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 32.0, bottom: 12.0),
    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    decoration: BoxDecoration(
      color: headerColor,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 32.0,
          height: 32.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '$index',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: headerColor,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _sectionBody({
  required Color body,
  required Color border,
  required List<Widget> children,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: body,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: border, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    ),
  );
}

Widget _whatThisShows(String text, Color captionColor) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 14.0,
        height: 1.35,
        color: captionColor,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget _interactionTip(String tip, Color captionColor) {
  return Container(
    margin: const EdgeInsets.only(top: 12.0),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: captionColor, width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(CupertinoIcons.hand_draw, size: 16.0, color: captionColor),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            tip,
            style: TextStyle(
              fontSize: 13.0,
              fontStyle: FontStyle.italic,
              color: captionColor,
              height: 1.3,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _fieldLabel(String label, Color captionColor) {
  return Padding(
    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.4,
        color: captionColor,
      ),
    ),
  );
}

Widget _anatomyCard({
  required String hookName,
  required String description,
  required Color border,
  required Color captionColor,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: border, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                color: captionColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                hookName,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Menlo',
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          description,
          style: const TextStyle(
            fontSize: 13.0,
            height: 1.4,
            color: Color(0xFF1C1C1C),
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Clipboard seed row — primes the system clipboard with a sample so paste in
// the demo fields is meaningful. Also exercises HapticFeedback so the demo
// uses a couple of services.dart entry points rather than only widget API.
// ----------------------------------------------------------------------------

class _ClipboardSeedRow extends StatelessWidget {
  const _ClipboardSeedRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CupertinoButton.filled(
          padding: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 8.0,
          ),
          onPressed: () async {
            // Real services.dart usage — Clipboard + HapticFeedback are
            // only reachable via package:flutter/services.dart.
            await Clipboard.setData(
              const ClipboardData(
                text:
                    'Pasted from CupertinoTextSelectionHandleControls demo.',
              ),
            );
            await HapticFeedback.selectionClick();
            print('  clipboard seeded for paste demo');
          },
          child: const Text(
            'Seed clipboard for paste demo',
            style: TextStyle(fontSize: 13.0),
          ),
        ),
        const SizedBox(width: 12.0),
        const Expanded(
          child: Text(
            'Tap to put a sample string on the clipboard so the bubble '
            'menu Paste action has something to insert.',
            style: TextStyle(
              fontSize: 12.0,
              height: 1.35,
              color: Color(0xFF55556A),
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// MAIN HARNESS BUILD
// ============================================================================

dynamic build(BuildContext context) {
  print('CupertinoTextSelectionHandleControls hand-written demo executing');
  print('  singleton: ${cupertinoTextSelectionHandleControls.runtimeType}');
  print('  legacy   : ${cupertinoTextSelectionControls.runtimeType}');

  // Precompute a few handle metrics so the anatomy panel can show actual
  // numbers fed by the controls themselves rather than guessed values.
  final TextSelectionControls touchControls =
      cupertinoTextSelectionHandleControls;
  final Size handleSize14 = touchControls.getHandleSize(14.0);
  final Size handleSize20 = touchControls.getHandleSize(20.0);
  final Offset anchorLeft = touchControls.getHandleAnchor(
    TextSelectionHandleType.left,
    16.0,
  );
  final Offset anchorRight = touchControls.getHandleAnchor(
    TextSelectionHandleType.right,
    16.0,
  );
  final Offset anchorCollapsed = touchControls.getHandleAnchor(
    TextSelectionHandleType.collapsed,
    16.0,
  );

  print('  handleSize@14 -> ${handleSize14.width}x${handleSize14.height}');
  print('  handleSize@20 -> ${handleSize20.width}x${handleSize20.height}');
  print('  anchor.left   -> $anchorLeft');
  print('  anchor.right  -> $anchorRight');
  print('  anchor.collap -> $anchorCollapsed');

  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF7F7FA),
      navigationBar: const CupertinoNavigationBar(
        middle: Text('CupertinoTextSelectionHandleControls'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // ------------------------------------------------------------
              // Intro card — sets the stage before the numbered scenarios.
              // ------------------------------------------------------------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: const Color(0xFFD0D0D8),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      'Touch-Style iOS Selection',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1C1C1C),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Each scenario below wires a real CupertinoTextField '
                      'with selectionControls: cupertinoTextSelectionHandleControls. '
                      'Long-press inside any field to see the bubble menu '
                      '(cut / copy / paste / select all) plus the round drag '
                      'handles that snap to character boundaries.',
                      style: TextStyle(
                        fontSize: 14.0,
                        height: 1.4,
                        color: Color(0xFF34344A),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    _ClipboardSeedRow(),
                  ],
                ),
              ),

              // ============================================================
              // SCENARIO 1 — Editable single-line field
              // ============================================================
              _sectionTitle(
                1,
                'Editable single-line field',
                _palette1Header,
              ),
              _sectionBody(
                body: _palette1Body,
                border: _palette1Border,
                children: <Widget>[
                  _whatThisShows(
                    'A plain CupertinoTextField with the touch-style handle '
                    'controls wired in. The bubble menu offers cut, copy, '
                    'paste, and select all; the two round drag points are '
                    'the only way to extend a selection by touch.',
                    _palette1Caption,
                  ),
                  _fieldLabel('Single-line input', _palette1Caption),
                  CupertinoTextField(
                    controller: _ctrlSingleLine,
                    focusNode: _focusSingle,
                    selectionControls: cupertinoTextSelectionHandleControls,
                    placeholder: 'Type, then long-press to select…',
                    placeholderStyle: const TextStyle(
                      color: Color(0xFF8A8A99),
                    ),
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFF1C1C1C),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 12.0,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: _palette1Border,
                        width: 1.0,
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    autocorrect: false,
                  ),
                  _interactionTip(
                    'Tap and hold somewhere in the middle of the text to '
                    'see the magnifier appear. Drag the round handles to '
                    'extend selection in either direction.',
                    _palette1Caption,
                  ),
                ],
              ),

              // ============================================================
              // SCENARIO 2 — Editable multi-line paragraph
              // ============================================================
              _sectionTitle(
                2,
                'Editable multi-line paragraph',
                _palette2Header,
              ),
              _sectionBody(
                body: _palette2Body,
                border: _palette2Border,
                children: <Widget>[
                  _whatThisShows(
                    'A multi-line field (maxLines: null) pre-loaded with a '
                    'longer prose snippet. The handles snap to character '
                    'boundaries and behave naturally across line breaks — '
                    'pulling the right handle past the visible bottom line '
                    'auto-scrolls the field.',
                    _palette2Caption,
                  ),
                  _fieldLabel('Multi-line prose', _palette2Caption),
                  CupertinoTextField(
                    controller: _ctrlMultiline,
                    focusNode: _focusMulti,
                    selectionControls: cupertinoTextSelectionHandleControls,
                    placeholder: 'Write a paragraph…',
                    maxLines: null,
                    minLines: 5,
                    style: const TextStyle(
                      fontSize: 15.0,
                      height: 1.5,
                      color: Color(0xFF1C1C1C),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: _palette2Border,
                        width: 1.0,
                      ),
                    ),
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                  ),
                  _interactionTip(
                    'Try selecting from a word in the first paragraph, '
                    'across the blank line, into the second paragraph. '
                    'Notice how the handle anchors stay just below each '
                    'baseline so they never cover the glyph you are aiming '
                    'for.',
                    _palette2Caption,
                  ),
                ],
              ),

              // ============================================================
              // SCENARIO 3 — Password vs plain text contrast
              // ============================================================
              _sectionTitle(
                3,
                'Password field with masked text',
                _palette3Header,
              ),
              _sectionBody(
                body: _palette3Body,
                border: _palette3Border,
                children: <Widget>[
                  _whatThisShows(
                    'When obscureText is true, the toolbar suppresses cut '
                    'and copy so masked credentials cannot be exfiltrated. '
                    'The companion plain-text row uses the same handle '
                    'controls so the difference is purely in the toolbar.',
                    _palette3Caption,
                  ),
                  _fieldLabel('Obscured (password)', _palette3Caption),
                  CupertinoTextField(
                    controller: _ctrlPassword,
                    focusNode: _focusPassword,
                    selectionControls: cupertinoTextSelectionHandleControls,
                    obscureText: true,
                    obscuringCharacter: '\u2022',
                    placeholder: 'Password',
                    enableSuggestions: false,
                    autocorrect: false,
                    style: const TextStyle(
                      fontSize: 16.0,
                      letterSpacing: 2.0,
                      color: Color(0xFF1C1C1C),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 12.0,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: _palette3Border,
                        width: 1.0,
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 12.0),
                  _fieldLabel(
                    'Plain text (for contrast)',
                    _palette3Caption,
                  ),
                  CupertinoTextField(
                    controller: _ctrlPasswordContrast,
                    focusNode: _focusPasswordContrast,
                    selectionControls: cupertinoTextSelectionHandleControls,
                    placeholder: 'Plain text',
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFF1C1C1C),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 12.0,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: _palette3Border,
                        width: 1.0,
                      ),
                    ),
                  ),
                  _interactionTip(
                    'Long-press both fields. The masked field shows '
                    'Select All / Paste only; the plain field also shows '
                    'Cut / Copy. Same handle controls, different toolbar '
                    'options.',
                    _palette3Caption,
                  ),
                ],
              ),

              // ============================================================
              // SCENARIO 4 — Read-only selectable text
              // ============================================================
              _sectionTitle(
                4,
                'Read-only selectable text',
                _palette4Header,
              ),
              _sectionBody(
                body: _palette4Body,
                border: _palette4Border,
                children: <Widget>[
                  _whatThisShows(
                    'A CupertinoTextField with readOnly: true still surfaces '
                    'the round handles and supports copy, but the toolbar '
                    'omits Paste because the field will not accept incoming '
                    'clipboard content.',
                    _palette4Caption,
                  ),
                  _fieldLabel('Read-only field', _palette4Caption),
                  CupertinoTextField(
                    controller: _ctrlReadOnly,
                    focusNode: _focusReadOnly,
                    selectionControls: cupertinoTextSelectionHandleControls,
                    readOnly: true,
                    enableInteractiveSelection: true,
                    maxLines: null,
                    minLines: 3,
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.45,
                      color: Color(0xFF1C1C1C),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: _palette4Border,
                        width: 1.0,
                      ),
                    ),
                  ),
                  _interactionTip(
                    'Long-press a word — Cut and Paste are gone, but the '
                    'two round handles still let you extend the selection '
                    'so you can copy a longer phrase.',
                    _palette4Caption,
                  ),
                ],
              ),

              // ============================================================
              // SCENARIO 5 — Inside CupertinoListSection.insetGrouped
              // ============================================================
              _sectionTitle(
                5,
                'Inside CupertinoListSection.insetGrouped',
                _palette5Header,
              ),
              _sectionBody(
                body: _palette5Body,
                border: _palette5Border,
                children: <Widget>[
                  _whatThisShows(
                    'The handle controls behave identically when the field '
                    'lives inside a real grouped list. Long-press any '
                    'editable row and the bubble menu floats over the '
                    'rounded rectangle just as it does on a bare field.',
                    _palette5Caption,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: _palette5Border,
                        width: 1.0,
                      ),
                    ),
                    child: CupertinoListSection.insetGrouped(
                      backgroundColor: const Color(0x00000000),
                      header: const Text(
                        'PROFILE',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      children: <Widget>[
                        CupertinoListTile(
                          leading: const Icon(
                            CupertinoIcons.person_crop_circle,
                          ),
                          title: const Text('Display name'),
                          additionalInfo: SizedBox(
                            width: 180.0,
                            child: CupertinoTextField(
                              controller: _ctrlListSection,
                              focusNode: _focusListSection,
                              selectionControls:
                                  cupertinoTextSelectionHandleControls,
                              placeholder: 'name',
                              decoration: const BoxDecoration(),
                              padding: EdgeInsets.zero,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontSize: 15.0,
                                color: Color(0xFF1C1C1C),
                              ),
                            ),
                          ),
                        ),
                        CupertinoListTile(
                          leading: const Icon(CupertinoIcons.tag),
                          title: const Text('Notes'),
                          subtitle: CupertinoTextField(
                            controller: _ctrlListSectionNotes,
                            focusNode: _focusListSectionNotes,
                            selectionControls:
                                cupertinoTextSelectionHandleControls,
                            maxLines: null,
                            minLines: 2,
                            style: const TextStyle(
                              fontSize: 13.5,
                              height: 1.35,
                              color: Color(0xFF34344A),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 6.0,
                            ),
                            decoration: const BoxDecoration(),
                          ),
                        ),
                        const CupertinoListTile(
                          leading: Icon(CupertinoIcons.checkmark_seal),
                          title: Text('Status'),
                          additionalInfo: Text('Verified'),
                          trailing: CupertinoListTileChevron(),
                        ),
                      ],
                    ),
                  ),
                  _interactionTip(
                    'Long-press the right-aligned name field — the bubble '
                    'menu is anchored above the row, not the whole list. '
                    'The grouped layout has no effect on selection geometry.',
                    _palette5Caption,
                  ),
                ],
              ),

              // ============================================================
              // SCENARIO 6 — Touch vs Desktop side-by-side
              // ============================================================
              _sectionTitle(
                6,
                'Touch vs desktop side-by-side',
                _palette6Header,
              ),
              _sectionBody(
                body: _palette6Body,
                border: _palette6Border,
                children: <Widget>[
                  _whatThisShows(
                    'Two structurally identical fields, distinguished only '
                    'by the selectionControls argument. The left column '
                    'uses the touch handle controls (round drag points + '
                    'bubble menu); the right column uses the desktop '
                    'controls (no handles, floating menu strip, I-beam '
                    'driven selection).',
                    _palette6Caption,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            _fieldLabel(
                              'cupertinoTextSelectionHandleControls',
                              _palette6Caption,
                            ),
                            CupertinoTextField(
                              controller: _ctrlSideBySideTouch,
                              focusNode: _focusTouch,
                              selectionControls:
                                  cupertinoTextSelectionHandleControls,
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Color(0xFF1C1C1C),
                              ),
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: _palette6Border,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Bubble menu (cut/copy/paste) plus two '
                              'round draggable handles. Optimised for '
                              'thumb-and-finger interaction on phones.',
                              style: TextStyle(
                                fontSize: 12.0,
                                height: 1.35,
                                color: _palette6Caption,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            _fieldLabel(
                              'cupertinoDesktopTextSelectionControls',
                              _palette6Caption,
                            ),
                            CupertinoTextField(
                              controller: _ctrlSideBySideDesktop,
                              focusNode: _focusDesktop,
                              selectionControls:
                                  cupertinoDesktopTextSelectionControls,
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Color(0xFF1C1C1C),
                              ),
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: _palette6Border,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Floating menu strip, no draggable handles. '
                              'Selection is driven by mouse drag or '
                              'shift-click — the I-beam cursor is the '
                              'sole visual affordance.',
                              style: TextStyle(
                                fontSize: 12.0,
                                height: 1.35,
                                color: _palette6Caption,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  _interactionTip(
                    'On a touch device the left field shows two big round '
                    'handles, the right field shows none. On desktop, the '
                    'left field still shows handles (forced by the '
                    'controls singleton), the right field hides them.',
                    _palette6Caption,
                  ),
                ],
              ),

              // ============================================================
              // SCENARIO 7 — Build hooks anatomy panel
              // ============================================================
              _sectionTitle(
                7,
                'Build hooks anatomy',
                _palette7Header,
              ),
              _sectionBody(
                body: _palette7Body,
                border: _palette7Border,
                children: <Widget>[
                  _whatThisShows(
                    'Each card describes a TextSelectionControls hook that '
                    'CupertinoTextSelectionHandleControls overrides. The '
                    'live field on the right uses the singleton, so '
                    'interacting with it triggers the very methods listed '
                    'in the cards.',
                    _palette7Caption,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            _anatomyCard(
                              hookName: 'buildHandle',
                              description:
                                  'Renders one of the two round drag '
                                  'handles. The handle controls draw the '
                                  'iOS lollipop shape: a circle with a '
                                  'short stem touching the baseline.',
                              border: _palette7Border,
                              captionColor: _palette7Caption,
                            ),
                            _anatomyCard(
                              hookName: 'buildToolbar',
                              description:
                                  'Builds the bubble-style menu shown '
                                  'above the selection. It composes '
                                  'buildToolbarButton entries for cut, '
                                  'copy, paste, and select all when each '
                                  'is permitted.',
                              border: _palette7Border,
                              captionColor: _palette7Caption,
                            ),
                            _anatomyCard(
                              hookName: 'buildToolbarButton',
                              description:
                                  'Returns the styled label widget for a '
                                  'single bubble-menu entry. Cupertino '
                                  'uses CupertinoTheme to colour the '
                                  'pressed state and divider strokes.',
                              border: _palette7Border,
                              captionColor: _palette7Caption,
                            ),
                            _anatomyCard(
                              hookName: 'getHandleAnchor',
                              description:
                                  'Returns the offset where the handle '
                                  'should be glued to the text. For the '
                                  'left handle the anchor sits at the '
                                  'top-right of the lollipop, for the '
                                  'right handle the top-left, and for a '
                                  'collapsed caret the centre. Captured '
                                  'live: '
                                  'left=$anchorLeft, '
                                  'right=$anchorRight, '
                                  'collapsed=$anchorCollapsed.',
                              border: _palette7Border,
                              captionColor: _palette7Caption,
                            ),
                            _anatomyCard(
                              hookName: 'getHandleSize',
                              description:
                                  'Reports the touch target size for a '
                                  'handle given the surrounding text '
                                  'fontSize. Captured live: '
                                  'fontSize 14 -> '
                                  '${handleSize14.width.toStringAsFixed(1)}'
                                  'x'
                                  '${handleSize14.height.toStringAsFixed(1)}, '
                                  'fontSize 20 -> '
                                  '${handleSize20.width.toStringAsFixed(1)}'
                                  'x'
                                  '${handleSize20.height.toStringAsFixed(1)}.',
                              border: _palette7Border,
                              captionColor: _palette7Caption,
                            ),
                            _anatomyCard(
                              hookName: 'magnifier integration',
                              description:
                                  'CupertinoTextField pairs the handle '
                                  'controls with a TextMagnifier on '
                                  'iOS/Android. While you drag a handle '
                                  'the magnifier follows the gesture and '
                                  'enlarges the glyph under your finger.',
                              border: _palette7Border,
                              captionColor: _palette7Caption,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            _fieldLabel('Live field', _palette7Caption),
                            CupertinoTextField(
                              controller: _ctrlAnatomyLive,
                              focusNode: _focusAnatomy,
                              selectionControls:
                                  cupertinoTextSelectionHandleControls,
                              maxLines: null,
                              minLines: 6,
                              style: const TextStyle(
                                fontSize: 13.5,
                                height: 1.4,
                                color: Color(0xFF1C1C1C),
                              ),
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: _palette7Border,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: _palette7Border,
                                  width: 1.0,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Captured metrics',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.4,
                                      color: _palette7Caption,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    'getHandleSize(14) = '
                                    '${handleSize14.width.toStringAsFixed(1)}'
                                    ' × '
                                    '${handleSize14.height.toStringAsFixed(1)}',
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'Menlo',
                                      color: Color(0xFF1C1C1C),
                                    ),
                                  ),
                                  Text(
                                    'getHandleSize(20) = '
                                    '${handleSize20.width.toStringAsFixed(1)}'
                                    ' × '
                                    '${handleSize20.height.toStringAsFixed(1)}',
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'Menlo',
                                      color: Color(0xFF1C1C1C),
                                    ),
                                  ),
                                  Text(
                                    'anchor.left  = '
                                    '(${anchorLeft.dx.toStringAsFixed(1)}, '
                                    '${anchorLeft.dy.toStringAsFixed(1)})',
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'Menlo',
                                      color: Color(0xFF1C1C1C),
                                    ),
                                  ),
                                  Text(
                                    'anchor.right = '
                                    '(${anchorRight.dx.toStringAsFixed(1)}, '
                                    '${anchorRight.dy.toStringAsFixed(1)})',
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'Menlo',
                                      color: Color(0xFF1C1C1C),
                                    ),
                                  ),
                                  Text(
                                    'anchor.collap= '
                                    '(${anchorCollapsed.dx.toStringAsFixed(1)}, '
                                    '${anchorCollapsed.dy.toStringAsFixed(1)})',
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'Menlo',
                                      color: Color(0xFF1C1C1C),
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
                  _interactionTip(
                    'Long-press the live field on the right. The hook '
                    'cards on the left describe exactly which method on '
                    'CupertinoTextSelectionHandleControls is being '
                    'invoked at each moment of your gesture.',
                    _palette7Caption,
                  ),
                ],
              ),

              // ------------------------------------------------------------
              // Footer — names the singletons and reminds the reader that
              // cupertinoTextSelectionControls is the legacy alias kept
              // around for backwards compatibility.
              // ------------------------------------------------------------
              const SizedBox(height: 32.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: const Color(0xFFD0D0D8),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      'Singletons referenced by this demo',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1C1C1C),
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      '• cupertinoTextSelectionHandleControls — current '
                      'touch-style controls singleton.',
                      style: TextStyle(
                        fontSize: 12.0,
                        height: 1.35,
                        fontFamily: 'Menlo',
                        color: Color(0xFF34344A),
                      ),
                    ),
                    Text(
                      '• cupertinoTextSelectionControls — legacy alias kept '
                      'for backwards compatibility.',
                      style: TextStyle(
                        fontSize: 12.0,
                        height: 1.35,
                        fontFamily: 'Menlo',
                        color: Color(0xFF34344A),
                      ),
                    ),
                    Text(
                      '• cupertinoDesktopTextSelectionControls — used in '
                      'scenario 6 for contrast.',
                      style: TextStyle(
                        fontSize: 12.0,
                        height: 1.35,
                        fontFamily: 'Menlo',
                        color: Color(0xFF34344A),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

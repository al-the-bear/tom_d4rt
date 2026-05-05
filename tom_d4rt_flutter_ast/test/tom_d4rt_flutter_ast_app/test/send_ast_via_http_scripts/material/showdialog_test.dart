// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep visual demo: showDialog and the dialog ecosystem.
//
// Palette: Curtain Velvet, Stagelight Saffron, Plum Modal, Theatrical Cream.
// Theme: modal presentation, barrier dismissal, dialogs versus sheets.
//
// IMPORTANT: This file deliberately does NOT call showDialog at runtime
// because showDialog returns a Future and this harness forbids Future
// usage. Instead the file renders MOCK previews of AlertDialog,
// SimpleDialog, and Dialog using ordinary widgets so we can study the
// visual surface of the dialog ecosystem under d4rt without actually
// pushing modal routes.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('showDialog deep visual demo executing');
  print('Palette: Curtain Velvet / Stagelight Saffron / Plum Modal / Theatrical Cream');

  // ------------------------------------------------------------------
  // Palette constants. All colors live as const Color values so we
  // can index them freely from collections without the interpreter
  // tripping over shorthand factory calls.
  // ------------------------------------------------------------------
  const Color curtainVelvet = Color(0xFF3A1B2E);
  const Color curtainVelvetDeep = Color(0xFF24101F);
  const Color curtainVelvetSoft = Color(0xFF55334A);
  const Color stagelightSaffron = Color(0xFFE9B44C);
  const Color stagelightSaffronDeep = Color(0xFFC8911F);
  const Color stagelightSaffronGlow = Color(0xFFF6D58A);
  const Color plumModal = Color(0xFF6B4669);
  const Color plumModalDeep = Color(0xFF4A2D49);
  const Color plumModalSoft = Color(0xFF8E6B8C);
  const Color theatricalCream = Color(0xFFF5EBD8);
  const Color theatricalCreamDeep = Color(0xFFEADCC0);
  const Color theatricalCreamSoft = Color(0xFFFFF7E6);
  const Color barrierShadow = Color(0xFF1A0E16);
  const Color spotlightCyan = Color(0xFF7AB8C2);
  const Color warningEmber = Color(0xFFD96C5A);
  const Color confirmMoss = Color(0xFF6E8E59);
  const Color borderInk = Color(0xFF2A1622);

  // ------------------------------------------------------------------
  // Palette table data. Each row carries name, hex string, role.
  // ------------------------------------------------------------------
  final List<List<String>> paletteRows = <List<String>>[
    <String>['Curtain Velvet', '#3A1B2E', 'Primary surface, dialog frame'],
    <String>['Curtain Velvet Deep', '#24101F', 'Barrier scrim, deep shadow'],
    <String>['Curtain Velvet Soft', '#55334A', 'Hover, secondary frame'],
    <String>['Stagelight Saffron', '#E9B44C', 'Accent, primary action button'],
    <String>['Stagelight Saffron Deep', '#C8911F', 'Pressed accent, focus ring'],
    <String>['Stagelight Saffron Glow', '#F6D58A', 'Hover accent, soft highlight'],
    <String>['Plum Modal', '#6B4669', 'Header band, title region'],
    <String>['Plum Modal Deep', '#4A2D49', 'Header shadow, divider'],
    <String>['Plum Modal Soft', '#8E6B8C', 'Disabled, helper text'],
    <String>['Theatrical Cream', '#F5EBD8', 'Body surface, content fill'],
    <String>['Theatrical Cream Deep', '#EADCC0', 'Sub-surface, table stripe'],
    <String>['Theatrical Cream Soft', '#FFF7E6', 'Highlighted body, focus row'],
    <String>['Barrier Shadow', '#1A0E16', 'Modal barrier color, deep dim'],
    <String>['Spotlight Cyan', '#7AB8C2', 'Info accent, link colour'],
    <String>['Warning Ember', '#D96C5A', 'Destructive accent, error row'],
    <String>['Confirm Moss', '#6E8E59', 'Confirm accent, success row'],
    <String>['Border Ink', '#2A1622', 'Outline, hairline divider'],
  ];

  final List<Color> paletteColors = <Color>[
    curtainVelvet,
    curtainVelvetDeep,
    curtainVelvetSoft,
    stagelightSaffron,
    stagelightSaffronDeep,
    stagelightSaffronGlow,
    plumModal,
    plumModalDeep,
    plumModalSoft,
    theatricalCream,
    theatricalCreamDeep,
    theatricalCreamSoft,
    barrierShadow,
    spotlightCyan,
    warningEmber,
    confirmMoss,
    borderInk,
  ];

  // ------------------------------------------------------------------
  // showDialog API surface. Each entry: parameter, type, default, note.
  // ------------------------------------------------------------------
  final List<List<String>> showDialogApi = <List<String>>[
    <String>['context', 'BuildContext', 'required', 'Locates Navigator and Theme; must outlive call.'],
    <String>['builder', 'WidgetBuilder', 'required', 'Builds the dialog widget; receives a fresh context.'],
    <String>['barrierDismissible', 'bool', 'true', 'Tapping outside the dialog dismisses it.'],
    <String>['barrierColor', 'Color?', 'Colors.black54', 'Scrim color drawn behind the dialog.'],
    <String>['barrierLabel', 'String?', 'null', 'Semantics label for screen readers.'],
    <String>['useSafeArea', 'bool', 'true', 'Insets the dialog within the safe area.'],
    <String>['useRootNavigator', 'bool', 'true', 'Pushes onto the root Navigator vs nearest.'],
    <String>['routeSettings', 'RouteSettings?', 'null', 'Name and arguments for the dialog route.'],
    <String>['anchorPoint', 'Offset?', 'null', 'Disambiguates which display the dialog uses.'],
    <String>['traversalEdgeBehavior', 'TraversalEdge', 'parentScope', 'Focus traversal at the edge of the dialog.'],
  ];

  // ------------------------------------------------------------------
  // Dialog-type catalog. Used to render visual mocks side-by-side.
  // ------------------------------------------------------------------
  final List<List<String>> dialogTypes = <List<String>>[
    <String>['AlertDialog', 'Title + content + actions row.', 'Confirmations, alerts, simple choices.'],
    <String>['SimpleDialog', 'Title + list of SimpleDialogOption children.', 'Pick-one choice from a small list.'],
    <String>['Dialog', 'Bare modal surface; you supply the layout.', 'Custom modal panels, forms, media.'],
    <String>['DialogTheme', 'Inherited theming for dialogs in subtree.', 'Centralized look-and-feel.'],
    <String>['AboutDialog', 'Pre-built app metadata dialog.', 'About screens, license listing.'],
  ];

  // ------------------------------------------------------------------
  // Barrier color comparison gallery data.
  // ------------------------------------------------------------------
  final List<List<dynamic>> barrierGallery = <List<dynamic>>[
    <dynamic>['Default scrim', barrierShadow.withValues(alpha: 0.54), 'Colors.black54 (default)'],
    <dynamic>['Velvet veil', curtainVelvet.withValues(alpha: 0.62), 'Brand-tinted dim'],
    <dynamic>['Plum hush', plumModalDeep.withValues(alpha: 0.70), 'Deep modal feel'],
    <dynamic>['Saffron wash', stagelightSaffronDeep.withValues(alpha: 0.30), 'Warm, soft dim'],
    <dynamic>['Spotlight bloom', spotlightCyan.withValues(alpha: 0.28), 'Cool info accent'],
    <dynamic>['Ember warn', warningEmber.withValues(alpha: 0.40), 'Destructive context'],
    <dynamic>['Transparent', Color(0x00000000), 'No scrim - rare, accessibility risk'],
    <dynamic>['Pure black', Color(0xFF000000).withValues(alpha: 0.85), 'Heavy theatrical blackout'],
  ];

  // ------------------------------------------------------------------
  // Button-action patterns table. Each entry: pattern, snippet, note.
  // ------------------------------------------------------------------
  final List<List<String>> actionPatterns = <List<String>>[
    <String>['Cancel/Confirm pair', 'TextButton(Cancel) + ElevatedButton(Confirm)', 'Most common AlertDialog pattern.'],
    <String>['Destructive confirm', 'TextButton(Cancel) + filled ember Delete', 'Make destructive action stand out.'],
    <String>['Single OK', 'TextButton(OK) only', 'Pure information; no choice.'],
    <String>['Three-way', 'Cancel / Discard / Save', 'Editor exit prompts.'],
    <String>['Pick-one list', 'SimpleDialogOption per choice', 'No explicit OK/Cancel.'],
    <String>['Custom layout', 'Dialog with bespoke children', 'Forms, pickers, embedded widgets.'],
    <String>['Async result', 'Navigator.pop(ctx, result)', 'Pass selection back to caller.'],
    <String>['Dismiss only', 'Navigator.pop(ctx)', 'No result; unit-typed dialog.'],
  ];

  // ------------------------------------------------------------------
  // Comparison: Dialog vs ModalBottomSheet vs Snackbar vs Banner vs Popup
  // ------------------------------------------------------------------
  final List<List<String>> comparisonRows = <List<String>>[
    <String>['Dialog', 'Center, modal', 'Yes (barrier)', 'Critical decision', 'Tap barrier or action'],
    <String>['ModalBottomSheet', 'Bottom, modal', 'Yes (barrier)', 'Action menu, picker', 'Drag down, tap barrier'],
    <String>['BottomSheet (persistent)', 'Bottom, non-modal', 'No', 'Contextual extra info', 'Drag, swipe'],
    <String>['SnackBar', 'Bottom edge, brief', 'No', 'Transient feedback', 'Auto-dismiss, swipe'],
    <String>['MaterialBanner', 'Top, persistent', 'No', 'Status, prompts in flow', 'Action button'],
    <String>['Popup menu', 'Anchored to widget', 'Light barrier', 'Quick choices', 'Tap option or outside'],
    <String>['Tooltip', 'Anchored, hover/long-press', 'No', 'Hint text', 'Release, timeout'],
    <String>['Toast (third-party)', 'Floating, brief', 'No', 'Tiny notice', 'Auto-dismiss'],
  ];

  // ------------------------------------------------------------------
  // Glossary entries.
  // ------------------------------------------------------------------
  final List<List<String>> glossary = <List<String>>[
    <String>['Modal', 'Blocks interaction with content beneath until dismissed.'],
    <String>['Barrier', 'The dim scrim drawn behind a modal route.'],
    <String>['Barrier dismissible', 'Whether a tap on the scrim closes the dialog.'],
    <String>['Route', 'A push/pop entry on the Navigator stack.'],
    <String>['Builder', 'Callback that returns the widget for the new route.'],
    <String>['Focus trap', 'Confining keyboard focus to the dialog while open.'],
    <String>['Safe area', 'Region not covered by notches or system UI.'],
    <String>['Root navigator', 'The topmost Navigator at app level.'],
    <String>['Anchor point', 'Used to choose display in multi-screen setups.'],
    <String>['Semantics label', 'Text announced by assistive technologies.'],
    <String>['Scrim opacity', 'Alpha channel of the barrier color.'],
    <String>['Modality', 'How forcefully a UI demands attention.'],
    <String>['Pop result', 'Value returned via Navigator.pop(ctx, value).'],
    <String>['Theme override', 'Local Theme/DialogTheme above showDialog call.'],
    <String>['Dismissal', 'The act of closing a dialog (tap, escape, action).'],
  ];

  // ------------------------------------------------------------------
  // Pitfalls.
  // ------------------------------------------------------------------
  final List<List<String>> pitfalls = <List<String>>[
    <String>['Using context after dismiss', 'After Navigator.pop, the builder context is dead. Capture state earlier.'],
    <String>['Awaiting in disposed widget', 'If parent unmounts before await, do not call setState.'],
    <String>['Nested dialogs', 'Stacking too many barriers confuses users; prefer a single decision.'],
    <String>['Barrier dismiss for destructive', 'Tap-outside should not delete data; set barrierDismissible: false.'],
    <String>['Long content w/o scroll', 'Content can overflow; wrap in SingleChildScrollView.'],
    <String>['Wrong navigator', 'useRootNavigator: false routes onto a nested navigator; pick deliberately.'],
    <String>['No semantics label', 'Screen readers do not know the barrier role; provide barrierLabel.'],
    <String>['Hidden actions on small screens', 'AlertDialog stacks actions vertically below a width threshold.'],
    <String>['Dialog within Dialog', 'Reaching for context in inner dialog can pop the outer one.'],
    <String>['Theme drift', 'Relying on default DialogTheme yields inconsistent look across screens.'],
  ];

  // ------------------------------------------------------------------
  // Scenario panels: confirm-delete, info, choice list, error.
  // ------------------------------------------------------------------
  final List<List<String>> scenarios = <List<String>>[
    <String>['Confirm Delete', 'Destructive action. barrierDismissible: false. Two buttons: Cancel + Delete (ember).'],
    <String>['Info', 'Single OK. Light scrim. Friendly tone, neutral palette.'],
    <String>['Choice List', 'SimpleDialog with 3-6 SimpleDialogOption children, each pops with a key.'],
    <String>['Error', 'AlertDialog with warning ember icon, technical detail collapsed below summary.'],
    <String>['Form', 'Custom Dialog with TextField rows, Save/Cancel actions.'],
    <String>['Picker', 'Custom Dialog hosting a date or color picker.'],
  ];

  // ------------------------------------------------------------------
  // Accessibility prose blocks.
  // ------------------------------------------------------------------
  final List<String> accessibilityNotes = <String>[
    'Announce the dialog. When it appears the platform should fire a live-region announcement so screen readers say something like "Dialog: Confirm Delete". Provide barrierLabel for the scrim itself.',
    'Trap focus. The Flutter modal route automatically scopes focus inside the dialog, but custom barriers built with Stack do NOT. If you build a bespoke modal, wrap it in FocusScope.',
    'Honour escape. Keyboard users expect Escape to dismiss the dialog. The default Flutter dialog route handles this; custom modals must too.',
    'Restore focus. After the dialog closes, focus should return to the widget that opened it. The Navigator does this automatically when you Navigator.pop.',
    'Mind contrast. Body text on a light theatrical cream surface should reach 4.5:1 against a dark ink. Saffron-on-cream titles can dip below contrast - pair with a curtain-velvet caption.',
    'Touch targets. Dialog actions sit close together. Minimum 48dp tappable height keeps mistakes rare.',
    'Semantic order. Title -> content -> actions matches the announce order. Keep it.',
    'Time. Do not auto-dismiss dialogs. People with cognitive disabilities need time to read.',
    'Motion. Dialog enter/exit transitions should respect the reduce-motion preference. Cross-fade rather than slide when animations are reduced.',
  ];

  // ------------------------------------------------------------------
  // Theming notes.
  // ------------------------------------------------------------------
  final List<String> themingNotes = <String>[
    'Wrap a subtree in Theme(data: ..., child: ...) before calling showDialog to override colors and shapes locally.',
    'Use DialogTheme on the global ThemeData to set backgroundColor, elevation, shape, alignment, titleTextStyle and contentTextStyle.',
    'Prefer rounded shapes (RoundedRectangleBorder, BorderRadius.circular(20)) for a softer modal feel.',
    'Avoid pure-white modal surfaces against a dark app theme; pick a tinted cream like Theatrical Cream for warmth.',
    'For destructive actions, swap the action ButtonStyle to a filled ember; do not just colour the label.',
    'For brand voice, give SimpleDialog a darker title band and lighter option rows, separated by a 1dp Border Ink hairline.',
    'When mixing dialogs and bottom sheets in one app, share radii and elevation so both feel like the same family.',
  ];

  // ------------------------------------------------------------------
  // Decision flowchart text.
  // ------------------------------------------------------------------
  final List<String> decisionFlow = <String>[
    'Q1: Is the user being asked a critical decision that must be answered?',
    '    YES -> consider a Dialog (modal). Continue to Q2.',
    '    NO  -> probably a SnackBar, Banner or inline UI.',
    'Q2: Is it a short binary or trinary choice?',
    '    YES -> AlertDialog with action buttons.',
    '    NO  -> Continue to Q3.',
    'Q3: Is it a pick-one from a short list?',
    '    YES -> SimpleDialog with SimpleDialogOption children.',
    '    NO  -> Continue to Q4.',
    'Q4: Does it need a complex form or media?',
    '    YES -> Dialog with custom content; consider full-screen route instead if huge.',
    '    NO  -> Continue to Q5.',
    'Q5: Is the action contextual to a particular widget on screen?',
    '    YES -> popup menu or anchored card might fit better than a centered dialog.',
    '    NO  -> default to AlertDialog.',
  ];

  // ------------------------------------------------------------------
  // Build a try/catch wrapped AlertDialog mock as a Widget. This is a
  // VISUAL mock - we do not push it onto Navigator, we do not call
  // showDialog. We render the exact same constructors so the d4rt
  // bridge exercises them inside try/catch.
  // ------------------------------------------------------------------
  Widget alertDialogMock;
  try {
    alertDialogMock = AlertDialog(
      backgroundColor: theatricalCream,
      elevation: 12.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      titlePadding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 12.0),
      contentPadding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 12.0),
      actionsPadding: EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 12.0),
      title: Row(
        children: <Widget>[
          Container(
            width: 28.0,
            height: 28.0,
            decoration: BoxDecoration(
              color: warningEmber,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '!',
              style: TextStyle(
                color: theatricalCreamSoft,
                fontWeight: FontWeight.w900,
                fontSize: 18.0,
              ),
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Text(
              'Confirm Delete',
              style: TextStyle(
                color: curtainVelvetDeep,
                fontWeight: FontWeight.w800,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'This action removes the selected item from the catalog. It cannot be undone from this screen.',
            style: TextStyle(
              color: curtainVelvet,
              fontSize: 14.0,
              height: 1.4,
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: theatricalCreamDeep,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: borderInk.withValues(alpha: 0.18)),
            ),
            child: Text(
              'item: stage_lamp_velvet_001',
              style: TextStyle(
                color: plumModalDeep,
                fontFamily: 'monospace',
                fontSize: 12.0,
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            print('AlertDialog mock: Cancel pressed');
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: curtainVelvet, fontWeight: FontWeight.w700),
          ),
        ),
        TextButton(
          onPressed: () {
            print('AlertDialog mock: Delete pressed');
          },
          child: Text(
            'Delete',
            style: TextStyle(color: warningEmber, fontWeight: FontWeight.w900),
          ),
        ),
      ],
    );
  } catch (e) {
    print('alertDialogMock error: $e');
    alertDialogMock = Container(
      padding: EdgeInsets.all(16.0),
      color: warningEmber.withValues(alpha: 0.2),
      child: Text('AlertDialog mock failed: $e'),
    );
  }

  // ------------------------------------------------------------------
  // SimpleDialog mock with try/catch.
  // ------------------------------------------------------------------
  Widget simpleDialogMock;
  try {
    final List<Widget> simpleOptions = <Widget>[];
    final List<List<String>> optionData = <List<String>>[
      <String>['Front row', 'A1-A12'],
      <String>['Mezzanine', 'B5-B40'],
      <String>['Balcony', 'C1-C60'],
      <String>['Box seat', 'V1-V8'],
    ];
    for (int i = 0; i < optionData.length; i = i + 1) {
      Widget option;
      try {
        option = SimpleDialogOption(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
          onPressed: () {
            print('SimpleDialog mock: option ${optionData[i][0]} chosen');
          },
          child: Row(
            children: <Widget>[
              Container(
                width: 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  color: stagelightSaffron,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  optionData[i][0],
                  style: TextStyle(
                    color: curtainVelvet,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.0,
                  ),
                ),
              ),
              Text(
                optionData[i][1],
                style: TextStyle(
                  color: plumModalSoft,
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        );
      } catch (e) {
        print('SimpleDialogOption $i error: $e');
        option = Container(
          padding: EdgeInsets.all(8.0),
          child: Text('option failed: $e'),
        );
      }
      simpleOptions.add(option);
    }

    simpleDialogMock = SimpleDialog(
      backgroundColor: theatricalCream,
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      titlePadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 12.0),
      contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
      title: Text(
        'Pick a section',
        style: TextStyle(
          color: plumModalDeep,
          fontWeight: FontWeight.w800,
          fontSize: 18.0,
        ),
      ),
      children: simpleOptions,
    );
  } catch (e) {
    print('simpleDialogMock error: $e');
    simpleDialogMock = Container(
      padding: EdgeInsets.all(16.0),
      color: warningEmber.withValues(alpha: 0.2),
      child: Text('SimpleDialog mock failed: $e'),
    );
  }

  // ------------------------------------------------------------------
  // Bare Dialog mock with try/catch.
  // ------------------------------------------------------------------
  Widget bareDialogMock;
  try {
    bareDialogMock = Dialog(
      backgroundColor: theatricalCream,
      elevation: 14.0,
      insetPadding: EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: EdgeInsets.all(20.0),
        constraints: BoxConstraints(maxWidth: 360.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: plumModal,
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: Text(
                'CUSTOM PANEL',
                style: TextStyle(
                  color: theatricalCreamSoft,
                  fontWeight: FontWeight.w800,
                  fontSize: 11.0,
                  letterSpacing: 1.4,
                ),
              ),
            ),
            SizedBox(height: 14.0),
            Text(
              'Set the curtain',
              style: TextStyle(
                color: curtainVelvetDeep,
                fontWeight: FontWeight.w900,
                fontSize: 22.0,
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              'Compose any layout you like inside Dialog. There is no required action row, no required title block.',
              style: TextStyle(
                color: curtainVelvet,
                fontSize: 13.0,
                height: 1.4,
              ),
            ),
            SizedBox(height: 14.0),
            Container(
              height: 80.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[stagelightSaffronGlow, stagelightSaffron, stagelightSaffronDeep],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              alignment: Alignment.center,
              child: Text(
                'Spotlight band',
                style: TextStyle(
                  color: curtainVelvetDeep,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(height: 14.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    print('Dialog mock: Cancel');
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: curtainVelvet),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  decoration: BoxDecoration(
                    color: stagelightSaffron,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: curtainVelvetDeep,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  } catch (e) {
    print('bareDialogMock error: $e');
    bareDialogMock = Container(
      padding: EdgeInsets.all(16.0),
      color: warningEmber.withValues(alpha: 0.2),
      child: Text('Dialog mock failed: $e'),
    );
  }

  // ------------------------------------------------------------------
  // DialogTheme construction wrapped in try/catch (we read its props
  // and display them; we do NOT attach it to a real Theme widget).
  // ------------------------------------------------------------------
  String dialogThemeSummary;
  try {
    final DialogTheme dt = DialogTheme(
      backgroundColor: theatricalCream,
      elevation: 12.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      alignment: Alignment.center,
      titleTextStyle: TextStyle(
        color: curtainVelvetDeep,
        fontWeight: FontWeight.w800,
        fontSize: 18.0,
      ),
      contentTextStyle: TextStyle(
        color: curtainVelvet,
        fontSize: 14.0,
      ),
    );
    dialogThemeSummary = 'DialogTheme constructed: bg=cream, elev=${dt.elevation}, alignment=center';
  } catch (e) {
    print('DialogTheme error: $e');
    dialogThemeSummary = 'DialogTheme failed: $e';
  }

  // ------------------------------------------------------------------
  // Helper: section header.
  // ------------------------------------------------------------------
  Widget sectionHeader(String label, String subtitle) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 24.0, bottom: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[curtainVelvetDeep, curtainVelvet, plumModalDeep],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
          bottomLeft: Radius.circular(4.0),
          bottomRight: Radius.circular(4.0),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: curtainVelvetDeep.withValues(alpha: 0.4),
            blurRadius: 8.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 6.0,
                height: 22.0,
                decoration: BoxDecoration(
                  color: stagelightSaffron,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: theatricalCreamSoft,
                    fontWeight: FontWeight.w900,
                    fontSize: 16.0,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Text(
            subtitle,
            style: TextStyle(
              color: stagelightSaffronGlow,
              fontSize: 12.0,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------
  // Helper: prose card.
  // ------------------------------------------------------------------
  Widget proseCard(String body) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: theatricalCreamSoft,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: borderInk.withValues(alpha: 0.15)),
      ),
      child: Text(
        body,
        style: TextStyle(
          color: curtainVelvetDeep,
          fontSize: 13.0,
          height: 1.45,
        ),
      ),
    );
  }

  // ------------------------------------------------------------------
  // Build palette table.
  // ------------------------------------------------------------------
  final List<Widget> paletteTableRows = <Widget>[];
  paletteTableRows.add(
    Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: curtainVelvet,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 36.0,
            child: Text(
              'SW',
              style: TextStyle(
                color: stagelightSaffronGlow,
                fontWeight: FontWeight.w800,
                fontSize: 11.0,
                letterSpacing: 1.0,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Name',
              style: TextStyle(
                color: stagelightSaffronGlow,
                fontWeight: FontWeight.w800,
                fontSize: 11.0,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Hex',
              style: TextStyle(
                color: stagelightSaffronGlow,
                fontWeight: FontWeight.w800,
                fontSize: 11.0,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              'Role',
              style: TextStyle(
                color: stagelightSaffronGlow,
                fontWeight: FontWeight.w800,
                fontSize: 11.0,
              ),
            ),
          ),
        ],
      ),
    ),
  );
  for (int i = 0; i < paletteRows.length; i = i + 1) {
    final Color stripe = i % 2 == 0 ? theatricalCream : theatricalCreamDeep;
    paletteTableRows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        decoration: BoxDecoration(color: stripe),
        child: Row(
          children: <Widget>[
            Container(
              width: 28.0,
              height: 28.0,
              margin: EdgeInsets.only(right: 8.0),
              decoration: BoxDecoration(
                color: paletteColors[i],
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: borderInk.withValues(alpha: 0.3)),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                paletteRows[i][0],
                style: TextStyle(
                  color: curtainVelvetDeep,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.0,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                paletteRows[i][1],
                style: TextStyle(
                  color: plumModalDeep,
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                paletteRows[i][2],
                style: TextStyle(
                  color: curtainVelvet,
                  fontSize: 11.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------------
  // Build showDialog API table.
  // ------------------------------------------------------------------
  final List<Widget> apiTableRows = <Widget>[];
  apiTableRows.add(
    Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: plumModalDeep,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              'Parameter',
              style: TextStyle(
                color: stagelightSaffronGlow,
                fontWeight: FontWeight.w800,
                fontSize: 11.0,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Type',
              style: TextStyle(
                color: stagelightSaffronGlow,
                fontWeight: FontWeight.w800,
                fontSize: 11.0,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Default',
              style: TextStyle(
                color: stagelightSaffronGlow,
                fontWeight: FontWeight.w800,
                fontSize: 11.0,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              'Note',
              style: TextStyle(
                color: stagelightSaffronGlow,
                fontWeight: FontWeight.w800,
                fontSize: 11.0,
              ),
            ),
          ),
        ],
      ),
    ),
  );
  for (int i = 0; i < showDialogApi.length; i = i + 1) {
    final Color stripe = i % 2 == 0 ? theatricalCreamSoft : theatricalCreamDeep;
    apiTableRows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        decoration: BoxDecoration(color: stripe),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Text(
                showDialogApi[i][0],
                style: TextStyle(
                  color: curtainVelvetDeep,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  fontSize: 11.0,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                showDialogApi[i][1],
                style: TextStyle(
                  color: plumModalDeep,
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                showDialogApi[i][2],
                style: TextStyle(
                  color: stagelightSaffronDeep,
                  fontWeight: FontWeight.w700,
                  fontSize: 11.0,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Text(
                showDialogApi[i][3],
                style: TextStyle(
                  color: curtainVelvet,
                  fontSize: 11.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------------
  // Build dialog-type catalog.
  // ------------------------------------------------------------------
  final List<Widget> dialogTypeCards = <Widget>[];
  for (int i = 0; i < dialogTypes.length; i = i + 1) {
    dialogTypeCards.add(
      Container(
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: theatricalCreamSoft,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: plumModal.withValues(alpha: 0.4)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: plumModalDeep.withValues(alpha: 0.12),
              blurRadius: 6.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: stagelightSaffron,
                    borderRadius: BorderRadius.circular(999.0),
                  ),
                  child: Text(
                    dialogTypes[i][0],
                    style: TextStyle(
                      color: curtainVelvetDeep,
                      fontWeight: FontWeight.w900,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              dialogTypes[i][1],
              style: TextStyle(
                color: curtainVelvetDeep,
                fontWeight: FontWeight.w700,
                fontSize: 13.0,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'Use for: ${dialogTypes[i][2]}',
              style: TextStyle(
                color: plumModalDeep,
                fontSize: 12.0,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------------
  // Barrier color gallery: each item paints a fake "modal scene" with
  // the candidate barrier and a tiny mock dialog floating above.
  // ------------------------------------------------------------------
  final List<Widget> barrierGalleryTiles = <Widget>[];
  for (int i = 0; i < barrierGallery.length; i = i + 1) {
    final String name = barrierGallery[i][0];
    final Color barrier = barrierGallery[i][1];
    final String note = barrierGallery[i][2];
    barrierGalleryTiles.add(
      Container(
        margin: EdgeInsets.only(bottom: 10.0),
        height: 120.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: borderInk.withValues(alpha: 0.3)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: <Widget>[
            // Fake background app surface.
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[theatricalCream, theatricalCreamDeep],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(height: 10.0, width: 90.0, color: curtainVelvet.withValues(alpha: 0.3)),
                  SizedBox(height: 6.0),
                  Container(height: 8.0, width: 160.0, color: curtainVelvet.withValues(alpha: 0.18)),
                  SizedBox(height: 6.0),
                  Container(height: 8.0, width: 130.0, color: curtainVelvet.withValues(alpha: 0.18)),
                ],
              ),
            ),
            // Barrier scrim.
            Container(color: barrier),
            // Mock floating dialog.
            Positioned(
              left: 24.0,
              right: 24.0,
              top: 30.0,
              bottom: 30.0,
              child: Container(
                decoration: BoxDecoration(
                  color: theatricalCreamSoft,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: barrierShadow.withValues(alpha: 0.4),
                      blurRadius: 12.0,
                      offset: Offset(0.0, 4.0),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 26.0,
                      height: 26.0,
                      decoration: BoxDecoration(
                        color: stagelightSaffron,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '?',
                        style: TextStyle(
                          color: curtainVelvetDeep,
                          fontWeight: FontWeight.w900,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            name,
                            style: TextStyle(
                              color: curtainVelvetDeep,
                              fontWeight: FontWeight.w900,
                              fontSize: 12.0,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            note,
                            style: TextStyle(
                              color: plumModalDeep,
                              fontSize: 10.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------------
  // Build button-action patterns table.
  // ------------------------------------------------------------------
  final List<Widget> actionPatternRows = <Widget>[];
  for (int i = 0; i < actionPatterns.length; i = i + 1) {
    actionPatternRows.add(
      Container(
        margin: EdgeInsets.only(bottom: 8.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: theatricalCreamSoft,
          borderRadius: BorderRadius.circular(8.0),
          border: Border(
            left: BorderSide(color: stagelightSaffron, width: 4.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              actionPatterns[i][0],
              style: TextStyle(
                color: curtainVelvetDeep,
                fontWeight: FontWeight.w800,
                fontSize: 13.0,
              ),
            ),
            SizedBox(height: 2.0),
            Text(
              actionPatterns[i][1],
              style: TextStyle(
                color: plumModalDeep,
                fontFamily: 'monospace',
                fontSize: 11.0,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              actionPatterns[i][2],
              style: TextStyle(
                color: curtainVelvet,
                fontSize: 11.0,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------------
  // Build comparison table (Dialog vs sheet vs ...).
  // ------------------------------------------------------------------
  final List<Widget> comparisonTable = <Widget>[];
  comparisonTable.add(
    Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: curtainVelvetDeep,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(flex: 3, child: Text('Surface', style: TextStyle(color: stagelightSaffronGlow, fontWeight: FontWeight.w800, fontSize: 11.0))),
          Expanded(flex: 3, child: Text('Position', style: TextStyle(color: stagelightSaffronGlow, fontWeight: FontWeight.w800, fontSize: 11.0))),
          Expanded(flex: 2, child: Text('Modal', style: TextStyle(color: stagelightSaffronGlow, fontWeight: FontWeight.w800, fontSize: 11.0))),
          Expanded(flex: 4, child: Text('Use', style: TextStyle(color: stagelightSaffronGlow, fontWeight: FontWeight.w800, fontSize: 11.0))),
          Expanded(flex: 4, child: Text('Dismiss', style: TextStyle(color: stagelightSaffronGlow, fontWeight: FontWeight.w800, fontSize: 11.0))),
        ],
      ),
    ),
  );
  for (int i = 0; i < comparisonRows.length; i = i + 1) {
    final Color stripe = i % 2 == 0 ? theatricalCreamSoft : theatricalCreamDeep;
    comparisonTable.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        decoration: BoxDecoration(color: stripe),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Text(
                comparisonRows[i][0],
                style: TextStyle(
                  color: curtainVelvetDeep,
                  fontWeight: FontWeight.w700,
                  fontSize: 11.0,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                comparisonRows[i][1],
                style: TextStyle(
                  color: plumModalDeep,
                  fontSize: 11.0,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                comparisonRows[i][2],
                style: TextStyle(
                  color: curtainVelvet,
                  fontSize: 11.0,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                comparisonRows[i][3],
                style: TextStyle(
                  color: curtainVelvet,
                  fontSize: 11.0,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                comparisonRows[i][4],
                style: TextStyle(
                  color: curtainVelvet,
                  fontSize: 11.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------------
  // Build scenario panels.
  // ------------------------------------------------------------------
  final List<Widget> scenarioPanels = <Widget>[];
  for (int i = 0; i < scenarios.length; i = i + 1) {
    Color accent;
    if (i == 0) {
      accent = warningEmber;
    } else if (i == 1) {
      accent = spotlightCyan;
    } else if (i == 2) {
      accent = stagelightSaffron;
    } else if (i == 3) {
      accent = warningEmber;
    } else if (i == 4) {
      accent = confirmMoss;
    } else {
      accent = plumModal;
    }
    scenarioPanels.add(
      Container(
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          color: theatricalCreamSoft,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: accent.withValues(alpha: 0.6), width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.18),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Text(
                scenarios[i][0],
                style: TextStyle(
                  color: curtainVelvetDeep,
                  fontWeight: FontWeight.w900,
                  fontSize: 13.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                scenarios[i][1],
                style: TextStyle(
                  color: curtainVelvet,
                  fontSize: 12.0,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------------
  // Build pitfalls list.
  // ------------------------------------------------------------------
  final List<Widget> pitfallTiles = <Widget>[];
  for (int i = 0; i < pitfalls.length; i = i + 1) {
    pitfallTiles.add(
      Container(
        margin: EdgeInsets.only(bottom: 8.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: theatricalCreamSoft,
          borderRadius: BorderRadius.circular(8.0),
          border: Border(
            left: BorderSide(color: warningEmber, width: 4.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 22.0,
                  height: 22.0,
                  decoration: BoxDecoration(
                    color: warningEmber,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '!',
                    style: TextStyle(
                      color: theatricalCreamSoft,
                      fontWeight: FontWeight.w900,
                      fontSize: 12.0,
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    pitfalls[i][0],
                    style: TextStyle(
                      color: curtainVelvetDeep,
                      fontWeight: FontWeight.w800,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Text(
              pitfalls[i][1],
              style: TextStyle(
                color: curtainVelvet,
                fontSize: 11.0,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------------
  // Build glossary list.
  // ------------------------------------------------------------------
  final List<Widget> glossaryTiles = <Widget>[];
  for (int i = 0; i < glossary.length; i = i + 1) {
    glossaryTiles.add(
      Container(
        margin: EdgeInsets.only(bottom: 6.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: i % 2 == 0 ? theatricalCreamSoft : theatricalCreamDeep,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 130.0,
              child: Text(
                glossary[i][0],
                style: TextStyle(
                  color: plumModalDeep,
                  fontWeight: FontWeight.w800,
                  fontSize: 12.0,
                ),
              ),
            ),
            Expanded(
              child: Text(
                glossary[i][1],
                style: TextStyle(
                  color: curtainVelvet,
                  fontSize: 12.0,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------------
  // Build palette swatch strip.
  // ------------------------------------------------------------------
  final List<Widget> swatchStrip = <Widget>[];
  for (int i = 0; i < paletteColors.length; i = i + 1) {
    swatchStrip.add(
      Container(
        width: 36.0,
        height: 36.0,
        margin: EdgeInsets.only(right: 4.0),
        decoration: BoxDecoration(
          color: paletteColors[i],
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: borderInk.withValues(alpha: 0.3)),
        ),
      ),
    );
  }

  // ------------------------------------------------------------------
  // Decision flow tiles.
  // ------------------------------------------------------------------
  final List<Widget> decisionTiles = <Widget>[];
  for (int i = 0; i < decisionFlow.length; i = i + 1) {
    final String line = decisionFlow[i];
    final bool isQuestion = line.startsWith('Q');
    decisionTiles.add(
      Container(
        margin: EdgeInsets.only(bottom: 4.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isQuestion ? plumModal.withValues(alpha: 0.15) : theatricalCreamSoft,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(
            color: isQuestion ? plumModal.withValues(alpha: 0.5) : borderInk.withValues(alpha: 0.15),
          ),
        ),
        child: Text(
          line,
          style: TextStyle(
            color: isQuestion ? plumModalDeep : curtainVelvet,
            fontFamily: 'monospace',
            fontWeight: isQuestion ? FontWeight.w800 : FontWeight.w500,
            fontSize: 11.5,
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------------
  // Theming notes tiles.
  // ------------------------------------------------------------------
  final List<Widget> themingTiles = <Widget>[];
  for (int i = 0; i < themingNotes.length; i = i + 1) {
    themingTiles.add(
      Container(
        margin: EdgeInsets.only(bottom: 6.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: theatricalCreamDeep,
          borderRadius: BorderRadius.circular(8.0),
          border: Border(
            left: BorderSide(color: confirmMoss, width: 4.0),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${i + 1}.',
              style: TextStyle(
                color: confirmMoss,
                fontWeight: FontWeight.w900,
                fontSize: 12.0,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                themingNotes[i],
                style: TextStyle(
                  color: curtainVelvetDeep,
                  fontSize: 12.0,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------------
  // Accessibility tiles.
  // ------------------------------------------------------------------
  final List<Widget> accessibilityTiles = <Widget>[];
  for (int i = 0; i < accessibilityNotes.length; i = i + 1) {
    accessibilityTiles.add(
      Container(
        margin: EdgeInsets.only(bottom: 6.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: theatricalCreamSoft,
          borderRadius: BorderRadius.circular(8.0),
          border: Border(
            left: BorderSide(color: spotlightCyan, width: 4.0),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 22.0,
              height: 22.0,
              decoration: BoxDecoration(
                color: spotlightCyan,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                'a',
                style: TextStyle(
                  color: curtainVelvetDeep,
                  fontWeight: FontWeight.w900,
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                accessibilityNotes[i],
                style: TextStyle(
                  color: curtainVelvet,
                  fontSize: 12.0,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------------
  // Hero card with mock modal preview.
  // ------------------------------------------------------------------
  final Widget heroCard = Container(
    margin: EdgeInsets.only(bottom: 12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[curtainVelvetDeep, curtainVelvet, plumModalDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: curtainVelvetDeep.withValues(alpha: 0.55),
          blurRadius: 18.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    padding: EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: stagelightSaffron,
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: Text(
                'showDialog',
                style: TextStyle(
                  color: curtainVelvetDeep,
                  fontWeight: FontWeight.w900,
                  fontSize: 12.0,
                  letterSpacing: 0.6,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: spotlightCyan,
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: Text(
                'modal route',
                style: TextStyle(
                  color: curtainVelvetDeep,
                  fontWeight: FontWeight.w900,
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Text(
          'The Dialog Ecosystem',
          style: TextStyle(
            color: theatricalCreamSoft,
            fontWeight: FontWeight.w900,
            fontSize: 26.0,
            letterSpacing: 0.4,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Curtain Velvet x Stagelight Saffron x Plum Modal x Theatrical Cream',
          style: TextStyle(
            color: stagelightSaffronGlow,
            fontStyle: FontStyle.italic,
            fontSize: 13.0,
          ),
        ),
        SizedBox(height: 14.0),
        Text(
          'showDialog pushes a modal route on top of the current Navigator. While the dialog is alive, a barrier scrim dims the page beneath, focus is trapped, and the user must explicitly resolve the dialog before returning to the app. This file dissects every dial that controls that experience: builder, barrier color, dismissibility, safe area, root navigator, route settings.',
          style: TextStyle(
            color: theatricalCreamSoft,
            fontSize: 13.0,
            height: 1.5,
          ),
        ),
        SizedBox(height: 16.0),
        // Mock modal preview: a fake screen with barrier and floating dialog.
        Container(
          height: 200.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: stagelightSaffron.withValues(alpha: 0.4)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: <Widget>[
              // Background "page".
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[theatricalCream, theatricalCreamDeep],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                padding: EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(height: 12.0, width: 110.0, color: curtainVelvet.withValues(alpha: 0.4)),
                    SizedBox(height: 8.0),
                    Container(height: 8.0, width: 220.0, color: curtainVelvet.withValues(alpha: 0.22)),
                    SizedBox(height: 6.0),
                    Container(height: 8.0, width: 180.0, color: curtainVelvet.withValues(alpha: 0.22)),
                    SizedBox(height: 6.0),
                    Container(height: 8.0, width: 200.0, color: curtainVelvet.withValues(alpha: 0.22)),
                    SizedBox(height: 6.0),
                    Container(height: 8.0, width: 90.0, color: curtainVelvet.withValues(alpha: 0.22)),
                  ],
                ),
              ),
              // Barrier.
              Container(color: barrierShadow.withValues(alpha: 0.6)),
              // Floating dialog body.
              Center(
                child: Container(
                  width: 260.0,
                  decoration: BoxDecoration(
                    color: theatricalCream,
                    borderRadius: BorderRadius.circular(14.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: barrierShadow.withValues(alpha: 0.5),
                        blurRadius: 16.0,
                        offset: Offset(0.0, 6.0),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(14.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Confirm action',
                        style: TextStyle(
                          color: curtainVelvetDeep,
                          fontWeight: FontWeight.w900,
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(height: 6.0),
                      Text(
                        'Lower the curtain on this draft? You can re-open it later from the archive.',
                        style: TextStyle(
                          color: curtainVelvet,
                          fontSize: 12.0,
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text('Cancel', style: TextStyle(color: curtainVelvet, fontWeight: FontWeight.w700)),
                          SizedBox(width: 14.0),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                            decoration: BoxDecoration(
                              color: stagelightSaffron,
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Text(
                              'Lower',
                              style: TextStyle(
                                color: curtainVelvetDeep,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          dialogThemeSummary,
          style: TextStyle(
            color: stagelightSaffronGlow,
            fontFamily: 'monospace',
            fontSize: 11.0,
          ),
        ),
        SizedBox(height: 8.0),
        Opacity(
          opacity: AlwaysStoppedAnimation<double>(0.85).value,
          child: Text(
            'Note: real showDialog calls are intentionally omitted here because they return a Future. This demo renders the visual surface only.',
            style: TextStyle(
              color: theatricalCreamDeep,
              fontStyle: FontStyle.italic,
              fontSize: 11.0,
            ),
          ),
        ),
      ],
    ),
  );

  // ------------------------------------------------------------------
  // Compose the body.
  // ------------------------------------------------------------------
  final List<Widget> body = <Widget>[];

  body.add(heroCard);

  body.add(sectionHeader('Palette', 'Theatrical greens, warm cream, and saffron stagelight.'));
  body.add(
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: borderInk.withValues(alpha: 0.25)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: paletteTableRows),
    ),
  );

  body.add(sectionHeader('Palette swatch strip', 'Quick-glance ribbon of every named hue.'));
  body.add(
    SizedBox(
      height: 48.0,
      child: Row(children: swatchStrip),
    ),
  );

  body.add(sectionHeader('showDialog API surface', 'Every parameter that shapes the modal route.'));
  body.add(
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: borderInk.withValues(alpha: 0.25)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: apiTableRows),
    ),
  );

  body.add(sectionHeader('Dialog-type catalog', 'AlertDialog, SimpleDialog, Dialog, DialogTheme, AboutDialog.'));
  body.add(Column(children: dialogTypeCards));

  body.add(sectionHeader('AlertDialog mock preview', 'Title + content + actions; the workhorse confirmation pattern.'));
  body.add(
    Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: barrierShadow.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 360.0),
          child: alertDialogMock,
        ),
      ),
    ),
  );

  body.add(sectionHeader('SimpleDialog mock preview', 'Title + SimpleDialogOption rows for pick-one choices.'));
  body.add(
    Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: plumModalDeep.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 320.0),
          child: simpleDialogMock,
        ),
      ),
    ),
  );

  body.add(sectionHeader('Custom Dialog mock preview', 'Bare modal surface with bespoke layout.'));
  body.add(
    Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: curtainVelvetDeep.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Center(child: bareDialogMock),
    ),
  );

  body.add(sectionHeader('Barrier color comparison', 'Same dialog, eight different scrims.'));
  body.add(Column(children: barrierGalleryTiles));

  body.add(sectionHeader('Button-action patterns', 'How to lay out the actions row.'));
  body.add(Column(children: actionPatternRows));

  body.add(sectionHeader('Accessibility', 'Make modals work for everyone.'));
  body.add(Column(children: accessibilityTiles));

  body.add(sectionHeader('Comparison', 'Dialog vs ModalBottomSheet vs SnackBar vs Banner vs Popup.'));
  body.add(
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: borderInk.withValues(alpha: 0.25)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: comparisonTable),
    ),
  );

  body.add(sectionHeader('Scenario panels', 'Confirm-delete, info, choice list, error, form, picker.'));
  body.add(Column(children: scenarioPanels));

  body.add(sectionHeader('Pitfalls', 'Mistakes that bite when shipping dialogs.'));
  body.add(Column(children: pitfallTiles));

  body.add(sectionHeader('Decision flowchart', 'Dialog vs sheet vs banner: pick the right modality.'));
  body.add(Column(children: decisionTiles));

  body.add(sectionHeader('Theming notes', 'Make every dialog feel like the same family.'));
  body.add(Column(children: themingTiles));

  body.add(sectionHeader('Glossary', 'Vocabulary for talking about modal UI.'));
  body.add(Column(children: glossaryTiles));

  body.add(sectionHeader('Closing prose', 'Why this sample dodges real showDialog calls.'));
  body.add(proseCard(
    'showDialog returns Future<T?>. The d4rt harness in this test forbids Future usage, so this file deliberately renders mock dialog widgets in-line. The constructors of AlertDialog, SimpleDialog, Dialog, DialogTheme, and SimpleDialogOption are still exercised - they are wrapped in try/catch blocks - so the bridge surface is covered without ever pushing a route. A separate integration test that runs in a normal Flutter harness can call the actual showDialog for end-to-end verification.',
  ));
  body.add(proseCard(
    'When you do invoke showDialog in production code, treat it like any other navigation: capture the result, handle the null case, do not assume the caller widget is still mounted. Wrapping the call in a small helper - confirmDestructive(BuildContext, String) -> Future<bool> - keeps your call sites tidy.',
  ));
  body.add(proseCard(
    'Finally, dialogs are interruptions. Every confirm screen is a place the user must stop, read, and decide. Use them only for decisions that genuinely warrant interrupting flow. For everything else, prefer SnackBars, Banners, inline UI, or anchored popups. A theatrical curtain only earns its drama when it falls at the right moment.',
  ));

  body.add(SizedBox(height: 32.0));

  // ------------------------------------------------------------------
  // Final scaffold.
  // ------------------------------------------------------------------
  return Scaffold(
    backgroundColor: theatricalCream,
    appBar: AppBar(
      backgroundColor: curtainVelvetDeep,
      elevation: 4.0,
      title: Text(
        'showDialog: Curtain Velvet Edition',
        style: TextStyle(
          color: stagelightSaffronGlow,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.4,
        ),
      ),
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: body,
      ),
    ),
  );
}

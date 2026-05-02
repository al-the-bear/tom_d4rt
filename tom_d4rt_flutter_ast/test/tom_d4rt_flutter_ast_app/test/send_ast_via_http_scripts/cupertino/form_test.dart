// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Hand-rolled Cupertino form gallery + iOS Settings demo.
// Exercises CupertinoFormSection, CupertinoFormSection.insetGrouped,
// CupertinoFormRow, CupertinoTextFormFieldRow, CupertinoTextField,
// CupertinoSwitch, CupertinoSlider, CupertinoSegmentedControl.
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('Cupertino form_test (settings + anatomy gallery) starting');

  // ---------------------------------------------------------------------------
  // Profile (Half A, Section 1) - live TextEditingControllers.
  // ---------------------------------------------------------------------------
  final profileFullNameController = TextEditingController(
    text: 'Alexis Kyaw',
  );
  final profileEmailController = TextEditingController(
    text: 'alexis@example.com',
  );
  final profileBioController = TextEditingController(
    text: 'Senior dev wandering through Cupertino form widgets.',
  );
  final profileHandleController = TextEditingController(text: '@al_the_bear');
  final profilePhoneController = TextEditingController(
    text: '+1 555 0136',
  );

  // ---------------------------------------------------------------------------
  // Notifications (Half A, Section 2) - bool snapshots.
  // ---------------------------------------------------------------------------
  bool notifyAllow = true;
  bool notifySound = true;
  bool notifyBadge = false;
  bool notifyQuiet = true;
  bool notifyPreviews = false;

  // ---------------------------------------------------------------------------
  // Display (Half A, Section 3) - text size, theme mode, motion.
  // ---------------------------------------------------------------------------
  double displayTextSize = 0.55;
  double displayBrightness = 0.72;
  int displayThemeMode = 1; // 0 = Light, 1 = System, 2 = Dark
  bool displayReduceMotion = false;
  bool displayBoldText = true;

  // ---------------------------------------------------------------------------
  // Account (Half A, Section 4) - read-only key/value rows; just data.
  // ---------------------------------------------------------------------------
  final accountInfo = <List<String>>[
    <String>['Apple ID', 'alexis@example.com'],
    <String>['Region', 'United Kingdom'],
    <String>['Plan', 'Developer Tier (yearly)'],
    <String>['Storage', '184 GB of 200 GB used'],
    <String>['Member since', 'March 2018'],
  ];

  // ---------------------------------------------------------------------------
  // Half B controllers / state.
  // ---------------------------------------------------------------------------
  final galleryFieldA = TextEditingController(text: 'inline editing');
  final galleryFieldB = TextEditingController();
  final galleryFieldC = TextEditingController(text: 'tap to focus');
  final gallerySearchController = TextEditingController(text: 'cupertino');
  final galleryDecoratedController = TextEditingController(
    text: 'custom decoration',
  );
  bool galleryToggleA = true;
  bool galleryToggleB = false;
  double gallerySliderA = 0.42;
  int gallerySegmentA = 1;

  // Tints used to give each section a unique title chip color.
  const Color tintProfile = Color(0xFF3478F6);
  const Color tintNotify = Color(0xFFFF9F0A);
  const Color tintDisplay = Color(0xFF34C759);
  const Color tintAccount = Color(0xFF5E5CE6);
  const Color tintDanger = Color(0xFFFF3B30);
  const Color tintGalleryStock = Color(0xFF00C7BE);
  const Color tintGalleryInset = Color(0xFFAF52DE);
  const Color tintGalleryHeaders = Color(0xFFFF2D55);
  const Color tintGalleryAffix = Color(0xFF30B0C7);
  const Color tintGalleryHelper = Color(0xFF8E8E93);

  Widget sectionTitle(String label, Color tint) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 8.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 6.0,
            height: 22.0,
            decoration: BoxDecoration(
              color: tint,
              borderRadius: BorderRadius.circular(3.0),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
                color: tint,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget caption(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28.0, 4.0, 28.0, 4.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12.5,
          color: Color(0xFF6E6E73),
          height: 1.35,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Half A - Section 1: Profile
  // ---------------------------------------------------------------------------
  final profileSection = CupertinoFormSection.insetGrouped(
    header: const Text('DISPLAY NAME'),
    footer: const Text('Used across the app on every device.'),
    backgroundColor: const Color(0xFFF2F2F7),
    children: <Widget>[
      CupertinoTextFormFieldRow(
        prefix: const Text('Full name'),
        placeholder: 'Your full name',
        controller: profileFullNameController,
        textCapitalization: TextCapitalization.words,
      ),
      CupertinoTextFormFieldRow(
        prefix: const Text('Handle'),
        placeholder: '@username',
        controller: profileHandleController,
        keyboardType: TextInputType.text,
        autocorrect: false,
      ),
      CupertinoTextFormFieldRow(
        prefix: const Text('Email'),
        placeholder: 'name@example.com',
        controller: profileEmailController,
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
      ),
      CupertinoTextFormFieldRow(
        prefix: const Text('Phone'),
        placeholder: '+CC NNN NNNN',
        controller: profilePhoneController,
        keyboardType: TextInputType.phone,
      ),
      CupertinoTextFormFieldRow(
        prefix: const Text('Bio'),
        placeholder: 'A short bio',
        controller: profileBioController,
        maxLines: 3,
        minLines: 2,
        textCapitalization: TextCapitalization.sentences,
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // Half A - Section 2: Notifications
  // ---------------------------------------------------------------------------
  final notificationsSection = CupertinoFormSection.insetGrouped(
    header: const Text('PUSHES & ALERTS'),
    footer: const Text(
      'Quiet hours silences alerts between 22:00 and 07:30 local time.',
    ),
    backgroundColor: const Color(0xFFF2F2F7),
    children: <Widget>[
      CupertinoFormRow(
        prefix: const Text('Allow notifications'),
        helper: const Text('Master switch for all alerts.'),
        child: CupertinoSwitch(
          value: notifyAllow,
          onChanged: (bool v) {
            notifyAllow = v;
            print('notifyAllow -> $v');
          },
        ),
      ),
      CupertinoFormRow(
        prefix: const Text('Sound'),
        child: CupertinoSwitch(
          value: notifySound,
          onChanged: (bool v) {
            notifySound = v;
            print('notifySound -> $v');
          },
        ),
      ),
      CupertinoFormRow(
        prefix: const Text('Badge app icon'),
        child: CupertinoSwitch(
          value: notifyBadge,
          onChanged: (bool v) {
            notifyBadge = v;
            print('notifyBadge -> $v');
          },
        ),
      ),
      CupertinoFormRow(
        prefix: const Text('Show previews'),
        helper: const Text('When unlocked.'),
        child: CupertinoSwitch(
          value: notifyPreviews,
          onChanged: (bool v) {
            notifyPreviews = v;
            print('notifyPreviews -> $v');
          },
        ),
      ),
      CupertinoFormRow(
        prefix: const Text('Quiet hours'),
        child: CupertinoSwitch(
          value: notifyQuiet,
          onChanged: (bool v) {
            notifyQuiet = v;
            print('notifyQuiet -> $v');
          },
        ),
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // Half A - Section 3: Display
  // ---------------------------------------------------------------------------
  final displaySection = CupertinoFormSection.insetGrouped(
    header: const Text('DISPLAY & TEXT'),
    footer: const Text(
      'Theme mode, text size, brightness, and motion preferences.',
    ),
    backgroundColor: const Color(0xFFF2F2F7),
    children: <Widget>[
      CupertinoFormRow(
        prefix: const Text('Theme mode'),
        helper: const Text('Switches the system appearance.'),
        child: SizedBox(
          width: 220.0,
          child: CupertinoSegmentedControl<int>(
            groupValue: displayThemeMode,
            children: const <int, Widget>{
              0: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('Light'),
              ),
              1: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('System'),
              ),
              2: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('Dark'),
              ),
            },
            onValueChanged: (int value) {
              displayThemeMode = value;
              print('displayThemeMode -> $value');
            },
          ),
        ),
      ),
      CupertinoFormRow(
        prefix: const Text('Text size'),
        helper: const Text('Drag to preview the dynamic-type scale.'),
        child: SizedBox(
          width: 200.0,
          child: CupertinoSlider(
            value: displayTextSize,
            min: 0.0,
            max: 1.0,
            divisions: 8,
            onChanged: (double v) {
              displayTextSize = v;
              print('displayTextSize -> ${v.toStringAsFixed(2)}');
            },
          ),
        ),
      ),
      CupertinoFormRow(
        prefix: const Text('Brightness'),
        child: SizedBox(
          width: 200.0,
          child: CupertinoSlider(
            value: displayBrightness,
            min: 0.0,
            max: 1.0,
            onChanged: (double v) {
              displayBrightness = v;
              print('displayBrightness -> ${v.toStringAsFixed(2)}');
            },
          ),
        ),
      ),
      CupertinoFormRow(
        prefix: const Text('Bold text'),
        child: CupertinoSwitch(
          value: displayBoldText,
          onChanged: (bool v) {
            displayBoldText = v;
            print('displayBoldText -> $v');
          },
        ),
      ),
      CupertinoFormRow(
        prefix: const Text('Reduce motion'),
        helper: const Text('Limits parallax and zoom transitions.'),
        child: CupertinoSwitch(
          value: displayReduceMotion,
          onChanged: (bool v) {
            displayReduceMotion = v;
            print('displayReduceMotion -> $v');
          },
        ),
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // Half A - Section 4: Account (read-only key/value rows)
  // ---------------------------------------------------------------------------
  final accountChildren = <Widget>[];
  for (final List<String> row in accountInfo) {
    accountChildren.add(
      CupertinoFormRow(
        prefix: Text(row[0]),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Text(
            row[1],
            style: const TextStyle(
              color: Color(0xFF8E8E93),
              fontSize: 15.0,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ),
    );
  }
  final accountSection = CupertinoFormSection.insetGrouped(
    header: const Text('ACCOUNT'),
    footer: const Text(
      'Read-only metadata. Manage details from the Apple ID page.',
    ),
    backgroundColor: const Color(0xFFF2F2F7),
    children: accountChildren,
  );

  // ---------------------------------------------------------------------------
  // Half A - Section 5: Danger zone
  // ---------------------------------------------------------------------------
  Widget dangerRow(String label, String trailing) {
    return CupertinoFormRow(
      prefix: Text(
        label,
        style: const TextStyle(
          color: Color(0xFFFF3B30),
          fontWeight: FontWeight.w500,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              trailing,
              style: const TextStyle(
                color: Color(0xFFFF3B30),
                fontSize: 14.0,
              ),
            ),
            const SizedBox(width: 6.0),
            const Icon(
              CupertinoIcons.chevron_forward,
              size: 16.0,
              color: Color(0xFFFF3B30),
            ),
          ],
        ),
      ),
    );
  }

  final dangerSection = CupertinoFormSection.insetGrouped(
    header: const Text('DANGER ZONE'),
    footer: const Text(
      'These actions are destructive and cannot be undone. Demonstration only.',
    ),
    backgroundColor: const Color(0xFFF2F2F7),
    children: <Widget>[
      dangerRow('Sign out everywhere', 'Sign out'),
      dangerRow('Reset preferences', 'Reset'),
      dangerRow('Erase all content', 'Erase'),
      dangerRow('Delete account', 'Delete'),
    ],
  );

  // ---------------------------------------------------------------------------
  // Half B - Section 6: Stock vs insetGrouped side-by-side.
  // ---------------------------------------------------------------------------
  final stockSection = CupertinoFormSection(
    header: const Text('STOCK'),
    footer: const Text(
      'Plain CupertinoFormSection: edge-to-edge, no rounded inset card.',
    ),
    children: <Widget>[
      CupertinoTextFormFieldRow(
        prefix: const Text('Field A'),
        placeholder: 'edge-to-edge',
        controller: galleryFieldA,
      ),
      CupertinoTextFormFieldRow(
        prefix: const Text('Field B'),
        placeholder: 'placeholder',
        controller: galleryFieldB,
      ),
      CupertinoFormRow(
        prefix: const Text('Toggle'),
        child: CupertinoSwitch(
          value: galleryToggleA,
          onChanged: (bool v) {
            galleryToggleA = v;
            print('galleryToggleA -> $v');
          },
        ),
      ),
    ],
  );

  final insetSection = CupertinoFormSection.insetGrouped(
    header: const Text('INSET GROUPED'),
    footer: const Text(
      'Same content using CupertinoFormSection.insetGrouped: rounded card on a tinted backdrop.',
    ),
    backgroundColor: const Color(0xFFF2F2F7),
    children: <Widget>[
      CupertinoTextFormFieldRow(
        prefix: const Text('Field A'),
        placeholder: 'inset',
        controller: galleryFieldC,
      ),
      CupertinoTextFormFieldRow(
        prefix: const Text('Field B'),
        placeholder: 'placeholder',
      ),
      CupertinoFormRow(
        prefix: const Text('Toggle'),
        child: CupertinoSwitch(
          value: galleryToggleB,
          onChanged: (bool v) {
            galleryToggleB = v;
            print('galleryToggleB -> $v');
          },
        ),
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // Half B - Section 7: Header / footer combinations.
  // ---------------------------------------------------------------------------
  final headerOnlySection = CupertinoFormSection.insetGrouped(
    header: const Text('HEADER ONLY'),
    backgroundColor: const Color(0xFFF2F2F7),
    children: const <Widget>[
      CupertinoFormRow(
        prefix: Text('Variant'),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.0),
          child: Text(
            'header set, footer absent',
            style: TextStyle(color: Color(0xFF8E8E93)),
          ),
        ),
      ),
    ],
  );

  final footerOnlySection = CupertinoFormSection.insetGrouped(
    footer: const Text('Footer only - no header text above this card.'),
    backgroundColor: const Color(0xFFF2F2F7),
    children: const <Widget>[
      CupertinoFormRow(
        prefix: Text('Variant'),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.0),
          child: Text(
            'header absent, footer set',
            style: TextStyle(color: Color(0xFF8E8E93)),
          ),
        ),
      ),
    ],
  );

  final bothSection = CupertinoFormSection.insetGrouped(
    header: const Text('BOTH'),
    footer: const Text('Both header and footer slots in use.'),
    backgroundColor: const Color(0xFFF2F2F7),
    children: const <Widget>[
      CupertinoFormRow(
        prefix: Text('Variant'),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.0),
          child: Text(
            'header + footer',
            style: TextStyle(color: Color(0xFF8E8E93)),
          ),
        ),
      ),
    ],
  );

  final neitherSection = CupertinoFormSection.insetGrouped(
    backgroundColor: const Color(0xFFF2F2F7),
    children: const <Widget>[
      CupertinoFormRow(
        prefix: Text('Variant'),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.0),
          child: Text(
            'no header, no footer',
            style: TextStyle(color: Color(0xFF8E8E93)),
          ),
        ),
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // Half B - Section 8: Affix combinations (prefix only / suffix only / both / child only).
  // CupertinoFormRow doesn't have a "suffix" slot, so suffix-style content is
  // expressed via the `child` slot aligned to the trailing edge.
  // ---------------------------------------------------------------------------
  final affixSection = CupertinoFormSection.insetGrouped(
    header: const Text('PREFIX & TRAILING CHILD'),
    footer: const Text(
      'Different combinations of prefix slot and child-as-trailing affix.',
    ),
    backgroundColor: const Color(0xFFF2F2F7),
    children: <Widget>[
      CupertinoFormRow(
        prefix: const Text('Prefix only'),
        child: const SizedBox.shrink(),
      ),
      CupertinoFormRow(
        prefix: const SizedBox.shrink(),
        child: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: const Text(
            'trailing only (child)',
            style: TextStyle(color: Color(0xFF8E8E93)),
          ),
        ),
      ),
      CupertinoFormRow(
        prefix: const Text('Prefix + child'),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Text(
                'value',
                style: TextStyle(color: Color(0xFF8E8E93)),
              ),
              SizedBox(width: 6.0),
              Icon(
                CupertinoIcons.chevron_forward,
                size: 16.0,
                color: Color(0xFFC7C7CC),
              ),
            ],
          ),
        ),
      ),
      CupertinoFormRow(
        prefix: const SizedBox.shrink(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: const Text(
            'child-only row, no prefix',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // Half B - Section 9: Helper / error variations.
  // ---------------------------------------------------------------------------
  final helperErrorSection = CupertinoFormSection.insetGrouped(
    header: const Text('HELPER & ERROR'),
    footer: const Text(
      'CupertinoFormRow exposes both helper and error slots; error overrides helper.',
    ),
    backgroundColor: const Color(0xFFF2F2F7),
    children: <Widget>[
      CupertinoFormRow(
        prefix: const Text('Helper text'),
        helper: const Text('Helpful supporting copy below the row.'),
        child: CupertinoTextField(
          placeholder: 'with helper',
          controller: TextEditingController(text: 'looks fine'),
        ),
      ),
      CupertinoFormRow(
        prefix: const Text('Error (Text)'),
        helper: const Text('Helper still set, but error wins.'),
        error: const Text('This field is required.'),
        child: CupertinoTextField(
          placeholder: 'required',
          controller: TextEditingController(),
        ),
      ),
      CupertinoFormRow(
        prefix: const Text('Error (styled)'),
        error: const Text(
          'Email format looks invalid.',
          style: TextStyle(
            color: Color(0xFFFF3B30),
            fontWeight: FontWeight.w600,
          ),
        ),
        child: CupertinoTextField(
          placeholder: 'name@example',
          controller: TextEditingController(text: 'not-an-email'),
        ),
      ),
      CupertinoFormRow(
        prefix: const Text('Error (Widget)'),
        error: Row(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Icon(
              CupertinoIcons.exclamationmark_triangle_fill,
              color: Color(0xFFFF9500),
              size: 14.0,
            ),
            SizedBox(width: 4.0),
            Text(
              'Composite widget error',
              style: TextStyle(color: Color(0xFFFF3B30)),
            ),
          ],
        ),
        child: CupertinoTextField(
          placeholder: 'composite error',
          controller: TextEditingController(text: 'value'),
        ),
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // Half B - Section 10: Decoration override.
  // ---------------------------------------------------------------------------
  final decoratedSection = CupertinoFormSection(
    header: const Text('CUSTOM DECORATION'),
    footer: const Text(
      'CupertinoFormSection.decoration overrides the default container.',
    ),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFFFFD60A), width: 1.5),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33FFD60A),
          blurRadius: 12.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    margin: const EdgeInsets.symmetric(horizontal: 20.0),
    children: <Widget>[
      CupertinoTextFormFieldRow(
        prefix: const Text('Tint'),
        placeholder: 'amber section',
        controller: galleryDecoratedController,
      ),
      CupertinoFormRow(
        prefix: const Text('Notifies'),
        child: CupertinoSwitch(
          value: true,
          onChanged: (bool v) {
            print('decoratedSwitch -> $v');
          },
        ),
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // Half B - Section 11: Child gallery (TextField, Switch, Slider, Segmented, Text).
  // ---------------------------------------------------------------------------
  final childGallerySection = CupertinoFormSection.insetGrouped(
    header: const Text('ROW CHILD VARIANTS'),
    footer: const Text(
      'CupertinoFormRow.child can host any widget. Five live examples here.',
    ),
    backgroundColor: const Color(0xFFF2F2F7),
    children: <Widget>[
      CupertinoFormRow(
        prefix: const Text('CupertinoTextField'),
        child: SizedBox(
          width: 180.0,
          child: CupertinoTextField(
            placeholder: 'inline text field',
            controller: gallerySearchController,
            clearButtonMode: OverlayVisibilityMode.editing,
            prefix: const Padding(
              padding: EdgeInsets.only(left: 6.0),
              child: Icon(
                CupertinoIcons.search,
                size: 16.0,
                color: Color(0xFF8E8E93),
              ),
            ),
          ),
        ),
      ),
      CupertinoFormRow(
        prefix: const Text('CupertinoSwitch'),
        child: CupertinoSwitch(
          value: galleryToggleA,
          onChanged: (bool v) {
            galleryToggleA = v;
            print('childGallerySwitch -> $v');
          },
        ),
      ),
      CupertinoFormRow(
        prefix: const Text('CupertinoSlider'),
        child: SizedBox(
          width: 200.0,
          child: CupertinoSlider(
            value: gallerySliderA,
            min: 0.0,
            max: 1.0,
            divisions: 10,
            onChanged: (double v) {
              gallerySliderA = v;
              print('gallerySliderA -> ${v.toStringAsFixed(2)}');
            },
          ),
        ),
      ),
      CupertinoFormRow(
        prefix: const Text('SegmentedControl'),
        child: SizedBox(
          width: 220.0,
          child: CupertinoSegmentedControl<int>(
            groupValue: gallerySegmentA,
            children: const <int, Widget>{
              0: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text('Daily'),
              ),
              1: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text('Weekly'),
              ),
              2: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text('Monthly'),
              ),
            },
            onValueChanged: (int v) {
              gallerySegmentA = v;
              print('gallerySegmentA -> $v');
            },
          ),
        ),
      ),
      CupertinoFormRow(
        prefix: const Text('Plain Text'),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 6.0),
          child: Text(
            'just a Text widget',
            style: TextStyle(color: Color(0xFF8E8E93)),
          ),
        ),
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 12: Text-input flavor strip - showcases the major
  // CupertinoTextFormFieldRow knobs in one short list.
  // ---------------------------------------------------------------------------
  final textInputFlavorSection = CupertinoFormSection.insetGrouped(
    header: const Text('TEXT INPUT FLAVORS'),
    footer: const Text(
      'CupertinoTextFormFieldRow with various keyboard, capitalization and obscure settings.',
    ),
    backgroundColor: const Color(0xFFF2F2F7),
    children: <Widget>[
      CupertinoTextFormFieldRow(
        prefix: const Text('Email'),
        placeholder: 'name@example.com',
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        autocorrect: false,
        controller: TextEditingController(),
      ),
      CupertinoTextFormFieldRow(
        prefix: const Text('Password'),
        placeholder: '••••••••',
        obscureText: true,
        autocorrect: false,
        controller: TextEditingController(),
      ),
      CupertinoTextFormFieldRow(
        prefix: const Text('Phone'),
        placeholder: '+CC NNN NNNN',
        keyboardType: TextInputType.phone,
        controller: TextEditingController(),
      ),
      CupertinoTextFormFieldRow(
        prefix: const Text('Pin'),
        placeholder: '0000',
        keyboardType: TextInputType.number,
        maxLength: 4,
        textAlign: TextAlign.right,
        controller: TextEditingController(text: '4242'),
      ),
      CupertinoTextFormFieldRow(
        prefix: const Text('Notes'),
        placeholder: 'Multi-line notes...',
        controller: TextEditingController(),
        maxLines: 4,
        minLines: 2,
        textCapitalization: TextCapitalization.sentences,
      ),
      CupertinoTextFormFieldRow(
        prefix: const Text('Read only'),
        controller: TextEditingController(text: 'cannot be edited'),
        readOnly: true,
        style: const TextStyle(color: Color(0xFF8E8E93)),
      ),
      CupertinoTextFormFieldRow(
        prefix: const Text('Disabled'),
        placeholder: 'cannot edit',
        enabled: false,
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // Build the page tree. Stitched together top-to-bottom in a Column.
  // ---------------------------------------------------------------------------
  final pageColumn = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      // ----- Page header banner -----
      Container(
        padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 16.0),
        margin: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 4.0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: <Color>[
              Color(0xFF3478F6),
              Color(0xFF5E5CE6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              'Cupertino Form Gallery',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              'A complete iOS Settings demo plus a row anatomy gallery.',
              style: TextStyle(
                fontSize: 14.0,
                color: Color(0xCCFFFFFF),
              ),
            ),
          ],
        ),
      ),

      // ===== HALF A =====
      sectionTitle('A.1  Profile', tintProfile),
      caption(
        'CupertinoFormSection.insetGrouped with five CupertinoTextFormFieldRow '
        'rows, each backed by a live TextEditingController.',
      ),
      profileSection,

      sectionTitle('A.2  Notifications', tintNotify),
      caption(
        'CupertinoFormRow with prefix Text and a CupertinoSwitch child for '
        'each setting; some rows also use the helper slot.',
      ),
      notificationsSection,

      sectionTitle('A.3  Display', tintDisplay),
      caption(
        'Mixed children: CupertinoSegmentedControl<int> for theme mode, '
        'two CupertinoSliders, and bool switches for bold/reduce-motion.',
      ),
      displaySection,

      sectionTitle('A.4  Account', tintAccount),
      caption(
        'Read-only key/value rows. Each child slot is just a Text widget '
        'aligned to the trailing edge.',
      ),
      accountSection,

      sectionTitle('A.5  Danger zone', tintDanger),
      caption(
        'Destructive-styled rows: red prefix Text, red trailing label, and '
        'a chevron icon - no actions wired, just the visual pattern.',
      ),
      dangerSection,

      // ===== ANATOMY HEADER =====
      Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 32.0, 20.0, 8.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                'Half B - Form-row anatomy',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'Side-by-side variants showing how header, footer, prefix, '
                'helper, error, decoration, and child slots interact.',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Color(0xCCFFFFFF),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),

      // ===== HALF B =====
      sectionTitle('B.1  Stock vs insetGrouped', tintGalleryStock),
      caption(
        'Plain CupertinoFormSection (no rounded card) above '
        'CupertinoFormSection.insetGrouped (rounded inset card on tinted bg).',
      ),
      stockSection,
      const SizedBox(height: 8.0),
      Container(
        color: const Color(0xFFF2F2F7),
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: insetSection,
      ),

      sectionTitle('B.2  Header / footer combos', tintGalleryInset),
      caption(
        'Four mini-sections demonstrating header-only, footer-only, both, and neither.',
      ),
      headerOnlySection,
      footerOnlySection,
      bothSection,
      neitherSection,

      sectionTitle('B.3  Prefix / trailing affix', tintGalleryHeaders),
      caption(
        'CupertinoFormRow does not have a suffix slot; trailing affixes go '
        'inside the child. This card shows prefix-only, trailing-only, '
        'prefix+trailing, and child-only rows.',
      ),
      affixSection,

      sectionTitle('B.4  Helper & error', tintGalleryAffix),
      caption(
        'Helper text, plain error Text, styled error Text, and a composite '
        'Widget passed as the error slot.',
      ),
      helperErrorSection,

      sectionTitle('B.5  Custom decoration', tintGalleryHelper),
      caption(
        'CupertinoFormSection with a custom decoration: amber background, '
        'bordered, with a soft shadow.',
      ),
      decoratedSection,

      sectionTitle('B.6  Row child variants', tintGalleryStock),
      caption(
        'A single section that uses every common child widget kind '
        'inside CupertinoFormRow.',
      ),
      childGallerySection,

      sectionTitle('B.7  Text input flavors', tintGalleryInset),
      caption(
        'CupertinoTextFormFieldRow with email, password, phone, pin, notes, '
        'read-only, and disabled flavors.',
      ),
      textInputFlavorSection,

      // ----- Footer -----
      Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 32.0),
        child: Center(
          child: Text(
            'Cupertino form_test - hand-rolled, ${DateTime.now().toIso8601String().substring(0, 10)}',
            style: const TextStyle(
              fontSize: 12.0,
              color: Color(0xFF8E8E93),
            ),
          ),
        ),
      ),
    ],
  );

  print('Cupertino form_test build tree assembled');

  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Settings & Form Anatomy'),
        previousPageTitle: 'Back',
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 24.0),
          // Toolbar import is intentional for ClipboardData-style services use
          // in adjacent demos; keep CupertinoTextField fully wired.
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: pageColumn,
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Tiny utility kept at top level so build() stays a leaf callable.
// Demonstrates that we can also reference `package:flutter/services.dart`
// (via SystemUiOverlayStyle) without crashing the harness; we don't apply it
// here because CupertinoApp manages its own overlays.
// ---------------------------------------------------------------------------
SystemUiOverlayStyle _previewOverlayStyle() {
  return const SystemUiOverlayStyle(
    statusBarColor: Color(0x00000000),
    statusBarIconBrightness: Brightness.dark,
  );
}

// Reference the helper to ensure the import is "used" without altering the
// returned tree. Called once at script load; no side effects.
final SystemUiOverlayStyle _kPreviewOverlay = _previewOverlayStyle();

// Touch the constant to avoid unused_element warnings in pedantic configs.
// ignore: unused_element
SystemUiOverlayStyle get _kPreviewOverlayRef => _kPreviewOverlay;

// Reference the prefixed widgets import so it stays meaningful. We expose a
// no-op typedef-like getter that returns the raw Widget type from
// package:flutter/widgets.dart, distinct from the Cupertino re-export.
// ignore: unused_element
Type get _widgetsTypeProbe => widgets.Widget;

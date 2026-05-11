// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, prefer_interpolation_to_compose_strings, use_full_hex_values_for_flutter_colors, dead_code
// D4rt Deep Visual Demo: SemanticsProperties
// =============================================================================
// A hand-crafted, instructive test script that documents and demonstrates the
// `SemanticsProperties` data class from `package:flutter/semantics.dart`.
//
// `SemanticsProperties` is the structured payload of attributes that the
// framework attaches to a `SemanticsNode` when a `Semantics` widget participates
// in the accessibility tree.  It is essentially a value-object describing
// *what a node means* to screen readers, switch control, voice navigation and
// other assistive technology.  This script renders the full surface of that
// class as a series of visual cards, tables, and live `Semantics` widget
// usages so a reader can see every facet at once.
// =============================================================================
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

dynamic build(BuildContext context) {
  // ===========================================================================
  // SECTION 1: DOSSIER
  // ---------------------------------------------------------------------------
  // High level orientation for the reader of this demo.
  // ===========================================================================

  final dossier = <Map<String, String>>[
    {
      'field': 'Class',
      'value': 'SemanticsProperties',
    },
    {
      'field': 'Library',
      'value': 'package:flutter/semantics.dart',
    },
    {
      'field': 'Role',
      'value': 'Data carrier for accessibility annotations',
    },
    {
      'field': 'Used by',
      'value': 'Semantics widget, MergeSemantics, custom render objects',
    },
    {
      'field': 'Reads to',
      'value': 'SemanticsNode in the SemanticsTree',
    },
    {
      'field': 'Consumers',
      'value': 'TalkBack, VoiceOver, NVDA, Switch Control',
    },
    {
      'field': 'Mutability',
      'value': 'Immutable value object (const-friendly)',
    },
    {
      'field': 'Construction',
      'value': 'All fields named and optional',
    },
    {
      'field': 'Pair with',
      'value': 'SemanticsTag, OrdinalSortKey, SemanticsHintOverrides',
    },
    {
      'field': 'Lifecycle',
      'value': 'Rebuilt on every Semantics widget rebuild',
    },
  ];

  print('=== SemanticsProperties dossier ===');
  for (final row in dossier) {
    print('  ${row['field']}: ${row['value']}');
  }

  // ===========================================================================
  // SECTION 2: ANATOMY
  // ---------------------------------------------------------------------------
  // Three lookup tables:
  //   * boolean flags        (role / state)
  //   * string-like fields   (label/value/hint/...)
  //   * action callbacks     (onTap/onScrollUp/...)
  // ===========================================================================

  final flagTable = <Map<String, String>>[
    {
      'flag': 'enabled',
      'meaning': 'Whether the control accepts input',
    },
    {
      'flag': 'checked',
      'meaning': 'Tri-state for checkboxes / toggle controls',
    },
    {
      'flag': 'mixed',
      'meaning': 'Indeterminate checkbox state',
    },
    {
      'flag': 'selected',
      'meaning': 'Highlighted member of a selection set',
    },
    {
      'flag': 'toggled',
      'meaning': 'Switch-style toggle on/off',
    },
    {
      'flag': 'button',
      'meaning': 'Marks the node as a pressable button',
    },
    {
      'flag': 'link',
      'meaning': 'Marks the node as a hyperlink',
    },
    {
      'flag': 'header',
      'meaning': 'Heading level node for navigation',
    },
    {
      'flag': 'textField',
      'meaning': 'Editable text input',
    },
    {
      'flag': 'readOnly',
      'meaning': 'Editable but currently locked',
    },
    {
      'flag': 'focusable',
      'meaning': 'Node may receive accessibility focus',
    },
    {
      'flag': 'focused',
      'meaning': 'Node currently has accessibility focus',
    },
    {
      'flag': 'inMutuallyExclusiveGroup',
      'meaning': 'Member of radio-style group',
    },
    {
      'flag': 'obscured',
      'meaning': 'Hidden text (e.g., password field)',
    },
    {
      'flag': 'multiline',
      'meaning': 'Multi-line text content',
    },
    {
      'flag': 'scopesRoute',
      'meaning': 'Boundary of a Route',
    },
    {
      'flag': 'namesRoute',
      'meaning': 'Provides the name for a Route',
    },
    {
      'flag': 'hidden',
      'meaning': 'Drop the node from a11y tree but keep painting',
    },
    {
      'flag': 'image',
      'meaning': 'Node represents an image',
    },
    {
      'flag': 'liveRegion',
      'meaning': 'Announce content changes automatically',
    },
    {
      'flag': 'slider',
      'meaning': 'Node is a slider-shaped control',
    },
    {
      'flag': 'keyboardKey',
      'meaning': 'On-screen keyboard key',
    },
    {
      'flag': 'expanded',
      'meaning': 'Disclosure currently expanded',
    },
  ];

  final stringTable = <Map<String, String>>[
    {
      'field': 'label',
      'meaning': 'Short descriptive name announced first',
    },
    {
      'field': 'value',
      'meaning': 'Current value (e.g., slider position)',
    },
    {
      'field': 'hint',
      'meaning': 'Action hint shown after label/value',
    },
    {
      'field': 'increasedValue',
      'meaning': 'Value after onIncrease executes',
    },
    {
      'field': 'decreasedValue',
      'meaning': 'Value after onDecrease executes',
    },
    {
      'field': 'tooltip',
      'meaning': 'Tooltip-style helper text',
    },
    {
      'field': 'attributedLabel',
      'meaning': 'Label with locale/spell-out spans',
    },
    {
      'field': 'attributedValue',
      'meaning': 'Value with locale/spell-out spans',
    },
    {
      'field': 'attributedHint',
      'meaning': 'Hint with locale/spell-out spans',
    },
    {
      'field': 'attributedIncreasedValue',
      'meaning': 'Increased value with attributes',
    },
    {
      'field': 'attributedDecreasedValue',
      'meaning': 'Decreased value with attributes',
    },
    {
      'field': 'textDirection',
      'meaning': 'Reading direction for the strings',
    },
  ];

  final actionTable = <Map<String, String>>[
    {
      'action': 'onTap',
      'meaning': 'Single tap activation',
    },
    {
      'action': 'onLongPress',
      'meaning': 'Long press (context menu)',
    },
    {
      'action': 'onScrollLeft',
      'meaning': 'Pan / fling left',
    },
    {
      'action': 'onScrollRight',
      'meaning': 'Pan / fling right',
    },
    {
      'action': 'onScrollUp',
      'meaning': 'Pan / fling up',
    },
    {
      'action': 'onScrollDown',
      'meaning': 'Pan / fling down',
    },
    {
      'action': 'onIncrease',
      'meaning': 'Step value up',
    },
    {
      'action': 'onDecrease',
      'meaning': 'Step value down',
    },
    {
      'action': 'onCopy',
      'meaning': 'Copy selected content',
    },
    {
      'action': 'onCut',
      'meaning': 'Cut selected content',
    },
    {
      'action': 'onPaste',
      'meaning': 'Paste clipboard content',
    },
    {
      'action': 'onMoveCursorForwardByCharacter',
      'meaning': 'Step caret right one character',
    },
    {
      'action': 'onMoveCursorBackwardByCharacter',
      'meaning': 'Step caret left one character',
    },
    {
      'action': 'onSetText',
      'meaning': 'Replace the entire text content',
    },
    {
      'action': 'onSetSelection',
      'meaning': 'Set selection range',
    },
    {
      'action': 'onDidGainAccessibilityFocus',
      'meaning': 'A11y focus arrived',
    },
    {
      'action': 'onDidLoseAccessibilityFocus',
      'meaning': 'A11y focus left',
    },
    {
      'action': 'onDismiss',
      'meaning': 'Dismiss the node (snackbar / dialog)',
    },
  ];

  print('Flag rows: ${flagTable.length}');
  print('String field rows: ${stringTable.length}');
  print('Action rows: ${actionTable.length}');

  // ===========================================================================
  // SECTION 3: BOOLEAN FLAGS GALLERY
  // ---------------------------------------------------------------------------
  // 12+ SemanticsProperties variants demonstrating distinct role flags.
  // ===========================================================================

  final galleryButton = SemanticsProperties(
    label: 'Submit',
    button: true,
    enabled: true,
    focusable: true,
  );

  final galleryLink = SemanticsProperties(
    label: 'Open documentation',
    link: true,
    enabled: true,
    focusable: true,
  );

  final galleryHeader = SemanticsProperties(
    label: 'Section: Accessibility',
    header: true,
  );

  final galleryCheckedBox = SemanticsProperties(
    label: 'Subscribe to newsletter',
    checked: true,
    enabled: true,
    focusable: true,
  );

  final galleryUncheckedBox = SemanticsProperties(
    label: 'Accept terms',
    checked: false,
    enabled: true,
    focusable: true,
  );

  final galleryToggleOn = SemanticsProperties(
    label: 'Wi-Fi',
    toggled: true,
    enabled: true,
    focusable: true,
  );

  final galleryToggleOff = SemanticsProperties(
    label: 'Bluetooth',
    toggled: false,
    enabled: true,
    focusable: true,
  );

  final gallerySelected = SemanticsProperties(
    label: 'Tab: Inbox',
    selected: true,
    button: true,
  );

  final galleryTextField = SemanticsProperties(
    label: 'Email',
    textField: true,
    enabled: true,
    multiline: false,
    focusable: true,
  );

  final galleryObscured = SemanticsProperties(
    label: 'Password',
    textField: true,
    obscured: true,
    enabled: true,
  );

  final galleryReadOnly = SemanticsProperties(
    label: 'Total',
    value: r'$24.99',
    textField: true,
    readOnly: true,
  );

  final galleryImage = SemanticsProperties(
    label: 'Profile photo',
    image: true,
  );

  final galleryLiveRegion = SemanticsProperties(
    label: 'Live score',
    value: '2-1',
    liveRegion: true,
  );

  final gallerySlider = SemanticsProperties(
    label: 'Volume',
    value: '60%',
    increasedValue: '70%',
    decreasedValue: '50%',
    slider: true,
  );

  final galleryExpanded = SemanticsProperties(
    label: 'Advanced options',
    expanded: true,
    button: true,
  );

  final galleryHidden = SemanticsProperties(
    label: 'Decorative dot',
    hidden: true,
  );

  final galleryKeyboard = SemanticsProperties(
    label: 'A',
    keyboardKey: true,
    button: true,
  );

  final gallery = <_GalleryEntry>[
    _GalleryEntry('Button', galleryButton, Color(0xFF1976D2)),
    _GalleryEntry('Link', galleryLink, Color(0xFF7B1FA2)),
    _GalleryEntry('Header', galleryHeader, Color(0xFF455A64)),
    _GalleryEntry('Checkbox (checked)', galleryCheckedBox, Color(0xFF388E3C)),
    _GalleryEntry('Checkbox (unchecked)', galleryUncheckedBox,
        Color(0xFF8D6E63)),
    _GalleryEntry('Switch (on)', galleryToggleOn, Color(0xFF00897B)),
    _GalleryEntry('Switch (off)', galleryToggleOff, Color(0xFF607D8B)),
    _GalleryEntry('Selected tab', gallerySelected, Color(0xFFD81B60)),
    _GalleryEntry('TextField', galleryTextField, Color(0xFF512DA8)),
    _GalleryEntry('Obscured field', galleryObscured, Color(0xFF303F9F)),
    _GalleryEntry('Read-only field', galleryReadOnly, Color(0xFF5D4037)),
    _GalleryEntry('Image', galleryImage, Color(0xFFE64A19)),
    _GalleryEntry('Live region', galleryLiveRegion, Color(0xFFC2185B)),
    _GalleryEntry('Slider', gallerySlider, Color(0xFF0288D1)),
    _GalleryEntry('Expanded disclosure', galleryExpanded, Color(0xFF6A1B9A)),
    _GalleryEntry('Hidden node', galleryHidden, Color(0xFF424242)),
    _GalleryEntry('Keyboard key', galleryKeyboard, Color(0xFF00695C)),
  ];

  print('Gallery entries: ${gallery.length}');

  // ===========================================================================
  // SECTION 4: ACTION CALLBACKS
  // ---------------------------------------------------------------------------
  // SemanticsProperties with action callbacks wired.  Listing the *names* of
  // bound actions is the bit we visualize.
  // ===========================================================================

  final tapAction = SemanticsProperties(
    label: 'Action: tap',
    button: true,
    enabled: true,
    onTap: () => print('onTap fired'),
  );

  final longPressAction = SemanticsProperties(
    label: 'Action: long press',
    button: true,
    enabled: true,
    onTap: () => print('tap'),
    onLongPress: () => print('long press'),
  );

  final scrollableAction = SemanticsProperties(
    label: 'Scrollable region',
    onScrollUp: () => print('scroll up'),
    onScrollDown: () => print('scroll down'),
    onScrollLeft: () => print('scroll left'),
    onScrollRight: () => print('scroll right'),
  );

  final adjustableAction = SemanticsProperties(
    label: 'Brightness',
    value: '40%',
    increasedValue: '50%',
    decreasedValue: '30%',
    slider: true,
    onIncrease: () => print('increase'),
    onDecrease: () => print('decrease'),
  );

  final clipboardAction = SemanticsProperties(
    label: 'Selected text',
    textField: true,
    onCopy: () => print('copy'),
    onCut: () => print('cut'),
    onPaste: () => print('paste'),
  );

  final caretAction = SemanticsProperties(
    label: 'Caret control',
    textField: true,
    onMoveCursorForwardByCharacter: (extend) => print('caret> $extend'),
    onMoveCursorBackwardByCharacter: (extend) => print('caret< $extend'),
    onSetSelection: (range) => print('set selection $range'),
    onSetText: (text) => print('set text $text'),
  );

  final focusAction = SemanticsProperties(
    label: 'Focus aware',
    onDidGainAccessibilityFocus: () => print('focus gained'),
    onDidLoseAccessibilityFocus: () => print('focus lost'),
  );

  final dismissAction = SemanticsProperties(
    label: 'Dismissable',
    onDismiss: () => print('dismiss'),
  );

  final actionConfigurations = <_ActionEntry>[
    _ActionEntry('Tap only', tapAction, ['onTap']),
    _ActionEntry('Tap + long press', longPressAction, ['onTap', 'onLongPress']),
    _ActionEntry('Scrollable', scrollableAction,
        ['onScrollUp', 'onScrollDown', 'onScrollLeft', 'onScrollRight']),
    _ActionEntry(
        'Adjustable slider', adjustableAction, ['onIncrease', 'onDecrease']),
    _ActionEntry('Clipboard', clipboardAction, ['onCopy', 'onCut', 'onPaste']),
    _ActionEntry('Caret + text', caretAction, [
      'onMoveCursorForwardByCharacter',
      'onMoveCursorBackwardByCharacter',
      'onSetSelection',
      'onSetText',
    ]),
    _ActionEntry('Focus', focusAction,
        ['onDidGainAccessibilityFocus', 'onDidLoseAccessibilityFocus']),
    _ActionEntry('Dismissable', dismissAction, ['onDismiss']),
  ];

  print('Action configurations: ${actionConfigurations.length}');

  // ===========================================================================
  // SECTION 5: ATTRIBUTED STRING VARIANTS
  // ---------------------------------------------------------------------------
  // AttributedString lets us pin spans of locale and spell-out semantics into a
  // label.  This is how screen readers know to say "F-A-Q" instead of "fack".
  // ===========================================================================

  final localeAttribute = LocaleStringAttribute(
    range: TextRange(start: 0, end: 5),
    locale: Locale('en', 'US'),
  );

  final spellOutAttribute = SpellOutStringAttribute(
    range: TextRange(start: 6, end: 9),
  );

  final attributedLabel = AttributedString(
    'Hello FAQ section',
    attributes: <StringAttribute>[localeAttribute, spellOutAttribute],
  );

  final germanLocale = LocaleStringAttribute(
    range: TextRange(start: 0, end: 7),
    locale: Locale('de', 'DE'),
  );
  final attributedValueGerman = AttributedString(
    'Guten Tag',
    attributes: <StringAttribute>[germanLocale],
  );

  final hintSpellOut = SpellOutStringAttribute(
    range: TextRange(start: 7, end: 11),
  );
  final attributedHint = AttributedString(
    'Acronym: NASA orbits',
    attributes: <StringAttribute>[hintSpellOut],
  );

  final attributedSampleProps = SemanticsProperties(
    attributedLabel: attributedLabel,
    attributedValue: attributedValueGerman,
    attributedHint: attributedHint,
  );

  final attributedRows = <Map<String, String>>[
    {
      'role': 'attributedLabel',
      'text': attributedLabel.string,
      'spans': '${attributedLabel.attributes.length}',
    },
    {
      'role': 'attributedValue',
      'text': attributedValueGerman.string,
      'spans': '${attributedValueGerman.attributes.length}',
    },
    {
      'role': 'attributedHint',
      'text': attributedHint.string,
      'spans': '${attributedHint.attributes.length}',
    },
  ];

  print('Attributed rows: ${attributedRows.length}');

  // ===========================================================================
  // SECTION 6: LIVE SEMANTICS WIDGET USAGE
  // ---------------------------------------------------------------------------
  // Wrap real widgets with `Semantics` instances configured equivalently to
  // various SemanticsProperties shapes.
  // ===========================================================================

  final liveSemanticsExamples = <Widget>[
    Semantics(
      label: 'Brand badge',
      header: true,
      child: _badge('Brand badge', Color(0xFF455A64)),
    ),
    Semantics(
      label: 'Open settings',
      button: true,
      enabled: true,
      onTap: () => print('settings tapped'),
      child: _badge('Open settings (button)', Color(0xFF1976D2)),
    ),
    Semantics(
      label: 'View terms',
      link: true,
      child: _badge('View terms (link)', Color(0xFF7B1FA2)),
    ),
    Semantics(
      label: 'Notifications',
      toggled: true,
      onTap: () => print('toggle off'),
      child: _badge('Notifications (on)', Color(0xFF00897B)),
    ),
    Semantics(
      label: 'Avatar',
      image: true,
      child: _badge('Avatar (image)', Color(0xFFE64A19)),
    ),
    MergeSemantics(
      child: Semantics(
        label: 'Merged group',
        container: true,
        child: _badge('Merged group', Color(0xFF6A1B9A)),
      ),
    ),
    ExcludeSemantics(
      child: _badge('Excluded decoration', Color(0xFF9E9E9E)),
    ),
  ];

  print('Live semantics samples: ${liveSemanticsExamples.length}');

  // ===========================================================================
  // SECTION 7: SLIDER VALUE SIMULATION
  // ---------------------------------------------------------------------------
  // Manually shape the increased/decreased value strings that a screen reader
  // would announce when the user invokes the increment / decrement gesture.
  // ===========================================================================

  final sliderValues = <int>[0, 25, 50, 75, 100];
  final sliderRows = <Map<String, String>>[];
  for (final v in sliderValues) {
    final inc = (v + 25).clamp(0, 100);
    final dec = (v - 25).clamp(0, 100);
    final props = SemanticsProperties(
      label: 'Volume',
      value: '$v%',
      increasedValue: '$inc%',
      decreasedValue: '$dec%',
      slider: true,
    );
    sliderRows.add(<String, String>{
      'value': props.value ?? '',
      'increased': props.increasedValue ?? '',
      'decreased': props.decreasedValue ?? '',
    });
  }

  print('Slider rows: ${sliderRows.length}');

  // ===========================================================================
  // SECTION 8: RECIPE CARDS
  // ---------------------------------------------------------------------------
  // Practical patterns you reach for when annotating real widgets.
  // ===========================================================================

  final recipes = <Map<String, String>>[
    {
      'title': 'Plain label',
      'code': "Semantics(label: 'Cancel', child: ...)",
      'when': 'Bare descriptive text for an icon-only button.',
    },
    {
      'title': 'Button + onTap',
      'code': "Semantics(button: true, label: 'Save', onTap: save)",
      'when':
          'GestureDetector wrapped widget that should announce as a button.',
    },
    {
      'title': 'Adjustable slider',
      'code':
          "Semantics(slider: true, value: '30%', increasedValue: '40%', decreasedValue: '20%', onIncrease: ..., onDecrease: ...)",
      'when': 'Custom sliders or steppers.',
    },
    {
      'title': 'Live region',
      'code': "Semantics(liveRegion: true, child: scoreText)",
      'when': 'Score boards, ticker feeds, async status text.',
    },
    {
      'title': 'Exclude decoration',
      'code': 'ExcludeSemantics(child: backgroundIcon)',
      'when': 'Pretty pixels that say nothing to a screen reader.',
    },
    {
      'title': 'Merge child semantics',
      'code': 'MergeSemantics(child: row)',
      'when':
          'A composite row that should announce as a single line of speech.',
    },
    {
      'title': 'Route boundary',
      'code': 'Semantics(scopesRoute: true, namesRoute: true, label: ...)',
      'when': 'Dialogs / overlays that should be reported as routes.',
    },
    {
      'title': 'Header for navigation',
      'code': "Semantics(header: true, label: 'Inbox')",
      'when':
          'Section titles in scrollable lists, navigable by heading gestures.',
    },
    {
      'title': 'Attributed label with locale',
      'code': 'Semantics(attributedLabel: AttributedString(...))',
      'when':
          'Mixed-locale UI content, especially brand names or foreign phrases.',
    },
    {
      'title': 'Spell-out acronym',
      'code': 'SpellOutStringAttribute(range: ...)',
      'when':
          "Acronyms that should be pronounced as letters, e.g., 'FAQ' \u2192 'F-A-Q'.",
    },
  ];

  print('Recipes: ${recipes.length}');

  // ===========================================================================
  // SECTION 9: COMPARISON TABLE
  // ---------------------------------------------------------------------------
  // Semantics vs MergeSemantics vs ExcludeSemantics vs BlockSemantics.
  // ===========================================================================

  final comparison = <Map<String, String>>[
    {
      'widget': 'Semantics',
      'merges': 'No (own node)',
      'visible': 'Yes',
      'use_case': 'Annotate a subtree with role/state/actions.',
    },
    {
      'widget': 'MergeSemantics',
      'merges': 'Yes (subtree)',
      'visible': 'Yes',
      'use_case': 'Compose row of icon + label into single utterance.',
    },
    {
      'widget': 'ExcludeSemantics',
      'merges': 'Drops subtree',
      'visible': 'Yes',
      'use_case': 'Hide purely decorative pixels from a11y tree.',
    },
    {
      'widget': 'BlockSemantics',
      'merges': 'Blocks siblings below',
      'visible': 'Yes',
      'use_case': 'Modal that should fully eclipse content behind it.',
    },
    {
      'widget': 'IndexedSemantics',
      'merges': 'No',
      'visible': 'Yes',
      'use_case': 'Stable index ordering for list children.',
    },
  ];

  print('Comparison rows: ${comparison.length}');

  // ===========================================================================
  // SECTION 10: GLOSSARY
  // ---------------------------------------------------------------------------
  // ===========================================================================

  final glossary = <Map<String, String>>[
    {
      'term': 'SemanticsNode',
      'definition':
          'A node in the SemanticsTree that the framework reports to assistive tech.',
    },
    {
      'term': 'SemanticsAction',
      'definition':
          'Enum of standardized accessibility actions (tap, scrollUp, increase, ...).',
    },
    {
      'term': 'SemanticsFlag',
      'definition':
          'Bitfield of stateful properties (isButton, isChecked, isHidden, ...).',
    },
    {
      'term': 'AttributedString',
      'definition':
          'Plain text plus a list of StringAttributes spanning ranges.',
    },
    {
      'term': 'LocaleStringAttribute',
      'definition':
          'Pins a locale to a range so the screen reader picks the right voice.',
    },
    {
      'term': 'SpellOutStringAttribute',
      'definition':
          'Forces a range to be pronounced letter by letter.',
    },
    {
      'term': 'OrdinalSortKey',
      'definition':
          'Controls traversal order of sibling semantics nodes.',
    },
    {
      'term': 'SemanticsTag',
      'definition':
          'Identifier you can attach to a node and look up later in tests.',
    },
    {
      'term': 'SemanticsHintOverrides',
      'definition':
          'Customizes the action-hint phrases the screen reader speaks.',
    },
    {
      'term': 'CustomSemanticsAction',
      'definition':
          'Bespoke action exposed via the rotor / context menu of the screen reader.',
    },
    {
      'term': 'Live region',
      'definition':
          'Region whose content changes are announced without focus moving.',
    },
    {
      'term': 'Route boundary',
      'definition':
          'A subtree that represents an in-app route (dialog, page, overlay).',
    },
  ];

  print('Glossary entries: ${glossary.length}');

  // ===========================================================================
  // VISUAL BUILDERS
  // ===========================================================================

  Widget sectionTitle(String number, String text) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Color(0xFF1A237E),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              number,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget pill(String text, Color color) {
    return Container(
      margin: EdgeInsets.only(right: 6, bottom: 6),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget infoCard(String title, List<Widget> children) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFB0BEC5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xFF1A237E),
            ),
          ),
          SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  Widget kvRow(String k, String v) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 160,
            child: Text(
              k,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF37474F),
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              v,
              style: TextStyle(fontSize: 12, color: Color(0xFF212121)),
            ),
          ),
        ],
      ),
    );
  }

  // Active flag pills for a given SemanticsProperties value.
  List<Widget> activeFlagPills(SemanticsProperties p) {
    final pills = <Widget>[];
    void addIf(bool? cond, String name, Color color) {
      if (cond == true) pills.add(pill(name, color));
    }

    addIf(p.enabled, 'enabled', Color(0xFF2E7D32));
    addIf(p.button, 'button', Color(0xFF1976D2));
    addIf(p.link, 'link', Color(0xFF7B1FA2));
    addIf(p.header, 'header', Color(0xFF455A64));
    addIf(p.textField, 'textField', Color(0xFF512DA8));
    addIf(p.readOnly, 'readOnly', Color(0xFF5D4037));
    addIf(p.focusable, 'focusable', Color(0xFF0288D1));
    addIf(p.focused, 'focused', Color(0xFF00838F));
    addIf(p.checked, 'checked', Color(0xFF388E3C));
    addIf(p.selected, 'selected', Color(0xFFD81B60));
    addIf(p.toggled, 'toggled', Color(0xFF00897B));
    addIf(p.slider, 'slider', Color(0xFF0277BD));
    addIf(p.image, 'image', Color(0xFFE64A19));
    addIf(p.obscured, 'obscured', Color(0xFF303F9F));
    addIf(p.multiline, 'multiline', Color(0xFF6A1B9A));
    addIf(p.scopesRoute, 'scopesRoute', Color(0xFF3949AB));
    addIf(p.namesRoute, 'namesRoute', Color(0xFF1565C0));
    addIf(p.hidden, 'hidden', Color(0xFF424242));
    addIf(p.liveRegion, 'liveRegion', Color(0xFFC2185B));
    addIf(p.keyboardKey, 'keyboardKey', Color(0xFF00695C));
    addIf(p.expanded, 'expanded', Color(0xFF6A1B9A));
    if (pills.isEmpty) {
      pills.add(pill('(no role flags)', Color(0xFF9E9E9E)));
    }
    return pills;
  }

  // Visualizes a gallery entry.
  Widget galleryCard(_GalleryEntry e) {
    final p = e.props;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: e.accent.withOpacity(0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: e.accent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(7),
                topRight: Radius.circular(7),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(
              e.title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (p.label != null) kvRow('label', p.label!),
                if (p.value != null) kvRow('value', p.value!),
                if (p.hint != null) kvRow('hint', p.hint!),
                if (p.increasedValue != null)
                  kvRow('increasedValue', p.increasedValue!),
                if (p.decreasedValue != null)
                  kvRow('decreasedValue', p.decreasedValue!),
                SizedBox(height: 6),
                Wrap(children: activeFlagPills(p)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget actionCard(_ActionEntry e) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFF90A4AE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            e.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Color(0xFF1B5E20),
            ),
          ),
          SizedBox(height: 6),
          if (e.props.label != null) kvRow('label', e.props.label!),
          if (e.props.value != null) kvRow('value', e.props.value!),
          SizedBox(height: 6),
          Wrap(
            children: <Widget>[
              for (final name in e.actions) pill(name, Color(0xFF455A64)),
            ],
          ),
        ],
      ),
    );
  }

  Widget tableHeader(List<String> cols, List<int> flex) {
    final cells = <Widget>[];
    for (var i = 0; i < cols.length; i++) {
      cells.add(Expanded(
        flex: flex[i],
        child: Text(
          cols[i],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ));
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      color: Color(0xFF455A64),
      child: Row(children: cells),
    );
  }

  Widget tableRow(List<String> cols, List<int> flex, Color zebra) {
    final cells = <Widget>[];
    for (var i = 0; i < cols.length; i++) {
      cells.add(Expanded(
        flex: flex[i],
        child: Text(
          cols[i],
          style: TextStyle(fontSize: 12, color: Color(0xFF212121)),
        ),
      ));
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      color: zebra,
      child: Row(children: cells),
    );
  }

  Widget builtTable({
    required List<String> headers,
    required List<int> flex,
    required List<List<String>> rows,
  }) {
    final widgets = <Widget>[tableHeader(headers, flex)];
    for (var i = 0; i < rows.length; i++) {
      widgets.add(tableRow(
        rows[i],
        flex,
        i.isEven ? Color(0xFFF5F5F5) : Color(0xFFFFFFFF),
      ));
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFB0BEC5)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Column(children: widgets),
      ),
    );
  }

  // ===========================================================================
  // SECTION 11: FINAL COMPOSITION
  // ===========================================================================

  final dossierRows =
      <List<String>>[for (final r in dossier) [r['field']!, r['value']!]];

  final flagRows =
      <List<String>>[for (final r in flagTable) [r['flag']!, r['meaning']!]];

  final stringRows =
      <List<String>>[for (final r in stringTable) [r['field']!, r['meaning']!]];

  final actionRows = <List<String>>[
    for (final r in actionTable) [r['action']!, r['meaning']!]
  ];

  final attributedRowsTable = <List<String>>[
    for (final r in attributedRows) [r['role']!, r['text']!, r['spans']!]
  ];

  final sliderRowsTable = <List<String>>[
    for (final r in sliderRows) [r['value']!, r['increased']!, r['decreased']!]
  ];

  final recipeRows = <List<String>>[
    for (final r in recipes) [r['title']!, r['code']!, r['when']!]
  ];

  final comparisonRows = <List<String>>[
    for (final r in comparison)
      [r['widget']!, r['merges']!, r['visible']!, r['use_case']!]
  ];

  final glossaryRows = <List<String>>[
    for (final r in glossary) [r['term']!, r['definition']!]
  ];

  final children = <Widget>[
    // Header
    Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      color: Color(0xFF1A237E),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'SemanticsProperties — Deep Visual Demo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'package:flutter/semantics.dart — data carrier for accessibility annotations',
            style: TextStyle(
              color: Color(0xFFC5CAE9),
              fontSize: 13,
            ),
          ),
        ],
      ),
    ),

    // Section 1
    sectionTitle('1', 'Dossier'),
    builtTable(
      headers: <String>['Field', 'Value'],
      flex: <int>[2, 4],
      rows: dossierRows,
    ),

    // Section 2
    sectionTitle('2', 'Anatomy — Flag Table'),
    builtTable(
      headers: <String>['Flag', 'Meaning'],
      flex: <int>[2, 4],
      rows: flagRows,
    ),
    sectionTitle('2', 'Anatomy — String Field Table'),
    builtTable(
      headers: <String>['Field', 'Meaning'],
      flex: <int>[2, 4],
      rows: stringRows,
    ),
    sectionTitle('2', 'Anatomy — Action Callback Table'),
    builtTable(
      headers: <String>['Action', 'Meaning'],
      flex: <int>[3, 4],
      rows: actionRows,
    ),

    // Section 3
    sectionTitle('3', 'Boolean-Flag Gallery'),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        '${gallery.length} SemanticsProperties variants demonstrating role flags.',
        style: TextStyle(fontSize: 12, color: Color(0xFF455A64)),
      ),
    ),
    for (final entry in gallery) galleryCard(entry),

    // Section 4
    sectionTitle('4', 'Action Callbacks'),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        '${actionConfigurations.length} configurations with action callbacks wired.',
        style: TextStyle(fontSize: 12, color: Color(0xFF455A64)),
      ),
    ),
    for (final cfg in actionConfigurations) actionCard(cfg),

    // Section 5
    sectionTitle('5', 'AttributedString Variants'),
    infoCard(
      'Spans summary',
      <Widget>[
        kvRow('attributedLabel', attributedLabel.string),
        kvRow('  span 1 (locale en_US)',
            '[${localeAttribute.range.start}..${localeAttribute.range.end})'),
        kvRow('  span 2 (spellOut)',
            '[${spellOutAttribute.range.start}..${spellOutAttribute.range.end})'),
        SizedBox(height: 6),
        kvRow('attributedValue', attributedValueGerman.string),
        kvRow('  span 1 (locale de_DE)',
            '[${germanLocale.range.start}..${germanLocale.range.end})'),
        SizedBox(height: 6),
        kvRow('attributedHint', attributedHint.string),
        kvRow('  span 1 (spellOut)',
            '[${hintSpellOut.range.start}..${hintSpellOut.range.end})'),
      ],
    ),
    builtTable(
      headers: <String>['Role', 'Text', 'Spans'],
      flex: <int>[2, 5, 1],
      rows: attributedRowsTable,
    ),

    // Section 6
    sectionTitle('6', 'Live Semantics Widget Usage'),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: liveSemanticsExamples,
      ),
    ),

    // Section 7
    sectionTitle('7', 'Slider Value Simulation'),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        'For each volume value, the value strings the screen reader would speak.',
        style: TextStyle(fontSize: 12, color: Color(0xFF455A64)),
      ),
    ),
    builtTable(
      headers: <String>['value', 'increasedValue', 'decreasedValue'],
      flex: <int>[2, 2, 2],
      rows: sliderRowsTable,
    ),

    // Section 8
    sectionTitle('8', 'Recipe Cards'),
    builtTable(
      headers: <String>['Title', 'Code', 'When'],
      flex: <int>[2, 4, 4],
      rows: recipeRows,
    ),

    // Section 9
    sectionTitle('9', 'Comparison Table'),
    builtTable(
      headers: <String>['Widget', 'Merges', 'Visible', 'Use case'],
      flex: <int>[2, 3, 1, 5],
      rows: comparisonRows,
    ),

    // Section 10
    sectionTitle('10', 'Glossary'),
    builtTable(
      headers: <String>['Term', 'Definition'],
      flex: <int>[2, 5],
      rows: glossaryRows,
    ),

    // Section 11
    sectionTitle('11', 'Final Composed Tree'),
    Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFE8EAF6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFF3F51B5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Composed Semantics tree:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Semantics(
            container: true,
            label: 'Demo summary',
            header: true,
            child: Text(
              'SemanticsProperties demo header',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFF1A237E)),
            ),
          ),
          SizedBox(height: 8),
          Semantics(
            button: true,
            enabled: true,
            label: 'Primary action',
            hint: 'Activates the demo',
            onTap: () => print('primary action'),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Color(0xFF3F51B5),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Primary action',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 8),
          MergeSemantics(
            child: Row(
              children: <Widget>[
                Icon(Icons.info, color: Color(0xFF1565C0)),
                SizedBox(width: 6),
                Text('Merged info row'),
              ],
            ),
          ),
          SizedBox(height: 8),
          Semantics(
            liveRegion: true,
            child: Text(
              'Live region content updates here',
              style: TextStyle(color: Color(0xFFC2185B)),
            ),
          ),
        ],
      ),
    ),

    // Footer
    Padding(
      padding: EdgeInsets.all(20),
      child: Text(
        'End of SemanticsProperties demo — '
        '${gallery.length} role variants, '
        '${actionConfigurations.length} action variants, '
        '${attributedRows.length} attributed strings, '
        '${recipes.length} recipes.',
        style: TextStyle(
          fontStyle: FontStyle.italic,
          color: Color(0xFF607D8B),
          fontSize: 12,
        ),
      ),
    ),
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// Helper widget: a small color-coded badge used in live semantics examples.
// =============================================================================
Widget _badge(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
    ),
  );
}

// =============================================================================
// Internal value objects keep this script organized and self-documenting.
// =============================================================================

class _GalleryEntry {
  _GalleryEntry(this.title, this.props, this.accent);

  final String title;
  final SemanticsProperties props;
  final Color accent;
}

class _ActionEntry {
  _ActionEntry(this.title, this.props, this.actions);

  final String title;
  final SemanticsProperties props;
  final List<String> actions;
}

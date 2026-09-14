// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo - Accessibility Semantics Atlas
// Theme: A richly designed visual atlas of Flutter's accessibility Semantics
// surface. Each section is a "map panel" for one capability of Semantics:
// labels & hints, flag taxonomy, action catalogue, merge/block/exclude
// behaviour, live regions, sortable reading order, and composed examples
// (form, list, dialog). Visual showcase only — no runtime side effects.
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

dynamic build(BuildContext context) {
  // ============================================================================
  // SECTION 1 DATA: SEMANTICS PRIMITIVES — anchor concepts
  // ============================================================================

  final primitiveCards = <Map<String, dynamic>>[
    {
      'name': 'Semantics',
      'role': 'Single widget node',
      'desc': 'Annotates the subtree with semantic metadata for assistive tech.',
      'glyph': 'SEM',
      'family': 'core',
    },
    {
      'name': 'MergeSemantics',
      'role': 'Collapse subtree',
      'desc': 'Merges descendant nodes into one node reported to a11y tree.',
      'glyph': 'MRG',
      'family': 'tree',
    },
    {
      'name': 'BlockSemantics',
      'role': 'Hide siblings',
      'desc': 'Drops earlier siblings within the same parent from the tree.',
      'glyph': 'BLK',
      'family': 'tree',
    },
    {
      'name': 'ExcludeSemantics',
      'role': 'Drop subtree',
      'desc': 'Removes everything beneath it from the accessibility tree.',
      'glyph': 'EXC',
      'family': 'tree',
    },
    {
      'name': 'IndexedSemantics',
      'role': 'Position index',
      'desc': 'Adds an ordinal index used by scrollable list reporting.',
      'glyph': 'IDX',
      'family': 'list',
    },
    {
      'name': 'Semantics(container: true)',
      'role': 'Force node',
      'desc': 'Promotes annotations onto their own SemanticsNode (no merge).',
      'glyph': 'CTR',
      'family': 'core',
    },
  ];

  // ============================================================================
  // SECTION 2 DATA: LABELS, HINTS, VALUES — the spoken vocabulary
  // ============================================================================

  final labelExamples = <Map<String, dynamic>>[
    {
      'kind': 'label',
      'visual': 'Save',
      'spoken': '"Save, button"',
      'desc': 'Label is the primary spoken text for a node.',
      'tone': Color(0xFF4527A0),
    },
    {
      'kind': 'hint',
      'visual': 'Save',
      'spoken': '"Save, double tap to activate"',
      'desc': 'Hint adds an instructional suffix after the label & role.',
      'tone': Color(0xFF00695C),
    },
    {
      'kind': 'value',
      'visual': 'Volume slider',
      'spoken': '"Volume, 65 percent, slider"',
      'desc': 'Value reads the current state (used for sliders, switches).',
      'tone': Color(0xFFEF6C00),
    },
    {
      'kind': 'increasedValue',
      'visual': '+1',
      'spoken': '"66 percent"',
      'desc': 'What the value becomes when the increase action fires.',
      'tone': Color(0xFFC62828),
    },
    {
      'kind': 'decreasedValue',
      'visual': '-1',
      'spoken': '"64 percent"',
      'desc': 'What the value becomes when the decrease action fires.',
      'tone': Color(0xFF1565C0),
    },
    {
      'kind': 'tooltip',
      'visual': 'Save',
      'spoken': '"Save, tooltip: Persist to disk"',
      'desc': 'Tooltip is appended only when long-press / hover is active.',
      'tone': Color(0xFF6A1B9A),
    },
  ];

  final attributedSamples = <Map<String, dynamic>>[
    {
      'text': 'Helvetica',
      'attr': 'LocaleStringAttribute(en-US)',
      'desc': 'Helps screen readers select the correct pronunciation dictionary.',
    },
    {
      'text': 'ABC-123',
      'attr': 'SpellOutStringAttribute',
      'desc': 'Reads each character individually instead of as a word.',
    },
    {
      'text': 'NASA',
      'attr': 'SpellOutStringAttribute',
      'desc': 'Force per-letter playback for acronyms that would otherwise be read as words.',
    },
    {
      'text': 'Bonjour le monde',
      'attr': 'LocaleStringAttribute(fr-FR)',
      'desc': 'Switches voice/locale for embedded foreign-language text.',
    },
  ];

  // ============================================================================
  // SECTION 3 DATA: SEMANTICS FLAG TAXONOMY — colour-coded badge groups
  // ============================================================================

  final booleanFlagGroup = <Map<String, dynamic>>[
    {'name': 'hasCheckedState', 'flag': SemanticsFlag.hasCheckedState, 'desc': 'Node can carry a checked/unchecked state.'},
    {'name': 'isChecked', 'flag': SemanticsFlag.isChecked, 'desc': 'The node is currently checked.'},
    {'name': 'isCheckStateMixed', 'flag': SemanticsFlag.isCheckStateMixed, 'desc': 'Tri-state checkbox in the mixed state.'},
    {'name': 'hasToggledState', 'flag': SemanticsFlag.hasToggledState, 'desc': 'Node can carry a toggled on/off state (switch).'},
    {'name': 'isToggled', 'flag': SemanticsFlag.isToggled, 'desc': 'The switch is currently on.'},
    {'name': 'hasSelectedState', 'flag': SemanticsFlag.hasSelectedState, 'desc': 'Node participates in a selection group.'},
    {'name': 'isSelected', 'flag': SemanticsFlag.isSelected, 'desc': 'The node is currently selected.'},
    {'name': 'hasEnabledState', 'flag': SemanticsFlag.hasEnabledState, 'desc': 'Node can be enabled or disabled.'},
    {'name': 'isEnabled', 'flag': SemanticsFlag.isEnabled, 'desc': 'The control is currently enabled.'},
  ];

  final roleFlagGroup = <Map<String, dynamic>>[
    {'name': 'isButton', 'flag': SemanticsFlag.isButton, 'desc': 'Reported as a button (announces "button" suffix).'},
    {'name': 'isLink', 'flag': SemanticsFlag.isLink, 'desc': 'Reported as a navigable link.'},
    {'name': 'isImage', 'flag': SemanticsFlag.isImage, 'desc': 'Reported as an image (label becomes alt text).'},
    {'name': 'isHeader', 'flag': SemanticsFlag.isHeader, 'desc': 'Reported as a section header (jump-target for readers).'},
    {'name': 'isTextField', 'flag': SemanticsFlag.isTextField, 'desc': 'Reported as a text input field.'},
    {'name': 'isReadOnly', 'flag': SemanticsFlag.isReadOnly, 'desc': 'The text field is read-only.'},
    {'name': 'isSlider', 'flag': SemanticsFlag.isSlider, 'desc': 'Reported as a slider (announces value).'},
    {'name': 'isKeyboardKey', 'flag': SemanticsFlag.isKeyboardKey, 'desc': 'Reported as an individual on-screen keyboard key.'},
  ];

  final visibilityFlagGroup = <Map<String, dynamic>>[
    {'name': 'isHidden', 'flag': SemanticsFlag.isHidden, 'desc': 'Currently off-screen; kept in tree but skipped.'},
    {'name': 'isObscured', 'flag': SemanticsFlag.isObscured, 'desc': 'Text is masked (password field).'},
    {'name': 'isMultiline', 'flag': SemanticsFlag.isMultiline, 'desc': 'Text field accepts multiple lines.'},
    {'name': 'namesRoute', 'flag': SemanticsFlag.namesRoute, 'desc': 'This node provides the name for its enclosing route.'},
    {'name': 'scopesRoute', 'flag': SemanticsFlag.scopesRoute, 'desc': 'Acts as a route scope (dialog, page).'},
    {'name': 'isFocusable', 'flag': SemanticsFlag.isFocusable, 'desc': 'Node can receive accessibility focus.'},
    {'name': 'isFocused', 'flag': SemanticsFlag.isFocused, 'desc': 'Node currently has accessibility focus.'},
  ];

  final liveFlagGroup = <Map<String, dynamic>>[
    {'name': 'isLiveRegion', 'flag': SemanticsFlag.isLiveRegion, 'desc': 'Changes are announced automatically when content changes.'},
    {'name': 'hasImplicitScrolling', 'flag': SemanticsFlag.hasImplicitScrolling, 'desc': 'Subtree scrolls implicitly when focus moves outside.'},
    {'name': 'isInMutuallyExclusiveGroup', 'flag': SemanticsFlag.isInMutuallyExclusiveGroup, 'desc': 'Radio-style group; selecting one deselects others.'},
  ];

  // ============================================================================
  // SECTION 4 DATA: SEMANTICS ACTION CATALOGUE — interaction surface
  // ============================================================================

  final touchActions = <Map<String, dynamic>>[
    {'name': 'tap', 'action': SemanticsAction.tap, 'desc': 'Default activation (button press).'},
    {'name': 'longPress', 'action': SemanticsAction.longPress, 'desc': 'Sustained touch / context menu trigger.'},
    {'name': 'didGainAccessibilityFocus', 'action': SemanticsAction.didGainAccessibilityFocus, 'desc': 'Reader cursor entered this node.'},
    {'name': 'didLoseAccessibilityFocus', 'action': SemanticsAction.didLoseAccessibilityFocus, 'desc': 'Reader cursor left this node.'},
    {'name': 'dismiss', 'action': SemanticsAction.dismiss, 'desc': 'Dismiss this element (close dialog, snackbar).'},
  ];

  final scrollActions = <Map<String, dynamic>>[
    {'name': 'scrollLeft', 'action': SemanticsAction.scrollLeft, 'desc': 'Scroll content one page to the left.'},
    {'name': 'scrollRight', 'action': SemanticsAction.scrollRight, 'desc': 'Scroll content one page to the right.'},
    {'name': 'scrollUp', 'action': SemanticsAction.scrollUp, 'desc': 'Scroll content one page up.'},
    {'name': 'scrollDown', 'action': SemanticsAction.scrollDown, 'desc': 'Scroll content one page down.'},
    {'name': 'scrollToOffset', 'action': SemanticsAction.scrollToOffset, 'desc': 'Programmatic scroll to a specific offset (a11y reader).'},
  ];

  final adjustActions = <Map<String, dynamic>>[
    {'name': 'increase', 'action': SemanticsAction.increase, 'desc': 'Step value up (slider, stepper).'},
    {'name': 'decrease', 'action': SemanticsAction.decrease, 'desc': 'Step value down (slider, stepper).'},
    {'name': 'setText', 'action': SemanticsAction.setText, 'desc': 'Replace the text contents of a field.'},
    {'name': 'setSelection', 'action': SemanticsAction.setSelection, 'desc': 'Set the current text selection range.'},
    {'name': 'copy', 'action': SemanticsAction.copy, 'desc': 'Copy current selection to clipboard.'},
    {'name': 'cut', 'action': SemanticsAction.cut, 'desc': 'Cut current selection to clipboard.'},
    {'name': 'paste', 'action': SemanticsAction.paste, 'desc': 'Paste clipboard contents at caret.'},
  ];

  final navActions = <Map<String, dynamic>>[
    {'name': 'moveCursorForwardByCharacter', 'action': SemanticsAction.moveCursorForwardByCharacter, 'desc': 'Caret one char forward.'},
    {'name': 'moveCursorBackwardByCharacter', 'action': SemanticsAction.moveCursorBackwardByCharacter, 'desc': 'Caret one char backward.'},
    {'name': 'moveCursorForwardByWord', 'action': SemanticsAction.moveCursorForwardByWord, 'desc': 'Caret one word forward.'},
    {'name': 'moveCursorBackwardByWord', 'action': SemanticsAction.moveCursorBackwardByWord, 'desc': 'Caret one word backward.'},
    {'name': 'showOnScreen', 'action': SemanticsAction.showOnScreen, 'desc': 'Scroll the node into the visible viewport.'},
    {'name': 'customAction', 'action': SemanticsAction.customAction, 'desc': 'User-provided named action exposed to readers.'},
    {'name': 'focus', 'action': SemanticsAction.focus, 'desc': 'Move accessibility focus to this node.'},
  ];

  // ============================================================================
  // SECTION 5 DATA: TREE-COMPOSITION MATRIX — Merge/Block/Exclude comparison
  // ============================================================================

  final compositionMatrix = <Map<String, String>>[
    {
      'widget': 'MergeSemantics',
      'subtree': 'kept',
      'siblings': 'kept',
      'announced': 'as one node',
    },
    {
      'widget': 'BlockSemantics',
      'subtree': 'kept',
      'siblings': 'dropped (earlier)',
      'announced': 'subtree only',
    },
    {
      'widget': 'ExcludeSemantics',
      'subtree': 'dropped',
      'siblings': 'kept',
      'announced': 'nothing',
    },
    {
      'widget': 'Semantics(container)',
      'subtree': 'kept',
      'siblings': 'kept',
      'announced': 'separate node',
    },
  ];

  // ============================================================================
  // SECTION 6 DATA: LIVE REGION ASSERTIVENESS — announcement priority
  // ============================================================================

  final liveAssertiveness = <Map<String, dynamic>>[
    {
      'name': 'Assertiveness.polite',
      'desc': 'Queue announcement; wait for the reader to be idle.',
      'tone': Color(0xFF1B5E20),
      'when': 'Status updates, soft notifications.',
    },
    {
      'name': 'Assertiveness.assertive',
      'desc': 'Interrupt the reader and speak immediately.',
      'tone': Color(0xFFB71C1C),
      'when': 'Errors, urgent confirmations.',
    },
  ];

  // ============================================================================
  // SECTION 7 DATA: READING ORDER — OrdinalSortKey demonstration
  // ============================================================================

  final readingOrder = <Map<String, dynamic>>[
    {'label': 'Page title', 'order': 0.0, 'note': 'Always first.'},
    {'label': 'Status banner', 'order': 1.0, 'note': 'Announce before form.'},
    {'label': 'Form field A', 'order': 2.0, 'note': 'Primary input.'},
    {'label': 'Form field B', 'order': 3.0, 'note': 'Secondary input.'},
    {'label': 'Submit button', 'order': 4.0, 'note': 'Closes the form group.'},
    {'label': 'Footer note', 'order': 5.0, 'note': 'Always last.'},
  ];

  // ============================================================================
  // SECTION 8 DATA: SORTKEY OBJECTS
  // ============================================================================

  final ordinalA = OrdinalSortKey(1.0);
  final ordinalB = OrdinalSortKey(2.0, name: 'form-group');
  final ordinalC = OrdinalSortKey(0.5, name: 'header');
  final ordinalCmp = ordinalA.compareTo(ordinalB);

  // ============================================================================
  // SECTION 9 DATA: TAGS & HINT OVERRIDES
  // ============================================================================

  final tagButton = SemanticsTag('button-tag');
  final tagHeader = SemanticsTag('header-tag');
  final tagCustom = SemanticsTag('custom-role');

  final hintOverridesFull = SemanticsHintOverrides(
    onTapHint: 'Activate button',
    onLongPressHint: 'Show options',
  );

  final hintOverridesTapOnly = SemanticsHintOverrides(
    onTapHint: 'Submit form',
  );

  final hintOverridesEmpty = SemanticsHintOverrides();

  // ============================================================================
  // SECTION 10 DATA: ATTRIBUTED STRINGS LIVE OBJECTS
  // ============================================================================

  final attrHello = AttributedString('Hello World');
  final attrSpell = AttributedString(
    'NASA',
    attributes: [SpellOutStringAttribute(range: TextRange(start: 0, end: 4))],
  );
  final attrLocale = AttributedString(
    'Bonjour le monde',
    attributes: [
      LocaleStringAttribute(
        range: TextRange(start: 0, end: 16),
        locale: Locale('fr', 'FR'),
      ),
    ],
  );
  final attrConcat = attrHello + AttributedString(' Atlas');

  // ============================================================================
  // SECTION 11 DATA: COMPOSED RECIPES — sample Semantics(...) invocations
  // ============================================================================

  final recipeCards = <Map<String, dynamic>>[
    {
      'title': 'Labeled button',
      'code': 'Semantics(\n  label: "Save",\n  button: true,\n  enabled: true,\n  onTap: () => save(),\n  child: child,\n)',
      'family': 'role',
    },
    {
      'title': 'Image with alt text',
      'code': 'Semantics(\n  label: "User avatar",\n  image: true,\n  excludeSemantics: true,\n  child: Image(...),\n)',
      'family': 'role',
    },
    {
      'title': 'Header for jump nav',
      'code': 'Semantics(\n  header: true,\n  label: "Section A",\n  sortKey: OrdinalSortKey(1.0),\n  child: child,\n)',
      'family': 'role',
    },
    {
      'title': 'Toggle / switch',
      'code': 'Semantics(\n  label: "Wi-Fi",\n  toggled: enabled,\n  onTap: () => toggle(),\n  child: child,\n)',
      'family': 'state',
    },
    {
      'title': 'Slider with values',
      'code': 'Semantics(\n  label: "Volume",\n  slider: true,\n  value: "65 percent",\n  increasedValue: "66 percent",\n  decreasedValue: "64 percent",\n  onIncrease: bump,\n  onDecrease: drop,\n  child: child,\n)',
      'family': 'state',
    },
    {
      'title': 'Read-only password field',
      'code': 'Semantics(\n  textField: true,\n  readOnly: true,\n  obscured: true,\n  label: "Password",\n  child: child,\n)',
      'family': 'role',
    },
    {
      'title': 'Live status region',
      'code': 'Semantics(\n  liveRegion: true,\n  label: "Saved at 12:04",\n  child: child,\n)',
      'family': 'live',
    },
    {
      'title': 'Merged compound widget',
      'code': 'MergeSemantics(\n  child: Row(children: [Icon(...), Text("Inbox")]),\n)',
      'family': 'tree',
    },
    {
      'title': 'Excluded decorative graphic',
      'code': 'ExcludeSemantics(\n  child: BackgroundFlourish(...),\n)',
      'family': 'tree',
    },
    {
      'title': 'Blocking modal',
      'code': 'BlockSemantics(\n  child: ModalDialog(...),\n)',
      'family': 'tree',
    },
  ];

  // ============================================================================
  // SECTION 12 DATA: WORKED FORM EXAMPLE — composed real-world sample
  // ============================================================================

  final formFields = <Map<String, dynamic>>[
    {
      'label': 'Email',
      'role': 'textField',
      'value': 'ada@example.com',
      'hint': 'Enter the email used for sign-in.',
      'sortOrder': 1.0,
    },
    {
      'label': 'Password',
      'role': 'textField (obscured)',
      'value': '••••••••',
      'hint': 'Enter your account password.',
      'sortOrder': 2.0,
    },
    {
      'label': 'Remember me',
      'role': 'checkbox',
      'value': 'checked',
      'hint': 'Keep me signed in on this device.',
      'sortOrder': 3.0,
    },
    {
      'label': 'Sign in',
      'role': 'button',
      'value': 'enabled',
      'hint': 'Submit the form to authenticate.',
      'sortOrder': 4.0,
    },
  ];

  // ============================================================================
  // SECTION 13 DATA: LIST EXAMPLE — IndexedSemantics & list announcements
  // ============================================================================

  final listItems = <Map<String, dynamic>>[
    {'index': 0, 'title': 'Project Apollo', 'meta': 'updated 12s ago'},
    {'index': 1, 'title': 'Project Borealis', 'meta': 'updated 4m ago'},
    {'index': 2, 'title': 'Project Chronos', 'meta': 'updated 1h ago'},
    {'index': 3, 'title': 'Project Daedalus', 'meta': 'updated 1d ago'},
    {'index': 4, 'title': 'Project Eos', 'meta': 'updated 2d ago'},
  ];

  // ============================================================================
  // SECTION 14 DATA: DIALOG EXAMPLE — scopesRoute / namesRoute
  // ============================================================================

  final dialogScopes = <Map<String, dynamic>>[
    {
      'name': 'scopesRoute',
      'desc': 'Marks this node as the root of a route (dialog/page).',
      'used': 'Dialog body container.',
    },
    {
      'name': 'namesRoute',
      'desc': 'Supplies the name spoken when the route is entered.',
      'used': 'Dialog title text.',
    },
    {
      'name': 'explicitChildNodes',
      'desc': 'Forces each child to own a SemanticsNode (no merge).',
      'used': 'Dialog button row.',
    },
    {
      'name': 'isBlocking',
      'desc': 'Dialog overlay sets BlockSemantics on background.',
      'used': 'Barrier behind the dialog.',
    },
  ];

  // ============================================================================
  // SECTION 15 DATA: ANIMATION SNAPSHOT — visualises focus glow ring
  // ============================================================================

  final focusGlow = AlwaysStoppedAnimation<double>(0.7);
  final focusGlowAlpha = (focusGlow.value * 255).round() & 0xFF;

  // ============================================================================
  // SECTION 16 DATA: GLOSSARY ENTRIES
  // ============================================================================

  final glossary = <Map<String, String>>[
    {'term': 'Semantics', 'def': 'Widget annotating a subtree with accessibility metadata.'},
    {'term': 'SemanticsFlag', 'def': 'Enum identifying boolean states/roles on a SemanticsNode.'},
    {'term': 'SemanticsAction', 'def': 'Enum identifying interaction the OS can request on a node.'},
    {'term': 'SemanticsNode', 'def': 'Internal accessibility tree node produced from widget annotations.'},
    {'term': 'SemanticsTag', 'def': 'Named tag attached to a node for selective lookup.'},
    {'term': 'SortKey', 'def': 'Custom ordering used by readers to traverse nodes.'},
    {'term': 'OrdinalSortKey', 'def': 'SortKey based on a numeric order with optional name group.'},
    {'term': 'AttributedString', 'def': 'String paired with locale / spell-out annotations.'},
    {'term': 'liveRegion', 'def': 'Marks a node whose changes should be auto-announced.'},
    {'term': 'a11y tree', 'def': 'Accessibility tree built from Semantics widgets and reported to the OS.'},
  ];

  // ============================================================================
  // SECTION 17 DATA: HEALTH METRICS / EPILOGUE
  // ============================================================================

  final atlasMetrics = <Map<String, String>>[
    {'metric': 'Primitive widgets covered', 'value': '${primitiveCards.length}'},
    {'metric': 'Labels & hints variants', 'value': '${labelExamples.length}'},
    {'metric': 'Boolean/state flags', 'value': '${booleanFlagGroup.length}'},
    {'metric': 'Role flags', 'value': '${roleFlagGroup.length}'},
    {'metric': 'Visibility flags', 'value': '${visibilityFlagGroup.length}'},
    {'metric': 'Live / list flags', 'value': '${liveFlagGroup.length}'},
    {'metric': 'Touch actions', 'value': '${touchActions.length}'},
    {'metric': 'Scroll actions', 'value': '${scrollActions.length}'},
    {'metric': 'Adjustment actions', 'value': '${adjustActions.length}'},
    {'metric': 'Navigation/text actions', 'value': '${navActions.length}'},
    {'metric': 'Composed recipes', 'value': '${recipeCards.length}'},
    {'metric': 'Worked form fields', 'value': '${formFields.length}'},
    {'metric': 'List items', 'value': '${listItems.length}'},
    {'metric': 'Glossary entries', 'value': '${glossary.length}'},
  ];

  final totalFlagCount = booleanFlagGroup.length +
      roleFlagGroup.length +
      visibilityFlagGroup.length +
      liveFlagGroup.length;
  final totalActionCount = touchActions.length +
      scrollActions.length +
      adjustActions.length +
      navActions.length;

  final epilogueColor = HSVColor.fromAHSV(
    1.0,
    (math.pi * 60.0) % 360.0,
    0.55,
    0.45,
  ).toColor();

  final ringRadius = 18.0 + focusGlow.value * 4.0;
  final ringGlowColor = Color.fromARGB(focusGlowAlpha, 26, 35, 126);
  final tickDuration = Duration.zero;
  final tickDurationMs = tickDuration.inMilliseconds;
  final pi2 = ui.lerpDouble(0.0, math.pi * 2.0, focusGlow.value) ?? 0.0;

  // ============================================================================
  // BUILD ATLAS UI
  // ============================================================================

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF5F3FF),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ===== HERO HEADER =====
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF311B92),
                      Color(0xFF4527A0),
                      Color(0xFF6A1B9A),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18.0),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x55311B92),
                      blurRadius: 12.0,
                      offset: Offset(0.0, 6.0),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48.0,
                          height: 48.0,
                          decoration: BoxDecoration(
                            color: Color(0x33FFFFFF),
                            borderRadius: BorderRadius.circular(14.0),
                            border: Border.all(
                              color: Color(0x66FFFFFF),
                              width: 1.0,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'A11Y',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 14.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Accessibility Semantics Atlas',
                                style: TextStyle(
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                'Deep Demo: Flutter Semantics surface — flags, actions, composition, live regions',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color: Color(0xFFEDE7F6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: [
                        _heroChip('Semantics'),
                        _heroChip('MergeSemantics'),
                        _heroChip('BlockSemantics'),
                        _heroChip('ExcludeSemantics'),
                        _heroChip('SemanticsFlag'),
                        _heroChip('SemanticsAction'),
                        _heroChip('OrdinalSortKey'),
                        _heroChip('SemanticsTag'),
                        _heroChip('AttributedString'),
                        _heroChip('liveRegion'),
                        _heroChip('scopesRoute'),
                      ],
                    ),
                    SizedBox(height: 14.0),
                    Row(
                      children: [
                        _heroStat(
                          'flags',
                          '$totalFlagCount',
                          Color(0xFFEDE7F6),
                          Color(0xFFB39DDB),
                        ),
                        SizedBox(width: 8.0),
                        _heroStat(
                          'actions',
                          '$totalActionCount',
                          Color(0xFFEDE7F6),
                          Color(0xFFB39DDB),
                        ),
                        SizedBox(width: 8.0),
                        _heroStat(
                          'recipes',
                          '${recipeCards.length}',
                          Color(0xFFEDE7F6),
                          Color(0xFFB39DDB),
                        ),
                        SizedBox(width: 8.0),
                        _heroStat(
                          'tick',
                          '${tickDurationMs}ms',
                          Color(0xFFEDE7F6),
                          Color(0xFFB39DDB),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.0),

              // ===== ATLAS LEGEND =====
              _legendCard(),

              SizedBox(height: 24.0),

              // ===== SECTION 1: SEMANTICS PRIMITIVES =====
              _sectionContainer(
                bg: Color(0xFFEDE7F6),
                border: Color(0xFFB39DDB),
                title: '1. Semantics Primitives',
                titleColor: Color(0xFF311B92),
                subtitle:
                    'Anchor widgets that participate in the accessibility tree.',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final card in primitiveCards)
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFD1C4E9),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: Color(0xFF9575CD),
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 48.0,
                                height: 36.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFF512DA8),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Center(
                                  child: Text(
                                    card['glyph'] as String,
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            card['name'] as String,
                                            style: TextStyle(
                                              fontFamily: 'monospace',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.0,
                                              color: Color(0xFF311B92),
                                            ),
                                          ),
                                        ),
                                        _familyBadge(
                                          card['family'] as String,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      card['role'] as String,
                                      style: TextStyle(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF4527A0),
                                      ),
                                    ),
                                    SizedBox(height: 2.0),
                                    Text(
                                      card['desc'] as String,
                                      style: TextStyle(
                                        fontSize: 11.0,
                                        color: Color(0xFF311B92),
                                        height: 1.3,
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

              SizedBox(height: 24.0),

              // ===== SECTION 2: LABELS, HINTS, VALUES =====
              _sectionContainer(
                bg: Color(0xFFE0F7FA),
                border: Color(0xFF80DEEA),
                title: '2. Labels, Hints, Values',
                titleColor: Color(0xFF006064),
                subtitle:
                    'The vocabulary the screen reader speaks for each node.',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final ex in labelExamples)
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFB2EBF2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  color: ex['tone'] as Color,
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Text(
                                  (ex['kind'] as String).toUpperCase(),
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'visual: ${ex['visual']}',
                                      style: TextStyle(
                                        fontSize: 11.0,
                                        fontFamily: 'monospace',
                                        color: Color(0xFF006064),
                                      ),
                                    ),
                                    SizedBox(height: 2.0),
                                    Text(
                                      'spoken: ${ex['spoken']}',
                                      style: TextStyle(
                                        fontSize: 11.0,
                                        fontStyle: FontStyle.italic,
                                        color: Color(0xFF004D40),
                                      ),
                                    ),
                                    SizedBox(height: 2.0),
                                    Text(
                                      ex['desc'] as String,
                                      style: TextStyle(
                                        fontSize: 11.0,
                                        height: 1.3,
                                        color: Color(0xFF263238),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: 10.0),
                    Text(
                      'AttributedString samples',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                        color: Color(0xFF006064),
                      ),
                    ),
                    SizedBox(height: 6.0),
                    for (final attr in attributedSamples)
                      Padding(
                        padding: EdgeInsets.only(bottom: 6.0),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFE0F2F1),
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: Color(0xFF4DB6AC),
                              width: 1.0,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6.0,
                                      vertical: 2.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF00838F),
                                      borderRadius:
                                          BorderRadius.circular(4.0),
                                    ),
                                    child: Text(
                                      attr['attr'] as String,
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 9.0,
                                        fontFamily: 'monospace',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    '"${attr['text']}"',
                                    style: TextStyle(
                                      fontFamily: 'monospace',
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF004D40),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                attr['desc'] as String,
                                style: TextStyle(
                                  fontSize: 11.0,
                                  color: Color(0xFF263238),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: 10.0),
                    _kvCard('Live AttributedString objects', [
                      _kv('attrHello', '"${attrHello.string}"'),
                      _kv('attrSpell', '"${attrSpell.string}" (#${attrSpell.attributes.length} attr)'),
                      _kv('attrLocale', '"${attrLocale.string}" (#${attrLocale.attributes.length} attr)'),
                      _kv('attrConcat', '"${attrConcat.string}"'),
                    ]),
                  ],
                ),
              ),

              SizedBox(height: 24.0),

              // ===== SECTION 3: SEMANTICS FLAG TAXONOMY =====
              _sectionContainer(
                bg: Color(0xFFFFF3E0),
                border: Color(0xFFFFB74D),
                title: '3. SemanticsFlag Taxonomy',
                titleColor: Color(0xFFE65100),
                subtitle:
                    'Colour-coded flag groups: state booleans, roles, visibility, live regions.',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _flagGroupHeader(
                      'State booleans',
                      'check/toggle/select/enable',
                      Color(0xFFD84315),
                    ),
                    SizedBox(height: 6.0),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: [
                        for (final f in booleanFlagGroup)
                          _flagBadge(
                            f['name'] as String,
                            (f['flag'] as SemanticsFlag).index,
                            Color(0xFFD84315),
                            Color(0xFFFFCCBC),
                          ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    for (final f in booleanFlagGroup)
                      _flagRow(
                        f['name'] as String,
                        f['desc'] as String,
                        (f['flag'] as SemanticsFlag).index,
                        Color(0xFFD84315),
                      ),
                    SizedBox(height: 14.0),

                    _flagGroupHeader(
                      'Role flags',
                      'button/link/image/header/textField/slider',
                      Color(0xFF6A1B9A),
                    ),
                    SizedBox(height: 6.0),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: [
                        for (final f in roleFlagGroup)
                          _flagBadge(
                            f['name'] as String,
                            (f['flag'] as SemanticsFlag).index,
                            Color(0xFF6A1B9A),
                            Color(0xFFE1BEE7),
                          ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    for (final f in roleFlagGroup)
                      _flagRow(
                        f['name'] as String,
                        f['desc'] as String,
                        (f['flag'] as SemanticsFlag).index,
                        Color(0xFF6A1B9A),
                      ),
                    SizedBox(height: 14.0),

                    _flagGroupHeader(
                      'Visibility & focus',
                      'hidden/obscured/multiline/routes/focus',
                      Color(0xFF1565C0),
                    ),
                    SizedBox(height: 6.0),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: [
                        for (final f in visibilityFlagGroup)
                          _flagBadge(
                            f['name'] as String,
                            (f['flag'] as SemanticsFlag).index,
                            Color(0xFF1565C0),
                            Color(0xFFBBDEFB),
                          ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    for (final f in visibilityFlagGroup)
                      _flagRow(
                        f['name'] as String,
                        f['desc'] as String,
                        (f['flag'] as SemanticsFlag).index,
                        Color(0xFF1565C0),
                      ),
                    SizedBox(height: 14.0),

                    _flagGroupHeader(
                      'Live region / grouping',
                      'live/implicitScroll/mutuallyExclusive',
                      Color(0xFF2E7D32),
                    ),
                    SizedBox(height: 6.0),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: [
                        for (final f in liveFlagGroup)
                          _flagBadge(
                            f['name'] as String,
                            (f['flag'] as SemanticsFlag).index,
                            Color(0xFF2E7D32),
                            Color(0xFFC8E6C9),
                          ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    for (final f in liveFlagGroup)
                      _flagRow(
                        f['name'] as String,
                        f['desc'] as String,
                        (f['flag'] as SemanticsFlag).index,
                        Color(0xFF2E7D32),
                      ),
                  ],
                ),
              ),

              SizedBox(height: 24.0),

              // ===== SECTION 4: SEMANTICS ACTION CATALOGUE =====
              _sectionContainer(
                bg: Color(0xFFE8F5E9),
                border: Color(0xFF81C784),
                title: '4. SemanticsAction Catalogue',
                titleColor: Color(0xFF1B5E20),
                subtitle:
                    'Interactions a screen reader / OS can request on a node.',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _flagGroupHeader(
                      'Touch & lifecycle',
                      'tap, longPress, focus, dismiss',
                      Color(0xFF2E7D32),
                    ),
                    SizedBox(height: 6.0),
                    for (final a in touchActions)
                      _actionRow(
                        a['name'] as String,
                        a['desc'] as String,
                        (a['action'] as SemanticsAction).index,
                        Color(0xFF2E7D32),
                        Color(0xFFC8E6C9),
                      ),
                    SizedBox(height: 14.0),

                    _flagGroupHeader(
                      'Scroll family',
                      'scrollLeft/Right/Up/Down/ToOffset',
                      Color(0xFF00838F),
                    ),
                    SizedBox(height: 6.0),
                    for (final a in scrollActions)
                      _actionRow(
                        a['name'] as String,
                        a['desc'] as String,
                        (a['action'] as SemanticsAction).index,
                        Color(0xFF00838F),
                        Color(0xFFB2EBF2),
                      ),
                    SizedBox(height: 14.0),

                    _flagGroupHeader(
                      'Value adjustment & clipboard',
                      'increase/decrease/setText/setSelection/copy/cut/paste',
                      Color(0xFFEF6C00),
                    ),
                    SizedBox(height: 6.0),
                    for (final a in adjustActions)
                      _actionRow(
                        a['name'] as String,
                        a['desc'] as String,
                        (a['action'] as SemanticsAction).index,
                        Color(0xFFEF6C00),
                        Color(0xFFFFE0B2),
                      ),
                    SizedBox(height: 14.0),

                    _flagGroupHeader(
                      'Text navigation & custom',
                      'cursor moves, showOnScreen, customAction',
                      Color(0xFF4527A0),
                    ),
                    SizedBox(height: 6.0),
                    for (final a in navActions)
                      _actionRow(
                        a['name'] as String,
                        a['desc'] as String,
                        (a['action'] as SemanticsAction).index,
                        Color(0xFF4527A0),
                        Color(0xFFD1C4E9),
                      ),
                  ],
                ),
              ),

              SizedBox(height: 24.0),

              // ===== SECTION 5: TREE COMPOSITION (MERGE/BLOCK/EXCLUDE) =====
              _sectionContainer(
                bg: Color(0xFFFFEBEE),
                border: Color(0xFFE57373),
                title: '5. Merge / Block / Exclude — tree composition',
                titleColor: Color(0xFFB71C1C),
                subtitle:
                    'How tree-composing widgets affect the reported accessibility tree.',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _compRow(
                      ['widget', 'subtree', 'siblings', 'announced'],
                      header: true,
                    ),
                    for (final row in compositionMatrix)
                      _compRow([
                        row['widget']!,
                        row['subtree']!,
                        row['siblings']!,
                        row['announced']!,
                      ]),
                    SizedBox(height: 14.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _treePanel(
                            title: 'MergeSemantics',
                            chipColor: Color(0xFFFFCDD2),
                            border: Color(0xFFEF9A9A),
                            steps: [
                              'Row',
                              ' Icon (label "star")',
                              ' Text "Favorite"',
                            ],
                            result: '"Favorite, star" — ONE node',
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: _treePanel(
                            title: 'BlockSemantics',
                            chipColor: Color(0xFFFFE0B2),
                            border: Color(0xFFFFB74D),
                            steps: [
                              'Stack',
                              ' Background tile',
                              ' BlockSemantics(Dialog)',
                            ],
                            result: 'Background dropped from tree',
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: _treePanel(
                            title: 'ExcludeSemantics',
                            chipColor: Color(0xFFCFD8DC),
                            border: Color(0xFF90A4AE),
                            steps: [
                              'Container',
                              ' ExcludeSemantics()',
                              '  Decorative SVG',
                            ],
                            result: 'Subtree completely silent',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14.0),
                    _recipeCard(
                      bg: Color(0xFFFFCDD2),
                      title: 'merge example',
                      code: 'MergeSemantics(child: Row(children: [Icon(Icons.star), Text("Favorite")]))',
                      codeColor: Color(0xFFB71C1C),
                    ),
                    SizedBox(height: 8.0),
                    _recipeCard(
                      bg: Color(0xFFFFE0B2),
                      title: 'block example',
                      code: 'Stack(children: [Background(), BlockSemantics(child: Dialog())])',
                      codeColor: Color(0xFFE65100),
                    ),
                    SizedBox(height: 8.0),
                    _recipeCard(
                      bg: Color(0xFFCFD8DC),
                      title: 'exclude example',
                      code: 'ExcludeSemantics(child: DecorativeFlourish())',
                      codeColor: Color(0xFF455A64),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.0),

              // ===== SECTION 6: LIVE REGIONS =====
              _sectionContainer(
                bg: Color(0xFFF1F8E9),
                border: Color(0xFFAED581),
                title: '6. Live Regions & Assertiveness',
                titleColor: Color(0xFF33691E),
                subtitle:
                    'Live regions automatically announce changes; assertiveness picks priority.',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final a in liveAssertiveness)
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFDCEDC8),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: a['tone'] as Color,
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  color: a['tone'] as Color,
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Text(
                                  (a['name'] as String).toUpperCase(),
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      a['desc'] as String,
                                      style: TextStyle(
                                        fontSize: 11.0,
                                        color: Color(0xFF1B5E20),
                                      ),
                                    ),
                                    SizedBox(height: 2.0),
                                    Text(
                                      'use case: ${a['when']}',
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        fontStyle: FontStyle.italic,
                                        color: Color(0xFF33691E),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: 8.0),
                    _recipeCard(
                      bg: Color(0xFFDCEDC8),
                      title: 'live region',
                      code: 'Semantics(\n  liveRegion: true,\n  label: "Connection restored",\n  child: child,\n)',
                      codeColor: Color(0xFF33691E),
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFC5E1A5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SemanticsEvent.announce(...)',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: Color(0xFF1B5E20),
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'SemanticsService.announce("Saved", TextDirection.ltr) pushes a one-shot announcement to the OS without needing a widget in the tree.',
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Color(0xFF33691E),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.0),

              // ===== SECTION 7: READING ORDER (OrdinalSortKey) =====
              _sectionContainer(
                bg: Color(0xFFE8EAF6),
                border: Color(0xFF9FA8DA),
                title: '7. Sortable Reading Order',
                titleColor: Color(0xFF1A237E),
                subtitle:
                    'OrdinalSortKey lets you override the default tree-order traversal.',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final row in readingOrder)
                      Padding(
                        padding: EdgeInsets.only(bottom: 6.0),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 8.0,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFC5CAE9),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 32.0,
                                height: 32.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFF283593),
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Center(
                                  child: Text(
                                    '${(row['order'] as double).toInt()}',
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      row['label'] as String,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1A237E),
                                      ),
                                    ),
                                    Text(
                                      row['note'] as String,
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        color: Color(0xFF303F9F),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'order=${row['order']}',
                                style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 11.0,
                                  color: Color(0xFF1A237E),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: 10.0),
                    _kvCard('OrdinalSortKey live objects', [
                      _kv('ordinalA', 'order=${ordinalA.order}, name=${ordinalA.name}'),
                      _kv('ordinalB', 'order=${ordinalB.order}, name=${ordinalB.name}'),
                      _kv('ordinalC', 'order=${ordinalC.order}, name=${ordinalC.name}'),
                      _kv('compareTo(A,B)', '$ordinalCmp'),
                    ]),
                    SizedBox(height: 8.0),
                    _recipeCard(
                      bg: Color(0xFFC5CAE9),
                      title: 'sortKey usage',
                      code: 'Semantics(\n  sortKey: OrdinalSortKey(1.0, name: "form-group"),\n  label: "Email",\n  child: child,\n)',
                      codeColor: Color(0xFF1A237E),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.0),

              // ===== SECTION 8: SEMANTICS TAGS & HINT OVERRIDES =====
              _sectionContainer(
                bg: Color(0xFFE0F2F1),
                border: Color(0xFF4DB6AC),
                title: '8. SemanticsTag & SemanticsHintOverrides',
                titleColor: Color(0xFF004D40),
                subtitle:
                    'Tags label nodes for selective lookup; hint overrides customise tap/long-press hints.',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _kvCard('SemanticsTag objects', [
                            _kv('tagButton', '"${tagButton.name}"'),
                            _kv('tagHeader', '"${tagHeader.name}"'),
                            _kv('tagCustom', '"${tagCustom.name}"'),
                            _kv('runtime', '${tagButton.runtimeType}'),
                          ]),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: _kvCard('Hint overrides', [
                            _kv('full.tap', '"${hintOverridesFull.onTapHint}"'),
                            _kv('full.long', '"${hintOverridesFull.onLongPressHint}"'),
                            _kv('full.isNotEmpty', '${hintOverridesFull.isNotEmpty}'),
                            _kv('tapOnly.tap', '"${hintOverridesTapOnly.onTapHint}"'),
                            _kv('empty.isNotEmpty', '${hintOverridesEmpty.isNotEmpty}'),
                          ]),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    _recipeCard(
                      bg: Color(0xFFB2DFDB),
                      title: 'tag attach',
                      code: 'Semantics(\n  tagForChildren: SemanticsTag("button-tag"),\n  child: child,\n)',
                      codeColor: Color(0xFF00695C),
                    ),
                    SizedBox(height: 8.0),
                    _recipeCard(
                      bg: Color(0xFFB2DFDB),
                      title: 'hint override',
                      code: 'Semantics(\n  onTap: doSomething,\n  hintOverrides: SemanticsHintOverrides(\n    onTapHint: "Activate button",\n    onLongPressHint: "Show options",\n  ),\n  child: child,\n)',
                      codeColor: Color(0xFF00695C),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.0),

              // ===== SECTION 9: COMPOSED FORM EXAMPLE =====
              _sectionContainer(
                bg: Color(0xFFFFF8E1),
                border: Color(0xFFFFD54F),
                title: '9. Composed Form Example',
                titleColor: Color(0xFFE65100),
                subtitle:
                    'A login form annotated with labels, hints, sort keys, and roles.',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final field in formFields)
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFECB3),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: Color(0xFFFFB300),
                              width: 1.0,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 28.0,
                                    height: 28.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFF8F00),
                                      borderRadius:
                                          BorderRadius.circular(14.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${(field['sortOrder'] as double).toInt()}',
                                        style: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                  Expanded(
                                    child: Text(
                                      field['label'] as String,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.0,
                                        color: Color(0xFFE65100),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6.0,
                                      vertical: 2.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFEF6C00),
                                      borderRadius:
                                          BorderRadius.circular(4.0),
                                    ),
                                    child: Text(
                                      field['role'] as String,
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 10.0,
                                        fontFamily: 'monospace',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6.0),
                              _kv('value', '${field['value']}'),
                              _kv('hint', '${field['hint']}'),
                              _kv('sortKey', 'OrdinalSortKey(${field['sortOrder']})'),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: 8.0),
                    _recipeCard(
                      bg: Color(0xFFFFECB3),
                      title: 'form field recipe',
                      code: 'Semantics(\n  textField: true,\n  label: "Email",\n  hint: "Enter the email used for sign-in.",\n  sortKey: OrdinalSortKey(1.0),\n  child: TextField(...),\n)',
                      codeColor: Color(0xFFE65100),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.0),

              // ===== SECTION 10: LIST EXAMPLE (IndexedSemantics) =====
              _sectionContainer(
                bg: Color(0xFFE1F5FE),
                border: Color(0xFF4FC3F7),
                title: '10. List Example — IndexedSemantics',
                titleColor: Color(0xFF01579B),
                subtitle:
                    'Scrollable lists use IndexedSemantics so readers can announce "item N of M".',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final item in listItems)
                      Padding(
                        padding: EdgeInsets.only(bottom: 6.0),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFB3E5FC),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFF0277BD),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Center(
                                  child: Text(
                                    '#${item['index']}',
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                      fontFamily: 'monospace',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['title'] as String,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF01579B),
                                      ),
                                    ),
                                    Text(
                                      item['meta'] as String,
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        color: Color(0xFF0277BD),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.0,
                                  vertical: 2.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFF01579B),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  'item ${(item['index'] as int) + 1} of ${listItems.length}',
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 9.0,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: 8.0),
                    _recipeCard(
                      bg: Color(0xFFB3E5FC),
                      title: 'IndexedSemantics',
                      code: 'IndexedSemantics(\n  index: i,\n  child: ListTile(...),\n)',
                      codeColor: Color(0xFF01579B),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.0),

              // ===== SECTION 11: DIALOG EXAMPLE (scopesRoute) =====
              _sectionContainer(
                bg: Color(0xFFFCE4EC),
                border: Color(0xFFF06292),
                title: '11. Dialog Example — scopesRoute / namesRoute',
                titleColor: Color(0xFF880E4F),
                subtitle:
                    'Modal dialogs are routes; semantics use scopesRoute and namesRoute to announce them.',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final scope in dialogScopes)
                      Padding(
                        padding: EdgeInsets.only(bottom: 6.0),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFF8BBD0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFFAD1457),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Text(
                                  scope['name'] as String,
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 11.0,
                                    fontFamily: 'monospace',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      scope['desc'] as String,
                                      style: TextStyle(
                                        fontSize: 11.0,
                                        color: Color(0xFF880E4F),
                                      ),
                                    ),
                                    SizedBox(height: 2.0),
                                    Text(
                                      'used at: ${scope['used']}',
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        fontStyle: FontStyle.italic,
                                        color: Color(0xFFAD1457),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: 10.0),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFF48FB1),
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: Color(0xFFAD1457),
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF880E4F),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Text(
                              'MOCK DIALOG: "Delete project?"',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'This dialog body is wrapped in Semantics(scopesRoute: true, explicitChildNodes: true, namesRoute: true, label: "Delete project").',
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Color(0xFF880E4F),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              _mockButton('Cancel', Color(0xFFEC407A)),
                              SizedBox(width: 8.0),
                              _mockButton('Delete', Color(0xFFC2185B)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    _recipeCard(
                      bg: Color(0xFFF8BBD0),
                      title: 'dialog recipe',
                      code: 'Semantics(\n  scopesRoute: true,\n  namesRoute: true,\n  explicitChildNodes: true,\n  label: "Delete project",\n  child: dialogBody,\n)',
                      codeColor: Color(0xFF880E4F),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.0),

              // ===== SECTION 12: RECIPE GALLERY =====
              _sectionContainer(
                bg: Color(0xFFECEFF1),
                border: Color(0xFF90A4AE),
                title: '12. Composed Semantics(...) Recipes',
                titleColor: Color(0xFF263238),
                subtitle:
                    'Canonical Semantics invocations grouped by role / state / tree / live.',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final r in recipeCards)
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFCFD8DC),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6.0,
                                      vertical: 2.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _familyColor(
                                        r['family'] as String,
                                      ),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Text(
                                      (r['family'] as String).toUpperCase(),
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 9.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    r['title'] as String,
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF263238),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6.0),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Color(0xFF263238),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    r['code'] as String,
                                    style: TextStyle(
                                      fontFamily: 'monospace',
                                      fontSize: 10.0,
                                      color: Color(0xFFB2DFDB),
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
              ),

              SizedBox(height: 24.0),

              // ===== SECTION 13: FOCUS GLOW VISUALISATION =====
              _sectionContainer(
                bg: Color(0xFFE3F2FD),
                border: Color(0xFF64B5F6),
                title: '13. Focus Glow & Animation Snapshot',
                titleColor: Color(0xFF0D47A1),
                subtitle:
                    'A static AlwaysStoppedAnimation<double> drives a stylised focus ring.',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 96.0,
                          height: 96.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFBBDEFB),
                            borderRadius:
                                BorderRadius.circular(ringRadius),
                            border: Border.all(
                              color: ringGlowColor,
                              width: 4.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: ringGlowColor,
                                blurRadius: 12.0,
                                spreadRadius: 2.0,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'FOCUS',
                              style: TextStyle(
                                color: Color(0xFF0D47A1),
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 14.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _kv('animation.value', '${focusGlow.value}'),
                              _kv('alpha (0-255)', '$focusGlowAlpha'),
                              _kv('ring radius', '${ringRadius.toStringAsFixed(2)}'),
                              _kv('arc (rad)', '${pi2.toStringAsFixed(3)}'),
                              _kv('tick duration', '${tickDurationMs}ms'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    _recipeCard(
                      bg: Color(0xFFBBDEFB),
                      title: 'focus glow recipe',
                      code: 'final t = AlwaysStoppedAnimation<double>(0.7);\nfinal alpha = (t.value * 255).round() & 0xFF;\nfinal glow = Color.fromARGB(alpha, 26, 35, 126);',
                      codeColor: Color(0xFF0D47A1),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.0),

              // ===== SECTION 14: ATLAS METRICS =====
              _sectionContainer(
                bg: Color(0xFFF3E5F5),
                border: Color(0xFFCE93D8),
                title: '14. Atlas Metrics',
                titleColor: Color(0xFF4A148C),
                subtitle:
                    'How many widgets, flags, actions, recipes are covered by this atlas.',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final m in atlasMetrics)
                      Padding(
                        padding: EdgeInsets.only(bottom: 4.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 6.0,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFE1BEE7),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  m['metric']!,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Color(0xFF4A148C),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 2.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFF6A1B9A),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  m['value']!,
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontFamily: 'monospace',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              SizedBox(height: 24.0),

              // ===== SECTION 15: GLOSSARY =====
              _sectionContainer(
                bg: Color(0xFFFAFAFA),
                border: Color(0xFFBDBDBD),
                title: '15. Glossary',
                titleColor: Color(0xFF212121),
                subtitle:
                    'Key terms in the Semantics surface, in alphabetical order.',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final g in glossary)
                      _glossaryItem(g['term']!, g['def']!),
                  ],
                ),
              ),

              SizedBox(height: 24.0),

              // ===== EPILOGUE =====
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF1A237E),
                      Color(0xFF311B92),
                      Color(0xFF4A148C),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Atlas Epilogue',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Semantics is the contract Flutter makes with assistive technologies. '
                      'Every section of this atlas — primitives, vocabulary, flag taxonomy, '
                      'action catalogue, tree composition, live regions, sortable reading order, '
                      'tags, hint overrides, composed form / list / dialog examples — is a face '
                      'of that contract. Build accessible apps by being deliberate at every node: '
                      'label, hint, role, state, and order.',
                      style: TextStyle(
                        color: Color(0xFFEDE7F6),
                        fontSize: 12.0,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 14.0),
                    _summaryItem('Sections covered', '15'),
                    _summaryItem('Flags catalogued', '$totalFlagCount'),
                    _summaryItem('Actions catalogued', '$totalActionCount'),
                    _summaryItem('Composed recipes', '${recipeCards.length}'),
                    _summaryItem(
                      'Worked examples',
                      'form / list / dialog',
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 6.0,
                      ),
                      decoration: BoxDecoration(
                        color: epilogueColor,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        'Atlas signed off at HSV-derived tint ${epilogueColor.value.toRadixString(16)}',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontFamily: 'monospace',
                          fontSize: 11.0,
                        ),
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

// ============================================================================
// HELPER WIDGETS
// ============================================================================

Widget _heroChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: Color(0x33FFFFFF),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Color(0x44FFFFFF), width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 11.0,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _heroStat(String label, String value, Color labelColor, Color border) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Color(0x22FFFFFF),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: border, width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label:',
          style: TextStyle(
            color: labelColor,
            fontSize: 10.0,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(width: 4.0),
        Text(
          value,
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _legendCard() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFEDE7F6),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFB39DDB), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color(0xFF4527A0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                'LEGEND',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0,
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'Atlas reading guide',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF311B92),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _legendChip('state', Color(0xFFD84315), Color(0xFFFFCCBC)),
            _legendChip('role', Color(0xFF6A1B9A), Color(0xFFE1BEE7)),
            _legendChip('visibility', Color(0xFF1565C0), Color(0xFFBBDEFB)),
            _legendChip('live/group', Color(0xFF2E7D32), Color(0xFFC8E6C9)),
            _legendChip('tree', Color(0xFFB71C1C), Color(0xFFFFCDD2)),
            _legendChip('list', Color(0xFF01579B), Color(0xFFB3E5FC)),
          ],
        ),
        SizedBox(height: 12.0),
        _bulletLine('1. Primitives    — Semantics, MergeSemantics, BlockSemantics, ExcludeSemantics, IndexedSemantics'),
        _bulletLine('2. Vocabulary    — label, hint, value, increasedValue, decreasedValue, tooltip'),
        _bulletLine('3. Flag taxonomy — boolean states, roles, visibility, live'),
        _bulletLine('4. Action catalogue — touch, scroll, adjust, navigation'),
        _bulletLine('5. Tree composition — merge / block / exclude matrix'),
        _bulletLine('6. Live regions  — polite vs assertive announcements'),
        _bulletLine('7. Reading order — OrdinalSortKey traversal control'),
        _bulletLine('8. Tags & hints  — SemanticsTag, SemanticsHintOverrides'),
        _bulletLine('9. Worked form   — composed example with sortKeys'),
        _bulletLine('10. List example — IndexedSemantics in a scrollable'),
        _bulletLine('11. Dialog example — scopesRoute / namesRoute'),
        _bulletLine('12. Recipe gallery — canonical Semantics() invocations'),
        _bulletLine('13. Focus glow   — animation snapshot visualisation'),
        _bulletLine('14. Atlas metrics — coverage counters'),
        _bulletLine('15. Glossary     — key term definitions'),
      ],
    ),
  );
}

Widget _legendChip(String label, Color fg, Color bg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: fg, width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: fg,
        fontSize: 10.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _bulletLine(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 3.0),
    child: Text(
      text,
      style: TextStyle(fontSize: 11.0, fontFamily: 'monospace'),
    ),
  );
}

Widget _sectionContainer({
  required Color bg,
  required Color border,
  required String title,
  required Color titleColor,
  required String subtitle,
  required Widget child,
}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: border, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x11000000),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          subtitle,
          style: TextStyle(fontSize: 12.0, color: Color(0xFF616161)),
        ),
        SizedBox(height: 14.0),
        child,
      ],
    ),
  );
}

Widget _recipeCard({
  required Color bg,
  required String title,
  required String code,
  required Color codeColor,
}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: codeColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                title.toUpperCase(),
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              code,
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: Color(0xFFB2DFDB),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _kv(String key, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$key:',
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF311B92),
          ),
        ),
        SizedBox(width: 4.0),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 10.0,
              fontFamily: 'monospace',
              color: Color(0xFF1A237E),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _kvCard(String title, List<Widget> rows) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Color(0xFFEDE7F6),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(0xFFB39DDB), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF311B92),
          ),
        ),
        SizedBox(height: 6.0),
        ...rows,
      ],
    ),
  );
}

Widget _compRow(List<String> cells, {bool header = false}) {
  return Container(
    margin: EdgeInsets.only(bottom: 2.0),
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: header ? Color(0xFFB71C1C) : Color(0xFFFFCDD2),
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Row(
      children: [
        for (final cell in cells)
          Expanded(
            child: Text(
              cell,
              style: TextStyle(
                fontSize: 11.0,
                fontFamily: 'monospace',
                fontWeight: header ? FontWeight.bold : FontWeight.normal,
                color: header ? Color(0xFFFFFFFF) : Color(0xFFB71C1C),
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _flagGroupHeader(String title, String subtitle, Color tone) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: 6.0,
        height: 22.0,
        decoration: BoxDecoration(
          color: tone,
          borderRadius: BorderRadius.circular(3.0),
        ),
      ),
      SizedBox(width: 8.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: tone,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10.0,
                color: Color(0xFF616161),
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _flagBadge(String name, int index, Color fg, Color bg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: fg, width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          style: TextStyle(
            color: fg,
            fontSize: 10.0,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
          decoration: BoxDecoration(
            color: fg,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            '$index',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 9.0,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _flagRow(String name, String desc, int index, Color tone) {
  return Padding(
    padding: EdgeInsets.only(bottom: 4.0),
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF).withOpacity(0.65),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: tone.withOpacity(0.4), width: 1.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28.0,
            padding: EdgeInsets.symmetric(vertical: 2.0),
            decoration: BoxDecoration(
              color: tone,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Center(
              child: Text(
                '$index',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: TextStyle(
                fontSize: 11.0,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                color: tone,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              desc,
              style: TextStyle(
                fontSize: 11.0,
                color: Color(0xFF263238),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _actionRow(String name, String desc, int index, Color tone, Color bg) {
  return Padding(
    padding: EdgeInsets.only(bottom: 4.0),
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: tone,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'bit $index',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 9.0,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            flex: 3,
            child: Text(
              name,
              style: TextStyle(
                fontSize: 11.0,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                color: tone,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              desc,
              style: TextStyle(
                fontSize: 11.0,
                color: Color(0xFF263238),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _treePanel({
  required String title,
  required Color chipColor,
  required Color border,
  required List<String> steps,
  required String result,
}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: chipColor,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: border, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
            color: Color(0xFF263238),
          ),
        ),
        SizedBox(height: 6.0),
        for (final s in steps)
          Padding(
            padding: EdgeInsets.only(bottom: 2.0),
            child: Text(
              s,
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: Color(0xFF263238),
              ),
            ),
          ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            result,
            style: TextStyle(
              color: Color(0xFFB2DFDB),
              fontFamily: 'monospace',
              fontSize: 9.0,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _familyBadge(String family) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
    decoration: BoxDecoration(
      color: _familyColor(family),
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Text(
      family.toUpperCase(),
      style: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 9.0,
        fontFamily: 'monospace',
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Color _familyColor(String family) {
  if (family == 'core') return Color(0xFF512DA8);
  if (family == 'tree') return Color(0xFFB71C1C);
  if (family == 'list') return Color(0xFF01579B);
  if (family == 'role') return Color(0xFF6A1B9A);
  if (family == 'state') return Color(0xFFD84315);
  if (family == 'live') return Color(0xFF2E7D32);
  return Color(0xFF455A64);
}

Widget _mockButton(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 11.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _glossaryItem(String term, String definition) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 130.0,
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Color(0xFF607D8B),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            term,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 10.0,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            definition,
            style: TextStyle(fontSize: 11.0, color: Color(0xFF37474F)),
          ),
        ),
      ],
    ),
  );
}

Widget _summaryItem(String label, String status) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6.0),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 13.0),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

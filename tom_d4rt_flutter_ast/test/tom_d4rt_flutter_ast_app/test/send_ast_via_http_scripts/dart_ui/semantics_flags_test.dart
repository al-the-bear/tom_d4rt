// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import
// D4rt test script: Deep visual demonstration of dart:ui SemanticsFlag accessibility flags.
//
// SemanticsFlag is the canonical Flutter engine type that exposes a fixed
// set of boolean accessibility traits. Each flag describes a *meaning*
// that assistive technology (TalkBack, VoiceOver, NVDA, JAWS) uses to
// announce widgets correctly. This file walks through the full enum,
// grouped by purpose, with cards, recipes, pitfalls, comparison tables
// and an ASCII reference, so that the rendered output works as a
// learning poster for the SemanticsFlag API.
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // Static animations (no motion). Used to satisfy the "static motion
  // only" requirement of the deep demo: AlwaysStoppedAnimation +
  // Duration.zero.
  // ============================================================
  final AlwaysStoppedAnimation<double> stopFull =
      AlwaysStoppedAnimation<double>(1.0);
  final AlwaysStoppedAnimation<double> stopHalf =
      AlwaysStoppedAnimation<double>(0.5);
  final AlwaysStoppedAnimation<double> stopZero =
      AlwaysStoppedAnimation<double>(0.0);
  final Duration zeroDuration = Duration.zero;

  // ============================================================
  // SECTION 1: Hero Header
  // ============================================================
  final Widget heroHeader = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF0D47A1),
          Color(0xFF1565C0),
          Color(0xFF6A1B9A),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Colors.purple.withValues(alpha: 0.30),
          blurRadius: 40.0,
          offset: Offset(0.0, 20.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Opacity(
          opacity: stopFull.value,
          child: Icon(
            Icons.accessibility_new,
            size: 72.0,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'dart:ui SemanticsFlag',
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'A complete visual reference for accessibility flags',
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.white.withValues(alpha: 0.85),
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 16.0),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildBadge('TalkBack', Colors.green),
            _buildBadge('VoiceOver', Colors.cyan),
            _buildBadge('NVDA', Colors.amber),
            _buildBadge('JAWS', Colors.deepOrange),
            _buildBadge('Switch Access', Colors.pink),
          ],
        ),
        SizedBox(height: 20.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.55),
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.flag, size: 18.0, color: Colors.white),
              SizedBox(width: 8.0),
              Text(
                '${ui.SemanticsFlag.values.length} flags total',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy of an accessibility flag
  // ============================================================
  final Widget anatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade50, Colors.cyan.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.science, color: Colors.teal.shade700, size: 26.0),
            SizedBox(width: 10.0),
            Text(
              'Anatomy of a SemanticsFlag',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Every SemanticsFlag is a tiny constant with two observable parts: a unique '
          'integer index that maps to a bit position in the engine, and a human-readable '
          'name used in toString() output. They never carry data; they are pure tags that '
          'describe what a node represents to assistive tools.',
          style: TextStyle(fontSize: 13.5, height: 1.45),
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.teal.shade200, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _anatomyRow(
                Icons.tag,
                'index',
                'Bit position used by the engine to encode the flag.',
                Colors.indigo,
              ),
              SizedBox(height: 10.0),
              _anatomyRow(
                Icons.text_fields,
                'toString()',
                'Human-readable form like SemanticsFlag.isButton.',
                Colors.deepPurple,
              ),
              SizedBox(height: 10.0),
              _anatomyRow(
                Icons.collections_bookmark,
                'values',
                'Static list of every flag, ordered by their index.',
                Colors.green,
              ),
              SizedBox(height: 10.0),
              _anatomyRow(
                Icons.swap_horiz,
                'paired flags',
                'Many flags come in pairs: hasFooState + isFoo.',
                Colors.orange,
              ),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        _buildCodeBlock(
          'final flag = ui.SemanticsFlag.isButton;\n'
          'print(flag);            // SemanticsFlag.isButton\n'
          'print(flag.index);      // engine bit position\n'
          'final all = ui.SemanticsFlag.values;\n'
          'print(all.length);      // total number of flags',
          Colors.cyan.shade200,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Interactivity flags (button, link, slider, key, textfield)
  // ============================================================
  final List<_FlagSpec> interactivityFlags = [
    _FlagSpec(
      flag: ui.SemanticsFlag.isButton,
      title: 'isButton',
      headline: 'Tap target that performs an action',
      description:
          'Signals that the node behaves like a button. Screen readers append '
          '"button" to its label so users know it is tappable.',
      icon: Icons.smart_button,
      color: Colors.deepOrange,
      example: 'IconButton(onPressed: ..., icon: Icon(Icons.save))',
    ),
    _FlagSpec(
      flag: ui.SemanticsFlag.isLink,
      title: 'isLink',
      headline: 'Navigates to another destination',
      description:
          'Indicates the node is a hyperlink. Distinguished from button so '
          'navigation actions can be announced as "link" instead of "button".',
      icon: Icons.link,
      color: Colors.blue,
      example: 'GestureDetector(onTap: launchUrl, child: Text("Open"))',
    ),
    _FlagSpec(
      flag: ui.SemanticsFlag.isSlider,
      title: 'isSlider',
      headline: 'Adjustable continuous value',
      description:
          'Identifies an adjustable control that responds to increment and '
          'decrement gestures from assistive tech.',
      icon: Icons.tune,
      color: Colors.purple,
      example: 'Slider(value: v, onChanged: (x) => setState(...))',
    ),
    _FlagSpec(
      flag: ui.SemanticsFlag.isTextField,
      title: 'isTextField',
      headline: 'Editable text input region',
      description:
          'Marks the node as a text input. AT may show edit controls and '
          'speak content as the user types.',
      icon: Icons.text_fields,
      color: Colors.indigo,
      example: 'TextField(controller: c, decoration: ...)',
    ),
    _FlagSpec(
      flag: ui.SemanticsFlag.isKeyboardKey,
      title: 'isKeyboardKey',
      headline: 'Single key in an on-screen keyboard',
      description:
          'Used for individual keys in a virtual keyboard so they are '
          'announced but not treated like generic buttons.',
      icon: Icons.keyboard,
      color: Colors.brown,
      example: 'KeyboardKey(label: "A", onPressed: ...)',
    ),
    _FlagSpec(
      flag: ui.SemanticsFlag.isImage,
      title: 'isImage',
      headline: 'Pictorial content with an alt label',
      description:
          'Marks the node as a graphic. Screen readers announce "image" so '
          'users know the label is describing visuals.',
      icon: Icons.image,
      color: Colors.cyan,
      example: 'Semantics(label: "Logo", image: true, child: ...)',
    ),
  ];

  // ============================================================
  // SECTION 4: State flags (checked, toggled, selected, expanded, ...)
  // ============================================================
  final List<_FlagSpec> stateFlags = [
    _FlagSpec(
      flag: ui.SemanticsFlag.hasCheckedState,
      title: 'hasCheckedState',
      headline: 'Node participates in checkbox semantics',
      description:
          'Required pair flag for isChecked. Without it, isChecked is not '
          'announced. Used by Checkbox-like widgets.',
      icon: Icons.check_box_outline_blank,
      color: Colors.green,
      example: 'Checkbox(value: ..., onChanged: ...)',
    ),
    _FlagSpec(
      flag: ui.SemanticsFlag.isChecked,
      title: 'isChecked',
      headline: 'Currently in the checked state',
      description:
          'Announces "checked". Must be paired with hasCheckedState. '
          'Mutually exclusive with isCheckStateMixed.',
      icon: Icons.check_box,
      color: Colors.green,
      example: 'Checkbox(value: true, onChanged: ...)',
    ),
    _FlagSpec(
      flag: ui.SemanticsFlag.isCheckStateMixed,
      title: 'isCheckStateMixed',
      headline: 'Tri-state checkbox in mixed state',
      description:
          'Indicates a tri-state checkbox is in the indeterminate state. '
          'Requires hasCheckedState as well.',
      icon: Icons.indeterminate_check_box,
      color: Colors.amber,
      example: 'Checkbox(tristate: true, value: null, ...)',
    ),
    _FlagSpec(
      flag: ui.SemanticsFlag.hasToggledState,
      title: 'hasToggledState',
      headline: 'Node participates in switch semantics',
      description:
          'Pair flag for isToggled. Differs from hasCheckedState: switches '
          'announce "switch" / "on/off" instead of "checked".',
      icon: Icons.toggle_off,
      color: Colors.deepPurple,
      example: 'Switch(value: ..., onChanged: ...)',
    ),
    _FlagSpec(
      flag: ui.SemanticsFlag.isToggled,
      title: 'isToggled',
      headline: 'Switch is in the on position',
      description:
          'Announces "on" for switch-like controls. Must be paired with '
          'hasToggledState.',
      icon: Icons.toggle_on,
      color: Colors.deepPurple,
      example: 'Switch(value: true, onChanged: ...)',
    ),
    _FlagSpec(
      flag: ui.SemanticsFlag.hasSelectedState,
      title: 'hasSelectedState',
      headline: 'Node participates in selection semantics',
      description:
          'Pair flag for isSelected. Lets AT distinguish "selectable" nodes '
          'from purely informational ones.',
      icon: Icons.radio_button_unchecked,
      color: Colors.teal,
      example: 'ListTile(selected: ..., ...)',
    ),
    _FlagSpec(
      flag: ui.SemanticsFlag.isSelected,
      title: 'isSelected',
      headline: 'Currently selected in a group',
      description:
          'Announces "selected". Combine with isInMutuallyExclusiveGroup for '
          'radio-style behaviour.',
      icon: Icons.radio_button_checked,
      color: Colors.teal,
      example: 'Tab(selected: true, child: ...)',
    ),
    _FlagSpec(
      flag: ui.SemanticsFlag.hasEnabledState,
      title: 'hasEnabledState',
      headline: 'Node has an enable/disable concept',
      description:
          'Pair flag for isEnabled. Without it, isEnabled would be invisible '
          'to AT.',
      icon: Icons.power_settings_new,
      color: Colors.lime,
      example: 'ElevatedButton(onPressed: null, ...)  // disabled',
    ),
    _FlagSpec(
      flag: ui.SemanticsFlag.isEnabled,
      title: 'isEnabled',
      headline: 'Currently enabled and interactive',
      description:
          'When false, AT announces the node as "disabled" or "dimmed". '
          'Must be paired with hasEnabledState.',
      icon: Icons.power,
      color: Colors.lime,
      example: 'TextButton(onPressed: () {}, child: ...)',
    ),
    _FlagSpec(
      flag: ui.SemanticsFlag.hasExpandedState,
      title: 'hasExpandedState',
      headline: 'Collapsible region pair flag',
      description:
          'Pair flag for isExpanded. Used by ExpansionTile, Drawer headers, '
          'and similar disclosure widgets.',
      icon: Icons.unfold_more,
      color: Colors.orange,
      example: 'ExpansionTile(initiallyExpanded: false, ...)',
    ),
    _FlagSpec(
      flag: ui.SemanticsFlag.isExpanded,
      title: 'isExpanded',
      headline: 'Currently expanded / open',
      description:
          'Announces "expanded" vs "collapsed". Must be paired with '
          'hasExpandedState.',
      icon: Icons.unfold_less,
      color: Colors.orange,
      example: 'ExpansionTile(initiallyExpanded: true, ...)',
    ),
    _FlagSpec(
      flag: ui.SemanticsFlag.hasRequiredState,
      title: 'hasRequiredState',
      headline: 'Form field has a required concept',
      description:
          'Pair flag for isRequired. Lets forms communicate which inputs '
          'must be filled in for submission.',
      icon: Icons.assignment_late_outlined,
      color: Colors.red,
      example: 'TextFormField(validator: requiredValidator, ...)',
    ),
    _FlagSpec(
      flag: ui.SemanticsFlag.isRequired,
      title: 'isRequired',
      headline: 'Field must be provided',
      description:
          'Announces "required". Must be paired with hasRequiredState. '
          'Useful for mandatory form inputs.',
      icon: Icons.priority_high,
      color: Colors.red,
      example: 'Semantics(required: true, child: TextField(...))',
    ),
    _FlagSpec(
      flag: ui.SemanticsFlag.isFocused,
      title: 'isFocused',
      headline: 'Owns keyboard focus right now',
      description:
          'Announces that this node is the current focus. Combine with '
          'isFocusable so AT understands the focus path.',
      icon: Icons.center_focus_strong,
      color: Colors.amber,
      example: 'FocusNode().requestFocus()',
    ),
    _FlagSpec(
      flag: ui.SemanticsFlag.isFocusable,
      title: 'isFocusable',
      headline: 'Eligible to receive focus',
      description:
          'Static capability flag. Different from isFocused; many nodes are '
          'focusable but not currently focused.',
      icon: Icons.center_focus_weak,
      color: Colors.amber,
      example: 'Focus(child: ...)',
    ),
  ];

  // ============================================================
  // SECTION 5: Role flags (header, route, live region, hidden, obscured...)
  // ============================================================
  final List<_FlagSpec> roleFlags = [
    _FlagSpec(
      flag: ui.SemanticsFlag.isHeader,
      title: 'isHeader',
      headline: 'Section header / heading level',
      description:
          'Marks the node as a heading. Screen reader users navigate by '
          'headings, so this dramatically improves discoverability.',
      icon: Icons.title,
      color: Colors.indigo,
      example: 'Semantics(header: true, child: Text("Settings"))',
    ),
    _FlagSpec(
      flag: ui.SemanticsFlag.scopesRoute,
      title: 'scopesRoute',
      headline: 'Defines a route boundary',
      description:
          'Marks the subtree as a logical screen / dialog. AT uses this to '
          'know when a new context has appeared.',
      icon: Icons.layers,
      color: Colors.blueGrey,
      example: 'Route boundary nodes inside a Dialog or Page.',
    ),
    _FlagSpec(
      flag: ui.SemanticsFlag.namesRoute,
      title: 'namesRoute',
      headline: 'Provides the route\'s spoken name',
      description:
          'Indicates the node\'s label should be used as the route\'s name. '
          'Often combined with scopesRoute on the screen title.',
      icon: Icons.label_important,
      color: Colors.blueGrey,
      example: 'Semantics(namesRoute: true, child: Text("Profile"))',
    ),
    _FlagSpec(
      flag: ui.SemanticsFlag.isLiveRegion,
      title: 'isLiveRegion',
      headline: 'Announce updates politely',
      description:
          'When the subtree changes, AT speaks the new content automatically '
          '(e.g. snackbars, toasts, error banners).',
      icon: Icons.podcasts,
      color: Colors.pink,
      example: 'Semantics(liveRegion: true, child: snackBar)',
    ),
    _FlagSpec(
      flag: ui.SemanticsFlag.isHidden,
      title: 'isHidden',
      headline: 'Excluded from AT, still painted',
      description:
          'Lets you hide decorative siblings while keeping them visible. '
          'Great for offscreen carousels and hero animations.',
      icon: Icons.visibility_off,
      color: Colors.grey,
      example: 'Semantics(excludeSemantics: true, child: ...)',
    ),
    _FlagSpec(
      flag: ui.SemanticsFlag.isObscured,
      title: 'isObscured',
      headline: 'Content is masked (e.g. password)',
      description:
          'AT will not read the literal characters; it announces that input '
          'is obscured.',
      icon: Icons.password,
      color: Colors.deepPurple,
      example: 'TextField(obscureText: true, ...)',
    ),
    _FlagSpec(
      flag: ui.SemanticsFlag.isMultiline,
      title: 'isMultiline',
      headline: 'Multi-line text content',
      description:
          'Used by editors and large text blocks so AT can navigate by '
          'lines instead of treating the whole content as one string.',
      icon: Icons.notes,
      color: Colors.brown,
      example: 'TextField(maxLines: null, ...)',
    ),
    _FlagSpec(
      flag: ui.SemanticsFlag.isReadOnly,
      title: 'isReadOnly',
      headline: 'Display-only field',
      description:
          'Announces "read only" so users know they cannot edit the field, '
          'even though it looks editable.',
      icon: Icons.lock_outline,
      color: Colors.grey,
      example: 'TextField(readOnly: true, controller: c)',
    ),
    _FlagSpec(
      flag: ui.SemanticsFlag.hasImplicitScrolling,
      title: 'hasImplicitScrolling',
      headline: 'Subtree is implicitly scrollable',
      description:
          'AT uses this to scroll a region into view when focusing children, '
          'even if the user did not explicitly scroll.',
      icon: Icons.swap_vert,
      color: Colors.cyan,
      example: 'ListView(...) with implicit scrolling',
    ),
    _FlagSpec(
      flag: ui.SemanticsFlag.isInMutuallyExclusiveGroup,
      title: 'isInMutuallyExclusiveGroup',
      headline: 'Radio-style group member',
      description:
          'Hint that only one sibling can be isSelected at a time. Combine '
          'with isSelected for radio buttons, segmented controls, tabs.',
      icon: Icons.radio_button_checked,
      color: Colors.lightGreen,
      example: 'Radio<int>(value: 1, groupValue: g, onChanged: ...)',
    ),
  ];

  // ============================================================
  // SECTION 6: Group cards
  // ============================================================
  final Widget interactivityCards =
      _buildFlagGroup('Interactivity flags', interactivityFlags, Colors.blue);
  final Widget stateCards =
      _buildFlagGroup('State flags', stateFlags, Colors.green);
  final Widget roleCards =
      _buildFlagGroup('Role / structure flags', roleFlags, Colors.deepPurple);

  // ============================================================
  // SECTION 7: Accessibility recipes
  // ============================================================
  final List<_RecipeSpec> recipes = [
    _RecipeSpec(
      title: 'Toggleable button',
      description:
          'A button that can be on or off. Combines isButton, hasToggledState '
          'and isToggled.',
      icon: Icons.toggle_on,
      color: Colors.deepPurple,
      flags: const [
        'isButton',
        'hasToggledState',
        'isToggled',
        'hasEnabledState',
        'isEnabled',
        'isFocusable',
      ],
      code: 'Semantics(\n'
          '  button: true,\n'
          '  toggled: true,\n'
          '  enabled: true,\n'
          '  child: ...,\n'
          ')',
    ),
    _RecipeSpec(
      title: 'Tri-state checkbox',
      description:
          'Form checkbox that can be off, on, or mixed. Pairs hasCheckedState '
          'with either isChecked or isCheckStateMixed.',
      icon: Icons.check_box,
      color: Colors.green,
      flags: const [
        'hasCheckedState',
        'isChecked',
        'isCheckStateMixed',
        'isFocusable',
      ],
      code: 'Semantics(\n'
          '  checked: state == true,\n'
          '  mixed: state == null,\n'
          '  child: Checkbox(...),\n'
          ')',
    ),
    _RecipeSpec(
      title: 'Radio group member',
      description:
          'Single radio button inside a group. Uses isSelected and '
          'isInMutuallyExclusiveGroup so AT knows it is part of a set.',
      icon: Icons.radio_button_checked,
      color: Colors.teal,
      flags: const [
        'hasSelectedState',
        'isSelected',
        'isInMutuallyExclusiveGroup',
        'isFocusable',
      ],
      code: 'Semantics(\n'
          '  selected: groupValue == value,\n'
          '  inMutuallyExclusiveGroup: true,\n'
          '  child: Radio<T>(...),\n'
          ')',
    ),
    _RecipeSpec(
      title: 'Required text field',
      description:
          'Mandatory text field with read-only fallback. Combines isTextField, '
          'isRequired and isFocusable.',
      icon: Icons.assignment,
      color: Colors.red,
      flags: const [
        'isTextField',
        'hasRequiredState',
        'isRequired',
        'hasEnabledState',
        'isEnabled',
        'isFocusable',
      ],
      code: 'Semantics(\n'
          '  textField: true,\n'
          '  required: true,\n'
          '  child: TextField(...),\n'
          ')',
    ),
    _RecipeSpec(
      title: 'Section heading',
      description:
          'A visually styled header that AT also announces as a heading. '
          'Just isHeader is required.',
      icon: Icons.title,
      color: Colors.indigo,
      flags: const [
        'isHeader',
      ],
      code: 'Semantics(\n'
          '  header: true,\n'
          '  child: Text("Settings"),\n'
          ')',
    ),
    _RecipeSpec(
      title: 'Live region (toast)',
      description:
          'Region that should be spoken whenever its content changes. '
          'Use isLiveRegion sparingly to avoid noise.',
      icon: Icons.podcasts,
      color: Colors.pink,
      flags: const [
        'isLiveRegion',
      ],
      code: 'Semantics(\n'
          '  liveRegion: true,\n'
          '  child: snackBarMessage,\n'
          ')',
    ),
    _RecipeSpec(
      title: 'Page route',
      description:
          'The root of a screen. scopesRoute marks the boundary while '
          'namesRoute provides the spoken name.',
      icon: Icons.layers,
      color: Colors.blueGrey,
      flags: const [
        'scopesRoute',
        'namesRoute',
      ],
      code: 'Semantics(\n'
          '  scopesRoute: true,\n'
          '  namesRoute: true,\n'
          '  label: "Profile",\n'
          '  child: ...,\n'
          ')',
    ),
    _RecipeSpec(
      title: 'Decorative image',
      description:
          'Image that should be ignored entirely. Combines isImage with '
          'isHidden so the picture is painted but not announced.',
      icon: Icons.hide_image,
      color: Colors.grey,
      flags: const [
        'isImage',
        'isHidden',
      ],
      code: 'Semantics(\n'
          '  image: true,\n'
          '  excludeSemantics: true,\n'
          '  child: decorativeIcon,\n'
          ')',
    ),
  ];
  final Widget recipesSection = _buildRecipesSection(recipes);

  // ============================================================
  // SECTION 8: Pitfalls / common mistakes
  // ============================================================
  final List<_PitfallSpec> pitfalls = [
    _PitfallSpec(
      bad: 'isChecked without hasCheckedState',
      good: 'Always pair hasCheckedState with isChecked or isCheckStateMixed.',
      icon: Icons.error_outline,
      color: Colors.red,
    ),
    _PitfallSpec(
      bad: 'isToggled without hasToggledState',
      good: 'Pair hasToggledState with isToggled. Otherwise AT will not '
          'announce on/off state.',
      icon: Icons.error_outline,
      color: Colors.red,
    ),
    _PitfallSpec(
      bad: 'Using isButton on a non-tappable Text',
      good: 'Only set isButton when there is an onTap/onPressed handler. '
          'Otherwise AT will lie to users.',
      icon: Icons.warning_amber,
      color: Colors.amber,
    ),
    _PitfallSpec(
      bad: 'isLiveRegion on every status text',
      good: 'Reserve liveRegion for actually-changing content. Otherwise it '
          'creates speech spam.',
      icon: Icons.warning_amber,
      color: Colors.amber,
    ),
    _PitfallSpec(
      bad: 'Mixing isChecked with isCheckStateMixed',
      good: 'They are mutually exclusive. Use one or the other based on '
          'tri-state value.',
      icon: Icons.cancel_outlined,
      color: Colors.deepOrange,
    ),
    _PitfallSpec(
      bad: 'isHeader on every Text',
      good: 'Only mark actual section headings; otherwise heading navigation '
          'becomes useless.',
      icon: Icons.warning_amber,
      color: Colors.amber,
    ),
    _PitfallSpec(
      bad: 'isHidden on interactive content',
      good: 'Hidden nodes cannot receive focus. Hide only decorative content.',
      icon: Icons.error_outline,
      color: Colors.red,
    ),
    _PitfallSpec(
      bad: 'isImage without a label',
      good: 'Always provide a Semantics label so AT can describe the image.',
      icon: Icons.warning_amber,
      color: Colors.amber,
    ),
    _PitfallSpec(
      bad: 'isFocused without isFocusable',
      good: 'Focused implies focusable. Set isFocusable on anything that can '
          'be focused.',
      icon: Icons.error_outline,
      color: Colors.red,
    ),
    _PitfallSpec(
      bad: 'scopesRoute on inner widgets',
      good: 'scopesRoute belongs on the route\'s root; nesting routes confuses '
          'navigation.',
      icon: Icons.cancel_outlined,
      color: Colors.deepOrange,
    ),
  ];
  final Widget pitfallsSection = _buildPitfallsSection(pitfalls);

  // ============================================================
  // SECTION 9: Comparison table (paired flags)
  // ============================================================
  final Widget comparisonTable = Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.blue.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.10),
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
            Icon(Icons.table_chart, color: Colors.indigo.shade700, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Paired flags side-by-side',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              _buildHeaderCell('Capability flag', 150.0),
              _buildHeaderCell('State flag', 150.0),
              _buildHeaderCell('Use case', 220.0),
            ],
          ),
        ),
        _buildComparisonRow(
          'hasCheckedState',
          'isChecked / isCheckStateMixed',
          'Checkbox-like widgets',
          Colors.green,
        ),
        _buildComparisonRow(
          'hasToggledState',
          'isToggled',
          'Switch-like widgets',
          Colors.deepPurple,
        ),
        _buildComparisonRow(
          'hasSelectedState',
          'isSelected',
          'Tabs, segmented controls, list selection',
          Colors.teal,
        ),
        _buildComparisonRow(
          'hasEnabledState',
          'isEnabled',
          'Buttons, fields with disabled state',
          Colors.lime,
        ),
        _buildComparisonRow(
          'hasExpandedState',
          'isExpanded',
          'Disclosure widgets, accordions',
          Colors.orange,
        ),
        _buildComparisonRow(
          'hasRequiredState',
          'isRequired',
          'Form inputs that must be filled',
          Colors.red,
        ),
        _buildComparisonRow(
          'isFocusable',
          'isFocused',
          'Anything that participates in focus',
          Colors.amber,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Quick reference (every flag listed)
  // ============================================================
  final List<Widget> quickRefRows = <Widget>[];
  for (int i = 0; i < ui.SemanticsFlag.values.length; i++) {
    final ui.SemanticsFlag flag = ui.SemanticsFlag.values[i];
    final Color stripe =
        i.isEven ? Colors.blue.shade50 : Colors.purple.shade50;
    quickRefRows.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: stripe,
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200, width: 1.0),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.indigo.shade300,
                    Colors.indigo.shade600,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withValues(alpha: 0.30),
                    blurRadius: 4.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                '${flag.index}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                flag.toString(),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13.0,
                  color: Colors.indigo.shade900,
                ),
              ),
            ),
            Icon(Icons.flag, size: 16.0, color: Colors.indigo.shade300),
          ],
        ),
      ),
    );
  }
  final Widget quickReference = Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo.shade700, Colors.purple.shade700],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.list_alt, color: Colors.white),
                SizedBox(width: 10.0),
                Text(
                  'Every SemanticsFlag at a glance',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          ...quickRefRows,
        ],
      ),
    ),
  );

  // ============================================================
  // SECTION 11: ASCII art footer
  // ============================================================
  final Widget asciiFooter = Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF0B0B1F),
          Color(0xFF1A1A3F),
          Color(0xFF2C0B4F),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.terminal, color: Colors.greenAccent, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'semantics_flag_diagram.txt',
              style: TextStyle(
                color: Colors.greenAccent,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          '+----------------------------------------------------------+\n'
          '|                  ui.SemanticsFlag                        |\n'
          '+----------------------------------------------------------+\n'
          '|                                                          |\n'
          '|   [interactivity]    [state]         [role]              |\n'
          '|       isButton          isChecked        isHeader        |\n'
          '|       isLink            isToggled        scopesRoute     |\n'
          '|       isSlider          isSelected       namesRoute      |\n'
          '|       isTextField       isExpanded       isLiveRegion    |\n'
          '|       isKeyboardKey     isEnabled        isHidden        |\n'
          '|       isImage           isRequired       isObscured      |\n'
          '|                         isFocused        isMultiline     |\n'
          '|                                          isReadOnly      |\n'
          '|                                          hasImplicitScrolling',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            height: 1.4,
            color: Colors.greenAccent.shade400,
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'Pair rule: every "isFoo" state flag has a "hasFooState" capability flag.\n'
          'Tip:       use Semantics() in widgets, not raw SemanticsFlag values.',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            height: 1.4,
            color: Colors.cyanAccent.shade100,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 12: Section divider helper widgets
  // ============================================================
  Widget sectionTitle(String index, String title, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(top: 24.0, bottom: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.20),
            color.withValues(alpha: 0.08),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border(
          left: BorderSide(color: color, width: 5.0),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18.0,
            backgroundColor: color,
            child: Icon(icon, color: Colors.white, size: 20.0),
          ),
          SizedBox(width: 12.0),
          Text(
            '$index. $title',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // Final layout
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text('SemanticsFlag deep demo'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            heroHeader,
            sectionTitle(
              '1',
              'Anatomy of a SemanticsFlag',
              Icons.science,
              Colors.teal,
            ),
            anatomy,
            sectionTitle(
              '2',
              'Interactivity flags',
              Icons.touch_app,
              Colors.blue,
            ),
            interactivityCards,
            sectionTitle(
              '3',
              'State flags',
              Icons.toggle_on,
              Colors.green,
            ),
            stateCards,
            sectionTitle(
              '4',
              'Role / structure flags',
              Icons.architecture,
              Colors.deepPurple,
            ),
            roleCards,
            sectionTitle(
              '5',
              'Accessibility recipes',
              Icons.menu_book,
              Colors.amber,
            ),
            recipesSection,
            sectionTitle(
              '6',
              'Common pitfalls',
              Icons.warning_amber,
              Colors.red,
            ),
            pitfallsSection,
            sectionTitle(
              '7',
              'Paired flags comparison',
              Icons.table_chart,
              Colors.indigo,
            ),
            comparisonTable,
            sectionTitle(
              '8',
              'Quick reference (every flag)',
              Icons.list_alt,
              Colors.indigo,
            ),
            quickReference,
            sectionTitle(
              '9',
              'ASCII reference',
              Icons.terminal,
              Colors.deepPurple,
            ),
            asciiFooter,
            SizedBox(height: 32.0),
            Center(
              child: Opacity(
                opacity: stopFull.value,
                child: Text(
                  'Build accessible Flutter apps with confidence.',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.0),
          ],
        ),
      ),
    ),
  );
}

// =============================================================
// Spec types
// =============================================================
class _FlagSpec {
  final ui.SemanticsFlag flag;
  final String title;
  final String headline;
  final String description;
  final IconData icon;
  final Color color;
  final String example;
  const _FlagSpec({
    required this.flag,
    required this.title,
    required this.headline,
    required this.description,
    required this.icon,
    required this.color,
    required this.example,
  });
}

class _RecipeSpec {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final List<String> flags;
  final String code;
  const _RecipeSpec({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.flags,
    required this.code,
  });
}

class _PitfallSpec {
  final String bad;
  final String good;
  final IconData icon;
  final Color color;
  const _PitfallSpec({
    required this.bad,
    required this.good,
    required this.icon,
    required this.color,
  });
}

// =============================================================
// Builders
// =============================================================
Widget _buildBadge(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.55),
          color.withValues(alpha: 0.85),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.45),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 12.0,
      ),
    ),
  );
}

Widget _anatomyRow(IconData icon, String label, String desc, Color color) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 32.0,
        height: 32.0,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8.0),
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 18.0, color: color),
      ),
      SizedBox(width: 12.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                color: color,
              ),
            ),
            SizedBox(height: 2.0),
            Text(
              desc,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey.shade800,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildFlagGroup(String title, List<_FlagSpec> specs, Color accent) {
  final List<Widget> cards = <Widget>[];
  for (final _FlagSpec s in specs) {
    cards.add(_buildFlagCard(s));
  }
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: accent.withValues(alpha: 0.30), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.10),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                '${specs.length} flags',
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: accent,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: cards,
        ),
      ],
    ),
  );
}

Widget _buildFlagCard(_FlagSpec s) {
  return Container(
    width: 280.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          s.color.withValues(alpha: 0.05),
          s.color.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(
        color: s.color.withValues(alpha: 0.45),
        width: 1.4,
      ),
      boxShadow: [
        BoxShadow(
          color: s.color.withValues(alpha: 0.20),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 44.0,
              height: 44.0,
              decoration: BoxDecoration(
                color: s.color,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: s.color.withValues(alpha: 0.45),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Icon(s.icon, color: Colors.white, size: 22.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.title,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: s.color,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: s.color.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      'index ${s.flag.index}',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: s.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          s.headline,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade900,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          s.description,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade800,
            height: 1.4,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            s.example,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: Colors.greenAccent.shade100,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildRecipesSection(List<_RecipeSpec> recipes) {
  final List<Widget> rows = <Widget>[];
  for (final _RecipeSpec r in recipes) {
    rows.add(_buildRecipeCard(r));
  }
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.amber.shade300, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.20),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Common combinations of flags that ship together. '
          'Use them as starting points when wiring up Semantics() widgets.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.brown.shade700,
            height: 1.4,
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: rows,
        ),
      ],
    ),
  );
}

Widget _buildRecipeCard(_RecipeSpec r) {
  return Container(
    width: 320.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(
        color: r.color.withValues(alpha: 0.45),
        width: 1.4,
      ),
      boxShadow: [
        BoxShadow(
          color: r.color.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    r.color.withValues(alpha: 0.7),
                    r.color,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              alignment: Alignment.center,
              child: Icon(r.icon, color: Colors.white, size: 20.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                r.title,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: r.color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          r.description,
          style: TextStyle(
            fontSize: 12.5,
            color: Colors.grey.shade800,
            height: 1.4,
          ),
        ),
        SizedBox(height: 10.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: [
            for (final String f in r.flags)
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: r.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: r.color.withValues(alpha: 0.45),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  f,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.5,
                    color: r.color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            r.code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.cyanAccent.shade100,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPitfallsSection(List<_PitfallSpec> pitfalls) {
  final List<Widget> rows = <Widget>[];
  for (final _PitfallSpec p in pitfalls) {
    rows.add(_buildPitfallCard(p));
  }
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.deepOrange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade200, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows,
    ),
  );
}

Widget _buildPitfallCard(_PitfallSpec p) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border(
        left: BorderSide(color: p.color, width: 4.0),
      ),
      boxShadow: [
        BoxShadow(
          color: p.color.withValues(alpha: 0.10),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(p.icon, color: p.color, size: 24.0),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: p.color.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      'AVOID',
                      style: TextStyle(
                        color: p.color,
                        fontWeight: FontWeight.bold,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      p.bad,
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      'PREFER',
                      style: TextStyle(
                        color: Colors.green.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      p.good,
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.grey.shade800,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildHeaderCell(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
        color: Colors.indigo.shade900,
      ),
    ),
  );
}

Widget _buildComparisonRow(
  String capability,
  String state,
  String useCase,
  Color color,
) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
      ),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 150.0,
          child: Text(
            capability,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: color,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: 150.0,
          child: Text(
            state,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: color.withValues(alpha: 0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: 220.0,
          child: Text(
            useCase,
            style: TextStyle(
              fontSize: 11.5,
              color: Colors.grey.shade800,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeBlock(String code, Color textColor) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.20),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.code, color: textColor, size: 16.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: textColor,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

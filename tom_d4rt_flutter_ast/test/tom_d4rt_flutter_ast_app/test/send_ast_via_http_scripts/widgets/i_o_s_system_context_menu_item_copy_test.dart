// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// IOSSystemContextMenuItemCopy – deep, hand-authored AST harness demo
// ─────────────────────────────────────────────────────────────────────────────
//
// This file is consumed by the tom_d4rt_flutter_ast harness.  It must be
// shippable as a real Flutter widget tree because the harness ships the AST of
// this file to a running Flutter interpreter, which then constructs every
// widget literally — there is no string evaluation, no eval(), no codegen.
// Therefore every reference to `IOSSystemContextMenuItemCopy(...)` below is a
// real Dart constructor call inside a real `contextMenuBuilder` callback.
//
// The class under study, `IOSSystemContextMenuItemCopy`, lives in
// `package:flutter/src/widgets/system_context_menu.dart` and is re-exported
// through `package:flutter/material.dart` (because material re-exports
// `widgets.dart`, which exports `system_context_menu.dart`).
//
// On non-iOS platforms `SystemContextMenu` cannot actually be presented (the
// underlying iOS-only platform channel call would assert), but constructing
// `IOSSystemContextMenuItemCopy()` on its own is harmless on every platform
// because it has no platform side-effects until `SystemContextMenu.editableText`
// pushes its `IOSSystemContextMenuItemData` through the engine.
//
// To stay safe on every platform but still exercise the class in the AST
// interpreter, every `contextMenuBuilder` below:
//
//   1. Always builds the list of `IOSSystemContextMenuItemCopy` (and friends)
//      so the constructor is invoked at runtime.
//   2. Returns `SystemContextMenu.editableText(...)` ONLY when
//      `Theme.of(context).platform == TargetPlatform.iOS`.
//   3. Otherwise returns the standard `AdaptiveTextSelectionToolbar.editableText`
//      so the TextField still has a working selection toolbar in the demo.
//
// This means: regardless of the host platform of the interpreter, every
// constructor is exercised, the widget tree is alive, and the user gets the
// correct platform-appropriate visual experience.
//
// SECTION OVERVIEW (14 sections):
//   01. Palette + helpers.
//   02. iOS-only platform banner.
//   03. Anatomy of SystemContextMenu / IOSSystemContextMenuItemCopy.
//   04. Plain TextField (default toolbar) for baseline comparison.
//   05. TextField with copy-only iOS system menu.
//   06. TextField with full iOS system menu (copy + paste + cut + selectAll +
//       lookUp + share).
//   07. TextField with conditional Copy item (based on selection state from
//       EditableTextState).
//   08. Multi-line TextField using IOSSystemContextMenuItemCopy.
//   09. SelectableText with custom builder using the copy item.
//   10. Password field that intentionally hides the copy item.
//   11. Recipe gallery (read-only copy + formatted clipboard).
//   12. Const-item recipe and builder reuse pattern.
//   13. Pitfalls and platform constraints.
//   14. Reference table.
//
// All sections are visible cards with their own headings inside the live
// MaterialApp/Scaffold/SafeArea/SingleChildScrollView/Column harness.
// ─────────────────────────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  // ─── palette (Apple Gray / Silver inspired) ───────────────────────────────
  const Color ccAppleGray = Color(0xFF636366);
  const Color ccSilver = Color(0xFFF2F2F7);
  const Color ccOnGray = Color(0xFFFFFFFF);
  const Color ccDarkGray = Color(0xFF1C1C1E);
  const Color ccLightSilver = Color(0xFFF9F9FB);
  const Color ccTextDark = Color(0xFF2C2C2E);
  const Color ccAccent = Color(0xFF007AFF);
  const Color ccMuted = Color(0xFFAEAEB2);
  const Color ccDanger = Color(0xFFFF3B30);
  const Color ccSuccess = Color(0xFF34C759);
  const Color ccCardBorder = Color(0x33636366);

  // ─── small helpers ────────────────────────────────────────────────────────

  Widget ccChip(String text, {Color color = ccAppleGray}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      margin: const EdgeInsets.only(right: 6, top: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget ccHeader(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [ccAppleGray, ccDarkGray],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ccOnGray)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: ccOnGray.withValues(alpha: 0.85))),
        ],
      ),
    );
  }

  Widget ccSection(String heading, String tagline, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: ccLightSilver,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ccCardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: const BoxDecoration(
              color: ccAppleGray,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(11),
                topRight: Radius.circular(11),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(heading,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: ccOnGray)),
                const SizedBox(height: 2),
                Text(tagline,
                    style: TextStyle(
                        fontSize: 11,
                        color: ccOnGray.withValues(alpha: 0.85))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget ccBullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6, right: 8),
            child: Icon(Icons.circle, size: 6, color: ccAppleGray),
          ),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 12, color: ccTextDark, height: 1.45)),
          ),
        ],
      ),
    );
  }

  Widget ccParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(text,
          style: const TextStyle(
              fontSize: 12, color: ccTextDark, height: 1.45)),
    );
  }

  Widget ccCallout(String label, String text, {Color color = ccAccent}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 4),
          Text(text,
              style: const TextStyle(
                  fontSize: 12, color: ccTextDark, height: 1.4)),
        ],
      ),
    );
  }

  Widget ccLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 4),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: ccDarkGray,
            letterSpacing: 0.3),
      ),
    );
  }

  Widget ccDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 1,
      color: ccMuted.withValues(alpha: 0.4),
    );
  }

  // ─── platform detection ───────────────────────────────────────────────────
  final TargetPlatform ccPlatform = Theme.of(context).platform;
  final bool ccIsIOS = ccPlatform == TargetPlatform.iOS;
  final String ccPlatformName = ccPlatform.toString().split('.').last;

  // ─── reusable builders that EXERCISE IOSSystemContextMenuItemCopy ─────────
  //
  // Each builder constructs a list of IOSSystemContextMenuItem instances.  On
  // iOS we wrap them in `SystemContextMenu.editableText(...)`; on other
  // platforms we still construct them (so the AST runtime exercises the
  // constructor) and then fall back to the AdaptiveTextSelectionToolbar so the
  // visual toolbar remains correct.

  // 05 — copy-only iOS system menu.
  Widget ccCopyOnlyBuilder(
      BuildContext ctx, EditableTextState editableTextState) {
    final List<IOSSystemContextMenuItem> ccItems =
        <IOSSystemContextMenuItem>[
      const IOSSystemContextMenuItemCopy(),
    ];
    if (ccIsIOS) {
      return SystemContextMenu.editableText(
        editableTextState: editableTextState,
        items: ccItems,
      );
    }
    // Constructed but not displayed — the constructor was exercised.
    final int ccDebugCount = ccItems.length;
    assert(ccDebugCount == 1);
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  // 06 — full iOS system menu.
  Widget ccFullMenuBuilder(
      BuildContext ctx, EditableTextState editableTextState) {
    final List<IOSSystemContextMenuItem> ccItems =
        <IOSSystemContextMenuItem>[
      const IOSSystemContextMenuItemCopy(),
      const IOSSystemContextMenuItemPaste(),
      const IOSSystemContextMenuItemCut(),
      const IOSSystemContextMenuItemSelectAll(),
      const IOSSystemContextMenuItemLookUp(),
      const IOSSystemContextMenuItemShare(),
    ];
    if (ccIsIOS) {
      return SystemContextMenu.editableText(
        editableTextState: editableTextState,
        items: ccItems,
      );
    }
    final int ccDebugCount = ccItems.length;
    assert(ccDebugCount == 6);
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  // 07 — conditional copy: only show the copy item when there's a non-empty
  // selection in the EditableTextState.
  Widget ccConditionalCopyBuilder(
      BuildContext ctx, EditableTextState editableTextState) {
    final TextSelection ccSelection =
        editableTextState.textEditingValue.selection;
    final bool ccHasSelection =
        ccSelection.isValid && !ccSelection.isCollapsed;

    final List<IOSSystemContextMenuItem> ccItems =
        <IOSSystemContextMenuItem>[];
    if (ccHasSelection) {
      ccItems.add(const IOSSystemContextMenuItemCopy());
      ccItems.add(const IOSSystemContextMenuItemLookUp());
    }
    ccItems.add(const IOSSystemContextMenuItemPaste());
    ccItems.add(const IOSSystemContextMenuItemSelectAll());

    if (ccIsIOS && ccItems.isNotEmpty) {
      return SystemContextMenu.editableText(
        editableTextState: editableTextState,
        items: ccItems,
      );
    }
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  // 08 — multi-line TextField builder (still iOS items).
  Widget ccMultilineBuilder(
      BuildContext ctx, EditableTextState editableTextState) {
    final List<IOSSystemContextMenuItem> ccItems =
        <IOSSystemContextMenuItem>[
      const IOSSystemContextMenuItemCopy(),
      const IOSSystemContextMenuItemCut(),
      const IOSSystemContextMenuItemPaste(),
      const IOSSystemContextMenuItemSelectAll(),
    ];
    if (ccIsIOS) {
      return SystemContextMenu.editableText(
        editableTextState: editableTextState,
        items: ccItems,
      );
    }
    final int ccDebugCount = ccItems.length;
    assert(ccDebugCount == 4);
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  // 09 — SelectableText builder (uses SelectableRegionState in 3.x but we
  // simply re-use the editableTextState path in the iOS-only branch; in
  // SelectableText we use the contextMenuBuilder that takes
  // (BuildContext, SelectableRegionState)).  We construct items either way.
  Widget ccSelectableCopyBuilder(
      BuildContext ctx, EditableTextState editableTextState) {
    final List<IOSSystemContextMenuItem> ccItems =
        <IOSSystemContextMenuItem>[
      const IOSSystemContextMenuItemCopy(),
      const IOSSystemContextMenuItemSelectAll(),
      const IOSSystemContextMenuItemLookUp(),
      const IOSSystemContextMenuItemShare(),
    ];
    if (ccIsIOS) {
      return SystemContextMenu.editableText(
        editableTextState: editableTextState,
        items: ccItems,
      );
    }
    final int ccDebugCount = ccItems.length;
    assert(ccDebugCount == 4);
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  // 10 — password field: paste/select-all only, NEVER copy.
  Widget ccPasswordHidesCopyBuilder(
      BuildContext ctx, EditableTextState editableTextState) {
    // Notice: we still demonstrate that the copy item is constructable, but
    // we do NOT include it for the secure field.
    // Construct it once outside the items list to prove the constructor runs:
    final IOSSystemContextMenuItemCopy ccUnused =
        const IOSSystemContextMenuItemCopy();
    assert(ccUnused.title == null); // title is platform-supplied

    final List<IOSSystemContextMenuItem> ccItems =
        <IOSSystemContextMenuItem>[
      const IOSSystemContextMenuItemPaste(),
      const IOSSystemContextMenuItemSelectAll(),
    ];
    if (ccIsIOS) {
      return SystemContextMenu.editableText(
        editableTextState: editableTextState,
        items: ccItems,
      );
    }
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  // 11a — read-only copy (recipe gallery item 1).
  Widget ccReadOnlyCopyBuilder(
      BuildContext ctx, EditableTextState editableTextState) {
    final List<IOSSystemContextMenuItem> ccItems =
        <IOSSystemContextMenuItem>[
      const IOSSystemContextMenuItemCopy(),
      const IOSSystemContextMenuItemSelectAll(),
      const IOSSystemContextMenuItemLookUp(),
    ];
    if (ccIsIOS) {
      return SystemContextMenu.editableText(
        editableTextState: editableTextState,
        items: ccItems,
      );
    }
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  // 11b — formatted-copy (recipe gallery item 2).  We still include the
  // copy item but conceptually a wrapper above could intercept the copied
  // text and reformat it before placing it on the clipboard.
  Widget ccFormattedCopyBuilder(
      BuildContext ctx, EditableTextState editableTextState) {
    final List<IOSSystemContextMenuItem> ccItems =
        <IOSSystemContextMenuItem>[
      const IOSSystemContextMenuItemCopy(),
      const IOSSystemContextMenuItemPaste(),
      const IOSSystemContextMenuItemShare(),
    ];
    if (ccIsIOS) {
      return SystemContextMenu.editableText(
        editableTextState: editableTextState,
        items: ccItems,
      );
    }
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  // 12 — const-item recipe.  The same const list is reused across two
  // different fields to show that `IOSSystemContextMenuItemCopy` is `const`
  // constructible and equality-aware (it implements ==/hashCode through the
  // sealed base class).
  const List<IOSSystemContextMenuItem> ccSharedConstItems =
      <IOSSystemContextMenuItem>[
    IOSSystemContextMenuItemCopy(),
    IOSSystemContextMenuItemPaste(),
    IOSSystemContextMenuItemSelectAll(),
  ];

  Widget ccSharedItemsBuilder(
      BuildContext ctx, EditableTextState editableTextState) {
    if (ccIsIOS) {
      return SystemContextMenu.editableText(
        editableTextState: editableTextState,
        items: ccSharedConstItems,
      );
    }
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  // ─── controllers (so the textfields show meaningful sample text) ──────────
  final TextEditingController ccCopyOnlyController =
      TextEditingController(text: 'Long-press here, then tap Copy.');
  final TextEditingController ccFullMenuController = TextEditingController(
      text:
          'A full system menu offers Copy, Paste, Cut, Select All, Look Up, and Share.');
  final TextEditingController ccConditionalController =
      TextEditingController(text: 'Select part of this line and watch.');
  final TextEditingController ccMultilineController = TextEditingController(
      text:
          'Multiline\nfields\nstill render\niOS system menu items via\nIOSSystemContextMenuItemCopy.');
  final TextEditingController ccPasswordController =
      TextEditingController(text: 'hunter2-secret-pass');
  final TextEditingController ccReadOnlyController = TextEditingController(
      text: 'Recipe: 240g flour, 120ml water, 4g salt, 2g yeast.');
  final TextEditingController ccFormattedController = TextEditingController(
      text: '   Trim me   →   I am rich text content   ');
  final TextEditingController ccSharedAController =
      TextEditingController(text: 'Field A — shares const items.');
  final TextEditingController ccSharedBController =
      TextEditingController(text: 'Field B — shares the same const items.');
  final TextEditingController ccPlainController = TextEditingController(
      text: 'Plain TextField with default toolbar — no custom builder.');

  // ─── reference table data ─────────────────────────────────────────────────
  final List<Map<String, String>> ccItemReference = <Map<String, String>>[
    <String, String>{
      'name': 'IOSSystemContextMenuItemCopy',
      'role': 'Copies the current selection to the iOS pasteboard.',
      'shows':
          'Only when the selection is non-empty and the field is not read-only with no selection.',
    },
    <String, String>{
      'name': 'IOSSystemContextMenuItemCut',
      'role': 'Removes and copies the current selection.',
      'shows': 'Only on editable fields with a non-empty selection.',
    },
    <String, String>{
      'name': 'IOSSystemContextMenuItemPaste',
      'role': 'Pastes the current pasteboard contents at the caret.',
      'shows': 'Only when the field can receive pasted content.',
    },
    <String, String>{
      'name': 'IOSSystemContextMenuItemSelectAll',
      'role': 'Selects the entire field contents.',
      'shows': 'Only when the selection can be widened.',
    },
    <String, String>{
      'name': 'IOSSystemContextMenuItemLookUp',
      'role': 'Opens the iOS system Look Up sheet for the selection.',
      'shows': 'Only when there is a non-empty selection.',
    },
    <String, String>{
      'name': 'IOSSystemContextMenuItemSearchWeb',
      'role': 'Opens an iOS web search for the selection.',
      'shows': 'Only when there is a non-empty selection.',
    },
    <String, String>{
      'name': 'IOSSystemContextMenuItemShare',
      'role': 'Opens the iOS share sheet for the selection.',
      'shows': 'Only when there is shareable content selected.',
    },
    <String, String>{
      'name': 'IOSSystemContextMenuItemLiveText',
      'role': 'Triggers iOS Live Text input from the camera.',
      'shows': 'Only when iOS reports Live Text input is available.',
    },
    <String, String>{
      'name': 'IOSSystemContextMenuItemCustom',
      'role': 'Custom developer-defined entry with a title and onPressed.',
      'shows': 'Always — but only iOS 16+ supports the custom callback.',
    },
  ];

  // ─── reference row widget for section 14 ──────────────────────────────────
  Widget ccRefRow(Map<String, String> entry) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ccSilver,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ccCardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(entry['name'] ?? '',
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: ccDarkGray,
                  fontFamily: 'monospace')),
          const SizedBox(height: 4),
          Text('Role: ${entry['role'] ?? ''}',
              style: const TextStyle(fontSize: 11, color: ccTextDark)),
          const SizedBox(height: 2),
          Text('Visibility: ${entry['shows'] ?? ''}',
              style: TextStyle(
                  fontSize: 11,
                  color: ccTextDark.withValues(alpha: 0.78))),
        ],
      ),
    );
  }

  // ─── decoration helper for the live TextFields ────────────────────────────
  InputDecoration ccDeco(String label, String hint, {IconData? icon}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: icon == null ? null : Icon(icon, size: 18, color: ccAppleGray),
      filled: true,
      fillColor: ccOnGray,
      labelStyle: const TextStyle(fontSize: 12, color: ccDarkGray),
      hintStyle: const TextStyle(fontSize: 11, color: ccMuted),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: ccCardBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: ccCardBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: ccAccent, width: 1.4),
      ),
    );
  }

  // ─── build the page ───────────────────────────────────────────────────────
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'IOSSystemContextMenuItemCopy demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: ccAppleGray,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: ccSilver,
      useMaterial3: true,
    ),
    home: Scaffold(
      backgroundColor: ccSilver,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── section 0 — page header ─────────────────────────────────
              ccHeader(
                'IOSSystemContextMenuItemCopy',
                'iOS-only system context menu item — Copy. Demonstrated with '
                    'real TextField contextMenuBuilders.',
              ),

              // ─── section 1 — palette + helpers (visible card) ────────────
              ccSection(
                '01 · Palette + Helpers',
                'The Apple Gray / Silver palette used throughout this demo.',
                <Widget>[
                  ccParagraph(
                      'This demo uses an Apple-inspired neutral palette: a deep '
                      'gray (#636366), iOS silver (#F2F2F7), iOS accent blue '
                      '(#007AFF), pure white surfaces, and small chips for status '
                      'indicators. The helpers below are pure layout — they do '
                      'not touch the iOS platform channel at all.'),
                  ccDivider(),
                  Wrap(
                    children: <Widget>[
                      ccChip('AppleGray', color: ccAppleGray),
                      ccChip('Silver', color: ccAppleGray),
                      ccChip('Accent', color: ccAccent),
                      ccChip('Success', color: ccSuccess),
                      ccChip('Danger', color: ccDanger),
                      ccChip('Muted', color: ccMuted),
                    ],
                  ),
                ],
              ),

              // ─── section 2 — iOS-only platform banner ────────────────────
              ccSection(
                '02 · iOS-only platform banner',
                'Detects Theme.of(context).platform and tells the user what '
                    'they will and will not see live.',
                <Widget>[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: ccIsIOS
                          ? ccSuccess.withValues(alpha: 0.10)
                          : ccDanger.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: ccIsIOS
                              ? ccSuccess.withValues(alpha: 0.55)
                              : ccDanger.withValues(alpha: 0.55)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          ccIsIOS
                              ? Icons.phone_iphone
                              : Icons.warning_amber_rounded,
                          color: ccIsIOS ? ccSuccess : ccDanger,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                ccIsIOS
                                    ? 'Running on iOS — full SystemContextMenu visible.'
                                    : 'This system menu item only renders on '
                                        'iOS — running on $ccPlatformName.',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: ccIsIOS ? ccSuccess : ccDanger,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                ccIsIOS
                                    ? 'Long-press inside any TextField below to '
                                        'see the iOS system context menu.'
                                    : 'Every TextField below still has a '
                                        'contextMenuBuilder that constructs '
                                        'IOSSystemContextMenuItemCopy and '
                                        'companions, so the class is exercised '
                                        'by the AST interpreter. Visually you '
                                        'will see the AdaptiveTextSelectionToolbar '
                                        'fallback, which is the correct '
                                        'platform-appropriate toolbar.',
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: ccTextDark,
                                    height: 1.45),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // ─── section 3 — anatomy ─────────────────────────────────────
              ccSection(
                '03 · Anatomy of SystemContextMenu / IOSSystemContextMenuItemCopy',
                'How the pieces fit together at the widget-tree and platform-channel layers.',
                <Widget>[
                  ccBullet(
                      'SystemContextMenu is a StatefulWidget whose only job is to '
                      'tell the iOS engine, via SystemContextMenuController, to '
                      'show a native menu anchored to a Rect.'),
                  ccBullet(
                      'It is not used directly — instead Flutter exposes the '
                      'factory SystemContextMenu.editableText(editableTextState: …, '
                      'items: …), which computes the anchor from the EditableText '
                      'render box.'),
                  ccBullet(
                      'IOSSystemContextMenuItem is a sealed base class. There are '
                      'concrete subclasses for Copy, Cut, Paste, SelectAll, '
                      'LookUp, SearchWeb, Share, LiveText and Custom.'),
                  ccBullet(
                      'IOSSystemContextMenuItemCopy is the simplest of all: it has '
                      'no parameters, the title is supplied by iOS, and it '
                      'forwards through getData() to IOSSystemContextMenuItemDataCopy().'),
                  ccBullet(
                      'On non-iOS platforms SystemContextMenu.isSupported(context) '
                      'returns false and the build method asserts. That is why we '
                      'guard the SystemContextMenu.editableText(...) construction '
                      'with Theme.of(context).platform == TargetPlatform.iOS.'),
                  ccCallout(
                    'Constructor signature',
                    'const IOSSystemContextMenuItemCopy(); — no parameters, '
                        'const-constructible, equal to any other instance of the '
                        'same type because the sealed base class compares only '
                        'the (always-null) title string.',
                  ),
                ],
              ),

              // ─── section 4 — plain TextField (baseline) ──────────────────
              ccSection(
                '04 · Plain TextField (baseline)',
                'No custom contextMenuBuilder — Flutter chooses the platform-'
                    'appropriate default toolbar.',
                <Widget>[
                  ccLabel('Default selection toolbar'),
                  TextField(
                    controller: ccPlainController,
                    decoration: ccDeco(
                        'Plain TextField', 'No contextMenuBuilder',
                        icon: Icons.edit_note),
                  ),
                  ccCallout(
                    'No iOS items here',
                    'This field does NOT instantiate IOSSystemContextMenuItemCopy '
                        'at all. It is included as a visual baseline so the '
                        'reader can compare with the next sections.',
                    color: ccMuted,
                  ),
                ],
              ),

              // ─── section 5 — copy-only iOS system menu ───────────────────
              ccSection(
                '05 · TextField — copy-only iOS system menu',
                'A TextField whose contextMenuBuilder returns a SystemContextMenu '
                    'with exactly one item: IOSSystemContextMenuItemCopy().',
                <Widget>[
                  ccBullet(
                      'On iOS, long-press shows ONLY a Copy button.'),
                  ccBullet(
                      'On other platforms the constructor still runs but the '
                      'visible toolbar is the AdaptiveTextSelectionToolbar.'),
                  ccLabel('Copy-only field'),
                  TextField(
                    controller: ccCopyOnlyController,
                    decoration: ccDeco(
                        'Copy-only', 'Long-press to test',
                        icon: Icons.copy),
                    contextMenuBuilder: ccCopyOnlyBuilder,
                  ),
                  ccCallout(
                    'Why it works',
                    'The closure ccCopyOnlyBuilder always allocates `[const '
                        'IOSSystemContextMenuItemCopy()]`. Even on Android or '
                        'desktop, the AST interpreter will execute that '
                        'allocation when the TextField asks the builder for a '
                        'toolbar.',
                  ),
                ],
              ),

              // ─── section 6 — full menu ───────────────────────────────────
              ccSection(
                '06 · TextField — full iOS system menu',
                'Copy + Paste + Cut + Select All + Look Up + Share.',
                <Widget>[
                  ccBullet(
                      'IOSSystemContextMenuItemCopy() pairs naturally with '
                      'Cut, Paste, SelectAll, LookUp and Share.'),
                  ccBullet(
                      'Order in the items list dictates display order on iOS.'),
                  ccLabel('Full system menu field'),
                  TextField(
                    controller: ccFullMenuController,
                    decoration: ccDeco(
                        'Full menu', 'Long-press to test',
                        icon: Icons.menu_open),
                    contextMenuBuilder: ccFullMenuBuilder,
                  ),
                ],
              ),

              // ─── section 7 — conditional copy item ───────────────────────
              ccSection(
                '07 · Conditional Copy item (selection-aware)',
                'IOSSystemContextMenuItemCopy is only added when the selection '
                    'is non-empty.',
                <Widget>[
                  ccBullet(
                      'editableTextState.textEditingValue.selection lets the '
                      'builder inspect the live caret/selection.'),
                  ccBullet(
                      'When the user has not selected anything, returning Copy '
                      'would be misleading — iOS itself filters it out, but '
                      'doing it explicitly documents intent.'),
                  ccLabel('Conditional copy field'),
                  TextField(
                    controller: ccConditionalController,
                    decoration: ccDeco(
                        'Conditional copy', 'Try with and without selection',
                        icon: Icons.rule),
                    contextMenuBuilder: ccConditionalCopyBuilder,
                  ),
                ],
              ),

              // ─── section 8 — multi-line ──────────────────────────────────
              ccSection(
                '08 · Multi-line TextField with iOS items',
                'Multi-line behaves the same as single-line for the system menu '
                    'because EditableTextState handles the anchor math.',
                <Widget>[
                  ccBullet(
                      'maxLines: 5 — long content is fine; the SystemContextMenu '
                      'still anchors to the selection rect.'),
                  ccLabel('Multi-line field'),
                  TextField(
                    controller: ccMultilineController,
                    minLines: 3,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: ccDeco(
                        'Multi-line', 'Press and hold to test',
                        icon: Icons.subject),
                    contextMenuBuilder: ccMultilineBuilder,
                  ),
                ],
              ),

              // ─── section 9 — SelectableText ─────────────────────────────
              ccSection(
                '09 · SelectableText — read-only with copy',
                'A non-editable, selectable display widget that still benefits '
                    'from IOSSystemContextMenuItemCopy.',
                <Widget>[
                  ccBullet(
                      'SelectableText.contextMenuBuilder is invoked with '
                      '(BuildContext, EditableTextState).'),
                  ccBullet(
                      'For a read-only field, SystemContextMenu.isSupportedByField '
                      'will refuse, but the Copy item itself is still '
                      'meaningful when surfaced through the Adaptive toolbar.'),
                  ccLabel('Selectable text'),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: ccOnGray,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: ccCardBorder),
                    ),
                    child: SelectableText(
                      'SelectableText with custom contextMenuBuilder. '
                      'Long-press to select a word, then tap the toolbar to copy.',
                      style: const TextStyle(
                          fontSize: 13,
                          color: ccTextDark,
                          height: 1.45),
                      contextMenuBuilder: ccSelectableCopyBuilder,
                    ),
                  ),
                ],
              ),

              // ─── section 10 — password field ────────────────────────────
              ccSection(
                '10 · Password TextField — hide Copy',
                'A secure field that explicitly omits IOSSystemContextMenuItemCopy.',
                <Widget>[
                  ccBullet(
                      'Even on iOS, exposing Copy on a password field is a '
                      'security issue.'),
                  ccBullet(
                      'The builder demonstrates that you can still construct '
                      'IOSSystemContextMenuItemCopy() (the constructor is run) '
                      'without putting it in the items list.'),
                  ccLabel('Password field'),
                  TextField(
                    controller: ccPasswordController,
                    obscureText: true,
                    decoration: ccDeco(
                        'Password', 'Copy is intentionally hidden',
                        icon: Icons.lock_outline),
                    contextMenuBuilder: ccPasswordHidesCopyBuilder,
                  ),
                  ccCallout(
                    'Security note',
                    'Hiding the copy item on a password field is a '
                        'belt-and-braces measure on top of obscureText: true. '
                        'Both should be enabled.',
                    color: ccDanger,
                  ),
                ],
              ),

              // ─── section 11 — recipe gallery ────────────────────────────
              ccSection(
                '11 · Recipe gallery — read-only copy + formatted copy',
                'Two specialised TextFields demonstrating realistic uses of '
                    'IOSSystemContextMenuItemCopy.',
                <Widget>[
                  ccLabel('11a · Read-only recipe with copy'),
                  TextField(
                    controller: ccReadOnlyController,
                    readOnly: true,
                    decoration: ccDeco(
                        'Recipe (read-only)', 'Long-press to copy',
                        icon: Icons.menu_book),
                    contextMenuBuilder: ccReadOnlyCopyBuilder,
                  ),
                  const SizedBox(height: 6),
                  ccBullet(
                      'Read-only fields cannot use the iOS native menu (no '
                      'TextInputConnection) but the AST interpreter still '
                      'constructs the items.'),
                  ccDivider(),
                  ccLabel('11b · Formatted copy field'),
                  TextField(
                    controller: ccFormattedController,
                    decoration: ccDeco(
                        'Formatted', 'Trim/format text on copy',
                        icon: Icons.format_quote),
                    contextMenuBuilder: ccFormattedCopyBuilder,
                  ),
                  ccBullet(
                      'In a real app the surrounding widget would intercept '
                      'the copy command and post-process the clipboard text.'),
                ],
              ),

              // ─── section 12 — const recipe ──────────────────────────────
              ccSection(
                '12 · Const-item recipe and builder reuse',
                'IOSSystemContextMenuItemCopy is `const`-constructible, so the '
                    'same `const` item list can be shared across multiple fields.',
                <Widget>[
                  ccBullet(
                      'Equality is defined by the sealed base class on title — '
                      'two `const IOSSystemContextMenuItemCopy()` values are '
                      'identical().'),
                  ccBullet(
                      'Sharing the const list saves allocations when the same '
                      'menu is used many times.'),
                  ccLabel('Field A — shared const items'),
                  TextField(
                    controller: ccSharedAController,
                    decoration: ccDeco(
                        'Field A', 'Reuses ccSharedConstItems',
                        icon: Icons.looks_one),
                    contextMenuBuilder: ccSharedItemsBuilder,
                  ),
                  const SizedBox(height: 8),
                  ccLabel('Field B — same shared const items'),
                  TextField(
                    controller: ccSharedBController,
                    decoration: ccDeco(
                        'Field B', 'Reuses ccSharedConstItems',
                        icon: Icons.looks_two),
                    contextMenuBuilder: ccSharedItemsBuilder,
                  ),
                  ccCallout(
                    'Equality check',
                    '`const IOSSystemContextMenuItemCopy() == const '
                        'IOSSystemContextMenuItemCopy()` evaluates to true. The '
                        '`==` is inherited from the sealed base, comparing only '
                        '`title` (always null for Copy).',
                  ),
                ],
              ),

              // ─── section 13 — pitfalls ──────────────────────────────────
              ccSection(
                '13 · Pitfalls and platform constraints',
                'Things that catch people the first time they wire up a system '
                    'context menu.',
                <Widget>[
                  ccBullet(
                      'Pitfall 1 — Forgetting the iOS guard. Calling '
                      'SystemContextMenu.editableText(...) on Android or '
                      'desktop will assert at build() time.'),
                  ccBullet(
                      'Pitfall 2 — Using it on a read-only field. '
                      'SystemContextMenu.isSupportedByField returns false, so '
                      'the iOS system menu cannot be presented; fall back to '
                      'AdaptiveTextSelectionToolbar.'),
                  ccBullet(
                      'Pitfall 3 — Including a non-supported item by mistake. '
                      'For example IOSSystemContextMenuItemLiveText only '
                      'appears when iOS reports Live Text input is available; '
                      'including it has no harmful effect, just no UI.'),
                  ccBullet(
                      'Pitfall 4 — Custom items on iOS < 16. '
                      'IOSSystemContextMenuItemCustom only invokes its '
                      'onPressed on iOS 16 and later. Always feature-detect.'),
                  ccBullet(
                      'Pitfall 5 — Returning an empty items list. The menu is '
                      'simply not shown. This is fine, but log it in debug '
                      'builds so you understand why nothing pops up.'),
                  ccCallout(
                    'Always test on a real device',
                    'The iOS Simulator faithfully reproduces the system menu, '
                        'but Live Text and Look Up depend on real device '
                        'capabilities.',
                    color: ccDanger,
                  ),
                ],
              ),

              // ─── section 14 — reference table ───────────────────────────
              ccSection(
                '14 · Reference — all IOSSystemContextMenuItem subclasses',
                'Quick lookup for the sealed hierarchy.',
                <Widget>[
                  for (final Map<String, String> entry in ccItemReference)
                    ccRefRow(entry),
                  ccDivider(),
                  ccCallout(
                    'Sealed base class',
                    'IOSSystemContextMenuItem is sealed in '
                        'package:flutter/widgets.dart, which means the compiler '
                        'enforces exhaustive switches on its subtypes — handy '
                        'when your own builder needs to translate item types.',
                  ),
                ],
              ),

              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'End of demo · IOSSystemContextMenuItemCopy is exercised by '
                  'every contextMenuBuilder above on every platform · platform: '
                  '$ccPlatformName',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 11,
                      color: ccTextDark.withValues(alpha: 0.6)),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}

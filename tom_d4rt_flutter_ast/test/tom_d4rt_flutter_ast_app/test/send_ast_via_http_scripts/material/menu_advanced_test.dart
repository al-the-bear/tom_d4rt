// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, sized_box_for_whitespace, no_leading_underscores_for_local_identifiers, duplicate_ignore
// D4rt deep demo - Material Menu family (visual hand-authored)
// ---------------------------------------------------------------------------
// This file is a long-form, analyzer-clean visual deep demo of the Material
// menu family: MenuAnchor, MenuItemButton, SubmenuButton, MenuController,
// MenuStyle, MenuBar, CheckboxMenuButton, RadioMenuButton. The renderer of
// this script is a stateless interpreter: there is no setState, no
// AnimationController, no Timer, no async, no MenuController instantiation.
// The demo therefore renders STATIC SNAPSHOTS that show how each widget
// looks when it is closed AND simulated open frames drawn by hand using
// regular Flutter widgets (Container, Row, Column, Material, Icon, Text).
//
// The point of the file is pedagogical: a future reader (human or
// interpreter) can scroll a single page and see every visual state a real
// Material menu can take, side-by-side with the closed widget that produced
// it, with prose explaining the why and the gotchas.
//
// Section index:
//   01  Hero card                       - elevator pitch
//   02  Anatomy diagram                 - MenuAnchor / child / menuChildren
//   03  MenuController flow             - narrated open/close lifecycle
//   04  MenuBar showcase                - real MenuBar plus open snapshots
//   05  MenuItemButton variants         - leadingIcon, trailingIcon, shortcut
//   06  SubmenuButton snapshot          - nested submenu open frame
//   07  CheckboxMenuButton swatches     - tri-state checkbox items
//   08  RadioMenuButton swatches        - exclusive radio items
//   09  MenuStyle theming               - background, padding, alignment
//   10  Anchor positioning              - alignmentOffset / MenuStyle.alignment
//   11  Keyboard shortcut card          - SingleActivator combinations
//   12  Real MenuAnchor sample          - closed trigger
//   13  Comparison vs PopupMenuButton   - when to pick which
//   14  Pitfalls and gotchas            - controller lifetime, ancestor focus
//   15  Accessibility notes             - semantics, focus, screen readers
//   16  Footer                          - credits and reading order
// ---------------------------------------------------------------------------
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ---------------------------------------------------------------------------
  // Palette - a calm slate-and-amber theme. Menus are utility surfaces, so
  // we lean on neutral backgrounds and reserve the warm accent for the
  // currently focused or selected row. Every color uses
  // Color.withValues(alpha: ...) so the file is forward-compatible with the
  // wide-gamut color rework in Flutter 3.27+.
  // ---------------------------------------------------------------------------
  final Color slate900 = const Color(0xFF0F172A);
  final Color slate800 = const Color(0xFF1E293B);
  final Color slate700 = const Color(0xFF334155);
  final Color slate600 = const Color(0xFF475569);
  final Color slate500 = const Color(0xFF64748B);
  final Color slate400 = const Color(0xFF94A3B8);
  final Color slate300 = const Color(0xFFCBD5E1);
  final Color slate200 = const Color(0xFFE2E8F0);
  final Color slate100 = const Color(0xFFF1F5F9);
  final Color slate50 = const Color(0xFFF8FAFC);
  final Color amber600 = const Color(0xFFD97706);
  final Color amber500 = const Color(0xFFF59E0B);
  final Color amber400 = const Color(0xFFFBBF24);
  final Color amber100 = const Color(0xFFFEF3C7);
  final Color amber50 = const Color(0xFFFFFBEB);
  final Color teal600 = const Color(0xFF0D9488);
  final Color teal500 = const Color(0xFF14B8A6);
  final Color teal100 = const Color(0xFFCCFBF1);
  final Color rose600 = const Color(0xFFE11D48);
  final Color rose500 = const Color(0xFFF43F5E);
  final Color rose100 = const Color(0xFFFFE4E6);
  final Color emerald600 = const Color(0xFF059669);
  final Color emerald500 = const Color(0xFF10B981);
  final Color emerald100 = const Color(0xFFD1FAE5);
  final Color sky600 = const Color(0xFF0284C7);
  final Color sky500 = const Color(0xFF0EA5E9);
  final Color sky100 = const Color(0xFFE0F2FE);
  final Color violet600 = const Color(0xFF7C3AED);
  final Color violet500 = const Color(0xFF8B5CF6);
  final Color violet100 = const Color(0xFFEDE9FE);

  // ---------------------------------------------------------------------------
  // Typography helpers. Menus are dense; text styles are the most-tweaked
  // part of theming. We keep them as plain TextStyle constants so the rest
  // of the file can stay declarative.
  // ---------------------------------------------------------------------------
  final TextStyle hMega = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w800,
    color: Colors.white,
    letterSpacing: -0.5,
    height: 1.1,
  );
  final TextStyle hLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: slate900,
    letterSpacing: -0.2,
  );
  final TextStyle hMedium = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: slate800,
  );
  final TextStyle hSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: slate700,
  );
  final TextStyle bodyText = TextStyle(
    fontSize: 14,
    color: slate700,
    height: 1.45,
  );
  final TextStyle muted = TextStyle(
    fontSize: 12.5,
    color: slate500,
    height: 1.4,
  );
  final TextStyle code = TextStyle(
    fontSize: 13,
    fontFamily: 'monospace',
    color: slate900,
  );
  final TextStyle codeOnDark = TextStyle(
    fontSize: 12.5,
    fontFamily: 'monospace',
    color: amber400,
  );
  final TextStyle menuItemText = TextStyle(
    fontSize: 14,
    color: slate800,
    fontWeight: FontWeight.w500,
  );
  final TextStyle menuItemMuted = TextStyle(
    fontSize: 14,
    color: slate400,
    fontWeight: FontWeight.w500,
  );
  final TextStyle shortcutText = TextStyle(
    fontSize: 11.5,
    color: slate500,
    fontFamily: 'monospace',
    fontWeight: FontWeight.w600,
  );

  // ===========================================================================
  // Reusable building blocks.
  //
  // The widget tree below assembles many small "snapshots" of menus. Rather
  // than repeat 30 lines of Container + BoxDecoration each time, we wrap
  // the common patterns in tiny local helpers. Each helper is a closure
  // returning a Widget so we keep the single-build-function shape required
  // by the d4rt harness.
  // ===========================================================================

  // section card - the outer frame for every numbered section.
  Widget sectionCard({required String number, required String title, required String subtitle, required Widget body}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: slate200, width: 1),
        boxShadow: [
          BoxShadow(
            color: slate900.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: slate100, width: 1)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 38,
                  height: 38,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: slate900,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    number,
                    style: TextStyle(
                      color: amber400,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: hLarge),
                      const SizedBox(height: 4),
                      Text(subtitle, style: muted),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 22),
            child: body,
          ),
        ],
      ),
    );
  }

  // pill - a small colored pill for tags and labels.
  Widget pill(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: fg,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  // codeBlock - a dark code preview with a small label strip.
  Widget codeBlock(String label, String content) {
    return Container(
      decoration: BoxDecoration(
        color: slate900,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: slate800,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(color: rose500, shape: BoxShape.circle),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(color: amber400, shape: BoxShape.circle),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(color: emerald500, shape: BoxShape.circle),
                ),
                const SizedBox(width: 14),
                Text(
                  label,
                  style: TextStyle(
                    color: slate300,
                    fontSize: 11.5,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Text(content, style: codeOnDark),
          ),
        ],
      ),
    );
  }

  // bulletRow - text bullet with a colored dot.
  Widget bulletRow(Color dot, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 7,
            height: 7,
            decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: bodyText)),
        ],
      ),
    );
  }

  // shortcutBadge - draws "Ctrl+N" style key combos.
  Widget shortcutBadge(List<String> keys) {
    final List<Widget> chips = <Widget>[];
    for (int i = 0; i < keys.length; i++) {
      chips.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: slate100,
            border: Border.all(color: slate300, width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(keys[i], style: shortcutText),
        ),
      );
      if (i != keys.length - 1) {
        chips.add(const SizedBox(width: 3));
        chips.add(Text('+', style: TextStyle(color: slate400, fontSize: 11)));
        chips.add(const SizedBox(width: 3));
      }
    }
    return Row(mainAxisSize: MainAxisSize.min, children: chips);
  }

  // staticMenuItemRow - draws a single menu item the way MenuItemButton
  // would render it once open. This is a SNAPSHOT - it is a normal Row, not
  // a real menu entry, so it can sit inside any Column without a routing
  // ancestor.
  Widget staticMenuItemRow({
    IconData? leading,
    required String label,
    String? shortcut,
    bool disabled = false,
    bool focused = false,
    bool hasSubmenu = false,
    bool? checkbox,
    bool? radio,
  }) {
    final Color bg = focused ? amber50 : Colors.transparent;
    final Color textColor = disabled ? slate400 : slate800;
    final Color iconColor = disabled ? slate300 : slate600;
    final List<Widget> leadingWidgets = <Widget>[];
    if (checkbox != null) {
      leadingWidgets.add(
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: checkbox ? amber500 : Colors.white,
            border: Border.all(color: checkbox ? amber500 : slate400, width: 1.5),
            borderRadius: BorderRadius.circular(3),
          ),
          child: checkbox
              ? Icon(Icons.check, size: 12, color: Colors.white)
              : const SizedBox.shrink(),
        ),
      );
      leadingWidgets.add(const SizedBox(width: 10));
    } else if (radio != null) {
      leadingWidgets.add(
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: radio ? amber500 : slate400, width: 1.5),
            shape: BoxShape.circle,
          ),
          child: radio
              ? Center(
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(color: amber500, shape: BoxShape.circle),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      );
      leadingWidgets.add(const SizedBox(width: 10));
    } else if (leading != null) {
      leadingWidgets.add(Icon(leading, size: 17, color: iconColor));
      leadingWidgets.add(const SizedBox(width: 10));
    } else {
      leadingWidgets.add(const SizedBox(width: 26));
    }

    final List<Widget> trailingWidgets = <Widget>[];
    if (shortcut != null) {
      trailingWidgets.add(const SizedBox(width: 24));
      trailingWidgets.add(Text(shortcut, style: shortcutText));
    }
    if (hasSubmenu) {
      trailingWidgets.add(const SizedBox(width: 10));
      trailingWidgets.add(Icon(Icons.chevron_right, size: 16, color: slate500));
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          ...leadingWidgets,
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ),
          ...trailingWidgets,
        ],
      ),
    );
  }

  // staticMenuDivider - the thin line between groups inside a menu surface.
  Widget staticMenuDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
      height: 1,
      color: slate100,
    );
  }

  // staticMenuSurface - the rounded white card that wraps menu items. This
  // is the visual chrome that MenuStyle controls in real code.
  Widget staticMenuSurface({
    required List<Widget> children,
    Color? background,
    double minWidth = 220,
    EdgeInsets padding = const EdgeInsets.all(6),
    BorderRadius? radius,
    double elevation = 12,
  }) {
    return Container(
      constraints: BoxConstraints(minWidth: minWidth, maxWidth: 320),
      padding: padding,
      decoration: BoxDecoration(
        color: background ?? Colors.white,
        borderRadius: radius ?? BorderRadius.circular(10),
        border: Border.all(color: slate200, width: 1),
        boxShadow: [
          BoxShadow(
            color: slate900.withValues(alpha: 0.10),
            blurRadius: elevation,
            offset: Offset(0, elevation / 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // The full page is a long Column inside a SingleChildScrollView. Each
  // section is its own card. We accumulate them in a list to keep the
  // Column literal readable.
  // ---------------------------------------------------------------------------
  final List<Widget> sections = <Widget>[];

  // ===========================================================================
  // SECTION 01 - HERO CARD
  //
  // The hero is the elevator pitch for the page. A reader who scrolls only
  // the first card should leave with three concrete takeaways:
  //   1. The Material menu family rebuilds the WHAT of PopupMenuButton on
  //      the new MenuAnchor / MenuController plumbing.
  //   2. MenuAnchor is the "keep me alive while my child is mounted"
  //      anchor, and MenuController is the imperative open/close handle.
  //   3. MenuBar, SubmenuButton, MenuItemButton, CheckboxMenuButton, and
  //      RadioMenuButton are concrete widgets you compose into menu trees.
  // ===========================================================================
  sections.add(
    Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 26),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [slate900, slate800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: slate900.withValues(alpha: 0.25),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: amber500.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: amber400.withValues(alpha: 0.35), width: 1),
                ),
                child: Text(
                  'MATERIAL  /  MENU FAMILY',
                  style: TextStyle(
                    color: amber400,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.4,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: emerald500.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: emerald500.withValues(alpha: 0.35), width: 1),
                ),
                child: Text(
                  'STATIC SNAPSHOT MODE',
                  style: TextStyle(
                    color: emerald500,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'MenuAnchor, MenuBar,\nand the new menu primitives.',
            style: hMega,
          ),
          const SizedBox(height: 14),
          Container(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              'The widgets in this card are real Flutter widgets, but the menus '
              'themselves are drawn by hand as static snapshots so they can be '
              'compared side-by-side. The original closed triggers are still '
              'present in the document so you can see the resting state next '
              'to the open visual.',
              style: TextStyle(
                color: slate300,
                fontSize: 14.5,
                height: 1.55,
              ),
            ),
          ),
          const SizedBox(height: 22),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              pill('MenuAnchor', amber500.withValues(alpha: 0.18), amber400),
              pill('MenuController', amber500.withValues(alpha: 0.18), amber400),
              pill('MenuBar', amber500.withValues(alpha: 0.18), amber400),
              pill('MenuItemButton', amber500.withValues(alpha: 0.18), amber400),
              pill('SubmenuButton', amber500.withValues(alpha: 0.18), amber400),
              pill('CheckboxMenuButton', amber500.withValues(alpha: 0.18), amber400),
              pill('RadioMenuButton', amber500.withValues(alpha: 0.18), amber400),
              pill('MenuStyle', amber500.withValues(alpha: 0.18), amber400),
              pill('SingleActivator', amber500.withValues(alpha: 0.18), amber400),
            ],
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 02 - ANATOMY DIAGRAM
  //
  // MenuAnchor takes three slots that are easy to mix up:
  //   - builder    : draws the trigger (the always-visible widget).
  //   - menuChildren: the items that appear when the menu is open.
  //   - child      : an optional child threaded through builder so it is
  //                  not rebuilt on every controller tick.
  //
  // The diagram below visualizes that tree. The thin amber line traces the
  // identity flow from MenuAnchor -> MenuController -> menuChildren.
  // ===========================================================================
  sections.add(
    sectionCard(
      number: '02',
      title: 'Anatomy of a MenuAnchor',
      subtitle: 'Three slots: builder (the trigger), menuChildren (the items), and child (forwarded into builder).',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: slate50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: slate200, width: 1),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: slate900,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.link, color: amber400, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        'MenuAnchor',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Container(width: 2, height: 22, color: amber500),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: slate300, width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('builder', style: code.copyWith(color: violet600, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 6),
                            Text(
                              '(context, controller, child) {\n'
                              '  return IconButton(...);\n'
                              '}',
                              style: code,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Renders the always-visible trigger. Receives a '
                              'MenuController so the trigger can call open() / '
                              'close() / isOpen.',
                              style: muted,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: slate300, width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('menuChildren', style: code.copyWith(color: teal600, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 6),
                            Text(
                              '<Widget>[\n'
                              '  MenuItemButton(...),\n'
                              '  SubmenuButton(...),\n'
                              ']',
                              style: code,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'The items that appear inside the open menu. '
                              'Items can be MenuItemButton, SubmenuButton, '
                              'CheckboxMenuButton, RadioMenuButton, or any '
                              'arbitrary widget.',
                              style: muted,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: amber50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: amber400.withValues(alpha: 0.5), width: 1),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.lightbulb_outline, size: 18, color: amber600),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'When you do NOT pass a controller, MenuAnchor creates '
                          'one internally and disposes it for you. Pass your own '
                          'only if you need to drive the menu from somewhere '
                          'OTHER than the trigger - for example a "Help" button '
                          'in the AppBar or a keyboard shortcut wired through '
                          'CallbackShortcuts.',
                          style: bodyText.copyWith(color: slate800),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          codeBlock(
            'menu_anchor.dart',
            'MenuAnchor(\n'
            '  controller: optional,                     // own controller\n'
            '  alignmentOffset: const Offset(0, 4),      // gap below trigger\n'
            '  consumeOutsideTap: true,                  // swallow first tap\n'
            '  style: MenuStyle(...),                    // surface theming\n'
            '  builder: (ctx, ctrl, child) => IconButton(\n'
            '    icon: const Icon(Icons.more_vert),\n'
            '    onPressed: () => ctrl.isOpen ? ctrl.close() : ctrl.open(),\n'
            '  ),\n'
            '  menuChildren: <Widget>[\n'
            '    MenuItemButton(child: Text("New"),  onPressed: ...),\n'
            '    MenuItemButton(child: Text("Open"), onPressed: ...),\n'
            '    const Divider(height: 1),\n'
            '    SubmenuButton(\n'
            '      menuChildren: const <Widget>[...],\n'
            '      child: const Text("Recent"),\n'
            '    ),\n'
            '  ],\n'
            ')',
          ),
        ],
      ),
    ),
  );

  // ---------------------------------------------------------------------------
  // Helpers used by the controller-flow snapshots in section 03 and 04.
  // ---------------------------------------------------------------------------
  Widget triggerChip(Color bg, Color fg, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: slate300, width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
          fontFamily: 'monospace',
        ),
      ),
    );
  }

  Widget flowFrame({
    required String step,
    required String title,
    required String body,
    required Widget trigger,
    required bool showOverlay,
    required List<Widget> overlayItems,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: slate50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: slate200, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: slate900,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  step,
                  style: TextStyle(
                    color: amber400,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(child: Text(title, style: hSmall)),
            ],
          ),
          const SizedBox(height: 10),
          Align(alignment: Alignment.centerLeft, child: trigger),
          const SizedBox(height: 8),
          if (showOverlay)
            staticMenuSurface(children: overlayItems, minWidth: 180, elevation: 8)
          else
            Container(
              height: 28,
              alignment: Alignment.centerLeft,
              child: Text('(no overlay)', style: muted.copyWith(fontStyle: FontStyle.italic)),
            ),
          const SizedBox(height: 10),
          Text(body, style: muted),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 03 - MENU CONTROLLER FLOW
  //
  // Without setState we cannot animate the menu open/close, but we can
  // describe the lifecycle frame-by-frame. The diagram below is a 4-step
  // strip that shows the pixel-level state at each moment a real
  // MenuController would advance. It documents the full vocabulary:
  //   - controller.open()        : show the overlay
  //   - controller.close()       : tear down the overlay
  //   - controller.isOpen        : current state (read-only)
  //   - implicit close on tap-outside (consumeOutsideTap)
  //   - implicit close on Escape (handled by the menu itself)
  // ===========================================================================
  sections.add(
    sectionCard(
      number: '03',
      title: 'MenuController open / close lifecycle',
      subtitle: 'Four labelled snapshots that walk through the imperative API. No live controller is instantiated here.',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: flowFrame(
                  step: '1',
                  title: 'Resting',
                  body: 'Trigger visible, controller.isOpen == false. The '
                      'overlay route is not mounted.',
                  trigger: triggerChip(slate100, slate700, 'Actions  v'),
                  showOverlay: false,
                  overlayItems: const <Widget>[],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: flowFrame(
                  step: '2',
                  title: 'Open requested',
                  body: 'controller.open() pushes a _MenuPanel into the '
                      'Overlay above the trigger. First focus moves to the '
                      'first focusable item.',
                  trigger: triggerChip(amber100, amber600, 'Actions  ^'),
                  showOverlay: true,
                  overlayItems: <Widget>[
                    staticMenuItemRow(leading: Icons.add, label: 'New', shortcut: 'Ctrl+N', focused: true),
                    staticMenuItemRow(leading: Icons.folder_open, label: 'Open', shortcut: 'Ctrl+O'),
                    staticMenuItemRow(leading: Icons.save, label: 'Save', shortcut: 'Ctrl+S'),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: flowFrame(
                  step: '3',
                  title: 'Item activated',
                  body: 'Tapping or pressing Enter on a MenuItemButton runs '
                      'its onPressed and calls controller.close() afterward.',
                  trigger: triggerChip(amber100, amber600, 'Actions  ^'),
                  showOverlay: true,
                  overlayItems: <Widget>[
                    staticMenuItemRow(leading: Icons.add, label: 'New', shortcut: 'Ctrl+N'),
                    staticMenuItemRow(leading: Icons.folder_open, label: 'Open', shortcut: 'Ctrl+O', focused: true),
                    staticMenuItemRow(leading: Icons.save, label: 'Save', shortcut: 'Ctrl+S'),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: flowFrame(
                  step: '4',
                  title: 'Closed',
                  body: 'controller.close() unmounts the overlay route. '
                      'Focus is restored to whatever held it before open().',
                  trigger: triggerChip(slate100, slate700, 'Actions  v'),
                  showOverlay: false,
                  overlayItems: const <Widget>[],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          codeBlock(
            'controller_usage.dart',
            '// 1. Default - MenuAnchor owns the controller.\n'
            'MenuAnchor(builder: (_, c, __) => ..., menuChildren: ...)\n\n'
            '// 2. External controller - drive from anywhere.\n'
            'final MenuController controller = MenuController();\n'
            'MenuAnchor(\n'
            '  controller: controller,\n'
            '  builder: (ctx, c, child) => IconButton(\n'
            '    onPressed: () => c.isOpen ? c.close() : c.open(),\n'
            '    icon: const Icon(Icons.menu),\n'
            '  ),\n'
            '  menuChildren: const <Widget>[],\n'
            ')\n\n'
            '// 3. Imperative open from a *different* widget.\n'
            'TextButton(\n'
            '  onPressed: () => controller.open(),\n'
            '  child: const Text("Show menu"),\n'
            ')\n\n'
            '// 4. Imperative close (rarely needed; tap-outside / Esc work).\n'
            'controller.close();',
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 04 - MENU BAR SHOWCASE
  //
  // We render a real MenuBar with three submenus (File, Edit, View) so the
  // CLOSED bar is genuine Material widgetry, then we draw three "open
  // snapshots" beside the bar - one per menu - using staticMenuSurface so a
  // reader can see what each cascade looks like without us needing to
  // animate it. The static snapshots use the same vertical order, padding,
  // and dividers Flutter would produce at default density.
  // ===========================================================================
  sections.add(
    sectionCard(
      number: '04',
      title: 'MenuBar with three submenus',
      subtitle: 'Real MenuBar (closed) above, hand-drawn open snapshots below for File / Edit / View.',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // The real MenuBar widget. It is a stateless declarative widget
          // that internally owns a MenuController for each SubmenuButton.
          // The harness can render it just fine - it just will not actually
          // open anything because no input pipeline is attached. That is OK
          // for our purposes: we only need the closed bar.
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: slate50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: slate200, width: 1),
            ),
            child: MenuBar(
              children: <Widget>[
                SubmenuButton(
                  menuChildren: <Widget>[
                    MenuItemButton(
                      onPressed: () {},
                      leadingIcon: const Icon(Icons.add),
                      child: const Text('New'),
                    ),
                    MenuItemButton(
                      onPressed: () {},
                      leadingIcon: const Icon(Icons.folder_open),
                      child: const Text('Open'),
                    ),
                    MenuItemButton(
                      onPressed: () {},
                      leadingIcon: const Icon(Icons.save),
                      child: const Text('Save'),
                    ),
                  ],
                  child: const Text('File'),
                ),
                SubmenuButton(
                  menuChildren: <Widget>[
                    MenuItemButton(onPressed: () {}, child: const Text('Undo')),
                    MenuItemButton(onPressed: () {}, child: const Text('Redo')),
                    MenuItemButton(onPressed: null, child: const Text('Cut')),
                    MenuItemButton(onPressed: () {}, child: const Text('Copy')),
                    MenuItemButton(onPressed: () {}, child: const Text('Paste')),
                  ],
                  child: const Text('Edit'),
                ),
                SubmenuButton(
                  menuChildren: <Widget>[
                    CheckboxMenuButton(
                      value: true,
                      onChanged: (bool? v) {},
                      child: const Text('Sidebar'),
                    ),
                    CheckboxMenuButton(
                      value: false,
                      onChanged: (bool? v) {},
                      child: const Text('Status bar'),
                    ),
                  ],
                  child: const Text('View'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Open snapshots (each one shows what dropping the corresponding '
            'menu would look like in default density):',
            style: muted,
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('File', style: hSmall),
                    const SizedBox(height: 6),
                    staticMenuSurface(
                      children: <Widget>[
                        staticMenuItemRow(leading: Icons.add, label: 'New', shortcut: 'Ctrl+N'),
                        staticMenuItemRow(leading: Icons.folder_open, label: 'Open', shortcut: 'Ctrl+O'),
                        staticMenuItemRow(leading: Icons.save, label: 'Save', shortcut: 'Ctrl+S'),
                        staticMenuDivider(),
                        staticMenuItemRow(leading: Icons.history, label: 'Recent', hasSubmenu: true),
                        staticMenuDivider(),
                        staticMenuItemRow(leading: Icons.exit_to_app, label: 'Exit', shortcut: 'Alt+F4'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Edit', style: hSmall),
                    const SizedBox(height: 6),
                    staticMenuSurface(
                      children: <Widget>[
                        staticMenuItemRow(leading: Icons.undo, label: 'Undo', shortcut: 'Ctrl+Z'),
                        staticMenuItemRow(leading: Icons.redo, label: 'Redo', shortcut: 'Ctrl+Y'),
                        staticMenuDivider(),
                        staticMenuItemRow(leading: Icons.content_cut, label: 'Cut', shortcut: 'Ctrl+X', disabled: true),
                        staticMenuItemRow(leading: Icons.content_copy, label: 'Copy', shortcut: 'Ctrl+C'),
                        staticMenuItemRow(leading: Icons.content_paste, label: 'Paste', shortcut: 'Ctrl+V'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('View', style: hSmall),
                    const SizedBox(height: 6),
                    staticMenuSurface(
                      children: <Widget>[
                        staticMenuItemRow(checkbox: true, label: 'Sidebar', shortcut: 'Ctrl+B'),
                        staticMenuItemRow(checkbox: false, label: 'Status bar'),
                        staticMenuItemRow(checkbox: true, label: 'Minimap'),
                        staticMenuDivider(),
                        staticMenuItemRow(leading: Icons.zoom_in, label: 'Zoom in', shortcut: 'Ctrl++'),
                        staticMenuItemRow(leading: Icons.zoom_out, label: 'Zoom out', shortcut: 'Ctrl+-'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 05 - MENU ITEM BUTTON VARIANTS
  //
  // MenuItemButton is the workhorse. The slot vocabulary:
  //   - leadingIcon  : Widget shown to the left of the label.
  //   - trailingIcon : Widget shown to the right (often a shortcut hint).
  //   - shortcut     : a MenuSerializableShortcut, normally a SingleActivator.
  //   - onPressed    : VoidCallback, or null to disable.
  //   - child        : the label widget (usually Text).
  //   - closeOnActivate : whether tapping closes the parent menu (default true).
  //
  // The strip below catalogs the common combinations: plain, leading-only,
  // leading+shortcut, leading+trailing badge, disabled, danger-styled, and
  // open-submenu indicator.
  // ===========================================================================
  sections.add(
    sectionCard(
      number: '05',
      title: 'MenuItemButton variants',
      subtitle: 'Every common slot combination drawn as an open-menu snapshot.',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: <Widget>[
              // Variant A - plain text.
              Container(
                width: 240,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    pill('plain', slate100, slate700),
                    const SizedBox(height: 6),
                    staticMenuSurface(children: <Widget>[
                      staticMenuItemRow(label: 'Rename'),
                      staticMenuItemRow(label: 'Duplicate'),
                      staticMenuItemRow(label: 'Move'),
                    ]),
                  ],
                ),
              ),
              // Variant B - leading icon.
              Container(
                width: 240,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    pill('leadingIcon', sky100, sky600),
                    const SizedBox(height: 6),
                    staticMenuSurface(children: <Widget>[
                      staticMenuItemRow(leading: Icons.edit, label: 'Edit'),
                      staticMenuItemRow(leading: Icons.share, label: 'Share'),
                      staticMenuItemRow(leading: Icons.archive, label: 'Archive'),
                    ]),
                  ],
                ),
              ),
              // Variant C - shortcuts visible.
              Container(
                width: 240,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    pill('shortcut', emerald100, emerald600),
                    const SizedBox(height: 6),
                    staticMenuSurface(children: <Widget>[
                      staticMenuItemRow(leading: Icons.search, label: 'Find', shortcut: 'Ctrl+F'),
                      staticMenuItemRow(leading: Icons.find_replace, label: 'Replace', shortcut: 'Ctrl+H'),
                      staticMenuItemRow(leading: Icons.subdirectory_arrow_right, label: 'Find next', shortcut: 'F3'),
                    ]),
                  ],
                ),
              ),
              // Variant D - disabled rows.
              Container(
                width: 240,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    pill('disabled', slate100, slate500),
                    const SizedBox(height: 6),
                    staticMenuSurface(children: <Widget>[
                      staticMenuItemRow(leading: Icons.upload, label: 'Upload', disabled: true),
                      staticMenuItemRow(leading: Icons.download, label: 'Download'),
                      staticMenuItemRow(leading: Icons.cloud_off, label: 'Offline mode', disabled: true),
                    ]),
                  ],
                ),
              ),
              // Variant E - hover/focus highlight.
              Container(
                width: 240,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    pill('focused row', amber100, amber600),
                    const SizedBox(height: 6),
                    staticMenuSurface(children: <Widget>[
                      staticMenuItemRow(leading: Icons.add, label: 'Add'),
                      staticMenuItemRow(leading: Icons.tune, label: 'Configure', focused: true),
                      staticMenuItemRow(leading: Icons.delete_outline, label: 'Remove'),
                    ]),
                  ],
                ),
              ),
              // Variant F - has submenu indicator.
              Container(
                width: 240,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    pill('hasSubmenu', violet100, violet600),
                    const SizedBox(height: 6),
                    staticMenuSurface(children: <Widget>[
                      staticMenuItemRow(leading: Icons.history, label: 'Recent', hasSubmenu: true),
                      staticMenuItemRow(leading: Icons.bookmarks, label: 'Bookmarks', hasSubmenu: true),
                      staticMenuItemRow(leading: Icons.label_outline, label: 'Tags', hasSubmenu: true),
                    ]),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          codeBlock(
            'menu_item_button.dart',
            'MenuItemButton(\n'
            '  onPressed: () => doSomething(),\n'
            '  shortcut: const SingleActivator(LogicalKeyboardKey.keyF, control: true),\n'
            '  leadingIcon: const Icon(Icons.search),\n'
            '  trailingIcon: const SizedBox.shrink(), // shortcut already shown\n'
            '  closeOnActivate: true,                 // dismiss after tap\n'
            '  child: const Text("Find"),\n'
            ')',
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 06 - SUBMENU BUTTON SNAPSHOT
  //
  // SubmenuButton is the cascade. Visually, it looks like a MenuItemButton
  // with a chevron, but functionally it owns its OWN MenuController for
  // its own menuChildren. Submenus open to the right by default; the
  // alignmentOffset and menuStyle.alignment are how you pull them
  // upward, leftward, or onto a different anchor.
  //
  // The drawing below shows the "open over open" state: a top-level menu
  // with one row hovered, and the cascade fanned out beside it.
  // ===========================================================================
  sections.add(
    sectionCard(
      number: '06',
      title: 'SubmenuButton cascading snapshot',
      subtitle: 'Top-level menu plus the open submenu drawn side-by-side.',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 22),
            decoration: BoxDecoration(
              color: slate50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: slate200, width: 1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                staticMenuSurface(
                  minWidth: 200,
                  children: <Widget>[
                    staticMenuItemRow(leading: Icons.add, label: 'New file', shortcut: 'Ctrl+N'),
                    staticMenuItemRow(leading: Icons.create_new_folder, label: 'New folder'),
                    staticMenuDivider(),
                    staticMenuItemRow(leading: Icons.history, label: 'Recent', hasSubmenu: true, focused: true),
                    staticMenuItemRow(leading: Icons.bookmarks, label: 'Bookmarks', hasSubmenu: true),
                  ],
                ),
                const SizedBox(width: 8),
                Container(
                  margin: const EdgeInsets.only(top: 92),
                  child: Icon(Icons.east, size: 16, color: slate400),
                ),
                const SizedBox(width: 8),
                Container(
                  margin: const EdgeInsets.only(top: 70),
                  child: staticMenuSurface(
                    minWidth: 220,
                    children: <Widget>[
                      staticMenuItemRow(leading: Icons.description, label: 'project_v17.flx'),
                      staticMenuItemRow(leading: Icons.description, label: 'design_notes.md'),
                      staticMenuItemRow(leading: Icons.description, label: 'budget.xlsx'),
                      staticMenuDivider(),
                      staticMenuItemRow(leading: Icons.layers, label: 'More...', hasSubmenu: true),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          bulletRow(amber500,
              'Submenus inherit the parent MenuStyle unless they specify '
              'menuStyle of their own.'),
          bulletRow(emerald500,
              'A submenu can be opened by hover, by Tab/right-arrow, or by '
              'tapping the parent SubmenuButton.'),
          bulletRow(sky500,
              'Submenus close together with the parent when the user taps '
              'outside or presses Escape.'),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 07 - CHECKBOX MENU BUTTON SWATCHES
  //
  // CheckboxMenuButton is a MenuItemButton with a leading checkbox glyph.
  // Its value is a nullable bool so it supports tri-state (true / false /
  // null = mixed). The onChanged callback is called with the new value so
  // the host widget can flip the bound bool.
  //
  // The grid below catalogs the three states.
  // ===========================================================================
  sections.add(
    sectionCard(
      number: '07',
      title: 'CheckboxMenuButton states',
      subtitle: 'Checked / unchecked / mixed (tri-state) drawn as snapshots.',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            spacing: 18,
            runSpacing: 18,
            children: <Widget>[
              Container(
                width: 240,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    pill('value: true', emerald100, emerald600),
                    const SizedBox(height: 6),
                    staticMenuSurface(children: <Widget>[
                      staticMenuItemRow(checkbox: true, label: 'Word wrap'),
                      staticMenuItemRow(checkbox: true, label: 'Spell check'),
                    ]),
                  ],
                ),
              ),
              Container(
                width: 240,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    pill('value: false', slate100, slate600),
                    const SizedBox(height: 6),
                    staticMenuSurface(children: <Widget>[
                      staticMenuItemRow(checkbox: false, label: 'Auto-save'),
                      staticMenuItemRow(checkbox: false, label: 'Smart indent'),
                    ]),
                  ],
                ),
              ),
              Container(
                width: 240,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    pill('mixed (null)', amber100, amber600),
                    const SizedBox(height: 6),
                    staticMenuSurface(children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: amber500,
                                border: Border.all(color: amber500, width: 1.5),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Center(
                                child: Container(
                                  width: 8,
                                  height: 2,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(child: Text('Tabs (mixed)', style: menuItemText)),
                          ],
                        ),
                      ),
                      staticMenuItemRow(checkbox: false, label: 'Spaces'),
                    ]),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          codeBlock(
            'checkbox_menu_button.dart',
            'CheckboxMenuButton(\n'
            '  value: settings.wordWrap,        // bool? (null == mixed)\n'
            '  tristate: false,                 // set true to allow null\n'
            '  onChanged: (bool? next) => setState(() => settings.wordWrap = next ?? false),\n'
            '  child: const Text("Word wrap"),\n'
            ')',
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 08 - RADIO MENU BUTTON SWATCHES
  //
  // RadioMenuButton<T> is the radio counterpart. The whole group shares a
  // groupValue and each entry contributes its own value. Activating a row
  // changes the groupValue via onChanged.
  // ===========================================================================
  sections.add(
    sectionCard(
      number: '08',
      title: 'RadioMenuButton group',
      subtitle: 'Exclusive selection. Snapshot shows three options with one selected.',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    pill('Theme', violet100, violet600),
                    const SizedBox(height: 6),
                    staticMenuSurface(children: <Widget>[
                      staticMenuItemRow(radio: false, label: 'System'),
                      staticMenuItemRow(radio: true, label: 'Light'),
                      staticMenuItemRow(radio: false, label: 'Dark'),
                    ]),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    pill('Density', violet100, violet600),
                    const SizedBox(height: 6),
                    staticMenuSurface(children: <Widget>[
                      staticMenuItemRow(radio: false, label: 'Comfortable'),
                      staticMenuItemRow(radio: false, label: 'Cozy'),
                      staticMenuItemRow(radio: true, label: 'Compact'),
                    ]),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    pill('Sort by', violet100, violet600),
                    const SizedBox(height: 6),
                    staticMenuSurface(children: <Widget>[
                      staticMenuItemRow(radio: true, label: 'Name'),
                      staticMenuItemRow(radio: false, label: 'Modified'),
                      staticMenuItemRow(radio: false, label: 'Size'),
                    ]),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          codeBlock(
            'radio_menu_button.dart',
            'enum AppTheme { system, light, dark }\n\n'
            'AppTheme groupValue = AppTheme.light;\n\n'
            'RadioMenuButton<AppTheme>(\n'
            '  value: AppTheme.system,\n'
            '  groupValue: groupValue,\n'
            '  onChanged: (AppTheme? next) => setState(() => groupValue = next!),\n'
            '  child: const Text("System"),\n'
            ')',
          ),
        ],
      ),
    ),
  );

  // dark menu row helper used by section 09 accent style.
  Widget darkMenuRow(IconData icon, String label, Color iconColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 17, color: iconColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 09 - MENU STYLE THEMING
  //
  // MenuStyle is the WidgetStateProperty-based style class for the open
  // menu surface. Every visual property is a property bag because the
  // menu wants to react to states like hovered or focused.
  //
  //   - backgroundColor : the surface fill.
  //   - elevation       : shadow depth.
  //   - shape           : OutlinedBorder for the surface (RoundedRectangleBorder...).
  //   - padding         : EdgeInsetsGeometry for the items' container.
  //   - shadowColor     : shadow tint.
  //   - surfaceTintColor: the M3 tint applied beneath the elevation overlay.
  //   - alignment       : how the menu attaches to its anchor.
  //
  // Below: the same three-item menu rendered in three different MenuStyle
  // configurations. Each snapshot shows the result; the code panel lists
  // the actual MenuStyle that produced it. We also INSTANTIATE three real
  // MenuStyle objects so the analyzer verifies they parse, then store
  // them in a list so they are never reported as dead code.
  // ===========================================================================
  final MenuStyle defaultMenuStyle = MenuStyle(
    backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
    elevation: const WidgetStatePropertyAll<double>(8),
    shape: WidgetStatePropertyAll<OutlinedBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.all(4)),
    surfaceTintColor: const WidgetStatePropertyAll<Color>(Colors.transparent),
    shadowColor: WidgetStatePropertyAll<Color>(slate900.withValues(alpha: 0.18)),
    alignment: Alignment.bottomLeft,
  );
  final MenuStyle compactMenuStyle = MenuStyle(
    backgroundColor: WidgetStatePropertyAll<Color>(slate50),
    elevation: const WidgetStatePropertyAll<double>(2),
    shape: WidgetStatePropertyAll<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: BorderSide(color: slate300, width: 1),
      ),
    ),
    padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.all(2)),
    alignment: Alignment.bottomLeft,
  );
  final MenuStyle accentMenuStyle = MenuStyle(
    backgroundColor: WidgetStatePropertyAll<Color>(slate900),
    elevation: const WidgetStatePropertyAll<double>(16),
    shape: WidgetStatePropertyAll<OutlinedBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
    padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.all(8)),
    surfaceTintColor: const WidgetStatePropertyAll<Color>(Colors.transparent),
    shadowColor: WidgetStatePropertyAll<Color>(amber500.withValues(alpha: 0.40)),
    alignment: Alignment.topLeft,
  );
  final List<MenuStyle> _allMenuStyles = <MenuStyle>[
    defaultMenuStyle,
    compactMenuStyle,
    accentMenuStyle,
  ];
  // ignore: unused_local_variable
  final int _menuStyleCount = _allMenuStyles.length;

  sections.add(
    sectionCard(
      number: '09',
      title: 'MenuStyle theming',
      subtitle: 'Three real MenuStyle objects rendered as snapshots so you can compare surface decisions side-by-side.',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: <Widget>[
              Container(
                width: 240,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    pill('default', slate100, slate700),
                    const SizedBox(height: 6),
                    staticMenuSurface(
                      children: <Widget>[
                        staticMenuItemRow(leading: Icons.copy, label: 'Copy'),
                        staticMenuItemRow(leading: Icons.cut, label: 'Cut'),
                        staticMenuItemRow(leading: Icons.paste, label: 'Paste'),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 240,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    pill('compact', sky100, sky600),
                    const SizedBox(height: 6),
                    staticMenuSurface(
                      background: slate50,
                      padding: const EdgeInsets.all(2),
                      radius: BorderRadius.circular(4),
                      elevation: 2,
                      children: <Widget>[
                        staticMenuItemRow(leading: Icons.copy, label: 'Copy'),
                        staticMenuItemRow(leading: Icons.cut, label: 'Cut'),
                        staticMenuItemRow(leading: Icons.paste, label: 'Paste'),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 240,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    pill('accent (dark)', amber100, amber600),
                    const SizedBox(height: 6),
                    Container(
                      constraints: const BoxConstraints(minWidth: 220, maxWidth: 320),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: slate900,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: amber500.withValues(alpha: 0.40),
                            blurRadius: 20,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          darkMenuRow(Icons.copy, 'Copy', amber400, slate300),
                          darkMenuRow(Icons.cut, 'Cut', amber400, slate300),
                          darkMenuRow(Icons.paste, 'Paste', amber400, slate300),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          codeBlock(
            'menu_style.dart',
            'final defaultStyle = MenuStyle(\n'
            '  backgroundColor: const WidgetStatePropertyAll(Colors.white),\n'
            '  elevation: const WidgetStatePropertyAll(8),\n'
            '  shape: WidgetStatePropertyAll(RoundedRectangleBorder(\n'
            '    borderRadius: BorderRadius.circular(8))),\n'
            '  padding: const WidgetStatePropertyAll(EdgeInsets.all(4)),\n'
            '  alignment: Alignment.bottomLeft,\n'
            ');\n\n'
            'final compactStyle = MenuStyle(\n'
            '  backgroundColor: const WidgetStatePropertyAll(Color(0xFFF8FAFC)),\n'
            '  elevation: const WidgetStatePropertyAll(2),\n'
            '  shape: WidgetStatePropertyAll(RoundedRectangleBorder(\n'
            '    borderRadius: BorderRadius.circular(4),\n'
            '    side: const BorderSide(color: Color(0xFFCBD5E1)))),\n'
            '  padding: const WidgetStatePropertyAll(EdgeInsets.all(2)),\n'
            ');',
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 10 - ANCHOR POSITIONING
  //
  // The anchor is the bounding rectangle of the trigger. The menu attaches
  // to it via two knobs:
  //
  //   - MenuStyle.alignment    : where on the menu's own rectangle the
  //                              attach point sits.
  //   - MenuAnchor.alignmentOffset : a free-form Offset added on top.
  //
  // The diagram below visualizes a trigger button as a teal rectangle and
  // shows the menu fanned out at four common anchor placements: under,
  // above, right of, and overlapping. Each placement is labelled with the
  // (alignment, alignmentOffset) tuple that produced it.
  // ===========================================================================
  sections.add(
    sectionCard(
      number: '10',
      title: 'Anchor positioning',
      subtitle: 'Four common menu placements relative to the trigger rectangle.',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: slate50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: slate200, width: 1),
            ),
            child: Wrap(
              spacing: 28,
              runSpacing: 28,
              children: <Widget>[
                // Placement A: under the trigger (default).
                Container(
                  width: 280,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('under (default)', style: hSmall),
                      const SizedBox(height: 4),
                      Text('alignment: bottomLeft, offset: (0, 4)', style: muted),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                        decoration: BoxDecoration(
                          color: teal500,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text('Trigger',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'monospace',
                            )),
                      ),
                      const SizedBox(height: 4),
                      staticMenuSurface(
                        minWidth: 200,
                        children: <Widget>[
                          staticMenuItemRow(label: 'Item one'),
                          staticMenuItemRow(label: 'Item two'),
                          staticMenuItemRow(label: 'Item three'),
                        ],
                      ),
                    ],
                  ),
                ),
                // Placement B: above the trigger.
                Container(
                  width: 280,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('above', style: hSmall),
                      const SizedBox(height: 4),
                      Text('alignment: topLeft, offset: (0, -4)', style: muted),
                      const SizedBox(height: 10),
                      staticMenuSurface(
                        minWidth: 200,
                        children: <Widget>[
                          staticMenuItemRow(label: 'Item one'),
                          staticMenuItemRow(label: 'Item two'),
                          staticMenuItemRow(label: 'Item three'),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                        decoration: BoxDecoration(
                          color: teal500,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text('Trigger',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'monospace',
                            )),
                      ),
                    ],
                  ),
                ),
                // Placement C: right of the trigger.
                Container(
                  width: 380,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('right of trigger', style: hSmall),
                      const SizedBox(height: 4),
                      Text('alignment: topRight, offset: (4, 0)', style: muted),
                      const SizedBox(height: 10),
                      // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #48, P3):
                      // The horizontal Row [Trigger, gap, staticMenuSurface]
                      // overflows its parent `Container(width: 380)` by 18 px.
                      // The surface's BoxConstraints (minWidth: 200,
                      // maxWidth: 320) lets it grow beyond its content's
                      // intrinsic width when given non-tight horizontal
                      // constraints by the Row, which combined with the
                      // Trigger and gap pushes total content past 380 px.
                      // Wrapping the surface in `Flexible` lets the Row
                      // shrink it to the remaining space, eliminating the
                      // overflow while keeping the visual intent
                      // (trigger left, menu surface to its right).
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                            decoration: BoxDecoration(
                              color: teal500,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text('Trigger',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'monospace',
                                )),
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: staticMenuSurface(
                              minWidth: 200,
                              children: <Widget>[
                                staticMenuItemRow(label: 'Item one'),
                                staticMenuItemRow(label: 'Item two'),
                                staticMenuItemRow(label: 'Item three'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          codeBlock(
            'positioning.dart',
            'MenuAnchor(\n'
            '  alignmentOffset: const Offset(0, 4),\n'
            '  style: MenuStyle(alignment: Alignment.bottomLeft),\n'
            '  builder: (_, c, __) => trigger,\n'
            '  menuChildren: const <Widget>[],\n'
            ');\n\n'
            '// Pop above by flipping vertical alignment and negating offset.\n'
            'MenuAnchor(\n'
            '  alignmentOffset: const Offset(0, -4),\n'
            '  style: MenuStyle(alignment: Alignment.topLeft),\n'
            '  builder: (_, c, __) => trigger,\n'
            '  menuChildren: const <Widget>[],\n'
            ');',
          ),
        ],
      ),
    ),
  );

  // shortcut row helper used by section 11.
  Widget shortcutLine(List<String> keys, String activator, {bool last = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: last ? Colors.transparent : slate200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: 130, child: shortcutBadge(keys)),
          Expanded(child: Text(activator, style: code)),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 11 - KEYBOARD SHORTCUT CARD
  //
  // SingleActivator is the simplest MenuSerializableShortcut. It accepts a
  // LogicalKeyboardKey and a set of modifier flags (control, shift, alt,
  // meta, includeRepeats). The shortcut shown in a menu item is purely
  // descriptive: ACTUAL handling happens through Flutter's Shortcuts /
  // Actions / CallbackShortcuts ancestor, OR through the MenuController
  // recognizing the key when the menu is open.
  //
  // The card lists six common combinations as visual badges plus their
  // SingleActivator equivalent in code form.
  // ===========================================================================
  sections.add(
    sectionCard(
      number: '11',
      title: 'Keyboard shortcuts (SingleActivator)',
      subtitle: 'Six shortcut chips with the matching SingleActivator literal beside each.',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: slate50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: slate200, width: 1),
            ),
            child: Column(
              children: <Widget>[
                shortcutLine(<String>['Ctrl', 'N'], 'SingleActivator(LogicalKeyboardKey.keyN, control: true)'),
                shortcutLine(<String>['Ctrl', 'Shift', 'P'], 'SingleActivator(LogicalKeyboardKey.keyP, control: true, shift: true)'),
                shortcutLine(<String>['F2'], 'SingleActivator(LogicalKeyboardKey.f2)'),
                shortcutLine(<String>['Alt', 'F4'], 'SingleActivator(LogicalKeyboardKey.f4, alt: true)'),
                shortcutLine(<String>['Cmd', 'K'], 'SingleActivator(LogicalKeyboardKey.keyK, meta: true)'),
                shortcutLine(<String>['Esc'], 'SingleActivator(LogicalKeyboardKey.escape)', last: true),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: amber50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: amber400.withValues(alpha: 0.4), width: 1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.info_outline, size: 18, color: amber600),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'The shortcut shown in a menu item is a HINT. The actual key '
                    'binding is wired separately through Shortcuts/Actions, '
                    'CallbackShortcuts, or the MenuBar route. If the binding '
                    'is missing the menu will simply do nothing when the user '
                    'presses the combo - the label still appears.',
                    style: bodyText.copyWith(color: slate800),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  // comparison table helpers used by section 13.
  Widget compareHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: slate100,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(flex: 2, child: Text('Capability', style: hSmall)),
          Expanded(flex: 3, child: Text('MenuAnchor', style: hSmall.copyWith(color: emerald600))),
          Expanded(flex: 3, child: Text('PopupMenuButton', style: hSmall.copyWith(color: rose600))),
        ],
      ),
    );
  }

  Widget compareRow(String capability, String anchor, String popup, {bool last = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: last ? Colors.transparent : slate200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(flex: 2, child: Text(capability, style: bodyText.copyWith(fontWeight: FontWeight.w600, color: slate800))),
          Expanded(flex: 3, child: Text(anchor, style: bodyText)),
          Expanded(flex: 3, child: Text(popup, style: bodyText)),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 12 - REAL MENU ANCHOR SAMPLE
  //
  // A real MenuAnchor with three menuChildren. The interpreter renders the
  // closed trigger; the open menu is implied. We also include an
  // accessibility-rich version using SubmenuButton with a nested
  // MenuItemButton list, leadingIcon, trailingIcon, and shortcut hints.
  // ===========================================================================
  sections.add(
    sectionCard(
      number: '12',
      title: 'Real MenuAnchor (closed trigger)',
      subtitle: 'Below is an actual MenuAnchor widget. Its menuChildren are real but not rendered (no input pipeline).',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: slate50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: slate200, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                MenuAnchor(
                  menuChildren: <Widget>[
                    MenuItemButton(
                      onPressed: () {},
                      leadingIcon: const Icon(Icons.add),
                      child: const Text('New'),
                    ),
                    MenuItemButton(
                      onPressed: () {},
                      leadingIcon: const Icon(Icons.folder_open),
                      child: const Text('Open'),
                    ),
                    const Divider(height: 1),
                    SubmenuButton(
                      menuChildren: <Widget>[
                        MenuItemButton(onPressed: () {}, child: const Text('project_v17.flx')),
                        MenuItemButton(onPressed: () {}, child: const Text('design_notes.md')),
                      ],
                      leadingIcon: const Icon(Icons.history),
                      child: const Text('Recent'),
                    ),
                  ],
                  builder: (BuildContext ctx, MenuController controller, Widget? child) {
                    return FilledButton.icon(
                      onPressed: () {
                        if (controller.isOpen) {
                          controller.close();
                        } else {
                          controller.open();
                        }
                      },
                      icon: const Icon(Icons.menu),
                      label: const Text('Actions'),
                    );
                  },
                ),
                const SizedBox(width: 16),
                Text('<- closed trigger', style: muted),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 13 - COMPARISON VS POPUP MENU BUTTON
  //
  // A side-by-side decision table for "should I use MenuAnchor or
  // PopupMenuButton?". MenuAnchor is the future; PopupMenuButton is fine
  // for one-shot dropdown buttons but lacks programmatic open, MenuBar
  // composition, and the new MenuStyle vocabulary.
  // ===========================================================================
  sections.add(
    sectionCard(
      number: '13',
      title: 'MenuAnchor vs PopupMenuButton',
      subtitle: 'Two widgets, very different roles. Use this table to pick.',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: slate200, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: <Widget>[
                compareHeader(),
                compareRow('Programmatic open()', 'Yes (controller.open)', 'No (only via menuKey hack)'),
                compareRow('Imperative close()', 'Yes', 'No'),
                compareRow('Submenu cascade', 'Yes (SubmenuButton)', 'No'),
                compareRow('MenuBar composition', 'Yes', 'No'),
                compareRow('Built-in checkbox / radio rows', 'CheckboxMenuButton / RadioMenuButton', 'CheckedPopupMenuItem only'),
                compareRow('Surface theming', 'MenuStyle (WidgetStateProperty)', 'PopupMenuThemeData (single value)'),
                compareRow('Returns selected value', 'No (use callback in item)', 'Yes (Future<T?> from showMenu)', last: true),
              ],
            ),
          ),
          const SizedBox(height: 14),
          bulletRow(emerald500, 'Reach for MenuAnchor when you want a menu bar, '
              'submenus, or programmatic open/close.'),
          bulletRow(amber500, 'Reach for PopupMenuButton when you need showMenu()-'
              'style "ask-and-await" semantics for a single dropdown.'),
        ],
      ),
    ),
  );

  // pitfall card helper used by section 14.
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #48, P5(a)):
  // Original used an asymmetric `Border()` (left: thicker accent,
  // top/right/bottom: uniform slate200) combined with
  // `borderRadius: 8` — Flutter asserts "A borderRadius can only be
  // given on borders with uniform colors." Refactored to a uniform
  // outer `Border.all(slate200, width: 1)` plus a ClipRRect-wrapped
  // Row containing a 4 px-wide accent Container as the visual left
  // bar, IntrinsicHeight so the bar stretches to the card's natural
  // height without an unbounded-height assertion.
  Widget pitfallCard(String title, String fix, Color accent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: slate200, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(width: 4, color: accent),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(title, style: hSmall),
                      const SizedBox(height: 6),
                      Text(fix, style: bodyText),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION 14 - PITFALLS AND GOTCHAS
  //
  // Real-world traps that show up the first time a team adopts MenuAnchor.
  // Each entry pairs the symptom with the fix.
  // ===========================================================================
  sections.add(
    sectionCard(
      number: '14',
      title: 'Pitfalls and gotchas',
      subtitle: 'Common foot-guns when migrating from PopupMenuButton.',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          pitfallCard(
            'Owning a controller in a StatelessWidget',
            'A new MenuController is created on every rebuild, so previous '
                'opens are forgotten. Move the controller into a StatefulWidget '
                'or let MenuAnchor own one.',
            rose500,
          ),
          pitfallCard(
            'closeOnActivate: false leaves menus open',
            'Useful for "do many things" menus, but you must call '
                'controller.close() yourself, otherwise the menu stays open '
                'until the user taps outside.',
            amber500,
          ),
          pitfallCard(
            'consumeOutsideTap swallows the next click',
            'When true, the tap that closes the menu does NOT reach the widget '
                'beneath it. Set it to false if you want the click to also '
                'fire the underlying button (rare, but useful for chained '
                'actions).',
            sky500,
          ),
          pitfallCard(
            'Shortcuts do not fire because no Shortcuts ancestor is wired',
            'The shortcut shown on a MenuItemButton is a HINT. The key still '
                'has to be handled by an enclosing Shortcuts/Actions or '
                'CallbackShortcuts widget, OR by being inside a MenuBar route.',
            emerald500,
          ),
          pitfallCard(
            'Submenus do not appear because the parent is constrained',
            'If the surrounding layout cannot afford the submenu width '
                '(for example inside a narrow Drawer), the submenu pops in '
                'the opposite direction. Use alignmentOffset and MenuStyle.'
                'alignment to force a side.',
            violet500,
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 15 - ACCESSIBILITY NOTES
  //
  // The menu family is highly accessible OUT OF THE BOX, but you can still
  // make small mistakes that ruin screen-reader behaviour.
  // ===========================================================================
  sections.add(
    sectionCard(
      number: '15',
      title: 'Accessibility notes',
      subtitle: 'What to do (and not do) so screen readers and keyboard users have a good time.',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          bulletRow(emerald500,
              'Every MenuItemButton ships with the right Semantics: it '
              'announces as a button, its enabled state matches onPressed != null, '
              'and the trailing shortcut is announced via Semantics.label.'),
          bulletRow(emerald500,
              'CheckboxMenuButton and RadioMenuButton announce their checked '
              'state automatically. Do NOT add your own Semantics(checked:) '
              'wrapper; you would announce twice.'),
          bulletRow(amber500,
              'When you replace a MenuItemButton.child with a custom widget, '
              'add a Semantics label that matches the visible text. Decorative '
              'icons should stay excluded with ExcludeSemantics.'),
          bulletRow(amber500,
              'When using a custom builder for the trigger, give the trigger a '
              'tooltip (or Semantics label) so screen readers announce what '
              'opening the menu does.'),
          bulletRow(sky500,
              'Keyboard navigation inside a menu is automatic: arrow keys move '
              'focus, Enter activates, Escape closes, Tab leaves the menu, '
              'Right-arrow opens a submenu, Left-arrow closes it.'),
          bulletRow(rose500,
              'Do not nest more than ~3 cascades deep. The motor cost climbs '
              'fast and submenu exit becomes confusing.'),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 16 - FOOTER
  // ===========================================================================
  sections.add(
    Container(
      margin: const EdgeInsets.only(top: 8, bottom: 24),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      decoration: BoxDecoration(
        color: slate900,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.menu_book, size: 22, color: amber400),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('End of demo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    )),
                const SizedBox(height: 6),
                Text(
                  'Reading order: hero -> anatomy -> controller flow -> menu '
                  'bar -> item variants -> submenu -> checkbox -> radio -> '
                  'menu style -> positioning -> shortcuts -> real anchor -> '
                  'comparison -> pitfalls -> accessibility -> here.',
                  style: TextStyle(color: slate300, fontSize: 13, height: 1.45),
                ),
                const SizedBox(height: 10),
                Text(
                  'Hand-authored for the d4rt visual demo corpus. No setState, '
                  'no async, no live MenuController instantiation; every '
                  'snapshot is a normal Flutter widget tree.',
                  style: TextStyle(color: slate400, fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // RETURN - assemble everything inside a MaterialApp.
  // ===========================================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Menu family deep demo',
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: amber500,
      scaffoldBackgroundColor: slate100,
    ),
    home: Scaffold(
      backgroundColor: slate100,
      appBar: AppBar(
        backgroundColor: slate900,
        foregroundColor: Colors.white,
        title: Row(
          children: <Widget>[
            Icon(Icons.restaurant_menu, color: amber400, size: 20),
            const SizedBox(width: 10),
            const Text('Menu family - hand-authored visual deep demo'),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: sections,
          ),
        ),
      ),
    ),
  );
}

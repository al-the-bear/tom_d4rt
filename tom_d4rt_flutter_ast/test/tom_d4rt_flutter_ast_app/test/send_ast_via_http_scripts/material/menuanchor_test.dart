// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
//                  M E N U   A N C H O R   D E E P   D E M O
// =============================================================================
//
//   Title:    "Aubergine Velvet" — A MenuAnchor field guide
//   Target:   package:flutter/material.dart  ::  MenuAnchor
//   Audience: D4rt analyzer-free interpreter (snapshot rendering)
//
// -----------------------------------------------------------------------------
//
//   This file is a hand-written, instruction-rich Flutter demo script that
//   exercises the Material 3 [MenuAnchor] widget and its closest
//   collaborators: [MenuItemButton], [SubmenuButton], [MenuController], and
//   [MenuStyle]. The goal is NOT to ship a runnable app: the goal is to
//   construct a richly annotated snapshot tree that documents every facet of
//   the widget through code, prose, palette swatches, callouts, and recipes.
//
//   The interpreter target ("d4rt") is a sandboxed Dart interpreter that
//   walks an AST and constructs a widget tree on demand. It does not run a
//   full Flutter pipeline. As such, this script obeys a strict set of rules:
//
//     * The entry point [build] is invoked once. It must return a snapshot.
//     * No StatefulWidget / setState. No animations. No timers.
//     * MenuController instances may be constructed but never .open()'d.
//     * Every MenuAnchor must render its closed `child` so the layout shows.
//     * No `for-in` over BridgedInstance values. No `.value` reads on Tweens.
//     * Use `.withValues(alpha: ...)` instead of deprecated `.withOpacity`.
//
//   The demo is organised as twelve thematic sections rendered top to bottom
//   inside a SingleChildScrollView so the reader can scrub the entire
//   "magazine" in one pass:
//
//       01  Title banner & full palette swatches
//       02  Prose anatomy of MenuAnchor responsibilities
//       03  Property anatomy panel — colour-coded knobs
//       04  Static MenuAnchor gallery (six closed anchors)
//       05  Style matrix — four cards mixing MenuStyle properties
//       06  SubmenuButton showcase — nested cascading menus
//       07  Alignment offset diagram
//       08  Open/close lifecycle prose & no-op callbacks
//       09  DO / AVOID callouts — six rules
//       10  Code-snippet recipes — five variations
//       11  Glossary — twelve+ terms
//       12  Recap footer
//
//   The palette is the "Aubergine Velvet" theme — a warm, dusky purple-to-
//   plum gradient with copper accents and parchment surfaces. Ten colours
//   carry the visual language; an extra six "deep tints" extend the matrix.
//
//   Maintenance notes:
//
//     * Every section is a private builder function returning a Widget.
//     * Every builder returns a Card-wrapped subtree so the magazine layout
//       remains uniform regardless of section content.
//     * Print statements act as a narrative track; 5-15 lines, scattered.
//     * No `.open()`, `.close()`, `.isOpen` reads on MenuController.
//
// =============================================================================

import 'package:flutter/material.dart';

// =============================================================================
//                          P A L E T T E   C O N S T A N T S
// =============================================================================
//
// The "Aubergine Velvet" palette. Ten primary colours plus six deep tints
// give the file a stable visual language. Every section uses these exact
// constants so the swatches in section 01 remain authoritative.

const Color kAubergineDeep = Color(0xFF2A0E2E); // 01 base background, near-black plum
const Color kAubergineCore = Color(0xFF4B1D52); // 02 mid plum, primary fill
const Color kAubergineLift = Color(0xFF6E2D78); // 03 lifted plum, hover state
const Color kAubergineGlow = Color(0xFF9A4FA6); // 04 lavender glow, accent
const Color kAuberginePale = Color(0xFFD7B7DD); // 05 pale rose-plum
const Color kVelvetSurface = Color(0xFFF6ECEF); // 06 parchment surface
const Color kCopperEmber = Color(0xFFB46A3C); // 07 copper accent, warm trim
const Color kCopperSpark = Color(0xFFE89A55); // 08 spark accent
const Color kInkOnVelvet = Color(0xFF1B0A1E); // 09 primary text on light
const Color kInkOnPlum = Color(0xFFFBF3F6); // 10 primary text on dark

// Six extended deep tints — these carry secondary roles (dividers, callouts,
// AVOID stripes, DO chips, table rows, code-block backgrounds).
const Color kDeepMulberry = Color(0xFF3E0F44);
const Color kDeepWine = Color(0xFF5B1734);
const Color kDeepFog = Color(0xFFAE8DB6);
const Color kDeepMoss = Color(0xFF4D6A4F);
const Color kDeepCandle = Color(0xFFE6C56F);
const Color kDeepDanger = Color(0xFF8B2530);

// =============================================================================
//                                B U I L D
// =============================================================================

dynamic build(BuildContext context) {
  print('[MenuAnchor demo] build() entered — Aubergine Velvet edition');
  print('[MenuAnchor demo] palette locked: 10 primaries + 6 deep tints');
  print('[MenuAnchor demo] composing sections 01..12');

  // -----------------------------------------------------------------
  // Construct controllers up front. Per the interpreter rules, we
  // construct but DO NOT open them; they exist only to demonstrate
  // `controller:` wiring on MenuAnchor.
  // -----------------------------------------------------------------
  final MenuController controllerAlpha = MenuController();
  final MenuController controllerBravo = MenuController();
  final MenuController controllerCharlie = MenuController();
  print('[MenuAnchor demo] three MenuController instances constructed');

  final List<Widget> sections = <Widget>[
    _buildSection01TitleBanner(),
    _buildSection02ProseAnatomy(),
    _buildSection03PropertyPanel(),
    _buildSection04StaticGallery(controllerAlpha, controllerBravo, controllerCharlie),
    _buildSection05StyleMatrix(),
    _buildSection06SubmenuShowcase(),
    _buildSection07AlignmentDiagram(),
    _buildSection08LifecycleProse(),
    _buildSection09DoAvoidCallouts(),
    _buildSection10RecipeCards(),
    _buildSection11Glossary(),
    _buildSection12RecapFooter(),
  ];

  print('[MenuAnchor demo] ${sections.length} sections assembled');
  print('[MenuAnchor demo] returning Scaffold with SingleChildScrollView');

  return Scaffold(
    backgroundColor: kVelvetSurface,
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: sections,
      ),
    ),
  );
}

// =============================================================================
//                  S E C T I O N   0 1   :   T I T L E   B A N N E R
// =============================================================================
//
// A strong title banner with the demo title, subtitle, and a row of ten
// palette swatches. This anchors the magazine and tells the reader they
// are reading something that takes its colour story seriously.

Widget _buildSection01TitleBanner() {
  print('[01] title banner with palette swatches');

  final List<_Swatch> primaries = <_Swatch>[
    _Swatch('AubergineDeep', kAubergineDeep, '0xFF2A0E2E'),
    _Swatch('AubergineCore', kAubergineCore, '0xFF4B1D52'),
    _Swatch('AubergineLift', kAubergineLift, '0xFF6E2D78'),
    _Swatch('AubergineGlow', kAubergineGlow, '0xFF9A4FA6'),
    _Swatch('AuberginePale', kAuberginePale, '0xFFD7B7DD'),
    _Swatch('VelvetSurface', kVelvetSurface, '0xFFF6ECEF'),
    _Swatch('CopperEmber', kCopperEmber, '0xFFB46A3C'),
    _Swatch('CopperSpark', kCopperSpark, '0xFFE89A55'),
    _Swatch('InkOnVelvet', kInkOnVelvet, '0xFF1B0A1E'),
    _Swatch('InkOnPlum', kInkOnPlum, '0xFFFBF3F6'),
  ];

  final List<_Swatch> deeps = <_Swatch>[
    _Swatch('DeepMulberry', kDeepMulberry, '0xFF3E0F44'),
    _Swatch('DeepWine', kDeepWine, '0xFF5B1734'),
    _Swatch('DeepFog', kDeepFog, '0xFFAE8DB6'),
    _Swatch('DeepMoss', kDeepMoss, '0xFF4D6A4F'),
    _Swatch('DeepCandle', kDeepCandle, '0xFFE6C56F'),
    _Swatch('DeepDanger', kDeepDanger, '0xFF8B2530'),
  ];

  return _sectionCard(
    accent: kAubergineDeep,
    title: '01  TITLE BANNER',
    child: Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[kAubergineDeep, kAubergineCore, kAubergineLift],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kAubergineDeep.withValues(alpha: 0.4),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'AUBERGINE VELVET',
            style: TextStyle(
              fontSize: 14,
              letterSpacing: 6.0,
              fontWeight: FontWeight.w600,
              color: kCopperSpark,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'A MenuAnchor field guide',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: kInkOnPlum,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Material 3 cascading menus, anatomy first.',
            style: TextStyle(
              fontSize: 15,
              fontStyle: FontStyle.italic,
              color: kAuberginePale.withValues(alpha: 0.95),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            height: 1,
            color: kInkOnPlum.withValues(alpha: 0.18),
          ),
          const SizedBox(height: 20),
          const Text(
            'PRIMARY PALETTE',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 3.0,
              fontWeight: FontWeight.w700,
              color: kAuberginePale,
            ),
          ),
          const SizedBox(height: 10),
          _buildSwatchRow(primaries),
          const SizedBox(height: 18),
          const Text(
            'EXTENDED DEEP TINTS',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 3.0,
              fontWeight: FontWeight.w700,
              color: kAuberginePale,
            ),
          ),
          const SizedBox(height: 10),
          _buildSwatchRow(deeps),
        ],
      ),
    ),
  );
}

Widget _buildSwatchRow(List<_Swatch> swatches) {
  final List<Widget> chips = <Widget>[];
  for (int i = 0; i < swatches.length; i++) {
    final _Swatch s = swatches[i];
    chips.add(_swatchChip(s));
    if (i < swatches.length - 1) {
      chips.add(const SizedBox(width: 10));
    }
  }
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(children: chips),
  );
}

Widget _swatchChip(_Swatch s) {
  return Container(
    width: 116,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kInkOnPlum.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: kInkOnPlum.withValues(alpha: 0.18)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 36,
          decoration: BoxDecoration(
            color: s.color,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: kInkOnPlum.withValues(alpha: 0.25)),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          s.name,
          style: const TextStyle(
            fontSize: 11,
            color: kInkOnPlum,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          s.hex,
          style: TextStyle(
            fontSize: 9,
            color: kInkOnPlum.withValues(alpha: 0.75),
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

class _Swatch {
  const _Swatch(this.name, this.color, this.hex);
  final String name;
  final Color color;
  final String hex;
}

// =============================================================================
//                S E C T I O N   0 2   :   P R O S E   A N A T O M Y
// =============================================================================
//
// MenuAnchor is, fundamentally, an anchoring widget. It does not render the
// menu content itself in the layout flow — it dispatches that content into
// the OverlayEntry tree at runtime. This section explains the responsibility
// split in plain prose so the reader has a mental model before any code.

Widget _buildSection02ProseAnatomy() {
  print('[02] prose anatomy of MenuAnchor responsibilities');

  return _sectionCard(
    accent: kAubergineCore,
    title: '02  PROSE ANATOMY',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _proseHeader('What MenuAnchor is responsible for'),
        const SizedBox(height: 8),
        _proseParagraph(
          'A MenuAnchor is a layout-level object that owns three things at '
          'once: (1) an anchor target — usually the child widget that the '
          'user interacts with to summon the menu; (2) a controller — an '
          'instance of MenuController that lets ancestor widgets imperatively '
          'open or close the cascading menu; and (3) the list of menuChildren '
          'that will be rendered inside the overlay layer when the menu is '
          'open.',
        ),
        const SizedBox(height: 14),
        _proseHeader('Where the menu actually lives'),
        const SizedBox(height: 8),
        _proseParagraph(
          'Crucially, the menuChildren are NOT in the same render tree as the '
          'anchor. They are inserted into an Overlay (root or descendant, '
          'controlled by useRootOverlay). This means the menu can paint over '
          'other widgets, escape clipping by parents, and survive scroll '
          'positions of the anchor\'s ancestors. The trade-off is that '
          'menuChildren do not contribute to the layout of the anchor.',
        ),
        const SizedBox(height: 14),
        _proseHeader('When to choose MenuAnchor over PopupMenuButton'),
        const SizedBox(height: 8),
        _proseParagraph(
          'PopupMenuButton is the older Material 2 abstraction. It bundles '
          'the trigger button, the menu, and the items into one widget. '
          'MenuAnchor is the Material 3 abstraction and intentionally splits '
          'these concerns. Reach for MenuAnchor when you need: nested '
          'submenus (SubmenuButton); custom triggers (any child + builder); '
          'persistent controller access from outside (toolbar shortcuts); '
          'or fine-grained MenuStyle control. Use PopupMenuButton when the '
          'flat dropdown is enough and you do not need cascading.',
        ),
        const SizedBox(height: 14),
        _proseHeader('Root overlay vs descendant overlay'),
        const SizedBox(height: 8),
        _proseParagraph(
          'The useRootOverlay flag determines which overlay receives the '
          'menu entries. The root overlay is the application-level overlay; '
          'menus rendered there can paint above modal route transitions and '
          'are not constrained by intermediate Navigators. A descendant '
          'overlay (the default in many cases) keeps the menu inside the '
          'nearest Overlay ancestor — useful when a sub-Navigator should '
          'own its own menus, or when the menu must clip with a panel.',
        ),
      ],
    ),
  );
}

// =============================================================================
//             S E C T I O N   0 3   :   P R O P E R T Y   P A N E L
// =============================================================================
//
// A colour-coded property anatomy panel. Nine MenuAnchor properties are
// shown as labelled rows with a swatch indicating their "knob colour" and
// a short description. This is the cheat-sheet that complements section 02.

Widget _buildSection03PropertyPanel() {
  print('[03] property panel: 9+ MenuAnchor knobs');

  final List<_PropertyRow> rows = <_PropertyRow>[
    _PropertyRow(
      name: 'controller',
      type: 'MenuController?',
      swatch: kAubergineCore,
      description:
          'Imperative handle. Construct one if you need to open/close the '
          'menu from outside the anchor (e.g. a keyboard shortcut handler). '
          'In this snapshot demo we construct controllers but never call '
          '.open() — the interpreter does not run an event loop.',
    ),
    _PropertyRow(
      name: 'childFocusNode',
      type: 'FocusNode?',
      swatch: kAubergineLift,
      description:
          'Focus node for the anchor child. Lets the menu return focus to '
          'the trigger after dismissal so keyboard users do not lose their '
          'place in the focus traversal order.',
    ),
    _PropertyRow(
      name: 'style',
      type: 'MenuStyle?',
      swatch: kAubergineGlow,
      description:
          'A MaterialStateProperty bag. Controls backgroundColor, elevation, '
          'shape, padding, and minimum size of the menu surface itself — not '
          'the menuChildren.',
    ),
    _PropertyRow(
      name: 'alignmentOffset',
      type: 'Offset',
      swatch: kCopperEmber,
      description:
          'Pixel offset applied AFTER the menu is positioned relative to '
          'the anchor. Defaults to Offset.zero. Tiny vertical shifts (e.g. '
          'Offset(0, 8)) are commonly used to add breathing room.',
    ),
    _PropertyRow(
      name: 'clipBehavior',
      type: 'Clip',
      swatch: kCopperSpark,
      description:
          'How the menu surface clips its painted content. Clip.hardEdge is '
          'cheap; Clip.antiAlias is smoother on rounded corners.',
    ),
    _PropertyRow(
      name: 'consumeOutsideTap',
      type: 'bool',
      swatch: kDeepMulberry,
      description:
          'When true, taps that dismiss the menu are absorbed and do not '
          'reach widgets behind it. Useful when accidental taps on a list '
          'underneath would do something destructive.',
    ),
    _PropertyRow(
      name: 'onOpen',
      type: 'VoidCallback?',
      swatch: kDeepMoss,
      description:
          'Fires when the menu transitions from closed to open. Good place '
          'to log analytics or pre-warm a data fetch.',
    ),
    _PropertyRow(
      name: 'onClose',
      type: 'VoidCallback?',
      swatch: kDeepWine,
      description:
          'Fires on the closing transition. Common uses: revert a hover '
          'highlight, persist a selection, or commit a draft.',
    ),
    _PropertyRow(
      name: 'crossAxisUnconstrained',
      type: 'bool',
      swatch: kDeepFog,
      description:
          'When true, the menu may overflow the cross axis of the parent. '
          'Defaults to true; flip to false to force the menu inside the '
          'anchor\'s box.',
    ),
    _PropertyRow(
      name: 'useRootOverlay',
      type: 'bool',
      swatch: kDeepCandle,
      description:
          'Routes the menu entries to the root overlay so they paint above '
          'sub-Navigators and intermediate Overlays.',
    ),
    _PropertyRow(
      name: 'menuChildren',
      type: 'List<Widget>',
      swatch: kAuberginePale,
      description:
          'Required. The cascading list. Typically a mix of MenuItemButton '
          'and SubmenuButton. May include arbitrary widgets, but the '
          'cascading focus model assumes button-like items.',
    ),
    _PropertyRow(
      name: 'child / builder',
      type: 'Widget? / MenuAnchorChildBuilder?',
      swatch: kCopperEmber,
      description:
          'The anchor itself. Provide one or the other. Builder is preferred '
          'when the trigger needs to know about the controller (e.g. to '
          'display an "open" indicator).',
    ),
  ];

  return _sectionCard(
    accent: kAubergineLift,
    title: '03  PROPERTY ANATOMY',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows.map(_propertyRowTile).toList(),
    ),
  );
}

class _PropertyRow {
  const _PropertyRow({
    required this.name,
    required this.type,
    required this.swatch,
    required this.description,
  });
  final String name;
  final String type;
  final Color swatch;
  final String description;
}

Widget _propertyRowTile(_PropertyRow r) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: kVelvetSurface,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: kAuberginePale.withValues(alpha: 0.6)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 14,
          height: 14,
          margin: const EdgeInsets.only(top: 4, right: 12),
          decoration: BoxDecoration(
            color: r.swatch,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: kInkOnVelvet.withValues(alpha: 0.25)),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    r.name,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: kInkOnVelvet,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: kAubergineCore.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      r.type,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: kAubergineCore,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                r.description,
                style: const TextStyle(
                  fontSize: 12.5,
                  color: kInkOnVelvet,
                  height: 1.4,
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
//          S E C T I O N   0 4   :   S T A T I C   M E N U   G A L L E R Y
// =============================================================================
//
// Six MenuAnchor instances, each with a different menuChildren composition,
// rendered in their CLOSED state. We never call controller.open(); we just
// place the anchors so their `child` widgets are visible. This proves the
// anchor's layout footprint is the child's footprint.

Widget _buildSection04StaticGallery(
  MenuController a,
  MenuController b,
  MenuController c,
) {
  print('[04] static MenuAnchor gallery — six anchors, all closed');

  final Widget anchor1 = MenuAnchor(
    controller: a,
    menuChildren: <Widget>[
      MenuItemButton(onPressed: () {}, child: const Text('New file')),
      MenuItemButton(onPressed: () {}, child: const Text('Open file')),
      MenuItemButton(onPressed: () {}, child: const Text('Save')),
    ],
    child: _galleryTrigger(label: 'File', icon: Icons.insert_drive_file),
  );

  final Widget anchor2 = MenuAnchor(
    controller: b,
    menuChildren: <Widget>[
      MenuItemButton(
        onPressed: () {},
        leadingIcon: const Icon(Icons.content_cut),
        child: const Text('Cut'),
      ),
      MenuItemButton(
        onPressed: () {},
        leadingIcon: const Icon(Icons.content_copy),
        child: const Text('Copy'),
      ),
      MenuItemButton(
        onPressed: () {},
        leadingIcon: const Icon(Icons.content_paste),
        child: const Text('Paste'),
      ),
      const Divider(height: 1),
      MenuItemButton(
        onPressed: () {},
        leadingIcon: const Icon(Icons.select_all),
        child: const Text('Select all'),
      ),
    ],
    child: _galleryTrigger(label: 'Edit', icon: Icons.edit),
  );

  final Widget anchor3 = MenuAnchor(
    controller: c,
    menuChildren: <Widget>[
      MenuItemButton(onPressed: () {}, child: const Text('Zoom in')),
      MenuItemButton(onPressed: () {}, child: const Text('Zoom out')),
      MenuItemButton(onPressed: () {}, child: const Text('Reset zoom')),
      MenuItemButton(onPressed: null, child: const Text('Fit page')),
    ],
    child: _galleryTrigger(label: 'View', icon: Icons.visibility),
  );

  final Widget anchor4 = MenuAnchor(
    menuChildren: <Widget>[
      MenuItemButton(
        onPressed: () {},
        leadingIcon: const Icon(Icons.share),
        child: const Text('Share link'),
      ),
      MenuItemButton(
        onPressed: () {},
        leadingIcon: const Icon(Icons.print),
        child: const Text('Print'),
      ),
      MenuItemButton(
        onPressed: () {},
        leadingIcon: const Icon(Icons.archive),
        child: const Text('Archive'),
      ),
    ],
    child: _galleryTrigger(label: 'Share', icon: Icons.share),
  );

  final Widget anchor5 = MenuAnchor(
    menuChildren: <Widget>[
      MenuItemButton(onPressed: () {}, child: const Text('Refresh')),
      MenuItemButton(onPressed: () {}, child: const Text('Sort by name')),
      MenuItemButton(onPressed: () {}, child: const Text('Sort by date')),
      MenuItemButton(onPressed: () {}, child: const Text('Sort by size')),
      MenuItemButton(onPressed: null, child: const Text('Group by tag')),
    ],
    child: _galleryTrigger(label: 'Sort', icon: Icons.sort),
  );

  final Widget anchor6 = MenuAnchor(
    menuChildren: <Widget>[
      MenuItemButton(
        onPressed: () {},
        leadingIcon: const Icon(Icons.help_outline),
        child: const Text('Documentation'),
      ),
      MenuItemButton(
        onPressed: () {},
        leadingIcon: const Icon(Icons.bug_report),
        child: const Text('Report bug'),
      ),
      MenuItemButton(
        onPressed: () {},
        leadingIcon: const Icon(Icons.info_outline),
        child: const Text('About'),
      ),
    ],
    child: _galleryTrigger(label: 'Help', icon: Icons.help),
  );

  return _sectionCard(
    accent: kAubergineGlow,
    title: '04  STATIC MENU ANCHOR GALLERY',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _proseParagraph(
          'Six anchors, six menu compositions. Each is rendered closed so '
          'its child (the trigger) defines the layout footprint. Hover and '
          'tap behaviour are handled by the framework when the app actually '
          'runs; the snapshot here documents the structural contract.',
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: <Widget>[anchor1, anchor2, anchor3, anchor4, anchor5, anchor6],
        ),
      ],
    ),
  );
}

Widget _galleryTrigger({required String label, required IconData icon}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: kAubergineCore,
      borderRadius: BorderRadius.circular(10),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kAubergineDeep.withValues(alpha: 0.35),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, color: kCopperSpark, size: 18),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: kInkOnPlum,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 6),
        const Icon(Icons.arrow_drop_down, color: kAuberginePale, size: 20),
      ],
    ),
  );
}

// =============================================================================
//                S E C T I O N   0 5   :   S T Y L E   M A T R I X
// =============================================================================
//
// Four cards, each with a MenuAnchor that uses a different MenuStyle. The
// MenuStyle wraps WidgetStateProperty bags. Here we use static colour
// resolvers (WidgetStatePropertyAll) for clarity — no state transitions
// because the snapshot does not animate.

Widget _buildSection05StyleMatrix() {
  print('[05] style matrix — four MenuStyle variations');

  final MenuStyle styleA = MenuStyle(
    backgroundColor: const WidgetStatePropertyAll<Color>(kAubergineCore),
    elevation: const WidgetStatePropertyAll<double>(8.0),
    padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
      EdgeInsets.symmetric(vertical: 6),
    ),
    shape: WidgetStatePropertyAll<OutlinedBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  final MenuStyle styleB = MenuStyle(
    backgroundColor: const WidgetStatePropertyAll<Color>(kVelvetSurface),
    elevation: const WidgetStatePropertyAll<double>(2.0),
    padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
      EdgeInsets.symmetric(vertical: 12, horizontal: 4),
    ),
    shape: WidgetStatePropertyAll<OutlinedBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );

  final MenuStyle styleC = MenuStyle(
    backgroundColor: const WidgetStatePropertyAll<Color>(kDeepMulberry),
    elevation: const WidgetStatePropertyAll<double>(16.0),
    alignment: Alignment.bottomLeft,
    padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
      EdgeInsets.zero,
    ),
  );

  final MenuStyle styleD = MenuStyle(
    backgroundColor: const WidgetStatePropertyAll<Color>(kCopperEmber),
    elevation: const WidgetStatePropertyAll<double>(0.0),
    padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
      EdgeInsets.all(8),
    ),
    shape: WidgetStatePropertyAll<OutlinedBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
    ),
  );

  Widget styleCard(String title, String prose, MenuStyle style, Color tint) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kVelvetSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tint.withValues(alpha: 0.6), width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: tint,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  color: kInkOnVelvet,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            prose,
            style: const TextStyle(fontSize: 12, height: 1.4, color: kInkOnVelvet),
          ),
          const SizedBox(height: 12),
          MenuAnchor(
            style: style,
            menuChildren: <Widget>[
              MenuItemButton(onPressed: () {}, child: const Text('Alpha')),
              MenuItemButton(onPressed: () {}, child: const Text('Bravo')),
              MenuItemButton(onPressed: () {}, child: const Text('Charlie')),
            ],
            child: _galleryTrigger(label: 'Trigger', icon: Icons.tune),
          ),
        ],
      ),
    );
  }

  return _sectionCard(
    accent: kCopperEmber,
    title: '05  STYLE MATRIX',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _proseParagraph(
          'Four MenuStyle bundles — each demonstrates a different posture: '
          'A is the dense, plum-on-plum dropdown; B is the airy parchment '
          'card; C is the deep mulberry edge-aligned overlay; D is a flat '
          'copper banner with no elevation.',
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: <Widget>[
            styleCard(
              'Style A — Dense plum',
              'Compact vertical padding, modest elevation, plum surface, '
              'standard rounded corners.',
              styleA,
              kAubergineCore,
            ),
            styleCard(
              'Style B — Parchment card',
              'Velvet surface, generous padding, very rounded corners, '
              'low elevation. Reads like a small panel.',
              styleB,
              kVelvetSurface,
            ),
            styleCard(
              'Style C — Edge-aligned',
              'Mulberry surface, high elevation, alignment shifted to '
              'bottom-left of the anchor. Zero internal padding.',
              styleC,
              kDeepMulberry,
            ),
            styleCard(
              'Style D — Flat copper',
              'Copper surface, zero elevation, near-square corners. '
              'Industrial look for power-user toolbars.',
              styleD,
              kCopperEmber,
            ),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
//          S E C T I O N   0 6   :   S U B M E N U   S H O W C A S E
// =============================================================================
//
// SubmenuButton lives inside menuChildren and itself has menuChildren. The
// anchor renders the parent menu; the SubmenuButton renders an additional
// cascading panel when hovered or activated. Two-level nesting is shown
// explicitly so the reader sees the recursive structure.

Widget _buildSection06SubmenuShowcase() {
  print('[06] SubmenuButton showcase — nested cascade');

  final Widget submenuExport = SubmenuButton(
    leadingIcon: const Icon(Icons.upload),
    menuChildren: <Widget>[
      MenuItemButton(onPressed: () {}, child: const Text('Export as PDF')),
      MenuItemButton(onPressed: () {}, child: const Text('Export as PNG')),
      MenuItemButton(onPressed: () {}, child: const Text('Export as SVG')),
      const Divider(height: 1),
      MenuItemButton(onPressed: () {}, child: const Text('Export as ZIP archive')),
    ],
    child: const Text('Export'),
  );

  final Widget submenuTheme = SubmenuButton(
    leadingIcon: const Icon(Icons.color_lens),
    menuChildren: <Widget>[
      MenuItemButton(onPressed: () {}, child: const Text('Aubergine Velvet')),
      MenuItemButton(onPressed: () {}, child: const Text('Solar Lime')),
      MenuItemButton(onPressed: () {}, child: const Text('Glacier')),
      MenuItemButton(onPressed: () {}, child: const Text('Carbon Mono')),
    ],
    child: const Text('Theme'),
  );

  final Widget submenuPrefs = SubmenuButton(
    leadingIcon: const Icon(Icons.settings),
    menuChildren: <Widget>[
      submenuTheme,
      SubmenuButton(
        leadingIcon: const Icon(Icons.language),
        menuChildren: <Widget>[
          MenuItemButton(onPressed: () {}, child: const Text('English')),
          MenuItemButton(onPressed: () {}, child: const Text('Deutsch')),
          MenuItemButton(onPressed: () {}, child: const Text('Français')),
          MenuItemButton(onPressed: () {}, child: const Text('日本語')),
        ],
        child: const Text('Language'),
      ),
      MenuItemButton(onPressed: () {}, child: const Text('Reset to defaults')),
    ],
    child: const Text('Preferences'),
  );

  final Widget topLevelAnchor = MenuAnchor(
    menuChildren: <Widget>[
      MenuItemButton(
        onPressed: () {},
        leadingIcon: const Icon(Icons.add),
        child: const Text('New document'),
      ),
      submenuExport,
      submenuPrefs,
      const Divider(height: 1),
      MenuItemButton(
        onPressed: () {},
        leadingIcon: const Icon(Icons.logout),
        child: const Text('Sign out'),
      ),
    ],
    child: _galleryTrigger(label: 'Workspace', icon: Icons.workspaces),
  );

  return _sectionCard(
    accent: kAubergineGlow,
    title: '06  SUBMENU SHOWCASE',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _proseParagraph(
          'A two-level cascade. The top MenuAnchor hosts plain MenuItemButtons '
          'plus two SubmenuButton entries. The "Preferences" submenu in turn '
          'contains another SubmenuButton ("Language") — three levels deep. '
          'In the live app, hovering a SubmenuButton expands its panel to '
          'the side; in this snapshot we only render the trigger.',
        ),
        const SizedBox(height: 16),
        topLevelAnchor,
        const SizedBox(height: 18),
        _proseHeader('Tree shape'),
        const SizedBox(height: 6),
        _treeLine('Workspace ▾'),
        _treeLine('  • New document'),
        _treeLine('  ▸ Export ▾'),
        _treeLine('      • Export as PDF'),
        _treeLine('      • Export as PNG'),
        _treeLine('      • Export as SVG'),
        _treeLine('      • Export as ZIP archive'),
        _treeLine('  ▸ Preferences ▾'),
        _treeLine('      ▸ Theme ▾'),
        _treeLine('          • Aubergine Velvet'),
        _treeLine('          • Solar Lime'),
        _treeLine('          • Glacier'),
        _treeLine('          • Carbon Mono'),
        _treeLine('      ▸ Language ▾'),
        _treeLine('          • English'),
        _treeLine('          • Deutsch'),
        _treeLine('          • Français'),
        _treeLine('          • 日本語'),
        _treeLine('      • Reset to defaults'),
        _treeLine('  • Sign out'),
      ],
    ),
  );
}

Widget _treeLine(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1),
    child: Text(
      text,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: kInkOnVelvet,
      ),
    ),
  );
}

// =============================================================================
//        S E C T I O N   0 7   :   A L I G N M E N T   O F F S E T   D I A G R A M
// =============================================================================
//
// alignmentOffset is one of the most commonly tweaked properties. This
// section visualises Offset.zero versus Offset(0, 8) versus Offset(12, 12)
// using a static diagram of stacked rectangles representing the anchor and
// the menu surface.

Widget _buildSection07AlignmentDiagram() {
  print('[07] alignment offset diagram');

  Widget diagram(String label, Offset offset, Color tint) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kVelvetSurface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tint.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: kInkOnVelvet,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Offset(${offset.dx.toStringAsFixed(0)}, ${offset.dy.toStringAsFixed(0)})',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: kAubergineCore,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 130,
            child: Stack(
              children: <Widget>[
                // Anchor box.
                Positioned(
                  left: 16,
                  top: 8,
                  child: Container(
                    width: 110,
                    height: 28,
                    decoration: BoxDecoration(
                      color: kAubergineCore,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'anchor',
                      style: TextStyle(
                        color: kInkOnPlum,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                // Menu surface, shifted by the offset.
                Positioned(
                  left: 16 + offset.dx,
                  top: 8 + 28 + offset.dy,
                  child: Container(
                    width: 130,
                    height: 70,
                    decoration: BoxDecoration(
                      color: tint,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: kAubergineDeep.withValues(alpha: 0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'menu surface',
                      style: TextStyle(
                        color: kInkOnPlum,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  return _sectionCard(
    accent: kCopperSpark,
    title: '07  ALIGNMENT OFFSET DIAGRAM',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _proseParagraph(
          'alignmentOffset is applied AFTER the menu has been positioned. '
          'A positive Y nudges the menu downward, away from the anchor, '
          'creating breathing room. A positive X nudges right.',
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: <Widget>[
            diagram('Zero offset', Offset.zero, kAubergineLift),
            diagram('Vertical breath', const Offset(0, 8), kAubergineGlow),
            diagram('Diagonal nudge', const Offset(12, 12), kCopperEmber),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
//             S E C T I O N   0 8   :   L I F E C Y C L E   P R O S E
// =============================================================================
//
// onOpen and onClose are the lifecycle callbacks. We attach no-op
// callbacks that print, demonstrating the wiring. We do not actually
// trigger the menu; the snapshot only documents the contract.

Widget _buildSection08LifecycleProse() {
  print('[08] open/close lifecycle prose');

  final Widget lifecycleAnchor = MenuAnchor(
    onOpen: () {
      // No-op for the snapshot; in a live app this would log analytics.
      print('[lifecycle] onOpen fired');
    },
    onClose: () {
      print('[lifecycle] onClose fired');
    },
    consumeOutsideTap: true,
    menuChildren: <Widget>[
      MenuItemButton(onPressed: () {}, child: const Text('Run task')),
      MenuItemButton(onPressed: () {}, child: const Text('Pause task')),
      MenuItemButton(onPressed: () {}, child: const Text('Cancel task')),
    ],
    child: _galleryTrigger(label: 'Tasks', icon: Icons.play_circle),
  );

  return _sectionCard(
    accent: kDeepMoss,
    title: '08  OPEN / CLOSE LIFECYCLE',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _proseHeader('When the menu opens'),
        const SizedBox(height: 6),
        _proseParagraph(
          'onOpen fires once when the controller transitions from "closed" '
          'to "open". Common uses: pre-fetch a thumbnail list; emit an '
          'analytics ping; update a "menu-open" indicator badge on the '
          'trigger; mark a guided tour step as complete.',
        ),
        const SizedBox(height: 12),
        _proseHeader('When the menu closes'),
        const SizedBox(height: 6),
        _proseParagraph(
          'onClose fires whether the menu was dismissed by a selection, '
          'an outside tap, the Escape key, or programmatic close(). It is '
          'the right place to commit a draft selection, dismiss a hover '
          'preview, or restore focus to the originating widget.',
        ),
        const SizedBox(height: 12),
        _proseHeader('consumeOutsideTap interplay'),
        const SizedBox(height: 6),
        _proseParagraph(
          'When consumeOutsideTap is true, the dismissing tap is absorbed '
          'and never reaches the underlying widget. Use this when the '
          'click-target underneath is destructive (delete row, navigate '
          'away). Otherwise leave it false so users can dismiss-and-act in '
          'a single click.',
        ),
        const SizedBox(height: 16),
        Row(
          children: <Widget>[
            lifecycleAnchor,
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                '↑ This anchor wires onOpen and onClose to print() callbacks. '
                'The interpreter does not actually open the menu, but the '
                'callbacks are constructed and attached.',
                style: TextStyle(fontSize: 12, color: kInkOnVelvet),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
//             S E C T I O N   0 9   :   D O   /   A V O I D   C A L L O U T S
// =============================================================================

Widget _buildSection09DoAvoidCallouts() {
  print('[09] DO / AVOID callouts');

  final List<_Callout> callouts = <_Callout>[
    _Callout(
      kind: _CalloutKind.doIt,
      title: 'DO provide menuChildren',
      body:
          'menuChildren is required. An empty list is technically valid but '
          'renders an empty surface; almost always a bug. Always populate.',
    ),
    _Callout(
      kind: _CalloutKind.avoid,
      title: 'AVOID null builder AND null child',
      body:
          'You must provide either child or builder. Passing null for both '
          'gives the anchor nothing to render in-flow; the menu will have '
          'no anchor target.',
    ),
    _Callout(
      kind: _CalloutKind.doIt,
      title: 'DO reuse a MenuController for shortcuts',
      body:
          'If a keyboard shortcut should open the menu, hold a MenuController '
          'in your State and call .open() from the shortcut\'s intent. The '
          'controller bridges the gap between the trigger and the rest of '
          'your widget tree.',
    ),
    _Callout(
      kind: _CalloutKind.avoid,
      title: 'AVOID nesting MenuAnchor inside MenuAnchor',
      body:
          'A nested cascade is what SubmenuButton is for. MenuAnchor inside '
          'MenuAnchor produces two independent overlays and breaks the '
          'cascading focus model.',
    ),
    _Callout(
      kind: _CalloutKind.doIt,
      title: 'DO use SubmenuButton for hierarchies',
      body:
          'SubmenuButton sits inside menuChildren and exposes its own '
          'menuChildren. It participates correctly in keyboard navigation '
          '(Right opens, Left closes) and dismiss propagation.',
    ),
    _Callout(
      kind: _CalloutKind.avoid,
      title: 'AVOID heavy work in onOpen',
      body:
          'onOpen runs synchronously on the open transition. Kicking off '
          'a heavy build there creates a visible jank. Prefer to pre-warm '
          'data on hover or schedule the work in a microtask.',
    ),
    _Callout(
      kind: _CalloutKind.doIt,
      title: 'DO supply a childFocusNode',
      body:
          'When the trigger should regain focus after dismissal, pass the '
          'trigger\'s FocusNode as childFocusNode. The framework handles '
          'restoration automatically.',
    ),
    _Callout(
      kind: _CalloutKind.avoid,
      title: 'AVOID stateful widgets in menuChildren',
      body:
          'Items inside menuChildren can be StatefulWidgets, but be aware '
          'that the overlay disposes them on close. State that must outlive '
          'the menu belongs in an ancestor.',
    ),
  ];

  return _sectionCard(
    accent: kDeepDanger,
    title: '09  DO / AVOID CALLOUTS',
    child: Column(
      children: callouts.map(_calloutTile).toList(),
    ),
  );
}

enum _CalloutKind { doIt, avoid }

class _Callout {
  const _Callout({required this.kind, required this.title, required this.body});
  final _CalloutKind kind;
  final String title;
  final String body;
}

Widget _calloutTile(_Callout c) {
  final bool good = c.kind == _CalloutKind.doIt;
  final Color stripe = good ? kDeepMoss : kDeepDanger;
  final String tag = good ? 'DO' : 'AVOID';
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: kVelvetSurface,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: stripe.withValues(alpha: 0.5)),
    ),
    child: IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: 6,
            decoration: BoxDecoration(
              color: stripe,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: stripe,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            color: kInkOnPlum,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          c.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                            color: kInkOnVelvet,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    c.body,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: kInkOnVelvet,
                      height: 1.4,
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

// =============================================================================
//                S E C T I O N   1 0   :   R E C I P E   C A R D S
// =============================================================================
//
// Five canonical recipes shown as code-snippet cards. The strings are the
// recipe sources; the cards are styled like terminal output blocks.

Widget _buildSection10RecipeCards() {
  print('[10] code snippet recipes — five');

  const String recipeBasic = '''
// Recipe 1 — Basic MenuAnchor
MenuAnchor(
  menuChildren: <Widget>[
    MenuItemButton(
      onPressed: () => print('new'),
      child: const Text('New'),
    ),
    MenuItemButton(
      onPressed: () => print('open'),
      child: const Text('Open'),
    ),
  ],
  child: TextButton(
    onPressed: () {},
    child: const Text('File'),
  ),
);''';

  const String recipeController = '''
// Recipe 2 — With a MenuController
final MenuController controller = MenuController();

MenuAnchor(
  controller: controller,
  menuChildren: <Widget>[
    MenuItemButton(onPressed: () {}, child: const Text('Run')),
    MenuItemButton(onPressed: () {}, child: const Text('Stop')),
  ],
  child: IconButton(
    onPressed: () {
      // Imperative open from the trigger or an ancestor shortcut.
      controller.open();
    },
    icon: const Icon(Icons.menu),
  ),
);''';

  const String recipeSubmenu = '''
// Recipe 3 — Nested SubmenuButton
MenuAnchor(
  menuChildren: <Widget>[
    SubmenuButton(
      menuChildren: <Widget>[
        MenuItemButton(onPressed: () {}, child: const Text('PNG')),
        MenuItemButton(onPressed: () {}, child: const Text('SVG')),
      ],
      child: const Text('Export'),
    ),
    MenuItemButton(onPressed: () {}, child: const Text('Quit')),
  ],
  child: const Text('File'),
);''';

  const String recipeStyle = '''
// Recipe 4 — Custom MenuStyle
final MenuStyle plumStyle = MenuStyle(
  backgroundColor: const WidgetStatePropertyAll<Color>(Color(0xFF4B1D52)),
  elevation: const WidgetStatePropertyAll<double>(8.0),
  shape: WidgetStatePropertyAll<OutlinedBorder>(
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
);

MenuAnchor(
  style: plumStyle,
  menuChildren: <Widget>[
    MenuItemButton(onPressed: () {}, child: const Text('Item')),
  ],
  child: const Text('Trigger'),
);''';

  const String recipeBuilder = '''
// Recipe 5 — Custom builder
MenuAnchor(
  builder: (BuildContext ctx, MenuController c, Widget? _) {
    return TextButton.icon(
      onPressed: () {
        if (c.isOpen) {
          c.close();
        } else {
          c.open();
        }
      },
      icon: Icon(c.isOpen ? Icons.expand_less : Icons.expand_more),
      label: const Text('Actions'),
    );
  },
  menuChildren: <Widget>[
    MenuItemButton(onPressed: () {}, child: const Text('Refresh')),
    MenuItemButton(onPressed: () {}, child: const Text('Settings')),
  ],
);''';

  final List<_Recipe> recipes = <_Recipe>[
    _Recipe('Basic anchor', recipeBasic, kAubergineCore),
    _Recipe('With controller', recipeController, kAubergineLift),
    _Recipe('Submenu cascade', recipeSubmenu, kAubergineGlow),
    _Recipe('Custom MenuStyle', recipeStyle, kCopperEmber),
    _Recipe('Custom builder', recipeBuilder, kCopperSpark),
  ];

  return _sectionCard(
    accent: kAubergineCore,
    title: '10  RECIPE CARDS',
    child: Column(
      children: recipes.map(_recipeCard).toList(),
    ),
  );
}

class _Recipe {
  const _Recipe(this.title, this.code, this.tint);
  final String title;
  final String code;
  final Color tint;
}

Widget _recipeCard(_Recipe r) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      color: kAubergineDeep,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: r.tint, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: r.tint.withValues(alpha: 0.25),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(11),
              topRight: Radius.circular(11),
            ),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: r.tint,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                r.title,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  color: kInkOnPlum,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(14),
          child: Text(
            r.code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              height: 1.4,
              color: kInkOnPlum,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//                       S E C T I O N   1 1   :   G L O S S A R Y
// =============================================================================

Widget _buildSection11Glossary() {
  print('[11] glossary — fifteen terms');

  final List<_GlossEntry> entries = <_GlossEntry>[
    _GlossEntry('Anchor',
        'The widget that the menu is positioned relative to. In MenuAnchor, '
        'this is the child or the widget produced by builder.'),
    _GlossEntry('Cascading menu',
        'A menu in which a row can itself open another menu, recursively. '
        'Built with SubmenuButton inside menuChildren.'),
    _GlossEntry('Overlay',
        'A Stack-like layer that paints above the regular widget tree. The '
        'menu surface lives here, not in the anchor\'s subtree.'),
    _GlossEntry('Root overlay',
        'The application-level Overlay. Use useRootOverlay: true to escape '
        'intermediate Navigators.'),
    _GlossEntry('MenuController',
        'An imperative handle to a MenuAnchor. Exposes open(), close(), and '
        'isOpen for ancestor-driven control.'),
    _GlossEntry('MenuStyle',
        'A bag of WidgetStateProperty resolvers controlling background, '
        'elevation, padding, shape, and minimum size of the surface.'),
    _GlossEntry('MenuItemButton',
        'A leaf row in a menu. Has onPressed, leadingIcon, trailingIcon, '
        'shortcut, and child.'),
    _GlossEntry('SubmenuButton',
        'A non-leaf row that itself owns menuChildren and renders a child '
        'menu when activated.'),
    _GlossEntry('alignmentOffset',
        'A pixel offset applied to the menu position after default '
        'alignment. Common breath-room nudge: Offset(0, 8).'),
    _GlossEntry('consumeOutsideTap',
        'Whether the dismissing tap is absorbed instead of reaching the '
        'widget under the cursor.'),
    _GlossEntry('crossAxisUnconstrained',
        'Whether the menu can overflow the cross-axis of its parent\'s '
        'constraints.'),
    _GlossEntry('childFocusNode',
        'The FocusNode of the trigger widget; used so the framework can '
        'restore focus to the trigger after dismissal.'),
    _GlossEntry('Menu surface',
        'The visible panel that contains the menuChildren. Distinct from '
        'the anchor itself.'),
    _GlossEntry('PopupMenuButton',
        'The Material 2 alternative. Less flexible than MenuAnchor; bundles '
        'trigger and menu in a single widget.'),
    _GlossEntry('Cascade focus',
        'The keyboard-navigation model in which arrow keys move within a '
        'menu, Right opens a submenu, and Left closes it.'),
  ];

  return _sectionCard(
    accent: kDeepFog,
    title: '11  GLOSSARY',
    child: Column(
      children: entries.map(_glossTile).toList(),
    ),
  );
}

class _GlossEntry {
  const _GlossEntry(this.term, this.def);
  final String term;
  final String def;
}

Widget _glossTile(_GlossEntry e) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: kVelvetSurface,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: kDeepFog.withValues(alpha: 0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 150,
          child: Text(
            e.term,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 13,
              color: kAubergineCore,
            ),
          ),
        ),
        Expanded(
          child: Text(
            e.def,
            style: const TextStyle(
              fontSize: 12.5,
              color: kInkOnVelvet,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//                      S E C T I O N   1 2   :   R E C A P
// =============================================================================

Widget _buildSection12RecapFooter() {
  print('[12] recap footer');

  return _sectionCard(
    accent: kAubergineDeep,
    title: '12  RECAP',
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[kAubergineDeep, kAubergineCore],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'KEY TAKEAWAYS',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 3.0,
              fontWeight: FontWeight.w700,
              color: kCopperSpark,
            ),
          ),
          const SizedBox(height: 12),
          _recapBullet('MenuAnchor is the M3 cascading-menu primitive. Pair it with MenuItemButton and SubmenuButton.'),
          _recapBullet('menuChildren is required; the anchor needs either child or builder.'),
          _recapBullet('MenuController bridges the menu to ancestors for shortcuts and tests.'),
          _recapBullet('MenuStyle controls the surface, not the children.'),
          _recapBullet('alignmentOffset is the right knob for breathing room.'),
          _recapBullet('consumeOutsideTap protects destructive widgets behind the menu.'),
          _recapBullet('useRootOverlay routes the surface above sub-Navigators.'),
          _recapBullet('Use SubmenuButton — never nest MenuAnchor inside MenuAnchor.'),
          const SizedBox(height: 16),
          Container(
            height: 1,
            color: kAuberginePale.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 12),
          Text(
            'End of "Aubergine Velvet" — A MenuAnchor field guide.',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 12,
              color: kAuberginePale.withValues(alpha: 0.95),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _recapBullet(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(top: 6, right: 10),
          decoration: const BoxDecoration(
            color: kCopperSpark,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: kInkOnPlum,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//                          S H A R E D   H E L P E R S
// =============================================================================

Widget _sectionCard({
  required Color accent,
  required String title,
  required Widget child,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 22),
    decoration: BoxDecoration(
      color: kInkOnPlum,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: kAuberginePale.withValues(alpha: 0.5)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kAubergineDeep.withValues(alpha: 0.07),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: kCopperSpark,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: kInkOnPlum,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18),
          child: child,
        ),
      ],
    ),
  );
}

Widget _proseHeader(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: 14,
      color: kAubergineCore,
    ),
  );
}

Widget _proseParagraph(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 13.5,
      height: 1.5,
      color: kInkOnVelvet,
    ),
  );
}

// =============================================================================
//                                 E N D
// =============================================================================

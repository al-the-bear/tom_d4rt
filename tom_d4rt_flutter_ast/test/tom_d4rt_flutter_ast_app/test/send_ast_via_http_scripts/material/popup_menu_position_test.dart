// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep demo - PopupMenuPosition (Material)
// ---------------------------------------------------------------------------
// PopupMenuPosition is a tiny enum with a big visual impact. It tells a
// PopupMenuButton (and the imperative showMenu() function, indirectly via the
// button's offset math) where to anchor the menu relative to its trigger:
//
//   - PopupMenuPosition.over  : the menu opens *over* the trigger, with the
//                               first item visually overlapping the anchor.
//                               This is the historical default in pre-M3
//                               Flutter and matches how desktop "command"
//                               menus feel - the cursor doesn't have to move.
//   - PopupMenuPosition.under : the menu opens *under* the trigger, like a
//                               classic dropdown. The trigger stays visible
//                               above the menu, which is what Material 3
//                               recommends and what users expect from
//                               toolbar-style controls.
//
// Both values interact with the optional `offset` parameter, with the screen
// edges (Flutter automatically flips a menu that would overflow), and with
// the chosen `child`/`icon` so the apparent placement depends on a triple of
// (position, anchor box, offset). This file is a hand-authored demo that
// puts each combination on a card so the reader can experiment.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== PopupMenuPosition Deep Demo ===');
  for (final v in PopupMenuPosition.values) {
    print('  enum value ${v.index}: ${v.name}');
  }

  // ---------------------------------------------------------------------------
  // Shared mutable state. Every section is wrapped in a StatefulBuilder so
  // closures over these locals re-trigger their own subtree when a menu item
  // is chosen. Because there is no main()/runApp() here (this is a harness
  // demo), keeping state at the build() scope is the simplest pattern.
  // ---------------------------------------------------------------------------

  // Section 2: live position toggle, shared between two side-by-side menus.
  PopupMenuPosition livePosition = PopupMenuPosition.under;
  String livePick = '(no item picked yet)';

  // Section 3: anchor variant + position + last selection display.
  PopupMenuPosition anchorPosition = PopupMenuPosition.under;
  String anchorPick = '(open one of the three triggers)';

  // Section 4: offset combined with position.
  PopupMenuPosition offsetPosition = PopupMenuPosition.under;
  double offsetDx = 0;
  double offsetDy = 0;
  String offsetPick = '(no item picked yet)';

  // Section 5: tall-trigger + over.
  String tallPick = '(pick a row action)';

  // Section 6: bottom-edge / auto-flip.
  String bottomPick = '(pick a share target)';

  // Section 7: PopupMenuTheme overrides.
  Color themeColor = const Color(0xFF1B5E20);
  PopupMenuPosition themePosition = PopupMenuPosition.under;
  double themeElevation = 8;
  String themePick = '(no view option chosen yet)';

  // Section 8: checked / disabled / dividers
  bool wrapLines = true;
  bool minimap = false;
  bool showRuler = true;
  bool showWhitespace = false;
  String checkedPick = '(toggle one of the editor view flags)';

  // Section 9: menuPadding demo.
  double menuPaddingV = 8;
  double menuPaddingH = 0;
  String menuPaddingPick = '(no profile chosen yet)';

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'PopupMenuPosition Deep Demo',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
    home: Scaffold(
      backgroundColor: const Color(0xFFF4F2FB),
      appBar: AppBar(
        title: const Text('PopupMenuPosition - Deep Demo'),
        backgroundColor: const Color(0xFF311B92),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // =================================================================
              // SECTION 1 - HERO CARD
              // -----------------------------------------------------------------
              // A heavy-weight intro card stating what the enum does and the
              // two values it ships. Sets the visual tone for the demo (deep
              // purple). The card is deliberately tall so the page already
              // looks "alive" before the reader scrolls.
              // =================================================================
              Card(
                color: const Color(0xFF311B92),
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.more_vert,
                                color: Colors.white, size: 28),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Text(
                              'enum PopupMenuPosition',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Where should the popup menu appear, relative to the '
                        'PopupMenuButton that owns it?',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 20),
                      _heroValueRow(
                        token: '.over',
                        title: 'Open over the trigger',
                        body: 'The first item visually overlaps the anchor. '
                            'Cursor / focus does not have to move - good for '
                            'desktop "command" menus.',
                        accent: const Color(0xFFB388FF),
                      ),
                      const SizedBox(height: 12),
                      _heroValueRow(
                        token: '.under',
                        title: 'Open under the trigger',
                        body: 'The trigger stays visible above the menu. '
                            'Material 3 toolbar / dropdown convention.',
                        accent: const Color(0xFF80CBC4),
                      ),
                      const SizedBox(height: 18),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.18),
                          ),
                        ),
                        child: const Text(
                          'Note: PopupMenuButton honours screen edges. If a '
                          ".under menu cannot fit below the trigger it will "
                          'flip up automatically; the enum chooses the '
                          'PREFERRED side, not an absolute one.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            height: 1.45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // =================================================================
              // SECTION 2 - SIDE BY SIDE OVER vs UNDER
              // -----------------------------------------------------------------
              // The simplest possible demonstration: two identical menus, one
              // .over and one .under, plus a SegmentedButton that toggles a
              // third menu live so the reader can see the popup re-rendering
              // with the new position the next time it opens.
              // =================================================================
              _SectionHeader(
                accent: const Color(0xFF6A1B9A),
                title: '2. .over vs .under, side by side',
                subtitle: 'Two menus rendered in parallel with the same items '
                    'so the only changing variable is PopupMenuPosition.',
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _PositionBox(
                                  background: const Color(0xFFEDE7F6),
                                  accent: const Color(0xFF512DA8),
                                  label: 'PopupMenuPosition.over',
                                  helper: 'Items visually overlap the trigger.',
                                  child: PopupMenuButton<String>(
                                    position: PopupMenuPosition.over,
                                    tooltip: 'File actions (over)',
                                    onSelected: (value) => setState(
                                        () => livePick = 'over -> $value'),
                                    itemBuilder: (ctx) => const [
                                      PopupMenuItem<String>(
                                        value: 'new',
                                        child: ListTile(
                                          leading: Icon(Icons.note_add),
                                          title: Text('New file'),
                                          subtitle: Text('Cmd+N'),
                                        ),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'open',
                                        child: ListTile(
                                          leading: Icon(Icons.folder_open),
                                          title: Text('Open...'),
                                          subtitle: Text('Cmd+O'),
                                        ),
                                      ),
                                      PopupMenuDivider(),
                                      PopupMenuItem<String>(
                                        value: 'save',
                                        child: ListTile(
                                          leading: Icon(Icons.save),
                                          title: Text('Save'),
                                          subtitle: Text('Cmd+S'),
                                        ),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'save_as',
                                        child: ListTile(
                                          leading: Icon(Icons.save_as),
                                          title: Text('Save as...'),
                                          subtitle: Text('Shift+Cmd+S'),
                                        ),
                                      ),
                                    ],
                                    child: const _AnchorPill(
                                      icon: Icons.description_outlined,
                                      label: 'File',
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _PositionBox(
                                  background: const Color(0xFFE0F2F1),
                                  accent: const Color(0xFF00695C),
                                  label: 'PopupMenuPosition.under',
                                  helper: 'Trigger stays above; classic dropdown.',
                                  child: PopupMenuButton<String>(
                                    position: PopupMenuPosition.under,
                                    tooltip: 'File actions (under)',
                                    onSelected: (value) => setState(
                                        () => livePick = 'under -> $value'),
                                    itemBuilder: (ctx) => const [
                                      PopupMenuItem<String>(
                                        value: 'new',
                                        child: ListTile(
                                          leading: Icon(Icons.note_add),
                                          title: Text('New file'),
                                          subtitle: Text('Cmd+N'),
                                        ),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'open',
                                        child: ListTile(
                                          leading: Icon(Icons.folder_open),
                                          title: Text('Open...'),
                                          subtitle: Text('Cmd+O'),
                                        ),
                                      ),
                                      PopupMenuDivider(),
                                      PopupMenuItem<String>(
                                        value: 'save',
                                        child: ListTile(
                                          leading: Icon(Icons.save),
                                          title: Text('Save'),
                                          subtitle: Text('Cmd+S'),
                                        ),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'save_as',
                                        child: ListTile(
                                          leading: Icon(Icons.save_as),
                                          title: Text('Save as...'),
                                          subtitle: Text('Shift+Cmd+S'),
                                        ),
                                      ),
                                    ],
                                    child: const _AnchorPill(
                                      icon: Icons.description_outlined,
                                      label: 'File',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 22),
                          const Text(
                            'Live toggle: rebuilds a third menu so you can see '
                            'how PopupMenuPosition flips at runtime. The next '
                            'time you open it, the chosen value is honoured.',
                            style: TextStyle(fontSize: 13, height: 1.45),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              SegmentedButton<PopupMenuPosition>(
                                segments: const [
                                  ButtonSegment(
                                    value: PopupMenuPosition.over,
                                    label: Text('.over'),
                                    icon: Icon(Icons.vertical_align_top),
                                  ),
                                  ButtonSegment(
                                    value: PopupMenuPosition.under,
                                    label: Text('.under'),
                                    icon: Icon(Icons.vertical_align_bottom),
                                  ),
                                ],
                                selected: {livePosition},
                                onSelectionChanged: (set) => setState(
                                    () => livePosition = set.first),
                              ),
                              const SizedBox(width: 16),
                              PopupMenuButton<String>(
                                position: livePosition,
                                tooltip: 'Sort by (live position)',
                                onSelected: (value) => setState(
                                    () => livePick = 'live -> $value'),
                                itemBuilder: (ctx) => const [
                                  PopupMenuItem<String>(
                                    value: 'name',
                                    child: Text('Sort by name'),
                                  ),
                                  PopupMenuItem<String>(
                                    value: 'modified',
                                    child: Text('Sort by date modified'),
                                  ),
                                  PopupMenuItem<String>(
                                    value: 'size',
                                    child: Text('Sort by size'),
                                  ),
                                  PopupMenuItem<String>(
                                    value: 'type',
                                    child: Text('Sort by type'),
                                  ),
                                ],
                                child: const _AnchorPill(
                                  icon: Icons.sort,
                                  label: 'Sort',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          _ResultBanner(
                            icon: Icons.bolt,
                            text: 'Last selection: $livePick',
                            color: const Color(0xFF512DA8),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // =================================================================
              // SECTION 3 - ANCHOR VARIATIONS
              // -----------------------------------------------------------------
              // PopupMenuPosition is computed against the **anchor box** of
              // the PopupMenuButton. That box is determined by the `child`
              // (or default `icon`) you provide. Three side-by-side anchors
              // -- icon, label, avatar -- show how the same enum value can
              // produce three different visual placements.
              // =================================================================
              _SectionHeader(
                accent: const Color(0xFF00838F),
                title: '3. The anchor box drives "where over/under starts"',
                subtitle: 'Same position enum, three different child widgets. '
                    'The menu always aligns to the bounds of the anchor.',
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  Widget anchorMenu(Widget child, String tag) {
                    return PopupMenuButton<String>(
                      position: anchorPosition,
                      tooltip: 'Share via ($tag)',
                      onSelected: (value) =>
                          setState(() => anchorPick = '$tag -> $value'),
                      itemBuilder: (ctx) => const [
                        PopupMenuItem<String>(
                          value: 'mail',
                          child: ListTile(
                            leading: Icon(Icons.mail_outline),
                            title: Text('Email'),
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'slack',
                          child: ListTile(
                            leading: Icon(Icons.tag),
                            title: Text('Slack'),
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'link',
                          child: ListTile(
                            leading: Icon(Icons.link),
                            title: Text('Copy link'),
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'airdrop',
                          child: ListTile(
                            leading: Icon(Icons.wifi_tethering),
                            title: Text('AirDrop'),
                          ),
                        ),
                      ],
                      child: child,
                    );
                  }

                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'PopupMenuPosition: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                              const SizedBox(width: 8),
                              SegmentedButton<PopupMenuPosition>(
                                segments: const [
                                  ButtonSegment(
                                    value: PopupMenuPosition.over,
                                    label: Text('.over'),
                                  ),
                                  ButtonSegment(
                                    value: PopupMenuPosition.under,
                                    label: Text('.under'),
                                  ),
                                ],
                                selected: {anchorPosition},
                                onSelectionChanged: (set) => setState(
                                    () => anchorPosition = set.first),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          Wrap(
                            spacing: 22,
                            runSpacing: 18,
                            children: [
                              _AnchorBox(
                                background: const Color(0xFFE0F7FA),
                                accent: const Color(0xFF006064),
                                label: 'IconButton anchor',
                                helper: 'Default 48x48 anchor box. The menu '
                                    'begins right at the icon edge.',
                                child: anchorMenu(
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withOpacity(0.08),
                                          blurRadius: 6,
                                        ),
                                      ],
                                    ),
                                    child: const Icon(Icons.share,
                                        color: Color(0xFF006064)),
                                  ),
                                  'icon',
                                ),
                              ),
                              _AnchorBox(
                                background: const Color(0xFFFFF8E1),
                                accent: const Color(0xFF8D6E63),
                                label: 'Label/pill anchor',
                                helper: 'A wider anchor produces a wider '
                                    'menu attachment edge.',
                                child: anchorMenu(
                                  const _AnchorPill(
                                    icon: Icons.share,
                                    label: 'Share this report',
                                  ),
                                  'pill',
                                ),
                              ),
                              _AnchorBox(
                                background: const Color(0xFFFCE4EC),
                                accent: const Color(0xFFAD1457),
                                label: 'Avatar anchor',
                                helper: 'Round anchor; menu still aligns to '
                                    'the bounding box, not the visible shape.',
                                child: anchorMenu(
                                  const CircleAvatar(
                                    radius: 22,
                                    backgroundColor: Color(0xFFAD1457),
                                    child: Icon(
                                      Icons.share,
                                      color: Colors.white,
                                    ),
                                  ),
                                  'avatar',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          _ResultBanner(
                            icon: Icons.flag_outlined,
                            text: 'Last selection: $anchorPick',
                            color: const Color(0xFF00838F),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // =================================================================
              // SECTION 4 - position + offset
              // -----------------------------------------------------------------
              // PopupMenuButton.offset is applied AFTER the position is
              // computed, so users can fine-tune placement. We expose two
              // sliders so the reader can shove the menu around the anchor.
              // =================================================================
              _SectionHeader(
                accent: const Color(0xFFD84315),
                title: '4. position + offset, fine-tuned together',
                subtitle: 'offset is applied on top of position. Use it for '
                    'small alignment nudges, not large jumps.',
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Position: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                              const SizedBox(width: 8),
                              SegmentedButton<PopupMenuPosition>(
                                segments: const [
                                  ButtonSegment(
                                    value: PopupMenuPosition.over,
                                    label: Text('.over'),
                                  ),
                                  ButtonSegment(
                                    value: PopupMenuPosition.under,
                                    label: Text('.under'),
                                  ),
                                ],
                                selected: {offsetPosition},
                                onSelectionChanged: (set) => setState(
                                    () => offsetPosition = set.first),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _LabeledSlider(
                            label: 'offset.dx',
                            min: -60,
                            max: 60,
                            value: offsetDx,
                            onChanged: (v) => setState(() => offsetDx = v),
                          ),
                          _LabeledSlider(
                            label: 'offset.dy',
                            min: -40,
                            max: 60,
                            value: offsetDy,
                            onChanged: (v) => setState(() => offsetDy = v),
                          ),
                          const SizedBox(height: 14),
                          Container(
                            height: 140,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF3E0),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFFD84315),
                                width: 1.2,
                              ),
                            ),
                            child: Center(
                              child: PopupMenuButton<String>(
                                position: offsetPosition,
                                offset: Offset(offsetDx, offsetDy),
                                tooltip: 'View options',
                                onSelected: (value) => setState(() =>
                                    offsetPick =
                                        'offset(${offsetDx.toStringAsFixed(0)},${offsetDy.toStringAsFixed(0)}) -> $value'),
                                itemBuilder: (ctx) => const [
                                  PopupMenuItem<String>(
                                    value: 'compact',
                                    child: Text('Compact density'),
                                  ),
                                  PopupMenuItem<String>(
                                    value: 'comfortable',
                                    child: Text('Comfortable density'),
                                  ),
                                  PopupMenuItem<String>(
                                    value: 'spacious',
                                    child: Text('Spacious density'),
                                  ),
                                  PopupMenuDivider(),
                                  PopupMenuItem<String>(
                                    value: 'show_grid',
                                    child: Text('Show grid'),
                                  ),
                                  PopupMenuItem<String>(
                                    value: 'show_rulers',
                                    child: Text('Show rulers'),
                                  ),
                                ],
                                child: const _AnchorPill(
                                  icon: Icons.tune,
                                  label: 'View options',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          _ResultBanner(
                            icon: Icons.straighten,
                            text: 'Last selection: $offsetPick',
                            color: const Color(0xFFD84315),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // =================================================================
              // SECTION 5 - .over with a tall trigger
              // -----------------------------------------------------------------
              // Demonstrates the visual identity of .over: when the trigger
              // is significantly taller than the menu, the first item lands
              // somewhere in the middle of the trigger. That is exactly the
              // "command menu over a row" pattern from data-grid UIs.
              // =================================================================
              _SectionHeader(
                accent: const Color(0xFF1565C0),
                title: '5. .over on a tall trigger - the row-action pattern',
                subtitle: 'Useful for data tables: tap any row, see the row '
                    'commands open right on top of the row\'s anchor.',
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  Widget tallRow(String invoice, String customer, String due) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(invoice,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700)),
                                const SizedBox(height: 4),
                                Text(customer,
                                    style: const TextStyle(
                                        color: Color(0xFF455A64),
                                        fontSize: 13)),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text('Due $due',
                                style: const TextStyle(
                                    color: Color(0xFF1565C0),
                                    fontWeight: FontWeight.w600)),
                          ),
                          PopupMenuButton<String>(
                            position: PopupMenuPosition.over,
                            tooltip: 'Row actions',
                            onSelected: (value) => setState(
                                () => tallPick = '$invoice -> $value'),
                            itemBuilder: (ctx) => const [
                              PopupMenuItem<String>(
                                value: 'view',
                                child: ListTile(
                                  leading: Icon(Icons.visibility),
                                  title: Text('View invoice'),
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: 'pdf',
                                child: ListTile(
                                  leading: Icon(Icons.picture_as_pdf),
                                  title: Text('Download PDF'),
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: 'remind',
                                child: ListTile(
                                  leading: Icon(Icons.notifications_active),
                                  title: Text('Send reminder'),
                                ),
                              ),
                              PopupMenuDivider(),
                              PopupMenuItem<String>(
                                value: 'archive',
                                child: ListTile(
                                  leading: Icon(Icons.archive),
                                  title: Text('Archive'),
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: 'delete',
                                enabled: false,
                                child: ListTile(
                                  leading:
                                      Icon(Icons.delete, color: Colors.grey),
                                  title: Text('Delete (locked)'),
                                ),
                              ),
                            ],
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(0xFF1565C0),
                                ),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.menu_open,
                                      color: Color(0xFF1565C0), size: 18),
                                  SizedBox(width: 4),
                                  Text('Actions',
                                      style: TextStyle(
                                          color: Color(0xFF1565C0),
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          tallRow('INV-1024', 'Aurora Robotics, Inc.',
                              'Apr 22'),
                          tallRow('INV-1031', 'Petals & Boughs',
                              'Apr 25'),
                          tallRow('INV-1042', 'Northstar Logistics',
                              'May 02'),
                          tallRow('INV-1057', 'Quanta Foods (Latam)',
                              'May 09'),
                          const SizedBox(height: 12),
                          _ResultBanner(
                            icon: Icons.table_rows,
                            text: 'Last action: $tallPick',
                            color: const Color(0xFF1565C0),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // =================================================================
              // SECTION 6 - .under near the bottom edge (auto-flip)
              // -----------------------------------------------------------------
              // Even with PopupMenuPosition.under, Flutter routes the menu so
              // it does not overflow. Anchor near the bottom = menu flips up.
              // We can't really force the bottom of the screen inside a
              // scrolling demo, but we can simulate the effect with a sized
              // container at the end of a card.
              // =================================================================
              _SectionHeader(
                accent: const Color(0xFFAD1457),
                title: '6. .under near a bottom edge - auto-flip',
                subtitle: 'PopupMenuPosition is a PREFERENCE. If there is no '
                    'room below the trigger, the menu opens above instead.',
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'On a phone, the trigger below would sit very '
                            'close to the soft-keyboard area or the bottom '
                            'safe-area inset. Flutter sees that .under has '
                            'no room and flips the menu upward without you '
                            'changing the enum.',
                            style: TextStyle(fontSize: 13, height: 1.45),
                          ),
                          const SizedBox(height: 14),
                          Container(
                            height: 220,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xFFFCE4EC),
                                  Colors.white,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFFAD1457),
                                width: 1.2,
                              ),
                            ),
                            child: Stack(
                              children: [
                                const Positioned(
                                  left: 16,
                                  top: 16,
                                  right: 16,
                                  child: Text(
                                    'Imagine this is the very bottom of a '
                                    'scaffold. The trigger is anchored to '
                                    'the bottom-right corner.',
                                    style: TextStyle(
                                      color: Color(0xFF880E4F),
                                      fontSize: 13,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 16,
                                  bottom: 16,
                                  child: PopupMenuButton<String>(
                                    position: PopupMenuPosition.under,
                                    tooltip: 'Send to ...',
                                    onSelected: (value) => setState(() =>
                                        bottomPick = 'under(flip) -> $value'),
                                    itemBuilder: (ctx) => const [
                                      PopupMenuItem<String>(
                                        value: 'mail',
                                        child: ListTile(
                                          leading: Icon(Icons.mail_outline),
                                          title: Text('Email'),
                                        ),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'message',
                                        child: ListTile(
                                          leading: Icon(Icons.sms),
                                          title: Text('SMS / Messages'),
                                        ),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'whatsapp',
                                        child: ListTile(
                                          leading: Icon(Icons.chat_bubble),
                                          title: Text('WhatsApp'),
                                        ),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'telegram',
                                        child: ListTile(
                                          leading: Icon(Icons.send),
                                          title: Text('Telegram'),
                                        ),
                                      ),
                                      PopupMenuDivider(),
                                      PopupMenuItem<String>(
                                        value: 'airdrop',
                                        child: ListTile(
                                          leading:
                                              Icon(Icons.wifi_tethering),
                                          title: Text('AirDrop'),
                                        ),
                                      ),
                                    ],
                                    child: const _AnchorPill(
                                      icon: Icons.share,
                                      label: 'Share',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          _ResultBanner(
                            icon: Icons.swap_vert,
                            text: 'Last share target: $bottomPick',
                            color: const Color(0xFFAD1457),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF1F5),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: const Color(0xFFEC407A)),
                            ),
                            child: const Text(
                              'Caption: PopupMenuButton uses CustomSingleChild'
                              'Layout under the hood; if your menu would be '
                              'clipped, _PopupMenuRouteLayout pushes it the '
                              'other direction. Treat .under as "I prefer '
                              'down", not "ALWAYS down".',
                              style: TextStyle(
                                fontSize: 12,
                                height: 1.45,
                                color: Color(0xFF6A1B4A),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // =================================================================
              // SECTION 7 - PopupMenuTheme overrides
              // -----------------------------------------------------------------
              // PopupMenuPosition has a parallel field on PopupMenuThemeData,
              // so apps can pick a default at the theme level. Here we wrap a
              // demo subtree in a Theme with a custom PopupMenuThemeData and
              // expose the most useful knobs (color, shape, elevation,
              // position) through StatefulBuilder controls.
              // =================================================================
              _SectionHeader(
                accent: const Color(0xFF2E7D32),
                title: '7. PopupMenuTheme - app-wide defaults for position',
                subtitle: 'Set position once on the theme and every PopupMenu '
                    'in the subtree inherits it (unless overridden locally).',
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  final themeData = PopupMenuThemeData(
                    color: themeColor,
                    elevation: themeElevation,
                    position: themePosition,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                    ),
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    iconColor: Colors.white,
                  );

                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 16,
                            runSpacing: 12,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Text('themed position: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14)),
                              SegmentedButton<PopupMenuPosition>(
                                segments: const [
                                  ButtonSegment(
                                    value: PopupMenuPosition.over,
                                    label: Text('.over'),
                                  ),
                                  ButtonSegment(
                                    value: PopupMenuPosition.under,
                                    label: Text('.under'),
                                  ),
                                ],
                                selected: {themePosition},
                                onSelectionChanged: (set) => setState(
                                    () => themePosition = set.first),
                              ),
                              const SizedBox(width: 12),
                              const Text('color: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14)),
                              for (final c in const [
                                Color(0xFF2E7D32),
                                Color(0xFF1565C0),
                                Color(0xFF6A1B9A),
                                Color(0xFFC62828),
                              ])
                                GestureDetector(
                                  onTap: () => setState(() => themeColor = c),
                                  child: Container(
                                    width: 26,
                                    height: 26,
                                    decoration: BoxDecoration(
                                      color: c,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: themeColor == c
                                            ? Colors.black
                                            : Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          _LabeledSlider(
                            label: 'theme elevation',
                            min: 0,
                            max: 24,
                            value: themeElevation,
                            onChanged: (v) =>
                                setState(() => themeElevation = v),
                          ),
                          const SizedBox(height: 8),
                          Theme(
                            data: Theme.of(context)
                                .copyWith(popupMenuTheme: themeData),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8F5E9),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xFF2E7D32),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: PopupMenuButton<String>(
                                      tooltip: 'View (theme A)',
                                      onSelected: (value) => setState(() =>
                                          themePick =
                                              'themeA -> $value'),
                                      itemBuilder: (ctx) => const [
                                        PopupMenuItem<String>(
                                          value: 'list',
                                          child: Text('List view'),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'cards',
                                          child: Text('Card view'),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'kanban',
                                          child: Text('Kanban view'),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'timeline',
                                          child: Text('Timeline view'),
                                        ),
                                      ],
                                      child: const _AnchorPill(
                                        icon: Icons.dashboard_customize,
                                        label: 'Themed view (A)',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: PopupMenuButton<String>(
                                      tooltip: 'View (theme B)',
                                      onSelected: (value) => setState(() =>
                                          themePick =
                                              'themeB -> $value'),
                                      itemBuilder: (ctx) => const [
                                        PopupMenuItem<String>(
                                          value: 'group_status',
                                          child: Text('Group by status'),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'group_owner',
                                          child: Text('Group by owner'),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'group_priority',
                                          child: Text('Group by priority'),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'group_none',
                                          child: Text('No grouping'),
                                        ),
                                      ],
                                      child: const _AnchorPill(
                                        icon: Icons.workspaces_filled,
                                        label: 'Themed group (B)',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          _ResultBanner(
                            icon: Icons.palette,
                            text: 'Last themed selection: $themePick',
                            color: const Color(0xFF2E7D32),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F5E9),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: const Color(0xFF2E7D32)),
                            ),
                            child: const Text(
                              'Theme tip: When you set position on the theme '
                              'you do NOT lose the ability to override it on '
                              'a single PopupMenuButton. The local field '
                              'always wins, which is the standard Flutter '
                              'theme cascade pattern.',
                              style: TextStyle(
                                fontSize: 12,
                                height: 1.45,
                                color: Color(0xFF1B5E20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // =================================================================
              // SECTION 8 - Checked / disabled / dividers
              // -----------------------------------------------------------------
              // PopupMenuPosition does not change item types - any popup menu
              // can mix CheckedPopupMenuItem, regular PopupMenuItem with
              // enabled:false, and PopupMenuDivider. We pair a .over menu of
              // editor view flags with a live readout of the toggled state,
              // so the reader can verify the .over experience with checked
              // items behaves the same way as a normal one.
              // =================================================================
              _SectionHeader(
                accent: const Color(0xFFEF6C00),
                title: '8. Checked / disabled / dividers under .over',
                subtitle: 'Position is independent of item kind. Mixing '
                    'CheckedPopupMenuItem, dividers and disabled rows works '
                    'identically with .over and .under.',
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.code,
                                  color: Color(0xFFEF6C00)),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Editor view options - .over',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFFEF6C00),
                                  ),
                                ),
                              ),
                              PopupMenuButton<String>(
                                position: PopupMenuPosition.over,
                                tooltip: 'Editor view',
                                onSelected: (value) {
                                  setState(() {
                                    switch (value) {
                                      case 'wrap':
                                        wrapLines = !wrapLines;
                                        break;
                                      case 'minimap':
                                        minimap = !minimap;
                                        break;
                                      case 'ruler':
                                        showRuler = !showRuler;
                                        break;
                                      case 'whitespace':
                                        showWhitespace = !showWhitespace;
                                        break;
                                    }
                                    checkedPick = 'toggled $value';
                                  });
                                },
                                itemBuilder: (ctx) => [
                                  CheckedPopupMenuItem<String>(
                                    value: 'wrap',
                                    checked: wrapLines,
                                    child: const Text('Wrap long lines'),
                                  ),
                                  CheckedPopupMenuItem<String>(
                                    value: 'minimap',
                                    checked: minimap,
                                    child: const Text('Show minimap'),
                                  ),
                                  CheckedPopupMenuItem<String>(
                                    value: 'ruler',
                                    checked: showRuler,
                                    child: const Text('Show ruler at 80'),
                                  ),
                                  CheckedPopupMenuItem<String>(
                                    value: 'whitespace',
                                    checked: showWhitespace,
                                    child: const Text('Show whitespace'),
                                  ),
                                  const PopupMenuDivider(),
                                  const PopupMenuItem<String>(
                                    value: 'theme',
                                    enabled: false,
                                    child: ListTile(
                                      leading: Icon(Icons.brightness_4,
                                          color: Colors.grey),
                                      title: Text(
                                        'Theme... (locked by org policy)',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'reset',
                                    child: ListTile(
                                      leading: Icon(Icons.restart_alt),
                                      title: Text('Reset to defaults'),
                                    ),
                                  ),
                                ],
                                child: const _AnchorPill(
                                  icon: Icons.settings,
                                  label: 'View',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Wrap(
                            spacing: 12,
                            runSpacing: 8,
                            children: [
                              _Chip(label: 'wrapLines', value: wrapLines),
                              _Chip(label: 'minimap', value: minimap),
                              _Chip(label: 'showRuler', value: showRuler),
                              _Chip(
                                  label: 'showWhitespace',
                                  value: showWhitespace),
                            ],
                          ),
                          const SizedBox(height: 14),
                          _ResultBanner(
                            icon: Icons.check_box,
                            text: 'Last toggle: $checkedPick',
                            color: const Color(0xFFEF6C00),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // =================================================================
              // SECTION 9 - menuPadding (and graceful fallback)
              // -----------------------------------------------------------------
              // PopupMenuButton.menuPadding (added in Flutter 3.22) lets apps
              // tighten the padding around the item list. Combined with
              // PopupMenuPosition.under and a small offset, you get a clean
              // "compact dropdown" look. We expose two sliders + show the
              // result; if the running Flutter is older the field will simply
              // not exist - keep this section and document the behaviour.
              // =================================================================
              _SectionHeader(
                accent: const Color(0xFF455A64),
                title: '9. menuPadding tightens the surface',
                subtitle: 'Use small menuPadding values when a popup feels '
                    'visually heavy next to a compact trigger.',
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _LabeledSlider(
                            label: 'menuPadding (vertical)',
                            min: 0,
                            max: 24,
                            value: menuPaddingV,
                            onChanged: (v) =>
                                setState(() => menuPaddingV = v),
                          ),
                          _LabeledSlider(
                            label: 'menuPadding (horizontal)',
                            min: 0,
                            max: 24,
                            value: menuPaddingH,
                            onChanged: (v) =>
                                setState(() => menuPaddingH = v),
                          ),
                          const SizedBox(height: 14),
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFECEFF1),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFF455A64),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    'Choose a profile to load. The popup will '
                                    'open .under with the padding values you '
                                    'configured above.',
                                    style: TextStyle(
                                      fontSize: 13,
                                      height: 1.45,
                                    ),
                                  ),
                                ),
                                PopupMenuButton<String>(
                                  position: PopupMenuPosition.under,
                                  tooltip: 'Profile',
                                  menuPadding: EdgeInsets.symmetric(
                                    vertical: menuPaddingV,
                                    horizontal: menuPaddingH,
                                  ),
                                  onSelected: (value) => setState(() =>
                                      menuPaddingPick = 'profile -> $value'),
                                  itemBuilder: (ctx) => const [
                                    PopupMenuItem<String>(
                                      value: 'work',
                                      child: ListTile(
                                        leading: Icon(Icons.work_outline),
                                        title: Text('Work'),
                                      ),
                                    ),
                                    PopupMenuItem<String>(
                                      value: 'home',
                                      child: ListTile(
                                        leading: Icon(Icons.home_outlined),
                                        title: Text('Home'),
                                      ),
                                    ),
                                    PopupMenuItem<String>(
                                      value: 'travel',
                                      child: ListTile(
                                        leading: Icon(Icons.flight_takeoff),
                                        title: Text('Travel'),
                                      ),
                                    ),
                                    PopupMenuItem<String>(
                                      value: 'focus',
                                      child: ListTile(
                                        leading: Icon(Icons.do_not_disturb),
                                        title: Text('Deep focus'),
                                      ),
                                    ),
                                  ],
                                  child: const _AnchorPill(
                                    icon: Icons.account_circle_outlined,
                                    label: 'Profile',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          _ResultBanner(
                            icon: Icons.format_indent_increase,
                            text: 'Last profile: $menuPaddingPick',
                            color: const Color(0xFF455A64),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // =================================================================
              // SECTION 10 - When to use which?
              // -----------------------------------------------------------------
              // Annotated guidance card. No live widgets, just a long-form
              // recommendation matrix the reader can come back to.
              // =================================================================
              _SectionHeader(
                accent: const Color(0xFF424242),
                title: '10. When should I pick .over vs .under?',
                subtitle: 'Practical guidance, distilled from M2 / M3 spec '
                    'and from common toolbar / data-grid patterns.',
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _RecommendRow(
                        position: '.over',
                        title: 'Toolbars and command menus',
                        body: 'Cursor lands directly on the first item; no '
                            'mouse travel needed. Matches how desktop IDEs '
                            'render context menus. Use sparingly on touch '
                            'because the trigger disappears.',
                        accent: const Color(0xFF6A1B9A),
                      ),
                      _RecommendRow(
                        position: '.over',
                        title: 'Data-grid row actions',
                        body: 'When the trigger is taller than the menu (a '
                            'whole row), .over feels like a contextual '
                            'pop-out anchored to the row.',
                        accent: const Color(0xFF6A1B9A),
                      ),
                      _RecommendRow(
                        position: '.under',
                        title: 'Header / app-bar dropdowns',
                        body: 'Users expect dropdowns to open beneath the '
                            'trigger. Keeps the trigger visible so the '
                            'context (which menu is open) remains obvious.',
                        accent: const Color(0xFF00695C),
                      ),
                      _RecommendRow(
                        position: '.under',
                        title: 'Touch / mobile',
                        body: 'Finger does not occlude the trigger. Easier '
                            'to tap, especially on small phones, and the '
                            'first item is well-clear of the touch target.',
                        accent: const Color(0xFF00695C),
                      ),
                      _RecommendRow(
                        position: 'theme',
                        title: 'Set a default once, override locally',
                        body: 'Pick the value that fits 80% of your menus '
                            'and put it on PopupMenuThemeData.position. '
                            'Override the rare exceptions per button.',
                        accent: const Color(0xFF2E7D32),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: const Color(0xFF9E9E9E)),
                        ),
                        child: const Text(
                          'Accessibility note: PopupMenuButton manages focus '
                          'and arrow-key navigation regardless of position. '
                          'Screen-readers announce the trigger first, then '
                          'each item; whether the menu sits over or under '
                          'the trigger does not affect the reading order.',
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.45,
                            color: Color(0xFF424242),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: const Color(0xFF1565C0)),
                        ),
                        child: const Text(
                          'M3 vs M2: in Material 2 the historical default '
                          'was .over (legacy). Material 3 prefers .under for '
                          'most surface-level menus. Flutter still defaults '
                          'PopupMenuButton.position to .over, so passing '
                          '.under explicitly (or via PopupMenuThemeData) is '
                          'the right call for new M3 codebases.',
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.45,
                            color: Color(0xFF0D47A1),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3E5F5),
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: const Color(0xFF6A1B9A)),
                        ),
                        child: const Text(
                          'Interaction with MenuAnchor: PopupMenuButton uses '
                          'the popup-route based stack, while MenuAnchor / '
                          'MenuBar use the newer M3 menu system. MenuAnchor '
                          'has its own alignmentOffset / anchorTapClosesMenu '
                          'instead of PopupMenuPosition. They coexist - pick '
                          'PopupMenuButton when you want a single one-shot '
                          'menu, MenuAnchor when you need keyboard-friendly '
                          'cascading menus.',
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.45,
                            color: Color(0xFF4A148C),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 36),

              // =================================================================
              // FOOTER - quick reference table
              // =================================================================
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Quick reference',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const _RefHeaderRow(),
                      _RefDataRow(
                        token: '.over',
                        defaultFor: 'PopupMenuButton (legacy)',
                        bestFor: 'desktop, command menus, tall triggers',
                      ),
                      _RefDataRow(
                        token: '.under',
                        defaultFor: 'M3 toolbar dropdowns',
                        bestFor: 'mobile, header dropdowns, dense lists',
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Generated by the PopupMenuPosition deep demo.',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// HELPERS
// ---------------------------------------------------------------------------

Widget _heroValueRow({
  required String token,
  required String title,
  required String body,
  required Color accent,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.white.withOpacity(0.18)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            token,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
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

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.accent,
    required this.title,
    required this.subtitle,
  });

  final Color accent;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6,
          height: 44,
          margin: const EdgeInsets.only(right: 12, top: 2),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF455A64),
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PositionBox extends StatelessWidget {
  const _PositionBox({
    required this.background,
    required this.accent,
    required this.label,
    required this.helper,
    required this.child,
  });

  final Color background;
  final Color accent;
  final String label;
  final String helper;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            helper,
            style: const TextStyle(fontSize: 12, height: 1.35),
          ),
          const SizedBox(height: 14),
          Center(child: child),
        ],
      ),
    );
  }
}

class _AnchorBox extends StatelessWidget {
  const _AnchorBox({
    required this.background,
    required this.accent,
    required this.label,
    required this.helper,
    required this.child,
  });

  final Color background;
  final Color accent;
  final String label;
  final String helper;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            helper,
            style: const TextStyle(fontSize: 12, height: 1.35),
          ),
          const SizedBox(height: 14),
          Center(child: child),
        ],
      ),
    );
  }
}

class _AnchorPill extends StatelessWidget {
  const _AnchorPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down, size: 18),
        ],
      ),
    );
  }
}

class _ResultBanner extends StatelessWidget {
  const _ResultBanner({
    required this.icon,
    required this.text,
    required this.color,
  });

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LabeledSlider extends StatelessWidget {
  const _LabeledSlider({
    required this.label,
    required this.min,
    required this.max,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final double min;
  final double max;
  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 180,
            child: Text(
              '$label: ${value.toStringAsFixed(1)}',
              style: const TextStyle(fontSize: 13),
            ),
          ),
          Expanded(
            child: Slider(
              min: min,
              max: max,
              value: value.clamp(min, max),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.value});

  final String label;
  final bool value;

  @override
  Widget build(BuildContext context) {
    final color = value ? const Color(0xFF2E7D32) : const Color(0xFF9E9E9E);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            value ? Icons.check_circle : Icons.radio_button_unchecked,
            color: color,
            size: 14,
          ),
          const SizedBox(width: 6),
          Text(
            '$label = $value',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _RecommendRow extends StatelessWidget {
  const _RecommendRow({
    required this.position,
    required this.title,
    required this.body,
    required this.accent,
  });

  final String position;
  final String title;
  final String body;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              position,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: Color(0xFF455A64),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RefHeaderRow extends StatelessWidget {
  const _RefHeaderRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF311B92),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'token',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              'default for',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              'best for',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RefDataRow extends StatelessWidget {
  const _RefDataRow({
    required this.token,
    required this.defaultFor,
    required this.bestFor,
  });

  final String token;
  final String defaultFor;
  final String bestFor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFE0E0E0)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              token,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(flex: 4, child: Text(defaultFor)),
          Expanded(flex: 5, child: Text(bestFor)),
        ],
      ),
    );
  }
}

// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep demo - DropdownMenuCloseBehavior
// ---------------------------------------------------------------------------
// DropdownMenuCloseBehavior is the enum used by Material's DropdownMenu (and
// indirectly by SubmenuButton-style menus, since those expose closeOnActivate
// for their items) to describe what should happen to the rest of the menu
// stack once an item is activated. The three values are:
//
//   - all   : when an item is activated, every open menu in the widget tree
//             dismisses. This is the default and is what end-users expect for
//             classic drop-downs (pick a value, the menu vanishes).
//   - self  : only the dropdown that owns the activated item closes. Sibling
//             menus and nested submenus stay visible. Useful when one menu is
//             part of a richer composite UI surface.
//   - none  : no menu closes. Every menu stays open after activation. This is
//             the right answer for "control panel" menus full of toggle items
//             where the user wants to flip several flags in one visit.
//
// This file is a hand-written deep demo, not a generated test. It renders
// seven sections, each highlighting a different facet of the enum.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== DropdownMenuCloseBehavior Deep Demo ===');
  for (final v in DropdownMenuCloseBehavior.values) {
    print('  enum value ${v.index}: ${v.name}');
  }

  // ---------------------------------------------------------------------------
  // Shared activation log. Several sections push entries here so the reader
  // can correlate clicks with which menus close. The log is read inside
  // StatefulBuilder children, so a top-level mutable list is fine.
  // ---------------------------------------------------------------------------
  final activationLog = <String>[];
  void logActivation(String section, String item) {
    print('activation [$section] -> $item');
    activationLog.insert(0, '[$section] $item');
    if (activationLog.length > 8) {
      activationLog.removeLast();
    }
  }

  // ---------------------------------------------------------------------------
  // Section 5 owns several toggle flags. We put them at the top so the closure
  // captures persist across rebuilds inside StatefulBuilder.
  // ---------------------------------------------------------------------------
  bool toggleBold = false;
  bool toggleItalic = false;
  bool toggleUnderline = false;
  bool toggleWrap = false;
  bool toggleMinimap = true;

  // Section 6 also has comparison state - which of the three menus was last
  // opened, to drive the "what did you observe?" caption under the buttons.
  String comparisonNote = 'Tap any of the three menus and pick "Save".';

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'DropdownMenuCloseBehavior Deep Demo',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
    home: Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text('DropdownMenuCloseBehavior - Deep Demo'),
        backgroundColor: const Color(0xFF1E1F4B),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ===================================================================
              // SECTION 1 - HERO CARD
              // -------------------------------------------------------------------
              // A single rich card giving the elevator pitch for the enum and
              // its three values. We use a bold indigo background to set this
              // section apart visually.
              // ===================================================================
              Card(
                color: const Color(0xFF1E1F4B),
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
                            child: const Icon(Icons.arrow_drop_down_circle,
                                color: Colors.white, size: 28),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Text(
                              'enum DropdownMenuCloseBehavior',
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
                        'Controls how the menu stack reacts when a menu item '
                        'is activated. Defaults to .all (legacy behaviour).',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 20),
                      _heroValueRow(
                        token: '.all',
                        title: 'Close everything',
                        body: 'All open menus in the tree dismiss. Use for '
                            'classic dropdowns where activation = final pick.',
                        accent: const Color(0xFF7C9CFF),
                      ),
                      const SizedBox(height: 12),
                      _heroValueRow(
                        token: '.self',
                        title: 'Close just this menu',
                        body: 'The dropdown that owns the item closes; '
                            'sibling submenus stay open. Composable surfaces.',
                        accent: const Color(0xFFFFC857),
                      ),
                      const SizedBox(height: 12),
                      _heroValueRow(
                        token: '.none',
                        title: 'Close nothing',
                        body: 'No menus dismiss. Pair with toggle items so '
                            'users flip several flags before walking away.',
                        accent: const Color(0xFFFF7C7C),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ===================================================================
              // SECTION 2 - THREE NESTED MENU ANCHORS
              // -------------------------------------------------------------------
              // Three side-by-side MenuAnchor demos, each containing a multi-
              // level nested submenu. The activation log card on the right
              // updates whenever an item is picked, so the reader can see
              // which menus close in each behaviour.
              //
              // Note: MenuAnchor / SubmenuButton don't expose the enum directly
              // (the enum is consumed by DropdownMenu). For this section we
              // simulate each behaviour using closeOnActivate on the items
              // themselves, plus a manual reopen for `none`.
              // ===================================================================
              _SectionHeader(
                accent: const Color(0xFF2E7D32),
                title: '2. Nested MenuAnchor with the three behaviours',
                subtitle: 'Open a menu, then pick a deeply-nested item. Watch '
                    'which menus stay visible afterwards.',
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  void onActivate(String section, String item) {
                    setState(() => logActivation(section, item));
                  }

                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Wrap(
                              spacing: 16,
                              runSpacing: 16,
                              children: [
                                _NestedMenuExample(
                                  label: '.all',
                                  helper: 'Close everything on activate',
                                  background: const Color(0xFFE8F5E9),
                                  accent: const Color(0xFF2E7D32),
                                  closeBehaviorName: 'all',
                                  onActivate: (item) =>
                                      onActivate('all', item),
                                ),
                                _NestedMenuExample(
                                  label: '.self',
                                  helper: 'Close only this menu',
                                  background: const Color(0xFFFFF8E1),
                                  accent: const Color(0xFFB68900),
                                  closeBehaviorName: 'self',
                                  onActivate: (item) =>
                                      onActivate('self', item),
                                ),
                                _NestedMenuExample(
                                  label: '.none',
                                  helper: 'Keep all menus open',
                                  background: const Color(0xFFFFEBEE),
                                  accent: const Color(0xFFC62828),
                                  closeBehaviorName: 'none',
                                  onActivate: (item) =>
                                      onActivate('none', item),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            width: 220,
                            child: _ActivationLogCard(log: activationLog),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // ===================================================================
              // SECTION 3 - DROPDOWNMENU MINI RECIPE
              // -------------------------------------------------------------------
              // Three live DropdownMenu<String> widgets, one per close
              // behaviour. Unlike section 2, these consume the enum directly
              // via DropdownMenu.closeBehavior - this is the canonical use of
              // the enum in real Flutter code.
              // ===================================================================
              _SectionHeader(
                accent: const Color(0xFF6A1B9A),
                title: '3. DropdownMenu<T> with closeBehavior',
                subtitle: 'Three identical DropdownMenu widgets, the only '
                    'difference is the closeBehavior parameter.',
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  String picked3a = 'apple';
                  String picked3b = 'banana';
                  String picked3c = 'cherry';
                  return Card(
                    elevation: 2,
                    color: const Color(0xFFF3E5F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Wrap(
                        spacing: 24,
                        runSpacing: 16,
                        children: [
                          _DropdownMenuTile(
                            title: 'closeBehavior: .all',
                            description:
                                'Default. The menu closes when an item is '
                                'tapped. Sibling overlays also close.',
                            accent: const Color(0xFF6A1B9A),
                            child: DropdownMenu<String>(
                              initialSelection: picked3a,
                              closeBehavior: DropdownMenuCloseBehavior.all,
                              label: const Text('Fruit (.all)'),
                              dropdownMenuEntries: const [
                                DropdownMenuEntry(
                                    value: 'apple', label: 'Apple'),
                                DropdownMenuEntry(
                                    value: 'banana', label: 'Banana'),
                                DropdownMenuEntry(
                                    value: 'cherry', label: 'Cherry'),
                                DropdownMenuEntry(
                                    value: 'date', label: 'Date'),
                              ],
                              onSelected: (v) {
                                setState(() {
                                  picked3a = v ?? picked3a;
                                  logActivation('dm.all', v ?? '');
                                });
                              },
                            ),
                          ),
                          _DropdownMenuTile(
                            title: 'closeBehavior: .self',
                            description:
                                'Only this menu closes; siblings or other '
                                'overlays in the tree stay open.',
                            accent: const Color(0xFFB68900),
                            child: DropdownMenu<String>(
                              initialSelection: picked3b,
                              closeBehavior: DropdownMenuCloseBehavior.self,
                              label: const Text('Fruit (.self)'),
                              dropdownMenuEntries: const [
                                DropdownMenuEntry(
                                    value: 'apple', label: 'Apple'),
                                DropdownMenuEntry(
                                    value: 'banana', label: 'Banana'),
                                DropdownMenuEntry(
                                    value: 'cherry', label: 'Cherry'),
                                DropdownMenuEntry(
                                    value: 'date', label: 'Date'),
                              ],
                              onSelected: (v) {
                                setState(() {
                                  picked3b = v ?? picked3b;
                                  logActivation('dm.self', v ?? '');
                                });
                              },
                            ),
                          ),
                          _DropdownMenuTile(
                            title: 'closeBehavior: .none',
                            description:
                                'Menu stays open after activation. The user '
                                'can quickly pick again or change their mind.',
                            accent: const Color(0xFFC62828),
                            child: DropdownMenu<String>(
                              initialSelection: picked3c,
                              closeBehavior: DropdownMenuCloseBehavior.none,
                              label: const Text('Fruit (.none)'),
                              dropdownMenuEntries: const [
                                DropdownMenuEntry(
                                    value: 'apple', label: 'Apple'),
                                DropdownMenuEntry(
                                    value: 'banana', label: 'Banana'),
                                DropdownMenuEntry(
                                    value: 'cherry', label: 'Cherry'),
                                DropdownMenuEntry(
                                    value: 'date', label: 'Date'),
                              ],
                              onSelected: (v) {
                                setState(() {
                                  picked3c = v ?? picked3c;
                                  logActivation('dm.none', v ?? '');
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // ===================================================================
              // SECTION 4 - FILE MENU MOCKUP RECIPE GALLERY
              // -------------------------------------------------------------------
              // Three faux File menus rendered as MenuBars (File > Recent >
              // File1). Each one emulates one of the three behaviours so the
              // reader can imagine what their own application's File menu
              // would feel like under each option.
              // ===================================================================
              _SectionHeader(
                accent: const Color(0xFF00838F),
                title: '4. File-menu recipe gallery',
                subtitle: 'A classic File > Recent > File1 chain rendered '
                    'three times, one per behaviour.',
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  String lastFile = '(none)';

                  void onPickFile(String behaviour, String file) {
                    setState(() {
                      lastFile = '$file via .$behaviour';
                      logActivation('file.$behaviour', file);
                    });
                  }

                  return Card(
                    elevation: 2,
                    color: const Color(0xFFE0F7FA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'File menu, three behaviours',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border:
                                      Border.all(color: Colors.black12),
                                ),
                                child: Text('Last opened: $lastFile'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          Wrap(
                            spacing: 24,
                            runSpacing: 16,
                            children: [
                              _FileMenuMock(
                                title: '.all',
                                accent: const Color(0xFF2E7D32),
                                explanation:
                                    'Tapping "File1" closes the entire '
                                    'menu chain. Classic, expected for File '
                                    'menus.',
                                closeOnActivate: true,
                                onPick: (f) => onPickFile('all', f),
                              ),
                              _FileMenuMock(
                                title: '.self',
                                accent: const Color(0xFFB68900),
                                explanation:
                                    'Only the leaf "Recent" submenu '
                                    'collapses; the File menu bar stays '
                                    'highlighted so the user can keep '
                                    'browsing.',
                                closeOnActivate: false,
                                onPick: (f) => onPickFile('self', f),
                              ),
                              _FileMenuMock(
                                title: '.none',
                                accent: const Color(0xFFC62828),
                                explanation:
                                    'No menus close. Useful when "File1" '
                                    'is a preview action and the user is '
                                    'browsing many recents.',
                                closeOnActivate: false,
                                onPick: (f) => onPickFile('none', f),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // ===================================================================
              // SECTION 5 - TOGGLE-STATE ITEMS RECIPE
              // -------------------------------------------------------------------
              // Real-world recipe: a "View" menu where every item is a toggle
              // (Bold, Italic, Underline, Word wrap, Minimap). The user wants
              // to flip several at once, so .none is the right behaviour.
              // ===================================================================
              _SectionHeader(
                accent: const Color(0xFFEF6C00),
                title: '5. Toggle items - the .none use case',
                subtitle: 'When every menu item is a toggle, .none keeps the '
                    'menu open so users can flip several without re-opening.',
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  Widget toggleRow({
                    required String label,
                    required bool value,
                    required ValueChanged<bool> onChanged,
                  }) {
                    return InkWell(
                      onTap: () => onChanged(!value),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Row(
                          children: [
                            Icon(
                              value
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                              color: value
                                  ? const Color(0xFFEF6C00)
                                  : Colors.black45,
                            ),
                            const SizedBox(width: 12),
                            Expanded(child: Text(label)),
                          ],
                        ),
                      ),
                    );
                  }

                  return Card(
                    elevation: 2,
                    color: const Color(0xFFFFF3E0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'View > Formatting toggles (.none)',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Tap each row. The menu remains open after '
                                  'every tap so you can rapidly toggle a few '
                                  'options at once. With .all, you would have '
                                  'to re-open the menu after every flip.',
                                  style: TextStyle(color: Colors.black54),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.black12),
                                  ),
                                  child: Column(
                                    children: [
                                      toggleRow(
                                        label: 'Bold',
                                        value: toggleBold,
                                        onChanged: (v) {
                                          setState(() {
                                            toggleBold = v;
                                            logActivation(
                                                'toggle.none', 'Bold=$v');
                                          });
                                        },
                                      ),
                                      const Divider(height: 1),
                                      toggleRow(
                                        label: 'Italic',
                                        value: toggleItalic,
                                        onChanged: (v) {
                                          setState(() {
                                            toggleItalic = v;
                                            logActivation(
                                                'toggle.none', 'Italic=$v');
                                          });
                                        },
                                      ),
                                      const Divider(height: 1),
                                      toggleRow(
                                        label: 'Underline',
                                        value: toggleUnderline,
                                        onChanged: (v) {
                                          setState(() {
                                            toggleUnderline = v;
                                            logActivation(
                                                'toggle.none', 'Underline=$v');
                                          });
                                        },
                                      ),
                                      const Divider(height: 1),
                                      toggleRow(
                                        label: 'Word wrap',
                                        value: toggleWrap,
                                        onChanged: (v) {
                                          setState(() {
                                            toggleWrap = v;
                                            logActivation(
                                                'toggle.none', 'Wrap=$v');
                                          });
                                        },
                                      ),
                                      const Divider(height: 1),
                                      toggleRow(
                                        label: 'Show minimap',
                                        value: toggleMinimap,
                                        onChanged: (v) {
                                          setState(() {
                                            toggleMinimap = v;
                                            logActivation(
                                                'toggle.none', 'Minimap=$v');
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 24),
                          Container(
                            width: 200,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Live state',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                _kv('bold', toggleBold),
                                _kv('italic', toggleItalic),
                                _kv('underline', toggleUnderline),
                                _kv('wrap', toggleWrap),
                                _kv('minimap', toggleMinimap),
                                const SizedBox(height: 12),
                                Text(
                                  'Try the same UI with .all or .self - you '
                                  'will close the menu on every tap.',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // ===================================================================
              // SECTION 6 - SIDE-BY-SIDE COMPARISON CARD
              // -------------------------------------------------------------------
              // Same menu tree (File-style with Save / Save As / Close), three
              // anchor buttons in a row. Beneath each button: an explanation
              // of what the user is observing.
              // ===================================================================
              _SectionHeader(
                accent: const Color(0xFF455A64),
                title: '6. Side-by-side comparison',
                subtitle: 'Identical menu tree - three buttons - three '
                    'closeBehavior values. Pick "Save" in any of them.',
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  void note(String value, String item) {
                    setState(() {
                      comparisonNote = 'You picked "$item" in .$value.';
                      logActivation('cmp.$value', item);
                    });
                  }

                  return Card(
                    elevation: 2,
                    color: const Color(0xFFECEFF1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _ComparisonAnchor(
                                title: '.all',
                                description: 'Tapping Save closes the menu.',
                                accent: const Color(0xFF2E7D32),
                                closeOnActivate: true,
                                onPick: (item) => note('all', item),
                              ),
                              _ComparisonAnchor(
                                title: '.self',
                                description:
                                    'Tapping Save closes only this menu - '
                                    'sibling overlays would survive.',
                                accent: const Color(0xFFB68900),
                                closeOnActivate: true,
                                onPick: (item) => note('self', item),
                              ),
                              _ComparisonAnchor(
                                title: '.none',
                                description:
                                    'Tapping Save keeps the menu open. '
                                    'Useful for "preview Save".',
                                accent: const Color(0xFFC62828),
                                closeOnActivate: false,
                                onPick: (item) => note('none', item),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Text(comparisonNote),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Visible behaviour difference: with .all the '
                            'overlay vanishes immediately. With .self, only '
                            'the activated dropdown disappears. With .none, '
                            'the overlay stays mounted, so you can repeat '
                            'the action without traveling to the anchor '
                            'again.',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // ===================================================================
              // SECTION 7 - REFERENCE CARD
              // -------------------------------------------------------------------
              // A flat reference table: enum value, index, default flag, and a
              // one-liner "when to use" guide.
              // ===================================================================
              _SectionHeader(
                accent: const Color(0xFF263238),
                title: '7. Reference card',
                subtitle: 'Enum values, indices, and a one-liner usage hint.',
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 2,
                color: const Color(0xFFECEFF1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: Text(
                          'Quick reference',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Column(
                          children: [
                            const _RefHeaderRow(),
                            for (final v
                                in DropdownMenuCloseBehavior.values)
                              _RefDataRow(value: v),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Defaults to DropdownMenuCloseBehavior.all when the '
                        'parameter is omitted (legacy behaviour). The enum '
                        'is consumed by DropdownMenu<T>.closeBehavior; for '
                        'MenuAnchor / SubmenuButton menus the equivalent '
                        'wiring is item-by-item via MenuItemButton.'
                        'closeOnActivate (true == .all, false == .none).',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // -------------------------------------------------------------------
              // FOOTER - tiny credit / contract line.
              // -------------------------------------------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: Text(
                    'DropdownMenuCloseBehavior - hand-rolled deep demo',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.45),
                      fontStyle: FontStyle.italic,
                    ),
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
// Below: small helper widgets and free functions used by the sections above.
// They live below build() so the top-of-file flow reads as a single demo
// script. None of them carry state of their own; state is owned by the
// surrounding StatefulBuilders.
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
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accent.withOpacity(0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.18),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            token,
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
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
          width: 4,
          height: 44,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: accent,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Section 2 helper: a single nested MenuAnchor demo with a submenu.
// closeBehaviorName is one of 'all' / 'self' / 'none' and only changes the
// MenuItemButton.closeOnActivate flag and (for 'none') reopens the menu via
// the controller after activation.
// ---------------------------------------------------------------------------
class _NestedMenuExample extends StatefulWidget {
  const _NestedMenuExample({
    required this.label,
    required this.helper,
    required this.background,
    required this.accent,
    required this.closeBehaviorName,
    required this.onActivate,
  });

  final String label;
  final String helper;
  final Color background;
  final Color accent;
  final String closeBehaviorName;
  final ValueChanged<String> onActivate;

  @override
  State<_NestedMenuExample> createState() => _NestedMenuExampleState();
}

class _NestedMenuExampleState extends State<_NestedMenuExample> {
  final MenuController _controller = MenuController();

  void _handle(String item) {
    widget.onActivate('${widget.label} $item');
    if (widget.closeBehaviorName == 'none') {
      // .none semantics: ensure the menu stays/becomes open.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && !_controller.isOpen) {
          _controller.open();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final closeOnActivate =
        widget.closeBehaviorName == 'all' || widget.closeBehaviorName == 'self';
    return Container(
      width: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: widget.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.accent.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: widget.accent,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.helper,
            style: TextStyle(
              color: widget.accent,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),
          MenuAnchor(
            controller: _controller,
            menuChildren: [
              SubmenuButton(
                menuChildren: [
                  SubmenuButton(
                    menuChildren: [
                      MenuItemButton(
                        closeOnActivate: closeOnActivate,
                        onPressed: () => _handle('Open > Recent > A'),
                        child: const Text('Recent A'),
                      ),
                      MenuItemButton(
                        closeOnActivate: closeOnActivate,
                        onPressed: () => _handle('Open > Recent > B'),
                        child: const Text('Recent B'),
                      ),
                      MenuItemButton(
                        closeOnActivate: closeOnActivate,
                        onPressed: () => _handle('Open > Recent > C'),
                        child: const Text('Recent C'),
                      ),
                    ],
                    child: const Text('Recent'),
                  ),
                  MenuItemButton(
                    closeOnActivate: closeOnActivate,
                    onPressed: () => _handle('Open > New tab'),
                    child: const Text('New tab'),
                  ),
                  MenuItemButton(
                    closeOnActivate: closeOnActivate,
                    onPressed: () => _handle('Open > Window'),
                    child: const Text('Open in window'),
                  ),
                ],
                child: const Text('Open'),
              ),
              MenuItemButton(
                closeOnActivate: closeOnActivate,
                onPressed: () => _handle('Save'),
                child: const Text('Save'),
              ),
              MenuItemButton(
                closeOnActivate: closeOnActivate,
                onPressed: () => _handle('Save As...'),
                child: const Text('Save As...'),
              ),
              MenuItemButton(
                closeOnActivate: closeOnActivate,
                onPressed: () => _handle('Quit'),
                child: const Text('Quit'),
              ),
            ],
            builder: (context, controller, child) {
              return ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.accent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 10),
                ),
                icon: const Icon(Icons.menu),
                label: Text('File (.${widget.closeBehaviorName})'),
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 2 helper: a small "log" card that displays the most-recent
// activations. Surrounding StatefulBuilder owns the underlying list so this
// widget is purely presentational.
// ---------------------------------------------------------------------------
class _ActivationLogCard extends StatelessWidget {
  const _ActivationLogCard({required this.log});

  final List<String> log;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.history, size: 16, color: Colors.black54),
              SizedBox(width: 6),
              Text(
                'Last activations',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Divider(height: 16),
          if (log.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Text(
                '(no activations yet)',
                style: TextStyle(
                    color: Colors.black45, fontStyle: FontStyle.italic),
              ),
            )
          else
            ...log.map(
              (line) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  line,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 3 helper: tile around a DropdownMenu with a title, description and
// an accent stripe.
// ---------------------------------------------------------------------------
class _DropdownMenuTile extends StatelessWidget {
  const _DropdownMenuTile({
    required this.title,
    required this.description,
    required this.accent,
    required this.child,
  });

  final String title;
  final String description;
  final Color accent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: accent.withOpacity(0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'monospace',
                color: accent,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 4 helper: a fake File > Recent > File1 menu chain. This widget
// always renders a real MenuAnchor so the user can try it; the only thing
// that varies is whether MenuItemButton.closeOnActivate is true or false.
// For the .none variant we simply do not close anything.
// ---------------------------------------------------------------------------
class _FileMenuMock extends StatefulWidget {
  const _FileMenuMock({
    required this.title,
    required this.accent,
    required this.explanation,
    required this.closeOnActivate,
    required this.onPick,
  });

  final String title;
  final Color accent;
  final String explanation;
  final bool closeOnActivate;
  final ValueChanged<String> onPick;

  @override
  State<_FileMenuMock> createState() => _FileMenuMockState();
}

class _FileMenuMockState extends State<_FileMenuMock> {
  final MenuController _controller = MenuController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: widget.accent.withOpacity(0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontFamily: 'monospace',
                color: widget.accent,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.explanation,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 12),
            MenuAnchor(
              controller: _controller,
              menuChildren: [
                SubmenuButton(
                  menuChildren: [
                    MenuItemButton(
                      closeOnActivate: widget.closeOnActivate,
                      onPressed: () => widget.onPick('File1'),
                      child: const Text('File1'),
                    ),
                    MenuItemButton(
                      closeOnActivate: widget.closeOnActivate,
                      onPressed: () => widget.onPick('File2'),
                      child: const Text('File2'),
                    ),
                    MenuItemButton(
                      closeOnActivate: widget.closeOnActivate,
                      onPressed: () => widget.onPick('File3'),
                      child: const Text('File3'),
                    ),
                  ],
                  child: const Text('Recent'),
                ),
                MenuItemButton(
                  closeOnActivate: widget.closeOnActivate,
                  onPressed: () => widget.onPick('New'),
                  child: const Text('New...'),
                ),
                MenuItemButton(
                  closeOnActivate: widget.closeOnActivate,
                  onPressed: () => widget.onPick('Close'),
                  child: const Text('Close window'),
                ),
              ],
              builder: (context, controller, child) {
                return OutlinedButton.icon(
                  icon: const Icon(Icons.folder_open),
                  label: Text('File menu (${widget.title})'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: widget.accent,
                    side: BorderSide(color: widget.accent),
                  ),
                  onPressed: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 5 helper: a tiny key/value row used in the "live state" sidebar of
// the toggle-state recipe. Renders a bool with a coloured dot.
// ---------------------------------------------------------------------------
Widget _kv(String label, bool value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: value ? const Color(0xFFEF6C00) : Colors.black26,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 13),
        ),
        const Spacer(),
        Text(
          value ? 'on' : 'off',
          style: TextStyle(
            fontSize: 13,
            color: value ? const Color(0xFFEF6C00) : Colors.black45,
            fontWeight: value ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 6 helper: an anchor button that owns its own MenuAnchor. Only the
// closeOnActivate flag of items varies between instances - this widget is
// effectively the canonical implementation of the comparison.
// ---------------------------------------------------------------------------
class _ComparisonAnchor extends StatefulWidget {
  const _ComparisonAnchor({
    required this.title,
    required this.description,
    required this.accent,
    required this.closeOnActivate,
    required this.onPick,
  });

  final String title;
  final String description;
  final Color accent;
  final bool closeOnActivate;
  final ValueChanged<String> onPick;

  @override
  State<_ComparisonAnchor> createState() => _ComparisonAnchorState();
}

class _ComparisonAnchorState extends State<_ComparisonAnchor> {
  final MenuController _controller = MenuController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Column(
        children: [
          MenuAnchor(
            controller: _controller,
            menuChildren: [
              MenuItemButton(
                closeOnActivate: widget.closeOnActivate,
                onPressed: () => widget.onPick('Save'),
                child: const Text('Save'),
              ),
              MenuItemButton(
                closeOnActivate: widget.closeOnActivate,
                onPressed: () => widget.onPick('Save As...'),
                child: const Text('Save As...'),
              ),
              MenuItemButton(
                closeOnActivate: widget.closeOnActivate,
                onPressed: () => widget.onPick('Close'),
                child: const Text('Close'),
              ),
            ],
            builder: (context, controller, child) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.accent,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                child: Text(widget.title),
              );
            },
          ),
          const SizedBox(height: 10),
          Text(
            widget.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 7 helpers: header and data rows for the reference table.
// ---------------------------------------------------------------------------
class _RefHeaderRow extends StatelessWidget {
  const _RefHeaderRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFCFD8DC),
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(10)),
      ),
      padding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: const [
          SizedBox(
            width: 80,
            child: Text(
              'Value',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            width: 60,
            child: Text(
              'Index',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              'Default',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: Text(
              'When to use',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class _RefDataRow extends StatelessWidget {
  const _RefDataRow({required this.value});

  final DropdownMenuCloseBehavior value;

  String get _whenToUse {
    switch (value) {
      case DropdownMenuCloseBehavior.all:
        return 'Classic dropdown - pick one value, dismiss the menu.';
      case DropdownMenuCloseBehavior.self:
        return 'Composite UIs where sibling menus must stay open.';
      case DropdownMenuCloseBehavior.none:
        return 'Toggle palettes; rapid sequential activations.';
    }
  }

  bool get _isDefault => value == DropdownMenuCloseBehavior.all;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black12),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '.${value.name}',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 60,
            child: Text(
              '${value.index}',
              style: const TextStyle(fontFamily: 'monospace'),
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              _isDefault ? 'yes' : 'no',
              style: TextStyle(
                color: _isDefault
                    ? const Color(0xFF2E7D32)
                    : Colors.black45,
                fontWeight:
                    _isDefault ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            child: Text(_whenToUse),
          ),
        ],
      ),
    );
  }
}

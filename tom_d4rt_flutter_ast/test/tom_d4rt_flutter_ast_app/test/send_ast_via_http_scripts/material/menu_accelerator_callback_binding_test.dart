// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Live demo gallery for MenuAcceleratorCallbackBinding.
// MenuAcceleratorCallbackBinding is the InheritedWidget that MenuAcceleratorLabel
// installs around the activation closure of a menu entry. A custom label
// builder reads it with MenuAcceleratorCallbackBinding.maybeOf(context) so
// that pressing the underlined letter (e.g. 'F' in '&File') invokes the
// matching MenuItemButton.onPressed without re-implementing the menu plumbing.
//
// This file walks through nine distinct sections that exercise the binding
// from every public angle: a hero card, a live MenuBar, a MenuAcceleratorLabel
// vs Text comparison, a custom builder, a state log, a localised mini-menu,
// disabled state, a custom consumer of the binding, and a parameter
// reference card.

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ===========================================================================
  // GLOBAL STATE - shared across the gallery
  // ---------------------------------------------------------------------------
  // The activity log records every menu activation that happened during this
  // demo, regardless of whether the activation came from a click, a keyboard
  // accelerator, or a custom binding consumer. The ValueNotifier feeds a
  // ValueListenableBuilder so chips re-render on each push.
  // ===========================================================================
  final ValueNotifier<List<String>> activityLog =
      ValueNotifier<List<String>>(<String>[]);

  void logEntry(String entry) {
    activityLog.value = <String>[...activityLog.value, entry];
    print('[activity] $entry');
  }

  // ===========================================================================
  // PALETTE - distinct colour per section
  // ---------------------------------------------------------------------------
  // Each section sets a unique background tint to make the visual segmentation
  // immediate. We use Material's standard palette swatches.
  // ===========================================================================
  const Color heroBg = Color(0xFFFFF3E0);
  const Color barBg = Color(0xFFE3F2FD);
  const Color compareBg = Color(0xFFF3E5F5);
  const Color builderBg = Color(0xFFE0F7FA);
  const Color logBg = Color(0xFFFFFDE7);
  const Color i18nBg = Color(0xFFE8F5E9);
  const Color disabledBg = Color(0xFFFFEBEE);
  const Color consumerBg = Color(0xFFEDE7F6);
  const Color refBg = Color(0xFFECEFF1);

  print('=== MenuAcceleratorCallbackBinding Live Gallery ===');
  print('  9 sections, distinct palettes, real MenuBar/SubmenuButton widgets');

  // ===========================================================================
  // SECTION 1 - HERO CARD
  // ---------------------------------------------------------------------------
  // Prose introduction explaining the role of MenuAcceleratorCallbackBinding.
  // The binding is an InheritedWidget that MenuAcceleratorLabel inserts around
  // every accelerator letter so a custom label builder can grab the matching
  // onPressed closure via maybeOf. The Alt-key prefix pattern means users hold
  // Alt to reveal underlines, then press the underlined letter to fire onPressed.
  // ===========================================================================
  Widget buildHero() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: heroBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFB8C00), width: 2),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'MenuAcceleratorCallbackBinding',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'The inherited binding behind every underlined menu letter',
            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
          ),
          SizedBox(height: 16),
          Text(
            'WHAT it is',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'MenuAcceleratorCallbackBinding is the InheritedWidget that '
            'MenuAcceleratorLabel installs around its accelerator-aware label '
            'tree. It carries two facts: the activation callback for the '
            'enclosing menu entry (i.e. MenuItemButton.onPressed) and a flag '
            'that says whether the menu is currently in "accelerator-display" '
            'mode (typically while Alt is held).',
          ),
          SizedBox(height: 12),
          Text(
            'WHY menus need it',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'A menu accelerator is a single letter inside a label that, when '
            'pressed (often with Alt), should invoke the same callback that '
            'clicking the menu entry would. The label widget is rendered '
            'separately from the button, so it needs a side-channel to find '
            'the right onPressed. That side-channel is the binding.',
          ),
          SizedBox(height: 12),
          Text(
            'WHO installs and reads it',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'INSTALLED by MenuItemButton/SubmenuButton when they wrap their '
            'child in a MenuAcceleratorLabel. READ by the label builder via '
            'MenuAcceleratorCallbackBinding.maybeOf(context); the default '
            'builder uses it to underline the accelerator letter and to wire '
            'the keyboard shortcut.',
          ),
          SizedBox(height: 12),
          Text(
            'THE Alt-key prefix pattern',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'Mark the accelerator letter with a single ampersand: &File means '
            'F is the accelerator. Use && to render a literal ampersand. The '
            'underline is shown only while accelerators are active (Alt held), '
            'matching the long-standing Windows menu convention. Linux GTK '
            'menus use the same prefix.',
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 2 - LIVE MENUBAR
  // ---------------------------------------------------------------------------
  // A real MenuBar with File / Edit / View / Help, each top-level entry uses a
  // MenuAcceleratorLabel with an &-prefix. Submenus expose &New, &Open, &Save
  // (File), &Cut, &Copy, &Paste (Edit), &Zoom In, &Zoom Out (View), and
  // &About (Help). Every onPressed pushes an entry into the shared activity
  // log so users can see which accelerator fired.
  // ===========================================================================
  Widget buildLiveMenuBar() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: barBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1565C0), width: 2),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Section 2 — Live MenuBar with Accelerator Labels',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            'Hold Alt to reveal underlines; press the highlighted letter to '
            'invoke the matching menu item.',
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 12),
          MenuBar(
            children: <Widget>[
              SubmenuButton(
                menuChildren: <Widget>[
                  MenuItemButton(
                    onPressed: () => logEntry('File → New'),
                    child: const MenuAcceleratorLabel('&New'),
                  ),
                  MenuItemButton(
                    onPressed: () => logEntry('File → Open'),
                    child: const MenuAcceleratorLabel('&Open…'),
                  ),
                  MenuItemButton(
                    onPressed: () => logEntry('File → Save'),
                    child: const MenuAcceleratorLabel('&Save'),
                  ),
                  MenuItemButton(
                    onPressed: () => logEntry('File → Save As'),
                    child: const MenuAcceleratorLabel('Save &As…'),
                  ),
                  MenuItemButton(
                    onPressed: () => logEntry('File → Quit'),
                    child: const MenuAcceleratorLabel('&Quit'),
                  ),
                ],
                child: const MenuAcceleratorLabel('&File'),
              ),
              SubmenuButton(
                menuChildren: <Widget>[
                  MenuItemButton(
                    onPressed: () => logEntry('Edit → Cut'),
                    child: const MenuAcceleratorLabel('Cu&t'),
                  ),
                  MenuItemButton(
                    onPressed: () => logEntry('Edit → Copy'),
                    child: const MenuAcceleratorLabel('&Copy'),
                  ),
                  MenuItemButton(
                    onPressed: () => logEntry('Edit → Paste'),
                    child: const MenuAcceleratorLabel('&Paste'),
                  ),
                  MenuItemButton(
                    onPressed: () => logEntry('Edit → Find'),
                    child: const MenuAcceleratorLabel('&Find…'),
                  ),
                ],
                child: const MenuAcceleratorLabel('&Edit'),
              ),
              SubmenuButton(
                menuChildren: <Widget>[
                  MenuItemButton(
                    onPressed: () => logEntry('View → Zoom In'),
                    child: const MenuAcceleratorLabel('Zoom &In'),
                  ),
                  MenuItemButton(
                    onPressed: () => logEntry('View → Zoom Out'),
                    child: const MenuAcceleratorLabel('Zoom &Out'),
                  ),
                  MenuItemButton(
                    onPressed: () => logEntry('View → Reset'),
                    child: const MenuAcceleratorLabel('&Reset Zoom'),
                  ),
                ],
                child: const MenuAcceleratorLabel('&View'),
              ),
              SubmenuButton(
                menuChildren: <Widget>[
                  MenuItemButton(
                    onPressed: () => logEntry('Help → About'),
                    child: const MenuAcceleratorLabel('&About'),
                  ),
                  MenuItemButton(
                    onPressed: () => logEntry('Help → Docs'),
                    child: const MenuAcceleratorLabel('&Documentation'),
                  ),
                ],
                child: const MenuAcceleratorLabel('&Help'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Each MenuAcceleratorLabel above installs a '
            'MenuAcceleratorCallbackBinding around its label tree, exposing '
            'the matching onPressed and the active-flag to any descendant '
            'that reads the inherited widget.',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 3 - MENUACCELERATORLABEL VS PLAIN TEXT
  // ---------------------------------------------------------------------------
  // Two parallel MenuBars rendered side-by-side. The left bar uses
  // MenuAcceleratorLabel; the right bar uses Text with the literal &-prefix
  // visible. This makes the underline difference and the "&" stripping
  // behaviour obvious. Activation hooks log "(accel)" or "(plain)" so the
  // log distinguishes the two sources.
  // ===========================================================================
  Widget buildAcceleratorVsPlain() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: compareBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF6A1B9A), width: 2),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Section 3 — MenuAcceleratorLabel vs plain Text',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'WITH MenuAcceleratorLabel',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    MenuBar(
                      children: <Widget>[
                        SubmenuButton(
                          menuChildren: <Widget>[
                            MenuItemButton(
                              onPressed: () => logEntry('(accel) File → New'),
                              child: const MenuAcceleratorLabel('&New'),
                            ),
                            MenuItemButton(
                              onPressed: () => logEntry('(accel) File → Save'),
                              child: const MenuAcceleratorLabel('&Save'),
                            ),
                          ],
                          child: const MenuAcceleratorLabel('&File'),
                        ),
                        SubmenuButton(
                          menuChildren: <Widget>[
                            MenuItemButton(
                              onPressed: () => logEntry('(accel) Edit → Copy'),
                              child: const MenuAcceleratorLabel('&Copy'),
                            ),
                          ],
                          child: const MenuAcceleratorLabel('&Edit'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'The "&" is stripped and the next letter underlined when '
                      'accelerators are active.',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'WITH plain Text (no accelerator)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    MenuBar(
                      children: <Widget>[
                        SubmenuButton(
                          menuChildren: <Widget>[
                            MenuItemButton(
                              onPressed: () => logEntry('(plain) File → New'),
                              child: const Text('&New'),
                            ),
                            MenuItemButton(
                              onPressed: () => logEntry('(plain) File → Save'),
                              child: const Text('&Save'),
                            ),
                          ],
                          child: const Text('&File'),
                        ),
                        SubmenuButton(
                          menuChildren: <Widget>[
                            MenuItemButton(
                              onPressed: () => logEntry('(plain) Edit → Copy'),
                              child: const Text('&Copy'),
                            ),
                          ],
                          child: const Text('&Edit'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'The literal "&" is rendered; no underline; no '
                      'MenuAcceleratorCallbackBinding installed.',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'The Shortcuts/Actions pair below would normally toggle the '
            'accelerator-display flag while Alt is held. We wrap the sections '
            'in a Shortcuts widget so the keyboard handling matches a real '
            'desktop menu.',
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 8),
          Actions(
            actions: <Type, Action<Intent>>{
              ActivateIntent: CallbackAction<ActivateIntent>(
                onInvoke: (Intent intent) {
                  logEntry('(plain) Alt pressed — accelerators visible');
                  return null;
                },
              ),
            },
            child: const SizedBox(height: 0),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 4 - CUSTOM BUILDER DEMO
  // ---------------------------------------------------------------------------
  // MenuAcceleratorLabel exposes a public `builder` parameter that receives
  // the accelerator index and the label string with the "&" already stripped.
  // We render the same '&Quit' label twice: once with the default underline,
  // once with a custom builder that decorates the accelerator with a star
  // glyph and a tomato colour so the customisation is impossible to miss.
  // ===========================================================================
  Widget buildCustomBuilderDemo() {
    Widget defaultLabel() => const MenuAcceleratorLabel('&Quit');

    Widget customLabel() => MenuAcceleratorLabel(
          '&Quit',
          builder: (BuildContext ctx, String label, int idx) {
            // The builder receives the cleaned label and the index of the
            // accelerator letter (or -1 if none). We split the label into
            // before / accelerator / after segments and decorate the middle
            // segment with our custom style.
            if (idx < 0) {
              return Text(label);
            }
            final String before = label.substring(0, idx);
            final String accel = label.substring(idx, idx + 1);
            final String after = label.substring(idx + 1);
            return Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  TextSpan(text: before),
                  TextSpan(
                    text: '\u2605',
                    style: const TextStyle(
                      color: Color(0xFFE53935),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: accel,
                    style: const TextStyle(
                      color: Color(0xFFE53935),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(text: after),
                ],
              ),
            );
          },
        );

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: builderBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF00838F), width: 2),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Section 4 — Custom builder for MenuAcceleratorLabel',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'The `builder` parameter takes (BuildContext, String label, int '
            'index) and lets you completely re-render the label.',
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Default builder',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    MenuBar(
                      children: <Widget>[
                        SubmenuButton(
                          menuChildren: <Widget>[
                            MenuItemButton(
                              onPressed: () => logEntry('(default) Quit'),
                              child: defaultLabel(),
                            ),
                          ],
                          child: const MenuAcceleratorLabel('&App'),
                        ),
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
                    const Text(
                      'Custom builder (star + red)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    MenuBar(
                      children: <Widget>[
                        SubmenuButton(
                          menuChildren: <Widget>[
                            MenuItemButton(
                              onPressed: () => logEntry('(custom) Quit'),
                              child: customLabel(),
                            ),
                          ],
                          child: const MenuAcceleratorLabel('&App'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Both submenus contain a MenuItemButton with onPressed wired to '
            'the activity log. Pressing either menu entry pushes a "(default) '
            'Quit" or "(custom) Quit" log entry, so the custom rendering '
            'still talks to the same MenuAcceleratorCallbackBinding.',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 5 - ACTIVATION STATE LOG
  // ---------------------------------------------------------------------------
  // ValueListenableBuilder rebuilds when activityLog changes. We render the
  // log as a Wrap of Chip widgets so it grows naturally. A "Clear" button at
  // the top right resets the log.
  // ===========================================================================
  Widget buildActivityLog() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: logBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF9A825), width: 2),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Section 5 — Activation log',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  activityLog.value = <String>[];
                  print('[activity] cleared');
                },
                child: const Text('Clear'),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Each MenuItemButton.onPressed pushes a row into the log. The log '
            'distinguishes click and accelerator activations because both end '
            'up calling the same closure that the binding exposes.',
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 12),
          ValueListenableBuilder<List<String>>(
            valueListenable: activityLog,
            builder: (BuildContext ctx, List<String> entries, Widget? _) {
              if (entries.isEmpty) {
                return const Text(
                  '(no activations yet — interact with the menus above)',
                  style: TextStyle(fontStyle: FontStyle.italic),
                );
              }
              return Wrap(
                spacing: 6,
                runSpacing: 6,
                children: <Widget>[
                  for (int i = 0; i < entries.length; i++)
                    Chip(
                      avatar: CircleAvatar(
                        backgroundColor: const Color(0xFFF9A825),
                        child: Text(
                          '${i + 1}',
                          style: const TextStyle(
                              fontSize: 11, color: Colors.white),
                        ),
                      ),
                      label: Text(entries[i]),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 6 - INTERNATIONALISED MINI-MENUS
  // ---------------------------------------------------------------------------
  // The accelerator letter follows the "&" prefix regardless of language. We
  // render three mini-menus side-by-side with German, French, and Spanish
  // labels so users can see that the underline lands on whatever letter
  // follows the ampersand.
  // ===========================================================================
  Widget buildI18nMenus() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: i18nBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2E7D32), width: 2),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Section 6 — Localised mini-menus',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            'The accelerator letter is whatever follows the "&" prefix; it is '
            'not bound to "F" — it follows the localised label.',
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('Deutsch',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    MenuBar(
                      children: <Widget>[
                        SubmenuButton(
                          menuChildren: <Widget>[
                            MenuItemButton(
                              onPressed: () => logEntry('Datei → Neu'),
                              child: const MenuAcceleratorLabel('&Neu'),
                            ),
                            MenuItemButton(
                              onPressed: () =>
                                  logEntry('Datei → Speichern'),
                              child:
                                  const MenuAcceleratorLabel('&Speichern'),
                            ),
                          ],
                          child: const MenuAcceleratorLabel('&Datei'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('Français',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    MenuBar(
                      children: <Widget>[
                        SubmenuButton(
                          menuChildren: <Widget>[
                            MenuItemButton(
                              onPressed: () => logEntry('Fichier → Nouveau'),
                              child: const MenuAcceleratorLabel('&Nouveau'),
                            ),
                            MenuItemButton(
                              onPressed: () =>
                                  logEntry('Fichier → Enregistrer'),
                              child: const MenuAcceleratorLabel(
                                  '&Enregistrer'),
                            ),
                          ],
                          child: const MenuAcceleratorLabel('&Fichier'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('Español',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    MenuBar(
                      children: <Widget>[
                        SubmenuButton(
                          menuChildren: <Widget>[
                            MenuItemButton(
                              onPressed: () => logEntry('Archivo → Nuevo'),
                              child: const MenuAcceleratorLabel('&Nuevo'),
                            ),
                            MenuItemButton(
                              onPressed: () => logEntry('Archivo → Guardar'),
                              child: const MenuAcceleratorLabel('&Guardar'),
                            ),
                          ],
                          child: const MenuAcceleratorLabel('&Archivo'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'In all three languages the binding is installed against the same '
            'onPressed; only the displayed underline shifts to follow the '
            'localised first letter (D, F, A respectively).',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 7 - DISABLED STATE
  // ---------------------------------------------------------------------------
  // When MenuItemButton.onPressed is null, the button is disabled, and
  // MenuAcceleratorCallbackBinding.maybeOf(context) returns null because no
  // activation callback is registered. The default builder still strips the
  // ampersand but does not emit an underline because nothing can be activated.
  // ===========================================================================
  Widget buildDisabledState() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: disabledBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC62828), width: 2),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Section 7 — Disabled MenuItemButton',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            'When onPressed is null the binding has no callback to publish; '
            'maybeOf returns null and the underline is suppressed.',
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 12),
          MenuBar(
            children: <Widget>[
              SubmenuButton(
                menuChildren: <Widget>[
                  // Active entry: binding has a callback.
                  MenuItemButton(
                    onPressed: () => logEntry('File → Save (enabled)'),
                    child: const MenuAcceleratorLabel('&Save'),
                  ),
                  // Disabled entry: onPressed is null, so binding.callback==null.
                  const MenuItemButton(
                    onPressed: null,
                    child: MenuAcceleratorLabel('&Save (disabled)'),
                  ),
                  // Disabled entry rendered with our custom builder so users
                  // can see that the builder still receives the index but the
                  // wrapping button is dimmed.
                  MenuItemButton(
                    onPressed: null,
                    child: MenuAcceleratorLabel(
                      '&Print (disabled)',
                      builder: (BuildContext ctx, String label, int idx) {
                        return Text(
                          label,
                          style: const TextStyle(color: Colors.grey),
                        );
                      },
                    ),
                  ),
                ],
                child: const MenuAcceleratorLabel('&File'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'The disabled rows are still wrapped in MenuAcceleratorLabel, but '
            'because no callback is in scope the binding cannot wire the '
            'shortcut. This mirrors how desktop menus grey out their '
            'underlines when an item is disabled.',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 8 - CUSTOM CONSUMER OF THE BINDING
  // ---------------------------------------------------------------------------
  // We define a tiny local-style helper that calls
  // MenuAcceleratorCallbackBinding.maybeOf(context). It renders a status card
  // showing whether a binding is in scope and, if so, whether the binding's
  // callback is non-null.
  //
  // We render the helper twice:
  //   (a) as a child of a MenuItemButton using a builder, so the binding is
  //       installed and maybeOf returns a non-null instance;
  //   (b) outside any menu, so maybeOf returns null. This is the canonical
  //       teaching example for the binding.
  // ===========================================================================
  Widget buildBindingConsumer(BuildContext ctx) {
    final MenuAcceleratorCallbackBinding? binding =
        MenuAcceleratorCallbackBinding.maybeOf(ctx);
    final bool inScope = binding != null;
    final bool hasCallback = binding?.onInvoke != null;
    final Color tint = inScope
        ? (hasCallback ? const Color(0xFF7E57C2) : const Color(0xFFB39DDB))
        : const Color(0xFFBDBDBD);
    return Container(
      decoration: BoxDecoration(
        color: tint.withOpacity(0.18),
        border: Border.all(color: tint, width: 1.4),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            inScope
                ? (hasCallback ? Icons.check_circle : Icons.help_outline)
                : Icons.cancel,
            color: tint,
            size: 18,
          ),
          const SizedBox(width: 6),
          Text(
            inScope
                ? (hasCallback
                    ? 'binding present, callback set'
                    : 'binding present, callback null')
                : 'binding absent (maybeOf returned null)',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget buildConsumerSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: consumerBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF4527A0), width: 2),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Section 8 — Reading the binding from a custom consumer',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            'The consumer below calls MenuAcceleratorCallbackBinding.maybeOf '
            'and reports the binding state. Inside a menu it is non-null; '
            'outside, it is null.',
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 12),
          const Text('Inside a MenuItemButton (binding installed):',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          MenuBar(
            children: <Widget>[
              SubmenuButton(
                menuChildren: <Widget>[
                  MenuItemButton(
                    onPressed: () => logEntry('Probe → fired'),
                    child: MenuAcceleratorLabel(
                      '&Probe',
                      builder: (BuildContext ctx, String label, int idx) {
                        // Render the consumer next to the standard label so
                        // both pieces are visible inside the popup.
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(label),
                            const SizedBox(width: 8),
                            Builder(builder: buildBindingConsumer),
                          ],
                        );
                      },
                    ),
                  ),
                ],
                child: const MenuAcceleratorLabel('&Diagnostics'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Outside any menu (no binding):',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Builder(builder: buildBindingConsumer),
          const SizedBox(height: 12),
          const Text(
            'The consumer is implementation-private to MenuAcceleratorLabel '
            'in real apps; this section just exposes it so we can read the '
            'binding visually. The same call (maybeOf) is what custom label '
            'builders use to wire their underline rendering.',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION 9 - REFERENCE CARD
  // ---------------------------------------------------------------------------
  // Reference table for MenuAcceleratorLabel parameters and
  // MenuAcceleratorCallbackBinding members. One-liner each.
  // ===========================================================================
  Widget buildReferenceCard() {
    Widget refRow(String name, String description) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 220,
              child: Text(
                name,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(description)),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: refBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF455A64), width: 2),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Section 9 — Reference card',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'MenuAcceleratorLabel parameters',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          refRow('label',
              'String with at most one "&"-prefixed letter; "&&" renders a literal "&".'),
          refRow('builder',
              'Optional MenuAcceleratorChildBuilder (BuildContext, String, int) used to render the label.'),
          const SizedBox(height: 12),
          const Text(
            'MenuAcceleratorLabel static helpers',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          refRow('stripAcceleratorMarkers',
              'Strips "&"-prefix markers from a label, returning the plain string.'),
          const SizedBox(height: 12),
          const Text(
            'MenuAcceleratorCallbackBinding members',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          refRow('static maybeOf(BuildContext)',
              'Returns the nearest binding or null if none is installed.'),
          refRow('static of(BuildContext)',
              'Returns the nearest binding; throws if none is installed.'),
          refRow('onInvoke',
              'The activation callback (i.e. MenuItemButton.onPressed) or null if disabled.'),
          refRow('hasSubmenu',
              'True if the enclosing entry opens a submenu rather than firing onInvoke.'),
          refRow('accelerator',
              'The accelerator key index inside the label, or -1 if none.'),
          const SizedBox(height: 12),
          const Text(
            'When each member is read',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          refRow('maybeOf', 'inside MenuAcceleratorChildBuilder.'),
          refRow('onInvoke',
              'wired by the default builder to the keyboard activator.'),
          refRow('hasSubmenu',
              'used to suppress underline in submenu parent vs. leaf items.'),
          refRow('accelerator',
              'used by the default builder to position the underline.'),
        ],
      ),
    );
  }

  // ===========================================================================
  // ASSEMBLE THE GALLERY
  // ---------------------------------------------------------------------------
  // Wrap everything in MaterialApp → Scaffold → SafeArea → SingleChildScrollView
  // → Column. Each section is separated by a SizedBox(height: 16).
  // ===========================================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'MenuAcceleratorCallbackBinding gallery',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: const Color(0xFF6A1B9A)),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('MenuAcceleratorCallbackBinding gallery'),
        backgroundColor: const Color(0xFFEDE7F6),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHero(),
              const SizedBox(height: 16),
              buildLiveMenuBar(),
              const SizedBox(height: 16),
              buildAcceleratorVsPlain(),
              const SizedBox(height: 16),
              buildCustomBuilderDemo(),
              const SizedBox(height: 16),
              buildActivityLog(),
              const SizedBox(height: 16),
              buildI18nMenus(),
              const SizedBox(height: 16),
              buildDisabledState(),
              const SizedBox(height: 16),
              buildConsumerSection(),
              const SizedBox(height: 16),
              buildReferenceCard(),
              const SizedBox(height: 24),
              const Center(
                child: Text(
                  'End of gallery — 9 sections covering '
                  'MenuAcceleratorCallbackBinding from prose to reference.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    ),
  );
}

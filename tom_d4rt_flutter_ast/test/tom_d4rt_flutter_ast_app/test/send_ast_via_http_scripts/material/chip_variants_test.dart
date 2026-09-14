// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element
//
// D4rt deep visual demo: Material Chip family.
//
// Subjects on display:
//   Chip, ActionChip, FilterChip, ChoiceChip, InputChip, RawChip, ChipThemeData.
//
// The build() function returns a single scrollable Material surface composed of
// twelve numbered sections. Each section is a self-contained widget cluster
// that either explains, demonstrates, or compares chips. Helper builders keep
// repetition out of the source while every call site passes meaningfully
// different inputs.

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette and typography helpers.
// ---------------------------------------------------------------------------

const Color _kInk = Color(0xFF1B1F23);
const Color _kInkSoft = Color(0xFF4A5358);
const Color _kInkMute = Color(0xFF8A9097);
const Color _kPaper = Color(0xFFF7F8FA);
const Color _kCard = Color(0xFFFFFFFF);
const Color _kDivider = Color(0xFFE3E6EA);
const Color _kAccent = Color(0xFF2563EB);
const Color _kAccentSoft = Color(0xFFDBEAFE);
const Color _kWarn = Color(0xFFB45309);
const Color _kGood = Color(0xFF166534);
const Color _kBad = Color(0xFFB91C1C);

TextStyle _h1() => const TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w800,
      color: _kInk,
      height: 1.2,
    );

TextStyle _h2() => const TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w700,
      color: _kInk,
      height: 1.25,
    );

TextStyle _h3() => const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: _kInk,
      letterSpacing: 0.2,
    );

TextStyle _body() => const TextStyle(
      fontSize: 13.0,
      color: _kInkSoft,
      height: 1.45,
    );

TextStyle _mono() => const TextStyle(
      fontSize: 12.0,
      fontFamily: 'monospace',
      color: _kInk,
      height: 1.4,
    );

TextStyle _label() => const TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.w700,
      color: _kInkMute,
      letterSpacing: 0.6,
    );

// ---------------------------------------------------------------------------
// Layout helpers.
// ---------------------------------------------------------------------------

Widget _sectionHeader(int n, String title, String subtitle) {
  return Padding(
    padding: const EdgeInsets.only(top: 24.0, bottom: 12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 30.0,
              height: 30.0,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: _kAccent,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$n',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 14.0,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(child: Text(title, style: _h1())),
          ],
        ),
        const SizedBox(height: 6.0),
        Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: Text(subtitle, style: _body()),
        ),
        const SizedBox(height: 8.0),
        Container(height: 1.0, color: _kDivider),
      ],
    ),
  );
}

Widget _card({required Widget child, EdgeInsetsGeometry? padding}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: padding ?? const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _kCard,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kDivider),
    ),
    child: child,
  );
}

Widget _kbd(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
    decoration: BoxDecoration(
      color: const Color(0xFFEFF1F4),
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: _kDivider),
    ),
    child: Text(text, style: _mono()),
  );
}

Widget _pill(String text, Color bg, Color fg) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: fg,
        fontSize: 11.0,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

// ===========================================================================
// SECTION 1 — Dossier cards
// ===========================================================================

Widget _buildDossier({
  required String name,
  required String tagline,
  required List<String> useWhen,
  required List<String> avoidWhen,
  required List<MapEntry<String, String>> keyProps,
  required Widget preview,
  required Color accent,
}) {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 6.0,
              height: 28.0,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(child: Text(name, style: _h2())),
            preview,
          ],
        ),
        const SizedBox(height: 8.0),
        Text(tagline, style: _body()),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _bulletList('USE WHEN', useWhen, _kGood),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: _bulletList('AVOID WHEN', avoidWhen, _kBad),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Text('KEY PROPS', style: _label()),
        const SizedBox(height: 6.0),
        ...keyProps.map(_buildKeyPropRow),
      ],
    ),
  );
}

Widget _bulletList(String header, List<String> items, Color dot) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(header, style: _label()),
      const SizedBox(height: 4.0),
      ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 6.0, right: 6.0),
                  width: 6.0,
                  height: 6.0,
                  decoration: BoxDecoration(
                    color: dot,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(child: Text(item, style: _body())),
              ],
            ),
          )),
    ],
  );
}

Widget _buildKeyPropRow(MapEntry<String, String> entry) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 140.0, child: _kbd(entry.key)),
        const SizedBox(width: 8.0),
        Expanded(child: Text(entry.value, style: _body())),
      ],
    ),
  );
}

Widget _section1Dossiers() {
  return Column(
    children: [
      _buildDossier(
        name: 'Chip',
        tagline:
            'The base visual element. Compact, non-interactive by default; add gestures via wrappers or use a specialized subclass.',
        useWhen: const [
          'You only need to display a tag or label',
          'You compose chips inside read-only contexts',
          'You want a uniform Material baseline shape',
        ],
        avoidWhen: const [
          'You need a press or selection callback',
          'You need built-in delete behavior beyond an icon slot',
        ],
        keyProps: const [
          MapEntry('label', 'Primary text content (required).'),
          MapEntry('avatar', 'Leading widget — usually CircleAvatar or Icon.'),
          MapEntry('deleteIcon', 'Trailing icon shown when onDeleted set.'),
          MapEntry('shape', 'Outline geometry; defaults to StadiumBorder.'),
        ],
        preview: const Chip(
          label: Text('Chip'),
          avatar: CircleAvatar(child: Text('C', style: TextStyle(fontSize: 10.0))),
        ),
        accent: _kAccent,
      ),
      _buildDossier(
        name: 'ActionChip',
        tagline:
            'A chip-shaped button. Tapping triggers an action; it never holds selection state.',
        useWhen: const [
          'You expose a quick action inline with content',
          'You suggest a follow-up tap target near text',
          'You need an inline alternative to a TextButton',
        ],
        avoidWhen: const [
          'The action is destructive or primary — use a real Button',
          'You need toggleable selection — use FilterChip',
        ],
        keyProps: const [
          MapEntry('onPressed', 'Required tap callback; null disables.'),
          MapEntry('avatar', 'Leading icon hint at the action verb.'),
          MapEntry('pressElevation', 'Lift while pressed (default 8.0).'),
          MapEntry('tooltip', 'Optional hover/long-press text.'),
        ],
        preview: ActionChip(
          avatar: const Icon(Icons.flash_on, size: 16.0),
          label: const Text('Run'),
          onPressed: () {},
        ),
        accent: const Color(0xFFF59E0B),
      ),
      _buildDossier(
        name: 'FilterChip',
        tagline:
            'Multi-select toggle. Often used in groups so users narrow a list by combining several active chips.',
        useWhen: const [
          'You filter a list across independent dimensions',
          'Multiple options can be simultaneously active',
          'Selection state must be obvious at a glance',
        ],
        avoidWhen: const [
          'Selection must be mutually exclusive — use ChoiceChip',
          'The state really represents a single primary action',
        ],
        keyProps: const [
          MapEntry('selected', 'Boolean drives selectedColor + checkmark.'),
          MapEntry('onSelected', 'Required (bool) callback.'),
          MapEntry('showCheckmark', 'Controls leading checkmark glyph.'),
          MapEntry('selectedColor', 'Background when selected == true.'),
        ],
        preview: FilterChip(
          label: const Text('Tag'),
          selected: true,
          onSelected: (_) {},
        ),
        accent: const Color(0xFF10B981),
      ),
      _buildDossier(
        name: 'ChoiceChip',
        tagline:
            'Single-select toggle. Inside a Wrap or Row, exactly one chip should be selected at a time.',
        useWhen: const [
          'You replace a dense RadioListTile group',
          'Only one option is valid simultaneously',
          'Compact horizontal layout matters',
        ],
        avoidWhen: const [
          'Multiple selections are allowed — use FilterChip',
          'You need to delete entries — use InputChip',
        ],
        keyProps: const [
          MapEntry('selected', 'Boolean per chip; parent enforces uniqueness.'),
          MapEntry('onSelected', 'Notifies parent to update the group.'),
          MapEntry('selectedColor', 'Background when active.'),
          MapEntry('disabledColor', 'Background when onSelected null.'),
        ],
        preview: ChoiceChip(
          label: const Text('One'),
          selected: true,
          onSelected: (_) {},
        ),
        accent: const Color(0xFF8B5CF6),
      ),
      _buildDossier(
        name: 'InputChip',
        tagline:
            'Represents a discrete piece of user input — a recipient, a tag, a selected file. Combines press, select and delete.',
        useWhen: const [
          'You display user-entered tokens in a TextField-like row',
          'Each item must be individually removable',
          'You want to mix selection plus deletion',
        ],
        avoidWhen: const [
          'No deletion is allowed — use Chip',
          'Items are non-interactive',
        ],
        keyProps: const [
          MapEntry('onPressed', 'Whole-chip tap callback.'),
          MapEntry('onDeleted', 'Tap callback for the trailing icon.'),
          MapEntry('isEnabled', 'Coarse enable/disable switch.'),
          MapEntry('selected', 'Optional selection state.'),
        ],
        preview: InputChip(
          avatar: const CircleAvatar(
              backgroundColor: _kAccentSoft,
              child: Text('A', style: TextStyle(fontSize: 10.0))),
          label: const Text('Alice'),
          onDeleted: () {},
        ),
        accent: const Color(0xFFEF4444),
      ),
      _buildDossier(
        name: 'RawChip',
        tagline:
            'The shared implementation behind the others. Reach for it when you need an unusual combination of features.',
        useWhen: const [
          'You need custom mixes of select + delete + press',
          'You build a domain-specific chip subclass',
          'A higher-level variant nearly fits but blocks one knob',
        ],
        avoidWhen: const [
          'A higher-level variant already fits — prefer that for clarity',
        ],
        keyProps: const [
          MapEntry('onPressed', 'Optional tap callback.'),
          MapEntry('onSelected', 'Optional selection callback.'),
          MapEntry('onDeleted', 'Optional deletion callback.'),
          MapEntry('isEnabled', 'Disables press + select interactions.'),
        ],
        preview: RawChip(
          label: const Text('Raw'),
          avatar: const Icon(Icons.code, size: 16.0),
          onPressed: () {},
        ),
        accent: const Color(0xFF0EA5E9),
      ),
    ],
  );
}

// ===========================================================================
// SECTION 2 — Anatomy & API tables
// ===========================================================================

Widget _buildAnatomyRow(List<String> cells, {bool header = false}) {
  return Container(
    decoration: BoxDecoration(
      color: header ? const Color(0xFFEFF3F8) : Colors.white,
      border: const Border(
        bottom: BorderSide(color: _kDivider),
      ),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < cells.length; i++)
          Expanded(
            flex: i == 0 ? 3 : 2,
            child: Text(
              cells[i],
              style: header
                  ? _label()
                  : (i == 0 ? _mono() : _body()),
            ),
          ),
      ],
    ),
  );
}

Widget _section2Anatomy() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _card(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            _buildAnatomyRow(
              const ['CLASS', 'EXTENDS / FAMILY', 'INTERACTIVE?', 'SELECTABLE?'],
              header: true,
            ),
            _buildAnatomyRow(const ['Chip', 'StatelessWidget', 'No (by default)', 'No']),
            _buildAnatomyRow(const ['RawChip', 'StatefulWidget', 'Optional', 'Optional']),
            _buildAnatomyRow(const ['ActionChip', 'wraps RawChip', 'Yes (onPressed)', 'No']),
            _buildAnatomyRow(const ['FilterChip', 'wraps RawChip', 'Yes (onSelected)', 'Yes — multi']),
            _buildAnatomyRow(const ['ChoiceChip', 'wraps RawChip', 'Yes (onSelected)', 'Yes — single']),
            _buildAnatomyRow(const ['InputChip', 'wraps RawChip', 'Yes (onPressed / onDeleted)', 'Optional']),
          ],
        ),
      ),
      const SizedBox(height: 8.0),
      Text('SHARED API SURFACE', style: _label()),
      const SizedBox(height: 6.0),
      _card(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            _buildAnatomyRow(
              const ['PROPERTY', 'TYPE', 'PURPOSE'],
              header: true,
            ),
            _buildAnatomyRow(const ['label', 'Widget', 'The main content slot, usually Text.']),
            _buildAnatomyRow(const ['avatar', 'Widget?', 'Leading slot. CircleAvatar, Icon, image, etc.']),
            _buildAnatomyRow(const ['deleteIcon', 'Widget?', 'Trailing slot rendered only when onDeleted is provided.']),
            _buildAnatomyRow(const ['onPressed', 'VoidCallback?', 'Tap callback (ActionChip / InputChip / RawChip).']),
            _buildAnatomyRow(const ['onSelected', 'ValueChanged<bool>?', 'Selection callback (Filter/Choice/Input/Raw).']),
            _buildAnatomyRow(const ['onDeleted', 'VoidCallback?', 'Delete-icon callback (Input/Raw).']),
            _buildAnatomyRow(const ['selected', 'bool', 'Whether the chip is currently selected.']),
            _buildAnatomyRow(const ['selectedColor', 'Color?', 'Background colour when selected.']),
            _buildAnatomyRow(const ['disabledColor', 'Color?', 'Background colour when callbacks are null.']),
            _buildAnatomyRow(const ['elevation', 'double?', 'Resting Z elevation.']),
            _buildAnatomyRow(const ['pressElevation', 'double?', 'Z elevation while the chip is pressed.']),
            _buildAnatomyRow(const ['shape', 'OutlinedBorder?', 'Outline shape; default StadiumBorder.']),
            _buildAnatomyRow(const ['side', 'BorderSide?', 'Override border colour / width.']),
            _buildAnatomyRow(const ['padding', 'EdgeInsetsGeometry?', 'Inner padding around label.']),
            _buildAnatomyRow(const ['labelPadding', 'EdgeInsetsGeometry?', 'Padding around the label widget only.']),
            _buildAnatomyRow(const ['materialTapTargetSize', 'MaterialTapTargetSize?', 'shrinkWrap or padded hit target.']),
            _buildAnatomyRow(const ['visualDensity', 'VisualDensity?', 'Adjust compactness per platform.']),
            _buildAnatomyRow(const ['showCheckmark', 'bool?', 'Filter/Choice only; toggles leading check.']),
            _buildAnatomyRow(const ['checkmarkColor', 'Color?', 'Tint of the leading check glyph.']),
          ],
        ),
      ),
    ],
  );
}

// ===========================================================================
// SECTION 3 — Live gallery
// ===========================================================================

Widget _buildGalleryColumn(String title, List<Widget> chips) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: _kPaper,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: _h3()),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: chips,
          ),
        ],
      ),
    ),
  );
}

Widget _section3Gallery() {
  final List<Widget> chipPlain = [
    const Chip(label: Text('Default')),
    Chip(
      label: const Text('With avatar'),
      avatar: CircleAvatar(
        backgroundColor: _kAccentSoft,
        child: const Text('A', style: TextStyle(fontSize: 11.0)),
      ),
    ),
    const Chip(
      label: Text('Iconed'),
      avatar: Icon(Icons.label, size: 16.0),
    ),
    Chip(
      label: const Text('With border'),
      side: const BorderSide(color: _kAccent, width: 1.2),
    ),
    const Chip(
      label: Text('Disabled-look'),
      backgroundColor: Color(0xFFEDEFF2),
    ),
  ];

  final List<Widget> actionChips = [
    ActionChip(
      avatar: const Icon(Icons.play_arrow, size: 16.0),
      label: const Text('Run task'),
      onPressed: () {},
    ),
    ActionChip(
      avatar: const Icon(Icons.refresh, size: 16.0),
      label: const Text('Refresh'),
      onPressed: () {},
      pressElevation: 6.0,
      elevation: 1.0,
    ),
    const ActionChip(
      avatar: Icon(Icons.block, size: 16.0),
      label: Text('Disabled'),
      onPressed: null,
    ),
    ActionChip(
      avatar: const Icon(Icons.cloud_upload, size: 16.0),
      label: const Text('Upload'),
      onPressed: () {},
      backgroundColor: const Color(0xFFFFF7E6),
    ),
  ];

  final List<Widget> filterChips = [
    FilterChip(
      label: const Text('Books'),
      selected: true,
      onSelected: (_) {},
      selectedColor: _kAccentSoft,
      checkmarkColor: _kAccent,
    ),
    FilterChip(
      label: const Text('Films'),
      selected: false,
      onSelected: (_) {},
    ),
    FilterChip(
      label: const Text('Music'),
      selected: true,
      onSelected: (_) {},
      avatar: const Icon(Icons.music_note, size: 16.0),
    ),
    const FilterChip(
      label: Text('Disabled'),
      selected: false,
      onSelected: null,
    ),
    FilterChip(
      label: const Text('No check'),
      selected: true,
      onSelected: (_) {},
      showCheckmark: false,
    ),
  ];

  final List<Widget> choiceChips = [
    ChoiceChip(
      label: const Text('Daily'),
      selected: true,
      onSelected: (_) {},
      selectedColor: const Color(0xFFE0E7FF),
    ),
    ChoiceChip(
      label: const Text('Weekly'),
      selected: false,
      onSelected: (_) {},
    ),
    ChoiceChip(
      label: const Text('Monthly'),
      selected: false,
      onSelected: (_) {},
    ),
    const ChoiceChip(
      label: Text('Yearly'),
      selected: false,
      onSelected: null,
    ),
  ];

  final List<Widget> inputChips = [
    InputChip(
      avatar: const CircleAvatar(
        backgroundColor: Color(0xFFFEE2E2),
        child: Text('B', style: TextStyle(fontSize: 11.0)),
      ),
      label: const Text('Bob'),
      onDeleted: () {},
    ),
    InputChip(
      label: const Text('Selected token'),
      selected: true,
      onPressed: () {},
      onDeleted: () {},
      selectedColor: const Color(0xFFDCFCE7),
    ),
    const InputChip(
      label: Text('Disabled token'),
      isEnabled: false,
    ),
    InputChip(
      label: const Text('Custom delete'),
      onDeleted: () {},
      deleteIcon: const Icon(Icons.highlight_off, size: 18.0),
      deleteIconColor: _kBad,
    ),
  ];

  final List<Widget> rawChips = [
    RawChip(
      label: const Text('Raw + pressed'),
      onPressed: () {},
      pressElevation: 4.0,
    ),
    RawChip(
      label: const Text('Raw + select'),
      selected: true,
      onSelected: (_) {},
      selectedColor: const Color(0xFFFDE68A),
    ),
    RawChip(
      label: const Text('Raw + delete'),
      onDeleted: () {},
    ),
    // RawChip's chip.dart line 1027 asserts that
    // `onSelected == null || onPressed == null`. Demo this variant
    // with only onSelected wired (Filter/Choice/InputChip use this
    // selection-callback path) so the assertion holds.
    RawChip(
      label: const Text('Raw all-in-one'),
      onSelected: (_) {},
      onDeleted: () {},
      selected: false,
    ),
  ];

  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGalleryColumn('Chip', chipPlain),
          _buildGalleryColumn('ActionChip', actionChips),
        ],
      ),
      const SizedBox(height: 8.0),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGalleryColumn('FilterChip', filterChips),
          _buildGalleryColumn('ChoiceChip', choiceChips),
        ],
      ),
      const SizedBox(height: 8.0),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGalleryColumn('InputChip', inputChips),
          _buildGalleryColumn('RawChip', rawChips),
        ],
      ),
    ],
  );
}

// ===========================================================================
// SECTION 4 — Stateful selection demonstrations
// ===========================================================================

Widget _section4Stateful() {
  final List<String> tagPool = const [
    'design',
    'flutter',
    'state',
    'theme',
    'a11y',
    'router',
    'forms',
    'i18n',
  ];

  final Widget filterDemo = StatefulBuilder(
    builder: (context, setState) {
      final Set<String> active = <String>{'flutter', 'theme'};
      return _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.tune, size: 18.0, color: _kAccent),
                const SizedBox(width: 8.0),
                Text('FilterChip — multi-select tag picker', style: _h3()),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              'Each chip toggles independently. Selection state survives rebuilds through the surrounding StatefulBuilder.',
              style: _body(),
            ),
            const SizedBox(height: 12.0),
            Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children: [
                for (final String tag in tagPool)
                  FilterChip(
                    label: Text(tag),
                    selected: active.contains(tag),
                    onSelected: (bool value) {
                      setState(() {
                        if (value) {
                          active.add(tag);
                        } else {
                          active.remove(tag);
                        }
                      });
                    },
                    selectedColor: _kAccentSoft,
                    checkmarkColor: _kAccent,
                  ),
              ],
            ),
            const SizedBox(height: 10.0),
            Text(
              'Active: ${active.isEmpty ? "—" : active.join(", ")}',
              style: _mono(),
            ),
          ],
        ),
      );
    },
  );

  final Widget choiceDemo = StatefulBuilder(
    builder: (context, setState) {
      String picked = 'standard';
      final List<MapEntry<String, IconData>> modes = const [
        MapEntry('compact', Icons.density_small),
        MapEntry('standard', Icons.density_medium),
        MapEntry('comfortable', Icons.density_large),
      ];
      return _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.radio_button_checked, size: 18.0, color: Color(0xFF8B5CF6)),
                const SizedBox(width: 8.0),
                Text('ChoiceChip — single-select density', style: _h3()),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              'Exactly one option active at a time. Parent state holds the selected key.',
              style: _body(),
            ),
            const SizedBox(height: 12.0),
            Wrap(
              spacing: 8.0,
              children: [
                for (final entry in modes)
                  ChoiceChip(
                    avatar: Icon(entry.value, size: 16.0),
                    label: Text(entry.key),
                    selected: picked == entry.key,
                    onSelected: (bool value) {
                      if (value) {
                        setState(() => picked = entry.key);
                      }
                    },
                    selectedColor: const Color(0xFFEDE9FE),
                  ),
              ],
            ),
            const SizedBox(height: 10.0),
            Text('Current density: $picked', style: _mono()),
          ],
        ),
      );
    },
  );

  final Widget inputDemo = StatefulBuilder(
    builder: (context, setState) {
      final List<String> recipients = <String>['alice@x', 'bob@y', 'carol@z'];
      return _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.alternate_email, size: 18.0, color: _kBad),
                const SizedBox(width: 8.0),
                Text('InputChip — removable email recipients', style: _h3()),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              'Press a chip to focus; tap the trailing cross to remove. The local list is rebuilt after each delete.',
              style: _body(),
            ),
            const SizedBox(height: 12.0),
            Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children: [
                for (final String email in List<String>.from(recipients))
                  InputChip(
                    avatar: CircleAvatar(
                      backgroundColor: const Color(0xFFFEE2E2),
                      child: Text(
                        email.substring(0, 1).toUpperCase(),
                        style: const TextStyle(fontSize: 11.0),
                      ),
                    ),
                    label: Text(email),
                    onPressed: () {},
                    onDeleted: () {
                      setState(() => recipients.remove(email));
                    },
                  ),
                ActionChip(
                  avatar: const Icon(Icons.add, size: 16.0),
                  label: const Text('add'),
                  onPressed: () {
                    setState(() => recipients.add('new@host'));
                  },
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Text('Count: ${recipients.length}', style: _mono()),
          ],
        ),
      );
    },
  );

  return Column(children: [filterDemo, choiceDemo, inputDemo]);
}

// ===========================================================================
// SECTION 5 — ChipThemeData exploration
// ===========================================================================

Widget _themedCluster(String title, ChipThemeData theme, Color accent) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10.0,
                height: 10.0,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6.0),
              Text(title, style: _h3()),
            ],
          ),
          const SizedBox(height: 10.0),
          ChipTheme(
            data: theme,
            child: Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children: [
                const Chip(label: Text('Default')),
                FilterChip(
                  label: const Text('Filter'),
                  selected: true,
                  onSelected: (_) {},
                ),
                ChoiceChip(
                  label: const Text('Choice'),
                  selected: false,
                  onSelected: (_) {},
                ),
                ActionChip(
                  label: const Text('Action'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Text('elevation: ${theme.elevation}', style: _mono()),
          Text('pressElevation: ${theme.pressElevation}', style: _mono()),
          Text('shape: ${theme.shape.runtimeType}', style: _mono()),
        ],
      ),
    ),
  );
}

Widget _section5Theme() {
  final ChipThemeData calm = ChipThemeData(
    backgroundColor: const Color(0xFFEEF2F7),
    selectedColor: const Color(0xFFC7D2FE),
    disabledColor: const Color(0xFFE5E7EB),
    secondarySelectedColor: const Color(0xFFA5B4FC),
    labelStyle: const TextStyle(fontSize: 13.0, color: _kInk),
    secondaryLabelStyle: const TextStyle(fontSize: 13.0, color: _kInk),
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    shape: const StadiumBorder(),
    side: const BorderSide(color: Color(0xFFCBD5E1)),
    brightness: Brightness.light,
    elevation: 0.0,
    pressElevation: 2.0,
    checkmarkColor: _kInk,
    showCheckmark: true,
  );

  final ChipThemeData vivid = ChipThemeData(
    backgroundColor: const Color(0xFFFFE4E6),
    selectedColor: const Color(0xFFFB7185),
    disabledColor: const Color(0xFFFEE2E2),
    secondarySelectedColor: const Color(0xFFE11D48),
    labelStyle: const TextStyle(fontSize: 13.0, color: _kInk, fontWeight: FontWeight.w700),
    secondaryLabelStyle: const TextStyle(fontSize: 13.0, color: Colors.white),
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
    side: const BorderSide(color: Color(0xFFFB7185)),
    brightness: Brightness.light,
    elevation: 1.0,
    pressElevation: 6.0,
    checkmarkColor: Colors.white,
    showCheckmark: true,
  );

  final ChipThemeData mono = ChipThemeData(
    backgroundColor: const Color(0xFF1F2937),
    selectedColor: const Color(0xFF374151),
    disabledColor: const Color(0xFF111827),
    secondarySelectedColor: const Color(0xFF6B7280),
    labelStyle: const TextStyle(fontSize: 13.0, color: Colors.white),
    secondaryLabelStyle: const TextStyle(fontSize: 13.0, color: Colors.white),
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
    side: const BorderSide(color: Color(0xFF4B5563)),
    brightness: Brightness.dark,
    elevation: 2.0,
    pressElevation: 4.0,
    checkmarkColor: Colors.white,
    showCheckmark: false,
  );

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _themedCluster('Calm', calm, _kAccent),
      _themedCluster('Vivid', vivid, const Color(0xFFE11D48)),
      _themedCluster('Mono', mono, _kInk),
    ],
  );
}

// ===========================================================================
// SECTION 6 — Avatars vs no-avatar
// ===========================================================================

Widget _avatarColumn(String header, List<Widget> rows) {
  return Expanded(
    child: _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(header, style: _h3()),
          const SizedBox(height: 8.0),
          Wrap(spacing: 6.0, runSpacing: 6.0, children: rows),
        ],
      ),
    ),
  );
}

Widget _section6Avatars() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _avatarColumn('No avatar', const [
        Chip(label: Text('Plain')),
        Chip(label: Text('Compact')),
        Chip(label: Text('Numeric — 42')),
      ]),
      _avatarColumn('CircleAvatar', [
        Chip(
          avatar: const CircleAvatar(
            backgroundColor: _kAccentSoft,
            child: Text('A', style: TextStyle(fontSize: 11.0)),
          ),
          label: const Text('Alice'),
        ),
        Chip(
          avatar: const CircleAvatar(
            backgroundColor: Color(0xFFFEE2E2),
            child: Text('B', style: TextStyle(fontSize: 11.0)),
          ),
          label: const Text('Bob'),
        ),
        Chip(
          avatar: const CircleAvatar(
            backgroundColor: Color(0xFFDCFCE7),
            child: Text('C', style: TextStyle(fontSize: 11.0)),
          ),
          label: const Text('Carol'),
        ),
      ]),
      _avatarColumn('Icon avatar', [
        Chip(
          avatar: const Icon(Icons.bolt, size: 16.0, color: Color(0xFFB45309)),
          label: const Text('Energy'),
        ),
        Chip(
          avatar: const Icon(Icons.shield, size: 16.0, color: _kGood),
          label: const Text('Secure'),
        ),
        Chip(
          avatar: const Icon(Icons.warning_amber, size: 16.0, color: _kBad),
          label: const Text('Risk'),
        ),
      ]),
    ],
  );
}

// ===========================================================================
// SECTION 7 — Delete-icon behavior
// ===========================================================================

Widget _section7Delete() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Trailing delete-icon variants', style: _h3()),
        const SizedBox(height: 6.0),
        Text(
          'Delete affordance only appears when onDeleted is provided. The icon, its colour, and the tooltip on the icon are all configurable.',
          style: _body(),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            InputChip(
              label: const Text('Default cross'),
              onDeleted: () {},
            ),
            InputChip(
              label: const Text('Cancel'),
              onDeleted: () {},
              deleteIcon: const Icon(Icons.cancel, size: 18.0),
              deleteIconColor: _kBad,
            ),
            InputChip(
              label: const Text('Highlight off'),
              onDeleted: () {},
              deleteIcon: const Icon(Icons.highlight_off, size: 18.0),
              deleteIconColor: _kWarn,
            ),
            InputChip(
              label: const Text('Trash'),
              onDeleted: () {},
              deleteIcon: const Icon(Icons.delete_outline, size: 18.0),
              deleteIconColor: _kInkMute,
            ),
            InputChip(
              label: const Text('Custom tip'),
              onDeleted: () {},
              deleteIcon: const Icon(Icons.close, size: 18.0),
              deleteButtonTooltipMessage: 'Detach',
            ),
            FilterChip(
              label: const Text('Filter + delete'),
              selected: true,
              onSelected: (_) {},
              onDeleted: () {},
              showCheckmark: false,
            ),
            RawChip(
              label: const Text('Raw delete'),
              onDeleted: () {},
              deleteIcon: const Icon(Icons.remove_circle_outline, size: 18.0),
              deleteIconColor: _kAccent,
            ),
          ],
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 8 — Shapes & borders
// ===========================================================================

Widget _shapeColumn(String name, OutlinedBorder shape, BorderSide side) {
  return Expanded(
    child: _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: _h3()),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: [
              Chip(
                label: const Text('Plain'),
                shape: shape,
                side: side,
              ),
              FilterChip(
                label: const Text('Filter'),
                selected: true,
                onSelected: (_) {},
                shape: shape,
                side: side,
              ),
              ActionChip(
                label: const Text('Action'),
                onPressed: () {},
                shape: shape,
                side: side,
              ),
              InputChip(
                label: const Text('Input'),
                onDeleted: () {},
                shape: shape,
                side: side,
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(shape.runtimeType.toString(), style: _mono()),
        ],
      ),
    ),
  );
}

Widget _section8Shapes() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _shapeColumn(
        'StadiumBorder',
        const StadiumBorder(),
        const BorderSide(color: _kDivider),
      ),
      _shapeColumn(
        'RoundedRectangle 8',
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        const BorderSide(color: _kAccent, width: 1.2),
      ),
      _shapeColumn(
        'BeveledRectangle 4',
        BeveledRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        const BorderSide(color: Color(0xFFB45309), width: 1.5),
      ),
    ],
  );
}

// ===========================================================================
// SECTION 9 — Recipe cards
// ===========================================================================

Widget _buildRecipeCard({
  required String title,
  required String summary,
  required List<String> steps,
  required Widget preview,
}) {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.menu_book, size: 16.0, color: _kAccent),
            const SizedBox(width: 6.0),
            Expanded(child: Text(title, style: _h3())),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(summary, style: _body()),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: _kPaper,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: preview,
        ),
        const SizedBox(height: 10.0),
        Text('STEPS', style: _label()),
        const SizedBox(height: 4.0),
        for (int i = 0; i < steps.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${i + 1}. ', style: _mono()),
                Expanded(child: Text(steps[i], style: _body())),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _section9Recipes() {
  final Widget skillsPreview = Wrap(
    spacing: 6.0,
    runSpacing: 6.0,
    children: const [
      Chip(label: Text('Dart')),
      Chip(label: Text('Flutter')),
      Chip(label: Text('Material')),
      Chip(label: Text('Riverpod')),
    ],
  );

  final Widget filterPreview = Wrap(
    spacing: 6.0,
    children: [
      FilterChip(label: const Text('Free'), selected: true, onSelected: (_) {}),
      FilterChip(label: const Text('Paid'), selected: false, onSelected: (_) {}),
      FilterChip(label: const Text('New'), selected: true, onSelected: (_) {}),
    ],
  );

  final Widget statusPreview = Wrap(
    spacing: 6.0,
    children: [
      Chip(
        avatar: const Icon(Icons.check_circle, size: 14.0, color: _kGood),
        label: const Text('Passing'),
        backgroundColor: const Color(0xFFDCFCE7),
      ),
      Chip(
        avatar: const Icon(Icons.error, size: 14.0, color: _kBad),
        label: const Text('Failing'),
        backgroundColor: const Color(0xFFFEE2E2),
      ),
      Chip(
        avatar: const Icon(Icons.schedule, size: 14.0, color: _kWarn),
        label: const Text('Pending'),
        backgroundColor: const Color(0xFFFEF3C7),
      ),
    ],
  );

  final Widget recipientsPreview = Wrap(
    spacing: 6.0,
    runSpacing: 6.0,
    children: [
      InputChip(
        avatar: const CircleAvatar(
          backgroundColor: _kAccentSoft,
          child: Text('a', style: TextStyle(fontSize: 11.0)),
        ),
        label: const Text('alex@x'),
        onDeleted: () {},
      ),
      InputChip(
        avatar: const CircleAvatar(
          backgroundColor: Color(0xFFFEE2E2),
          child: Text('b', style: TextStyle(fontSize: 11.0)),
        ),
        label: const Text('beth@y'),
        onDeleted: () {},
      ),
    ],
  );

  final Widget categoriesPreview = Wrap(
    spacing: 6.0,
    children: [
      ChoiceChip(label: const Text('All'), selected: false, onSelected: (_) {}),
      ChoiceChip(label: const Text('Books'), selected: true, onSelected: (_) {}),
      ChoiceChip(label: const Text('Films'), selected: false, onSelected: (_) {}),
    ],
  );

  final Widget modeSwitchPreview = Wrap(
    spacing: 6.0,
    children: [
      ChoiceChip(
        avatar: const Icon(Icons.light_mode, size: 16.0),
        label: const Text('Light'),
        selected: true,
        onSelected: (_) {},
      ),
      ChoiceChip(
        avatar: const Icon(Icons.dark_mode, size: 16.0),
        label: const Text('Dark'),
        selected: false,
        onSelected: (_) {},
      ),
      ChoiceChip(
        avatar: const Icon(Icons.brightness_auto, size: 16.0),
        label: const Text('System'),
        selected: false,
        onSelected: (_) {},
      ),
    ],
  );

  final Widget removablePreview = Wrap(
    spacing: 6.0,
    runSpacing: 6.0,
    children: [
      InputChip(
        avatar: const Icon(Icons.label, size: 14.0),
        label: const Text('price > 100'),
        onDeleted: () {},
      ),
      InputChip(
        avatar: const Icon(Icons.label, size: 14.0),
        label: const Text('in_stock'),
        onDeleted: () {},
      ),
      InputChip(
        avatar: const Icon(Icons.label, size: 14.0),
        label: const Text('rating>=4'),
        onDeleted: () {},
      ),
    ],
  );

  return Column(
    children: [
      _buildRecipeCard(
        title: 'Skill tags on a profile card',
        summary: 'Read-only labels describing capabilities. No interaction needed.',
        steps: const [
          'Wrap a list of strings in Wrap.',
          'Build a plain Chip per entry.',
          'Optionally add an avatar for category emphasis.',
        ],
        preview: skillsPreview,
      ),
      _buildRecipeCard(
        title: 'Filter pills above a list',
        summary: 'Multi-select FilterChips that narrow a backing query.',
        steps: const [
          'Hold a Set<String> of active filters.',
          'For each option emit a FilterChip with selected: set.contains(option).',
          'In onSelected, mutate the set and rebuild.',
        ],
        preview: filterPreview,
      ),
      _buildRecipeCard(
        title: 'Status badges',
        summary: 'Non-interactive Chips with semantic icons and tinted backgrounds.',
        steps: const [
          'Map status enum to (icon, color, text).',
          'Set backgroundColor on a Chip; never wire onPressed.',
          'Make sure the colour palette is accessible.',
        ],
        preview: statusPreview,
      ),
      _buildRecipeCard(
        title: 'Email recipient tokens',
        summary: 'Each token is an InputChip with onDeleted; tap removes it from the list.',
        steps: const [
          'Render the list of String tokens inside a Wrap.',
          'For each token, emit an InputChip with avatar + onDeleted.',
          'In onDeleted, remove the token from state and setState.',
        ],
        preview: recipientsPreview,
      ),
      _buildRecipeCard(
        title: 'Category selector',
        summary: 'Mutually exclusive selection with ChoiceChip.',
        steps: const [
          'Hold the selected category in state.',
          'For each category emit a ChoiceChip with selected: state == category.',
          'In onSelected, write state = category when value is true.',
        ],
        preview: categoriesPreview,
      ),
      _buildRecipeCard(
        title: 'Theme-mode switcher',
        summary: 'Three ChoiceChips replacing a SegmentedControl-style picker.',
        steps: const [
          'Use a Wrap with three ChoiceChips.',
          'Pass an icon in avatar to reinforce meaning.',
          'Hook onSelected to your ThemeMode notifier.',
        ],
        preview: modeSwitchPreview,
      ),
      _buildRecipeCard(
        title: 'Removable applied filters',
        summary: 'Show every active filter as an InputChip with a delete cross.',
        steps: const [
          'Derive a list of human-readable filter clauses.',
          'For each clause render an InputChip with onDeleted.',
          'In onDeleted, remove the clause and re-run the query.',
        ],
        preview: removablePreview,
      ),
    ],
  );
}

// ===========================================================================
// SECTION 10 — Comparison table
// ===========================================================================

Widget _buildComparisonRow(List<String> cells, {bool header = false}) {
  return Container(
    decoration: BoxDecoration(
      color: header ? const Color(0xFFEFF3F8) : Colors.white,
      border: const Border(bottom: BorderSide(color: _kDivider)),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < cells.length; i++)
          Expanded(
            flex: i == 0 ? 3 : 2,
            child: Text(
              cells[i],
              style: header
                  ? _label()
                  : (i == 0 ? _h3() : _body()),
            ),
          ),
      ],
    ),
  );
}

Widget _section10Comparison() {
  return _card(
    padding: const EdgeInsets.all(0.0),
    child: Column(
      children: [
        _buildComparisonRow(
          const ['VARIANT', 'PRESS', 'SELECT', 'DELETE', 'TYPICAL USE'],
          header: true,
        ),
        _buildComparisonRow(const ['Chip', '—', '—', '—', 'Read-only tag, badge.']),
        _buildComparisonRow(const ['ActionChip', 'yes', '—', '—', 'Inline action button.']),
        _buildComparisonRow(const ['FilterChip', 'via onSelected', 'multi', '—', 'Filter a list.']),
        _buildComparisonRow(const ['ChoiceChip', 'via onSelected', 'single', '—', 'Pick one of N.']),
        _buildComparisonRow(const ['InputChip', 'yes', 'optional', 'yes', 'Removable tokens.']),
        _buildComparisonRow(const ['RawChip', 'optional', 'optional', 'optional', 'Custom hybrid.']),
        _buildComparisonRow(const ['TextButton', 'yes', '—', '—', 'Standalone command.']),
        _buildComparisonRow(const ['ToggleButton', 'yes', 'manual', '—', 'Group toggle bar.']),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 11 — Glossary
// ===========================================================================

Widget _glossaryRow(String term, String definition) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 170.0, child: _kbd(term)),
        const SizedBox(width: 10.0),
        Expanded(child: Text(definition, style: _body())),
      ],
    ),
  );
}

Widget _section11Glossary() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Glossary', style: _h2()),
        const SizedBox(height: 6.0),
        _glossaryRow('avatar slot', 'Leading widget in a chip — typically CircleAvatar or Icon.'),
        _glossaryRow('label slot', 'Main content of the chip; almost always a Text widget.'),
        _glossaryRow('delete affordance', 'Trailing icon revealed only when onDeleted is wired.'),
        _glossaryRow('press elevation', 'Z-elevation while the chip is being pressed.'),
        _glossaryRow('checkmark', 'Leading glyph indicating Filter/Choice selection state.'),
        _glossaryRow('isEnabled', 'Coarse switch on InputChip / RawChip that disables all callbacks.'),
        _glossaryRow('ChipThemeData', 'Inherited bundle of defaults applied to all chips below it.'),
        _glossaryRow('selectedColor', 'Background applied when selected == true.'),
        _glossaryRow('disabledColor', 'Background applied when interaction callbacks are null.'),
        _glossaryRow('shape', 'OutlinedBorder controlling the chip outline; default StadiumBorder.'),
        _glossaryRow('side', 'Explicit BorderSide overriding the shape default.'),
        _glossaryRow('visualDensity', 'Cross-platform compactness tuner inherited from Theme.'),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 12 — Final composed tree
// ===========================================================================

dynamic build(BuildContext context) {
  print('Chip variants deep demo executing');

  // Build each section once so the returned widget tree is straightforward.
  final Widget section1 = _section1Dossiers();
  final Widget section2 = _section2Anatomy();
  final Widget section3 = _section3Gallery();
  final Widget section4 = _section4Stateful();
  final Widget section5 = _section5Theme();
  final Widget section6 = _section6Avatars();
  final Widget section7 = _section7Delete();
  final Widget section8 = _section8Shapes();
  final Widget section9 = _section9Recipes();
  final Widget section10 = _section10Comparison();
  final Widget section11 = _section11Glossary();

  // Compose a header card describing what the demo covers.
  final Widget header = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.style, size: 22.0, color: _kAccent),
            const SizedBox(width: 8.0),
            Text('Material Chip Family — Deep Visual Demo', style: _h1()),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          'A scrollable atlas of every Chip variant in flutter/material.dart. '
          'Every variant appears as a live widget alongside instructional cards, '
          'API tables, theme experiments, and seven practical recipes.',
          style: _body(),
        ),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: [
            _pill('Chip', _kAccentSoft, _kAccent),
            _pill('ActionChip', const Color(0xFFFEF3C7), _kWarn),
            _pill('FilterChip', const Color(0xFFDCFCE7), _kGood),
            _pill('ChoiceChip', const Color(0xFFEDE9FE), const Color(0xFF6D28D9)),
            _pill('InputChip', const Color(0xFFFEE2E2), _kBad),
            _pill('RawChip', const Color(0xFFE0F2FE), const Color(0xFF0369A1)),
            _pill('ChipThemeData', const Color(0xFFE5E7EB), _kInk),
          ],
        ),
      ],
    ),
  );

  final Widget footer = Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: Center(
      child: Text(
        'End of chip variants visual demo.',
        style: _label(),
      ),
    ),
  );

  print('Chip variants deep demo widget tree assembled');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Material(
      color: _kPaper,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header,
              _sectionHeader(
                1,
                'Dossier cards',
                'One card per chip variant: tagline, when to use, when to avoid, key props, and a live preview.',
              ),
              section1,
              _sectionHeader(
                2,
                'Anatomy & API tables',
                'Class hierarchy and the shared API surface every variant inherits from RawChip.',
              ),
              section2,
              _sectionHeader(
                3,
                'Live gallery',
                'Every variant rendered multiple times to show enabled, disabled, with and without avatars.',
              ),
              section3,
              _sectionHeader(
                4,
                'Stateful demonstrations',
                'Real toggling via StatefulBuilder — multi-select tags, single-select density, removable recipients.',
              ),
              section4,
              _sectionHeader(
                5,
                'ChipThemeData exploration',
                'Three side-by-side ChipTheme clusters drive the same set of chips through very different palettes.',
              ),
              section5,
              _sectionHeader(
                6,
                'Avatars vs no-avatar',
                'Same chip, three avatar strategies: none, CircleAvatar with initial, semantic Icon.',
              ),
              section6,
              _sectionHeader(
                7,
                'Delete-icon behavior',
                'How onDeleted / deleteIcon / deleteIconColor / deleteButtonTooltipMessage combine.',
              ),
              section7,
              _sectionHeader(
                8,
                'Shapes & borders',
                'Stadium, rounded rectangle and beveled rectangle — same chips under three OutlinedBorder shapes.',
              ),
              section8,
              _sectionHeader(
                9,
                'Recipe cards',
                'Seven practical patterns: skill tags, filter pills, status badges, recipients, categories, mode switch, removable filters.',
              ),
              section9,
              _sectionHeader(
                10,
                'Comparison table',
                'Variants and adjacent widgets compared on press, select, delete, and typical use.',
              ),
              section10,
              _sectionHeader(
                11,
                'Glossary',
                'Twelve terms you meet when working with chips.',
              ),
              section11,
              footer,
            ],
          ),
        ),
      ),
    ),
  );
}

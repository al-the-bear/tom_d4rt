// ignore_for_file: avoid_print, unused_local_variable
import 'package:flutter/material.dart';

// ============================================================================
// Palette - teal / navy / copper coherent palette used through the whole demo.
// ============================================================================
const Color _kInk = Color(0xFF0E2233);
const Color _kInkSoft = Color(0xFF3A4D60);
const Color _kPaper = Color(0xFFFBF8F2);
const Color _kPaperAlt = Color(0xFFF1ECDF);
const Color _kTeal = Color(0xFF1F8A8B);
const Color _kTealDeep = Color(0xFF0E5C5D);
const Color _kTealSoft = Color(0xFFD3ECEC);
const Color _kCopper = Color(0xFFB4632F);
const Color _kCopperSoft = Color(0xFFF3D9C5);
const Color _kRule = Color(0xFFCDC4AD);
const Color _kDisabled = Color(0xFF9AA4AC);

// ============================================================================
// Entry point - D4rt script form.
// ============================================================================
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'DropdownMenu Deep Dive',
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _kTeal,
      scaffoldBackgroundColor: _kPaper,
      fontFamily: 'Roboto',
    ),
    home: Scaffold(
      backgroundColor: _kPaper,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionHero(),
              _gap(),
              _sectionConcept(),
              _gap(),
              _sectionAnatomy(),
              _gap(),
              _sectionEntryProperties(),
              _gap(),
              _sectionWidthModes(),
              _gap(),
              _sectionLabelVariants(),
              _gap(),
              _sectionIconVariants(),
              _gap(),
              _sectionHintVariants(),
              _gap(),
              _sectionDecorationStyles(),
              _gap(),
              _sectionFakePopup(),
              _gap(),
              _sectionSelectionStates(),
              _gap(),
              _sectionRealWorldCatalog(),
              _gap(),
              _sectionComparisonTable(),
              _gap(),
              _sectionGlossary(),
              _gap(),
              _sectionEpilogue(),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    ),
  );
}

// ----------------------------------------------------------------------------
// Spacing helper.
// ----------------------------------------------------------------------------
Widget _gap() => const SizedBox(height: 40);

// ----------------------------------------------------------------------------
// Shared chrome - section card.
// ----------------------------------------------------------------------------
Widget _card({required String tag, required String title, required Widget child}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: _kRule),
      boxShadow: const [
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 22,
          offset: Offset(0, 6),
        ),
      ],
    ),
    padding: const EdgeInsets.fromLTRB(24, 22, 24, 26),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: _kTealSoft,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                tag,
                style: const TextStyle(
                  color: _kTealDeep,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.1,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: _kInk,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(height: 1, color: _kRule),
        const SizedBox(height: 16),
        child,
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Bullet row.
// ----------------------------------------------------------------------------
Widget _bullet(String head, String body) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 7, right: 12),
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: _kCopper,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: _kInkSoft, fontSize: 14, height: 1.45),
              children: [
                TextSpan(
                  text: '$head — ',
                  style: const TextStyle(
                    color: _kInk,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(text: body),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Caption paragraph.
// ----------------------------------------------------------------------------
Widget _caption(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      text,
      style: const TextStyle(
        color: _kInkSoft,
        fontSize: 14,
        height: 1.5,
      ),
    ),
  );
}

// ----------------------------------------------------------------------------
// Subhead.
// ----------------------------------------------------------------------------
Widget _subhead(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 6, bottom: 8),
    child: Text(
      text,
      style: const TextStyle(
        color: _kTealDeep,
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
      ),
    ),
  );
}

// ============================================================================
// SECTION 1 - HERO
// ============================================================================
Widget _sectionHero() {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_kInk, _kTealDeep],
      ),
      borderRadius: BorderRadius.circular(22),
      boxShadow: const [
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 24,
          offset: Offset(0, 8),
        ),
      ],
    ),
    padding: const EdgeInsets.fromLTRB(28, 30, 28, 32),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: _kCopper.withValues(alpha: 0.20),
                border: Border.all(color: _kCopper),
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                'WIDGET DEEP DIVE',
                style: TextStyle(
                  color: _kCopperSoft,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.3,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.arrow_drop_down_circle_outlined,
                color: _kCopperSoft, size: 22),
          ],
        ),
        const SizedBox(height: 18),
        const Text(
          'DropdownMenu',
          style: TextStyle(
            color: Colors.white,
            fontSize: 44,
            fontWeight: FontWeight.w800,
            height: 1.05,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Material 3 picker with searchable input',
          style: TextStyle(
            color: _kTealSoft,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 18),
        const SizedBox(
          width: 720,
          child: Text(
            'DropdownMenu pairs a text field with a popup list of '
            'DropdownMenuEntry items. Unlike the older DropdownButton, the '
            'menu is searchable, has a real input affordance, and uses the '
            'Material 3 menu surface. This visual reference walks every '
            'major property, from width modes to leading icons.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.55,
            ),
          ),
        ),
        const SizedBox(height: 22),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _heroChip('Material 3'),
            _heroChip('Searchable'),
            _heroChip('Generic<T>'),
            _heroChip('Form-friendly'),
            _heroChip('14 sections'),
          ],
        ),
      ],
    ),
  );
}

Widget _heroChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.08),
      border: Border.all(color: Colors.white24),
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// ============================================================================
// SECTION 2 - CONCEPT
// ============================================================================
Widget _sectionConcept() {
  return _card(
    tag: 'CONCEPT',
    title: 'What is DropdownMenu, really?',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _caption(
          'DropdownMenu<T> is a Material 3 picker introduced to replace the '
          'aging DropdownButton. It looks like a text field, opens to a list '
          'of menu entries, and supports keyboard typing to filter results.',
        ),
        _subhead('CORE PROPERTIES'),
        _bullet('dropdownMenuEntries',
            'required list of DropdownMenuEntry<T> describing each option.'),
        _bullet('initialSelection',
            'optional value pre-selected when the widget first renders.'),
        _bullet('onSelected',
            'callback fired when the user picks an entry.'),
        _bullet('label / hintText',
            'label widget shown above the field; hintText shown inside when '
            'empty.'),
        _bullet('leadingIcon / trailingIcon',
            'icons placed at the start / end of the text field.'),
        _bullet('selectedTrailingIcon',
            'optional trailing icon swapped in when the menu is open.'),
        _bullet('enableFilter / enableSearch',
            'filter narrows visible entries; search jumps the highlight as '
            'the user types.'),
        _bullet('width / expandedInsets',
            'fixed width, or insets to expand to the available width.'),
        _bullet('menuHeight',
            'maximum height of the popup before scrolling.'),
        _bullet('inputDecorationTheme',
            'shape the text field surface — outlined, filled, custom border.'),
        _bullet('menuStyle',
            'MenuStyle for the popup container (elevation, shape, colour).'),
        _bullet('textStyle',
            'TextStyle used for the field text and entries.'),
        _bullet('enabled',
            'whether the dropdown can be opened or selected from.'),
        const SizedBox(height: 10),
        _subhead('MENTAL MODEL'),
        _caption(
          'Think of DropdownMenu as a TextField that hosts a MenuAnchor. The '
          'text field gives you accessibility, focus management and '
          'typeahead; the anchor gives you the popup. The entries are not '
          'just labels — each entry has its own ButtonStyle.',
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 3 - ANATOMY
// ============================================================================
Widget _sectionAnatomy() {
  return _card(
    tag: 'ANATOMY',
    title: 'A labelled cross-section of the widget',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _caption(
          'The dropdown is made of two visible surfaces: the closed field, '
          'and the popup. Each surface is decorated independently.',
        ),
        const SizedBox(height: 8),
        _anatomyDiagram(),
        const SizedBox(height: 18),
        _subhead('PARTS LIST'),
        _bullet('1 · Label',
            'lives above the field, comes from `label:` parameter.'),
        _bullet('2 · Leading icon',
            'shown inside the field on the start side.'),
        _bullet('3 · Text input',
            'reads the label of the selected entry or hintText.'),
        _bullet('4 · Trailing icon',
            'usually a chevron; swaps when open.'),
        _bullet('5 · Popup surface',
            'M3 menu container, elevation 3 by default.'),
        _bullet('6 · Entry leading icon',
            'optional icon at the start of each entry row.'),
        _bullet('7 · Entry label',
            'the visible text — `label:` or `labelWidget:`.'),
        _bullet('8 · Entry trailing icon',
            'often used for shortcuts or selection ticks.'),
      ],
    ),
  );
}

Widget _anatomyDiagram() {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: _kPaperAlt,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _kRule),
    ),
    padding: const EdgeInsets.all(20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Country',
                  style: TextStyle(
                      color: _kInkSoft,
                      fontSize: 12,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              _anatomyField(),
              const SizedBox(height: 6),
              _anatomyPopup(),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _anatomyLeg('1', 'Label text'),
              _anatomyLeg('2', 'Leading icon (Icons.public)'),
              _anatomyLeg('3', 'Text input area'),
              _anatomyLeg('4', 'Trailing icon (chevron)'),
              _anatomyLeg('5', 'Popup surface'),
              _anatomyLeg('6', 'Entry leading icon'),
              _anatomyLeg('7', 'Entry label'),
              _anatomyLeg('8', 'Entry trailing icon'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyField() {
  return Container(
    height: 52,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: _kTeal, width: 1.4),
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Row(
      children: const [
        Icon(Icons.public, color: _kTealDeep, size: 20),
        SizedBox(width: 10),
        Text('Germany',
            style: TextStyle(
                color: _kInk, fontSize: 15, fontWeight: FontWeight.w500)),
        Spacer(),
        Icon(Icons.arrow_drop_down, color: _kInkSoft),
      ],
    ),
  );
}

Widget _anatomyPopup() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kRule),
      boxShadow: const [
        BoxShadow(
            color: Color(0x14000000), blurRadius: 8, offset: Offset(0, 3)),
      ],
    ),
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Column(
      children: [
        _fakeEntry('France', Icons.flag, selected: false),
        _fakeEntry('Germany', Icons.flag, selected: true),
        _fakeEntry('Greece', Icons.flag, selected: false),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Anatomy legend row.
// ----------------------------------------------------------------------------
Widget _anatomyLeg(String num, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 22,
          height: 22,
          alignment: Alignment.center,
          decoration:
              const BoxDecoration(color: _kCopper, shape: BoxShape.circle),
          child: Text(num,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style:
                  const TextStyle(color: _kInk, fontSize: 13, height: 1.4)),
        ),
      ],
    ),
  );
}

// ============================================================================
// FAKE ENTRY — visual stand-in for a popped-up menu row.
// ============================================================================
Widget _fakeEntry(String label, IconData icon,
    {bool selected = false,
    bool disabled = false,
    bool hover = false,
    IconData? trailing,
    Color? accent}) {
  final Color fg = disabled
      ? _kDisabled
      : (selected ? (accent ?? _kTealDeep) : _kInk);
  final Color bg = disabled
      ? Colors.transparent
      : (selected
          ? (accent ?? _kTeal).withValues(alpha: 0.12)
          : (hover ? _kPaperAlt : Colors.transparent));
  return Container(
    width: double.infinity,
    color: bg,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    child: Row(
      children: [
        Icon(icon, color: fg, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
                color: fg,
                fontSize: 14,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500),
          ),
        ),
        if (trailing != null) Icon(trailing, color: fg, size: 16),
      ],
    ),
  );
}

// ============================================================================
// SECTION 4 - DropdownMenuEntry properties
// ============================================================================
Widget _sectionEntryProperties() {
  final DropdownMenu<String> demo = DropdownMenu<String>(
    initialSelection: 'b',
    label: const Text('Animal'),
    leadingIcon: const Icon(Icons.pets),
    width: 280,
    dropdownMenuEntries: const <DropdownMenuEntry<String>>[
      DropdownMenuEntry<String>(
        value: 'a',
        label: 'Aardvark',
        leadingIcon: Icon(Icons.cruelty_free),
      ),
      DropdownMenuEntry<String>(
        value: 'b',
        label: 'Bumblebee',
        leadingIcon: Icon(Icons.emoji_nature),
        trailingIcon: Icon(Icons.star, color: _kCopper, size: 16),
      ),
      DropdownMenuEntry<String>(
        value: 'c',
        label: 'Capybara',
        leadingIcon: Icon(Icons.water),
      ),
      DropdownMenuEntry<String>(
        value: 'd',
        label: 'Donkey (off-duty)',
        leadingIcon: Icon(Icons.do_not_disturb_on),
        enabled: false,
      ),
    ],
  );

  return _card(
    tag: 'ENTRIES',
    title: 'DropdownMenuEntry — every knob',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _caption(
          'Each entry is its own widget descriptor. Despite the name it is '
          'not a Widget — it carries data, and the DropdownMenu builds the '
          'rows internally from MenuItemButtons.',
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            demo,
            const SizedBox(width: 28),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _bullet('value', 'the T value returned via onSelected.'),
                  _bullet('label',
                      'short string label displayed in the closed field.'),
                  _bullet('labelWidget',
                      'optional widget shown in the popup row instead of a '
                      'plain Text(label).'),
                  _bullet('leadingIcon',
                      'icon shown on the start side of the popup row.'),
                  _bullet('trailingIcon',
                      'icon shown on the end side — great for keyboard '
                      'shortcuts.'),
                  _bullet('enabled',
                      'whether the entry can be picked.'),
                  _bullet('style',
                      'a ButtonStyle for the row — colours, padding, shape.'),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 5 - Width modes
// ============================================================================
Widget _sectionWidthModes() {
  final DropdownMenu<String> fixed = DropdownMenu<String>(
    initialSelection: 'm',
    label: const Text('Size · fixed 220'),
    width: 220,
    dropdownMenuEntries: _sizeEntries(),
  );
  final DropdownMenu<String> wide = DropdownMenu<String>(
    initialSelection: 'l',
    label: const Text('Size · fixed 340'),
    width: 340,
    dropdownMenuEntries: _sizeEntries(),
  );
  final DropdownMenu<String> expanded = DropdownMenu<String>(
    initialSelection: 'xl',
    label: const Text('Size · expandedInsets'),
    expandedInsets: EdgeInsets.zero,
    dropdownMenuEntries: _sizeEntries(),
  );
  final DropdownMenu<String> intrinsic = DropdownMenu<String>(
    initialSelection: 's',
    label: const Text('Size · intrinsic'),
    dropdownMenuEntries: _sizeEntries(),
  );

  return _card(
    tag: 'WIDTH',
    title: 'Width modes — fixed, expanded, intrinsic',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _caption(
          'DropdownMenu has three width strategies. Pick one — they are '
          'mutually exclusive in practice.',
        ),
        _subhead('FIXED WIDTH'),
        Wrap(spacing: 18, runSpacing: 16, children: [fixed, wide]),
        const SizedBox(height: 18),
        _subhead('EXPANDED INSETS'),
        expanded,
        const SizedBox(height: 18),
        _subhead('INTRINSIC (NO WIDTH)'),
        intrinsic,
        const SizedBox(height: 8),
        _bullet('width:',
            'forces an exact pixel width regardless of content.'),
        _bullet('expandedInsets:',
            'fills the parent constraints minus the given EdgeInsets.'),
        _bullet('neither:',
            'sized to the longest entry label.'),
      ],
    ),
  );
}

List<DropdownMenuEntry<String>> _sizeEntries() {
  return const <DropdownMenuEntry<String>>[
    DropdownMenuEntry<String>(value: 's', label: 'Small'),
    DropdownMenuEntry<String>(value: 'm', label: 'Medium'),
    DropdownMenuEntry<String>(value: 'l', label: 'Large'),
    DropdownMenuEntry<String>(value: 'xl', label: 'Extra Large'),
  ];
}

// ============================================================================
// SECTION 6 - Label variants
// ============================================================================
Widget _sectionLabelVariants() {
  final DropdownMenu<String> labelled = DropdownMenu<String>(
    initialSelection: 'one',
    label: const Text('With label'),
    width: 260,
    dropdownMenuEntries: _numEntries(),
  );
  final DropdownMenu<String> unlabelled = DropdownMenu<String>(
    initialSelection: 'one',
    hintText: 'No label · hint only',
    width: 260,
    dropdownMenuEntries: _numEntries(),
  );
  final DropdownMenu<String> richLabel = DropdownMenu<String>(
    initialSelection: 'two',
    width: 260,
    label: Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.info_outline, color: _kTealDeep, size: 16),
        SizedBox(width: 6),
        Text('Rich label widget'),
      ],
    ),
    dropdownMenuEntries: _numEntries(),
  );

  return _card(
    tag: 'LABEL',
    title: 'Labelled, unlabelled, rich',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _caption(
          'label: takes a Widget — so beyond plain Text you can stack an '
          'icon and rich content. Skipping label still works; pair it with '
          'hintText for an in-field placeholder.',
        ),
        Wrap(
          spacing: 18,
          runSpacing: 16,
          children: [labelled, unlabelled, richLabel],
        ),
      ],
    ),
  );
}

List<DropdownMenuEntry<String>> _numEntries() {
  return const <DropdownMenuEntry<String>>[
    DropdownMenuEntry<String>(value: 'one', label: 'One'),
    DropdownMenuEntry<String>(value: 'two', label: 'Two'),
    DropdownMenuEntry<String>(value: 'three', label: 'Three'),
    DropdownMenuEntry<String>(value: 'four', label: 'Four'),
  ];
}

// ============================================================================
// SECTION 7 - Icon variants
// ============================================================================
Widget _sectionIconVariants() {
  final DropdownMenu<String> noIcons = DropdownMenu<String>(
    initialSelection: 'apple',
    label: const Text('Fruit · no icons'),
    width: 240,
    dropdownMenuEntries: _fruitEntries(withLeading: false),
  );
  final DropdownMenu<String> leadingOnly = DropdownMenu<String>(
    initialSelection: 'apple',
    label: const Text('Fruit · leading'),
    width: 240,
    leadingIcon: const Icon(Icons.local_grocery_store),
    dropdownMenuEntries: _fruitEntries(withLeading: true),
  );
  final DropdownMenu<String> bothIcons = DropdownMenu<String>(
    initialSelection: 'apple',
    label: const Text('Fruit · both'),
    width: 240,
    leadingIcon: const Icon(Icons.local_grocery_store),
    trailingIcon: const Icon(Icons.arrow_drop_down),
    selectedTrailingIcon: const Icon(Icons.arrow_drop_up),
    dropdownMenuEntries: _fruitEntries(withLeading: true),
  );

  return _card(
    tag: 'ICONS',
    title: 'Leading, trailing, and the swap-on-open trick',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _caption(
          'leadingIcon and trailingIcon decorate the closed field. '
          'selectedTrailingIcon takes the trailingIcon slot while the popup '
          'is open — typically flipping a chevron.',
        ),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [noIcons, leadingOnly, bothIcons],
        ),
      ],
    ),
  );
}

List<DropdownMenuEntry<String>> _fruitEntries({required bool withLeading}) {
  if (!withLeading) {
    return const <DropdownMenuEntry<String>>[
      DropdownMenuEntry<String>(value: 'apple', label: 'Apple'),
      DropdownMenuEntry<String>(value: 'banana', label: 'Banana'),
      DropdownMenuEntry<String>(value: 'cherry', label: 'Cherry'),
    ];
  }
  return const <DropdownMenuEntry<String>>[
    DropdownMenuEntry<String>(
        value: 'apple',
        label: 'Apple',
        leadingIcon: Icon(Icons.apple)),
    DropdownMenuEntry<String>(
        value: 'banana',
        label: 'Banana',
        leadingIcon: Icon(Icons.cookie_outlined)),
    DropdownMenuEntry<String>(
        value: 'cherry',
        label: 'Cherry',
        leadingIcon: Icon(Icons.spa)),
  ];
}

// ============================================================================
// SECTION 8 - Hint text variants
// ============================================================================
Widget _sectionHintVariants() {
  final DropdownMenu<String> empty = DropdownMenu<String>(
    label: const Text('No initial selection'),
    hintText: 'Pick a planet…',
    width: 260,
    dropdownMenuEntries: _planetEntries(),
  );
  final DropdownMenu<String> withInitial = DropdownMenu<String>(
    initialSelection: 'mars',
    label: const Text('With initial selection'),
    hintText: 'Pick a planet…',
    width: 260,
    dropdownMenuEntries: _planetEntries(),
  );
  final DropdownMenu<String> helper = DropdownMenu<String>(
    label: const Text('With helper'),
    hintText: 'Pick a planet…',
    helperText: 'Inner solar system only',
    width: 260,
    dropdownMenuEntries: _planetEntries(),
  );

  return _card(
    tag: 'HINT',
    title: 'hintText, initialSelection, helperText',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _caption(
          'hintText shows inside the field when no value is selected. '
          'initialSelection wins over hintText. helperText puts a small '
          'caption below the field — same as in TextField.',
        ),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [empty, withInitial, helper],
        ),
      ],
    ),
  );
}

List<DropdownMenuEntry<String>> _planetEntries() {
  return const <DropdownMenuEntry<String>>[
    DropdownMenuEntry<String>(value: 'mercury', label: 'Mercury'),
    DropdownMenuEntry<String>(value: 'venus', label: 'Venus'),
    DropdownMenuEntry<String>(value: 'earth', label: 'Earth'),
    DropdownMenuEntry<String>(value: 'mars', label: 'Mars'),
  ];
}

// ============================================================================
// SECTION 9 - Decoration styles (filled vs outlined)
// ============================================================================
Widget _sectionDecorationStyles() {
  final InputDecorationTheme outlined = const InputDecorationTheme(
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: _kTeal, width: 1.5),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  );
  final InputDecorationTheme filled = InputDecorationTheme(
    filled: true,
    fillColor: _kTealSoft,
    border: const OutlineInputBorder(borderSide: BorderSide.none),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  );
  final InputDecorationTheme underlined = const InputDecorationTheme(
    border: UnderlineInputBorder(),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: _kCopper, width: 2),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
  );

  final DropdownMenu<String> a = DropdownMenu<String>(
    initialSelection: 'space',
    label: const Text('Outlined'),
    width: 240,
    inputDecorationTheme: outlined,
    dropdownMenuEntries: _themeEntries(),
  );
  final DropdownMenu<String> b = DropdownMenu<String>(
    initialSelection: 'space',
    label: const Text('Filled'),
    width: 240,
    inputDecorationTheme: filled,
    dropdownMenuEntries: _themeEntries(),
  );
  final DropdownMenu<String> c = DropdownMenu<String>(
    initialSelection: 'space',
    label: const Text('Underlined'),
    width: 240,
    inputDecorationTheme: underlined,
    dropdownMenuEntries: _themeEntries(),
  );

  return _card(
    tag: 'DECORATION',
    title: 'inputDecorationTheme — same data, three skins',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _caption(
          'The text field surface is shaped entirely by '
          'InputDecorationTheme. Outlined is the M3 default. Filled gives '
          'you a soft background. Underlined revives the M2 look.',
        ),
        Wrap(spacing: 16, runSpacing: 16, children: [a, b, c]),
      ],
    ),
  );
}

List<DropdownMenuEntry<String>> _themeEntries() {
  return const <DropdownMenuEntry<String>>[
    DropdownMenuEntry<String>(value: 'space', label: 'Space'),
    DropdownMenuEntry<String>(value: 'ocean', label: 'Ocean'),
    DropdownMenuEntry<String>(value: 'desert', label: 'Desert'),
    DropdownMenuEntry<String>(value: 'forest', label: 'Forest'),
  ];
}

// ============================================================================
// SECTION 10 - Fake popup (rendered statically as fake entries)
// ============================================================================
Widget _sectionFakePopup() {
  return _card(
    tag: 'POPUP',
    title: 'Menu entries — every state, side-by-side',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _caption(
          'Real popups only render when the field is focused. To document '
          'every visual state at once we draw a fake popup surface and '
          'place one row per state. These are not real DropdownMenuEntry '
          'widgets — they mimic the appearance the menu would produce.',
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _fakePopupSurface('Default rows', [
              _fakeEntry('Default', Icons.circle_outlined),
              _fakeEntry('Default', Icons.circle_outlined),
              _fakeEntry('Default', Icons.circle_outlined),
            ])),
            const SizedBox(width: 14),
            Expanded(child: _fakePopupSurface('Hover row', [
              _fakeEntry('Default', Icons.circle_outlined),
              _fakeEntry('Hover',   Icons.circle_outlined, hover: true),
              _fakeEntry('Default', Icons.circle_outlined),
            ])),
            const SizedBox(width: 14),
            Expanded(child: _fakePopupSurface('Selected', [
              _fakeEntry('Default',  Icons.circle_outlined),
              _fakeEntry('Selected', Icons.check_circle, selected: true),
              _fakeEntry('Default',  Icons.circle_outlined),
            ])),
            const SizedBox(width: 14),
            Expanded(child: _fakePopupSurface('Disabled', [
              _fakeEntry('Default',  Icons.circle_outlined),
              _fakeEntry('Disabled', Icons.block, disabled: true),
              _fakeEntry('Default',  Icons.circle_outlined),
            ])),
          ],
        ),
        const SizedBox(height: 16),
        _subhead('WITH TRAILING SHORTCUTS'),
        _fakePopupSurface('Edit menu', [
          _fakeEntry('Undo', Icons.undo, trailing: Icons.keyboard),
          _fakeEntry('Redo', Icons.redo, trailing: Icons.keyboard),
          _fakeEntry('Cut',  Icons.content_cut, trailing: Icons.keyboard),
          _fakeEntry('Copy', Icons.content_copy, trailing: Icons.keyboard),
          _fakeEntry('Paste', Icons.content_paste, trailing: Icons.keyboard),
        ]),
      ],
    ),
  );
}

Widget _fakePopupSurface(String caption, List<Widget> rows) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(caption,
          style: const TextStyle(
              color: _kInkSoft, fontSize: 12, fontWeight: FontWeight.w600)),
      const SizedBox(height: 6),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _kRule),
          boxShadow: const [
            BoxShadow(
                color: Color(0x14000000),
                blurRadius: 10,
                offset: Offset(0, 4)),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(children: rows),
      ),
    ],
  );
}

// ============================================================================
// SECTION 11 - Selection states
// ============================================================================
Widget _sectionSelectionStates() {
  return _card(
    tag: 'STATE',
    title: 'Selected vs unselected, enabled vs disabled',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _caption(
          'The closed field reflects the current selection. When disabled, '
          'the field uses a muted palette and ignores taps.',
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _subhead('UNSELECTED'),
                  DropdownMenu<String>(
                    label: const Text('Pick one'),
                    hintText: 'Pick one…',
                    width: 260,
                    dropdownMenuEntries: _planetEntries(),
                  ),
                  const SizedBox(height: 14),
                  _subhead('SELECTED'),
                  DropdownMenu<String>(
                    initialSelection: 'earth',
                    label: const Text('Pick one'),
                    width: 260,
                    dropdownMenuEntries: _planetEntries(),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _subhead('ENABLED'),
                  DropdownMenu<String>(
                    initialSelection: 'earth',
                    label: const Text('Pick one'),
                    width: 260,
                    dropdownMenuEntries: _planetEntries(),
                  ),
                  const SizedBox(height: 14),
                  _subhead('DISABLED'),
                  DropdownMenu<String>(
                    initialSelection: 'earth',
                    label: const Text('Pick one'),
                    enabled: false,
                    width: 260,
                    dropdownMenuEntries: _planetEntries(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 12 - Real-world catalog (country, language, theme, font size)
// ============================================================================
Widget _sectionRealWorldCatalog() {
  final DropdownMenu<String> country = DropdownMenu<String>(
    initialSelection: 'de',
    label: const Text('Country'),
    leadingIcon: const Icon(Icons.public),
    width: 280,
    dropdownMenuEntries: const <DropdownMenuEntry<String>>[
      DropdownMenuEntry<String>(value: 'us', label: 'United States'),
      DropdownMenuEntry<String>(value: 'de', label: 'Germany'),
      DropdownMenuEntry<String>(value: 'fr', label: 'France'),
      DropdownMenuEntry<String>(value: 'jp', label: 'Japan'),
      DropdownMenuEntry<String>(value: 'br', label: 'Brazil'),
      DropdownMenuEntry<String>(value: 'au', label: 'Australia'),
    ],
  );

  final DropdownMenu<String> language = DropdownMenu<String>(
    initialSelection: 'en',
    label: const Text('Language'),
    leadingIcon: const Icon(Icons.language),
    width: 280,
    dropdownMenuEntries: const <DropdownMenuEntry<String>>[
      DropdownMenuEntry<String>(value: 'en', label: 'English'),
      DropdownMenuEntry<String>(value: 'de', label: 'Deutsch'),
      DropdownMenuEntry<String>(value: 'fr', label: 'Français'),
      DropdownMenuEntry<String>(value: 'ja', label: '日本語'),
      DropdownMenuEntry<String>(value: 'pt', label: 'Português'),
    ],
  );

  final DropdownMenu<String> themePick = DropdownMenu<String>(
    initialSelection: 'system',
    label: const Text('Theme'),
    leadingIcon: const Icon(Icons.palette),
    width: 280,
    dropdownMenuEntries: const <DropdownMenuEntry<String>>[
      DropdownMenuEntry<String>(
          value: 'light',
          label: 'Light',
          leadingIcon: Icon(Icons.light_mode)),
      DropdownMenuEntry<String>(
          value: 'dark',
          label: 'Dark',
          leadingIcon: Icon(Icons.dark_mode)),
      DropdownMenuEntry<String>(
          value: 'system',
          label: 'System',
          leadingIcon: Icon(Icons.settings_brightness)),
      DropdownMenuEntry<String>(
          value: 'highContrast',
          label: 'High contrast',
          leadingIcon: Icon(Icons.contrast)),
    ],
  );

  final DropdownMenu<int> fontSize = DropdownMenu<int>(
    initialSelection: 14,
    label: const Text('Font size'),
    leadingIcon: const Icon(Icons.text_fields),
    width: 280,
    dropdownMenuEntries: const <DropdownMenuEntry<int>>[
      DropdownMenuEntry<int>(value: 12, label: '12 px · Small'),
      DropdownMenuEntry<int>(value: 14, label: '14 px · Default'),
      DropdownMenuEntry<int>(value: 16, label: '16 px · Comfortable'),
      DropdownMenuEntry<int>(value: 18, label: '18 px · Large'),
      DropdownMenuEntry<int>(value: 22, label: '22 px · Headline'),
    ],
  );

  return _card(
    tag: 'CATALOG',
    title: 'Four typical settings dropdowns',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _caption(
          'A settings panel is the most common DropdownMenu site. Each '
          'picker below would normally live next to a save/apply button. '
          'Note how a generic type other than String — here int — works '
          'just as cleanly.',
        ),
        Wrap(
          spacing: 18,
          runSpacing: 18,
          children: [country, language, themePick, fontSize],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 13 - Comparison table
// ============================================================================
Widget _sectionComparisonTable() {
  final List<List<String>> rows = const [
    ['Property',           'DropdownMenu',   'DropdownButton', 'PopupMenuButton', 'Autocomplete'],
    ['Material version',   '3',              '2',              '2/3',             '3'],
    ['Looks like',         'Text field',     'Inline button',  'Icon/avatar',     'Text field'],
    ['Type-to-filter',     'Yes',            'No',             'No',              'Yes'],
    ['Static popup',       'No',             'Yes',            'Yes',             'No'],
    ['Form-friendly',      'Yes',            'No',             'No',              'Yes'],
    ['Result via',         'onSelected',     'onChanged',      'onSelected',      'onSelected'],
    ['Genericity',         'DropdownMenu<T>','DropdownButton<T>','PopupMenuButton<T>','Autocomplete<T>'],
    ['Entry type',         'DropdownMenuEntry<T>', 'DropdownMenuItem<T>', 'PopupMenuEntry<T>', 'plain T'],
    ['Search of options',  'Built-in',       'No',             'No',              'Built-in'],
    ['Best for',           'Pickers + form', 'Quick toggle',   'Context actions', 'Free-text matches'],
  ];

  return _card(
    tag: 'COMPARE',
    title: 'DropdownMenu vs alternatives',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _caption(
          'When in doubt, reach for DropdownMenu — it covers most M3 picker '
          'cases. The others remain useful for narrow shapes: '
          'DropdownButton for a small inline toggle, PopupMenuButton for an '
          'overflow icon, Autocomplete for free-text fields.',
        ),
        Container(
          decoration: BoxDecoration(
            color: _kPaperAlt,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kRule),
          ),
          padding: const EdgeInsets.all(2),
          child: Column(
            children: List<Widget>.generate(rows.length, (int i) {
              final List<String> row = rows[i];
              final bool head = i == 0;
              return Container(
                color: head
                    ? _kInk
                    : (i.isEven ? Colors.white : _kPaper),
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
                child: Row(
                  children: List<Widget>.generate(row.length, (int c) {
                    return Expanded(
                      flex: c == 0 ? 2 : 2,
                      child: Text(
                        row[c],
                        style: TextStyle(
                          color: head ? Colors.white : _kInk,
                          fontSize: head ? 12 : 13,
                          fontWeight:
                              head || c == 0 ? FontWeight.w700 : FontWeight.w500,
                          letterSpacing: head ? 0.6 : 0,
                        ),
                      ),
                    );
                  }),
                ),
              );
            }),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 14 - Glossary
// ============================================================================
Widget _sectionGlossary() {
  final List<List<String>> terms = const [
    ['Anchor',
      'The widget the popup is positioned relative to. The DropdownMenu '
      'text field is its own anchor.'],
    ['DropdownMenuEntry',
      'A data record describing one option: value, label, icons, style.'],
    ['Filter',
      'Reduces visible entries to those matching what the user types.'],
    ['Helper text',
      'Caption shown below the field, like in a TextField.'],
    ['Hint',
      'In-field placeholder shown when no entry is selected.'],
    ['Initial selection',
      'The value pre-applied when the widget first builds.'],
    ['Leading icon',
      'Icon at the start of either the field or an entry row.'],
    ['Menu surface',
      'The popup container — elevated, rounded, themed via MenuStyle.'],
    ['MenuStyle',
      'A ButtonStyle-shaped object that styles the popup container.'],
    ['onSelected',
      'Callback receiving the picked T when the user confirms a choice.'],
    ['Popup',
      'The list of menu entries that opens below or above the field.'],
    ['Trailing icon',
      'Icon at the end of the field — typically the chevron.'],
  ];

  return _card(
    tag: 'GLOSSARY',
    title: 'Twelve terms you will keep meeting',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List<Widget>.generate(terms.length, (int i) {
        final List<String> entry = terms[i];
        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: i == terms.length - 1 ? Colors.transparent : _kRule,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 150,
                child: Text(entry[0],
                    style: const TextStyle(
                        color: _kTealDeep,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(entry[1],
                    style: const TextStyle(
                        color: _kInkSoft, fontSize: 13, height: 1.5)),
              ),
            ],
          ),
        );
      }),
    ),
  );
}

// ============================================================================
// SECTION 15 - Epilogue
// ============================================================================
Widget _sectionEpilogue() {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: _kInk,
      borderRadius: BorderRadius.circular(18),
    ),
    padding: const EdgeInsets.fromLTRB(28, 26, 28, 28),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: _kCopper.withValues(alpha: 0.20),
            border: Border.all(color: _kCopper),
            borderRadius: BorderRadius.circular(999),
          ),
          child: const Text(
            'EPILOGUE',
            style: TextStyle(
                color: _kCopperSoft,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'You now know everything visible about DropdownMenu.',
          style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              height: 1.2),
        ),
        const SizedBox(height: 10),
        const Text(
          'The only behavioural piece this static reference cannot show is '
          'the open-on-tap animation and the searchable filter in motion. '
          'Both are subtle — a 200 ms scale and fade for the popup, and a '
          'live narrowing of entries as you type. Try them in any sample '
          'app and the rest of this widget will already feel familiar.',
          style: TextStyle(
              color: Colors.white70, fontSize: 14, height: 1.55),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                  color: _kCopper, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            const Text('fin.',
                style: TextStyle(
                    color: _kCopperSoft,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2)),
          ],
        ),
      ],
    ),
  );
}

// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// =====================================================================
//  ChipAttributes — Visual Deep Demo
// =====================================================================
//
//  Subject: Flutter Material's `ChipAttributes` mixin and the family of
//  chip widgets that mix it in: `Chip`, `ActionChip`, `ChoiceChip`,
//  `FilterChip`, `InputChip`, `RawChip`.
//
//  This is a hand-authored, analyzer-free demo that renders a single
//  static screen describing every property of `ChipAttributes` and
//  documenting how each of the chip subclasses combines it with sister
//  mixins (`DeletableChipAttributes`, `SelectableChipAttributes`,
//  `DisabledChipAttributes`, `CheckmarkableChipAttributes`,
//  `TappableChipAttributes`).
//
//  Layout overview
//  ---------------
//   1.  Hero — chip cloud with 30+ chips of every kind
//   2.  Anatomy — labelled diagram of one Chip's parts
//   3.  Family — mixin matrix per subclass
//   4.  Field gallery — each ChipAttributes property varied
//   5.  Selection matrix — selected x states grid for FilterChip
//   6.  Color WidgetStateProperty — resolution chain visualization
//   7.  Recipe — fully styled FilterChip code listing card
//   8.  ChipTheme — theme cascade comparison
//   9.  Pitfalls — common gotchas
//  10.  Footer — palette + version
//
// =====================================================================

import 'package:flutter/material.dart';

// =====================================================================
//  PALETTE — neutrals + accents used across the demo.
// =====================================================================

const Color _kInk = Color(0xFF101828);
const Color _kSubInk = Color(0xFF475467);
const Color _kFaint = Color(0xFF98A2B3);
const Color _kPaper = Color(0xFFF7F8FA);
const Color _kCard = Color(0xFFFFFFFF);
const Color _kLine = Color(0xFFE4E7EC);
const Color _kAccent = Color(0xFF6C5CE7);
const Color _kAccentSoft = Color(0xFFEDEAFE);
const Color _kPositive = Color(0xFF12B76A);
const Color _kPositiveSoft = Color(0xFFD1FADF);
const Color _kWarn = Color(0xFFF79009);
const Color _kWarnSoft = Color(0xFFFEF0C7);
const Color _kDanger = Color(0xFFD92D20);
const Color _kDangerSoft = Color(0xFFFEE4E2);
const Color _kInfo = Color(0xFF2E90FA);
const Color _kInfoSoft = Color(0xFFD1E9FF);
const Color _kViolet = Color(0xFF7A5AF8);
const Color _kVioletSoft = Color(0xFFE9E2FE);
const Color _kTeal = Color(0xFF0E9384);
const Color _kTealSoft = Color(0xFFCCFBF1);
const Color _kRose = Color(0xFFE31B54);
const Color _kRoseSoft = Color(0xFFFFE4EE);

// =====================================================================
//  SINGLE PUBLIC ENTRY POINT
// =====================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ChipAttributes Visual Demo',
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: _kPaper,
      colorScheme: const ColorScheme.light(
        primary: _kAccent,
        onPrimary: Colors.white,
        secondary: _kViolet,
        onSecondary: Colors.white,
        surface: _kCard,
        onSurface: _kInk,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _kInk, fontSize: 14),
        bodySmall: TextStyle(color: _kSubInk, fontSize: 12),
      ),
    ),
    home: Scaffold(
      backgroundColor: _kPaper,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 64),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _PrivateSectionHeader(
                index: 1,
                title: 'Hero — Chip Cloud',
                subtitle:
                    'A dense cloud of 30+ chips spanning Chip, ActionChip, ChoiceChip, FilterChip, InputChip, and RawChip.',
              ),
              const SizedBox(height: 16),
              _PrivateHeroSection(),
              const SizedBox(height: 32),
              _PrivateSectionHeader(
                index: 2,
                title: 'Anatomy of a Chip',
                subtitle:
                    'Avatar, label, deleteIcon, padding, border, background, and elevation are the visible anatomy.',
              ),
              const SizedBox(height: 16),
              _PrivateAnatomySection(),
              const SizedBox(height: 32),
              _PrivateSectionHeader(
                index: 3,
                title: 'Family Mixin Matrix',
                subtitle:
                    'Each chip subclass mixes ChipAttributes with a different set of sister mixins.',
              ),
              const SizedBox(height: 16),
              _PrivateFamilyMatrix(),
              const SizedBox(height: 32),
              _PrivateSectionHeader(
                index: 4,
                title: 'ChipAttributes — field-by-field',
                subtitle:
                    'Each card varies one ChipAttributes property across three values to show its visual effect.',
              ),
              const SizedBox(height: 16),
              _PrivateAttributeGallery(),
              const SizedBox(height: 32),
              _PrivateSectionHeader(
                index: 5,
                title: 'Selection State Matrix',
                subtitle:
                    'A 4x6 grid of FilterChips covering selected/unselected combined with disabled, enabled, avatar, and checkmark.',
              ),
              const SizedBox(height: 16),
              _PrivateSelectionMatrix(),
              const SizedBox(height: 32),
              _PrivateSectionHeader(
                index: 6,
                title: 'Color — WidgetStateProperty Resolution',
                subtitle:
                    'How `color` resolves to a concrete Color depending on the chip\'s WidgetState set.',
              ),
              const SizedBox(height: 16),
              _PrivateStateColorChain(),
              const SizedBox(height: 32),
              _PrivateSectionHeader(
                index: 7,
                title: 'Recipe — Fully Styled FilterChip',
                subtitle:
                    'A reference code listing for a fully decorated FilterChip and its rendered output.',
              ),
              const SizedBox(height: 16),
              _PrivateRecipeCard(),
              const SizedBox(height: 32),
              _PrivateSectionHeader(
                index: 8,
                title: 'ChipTheme cascade',
                subtitle:
                    'ChipTheme.of(context) gives the resolved defaults; overriding via ChipTheme cascades down to children.',
              ),
              const SizedBox(height: 16),
              _PrivateThemePanel(),
              const SizedBox(height: 32),
              _PrivateSectionHeader(
                index: 9,
                title: 'Pitfalls',
                subtitle:
                    'Common surprises that bite when wiring chip widgets into a real screen.',
              ),
              const SizedBox(height: 16),
              _PrivatePitfalls(),
              const SizedBox(height: 32),
              _PrivateSectionHeader(
                index: 10,
                title: 'Palette & Version',
                subtitle: 'The colors and metadata used by this demo.',
              ),
              const SizedBox(height: 16),
              _PrivateFooter(),
            ],
          ),
        ),
      ),
    ),
  );
}

// =====================================================================
//  COMMON LITTLE WIDGETS
// =====================================================================

class _PrivateSectionHeader extends StatelessWidget {
  const _PrivateSectionHeader({
    required this.index,
    required this.title,
    required this.subtitle,
  });

  final int index;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kLine),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _kAccentSoft,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$index',
              style: const TextStyle(
                color: _kAccent,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: _kInk,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(color: _kSubInk, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateCard extends StatelessWidget {
  const _PrivateCard({required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kLine),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _PrivateMiniCaption extends StatelessWidget {
  const _PrivateMiniCaption(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: _kSubInk,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.3,
      ),
    );
  }
}

class _PrivateLabel extends StatelessWidget {
  const _PrivateLabel(this.text, {this.bold = false});
  final String text;
  final bool bold;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: _kInk,
        fontSize: 13,
        fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
      ),
    );
  }
}

// =====================================================================
//  SECTION 1 — HERO CHIP CLOUD
// =====================================================================

class _PrivateHeroSection extends StatelessWidget {
  const _PrivateHeroSection();

  List<Widget> _buildCloud() {
    final List<Widget> chips = <Widget>[];

    // Plain Chip examples
    chips.add(const Chip(label: Text('flutter')));
    chips.add(const Chip(label: Text('dart')));
    chips.add(Chip(
      label: const Text('material'),
      avatar: const Icon(Icons.layers, size: 18, color: _kAccent),
    ));
    chips.add(Chip(
      label: const Text('design'),
      backgroundColor: _kAccentSoft,
      side: const BorderSide(color: _kAccent),
    ));
    chips.add(const Chip(
      label: Text('widgets'),
      shape: StadiumBorder(),
    ));

    // ActionChip examples
    chips.add(ActionChip(
      label: const Text('Refresh'),
      avatar: const Icon(Icons.refresh, size: 18),
      onPressed: () {},
    ));
    chips.add(ActionChip(
      label: const Text('Share'),
      avatar: const Icon(Icons.share, size: 18),
      onPressed: () {},
      backgroundColor: _kInfoSoft,
      side: const BorderSide(color: _kInfo),
    ));
    chips.add(ActionChip(
      label: const Text('Save'),
      onPressed: () {},
      shape: const StadiumBorder(),
    ));
    chips.add(ActionChip(
      label: const Text('Export'),
      onPressed: () {},
      backgroundColor: _kPositiveSoft,
    ));

    // ChoiceChip examples
    chips.add(ChoiceChip(
      label: const Text('Daily'),
      selected: true,
      onSelected: (_) {},
      selectedColor: _kAccentSoft,
    ));
    chips.add(ChoiceChip(
      label: const Text('Weekly'),
      selected: false,
      onSelected: (_) {},
    ));
    chips.add(ChoiceChip(
      label: const Text('Monthly'),
      selected: false,
      onSelected: (_) {},
    ));
    chips.add(const ChoiceChip(
      label: Text('Yearly (disabled)'),
      selected: false,
    ));

    // FilterChip examples
    chips.add(FilterChip(
      label: const Text('Sci-Fi'),
      selected: true,
      onSelected: (_) {},
      avatar: const Icon(Icons.bolt, size: 18, color: _kAccent),
    ));
    chips.add(FilterChip(
      label: const Text('Drama'),
      selected: false,
      onSelected: (_) {},
    ));
    chips.add(FilterChip(
      label: const Text('Horror'),
      selected: true,
      onSelected: (_) {},
      backgroundColor: _kRoseSoft,
      selectedColor: _kRose.withValues(alpha: 0.2),
      side: const BorderSide(color: _kRose),
    ));
    chips.add(FilterChip(
      label: const Text('Comedy'),
      selected: false,
      onSelected: (_) {},
    ));
    chips.add(FilterChip(
      label: const Text('Romance'),
      selected: true,
      onSelected: (_) {},
      checkmarkColor: _kPositive,
    ));

    // InputChip examples
    chips.add(InputChip(
      label: const Text('alice@example.com'),
      avatar: const CircleAvatar(
        backgroundColor: _kAccent,
        child: Text('A',
            style: TextStyle(color: Colors.white, fontSize: 12)),
      ),
      onDeleted: () {},
    ));
    chips.add(InputChip(
      label: const Text('bob@example.com'),
      avatar: const CircleAvatar(
        backgroundColor: _kViolet,
        child: Text('B',
            style: TextStyle(color: Colors.white, fontSize: 12)),
      ),
      onDeleted: () {},
    ));
    chips.add(InputChip(
      label: const Text('carla@example.com'),
      avatar: const CircleAvatar(
        backgroundColor: _kTeal,
        child: Text('C',
            style: TextStyle(color: Colors.white, fontSize: 12)),
      ),
      onDeleted: () {},
      selected: true,
    ));
    chips.add(InputChip(
      label: const Text('dan@example.com'),
      onDeleted: () {},
      onPressed: () {},
    ));
    chips.add(const InputChip(
      label: Text('eve@example.com (disabled)'),
      isEnabled: false,
    ));

    // RawChip examples
    chips.add(RawChip(
      label: const Text('raw-foo'),
      onPressed: () {},
      shape: const StadiumBorder(),
      side: const BorderSide(color: _kAccent),
    ));
    chips.add(RawChip(
      label: const Text('raw-bar'),
      onPressed: () {},
      onDeleted: () {},
      avatar: const Icon(Icons.tag, size: 18),
    ));
    chips.add(RawChip(
      label: const Text('raw-baz'),
      selected: true,
      onSelected: (_) {},
      showCheckmark: true,
    ));
    chips.add(RawChip(
      label: const Text('raw-quux'),
      onPressed: () {},
      backgroundColor: _kVioletSoft,
      side: const BorderSide(color: _kViolet),
    ));

    // Variants — colored
    chips.add(Chip(
      label: const Text('error'),
      backgroundColor: _kDangerSoft,
      side: const BorderSide(color: _kDanger),
      labelStyle: const TextStyle(color: _kDanger, fontWeight: FontWeight.w600),
    ));
    chips.add(Chip(
      label: const Text('warning'),
      backgroundColor: _kWarnSoft,
      side: const BorderSide(color: _kWarn),
      labelStyle: const TextStyle(color: _kWarn, fontWeight: FontWeight.w600),
    ));
    chips.add(Chip(
      label: const Text('ok'),
      backgroundColor: _kPositiveSoft,
      side: const BorderSide(color: _kPositive),
      labelStyle:
          const TextStyle(color: _kPositive, fontWeight: FontWeight.w600),
    ));
    chips.add(Chip(
      label: const Text('info'),
      backgroundColor: _kInfoSoft,
      side: const BorderSide(color: _kInfo),
      labelStyle: const TextStyle(color: _kInfo, fontWeight: FontWeight.w600),
    ));
    chips.add(const Chip(label: Text('beta'), elevation: 4));
    chips.add(const Chip(label: Text('archived'), elevation: 0));
    chips.add(Chip(
      label: const Text('priority'),
      avatar: const Icon(Icons.flag, size: 18, color: _kRose),
    ));

    return chips;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> cloud = _buildCloud();
    return _PrivateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.cloud, color: _kAccent),
              const SizedBox(width: 8),
              const _PrivateLabel('30+ chips, every kind', bold: true),
              const Spacer(),
              _PrivateMiniCaption('count: ${cloud.length}'),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 10,
            children: cloud,
          ),
        ],
      ),
    );
  }
}

// =====================================================================
//  SECTION 2 — ANATOMY DIAGRAM
// =====================================================================

class _PrivateAnatomySection extends StatelessWidget {
  const _PrivateAnatomySection();

  @override
  Widget build(BuildContext context) {
    return _PrivateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _PrivateLabel('A chip is the sum of its anatomy:', bold: true),
          const SizedBox(height: 16),
          Center(
            child: _PrivateBigChipDiagram(),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 14,
            runSpacing: 10,
            children: const <Widget>[
              _PrivateAnatomyTag(swatch: _kAccent, label: 'avatar'),
              _PrivateAnatomyTag(swatch: _kInk, label: 'label'),
              _PrivateAnatomyTag(swatch: _kRose, label: 'deleteIcon'),
              _PrivateAnatomyTag(swatch: _kFaint, label: 'padding'),
              _PrivateAnatomyTag(swatch: _kSubInk, label: 'border (side)'),
              _PrivateAnatomyTag(swatch: _kAccentSoft, label: 'backgroundColor'),
              _PrivateAnatomyTag(swatch: _kViolet, label: 'elevation shadow'),
            ],
          ),
        ],
      ),
    );
  }
}

class _PrivateAnatomyTag extends StatelessWidget {
  const _PrivateAnatomyTag({required this.swatch, required this.label});
  final Color swatch;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: swatch,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(label,
            style: const TextStyle(color: _kInk, fontSize: 12)),
      ],
    );
  }
}

class _PrivateBigChipDiagram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(28, 36, 28, 36),
      decoration: BoxDecoration(
        color: _kPaper,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kLine),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: <Widget>[
          // The "big chip" pictograph.
          Container(
            padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
            decoration: BoxDecoration(
              color: _kAccentSoft,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: _kAccent, width: 1.5),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: _kViolet.withValues(alpha: 0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: _kAccent,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    'A',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    'Anatomy of a Chip',
                    style: TextStyle(
                      color: _kInk,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 22,
                  height: 22,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _kRose.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: _kRose, size: 14),
                ),
              ],
            ),
          ),
          // Callouts
          const Positioned(
            top: -4,
            left: 0,
            child: _PrivateCallout(text: 'avatar', color: _kAccent),
          ),
          const Positioned(
            top: -4,
            right: 0,
            child: _PrivateCallout(text: 'deleteIcon', color: _kRose),
          ),
          const Positioned(
            bottom: -4,
            left: 80,
            child: _PrivateCallout(text: 'label', color: _kInk),
          ),
          const Positioned(
            bottom: -22,
            right: 12,
            child:
                _PrivateCallout(text: 'side / shape / elevation', color: _kViolet),
          ),
        ],
      ),
    );
  }
}

class _PrivateCallout extends StatelessWidget {
  const _PrivateCallout({required this.text, required this.color});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// =====================================================================
//  SECTION 3 — FAMILY MIXIN MATRIX
// =====================================================================

class _PrivateFamilyMatrix extends StatelessWidget {
  const _PrivateFamilyMatrix();

  static const List<String> _columns = <String>[
    'ChipAttributes',
    'Deletable',
    'Selectable',
    'Disabled',
    'Checkmarkable',
    'Tappable',
  ];

  // (subclass, column-flags in same order as _columns)
  static const List<List<dynamic>> _rows = <List<dynamic>>[
    <dynamic>['Chip', true, true, false, false, false, false],
    <dynamic>['ActionChip', true, false, false, false, false, true],
    <dynamic>['ChoiceChip', true, false, true, true, true, false],
    <dynamic>['FilterChip', true, false, true, true, true, false],
    <dynamic>['InputChip', true, true, true, true, true, true],
    <dynamic>['RawChip', true, true, true, true, true, true],
  ];

  @override
  Widget build(BuildContext context) {
    return _PrivateCard(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // header row
          Container(
            decoration: const BoxDecoration(
              color: _kPaper,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(14)),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: <Widget>[
                const SizedBox(
                  width: 110,
                  child: Text('Subclass',
                      style: TextStyle(
                        color: _kInk,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      )),
                ),
                ..._columns.map<Widget>((String c) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        c,
                        style: const TextStyle(
                          color: _kInk,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          ..._rows.map<Widget>((List<dynamic> r) {
            return Container(
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: _kLine)),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 110,
                    child: Text(
                      r[0] as String,
                      style: const TextStyle(
                        color: _kInk,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  for (int i = 1; i <= 6; i++)
                    Expanded(
                      child: Center(
                        child: _PrivateMixinDot(value: r[i] as bool),
                      ),
                    ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _PrivateMixinDot extends StatelessWidget {
  const _PrivateMixinDot({required this.value});
  final bool value;
  @override
  Widget build(BuildContext context) {
    final Color c = value ? _kPositive : _kFaint;
    final IconData ic = value ? Icons.check_circle : Icons.remove_circle_outline;
    return Icon(ic, color: c, size: 18);
  }
}

// =====================================================================
//  SECTION 4 — ATTRIBUTE GALLERY
// =====================================================================

class _PrivateAttributeGallery extends StatelessWidget {
  const _PrivateAttributeGallery();

  @override
  Widget build(BuildContext context) {
    final List<_PrivateAttrCard> cards = <_PrivateAttrCard>[
      _PrivateAttrCard(
        attribute: 'label / labelStyle',
        description:
            'The string content. labelStyle sets typography on the label widget.',
        examples: <Widget>[
          const Chip(
            label: Text('plain'),
          ),
          Chip(
            label: const Text('italic'),
            labelStyle: const TextStyle(
              fontStyle: FontStyle.italic,
              color: _kAccent,
            ),
          ),
          Chip(
            label: const Text('bold + spaced'),
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
      _PrivateAttrCard(
        attribute: 'labelPadding',
        description:
            'Padding wrapping the label. Distinct from `padding` which surrounds the entire chip.',
        examples: <Widget>[
          const Chip(
            label: Text('tight'),
            labelPadding: EdgeInsets.zero,
          ),
          Chip(
            label: const Text('medium'),
            labelPadding: const EdgeInsets.symmetric(horizontal: 6),
          ),
          Chip(
            label: const Text('wide'),
            labelPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        ],
      ),
      _PrivateAttrCard(
        attribute: 'avatar',
        description:
            'Leading widget. CircleAvatar, Icon, or any small widget.',
        examples: <Widget>[
          Chip(
            label: const Text('icon'),
            avatar: const Icon(Icons.tag, size: 18, color: _kAccent),
          ),
          Chip(
            label: const Text('initials'),
            avatar: const CircleAvatar(
              backgroundColor: _kAccent,
              child: Text(
                'AB',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
          Chip(
            label: const Text('image stub'),
            avatar: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: <Color>[_kViolet, _kRose],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
      _PrivateAttrCard(
        attribute: 'padding',
        description:
            'Padding around the entire chip body (between border and contents).',
        examples: <Widget>[
          Chip(
            label: const Text('tight'),
            padding: const EdgeInsets.all(0),
          ),
          Chip(
            label: const Text('medium'),
            padding: const EdgeInsets.all(4),
          ),
          Chip(
            label: const Text('wide'),
            padding: const EdgeInsets.all(10),
          ),
        ],
      ),
      _PrivateAttrCard(
        attribute: 'shape',
        description:
            'OutlinedBorder. Affects corner radius and outline drawing.',
        examples: <Widget>[
          Chip(
            label: const Text('rounded'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const Chip(
            label: Text('stadium'),
            shape: StadiumBorder(),
          ),
          Chip(
            label: const Text('squircle'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
      _PrivateAttrCard(
        attribute: 'side',
        description:
            'Border drawn around the chip. Width and color tuneable.',
        examples: <Widget>[
          Chip(
            label: const Text('thin'),
            side: const BorderSide(color: _kSubInk, width: 0.5),
          ),
          Chip(
            label: const Text('medium'),
            side: const BorderSide(color: _kAccent, width: 1.5),
          ),
          Chip(
            label: const Text('thick'),
            side: const BorderSide(color: _kRose, width: 3),
          ),
        ],
      ),
      _PrivateAttrCard(
        attribute: 'backgroundColor',
        description:
            'Fill behind the chip. M3 themes can override; explicit value wins.',
        examples: <Widget>[
          Chip(
            label: const Text('paper'),
            backgroundColor: _kPaper,
          ),
          Chip(
            label: const Text('soft accent'),
            backgroundColor: _kAccentSoft,
          ),
          Chip(
            label: const Text('soft positive'),
            backgroundColor: _kPositiveSoft,
          ),
        ],
      ),
      _PrivateAttrCard(
        attribute: 'elevation',
        description:
            'Z-axis lift, casting a softer shadow as it grows.',
        examples: <Widget>[
          const Chip(
            label: Text('flat (0)'),
            elevation: 0,
          ),
          const Chip(
            label: Text('mid (4)'),
            elevation: 4,
          ),
          const Chip(
            label: Text('high (12)'),
            elevation: 12,
          ),
        ],
      ),
      _PrivateAttrCard(
        attribute: 'shadowColor',
        description:
            'Color of the cast shadow when elevation > 0.',
        examples: <Widget>[
          const Chip(
            label: Text('default'),
            elevation: 6,
          ),
          const Chip(
            label: Text('warm'),
            elevation: 6,
            shadowColor: _kRose,
          ),
          const Chip(
            label: Text('violet'),
            elevation: 6,
            shadowColor: _kViolet,
          ),
        ],
      ),
      _PrivateAttrCard(
        attribute: 'surfaceTintColor',
        description:
            'M3 surface tint blended with backgroundColor based on elevation.',
        examples: <Widget>[
          const Chip(
            label: Text('untinted'),
            elevation: 6,
            surfaceTintColor: Colors.transparent,
          ),
          const Chip(
            label: Text('teal tint'),
            elevation: 6,
            surfaceTintColor: _kTeal,
          ),
          const Chip(
            label: Text('rose tint'),
            elevation: 6,
            surfaceTintColor: _kRose,
          ),
        ],
      ),
      _PrivateAttrCard(
        attribute: 'iconTheme',
        description:
            'IconThemeData applied to icons inside the chip (e.g. avatar Icon).',
        examples: <Widget>[
          Chip(
            label: const Text('default'),
            avatar: const Icon(Icons.star),
          ),
          Chip(
            label: const Text('custom small'),
            avatar: const Icon(Icons.star),
            iconTheme: const IconThemeData(color: _kAccent, size: 14),
          ),
          Chip(
            label: const Text('custom big'),
            avatar: const Icon(Icons.star),
            iconTheme: const IconThemeData(color: _kRose, size: 22),
          ),
        ],
      ),
      _PrivateAttrCard(
        attribute: 'clipBehavior',
        description:
            'How content is clipped against the chip\'s shape.',
        examples: <Widget>[
          Chip(
            label: const Text('none'),
            clipBehavior: Clip.none,
          ),
          Chip(
            label: const Text('hardEdge'),
            clipBehavior: Clip.hardEdge,
          ),
          Chip(
            label: const Text('antiAlias'),
            clipBehavior: Clip.antiAlias,
          ),
        ],
      ),
      _PrivateAttrCard(
        attribute: 'materialTapTargetSize',
        description:
            'shrinkWrap vs padded. Controls min hit-area, often 48dp.',
        examples: <Widget>[
          ActionChip(
            label: const Text('shrink wrap'),
            onPressed: () {},
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          ActionChip(
            label: const Text('padded'),
            onPressed: () {},
            materialTapTargetSize: MaterialTapTargetSize.padded,
          ),
          ActionChip(
            label: const Text('default'),
            onPressed: () {},
          ),
        ],
      ),
      _PrivateAttrCard(
        attribute: 'visualDensity',
        description:
            'Compact / standard / comfortable spacing tuning per Material guidelines.',
        examples: <Widget>[
          const Chip(
            label: Text('standard'),
            visualDensity: VisualDensity.standard,
          ),
          const Chip(
            label: Text('compact'),
            visualDensity: VisualDensity.compact,
          ),
          const Chip(
            label: Text('comfortable'),
            visualDensity: VisualDensity.comfortable,
          ),
        ],
      ),
      _PrivateAttrCard(
        attribute: 'autofocus / focusNode',
        description:
            'Determines initial focus and the FocusNode used by the chip.',
        examples: <Widget>[
          ActionChip(
            label: const Text('autofocus: false'),
            onPressed: () {},
            autofocus: false,
          ),
          ActionChip(
            label: const Text('autofocus: true'),
            onPressed: () {},
            autofocus: true,
          ),
          ActionChip(
            label: const Text('w/ FocusNode'),
            onPressed: () {},
            focusNode: FocusNode(skipTraversal: true),
          ),
        ],
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        for (int i = 0; i < cards.length; i += 2)
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(child: cards[i]),
                const SizedBox(width: 14),
                Expanded(
                  child: i + 1 < cards.length
                      ? cards[i + 1]
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _PrivateAttrCard extends StatelessWidget {
  const _PrivateAttrCard({
    required this.attribute,
    required this.description,
    required this.examples,
  });
  final String attribute;
  final String description;
  final List<Widget> examples;

  @override
  Widget build(BuildContext context) {
    return _PrivateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _kAccentSoft,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  attribute,
                  style: const TextStyle(
                    color: _kAccent,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(color: _kSubInk, fontSize: 12),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 10,
            children: examples,
          ),
        ],
      ),
    );
  }
}

// =====================================================================
//  SECTION 5 — SELECTION MATRIX
// =====================================================================

class _PrivateSelectionMatrix extends StatelessWidget {
  const _PrivateSelectionMatrix();

  static const List<String> _rowLabels = <String>[
    'Plain',
    'Disabled',
    'With avatar',
    'No checkmark',
  ];

  static const List<String> _colLabels = <String>[
    'unselected',
    'unselected (alt)',
    'selected',
    'selected (alt)',
    'unselected (third)',
    'selected (third)',
  ];

  Widget _cell(int row, int col) {
    final bool selected = col % 2 == 1 || col >= 4;
    final bool reallySelected = (col == 2) || (col == 3) || (col == 5);
    final bool isSelected = reallySelected;

    switch (row) {
      case 0:
        return FilterChip(
          label: Text(isSelected ? 'on' : 'off'),
          selected: isSelected,
          onSelected: (_) {},
        );
      case 1:
        return FilterChip(
          label: Text(isSelected ? 'on' : 'off'),
          selected: isSelected,
          onSelected: null,
        );
      case 2:
        return FilterChip(
          label: Text(isSelected ? 'on' : 'off'),
          selected: isSelected,
          onSelected: (_) {},
          avatar: const Icon(Icons.star, size: 18),
        );
      case 3:
        return FilterChip(
          label: Text(isSelected ? 'on' : 'off'),
          selected: isSelected,
          onSelected: (_) {},
          showCheckmark: false,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _PrivateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _PrivateLabel('FilterChip — 4 rows × 6 columns', bold: true),
          const SizedBox(height: 4),
          const _PrivateMiniCaption(
              'Each cell uses a static `selected:` value; `onSelected: (_) {}` toggles enable/disable.'),
          const SizedBox(height: 14),
          for (int r = 0; r < 4; r++)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 110,
                    child: Text(
                      _rowLabels[r],
                      style: const TextStyle(
                        color: _kInk,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  for (int c = 0; c < 6; c++)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Center(child: _cell(r, c)),
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

// =====================================================================
//  SECTION 6 — Color (WidgetStateProperty) RESOLUTION CHAIN
// =====================================================================

class _PrivateStateColorChain extends StatelessWidget {
  const _PrivateStateColorChain();

  static const List<List<dynamic>> _states = <List<dynamic>>[
    <dynamic>['default', _kAccentSoft, _kAccent, '{}'],
    <dynamic>['hovered', Color(0xFFE0DCFE), _kAccent, '{hovered}'],
    <dynamic>['focused', Color(0xFFD6CDFF), _kViolet, '{focused}'],
    <dynamic>['pressed', Color(0xFFC7BBFF), _kViolet, '{pressed}'],
    <dynamic>['selected', _kAccent, Colors.white, '{selected}'],
    <dynamic>['disabled', Color(0xFFEFEFF1), _kFaint, '{disabled}'],
  ];

  @override
  Widget build(BuildContext context) {
    return _PrivateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _PrivateLabel(
            'WidgetStateProperty<Color?> — resolution chain',
            bold: true,
          ),
          const SizedBox(height: 4),
          const _PrivateMiniCaption(
              '`color` resolves to a Color depending on the WidgetState set; we visualize the static result for each state.'),
          const SizedBox(height: 14),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              for (final List<dynamic> s in _states)
                _PrivateStateBox(
                  label: s[0] as String,
                  bg: s[1] as Color,
                  fg: s[2] as Color,
                  set: s[3] as String,
                ),
            ],
          ),
          const SizedBox(height: 18),
          const Divider(height: 1, color: _kLine),
          const SizedBox(height: 14),
          const _PrivateLabel(
            'Pseudo-code',
            bold: true,
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kPaper,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kLine),
            ),
            child: const Text(
              'color: WidgetStateProperty.resolveWith<Color?>((states) {\n'
              '  if (states.contains(WidgetState.disabled)) return Color(0xFFEFEFF1);\n'
              '  if (states.contains(WidgetState.selected)) return accent;\n'
              '  if (states.contains(WidgetState.pressed))  return pressedTint;\n'
              '  if (states.contains(WidgetState.focused))  return focusedTint;\n'
              '  if (states.contains(WidgetState.hovered))  return hoverTint;\n'
              '  return defaultTint;\n'
              '}),',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: _kInk,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateStateBox extends StatelessWidget {
  const _PrivateStateBox({
    required this.label,
    required this.bg,
    required this.fg,
    required this.set,
  });
  final String label;
  final Color bg;
  final Color fg;
  final String set;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: fg.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: fg,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            set,
            style: TextStyle(
              color: fg.withValues(alpha: 0.8),
              fontFamily: 'monospace',
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
//  SECTION 7 — RECIPE CARD
// =====================================================================

class _PrivateRecipeCard extends StatelessWidget {
  const _PrivateRecipeCard();

  static const String _code =
      'FilterChip(\n'
      '  label: const Text(\'Sci-Fi\'),\n'
      '  selected: true,\n'
      '  onSelected: (v) {},\n'
      '  avatar: const Icon(Icons.bolt, size: 18),\n'
      '  labelStyle: const TextStyle(\n'
      '    fontWeight: FontWeight.w600,\n'
      '    color: Colors.white,\n'
      '  ),\n'
      '  labelPadding: const EdgeInsets.symmetric(horizontal: 4),\n'
      '  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),\n'
      '  shape: const StadiumBorder(),\n'
      '  side: const BorderSide(color: Color(0xFF6C5CE7)),\n'
      '  backgroundColor: const Color(0xFFEDEAFE),\n'
      '  selectedColor: const Color(0xFF6C5CE7),\n'
      '  checkmarkColor: Colors.white,\n'
      '  showCheckmark: true,\n'
      '  elevation: 4,\n'
      '  pressElevation: 8,\n'
      '  shadowColor: const Color(0xFF7A5AF8),\n'
      '  surfaceTintColor: Colors.transparent,\n'
      '  visualDensity: VisualDensity.standard,\n'
      '  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,\n'
      '  clipBehavior: Clip.antiAlias,\n'
      '  iconTheme: const IconThemeData(color: Colors.white, size: 16),\n'
      '),';

  @override
  Widget build(BuildContext context) {
    return _PrivateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.menu_book_outlined, color: _kViolet),
              const SizedBox(width: 8),
              const _PrivateLabel('Recipe — Fully styled FilterChip',
                  bold: true),
              const Spacer(),
              FilterChip(
                label: const Text('Sci-Fi'),
                selected: true,
                onSelected: (_) {},
                avatar: const Icon(Icons.bolt, size: 18, color: Colors.white),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 4),
                shape: const StadiumBorder(),
                side: const BorderSide(color: _kAccent),
                backgroundColor: _kAccentSoft,
                selectedColor: _kAccent,
                checkmarkColor: Colors.white,
                showCheckmark: true,
                elevation: 4,
                pressElevation: 8,
                shadowColor: _kViolet,
                surfaceTintColor: Colors.transparent,
                visualDensity: VisualDensity.standard,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                clipBehavior: Clip.antiAlias,
                iconTheme:
                    const IconThemeData(color: Colors.white, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _kInk,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              _code,
              style: TextStyle(
                color: Color(0xFFD6BCFA),
                fontFamily: 'monospace',
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
//  SECTION 8 — CHIPTHEME CASCADE PANEL
// =====================================================================

class _PrivateThemePanel extends StatelessWidget {
  const _PrivateThemePanel();

  Widget _row(String name) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: <Widget>[
        Chip(label: Text('$name a')),
        Chip(label: Text('$name b')),
        FilterChip(
          label: Text('$name c'),
          selected: true,
          onSelected: (_) {},
        ),
        FilterChip(
          label: Text('$name d'),
          selected: false,
          onSelected: (_) {},
        ),
        ActionChip(
          label: Text('$name e'),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _PrivateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _PrivateLabel('default theme', bold: true),
          const SizedBox(height: 4),
          const _PrivateMiniCaption(
              'No surrounding ChipTheme — uses ThemeData.chipTheme.'),
          const SizedBox(height: 12),
          _row('default'),
          const SizedBox(height: 18),
          const Divider(height: 1, color: _kLine),
          const SizedBox(height: 14),
          const _PrivateLabel('with ChipTheme override', bold: true),
          const SizedBox(height: 4),
          const _PrivateMiniCaption(
              'Wrapped in ChipTheme(data: ChipThemeData(...)) — values cascade to children.'),
          const SizedBox(height: 12),
          ChipTheme(
            data: ChipThemeData(
              backgroundColor: _kVioletSoft,
              selectedColor: _kViolet,
              checkmarkColor: Colors.white,
              labelStyle: const TextStyle(
                color: _kInk,
                fontWeight: FontWeight.w600,
              ),
              secondaryLabelStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              shape: const StadiumBorder(),
              side: const BorderSide(color: _kViolet),
              elevation: 2,
              pressElevation: 6,
              shadowColor: _kViolet,
              brightness: Brightness.light,
              iconTheme: const IconThemeData(color: _kViolet, size: 16),
            ),
            child: _row('themed'),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
//  SECTION 9 — PITFALLS
// =====================================================================

class _PrivatePitfalls extends StatelessWidget {
  const _PrivatePitfalls();

  static const List<List<String>> _items = <List<String>>[
    <String>[
      'FilterChip stays disabled if onSelected is null',
      'A FilterChip is "enabled" only when onSelected is non-null. Passing only `selected:` without a callback yields a non-interactive look.',
    ],
    <String>[
      'deleteIcon shows only on Deletable subclasses',
      'Setting deleteIcon on a plain ChoiceChip does nothing — only Chip / InputChip / RawChip mix DeletableChipAttributes.',
    ],
    <String>[
      'RawChip is the kitchen sink — use sparingly',
      'RawChip exposes everything but offers no opinion. Reach for it only when none of the named subclasses fit.',
    ],
    <String>[
      'shape and side interact',
      'When `shape` is an OutlinedBorder with its own side, an explicit `side:` overrides only the side — not the radius.',
    ],
    <String>[
      'Color and backgroundColor coexist',
      'In M3, `color: WidgetStateProperty<Color?>` resolves first; if null, `backgroundColor` is used.',
    ],
    <String>[
      'showCheckmark only matters for Selectable+Checkmarkable chips',
      'On Chip/ActionChip it is ignored.',
    ],
    <String>[
      'visualDensity affects size more than padding',
      'Density adjusts component minimums; pairing with `padding` can yield surprising overlaps.',
    ],
    <String>[
      'iconTheme is for in-chip icons, not avatar CircleAvatars',
      'A CircleAvatar does not use the chip\'s iconTheme — only Icon widgets inside the chip do.',
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return _PrivateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (int i = 0; i < _items.length; i++) ...<Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _kWarnSoft,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.warning_amber_outlined,
                      color: _kWarn, size: 16),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _items[i][0],
                        style: const TextStyle(
                          color: _kInk,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _items[i][1],
                        style: const TextStyle(
                          color: _kSubInk,
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (i + 1 != _items.length) ...<Widget>[
              const SizedBox(height: 12),
              const Divider(height: 1, color: _kLine),
              const SizedBox(height: 12),
            ],
          ],
        ],
      ),
    );
  }
}

// =====================================================================
//  SECTION 10 — FOOTER (PALETTE + VERSION)
// =====================================================================

class _PrivateFooter extends StatelessWidget {
  const _PrivateFooter();

  static const List<List<dynamic>> _swatches = <List<dynamic>>[
    <dynamic>['ink', _kInk],
    <dynamic>['sub-ink', _kSubInk],
    <dynamic>['faint', _kFaint],
    <dynamic>['paper', _kPaper],
    <dynamic>['line', _kLine],
    <dynamic>['accent', _kAccent],
    <dynamic>['accent-soft', _kAccentSoft],
    <dynamic>['violet', _kViolet],
    <dynamic>['violet-soft', _kVioletSoft],
    <dynamic>['positive', _kPositive],
    <dynamic>['positive-soft', _kPositiveSoft],
    <dynamic>['warn', _kWarn],
    <dynamic>['warn-soft', _kWarnSoft],
    <dynamic>['danger', _kDanger],
    <dynamic>['danger-soft', _kDangerSoft],
    <dynamic>['info', _kInfo],
    <dynamic>['info-soft', _kInfoSoft],
    <dynamic>['teal', _kTeal],
    <dynamic>['teal-soft', _kTealSoft],
    <dynamic>['rose', _kRose],
    <dynamic>['rose-soft', _kRoseSoft],
  ];

  @override
  Widget build(BuildContext context) {
    return _PrivateCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _PrivateLabel('Palette', bold: true),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              for (final List<dynamic> sw in _swatches)
                Container(
                  width: 130,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _kPaper,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _kLine),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: sw[1] as Color,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: _kLine),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          sw[0] as String,
                          style: const TextStyle(
                            color: _kInk,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 18),
          const Divider(height: 1, color: _kLine),
          const SizedBox(height: 12),
          Row(
            children: const <Widget>[
              Icon(Icons.label_outline, color: _kSubInk, size: 16),
              SizedBox(width: 6),
              Text(
                'demo: chip_attributes_test  ·  v1.0  ·  hand-authored',
                style: TextStyle(color: _kSubInk, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

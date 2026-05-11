// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true),
    home: Scaffold(
      backgroundColor: const Color(0xFFF6F4EE),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 60),
          child: Column(children: const <Widget>[
            _HeroCard(),
            SizedBox(height: 28),
            _InterfaceAnatomySection(),
            SizedBox(height: 28),
            _ConstructorSection(),
            SizedBox(height: 28),
            _AppBarGallerySection(),
            SizedBox(height: 28),
            _BottomOfAppBarSection(),
            SizedBox(height: 28),
            _TabBarInPreferredSection(),
            SizedBox(height: 28),
            _SizeFactoriesSection(),
            SizedBox(height: 28),
            _ParentLayoutFlowSection(),
            SizedBox(height: 28),
            _CustomImplementationSection(),
            SizedBox(height: 28),
            _PitfallsSection(),
            SizedBox(height: 28),
            _UseCasesSection(),
            SizedBox(height: 28),
            _RecipeCodeSection(),
            SizedBox(height: 28),
            _FooterStamp(),
          ]),
        ),
      ),
    ),
  );
}

// ===================================================================
// SHARED PRIMITIVES
// ===================================================================

class _SectionHeader extends StatelessWidget {
  final String label;
  final String title;
  final String subtitle;
  final Color accent;
  final IconData icon;
  const _SectionHeader({
    required this.label,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            accent.withValues(alpha: 0.18),
            const Color(0xFFFFFFFF),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accent.withValues(alpha: 0.45), width: 1.4),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(children: <Widget>[
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(14),
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: const Color(0xFFFFFFFF), size: 24),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: accent,
                  letterSpacing: 1.6,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1F1A33),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12.5,
                  height: 1.4,
                  color: Color(0xFF4A465A),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class _CardShell extends StatelessWidget {
  final Widget child;
  final Color border;
  final EdgeInsets padding;
  const _CardShell({
    required this.child,
    required this.border,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border, width: 1.1),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _Chip extends StatelessWidget {
  final String text;
  final Color color;
  const _Chip(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.45), width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  final String code;
  final Color accent;
  const _CodeBlock({required this.code, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFF1B1A2C), Color(0xFF2A2740)],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.6), width: 1),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.5,
          height: 1.45,
          color: Color(0xFFE7E3FA),
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String head;
  final String body;
  final Color color;
  final IconData icon;
  const _Bullet({
    required this.head,
    required this.body,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.35), width: 1),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: const Color(0xFFFFFFFF), size: 16),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                head,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.4,
                  color: Color(0xFF3D3852),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

// ===================================================================
// 1. HERO CARD
// ===================================================================

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 26),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF3D5A80),
            Color(0xFF98C1D9),
            Color(0xFFEE6C4D),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Row(children: <Widget>[
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF).withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFFFFFFF).withValues(alpha: 0.55),
                width: 1.4,
              ),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.aspect_ratio,
              color: Color(0xFFFFFFFF),
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'PREFERRED SIZE',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFFFEDE3),
                    letterSpacing: 2.4,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Telling parents what size you would like to be',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFFFFFFF),
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ]),
        const SizedBox(height: 18),
        const Text(
          'A PreferredSizeWidget reports an intrinsic size to its parent. '
          'Slots like Scaffold.appBar and Scaffold.bottomNavigationBar use this '
          'hint to allocate space before laying the child out.',
          style: TextStyle(
            fontSize: 13,
            height: 1.5,
            color: Color(0xFFFAF5EF),
          ),
        ),
        const SizedBox(height: 18),
        Row(children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF).withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Size getter only',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF).withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Implemented by AppBar',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
        ]),
      ]),
    );
  }
}

// ===================================================================
// 2. INTERFACE ANATOMY
// ===================================================================

class _InterfaceAnatomySection extends StatelessWidget {
  const _InterfaceAnatomySection();

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: const <Widget>[
      _SectionHeader(
        label: 'SECTION 01',
        title: 'Interface anatomy',
        subtitle:
            'PreferredSizeWidget exposes exactly one getter: preferredSize → Size. '
            'Any widget can adopt the interface to advertise its desired metrics.',
        accent: Color(0xFF3D5A80),
        icon: Icons.account_tree_outlined,
      ),
      SizedBox(height: 14),
      _InterfaceDiagram(),
      SizedBox(height: 12),
      _ImplementersGrid(),
    ]);
  }
}

class _InterfaceDiagram extends StatelessWidget {
  const _InterfaceDiagram();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      border: const Color(0xFFC8D3E2),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xFFEAF1F9), Color(0xFFD5E2F0)],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF3D5A80), width: 1.2),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const <Widget>[
            Text(
              'abstract class PreferredSizeWidget',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1F2E47),
              ),
            ),
            SizedBox(height: 4),
            Text(
              '    implements Widget',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Color(0xFF4A5A75),
              ),
            ),
            SizedBox(height: 8),
            Text(
              '  Size get preferredSize;',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF7B2727),
              ),
            ),
          ]),
        ),
        const SizedBox(height: 14),
        Row(children: const <Widget>[
          Expanded(
            child: _FieldRow(
              label: 'preferredSize',
              type: 'Size',
              note: 'Intrinsic hint in logical pixels',
              color: Color(0xFF3D5A80),
            ),
          ),
        ]),
        const SizedBox(height: 8),
        Row(children: const <Widget>[
          Expanded(
            child: _FieldRow(
              label: 'Implements',
              type: 'Widget',
              note: 'Still must produce an Element / RenderObject',
              color: Color(0xFFEE6C4D),
            ),
          ),
        ]),
      ]),
    );
  }
}

class _FieldRow extends StatelessWidget {
  final String label;
  final String type;
  final String note;
  final Color color;
  const _FieldRow({
    required this.label,
    required this.type,
    required this.note,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.45), width: 1),
      ),
      child: Row(children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          type,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            note,
            style: const TextStyle(
              fontSize: 11.5,
              color: Color(0xFF4A465A),
            ),
          ),
        ),
      ]),
    );
  }
}

class _ImplementersGrid extends StatelessWidget {
  const _ImplementersGrid();

  @override
  Widget build(BuildContext context) {
    return Column(children: const <Widget>[
      Row(children: <Widget>[
        Expanded(
          child: _ImplementerCard(
            name: 'AppBar',
            size: 'Size.fromHeight(56)',
            note: 'Material toolbar at top of Scaffold',
            color: Color(0xFF3D5A80),
            icon: Icons.web_asset,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _ImplementerCard(
            name: 'TabBar',
            size: 'Size.fromHeight(46)',
            note: 'Row of tabs, often inside AppBar.bottom',
            color: Color(0xFFEE6C4D),
            icon: Icons.tab,
          ),
        ),
      ]),
      SizedBox(height: 10),
      Row(children: <Widget>[
        Expanded(
          child: _ImplementerCard(
            name: 'PreferredSize',
            size: 'Size.fromHeight(any)',
            note: 'Wrap any widget with a custom size hint',
            color: Color(0xFF6A4C93),
            icon: Icons.aspect_ratio,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _ImplementerCard(
            name: 'SliverAppBar.medium',
            size: 'Size.fromHeight(112)',
            note: 'Sliver variant with expanded title region',
            color: Color(0xFF118AB2),
            icon: Icons.expand_more,
          ),
        ),
      ]),
    ]);
  }
}

class _ImplementerCard extends StatelessWidget {
  final String name;
  final String size;
  final String note;
  final Color color;
  final IconData icon;
  const _ImplementerCard({
    required this.name,
    required this.size,
    required this.note,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.6), width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Row(children: <Widget>[
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: const Color(0xFFFFFFFF), size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          ),
        ]),
        const SizedBox(height: 8),
        Text(
          size,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: Color(0xFF3D3852),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          note,
          style: const TextStyle(
            fontSize: 11,
            height: 1.35,
            color: Color(0xFF5A556A),
          ),
        ),
      ]),
    );
  }
}

// ===================================================================
// 3. CONSTRUCTOR
// ===================================================================

class _ConstructorSection extends StatelessWidget {
  const _ConstructorSection();

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: const <Widget>[
      _SectionHeader(
        label: 'SECTION 02',
        title: 'The PreferredSize wrapper',
        subtitle:
            'PreferredSize is the simplest implementer. Pass any Widget plus an '
            'explicit Size and the wrapper advertises that size to its parent.',
        accent: Color(0xFF6A4C93),
        icon: Icons.construction,
      ),
      SizedBox(height: 14),
      _ConstructorBox(),
      SizedBox(height: 12),
      _ParamBreakdown(),
    ]);
  }
}

class _ConstructorBox extends StatelessWidget {
  const _ConstructorBox();

  @override
  Widget build(BuildContext context) {
    return _CodeBlock(
      accent: const Color(0xFF6A4C93),
      code:
          'const PreferredSize({\n'
          '  super.key,\n'
          '  required this.preferredSize, // Size\n'
          '  required this.child,         // Widget\n'
          '});',
    );
  }
}

class _ParamBreakdown extends StatelessWidget {
  const _ParamBreakdown();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      border: const Color(0xFFD3C8E5),
      child: Column(children: const <Widget>[
        _ParamRow(
          name: 'preferredSize',
          type: 'Size',
          required: true,
          note: 'The intrinsic size hint. Read by parents like Scaffold.appBar.',
          color: Color(0xFF6A4C93),
        ),
        SizedBox(height: 10),
        _ParamRow(
          name: 'child',
          type: 'Widget',
          required: true,
          note: 'The actual rendered widget. Can be anything — Container, Row, etc.',
          color: Color(0xFFEE6C4D),
        ),
        SizedBox(height: 10),
        _ParamRow(
          name: 'key',
          type: 'Key?',
          required: false,
          note: 'Optional widget key, inherited from Widget.',
          color: Color(0xFF3D5A80),
        ),
      ]),
    );
  }
}

class _ParamRow extends StatelessWidget {
  final String name;
  final String type;
  final bool required;
  final String note;
  final Color color;
  const _ParamRow({
    required this.name,
    required this.type,
    required this.required,
    required this.note,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.35), width: 1),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            name,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(children: <Widget>[
                Text(
                  type,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: required
                        ? const Color(0xFFEE6C4D)
                        : const Color(0xFF98C1D9),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    required ? 'required' : 'optional',
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFFFFFFF),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ]),
              const SizedBox(height: 4),
              Text(
                note,
                style: const TextStyle(
                  fontSize: 11.5,
                  height: 1.4,
                  color: Color(0xFF3D3852),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

// ===================================================================
// 4. APPBAR GALLERY
// ===================================================================

class _AppBarGallerySection extends StatelessWidget {
  const _AppBarGallerySection();

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: const <Widget>[
      _SectionHeader(
        label: 'SECTION 03',
        title: 'Live AppBar gallery',
        subtitle:
            'AppBar implements PreferredSizeWidget so Scaffold can reserve the '
            'exact vertical slot. Four common configurations shown below.',
        accent: Color(0xFFEE6C4D),
        icon: Icons.view_carousel_outlined,
      ),
      SizedBox(height: 14),
      _AppBarMockGrid(),
    ]);
  }
}

class _AppBarMockGrid extends StatelessWidget {
  const _AppBarMockGrid();

  @override
  Widget build(BuildContext context) {
    return Column(children: const <Widget>[
      _AppBarMock(
        title: 'Standard toolbar',
        height: 56,
        gradient: <Color>[Color(0xFF3D5A80), Color(0xFF98C1D9)],
        leadingIcon: Icons.menu,
        labelText: 'Inbox',
        actions: <IconData>[Icons.search, Icons.more_vert],
        hasSubrow: false,
        isTall: false,
      ),
      SizedBox(height: 10),
      _AppBarMock(
        title: 'Compact 48',
        height: 48,
        gradient: <Color>[Color(0xFF6A4C93), Color(0xFFB39DDB)],
        leadingIcon: Icons.arrow_back,
        labelText: 'Settings',
        actions: <IconData>[Icons.check],
        hasSubrow: false,
        isTall: false,
      ),
      SizedBox(height: 10),
      _AppBarMock(
        title: 'Tall hero (96)',
        height: 96,
        gradient: <Color>[Color(0xFFEE6C4D), Color(0xFFFFB67A)],
        leadingIcon: Icons.menu,
        labelText: 'Discover',
        actions: <IconData>[Icons.notifications_none, Icons.account_circle],
        hasSubrow: true,
        isTall: true,
      ),
      SizedBox(height: 10),
      _AppBarMock(
        title: 'Double row (112)',
        height: 112,
        gradient: <Color>[Color(0xFF118AB2), Color(0xFF06D6A0)],
        leadingIcon: Icons.menu,
        labelText: 'Library',
        actions: <IconData>[Icons.filter_list, Icons.more_vert],
        hasSubrow: true,
        isTall: true,
      ),
    ]);
  }
}

class _AppBarMock extends StatelessWidget {
  final String title;
  final double height;
  final List<Color> gradient;
  final IconData leadingIcon;
  final String labelText;
  final List<IconData> actions;
  final bool hasSubrow;
  final bool isTall;
  const _AppBarMock({
    required this.title,
    required this.height,
    required this.gradient,
    required this.leadingIcon,
    required this.labelText,
    required this.actions,
    required this.hasSubrow,
    required this.isTall,
  });

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      border: gradient.first.withValues(alpha: 0.55),
      padding: const EdgeInsets.all(12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Row(children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: gradient.first,
            ),
          ),
          const Spacer(),
          _Chip('Size.fromHeight(${height.toStringAsFixed(0)})', gradient.first),
        ]),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradient,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: gradient.first.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(children: <Widget>[
                Icon(leadingIcon, color: const Color(0xFFFFFFFF), size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    labelText,
                    style: TextStyle(
                      fontSize: isTall ? 18 : 14,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFFFFFFFF),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    for (final IconData a in actions) ...<Widget>[
                      Icon(a, color: const Color(0xFFFFFFFF), size: 18),
                      const SizedBox(width: 8),
                    ],
                  ],
                ),
              ]),
              if (hasSubrow) ...<Widget>[
                const SizedBox(height: 6),
                Container(
                  height: 26,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF).withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Search or browse...',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Reported preferredSize.height = ${height.toStringAsFixed(0)} '
          'logical px. Scaffold layouts this much vertical space.',
          style: const TextStyle(
            fontSize: 11,
            height: 1.4,
            color: Color(0xFF5A556A),
          ),
        ),
      ]),
    );
  }
}

// ===================================================================
// 5. BOTTOM OF APPBAR
// ===================================================================

class _BottomOfAppBarSection extends StatelessWidget {
  const _BottomOfAppBarSection();

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: const <Widget>[
      _SectionHeader(
        label: 'SECTION 04',
        title: 'PreferredSize as AppBar.bottom',
        subtitle:
            'AppBar.bottom is typed as PreferredSizeWidget. Wrap any custom '
            'widget with PreferredSize to nest it below the toolbar.',
        accent: Color(0xFF118AB2),
        icon: Icons.vertical_align_bottom,
      ),
      SizedBox(height: 14),
      _PhoneFrame(),
      SizedBox(height: 12),
      _BottomCode(),
    ]);
  }
}

class _PhoneFrame extends StatelessWidget {
  const _PhoneFrame();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 260,
        decoration: BoxDecoration(
          color: const Color(0xFF1F1A33),
          borderRadius: BorderRadius.circular(28),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0x44000000),
              blurRadius: 16,
              offset: Offset(0, 8),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Container(
            color: const Color(0xFFF6F4EE),
            height: 380,
            child: Column(children: <Widget>[
              // Status bar
              Container(
                height: 22,
                color: const Color(0xFF1F1A33),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(children: const <Widget>[
                  Text(
                    '9:41',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.wifi, color: Color(0xFFFFFFFF), size: 12),
                  SizedBox(width: 4),
                  Icon(Icons.battery_full, color: Color(0xFFFFFFFF), size: 12),
                ]),
              ),
              // Real AppBar with bottom PreferredSize area
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Color(0xFF118AB2), Color(0xFF06D6A0)],
                  ),
                ),
                child: Column(children: <Widget>[
                  // Top toolbar
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(children: const <Widget>[
                      Icon(Icons.menu, color: Color(0xFFFFFFFF), size: 20),
                      SizedBox(width: 12),
                      Text(
                        'Photo Library',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.search, color: Color(0xFFFFFFFF), size: 18),
                    ]),
                  ),
                  // Bottom PreferredSize segment
                  Container(
                    height: 40,
                    color: const Color(0xFF000000).withValues(alpha: 0.18),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    alignment: Alignment.centerLeft,
                    child: Row(children: const <Widget>[
                      _SegPill('Albums', true),
                      SizedBox(width: 6),
                      _SegPill('Places', false),
                      SizedBox(width: 6),
                      _SegPill('People', false),
                    ]),
                  ),
                ]),
              ),
              // Body filler
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(children: <Widget>[
                    for (int i = 0; i < 3; i++)
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE7E3FA),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                  ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class _SegPill extends StatelessWidget {
  final String text;
  final bool active;
  const _SegPill(this.text, this.active);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: active
            ? const Color(0xFFFFFFFF)
            : const Color(0xFFFFFFFF).withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: active ? const Color(0xFF118AB2) : const Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}

class _BottomCode extends StatelessWidget {
  const _BottomCode();

  @override
  Widget build(BuildContext context) {
    return _CodeBlock(
      accent: const Color(0xFF118AB2),
      code:
          'AppBar(\n'
          '  title: const Text(\'Photo Library\'),\n'
          '  bottom: PreferredSize(\n'
          '    preferredSize: const Size.fromHeight(40.0),\n'
          '    child: Row(\n'
          '      children: <Widget>[\n'
          '        SegPill(\'Albums\', active: true),\n'
          '        SegPill(\'Places\'),\n'
          '        SegPill(\'People\'),\n'
          '      ],\n'
          '    ),\n'
          '  ),\n'
          ')',
    );
  }
}

// ===================================================================
// 6. TABBAR IN PREFERREDSIZE
// ===================================================================

class _TabBarInPreferredSection extends StatelessWidget {
  const _TabBarInPreferredSection();

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: const <Widget>[
      _SectionHeader(
        label: 'SECTION 05',
        title: 'TabBar inside PreferredSize',
        subtitle:
            'TabBar itself is a PreferredSizeWidget. Wrapping it in PreferredSize '
            'lets you control its height and surrounding decoration.',
        accent: Color(0xFFEC4899),
        icon: Icons.tab,
      ),
      SizedBox(height: 14),
      _TabBarVisualMock(),
      SizedBox(height: 12),
      _TabBarCode(),
    ]);
  }
}

class _TabBarVisualMock extends StatelessWidget {
  const _TabBarVisualMock();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      border: const Color(0xFFEC4899),
      child: Column(children: <Widget>[
        Container(
          height: 48,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xFFEC4899), Color(0xFFFB7185)],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(children: const <Widget>[
            _TabItem(label: 'Home', active: true),
            _TabItem(label: 'Search', active: false),
            _TabItem(label: 'Saved', active: false),
            _TabItem(label: 'Account', active: false),
          ]),
        ),
        const SizedBox(height: 10),
        Row(children: const <Widget>[
          _Chip('Size.fromHeight(48)', Color(0xFFEC4899)),
          SizedBox(width: 6),
          _Chip('PreferredSize', Color(0xFF6A4C93)),
          SizedBox(width: 6),
          _Chip('Gradient bg', Color(0xFFEE6C4D)),
        ]),
      ]),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool active;
  const _TabItem({required this.label, required this.active});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
        decoration: BoxDecoration(
          color: active
              ? const Color(0xFFFFFFFF)
              : const Color(0xFFFFFFFF).withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: active ? const Color(0xFFEC4899) : const Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }
}

class _TabBarCode extends StatelessWidget {
  const _TabBarCode();

  @override
  Widget build(BuildContext context) {
    return _CodeBlock(
      accent: const Color(0xFFEC4899),
      code:
          'PreferredSize(\n'
          '  preferredSize: const Size.fromHeight(48.0),\n'
          '  child: TabBar(\n'
          '    controller: tabController,\n'
          '    tabs: const <Widget>[\n'
          '      Tab(text: \'Home\'),\n'
          '      Tab(text: \'Search\'),\n'
          '      Tab(text: \'Saved\'),\n'
          '      Tab(text: \'Account\'),\n'
          '    ],\n'
          '  ),\n'
          ')',
    );
  }
}

// ===================================================================
// 7. SIZE FACTORIES
// ===================================================================

class _SizeFactoriesSection extends StatelessWidget {
  const _SizeFactoriesSection();

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: const <Widget>[
      _SectionHeader(
        label: 'SECTION 06',
        title: 'Size construction patterns',
        subtitle:
            'Common factories for building the preferredSize value. Most AppBar '
            'slots only consult height — width is treated as fill.',
        accent: Color(0xFF06D6A0),
        icon: Icons.straighten,
      ),
      SizedBox(height: 14),
      _SizeTable(),
    ]);
  }
}

class _SizeTable extends StatelessWidget {
  const _SizeTable();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      border: const Color(0xFFB7E4D2),
      child: Column(children: const <Widget>[
        _SizeRow(
          factory: 'Size.fromHeight(56.0)',
          eq: 'Size(infinity, 56.0)',
          usecase: 'Standard AppBar height',
          color: Color(0xFF06D6A0),
        ),
        SizedBox(height: 8),
        _SizeRow(
          factory: 'Size.fromHeight(80.0)',
          eq: 'Size(infinity, 80.0)',
          usecase: 'Roomier custom header',
          color: Color(0xFF118AB2),
        ),
        SizedBox(height: 8),
        _SizeRow(
          factory: 'Size.fromWidth(120.0)',
          eq: 'Size(120.0, infinity)',
          usecase: 'Vertical side-rail header (rare)',
          color: Color(0xFFEE6C4D),
        ),
        SizedBox(height: 8),
        _SizeRow(
          factory: 'Size(double.infinity, 56.0)',
          eq: 'Manually built',
          usecase: 'Explicit fill-width header',
          color: Color(0xFF6A4C93),
        ),
        SizedBox(height: 8),
        _SizeRow(
          factory: 'Size.zero',
          eq: 'Size(0, 0)',
          usecase: 'Hide a PreferredSizeWidget entirely',
          color: Color(0xFFEC4899),
        ),
        SizedBox(height: 8),
        _SizeRow(
          factory: 'Size.square(48.0)',
          eq: 'Size(48.0, 48.0)',
          usecase: 'Square hint (compact icon-only bars)',
          color: Color(0xFF3D5A80),
        ),
      ]),
    );
  }
}

class _SizeRow extends StatelessWidget {
  final String factory;
  final String eq;
  final String usecase;
  final Color color;
  const _SizeRow({
    required this.factory,
    required this.eq,
    required this.usecase,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Row(children: <Widget>[
          Text(
            factory,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              eq,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
        ]),
        const SizedBox(height: 4),
        Text(
          usecase,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF3D3852),
          ),
        ),
      ]),
    );
  }
}

// ===================================================================
// 8. PARENT LAYOUT FLOW
// ===================================================================

class _ParentLayoutFlowSection extends StatelessWidget {
  const _ParentLayoutFlowSection();

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: const <Widget>[
      _SectionHeader(
        label: 'SECTION 07',
        title: 'What the parent does with preferredSize',
        subtitle:
            'Scaffold (and similar) reads preferredSize first, reserves the '
            'slot, then lays out the child with tight constraints in that area.',
        accent: Color(0xFFFFB67A),
        icon: Icons.swap_vert,
      ),
      SizedBox(height: 14),
      _FlowDiagram(),
    ]);
  }
}

class _FlowDiagram extends StatelessWidget {
  const _FlowDiagram();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      border: const Color(0xFFFFD7B7),
      child: Column(children: const <Widget>[
        _FlowStep(
          step: '1',
          title: 'Parent reads preferredSize',
          body: 'Scaffold.appBar.preferredSize → e.g. Size(infinity, 56).',
          color: Color(0xFF3D5A80),
          icon: Icons.visibility_outlined,
        ),
        SizedBox(height: 8),
        _FlowArrow(),
        SizedBox(height: 8),
        _FlowStep(
          step: '2',
          title: 'Parent reserves slot',
          body: 'A 56-tall band is allocated at the top before laying out body.',
          color: Color(0xFF118AB2),
          icon: Icons.crop_landscape,
        ),
        SizedBox(height: 8),
        _FlowArrow(),
        SizedBox(height: 8),
        _FlowStep(
          step: '3',
          title: 'Parent lays out child',
          body: 'AppBar is given BoxConstraints.tight(Size(viewportWidth, 56)).',
          color: Color(0xFFEE6C4D),
          icon: Icons.crop_din,
        ),
        SizedBox(height: 8),
        _FlowArrow(),
        SizedBox(height: 8),
        _FlowStep(
          step: '4',
          title: 'Body fills remaining space',
          body: 'The rest of the viewport flows below the reserved band.',
          color: Color(0xFF06D6A0),
          icon: Icons.view_agenda_outlined,
        ),
      ]),
    );
  }
}

class _FlowStep extends StatelessWidget {
  final String step;
  final String title;
  final String body;
  final Color color;
  final IconData icon;
  const _FlowStep({
    required this.step,
    required this.title,
    required this.body,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            color.withValues(alpha: 0.12),
            const Color(0xFFFFFFFF),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.45), width: 1),
      ),
      child: Row(children: <Widget>[
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            step,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 11.5,
                  height: 1.4,
                  color: Color(0xFF3D3852),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class _FlowArrow extends StatelessWidget {
  const _FlowArrow();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.arrow_downward,
        color: Color(0xFFFFB67A),
        size: 20,
      ),
    );
  }
}

// ===================================================================
// 9. CUSTOM IMPLEMENTATION
// ===================================================================

class _CustomImplementationSection extends StatelessWidget {
  const _CustomImplementationSection();

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: const <Widget>[
      _SectionHeader(
        label: 'SECTION 08',
        title: 'Custom PreferredSizeWidget',
        subtitle:
            'For more reuse than PreferredSize wrapping, implement the interface '
            'directly. Override preferredSize and build like any StatelessWidget.',
        accent: Color(0xFF7B68EE),
        icon: Icons.code,
      ),
      SizedBox(height: 14),
      _CustomCode(),
      SizedBox(height: 12),
      _CustomNotes(),
    ]);
  }
}

class _CustomCode extends StatelessWidget {
  const _CustomCode();

  @override
  Widget build(BuildContext context) {
    return _CodeBlock(
      accent: const Color(0xFF7B68EE),
      code:
          'class FancyHeader extends StatelessWidget\n'
          '    implements PreferredSizeWidget {\n'
          '  const FancyHeader({super.key, required this.title});\n'
          '  final String title;\n'
          '\n'
          '  @override\n'
          '  Size get preferredSize => const Size.fromHeight(72.0);\n'
          '\n'
          '  @override\n'
          '  Widget build(BuildContext context) {\n'
          '    return Container(\n'
          '      padding: const EdgeInsets.symmetric(horizontal: 16),\n'
          '      decoration: const BoxDecoration(\n'
          '        gradient: LinearGradient(\n'
          '          colors: <Color>[Color(0xFF3D5A80), Color(0xFF98C1D9)],\n'
          '        ),\n'
          '      ),\n'
          '      alignment: Alignment.centerLeft,\n'
          '      child: Text(title,\n'
          '          style: const TextStyle(\n'
          '            fontSize: 20, fontWeight: FontWeight.w800,\n'
          '            color: Color(0xFFFFFFFF),\n'
          '          )),\n'
          '    );\n'
          '  }\n'
          '}',
    );
  }
}

class _CustomNotes extends StatelessWidget {
  const _CustomNotes();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      border: const Color(0xFFD3C8E5),
      child: Column(children: const <Widget>[
        _Bullet(
          head: 'Single getter contract',
          body: 'preferredSize is the only API surface — keep it pure and stable.',
          color: Color(0xFF7B68EE),
          icon: Icons.check_circle_outline,
        ),
        _Bullet(
          head: 'Const where possible',
          body: 'Return a const Size.fromHeight(...) — avoids rebuild churn.',
          color: Color(0xFF06D6A0),
          icon: Icons.bolt,
        ),
        _Bullet(
          head: 'No layout work in the getter',
          body: 'Do not call MediaQuery or any layout APIs inside preferredSize.',
          color: Color(0xFFEE6C4D),
          icon: Icons.do_not_disturb_alt,
        ),
      ]),
    );
  }
}

// ===================================================================
// 10. PITFALLS
// ===================================================================

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: const <Widget>[
      _SectionHeader(
        label: 'SECTION 09',
        title: 'Pitfalls and gotchas',
        subtitle:
            'PreferredSize is a hint, not a guarantee. Mind the edges where '
            'reality diverges from the advertised size.',
        accent: Color(0xFFDC2626),
        icon: Icons.warning_amber_outlined,
      ),
      SizedBox(height: 14),
      _PitfallsList(),
    ]);
  }
}

class _PitfallsList extends StatelessWidget {
  const _PitfallsList();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      border: const Color(0xFFFCA5A5),
      child: Column(children: const <Widget>[
        _Bullet(
          head: 'preferredSize must be finite',
          body: 'Avoid double.infinity in BOTH width and height — Scaffold will '
              'use the size verbatim and infinite dimensions break layout math.',
          color: Color(0xFFDC2626),
          icon: Icons.block,
        ),
        _Bullet(
          head: 'Children can still exceed the hint',
          body: 'preferredSize does not constrain children. Oversized children '
              'overflow visually even though the slot is sized correctly.',
          color: Color(0xFFEE6C4D),
          icon: Icons.warning,
        ),
        _Bullet(
          head: 'Parents are free to ignore',
          body: 'Not every parent reads preferredSize. Custom container widgets '
              'may treat the child as a regular widget and ignore the hint.',
          color: Color(0xFF7B2727),
          icon: Icons.layers_clear,
        ),
        _Bullet(
          head: 'SafeArea & padding stack on top',
          body: 'The reserved slot does NOT auto-include status bar padding. '
              'Wrap your child or budget for it in preferredSize manually.',
          color: Color(0xFF6A4C93),
          icon: Icons.format_indent_decrease,
        ),
        _Bullet(
          head: 'Const matters',
          body: 'Returning a non-const Size from preferredSize on every build '
              'still works but causes unnecessary Size allocations.',
          color: Color(0xFF118AB2),
          icon: Icons.memory,
        ),
      ]),
    );
  }
}

// ===================================================================
// 11. USE CASES
// ===================================================================

class _UseCasesSection extends StatelessWidget {
  const _UseCasesSection();

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: const <Widget>[
      _SectionHeader(
        label: 'SECTION 10',
        title: 'Use cases',
        subtitle:
            'When and where preferred-size widgets shine in real Flutter apps.',
        accent: Color(0xFF06D6A0),
        icon: Icons.lightbulb_outline,
      ),
      SizedBox(height: 14),
      _UseCaseGrid(),
    ]);
  }
}

class _UseCaseGrid extends StatelessWidget {
  const _UseCaseGrid();

  @override
  Widget build(BuildContext context) {
    return Column(children: const <Widget>[
      Row(children: <Widget>[
        Expanded(
          child: _UseCaseCard(
            title: 'Custom AppBar replacement',
            body: 'Replace Material AppBar with a fully branded header while '
                'keeping Scaffold layout math intact.',
            icon: Icons.brush,
            color: Color(0xFF3D5A80),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _UseCaseCard(
            title: 'Hero / title regions',
            body: 'Use Size.fromHeight(140) to declare a tall hero band with '
                'photography, gradients or breadcrumbs.',
            icon: Icons.image_outlined,
            color: Color(0xFFEE6C4D),
          ),
        ),
      ]),
      SizedBox(height: 10),
      Row(children: <Widget>[
        Expanded(
          child: _UseCaseCard(
            title: 'Scroll-fade headers',
            body: 'Wrap a custom widget that animates opacity / blur into '
                'PreferredSize so Scaffold reserves the right band.',
            icon: Icons.gradient,
            color: Color(0xFF6A4C93),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _UseCaseCard(
            title: 'Bottom navigation strip',
            body: 'AppBar.bottom + PreferredSize lets you append a sub-toolbar '
                'with filters, search, segments, etc.',
            icon: Icons.dynamic_feed_outlined,
            color: Color(0xFF06D6A0),
          ),
        ),
      ]),
    ]);
  }
}

class _UseCaseCard extends StatelessWidget {
  final String title;
  final String body;
  final IconData icon;
  final Color color;
  const _UseCaseCard({
    required this.title,
    required this.body,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            color.withValues(alpha: 0.14),
            const Color(0xFFFFFFFF),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(9),
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: const Color(0xFFFFFFFF), size: 18),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          body,
          style: const TextStyle(
            fontSize: 11.5,
            height: 1.4,
            color: Color(0xFF3D3852),
          ),
        ),
      ]),
    );
  }
}

// ===================================================================
// 12. RECIPE CODE
// ===================================================================

class _RecipeCodeSection extends StatelessWidget {
  const _RecipeCodeSection();

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: const <Widget>[
      _SectionHeader(
        label: 'SECTION 11',
        title: 'Canonical recipe',
        subtitle:
            'The minimal, idiomatic snippet to drop into a Scaffold.appBar slot.',
        accent: Color(0xFF1F1A33),
        icon: Icons.menu_book_outlined,
      ),
      SizedBox(height: 14),
      _RecipeBlock(),
      SizedBox(height: 12),
      _RecipeNotes(),
    ]);
  }
}

class _RecipeBlock extends StatelessWidget {
  const _RecipeBlock();

  @override
  Widget build(BuildContext context) {
    return _CodeBlock(
      accent: const Color(0xFF1F1A33),
      code:
          'appBar: PreferredSize(\n'
          '  preferredSize: const Size.fromHeight(80.0),\n'
          '  child: Container(\n'
          '    color: Theme.of(context).primaryColor,\n'
          '    alignment: Alignment.centerLeft,\n'
          '    padding: const EdgeInsets.symmetric(horizontal: 16),\n'
          '    child: const Text(\'Fancy header\'),\n'
          '  ),\n'
          ')',
    );
  }
}

class _RecipeNotes extends StatelessWidget {
  const _RecipeNotes();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      border: const Color(0xFF1F1A33),
      child: Column(children: const <Widget>[
        _Bullet(
          head: 'Always const the Size',
          body: 'const Size.fromHeight(80.0) prevents repeated allocations.',
          color: Color(0xFF1F1A33),
          icon: Icons.tag,
        ),
        _Bullet(
          head: 'Stay finite',
          body: 'Avoid double.infinity in height — Size.fromHeight already '
              'sets width to infinity which is what slots expect.',
          color: Color(0xFFDC2626),
          icon: Icons.error_outline,
        ),
        _Bullet(
          head: 'Decoration goes on child',
          body: 'PreferredSize itself draws nothing; decorate the child Container.',
          color: Color(0xFF118AB2),
          icon: Icons.palette_outlined,
        ),
      ]),
    );
  }
}

// ===================================================================
// 13. FOOTER
// ===================================================================

class _FooterStamp extends StatelessWidget {
  const _FooterStamp();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF1F1A33),
            Color(0xFF3D5A80),
            Color(0xFF06D6A0),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Row(children: <Widget>[
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF).withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.aspect_ratio,
              color: Color(0xFFFFFFFF),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'PreferredSize visual deep demo',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Hand-authored — flutter/material.dart only',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFFE7E3FA),
                  ),
                ),
              ],
            ),
          ),
        ]),
        const SizedBox(height: 12),
        Row(children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'v1.0.0',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'static snapshot',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
        ]),
      ]),
    );
  }
}

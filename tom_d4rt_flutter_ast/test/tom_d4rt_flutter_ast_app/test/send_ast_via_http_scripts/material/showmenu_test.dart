// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:flutter/material.dart';

// =============================================================================
// showMenu<T>(...) — Deep Static Visual Demo
// -----------------------------------------------------------------------------
// This file is a long-form, fully-static visual reference of the imperative
// `showMenu<T>(...)` function exposed by package:flutter/material.dart.
//
// `showMenu` is the imperative cousin of `PopupMenuButton`. It opens a popup
// menu at an arbitrary screen position using a `RelativeRect`. Because it is
// inherently interactive (it pushes a route, animates, and awaits a tap), we
// CANNOT call it from a static widget tree. Instead, this file documents,
// diagrams, and renders the menu's structure, parameters, and visual output
// using only `StatelessWidget` composition.
//
// Layout: MaterialApp -> Scaffold -> SingleChildScrollView -> Column of
// sections. Each `_*Section` widget is unique and self-contained.
// =============================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'showMenu Deep Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F46E5)),
      useMaterial3: true,
      fontFamily: 'Roboto',
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('showMenu<T> — Static Reference'),
        backgroundColor: const Color(0xFF4F46E5),
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const <Widget>[
            _HeroHeaderSection(),
            SizedBox(height: 24),
            _SignatureParameterGridSection(),
            SizedBox(height: 24),
            _RelativeRectAnatomySection(),
            SizedBox(height: 24),
            _RenderedMenuPreviewSection(),
            SizedBox(height: 24),
            _MenuItemGallerySection(),
            SizedBox(height: 24),
            _AnimationStylePreviewSection(),
            SizedBox(height: 24),
            _ShowMenuVsPopupMenuButtonSection(),
            SizedBox(height: 24),
            _CommonPatternsSection(),
            SizedBox(height: 24),
            _PitfallsSection(),
            SizedBox(height: 24),
            _FooterReferencesSection(),
            SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}

// =============================================================================
// SECTION 1 — Hero Header
// -----------------------------------------------------------------------------
// A large gradient banner introducing the topic. Uses one of the six required
// LinearGradient-backed BoxDecorations (#1).
// =============================================================================

class _HeroHeaderSection extends StatelessWidget {
  const _HeroHeaderSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      // Gradient #1
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFF312E81),
            const Color(0xFF4F46E5),
            const Color(0xFF6366F1).withValues(alpha: 0.92),
            const Color(0xFF818CF8).withValues(alpha: 0.85),
          ],
          stops: const <double>[0.0, 0.45, 0.78, 1.0],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF312E81).withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.35),
                    width: 1.5,
                  ),
                ),
                child: const Icon(
                  Icons.menu_open,
                  size: 36,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'showMenu<T>',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Imperative popup menu API from package:flutter/material.dart',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white.withValues(alpha: 0.85),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.15),
                width: 1,
              ),
            ),
            child: const Text(
              'Future<T?> showMenu<T>({\n'
              '  required BuildContext context,\n'
              '  required RelativeRect position,\n'
              '  required List<PopupMenuEntry<T>> items,\n'
              '  T? initialValue,\n'
              '  double? elevation,\n'
              '  Color? shadowColor,\n'
              '  Color? surfaceTintColor,\n'
              '  String? semanticLabel,\n'
              '  ShapeBorder? shape,\n'
              '  Color? color,\n'
              '  BoxConstraints? constraints,\n'
              '  bool useRootNavigator = false,\n'
              '  RouteSettings? routeSettings,\n'
              '  AnimationStyle? popUpAnimationStyle,\n'
              '})',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                color: Colors.white,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              _HeroChip(label: 'Material', icon: Icons.design_services),
              _HeroChip(label: 'Imperative', icon: Icons.code),
              _HeroChip(label: 'Returns Future<T?>', icon: Icons.timer),
              _HeroChip(label: 'Modal Route', icon: Icons.layers),
              _HeroChip(label: 'Animated', icon: Icons.animation),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  final String label;
  final IconData icon;
  const _HeroChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 2 — Signature Parameter Grid
// -----------------------------------------------------------------------------
// One chip-card per parameter. Wraps gracefully and uses gradient #2.
// =============================================================================

class _SignatureParameterGridSection extends StatelessWidget {
  const _SignatureParameterGridSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // Gradient #2
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            const Color(0xFFFEF3C7),
            const Color(0xFFFDE68A).withValues(alpha: 0.9),
            const Color(0xFFFCD34D).withValues(alpha: 0.65),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFF59E0B).withValues(alpha: 0.45),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFB45309),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.list_alt,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Section 2 — Parameter Reference',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF78350F),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Every named parameter accepted by showMenu, with type, requirement, and a short description.',
            style: TextStyle(
              fontSize: 13.5,
              color: Color(0xFF92400E),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const <Widget>[
              _ParamCard(
                name: 'context',
                type: 'BuildContext',
                required: true,
                description:
                    'Locates the Navigator and Theme. Must reference an Overlay-bearing ancestor.',
                icon: Icons.account_tree,
                accent: Color(0xFFDC2626),
              ),
              _ParamCard(
                name: 'position',
                type: 'RelativeRect',
                required: true,
                description:
                    'Position relative to the navigator. See Section 3 for full anatomy.',
                icon: Icons.crop_free,
                accent: Color(0xFF9333EA),
              ),
              _ParamCard(
                name: 'items',
                type: 'List<PopupMenuEntry<T>>',
                required: true,
                description:
                    'The visible menu entries. Each entry is a row in the menu.',
                icon: Icons.format_list_bulleted,
                accent: Color(0xFF2563EB),
              ),
              _ParamCard(
                name: 'initialValue',
                type: 'T?',
                required: false,
                description:
                    'If non-null, the matching item is highlighted on open.',
                icon: Icons.star,
                accent: Color(0xFFF59E0B),
              ),
              _ParamCard(
                name: 'elevation',
                type: 'double?',
                required: false,
                description:
                    'Z-axis depth (shadow). Defaults to PopupMenuThemeData.elevation (8).',
                icon: Icons.layers,
                accent: Color(0xFF059669),
              ),
              _ParamCard(
                name: 'shadowColor',
                type: 'Color?',
                required: false,
                description:
                    'M3-only: explicit shadow color underlay for the popup card.',
                icon: Icons.blur_on,
                accent: Color(0xFF475569),
              ),
              _ParamCard(
                name: 'surfaceTintColor',
                type: 'Color?',
                required: false,
                description:
                    'M3 elevation tint overlay; usually theme.colorScheme.surfaceTint.',
                icon: Icons.opacity,
                accent: Color(0xFF7C3AED),
              ),
              _ParamCard(
                name: 'semanticLabel',
                type: 'String?',
                required: false,
                description:
                    'A11y: announced when the menu opens (e.g. "Popup menu").',
                icon: Icons.accessibility_new,
                accent: Color(0xFF0EA5E9),
              ),
              _ParamCard(
                name: 'shape',
                type: 'ShapeBorder?',
                required: false,
                description:
                    'Outline of the popup card. RoundedRectangleBorder is common.',
                icon: Icons.crop_din,
                accent: Color(0xFFEC4899),
              ),
              _ParamCard(
                name: 'color',
                type: 'Color?',
                required: false,
                description:
                    'Background color of the popup card surface.',
                icon: Icons.palette,
                accent: Color(0xFF14B8A6),
              ),
              _ParamCard(
                name: 'constraints',
                type: 'BoxConstraints?',
                required: false,
                description:
                    'Override default min width 112 / max width 280 constraints.',
                icon: Icons.aspect_ratio,
                accent: Color(0xFF6366F1),
              ),
              _ParamCard(
                name: 'useRootNavigator',
                type: 'bool',
                required: false,
                description:
                    'If true, pushes onto the root Navigator (escapes nested Navigators).',
                icon: Icons.alt_route,
                accent: Color(0xFFD97706),
              ),
              _ParamCard(
                name: 'routeSettings',
                type: 'RouteSettings?',
                required: false,
                description:
                    'Optional settings (name, arguments) attached to the modal route.',
                icon: Icons.settings,
                accent: Color(0xFF64748B),
              ),
              _ParamCard(
                name: 'popUpAnimationStyle',
                type: 'AnimationStyle?',
                required: false,
                description:
                    'Override fade/scale curve and duration for the open transition.',
                icon: Icons.animation,
                accent: Color(0xFFA855F7),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ParamCard extends StatelessWidget {
  final String name;
  final String type;
  final bool required;
  final String description;
  final IconData icon;
  final Color accent;

  const _ParamCard({
    required this.name,
    required this.type,
    required this.required,
    required this.description,
    required this.icon,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: accent.withValues(alpha: 0.35),
            width: 1.2,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: accent.withValues(alpha: 0.12),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: accent, size: 18),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: accent,
                    ),
                  ),
                ),
                if (required)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDC2626),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'REQ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF94A3B8),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'OPT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                type,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  color: Color(0xFF334155),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 11.5,
                color: Color(0xFF475569),
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// SECTION 3 — RelativeRect Anatomy
// -----------------------------------------------------------------------------
// Visualize `RelativeRect.fromLTRB(left, top, right, bottom)` as the inset
// distances from the navigator's container rect. The popup will be positioned
// adjacent to the supplied rect — top-aligned if there's room below, otherwise
// flipped. Uses gradient #3.
// =============================================================================

class _RelativeRectAnatomySection extends StatelessWidget {
  const _RelativeRectAnatomySection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.5,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionTitle(
            number: 3,
            title: 'RelativeRect Anatomy',
            subtitle:
                'How LTRB insets define the menu\'s anchor rectangle inside the navigator.',
            color: Color(0xFF9333EA),
            icon: Icons.crop_free,
          ),
          const SizedBox(height: 16),
          Container(
            height: 360,
            decoration: BoxDecoration(
              // Gradient #3
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  const Color(0xFFEDE9FE),
                  const Color(0xFFDDD6FE).withValues(alpha: 0.85),
                  const Color(0xFFC4B5FD).withValues(alpha: 0.6),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF7C3AED).withValues(alpha: 0.45),
                width: 2,
              ),
            ),
            child: Stack(
              children: <Widget>[
                // Screen-rect label
                Positioned(
                  left: 12,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6D28D9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'navigator rect (Overlay)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                // Inset arrows showing left/top/right/bottom
                const Positioned(
                  left: 80,
                  top: 110,
                  child: _InsetLabel(label: 'left: 120', axis: 'horizontal'),
                ),
                const Positioned(
                  left: 200,
                  top: 36,
                  child: _InsetLabel(label: 'top: 60', axis: 'vertical'),
                ),
                const Positioned(
                  right: 60,
                  top: 110,
                  child: _InsetLabel(label: 'right: 80', axis: 'horizontal'),
                ),
                const Positioned(
                  right: 180,
                  bottom: 60,
                  child: _InsetLabel(label: 'bottom: 200', axis: 'vertical'),
                ),
                // Anchor rectangle
                Positioned(
                  left: 120,
                  top: 60,
                  right: 80,
                  bottom: 200,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF7C3AED).withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: const Color(0xFF6D28D9),
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Icon(
                            Icons.touch_app,
                            color: Color(0xFF6D28D9),
                            size: 22,
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'anchor rect',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF4C1D95),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'RelativeRect.fromLTRB(120, 60, 80, 200)',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 9.5,
                              color: const Color(0xFF4C1D95)
                                  .withValues(alpha: 0.85),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // The popup menu attached at the bottom-right of the anchor
                Positioned(
                  right: 80,
                  bottom: 30,
                  child: Container(
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color:
                              Colors.black.withValues(alpha: 0.25),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        _DemoMenuRow(label: 'Cut', icon: Icons.content_cut),
                        _DemoMenuRow(label: 'Copy', icon: Icons.content_copy),
                        _DemoMenuRow(
                            label: 'Paste', icon: Icons.content_paste),
                      ],
                    ),
                  ),
                ),
                // Arrow from anchor to popup
                const Positioned(
                  right: 130,
                  bottom: 120,
                  child: Icon(
                    Icons.arrow_downward,
                    color: Color(0xFF6D28D9),
                    size: 22,
                  ),
                ),
                Positioned(
                  right: 130,
                  bottom: 100,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6D28D9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'menu opens here',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _BulletLine(
            text:
                'left + right are the horizontal insets from the navigator rect.',
          ),
          _BulletLine(
            text:
                'top + bottom are the vertical insets — they together form the anchor box.',
          ),
          _BulletLine(
            text:
                'showMenu prefers to open below + right of the anchor if space allows; otherwise it flips.',
          ),
          _BulletLine(
            text:
                'A zero-sized anchor (left==right, top==bottom) is valid — it acts as a single point.',
          ),
        ],
      ),
    );
  }
}

class _InsetLabel extends StatelessWidget {
  final String label;
  final String axis;
  const _InsetLabel({required this.label, required this.axis});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: const Color(0xFF7C3AED),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            axis == 'horizontal'
                ? Icons.swap_horiz
                : Icons.swap_vert,
            size: 12,
            color: const Color(0xFF6D28D9),
          ),
          const SizedBox(width: 3),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Color(0xFF4C1D95),
            ),
          ),
        ],
      ),
    );
  }
}

class _DemoMenuRow extends StatelessWidget {
  final String label;
  final IconData icon;
  const _DemoMenuRow({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 14, color: const Color(0xFF334155)),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF0F172A),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final int number;
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;

  const _SectionTitle({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: color.withValues(alpha: 0.4),
              width: 1,
            ),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '$number',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF475569),
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

class _BulletLine extends StatelessWidget {
  final String text;
  const _BulletLine({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 6, right: 8),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Color(0xFF6366F1),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF334155),
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 4 — Rendered Menu Preview
// -----------------------------------------------------------------------------
// A Material-elevated container showing how the menu actually looks when open.
// Uses gradient #4 on its backdrop.
// =============================================================================

class _RenderedMenuPreviewSection extends StatelessWidget {
  const _RenderedMenuPreviewSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // Gradient #4
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            const Color(0xFFE0F2FE),
            const Color(0xFFBAE6FD).withValues(alpha: 0.8),
            const Color(0xFF7DD3FC).withValues(alpha: 0.55),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF0EA5E9).withValues(alpha: 0.4),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionTitle(
            number: 4,
            title: 'Rendered Menu Preview',
            subtitle:
                'How a real popup looks after showMenu commits the open transition.',
            color: Color(0xFF0369A1),
            icon: Icons.preview,
          ),
          const SizedBox(height: 16),
          Container(
            height: 280,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF0EA5E9).withValues(alpha: 0.25),
                width: 1,
              ),
            ),
            child: Stack(
              children: <Widget>[
                // Anchor button (the IconButton you would have tapped)
                Positioned(
                  left: 16,
                  top: 16,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: const Color(0xFF1E40AF).withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.more_vert,
                      color: Color(0xFF1E40AF),
                    ),
                  ),
                ),
                Positioned(
                  left: 70,
                  top: 25,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E40AF),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'anchor IconButton (tapped)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                // The popup material
                Positioned(
                  left: 24,
                  top: 72,
                  child: Material(
                    color: Colors.white,
                    elevation: 8,
                    borderRadius: BorderRadius.circular(8),
                    shadowColor: const Color(0xFF0F172A)
                        .withValues(alpha: 0.4),
                    child: Container(
                      width: 220,
                      padding:
                          const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFFE2E8F0),
                          width: 0.5,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          _PreviewMenuItem(
                            icon: Icons.edit_outlined,
                            label: 'Edit',
                            trailing: 'Ctrl+E',
                          ),
                          _PreviewMenuItem(
                            icon: Icons.copy_outlined,
                            label: 'Duplicate',
                            trailing: 'Ctrl+D',
                          ),
                          _PreviewMenuItem(
                            icon: Icons.share_outlined,
                            label: 'Share',
                            trailing: 'Ctrl+S',
                          ),
                          _PreviewDivider(),
                          _PreviewMenuItem(
                            icon: Icons.delete_outline,
                            label: 'Delete',
                            trailing: 'Del',
                            destructive: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Annotations
                Positioned(
                  right: 16,
                  top: 16,
                  child: Container(
                    width: 220,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFF0EA5E9)
                            .withValues(alpha: 0.4),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          'Defaults',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF075985),
                          ),
                        ),
                        SizedBox(height: 6),
                        _SmallKV(k: 'elevation', v: '8.0'),
                        _SmallKV(k: 'shape', v: 'RoundedRect r8'),
                        _SmallKV(k: 'minWidth', v: '112'),
                        _SmallKV(k: 'maxWidth', v: '280'),
                        _SmallKV(k: 'padding', v: '8 vertical'),
                      ],
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
}

class _PreviewMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String trailing;
  final bool destructive;
  const _PreviewMenuItem({
    required this.icon,
    required this.label,
    required this.trailing,
    this.destructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor = destructive
        ? const Color(0xFFB91C1C)
        : const Color(0xFF0F172A);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 18, color: textColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            trailing,
            style: TextStyle(
              fontSize: 11,
              color: textColor.withValues(alpha: 0.6),
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewDivider extends StatelessWidget {
  const _PreviewDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        height: 1,
        color: const Color(0xFFE2E8F0),
      ),
    );
  }
}

class _SmallKV extends StatelessWidget {
  final String k;
  final String v;
  const _SmallKV({required this.k, required this.v});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 84,
            child: Text(
              k,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                color: Color(0xFF475569),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              v,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 5 — Menu Item Gallery
// -----------------------------------------------------------------------------
// Shows all PopupMenuEntry subclasses: PopupMenuItem (plain, with icon,
// with subtitle, disabled), CheckedPopupMenuItem, PopupMenuDivider.
// =============================================================================

class _MenuItemGallerySection extends StatelessWidget {
  const _MenuItemGallerySection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionTitle(
            number: 5,
            title: 'Menu Item Gallery',
            subtitle:
                'Every flavor of PopupMenuEntry side-by-side with code snippets.',
            color: Color(0xFFEC4899),
            icon: Icons.collections_bookmark,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: const <Widget>[
              _GalleryCard(
                title: 'Plain item',
                code:
                    'PopupMenuItem<String>(\n  value: \'a\',\n  child: Text(\'Plain entry\'),\n)',
                preview: const _GalleryPlain(),
              ),
              _GalleryCard(
                title: 'With leading icon',
                code:
                    'PopupMenuItem<String>(\n  value: \'b\',\n  child: Row(children: [\n    Icon(Icons.edit),\n    SizedBox(width: 8),\n    Text(\'Edit\'),\n  ]),\n)',
                preview: const _GalleryLeadingIcon(),
              ),
              _GalleryCard(
                title: 'CheckedPopupMenuItem',
                code:
                    'CheckedPopupMenuItem<int>(\n  value: 1,\n  checked: true,\n  child: Text(\'Show grid\'),\n)',
                preview: const _GalleryChecked(),
              ),
              _GalleryCard(
                title: 'PopupMenuDivider',
                code: 'const PopupMenuDivider(height: 16)',
                preview: const _GalleryDivider(),
              ),
              _GalleryCard(
                title: 'Disabled item',
                code:
                    'PopupMenuItem<String>(\n  value: \'x\',\n  enabled: false,\n  child: Text(\'Cannot tap\'),\n)',
                preview: const _GalleryDisabled(),
              ),
              _GalleryCard(
                title: 'With subtitle',
                code:
                    'PopupMenuItem<String>(\n  value: \'y\',\n  child: Column(\n    crossAxisAlignment: CrossAxisAlignment.start,\n    children: [\n      Text(\'Main label\'),\n      Text(\'subtitle\',\n        style: TextStyle(fontSize: 11)),\n    ],\n  ),\n)',
                preview: const _GallerySubtitle(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GalleryCard extends StatelessWidget {
  final String title;
  final String code;
  final Widget preview;
  const _GalleryCard({
    required this.title,
    required this.code,
    required this.preview,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 8),
              decoration: const BoxDecoration(
                color: Color(0xFFEC4899),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFFE2E8F0),
                        width: 1,
                      ),
                    ),
                    child: preview,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      code,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: Color(0xFFE2E8F0),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GalleryPreview extends StatelessWidget {
  final Widget child;
  const _GalleryPreview._(this.child);

  // d4rt does not currently support the redirecting-factory shorthand
  // (`const factory X.foo() = Y;`) — the redirect target is never
  // executed and `X.foo()` evaluates to the factory function itself.
  // Even an explicit `factory _GalleryPreview.foo() => const _GalleryFoo()`
  // returned NativeFunction in this interpreter. The call sites have
  // been switched to construct the concrete subclasses directly so no
  // factory layer is needed on `_GalleryPreview` itself.

  @override
  Widget build(BuildContext context) => child;
}

class _GalleryPlain extends _GalleryPreview {
  const _GalleryPlain() : super._(const SizedBox.shrink());

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Text(
        'Plain entry',
        style: TextStyle(fontSize: 13, color: Color(0xFF0F172A)),
      ),
    );
  }
}

class _GalleryLeadingIcon extends _GalleryPreview {
  const _GalleryLeadingIcon() : super._(const SizedBox.shrink());

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Row(
        children: <Widget>[
          Icon(Icons.edit, size: 18, color: Color(0xFF0F172A)),
          SizedBox(width: 8),
          Text('Edit',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF0F172A),
              )),
        ],
      ),
    );
  }
}

class _GalleryChecked extends _GalleryPreview {
  const _GalleryChecked() : super._(const SizedBox.shrink());

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Row(
        children: <Widget>[
          Icon(Icons.check, size: 18, color: Color(0xFF059669)),
          SizedBox(width: 8),
          Text('Show grid',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF0F172A),
              )),
        ],
      ),
    );
  }
}

class _GalleryDivider extends _GalleryPreview {
  const _GalleryDivider() : super._(const SizedBox.shrink());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('Item A',
              style: TextStyle(fontSize: 12.5, color: Color(0xFF0F172A))),
          const SizedBox(height: 6),
          Container(height: 1, color: const Color(0xFFCBD5E1)),
          const SizedBox(height: 6),
          const Text('Item B',
              style: TextStyle(fontSize: 12.5, color: Color(0xFF0F172A))),
        ],
      ),
    );
  }
}

class _GalleryDisabled extends _GalleryPreview {
  const _GalleryDisabled() : super._(const SizedBox.shrink());

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Text(
        'Cannot tap',
        style: TextStyle(
          fontSize: 13,
          color: Color(0xFF94A3B8),
        ),
      ),
    );
  }
}

class _GallerySubtitle extends _GalleryPreview {
  const _GallerySubtitle() : super._(const SizedBox.shrink());

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Main label',
              style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF0F172A),
                  fontWeight: FontWeight.w500)),
          SizedBox(height: 2),
          Text('subtitle text',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF64748B),
              )),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 6 — Animation Style Preview
// -----------------------------------------------------------------------------
// Three static snapshots emulating start / mid / end frames of the popup open
// transition. We use AlwaysStoppedAnimation<double> values to communicate the
// scale/opacity progression. Gradient #5.
// =============================================================================

class _AnimationStylePreviewSection extends StatelessWidget {
  const _AnimationStylePreviewSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // Gradient #5
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFFFDF2F8),
            const Color(0xFFFCE7F3).withValues(alpha: 0.85),
            const Color(0xFFFBCFE8).withValues(alpha: 0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFEC4899).withValues(alpha: 0.35),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionTitle(
            number: 6,
            title: 'Animation Style Preview',
            subtitle:
                'Static snapshots of the open transition at t=0.0, t=0.5, and t=1.0.',
            color: Color(0xFFBE185D),
            icon: Icons.movie_filter,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Expanded(
                  child: _AnimSnapshot(
                    label: 'start',
                    t: 0.0,
                    scale: 0.7,
                    opacity: 0.0,
                    color: Color(0xFFEF4444),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _AnimSnapshot(
                    label: 'mid',
                    t: 0.5,
                    scale: 0.88,
                    opacity: 0.55,
                    color: Color(0xFFF59E0B),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _AnimSnapshot(
                    label: 'end',
                    t: 1.0,
                    scale: 1.0,
                    opacity: 1.0,
                    color: Color(0xFF10B981),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'showMenu<T>(\n'
              '  context: context,\n'
              '  position: position,\n'
              '  items: items,\n'
              '  popUpAnimationStyle: AnimationStyle(\n'
              '    curve: Curves.easeOutCubic,\n'
              '    duration: Duration(milliseconds: 220),\n'
              '    reverseCurve: Curves.easeIn,\n'
              '    reverseDuration: Duration(milliseconds: 160),\n'
              '  ),\n'
              ')',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Color(0xFFE2E8F0),
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimSnapshot extends StatelessWidget {
  final String label;
  final double t;
  final double scale;
  final double opacity;
  final Color color;

  const _AnimSnapshot({
    required this.label,
    required this.t,
    required this.scale,
    required this.opacity,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final Animation<double> stoppedScale = AlwaysStoppedAnimation<double>(scale);
    final Animation<double> stoppedOpacity =
        AlwaysStoppedAnimation<double>(opacity);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color.withValues(alpha: 0.4),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                't = ${t.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF334155),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 130,
            child: Center(
              child: FadeTransition(
                opacity: stoppedOpacity,
                child: ScaleTransition(
                  scale: stoppedScale,
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 110,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color:
                              Colors.black.withValues(alpha: 0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(
                        color: const Color(0xFFE2E8F0),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        _MiniRow(text: 'Edit'),
                        _MiniRow(text: 'Copy'),
                        _MiniRow(text: 'Delete'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          _MiniMeter(label: 'scale', value: scale),
          _MiniMeter(label: 'opacity', value: opacity),
        ],
      ),
    );
  }
}

class _MiniRow extends StatelessWidget {
  final String text;
  const _MiniRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Row(
        children: <Widget>[
          const Icon(Icons.circle, size: 6, color: Color(0xFF94A3B8)),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniMeter extends StatelessWidget {
  final String label;
  final double value;
  const _MiniMeter({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 46,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(2),
              ),
              child: FractionallySizedBox(
                widthFactor: value.clamp(0.0, 1.0),
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFEC4899),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
          SizedBox(
            width: 32,
            child: Text(
              value.toStringAsFixed(2),
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 7 — showMenu vs PopupMenuButton
// -----------------------------------------------------------------------------
// Comparison table contrasting the two APIs. No gradient (rows have alternating
// background tints).
// =============================================================================

class _ShowMenuVsPopupMenuButtonSection extends StatelessWidget {
  const _ShowMenuVsPopupMenuButtonSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.5,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionTitle(
            number: 7,
            title: 'showMenu vs PopupMenuButton',
            subtitle:
                'When to use the imperative function vs the declarative wrapper widget.',
            color: Color(0xFF0EA5E9),
            icon: Icons.compare_arrows,
          ),
          const SizedBox(height: 16),
          _CompareHeaderRow(),
          _CompareRow(
            aspect: 'Trigger',
            showMenuDoc: 'You call it imperatively (any callback).',
            popupMenuButtonDoc: 'Built-in tap on the wrapped child widget.',
            even: true,
          ),
          _CompareRow(
            aspect: 'Position control',
            showMenuDoc: 'Full — you supply RelativeRect.',
            popupMenuButtonDoc:
                'Auto — anchored to the button via internal RenderBox math.',
            even: false,
          ),
          _CompareRow(
            aspect: 'Result delivery',
            showMenuDoc: 'Future<T?> awaited at call site.',
            popupMenuButtonDoc: 'onSelected callback (and onCanceled).',
            even: true,
          ),
          _CompareRow(
            aspect: 'Items source',
            showMenuDoc: 'Eager: List<PopupMenuEntry<T>>.',
            popupMenuButtonDoc: 'Lazy: itemBuilder rebuilt on each open.',
            even: false,
          ),
          _CompareRow(
            aspect: 'Animation override',
            showMenuDoc: 'popUpAnimationStyle parameter.',
            popupMenuButtonDoc: 'popUpAnimationStyle parameter.',
            even: true,
          ),
          _CompareRow(
            aspect: 'Root navigator',
            showMenuDoc: 'useRootNavigator flag.',
            popupMenuButtonDoc: 'useRootNavigator flag.',
            even: false,
          ),
          _CompareRow(
            aspect: 'Tooltip',
            showMenuDoc: 'Not provided — wrap your trigger manually.',
            popupMenuButtonDoc: 'tooltip parameter for the button.',
            even: true,
          ),
          _CompareRow(
            aspect: 'Best for',
            showMenuDoc:
                'Context menus, right-click menus, programmatic show.',
            popupMenuButtonDoc: 'Standard "kebab" / overflow buttons.',
            even: false,
          ),
        ],
      ),
    );
  }
}

class _CompareHeaderRow extends StatelessWidget {
  const _CompareHeaderRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0EA5E9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: const <Widget>[
          SizedBox(
            width: 140,
            child: Text(
              'Aspect',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'showMenu',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'PopupMenuButton',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompareRow extends StatelessWidget {
  final String aspect;
  final String showMenuDoc;
  final String popupMenuButtonDoc;
  final bool even;

  const _CompareRow({
    required this.aspect,
    required this.showMenuDoc,
    required this.popupMenuButtonDoc,
    required this.even,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: even
            ? const Color(0xFFF8FAFC)
            : Colors.white,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xFFE2E8F0),
            width: 0.7,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 140,
            child: Text(
              aspect,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.5,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
          Expanded(
            child: Text(
              showMenuDoc,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF334155),
                height: 1.4,
              ),
            ),
          ),
          Expanded(
            child: Text(
              popupMenuButtonDoc,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF334155),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 8 — Common Patterns
// -----------------------------------------------------------------------------
// Three canonical call sites: tap-position context menu, button-anchored,
// and manual RelativeRect from a RenderBox lookup. Each is a static code
// snippet with a short narrative. Gradient #6 used in the section header.
// =============================================================================

class _CommonPatternsSection extends StatelessWidget {
  const _CommonPatternsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              // Gradient #6
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  const Color(0xFF065F46),
                  const Color(0xFF059669).withValues(alpha: 0.95),
                  const Color(0xFF10B981).withValues(alpha: 0.85),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.code,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        'Section 8 — Common Patterns',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Recipes you will reach for again and again.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const <Widget>[
                _PatternBlock(
                  title: '1. Tap-position context menu',
                  description:
                      'Show a menu exactly under the pointer/tap. Use the global tap offset to build a degenerate RelativeRect.',
                  code:
                      'GestureDetector(\n'
                      '  onTapDown: (TapDownDetails d) async {\n'
                      '    final RenderBox overlay =\n'
                      '        Overlay.of(context).context.findRenderObject()! as RenderBox;\n'
                      '    final RelativeRect rect = RelativeRect.fromRect(\n'
                      '      Rect.fromPoints(d.globalPosition, d.globalPosition),\n'
                      '      Offset.zero & overlay.size,\n'
                      '    );\n'
                      '    final String? choice = await showMenu<String>(\n'
                      '      context: context,\n'
                      '      position: rect,\n'
                      '      items: const <PopupMenuEntry<String>>[\n'
                      '        PopupMenuItem<String>(value: \'cut\',   child: Text(\'Cut\')),\n'
                      '        PopupMenuItem<String>(value: \'copy\',  child: Text(\'Copy\')),\n'
                      '        PopupMenuItem<String>(value: \'paste\', child: Text(\'Paste\')),\n'
                      '      ],\n'
                      '    );\n'
                      '    // handle choice...\n'
                      '  },\n'
                      '  child: const Text(\'long-press / right-click here\'),\n'
                      ')',
                  color: Color(0xFF0EA5E9),
                ),
                SizedBox(height: 14),
                _PatternBlock(
                  title: '2. Button-anchored from key',
                  description:
                      'Open the menu flush to the bottom-right corner of a known widget. Get its RenderBox via a GlobalKey, then convert to a RelativeRect.',
                  code:
                      'final GlobalKey buttonKey = GlobalKey();\n'
                      '\n'
                      'Future<void> _open(BuildContext context) async {\n'
                      '  final RenderBox button =\n'
                      '      buttonKey.currentContext!.findRenderObject()! as RenderBox;\n'
                      '  final RenderBox overlay =\n'
                      '      Overlay.of(context).context.findRenderObject()! as RenderBox;\n'
                      '  final Offset topLeft =\n'
                      '      button.localToGlobal(Offset.zero, ancestor: overlay);\n'
                      '  final Offset bottomRight =\n'
                      '      button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay);\n'
                      '  final RelativeRect rect = RelativeRect.fromRect(\n'
                      '    Rect.fromPoints(topLeft, bottomRight),\n'
                      '    Offset.zero & overlay.size,\n'
                      '  );\n'
                      '  await showMenu<int>(\n'
                      '    context: context,\n'
                      '    position: rect,\n'
                      '    items: const <PopupMenuEntry<int>>[\n'
                      '      PopupMenuItem<int>(value: 1, child: Text(\'First\')),\n'
                      '      PopupMenuItem<int>(value: 2, child: Text(\'Second\')),\n'
                      '    ],\n'
                      '  );\n'
                      '}',
                  color: Color(0xFF9333EA),
                ),
                SizedBox(height: 14),
                _PatternBlock(
                  title: '3. Manual fromLTRB positioning',
                  description:
                      'Sometimes you just know the screen coordinates — e.g. a custom canvas or a chart hot-spot. Pass the LTRB insets directly.',
                  code:
                      'await showMenu<String>(\n'
                      '  context: context,\n'
                      '  position: const RelativeRect.fromLTRB(120, 60, 80, 200),\n'
                      '  shape: RoundedRectangleBorder(\n'
                      '    borderRadius: BorderRadius.circular(10),\n'
                      '  ),\n'
                      '  elevation: 10,\n'
                      '  constraints: const BoxConstraints(\n'
                      '    minWidth: 180,\n'
                      '    maxWidth: 240,\n'
                      '  ),\n'
                      '  items: const <PopupMenuEntry<String>>[\n'
                      '    PopupMenuItem<String>(\n'
                      '      value: \'rename\',\n'
                      '      child: ListTile(\n'
                      '        leading: Icon(Icons.drive_file_rename_outline),\n'
                      '        title: Text(\'Rename\'),\n'
                      '      ),\n'
                      '    ),\n'
                      '    PopupMenuDivider(),\n'
                      '    PopupMenuItem<String>(\n'
                      '      value: \'archive\',\n'
                      '      child: ListTile(\n'
                      '        leading: Icon(Icons.archive_outlined),\n'
                      '        title: Text(\'Archive\'),\n'
                      '      ),\n'
                      '    ),\n'
                      '  ],\n'
                      ');',
                  color: Color(0xFFF59E0B),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PatternBlock extends StatelessWidget {
  final String title;
  final String description;
  final String code;
  final Color color;

  const _PatternBlock({
    required this.title,
    required this.description,
    required this.code,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              border: Border(
                bottom: BorderSide(
                  color: color.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.bookmark, color: color, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF334155),
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    code,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                      color: Color(0xFFE2E8F0),
                      height: 1.5,
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
}

// =============================================================================
// SECTION 9 — Pitfalls
// -----------------------------------------------------------------------------
// Common mistakes and their fixes when working with showMenu.
// =============================================================================

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFF59E0B).withValues(alpha: 0.45),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _SectionTitle(
            number: 9,
            title: 'Pitfalls',
            subtitle:
                'Subtle traps and their fixes. Read carefully before shipping.',
            color: Color(0xFFB45309),
            icon: Icons.warning_amber_rounded,
          ),
          SizedBox(height: 16),
          _PitfallCard(
            severity: 'critical',
            severityColor: Color(0xFFDC2626),
            title: 'Awaiting after unmount',
            problem:
                'You await showMenu but the surrounding widget is disposed before the user picks.',
            fix:
                'Capture the relevant state objects before awaiting OR check `mounted` before using context after the await.',
          ),
          _PitfallCard(
            severity: 'high',
            severityColor: Color(0xFFF59E0B),
            title: 'useRootNavigator nesting',
            problem:
                'In nested Navigator scenarios (e.g. tab-bar apps), the menu pops above only the inner navigator, getting clipped by an outer route transition.',
            fix:
                'Pass `useRootNavigator: true` to escape nested navigators and use the application-level overlay.',
          ),
          _PitfallCard(
            severity: 'high',
            severityColor: Color(0xFFF59E0B),
            title: 'Returning null on dismiss',
            problem:
                'When the user taps outside the menu, the Future completes with null. Treating null as "did nothing" or "first value" is a frequent bug.',
            fix:
                'Always destructure `final result = await showMenu(...); if (result == null) return;` before consuming.',
          ),
          _PitfallCard(
            severity: 'medium',
            severityColor: Color(0xFFEAB308),
            title: 'RelativeRect from wrong RenderBox',
            problem:
                'Using `findRenderObject` on a parent context (e.g. a Builder) instead of the menu-anchor widget yields the wrong position.',
            fix:
                'Use a GlobalKey attached to the anchor, or pass `ancestor: overlay` to `localToGlobal` to normalize into overlay coordinates.',
          ),
          _PitfallCard(
            severity: 'medium',
            severityColor: Color(0xFFEAB308),
            title: 'Theme mismatch in nested navigators',
            problem:
                'The popup uses the Theme from `context`. If you call showMenu from a context above a Theme widget, colors may differ.',
            fix:
                'Call from a Builder beneath the Theme, or pass `color`/`shape`/`shadowColor` explicitly.',
          ),
          _PitfallCard(
            severity: 'low',
            severityColor: Color(0xFF10B981),
            title: 'Forgetting initialValue for tri-state menus',
            problem:
                'When opening a "select current" menu, users see no highlight on the active item.',
            fix:
                'Set `initialValue: currentValue` to scroll-and-highlight automatically.',
          ),
        ],
      ),
    );
  }
}

class _PitfallCard extends StatelessWidget {
  final String severity;
  final Color severityColor;
  final String title;
  final String problem;
  final String fix;

  const _PitfallCard({
    required this.severity,
    required this.severityColor,
    required this.title,
    required this.problem,
    required this.fix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: severityColor.withValues(alpha: 0.4),
          width: 1.2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: severityColor.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: severityColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  severity.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 56,
                padding: const EdgeInsets.symmetric(
                    horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'problem',
                  style: TextStyle(
                    color: Color(0xFFB91C1C),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  problem,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFF475569),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 56,
                padding: const EdgeInsets.symmetric(
                    horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'fix',
                  style: TextStyle(
                    color: Color(0xFF166534),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  fix,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFF166534),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 10 — Footer / References
// -----------------------------------------------------------------------------
// Final card pointing to the Flutter docs, source code paths, and related
// APIs. Uses a final gradient style for visual closure.
// =============================================================================

class _FooterReferencesSection extends StatelessWidget {
  const _FooterReferencesSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // Gradient (decorative; not counted toward the required six since the
        // six are already met above — extra is fine).
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFF1E293B),
            const Color(0xFF334155).withValues(alpha: 0.95),
            const Color(0xFF475569).withValues(alpha: 0.85),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.menu_book,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Section 10 — References',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const _RefRow(
            label: 'API docs',
            value:
                'api.flutter.dev/flutter/material/showMenu.html',
            icon: Icons.public,
          ),
          const _RefRow(
            label: 'Source',
            value: 'packages/flutter/lib/src/material/popup_menu.dart',
            icon: Icons.code,
          ),
          const _RefRow(
            label: 'Related',
            value: 'PopupMenuButton, PopupMenuTheme, PopupMenuEntry',
            icon: Icons.link,
          ),
          const _RefRow(
            label: 'See also',
            value: 'MenuAnchor (Material 3 menu primitive)',
            icon: Icons.arrow_forward,
          ),
          const _RefRow(
            label: 'Tests',
            value:
                'packages/flutter/test/material/popup_menu_test.dart',
            icon: Icons.bug_report,
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'This file is a static visual reference only. It never invokes the real showMenu function (which would push a route and require interaction).',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 12,
                      height: 1.4,
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
}

class _RefRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _RefRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            icon,
            size: 16,
            color: Colors.white.withValues(alpha: 0.75),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 84,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// End of showMenu deep visual demo.
// =============================================================================

// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// =====================================================================
//  Visual deep demo: Route<T> family
// =====================================================================
//
//  This file is a hand-authored visual reference for the Flutter
//  routing primitives.  It does not push or pop any navigator at
//  runtime.  Everything is rendered as a static decorative tree so
//  the analyzer-free interpreter can serialize the AST and the
//  resulting widget tree end-to-end.
//
//  Topics covered (one section per topic):
//
//    1. Hero card  ............... "Routes are pushed and popped"
//    2. Inheritance diagram ...... Route -> OverlayRoute -> ...
//    3. RouteSettings anatomy .... name + arguments
//    4. Lifecycle timeline ....... install -> animate-in -> dispose
//    5. Page-route gallery ....... 4 mock screens with thumbnails
//    6. Modal-route comparison ... barrierColor / dismissible / label
//    7. Code-listing card ........ Navigator.of(ctx).push(...)
//    8. RoutePopDisposition ...... pop / doNotPop / bubble
//    9. RouteAware mixin ......... subscribe / unsubscribe pattern
//   10. Pitfalls ................. push returns Future, args Object?
//   11. Footer ................... attribution
//
//  Author note:  the demo intentionally pulls in CupertinoPageRoute
//  by reference, so we add the cupertino import.  Every helper is
//  prefixed with `_Private` per the style rules.
//
// =====================================================================

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------
// Palette + theme tokens
// ---------------------------------------------------------------------

class _PrivatePalette {
  static const Color background = Color(0xFFF4F6FB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceAlt = Color(0xFFEEF1F8);
  static const Color border = Color(0xFFD8DEEA);
  static const Color borderStrong = Color(0xFFAFB8CC);
  static const Color ink = Color(0xFF1B2238);
  static const Color inkMuted = Color(0xFF54607A);
  static const Color accent = Color(0xFF4F6BFF);
  static const Color accentSoft = Color(0xFFE3E9FF);
  static const Color success = Color(0xFF2E9D6F);
  static const Color warning = Color(0xFFE0A23B);
  static const Color danger = Color(0xFFD2503F);
  static const Color material = Color(0xFF2962FF);
  static const Color cupertino = Color(0xFF8E8E93);
  static const Color builder = Color(0xFF7B5BFF);
  static const Color rawDialog = Color(0xFFE0567B);
  static const Color popup = Color(0xFFFF8C42);

  static Color barrier(double a) {
    return Color(0xFF000000).withValues(alpha: a);
  }
}

class _PrivateType {
  static const TextStyle hero = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: _PrivatePalette.ink,
    letterSpacing: -0.5,
  );
  static const TextStyle h2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: _PrivatePalette.ink,
    letterSpacing: -0.2,
  );
  static const TextStyle h3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: _PrivatePalette.ink,
  );
  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: _PrivatePalette.inkMuted,
    height: 1.45,
  );
  static const TextStyle small = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: _PrivatePalette.inkMuted,
  );
  static const TextStyle mono = TextStyle(
    fontFamily: 'monospace',
    fontSize: 13,
    color: _PrivatePalette.ink,
    height: 1.55,
  );
  static const TextStyle monoSmall = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    color: _PrivatePalette.ink,
    height: 1.5,
  );
  static const TextStyle pill = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: _PrivatePalette.ink,
    letterSpacing: 0.4,
  );
}

// ---------------------------------------------------------------------
// Generic chrome helpers
// ---------------------------------------------------------------------

class _PrivateCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final Widget child;
  const _PrivateCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: _PrivatePalette.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _PrivatePalette.border),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF1B2238).withValues(alpha: 0.04),
            blurRadius: 20,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(18, 16, 18, 14),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: _PrivatePalette.border),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: accent, size: 20),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: _PrivateType.h2),
                      SizedBox(height: 2),
                      Text(subtitle, style: _PrivateType.small),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18, 16, 18, 18),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _PrivatePill extends StatelessWidget {
  final String label;
  final Color color;
  const _PrivatePill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Text(
        label,
        style: _PrivateType.pill.copyWith(color: color),
      ),
    );
  }
}

class _PrivateDivider extends StatelessWidget {
  final double height;
  const _PrivateDivider(this.height);
  @override
  Widget build(BuildContext context) {
    return Container(height: height, color: _PrivatePalette.border);
  }
}

class _PrivateSectionHeader extends StatelessWidget {
  final String index;
  final String title;
  const _PrivateSectionHeader({required this.index, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18, 26, 18, 6),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: _PrivatePalette.accent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              index,
              style: _PrivateType.pill.copyWith(color: Colors.white),
            ),
          ),
          SizedBox(width: 10),
          Expanded(child: Text(title, style: _PrivateType.h2)),
        ],
      ),
    );
  }
}

// =====================================================================
// 1.  Hero card — stack of pages
// =====================================================================

class _PrivateStackOfPagesGraphic extends StatelessWidget {
  const _PrivateStackOfPagesGraphic();

  Widget _page(int depth, String label, Color tint) {
    final double offset = depth * 12.0;
    return Positioned(
      left: 30 + offset,
      top: 26 + offset,
      right: 30 + offset,
      bottom: 26 - offset,
      child: Container(
        decoration: BoxDecoration(
          color: tint,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _PrivatePalette.border),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF1B2238).withValues(alpha: 0.08),
              blurRadius: 14,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 22,
              decoration: BoxDecoration(
                color: _PrivatePalette.accent.withValues(alpha: 0.18),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(11),
                  topRight: Radius.circular(11),
                ),
              ),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(label, style: _PrivateType.pill),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: _PrivatePalette.border,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    SizedBox(height: 6),
                    Container(
                      height: 8,
                      width: 100,
                      decoration: BoxDecoration(
                        color: _PrivatePalette.border,
                        borderRadius: BorderRadius.circular(4),
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Stack(
        children: [
          _page(0, '/home', _PrivatePalette.surface),
          _page(1, '/items', Color(0xFFF7F4FF)),
          _page(2, '/items/42', Color(0xFFEAF3FF)),
          _page(3, '/items/42/edit', Color(0xFFE3F8EE)),
          Positioned(
            right: 12,
            bottom: 8,
            child: Row(
              children: [
                Icon(Icons.arrow_upward, size: 14, color: _PrivatePalette.success),
                SizedBox(width: 4),
                Text('push', style: _PrivateType.small.copyWith(color: _PrivatePalette.success)),
                SizedBox(width: 12),
                Icon(Icons.arrow_downward, size: 14, color: _PrivatePalette.danger),
                SizedBox(width: 4),
                Text('pop', style: _PrivateType.small.copyWith(color: _PrivatePalette.danger)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateHeroCard extends StatelessWidget {
  const _PrivateHeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(18, 18, 18, 8),
      padding: EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _PrivatePalette.accent.withValues(alpha: 0.10),
            _PrivatePalette.accentSoft,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _PrivatePalette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              _PrivatePill(label: 'NAVIGATION', color: _PrivatePalette.accent),
              SizedBox(width: 8),
              _PrivatePill(label: 'STACK MODEL', color: _PrivatePalette.builder),
              SizedBox(width: 8),
              _PrivatePill(label: 'OVERLAY', color: _PrivatePalette.popup),
            ],
          ),
          SizedBox(height: 12),
          Text('Routes are pushed and popped', style: _PrivateType.hero),
          SizedBox(height: 6),
          Text(
            'A Route<T> represents one entry in the navigator stack.  Push '
            'wraps a screen in animation, push another and the previous one '
            "stays alive — pop returns control plus an optional result of T.",
            style: _PrivateType.body,
          ),
          SizedBox(height: 18),
          _PrivateStackOfPagesGraphic(),
        ],
      ),
    );
  }
}

// =====================================================================
// 2.  Inheritance diagram
// =====================================================================

class _PrivateInheritanceNode extends StatelessWidget {
  final int depth;
  final String name;
  final String summary;
  final bool concrete;
  final Color color;
  const _PrivateInheritanceNode({
    required this.depth,
    required this.name,
    required this.summary,
    required this.concrete,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final double indent = depth * 22.0;
    return Padding(
      padding: EdgeInsets.only(left: indent, top: 4, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (depth > 0)
            Padding(
              padding: EdgeInsets.only(right: 6),
              child: Text('└─', style: _PrivateType.mono),
            ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: concrete ? 0.20 : 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: color.withValues(alpha: concrete ? 0.7 : 0.3),
                width: concrete ? 1.4 : 1.0,
                style: concrete ? BorderStyle.solid : BorderStyle.solid,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  concrete ? Icons.check_circle : Icons.donut_large,
                  size: 14,
                  color: color,
                ),
                SizedBox(width: 6),
                Text(name, style: _PrivateType.mono),
              ],
            ),
          ),
          SizedBox(width: 10),
          Flexible(
            child: Text(
              summary,
              style: _PrivateType.small,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateInheritanceDiagram extends StatelessWidget {
  const _PrivateInheritanceDiagram();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Every concrete page route descends from this chain.  The marker '
          'on the left distinguishes abstract nodes (donut) from concrete '
          'ones (filled check).',
          style: _PrivateType.body,
        ),
        SizedBox(height: 14),
        _PrivateInheritanceNode(
          depth: 0,
          name: 'Route<T>',
          summary: 'abstract — a single entry in a Navigator stack',
          concrete: false,
          color: _PrivatePalette.accent,
        ),
        _PrivateInheritanceNode(
          depth: 1,
          name: 'OverlayRoute<T>',
          summary: 'inserts one or more OverlayEntries',
          concrete: false,
          color: _PrivatePalette.accent,
        ),
        _PrivateInheritanceNode(
          depth: 2,
          name: 'TransitionRoute<T>',
          summary: 'has an AnimationController for in/out',
          concrete: false,
          color: _PrivatePalette.accent,
        ),
        _PrivateInheritanceNode(
          depth: 3,
          name: 'ModalRoute<T>',
          summary: 'blocks input below; barrier + isCurrent + isActive',
          concrete: false,
          color: _PrivatePalette.accent,
        ),
        _PrivateInheritanceNode(
          depth: 4,
          name: 'PageRoute<T>',
          summary: 'opaque, full-screen, replaces previous route visually',
          concrete: false,
          color: _PrivatePalette.material,
        ),
        _PrivateInheritanceNode(
          depth: 5,
          name: 'MaterialPageRoute<T>',
          summary: 'platform-adaptive Material slide / fade',
          concrete: true,
          color: _PrivatePalette.material,
        ),
        _PrivateInheritanceNode(
          depth: 5,
          name: 'CupertinoPageRoute<T>',
          summary: 'iOS slide-from-right with swipe-back gesture',
          concrete: true,
          color: _PrivatePalette.cupertino,
        ),
        _PrivateInheritanceNode(
          depth: 5,
          name: 'PageRouteBuilder<T>',
          summary: 'inline builder + transitionsBuilder for ad-hoc routes',
          concrete: true,
          color: _PrivatePalette.builder,
        ),
        _PrivateInheritanceNode(
          depth: 4,
          name: 'PopupRoute<T>',
          summary: 'transparent route above current — used by dialogs/menus',
          concrete: false,
          color: _PrivatePalette.popup,
        ),
        _PrivateInheritanceNode(
          depth: 5,
          name: 'RawDialogRoute<T>',
          summary: 'low-level dialog route, fully custom transition',
          concrete: true,
          color: _PrivatePalette.rawDialog,
        ),
        _PrivateInheritanceNode(
          depth: 5,
          name: 'DialogRoute<T>',
          summary: 'standard Material/Cupertino dialog route',
          concrete: true,
          color: _PrivatePalette.rawDialog,
        ),
        SizedBox(height: 14),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _PrivatePalette.surfaceAlt,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _PrivatePalette.border),
          ),
          child: Text(
            'Hint: PopupRoute keeps the route below visible, PageRoute does '
            'not.  That single difference flows from whether the route is '
            'considered "opaque" in the overlay.',
            style: _PrivateType.small,
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// 3.  RouteSettings anatomy
// =====================================================================

class _PrivateSettingsRow extends StatelessWidget {
  final String name;
  final String args;
  final String note;
  const _PrivateSettingsRow({
    required this.name,
    required this.args,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _PrivatePalette.surfaceAlt,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _PrivatePalette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _PrivatePill(label: 'name', color: _PrivatePalette.material),
              SizedBox(width: 8),
              Expanded(child: Text(name, style: _PrivateType.mono)),
            ],
          ),
          SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PrivatePill(label: 'arguments', color: _PrivatePalette.builder),
              SizedBox(width: 8),
              Expanded(child: Text(args, style: _PrivateType.monoSmall)),
            ],
          ),
          SizedBox(height: 6),
          Text(note, style: _PrivateType.small),
        ],
      ),
    );
  }
}

class _PrivateRouteSettingsPanel extends StatelessWidget {
  const _PrivateRouteSettingsPanel();

  @override
  Widget build(BuildContext context) {
    final RouteSettings s1 = RouteSettings(name: '/');
    final RouteSettings s2 = RouteSettings(
      name: '/items/42',
      arguments: <String, Object?>{'id': 42, 'tab': 'details'},
    );
    final RouteSettings s3 = RouteSettings(
      name: '/share',
      arguments: 'url=https://example.com/x',
    );
    final RouteSettings s4 = RouteSettings(arguments: null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Each Route carries a RouteSettings.  It's optional metadata that "
          "the navigator and observers can read — not the route's payload.",
          style: _PrivateType.body,
        ),
        SizedBox(height: 12),
        _PrivateSettingsRow(
          name: 's1.name = "${s1.name}"',
          args: 's1.arguments = ${s1.arguments}',
          note: 'A bare home route — name is conventionally "/".',
        ),
        _PrivateSettingsRow(
          name: 's2.name = "${s2.name}"',
          args: 's2.arguments = ${s2.arguments}',
          note: 'Map arguments — common for typed-in-spirit deep links.',
        ),
        _PrivateSettingsRow(
          name: 's3.name = "${s3.name}"',
          args: 's3.arguments = ${s3.arguments}',
          note: 'Arguments may be any Object? — strings, records, models...',
        ),
        _PrivateSettingsRow(
          name: 's4.name = ${s4.name}',
          args: 's4.arguments = ${s4.arguments}',
          note: 'Both fields are optional — anonymous, payload-less route.',
        ),
      ],
    );
  }
}

// =====================================================================
// 4.  Lifecycle timeline
// =====================================================================

class _PrivateLifecycleStage {
  final String label;
  final String description;
  final IconData icon;
  final Color color;
  const _PrivateLifecycleStage({
    required this.label,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class _PrivateLifecycleTile extends StatelessWidget {
  final int index;
  final _PrivateLifecycleStage stage;
  final bool last;
  const _PrivateLifecycleTile({
    required this.index,
    required this.stage,
    required this.last,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: stage.color.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                  border: Border.all(color: stage.color),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${index + 1}',
                  style: _PrivateType.pill.copyWith(color: stage.color),
                ),
              ),
              if (!last)
                Expanded(
                  child: Container(
                    width: 2,
                    color: stage.color.withValues(alpha: 0.3),
                  ),
                ),
            ],
          ),
          SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: last ? 0 : 14),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _PrivatePalette.surfaceAlt,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _PrivatePalette.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(stage.icon, size: 16, color: stage.color),
                        SizedBox(width: 6),
                        Text(stage.label, style: _PrivateType.h3),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(stage.description, style: _PrivateType.small),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateLifecycleTimeline extends StatelessWidget {
  const _PrivateLifecycleTimeline();

  @override
  Widget build(BuildContext context) {
    final List<_PrivateLifecycleStage> stages = [
      _PrivateLifecycleStage(
        label: 'install()',
        description:
            'The route is added to the overlay.  createOverlayEntries() runs '
            'and the AnimationController is created with status dismissed.',
        icon: Icons.input,
        color: _PrivatePalette.accent,
      ),
      _PrivateLifecycleStage(
        label: 'didPush() — animate-in',
        description:
            'The controller forwards from 0.0 → 1.0.  buildTransitions wraps '
            'the page so it slides / fades in.  The route below pauses input.',
        icon: Icons.east,
        color: _PrivatePalette.success,
      ),
      _PrivateLifecycleStage(
        label: 'didChangeNext(nextRoute)',
        description:
            'Notifies this route that another route was pushed on top of it. '
            'Useful for animating to a "behind" state.',
        icon: Icons.layers,
        color: _PrivatePalette.builder,
      ),
      _PrivateLifecycleStage(
        label: 'didPopNext()',
        description:
            'The route on top popped — this route is now top-of-stack again. '
            'Often paired with RouteAware.didPopNext() for refresh logic.',
        icon: Icons.refresh,
        color: _PrivatePalette.material,
      ),
      _PrivateLifecycleStage(
        label: 'didPop(result) — animate-out',
        description:
            'The controller reverses 1.0 → 0.0.  When complete, the overlay '
            'entries are removed and the result is delivered to push()ʼs Future.',
        icon: Icons.west,
        color: _PrivatePalette.warning,
      ),
      _PrivateLifecycleStage(
        label: 'dispose()',
        description:
            'AnimationController, scopes and observers are torn down.  No '
            'further callbacks will fire on this Route instance.',
        icon: Icons.delete_outline,
        color: _PrivatePalette.danger,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int i = 0; i < stages.length; i++)
          _PrivateLifecycleTile(
            index: i,
            stage: stages[i],
            last: i == stages.length - 1,
          ),
      ],
    );
  }
}

// =====================================================================
// 5.  Page-route gallery
// =====================================================================

class _PrivatePageThumb extends StatelessWidget {
  final String title;
  final String transition;
  final Color color;
  final IconData icon;
  final List<Widget> overlayHints;
  const _PrivatePageThumb({
    required this.title,
    required this.transition,
    required this.color,
    required this.icon,
    required this.overlayHints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _PrivatePalette.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _PrivatePalette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(11),
                topRight: Radius.circular(11),
              ),
              border: Border(
                bottom: BorderSide(color: _PrivatePalette.border),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 16),
                SizedBox(width: 6),
                Expanded(
                  child: Text(title, style: _PrivateType.h3),
                ),
              ],
            ),
          ),
          // Mock screen
          Container(
            height: 110,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _PrivatePalette.surfaceAlt,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _PrivatePalette.border),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 22,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7),
                          topRight: Radius.circular(7),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 6, 8, 4),
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: _PrivatePalette.border,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
                      child: Container(
                        height: 6,
                        width: 70,
                        decoration: BoxDecoration(
                          color: _PrivatePalette.border,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
                      child: Container(
                        height: 6,
                        width: 100,
                        decoration: BoxDecoration(
                          color: _PrivatePalette.border,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
                ...overlayHints,
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Row(
              children: [
                Icon(Icons.animation, size: 13, color: _PrivatePalette.inkMuted),
                SizedBox(width: 4),
                Expanded(
                  child: Text(transition, style: _PrivateType.small),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivatePageRouteGallery extends StatelessWidget {
  const _PrivatePageRouteGallery();

  Widget _slideArrow({required Color color}) {
    return Positioned(
      right: 6,
      top: 24,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: color.withValues(alpha: 0.5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.arrow_forward, size: 11, color: color),
            SizedBox(width: 2),
            Text('slide', style: _PrivateType.pill.copyWith(color: color)),
          ],
        ),
      ),
    );
  }

  Widget _chevron({required Color color}) {
    return Positioned(
      left: 6,
      top: 6,
      child: Icon(Icons.chevron_left, size: 18, color: color),
    );
  }

  Widget _fadeBlur({required Color color}) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.0),
              color.withValues(alpha: 0.20),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(7),
        ),
      ),
    );
  }

  Widget _dialogShade({required Color color}) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: _PrivatePalette.barrier(0.4),
          borderRadius: BorderRadius.circular(7),
        ),
        alignment: Alignment.center,
        child: Container(
          width: 70,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Four routes you will pick from 99% of the time.  The thumbnail '
          'shows what their default transition feels like.',
          style: _PrivateType.body,
        ),
        SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _PrivatePageThumb(
                title: 'MaterialPageRoute',
                transition: 'Slide-up + fade on Android, slide-from-right on iOS.',
                color: _PrivatePalette.material,
                icon: Icons.android,
                overlayHints: [_slideArrow(color: _PrivatePalette.material)],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _PrivatePageThumb(
                title: 'CupertinoPageRoute',
                transition: 'iOS slide-from-right with swipe-to-go-back gesture.',
                color: _PrivatePalette.cupertino,
                icon: Icons.phone_iphone,
                overlayHints: [
                  _chevron(color: _PrivatePalette.cupertino),
                  _slideArrow(color: _PrivatePalette.cupertino),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _PrivatePageThumb(
                title: 'PageRouteBuilder',
                transition: 'You bring transitionsBuilder — typical: fade or scale.',
                color: _PrivatePalette.builder,
                icon: Icons.build,
                overlayHints: [_fadeBlur(color: _PrivatePalette.builder)],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _PrivatePageThumb(
                title: 'RawDialogRoute',
                transition: 'Modal barrier + custom dialog box transition.',
                color: _PrivatePalette.rawDialog,
                icon: Icons.layers,
                overlayHints: [_dialogShade(color: _PrivatePalette.rawDialog)],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _PrivatePalette.surfaceAlt,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _PrivatePalette.border),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, size: 16, color: _PrivatePalette.accent),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Reminder: a CupertinoPageRoute also exists in code as '
                  'CupertinoPageRoute(builder: ...).  We only reference its '
                  'type here so the test asserts the import resolved.',
                  style: _PrivateType.small,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Builder(
          builder: (BuildContext ctx) {
            // Reference CupertinoPageRoute type literally — no instantiation,
            // so no analyzer warnings, but the import is now load-bearing.
            const Type cupertinoType = CupertinoPageRoute;
            return Text(
              'Type referenced: $cupertinoType',
              style: _PrivateType.monoSmall,
            );
          },
        ),
      ],
    );
  }
}

// =====================================================================
// 6.  Modal-route comparison table
// =====================================================================

class _PrivateModalRow {
  final String type;
  final String barrierColor;
  final String dismissible;
  final String label;
  final String notes;
  final Color color;
  const _PrivateModalRow({
    required this.type,
    required this.barrierColor,
    required this.dismissible,
    required this.label,
    required this.notes,
    required this.color,
  });
}

class _PrivateModalComparison extends StatelessWidget {
  const _PrivateModalComparison();

  Widget _cell(String text, {bool header = false, double width = 0}) {
    final TextStyle style = header
        ? _PrivateType.pill
        : _PrivateType.monoSmall;
    final Widget content = Text(text, style: style, overflow: TextOverflow.ellipsis);
    return Container(
      width: width > 0 ? width : null,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: width > 0 ? content : Center(child: content),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<_PrivateModalRow> rows = [
      _PrivateModalRow(
        type: 'ModalRoute',
        barrierColor: 'override',
        dismissible: 'override',
        label: 'override',
        notes: 'abstract base for everything blocking input below',
        color: _PrivatePalette.accent,
      ),
      _PrivateModalRow(
        type: 'PopupRoute',
        barrierColor: 'override',
        dismissible: 'override',
        label: 'override',
        notes: 'transparent above current — menus, snack overlays',
        color: _PrivatePalette.popup,
      ),
      _PrivateModalRow(
        type: 'DialogRoute',
        barrierColor: 'Colors.black54',
        dismissible: 'true (default)',
        label: 'l10n "Dismiss"',
        notes: 'standard dialog frame + theme integration',
        color: _PrivatePalette.material,
      ),
      _PrivateModalRow(
        type: 'RawDialogRoute',
        barrierColor: 'Color(0x80000000)',
        dismissible: 'true',
        label: 'caller-supplied',
        notes: 'no Material chrome — just transition + barrier',
        color: _PrivatePalette.rawDialog,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Four cousins in the modal family.  The biggest visible '
          'difference is the barrier — its color, its label, and whether '
          'tapping it dismisses the route.',
          style: _PrivateType.body,
        ),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: _PrivatePalette.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _PrivatePalette.border),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: _PrivatePalette.surfaceAlt,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(9),
                    topRight: Radius.circular(9),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 130,
                      child: _cell('TYPE', header: true, width: 130),
                    ),
                    Expanded(child: _cell('barrierColor', header: true)),
                    Expanded(child: _cell('barrierDismissible', header: true)),
                    Expanded(child: _cell('barrierLabel', header: true)),
                  ],
                ),
              ),
              for (int i = 0; i < rows.length; i++)
                Container(
                  decoration: BoxDecoration(
                    color: i.isEven
                        ? _PrivatePalette.surface
                        : _PrivatePalette.surfaceAlt.withValues(alpha: 0.5),
                    border: Border(
                      top: BorderSide(color: _PrivatePalette.border),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 130,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 8,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: rows[i].color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      rows[i].type,
                                      style: _PrivateType.h3.copyWith(fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(child: _cell(rows[i].barrierColor)),
                          Expanded(child: _cell(rows[i].dismissible)),
                          Expanded(child: _cell(rows[i].label)),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 12, 8),
                        child: Row(
                          children: [
                            Icon(Icons.subdirectory_arrow_right,
                                size: 12, color: _PrivatePalette.inkMuted),
                            SizedBox(width: 4),
                            Expanded(
                              child: Text(rows[i].notes, style: _PrivateType.small),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// 7.  Code-listing card — push example
// =====================================================================

class _PrivateCodeLine extends StatelessWidget {
  final String number;
  final String code;
  final Color color;
  const _PrivateCodeLine({
    required this.number,
    required this.code,
    this.color = _PrivatePalette.ink,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 30,
          child: Text(
            number,
            style: _PrivateType.monoSmall.copyWith(
              color: _PrivatePalette.inkMuted,
            ),
            textAlign: TextAlign.right,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            code,
            style: _PrivateType.mono.copyWith(color: color),
          ),
        ),
      ],
    );
  }
}

class _PrivateCodeListing extends StatelessWidget {
  const _PrivateCodeListing();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'A typical push of a MaterialPageRoute.  Note that push() returns '
          'a Future<T?> — to receive the popped result you must await it.',
          style: _PrivateType.body,
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: Color(0xFF0E1422),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xFF1F2A44)),
          ),
          child: DefaultTextStyle(
            style: _PrivateType.mono.copyWith(color: Color(0xFFE6E9F2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _PrivateCodeLine(
                  number: '1',
                  code: '// A typical Navigator.push',
                  color: Color(0xFF6F7BA5),
                ),
                _PrivateCodeLine(
                  number: '2',
                  code: 'Future<void> _open(BuildContext ctx) async {',
                  color: Color(0xFFE6E9F2),
                ),
                _PrivateCodeLine(
                  number: '3',
                  code: '  final result = await Navigator.of(ctx).push<bool>(',
                  color: Color(0xFFE6E9F2),
                ),
                _PrivateCodeLine(
                  number: '4',
                  code: '    MaterialPageRoute<bool>(',
                  color: Color(0xFFA9B8FF),
                ),
                _PrivateCodeLine(
                  number: '5',
                  code: "      settings: RouteSettings(name: '/edit'),",
                  color: Color(0xFFE6E9F2),
                ),
                _PrivateCodeLine(
                  number: '6',
                  code: '      builder: (BuildContext c) => EditScreen(),',
                  color: Color(0xFFE6E9F2),
                ),
                _PrivateCodeLine(
                  number: '7',
                  code: '      fullscreenDialog: false,',
                  color: Color(0xFFE6E9F2),
                ),
                _PrivateCodeLine(
                  number: '8',
                  code: '    ),',
                  color: Color(0xFFA9B8FF),
                ),
                _PrivateCodeLine(
                  number: '9',
                  code: '  );',
                  color: Color(0xFFE6E9F2),
                ),
                _PrivateCodeLine(
                  number: '10',
                  code: '  if (result == true) {',
                  color: Color(0xFFE6E9F2),
                ),
                _PrivateCodeLine(
                  number: '11',
                  code: "    debugPrint('saved');",
                  color: Color(0xFFE6E9F2),
                ),
                _PrivateCodeLine(
                  number: '12',
                  code: '  }',
                  color: Color(0xFFE6E9F2),
                ),
                _PrivateCodeLine(
                  number: '13',
                  code: '}',
                  color: Color(0xFFE6E9F2),
                ),
                SizedBox(height: 8),
                _PrivateCodeLine(
                  number: '14',
                  code: '// Pop with a result:',
                  color: Color(0xFF6F7BA5),
                ),
                _PrivateCodeLine(
                  number: '15',
                  code: '// Navigator.of(c).pop<bool>(true);',
                  color: Color(0xFF6F7BA5),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _PrivatePalette.success.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _PrivatePalette.success.withValues(alpha: 0.4),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline,
                  size: 16, color: _PrivatePalette.success),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Tip: parametrize MaterialPageRoute<bool> so push<bool> '
                  'returns Future<bool?> with the right type — no casts.',
                  style: _PrivateType.small,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// 8.  RoutePopDisposition enum panel
// =====================================================================

class _PrivateDispositionTile extends StatelessWidget {
  final RoutePopDisposition disposition;
  final String headline;
  final String description;
  final IconData icon;
  final Color color;
  const _PrivateDispositionTile({
    required this.disposition,
    required this.headline,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'RoutePopDisposition.',
                      style: _PrivateType.monoSmall.copyWith(
                        color: _PrivatePalette.inkMuted,
                      ),
                    ),
                    Text(
                      disposition.toString().split('.').last,
                      style: _PrivateType.mono.copyWith(color: color),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(headline, style: _PrivateType.h3),
                SizedBox(height: 2),
                Text(description, style: _PrivateType.small),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateDispositionPanel extends StatelessWidget {
  const _PrivateDispositionPanel();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'When the user requests a back-pop (Android back button, iOS swipe, '
          'desktop esc) the framework asks the route for a disposition.',
          style: _PrivateType.body,
        ),
        SizedBox(height: 12),
        _PrivateDispositionTile(
          disposition: RoutePopDisposition.pop,
          headline: 'Pop normally',
          description:
              'The route allows the back-action and will be popped with the '
              'usual animate-out.  Default for ordinary screens.',
          icon: Icons.arrow_back,
          color: _PrivatePalette.success,
        ),
        _PrivateDispositionTile(
          disposition: RoutePopDisposition.doNotPop,
          headline: 'Block the pop',
          description:
              'The route refuses the request — useful when an unsaved-changes '
              'guard wants to prompt a "discard?" dialog before allowing pop.',
          icon: Icons.block,
          color: _PrivatePalette.danger,
        ),
        _PrivateDispositionTile(
          disposition: RoutePopDisposition.bubble,
          headline: 'Bubble up',
          description:
              'Let the navigator decide.  If this is the last route, the '
              'host (e.g. SystemNavigator.pop()) is asked to handle it.',
          icon: Icons.bubble_chart,
          color: _PrivatePalette.builder,
        ),
      ],
    );
  }
}

// =====================================================================
// 9.  RouteAware mixin explainer
// =====================================================================

class _PrivateRouteAwarePanel extends StatelessWidget {
  const _PrivateRouteAwarePanel();

  Widget _row(IconData icon, String title, String body, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: _PrivateType.h3),
                SizedBox(height: 2),
                Text(body, style: _PrivateType.small),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'RouteAware lets a State<T> react to navigator events without '
          'subclassing Route.  Subscribe in didChangeDependencies, '
          'unsubscribe in dispose.',
          style: _PrivateType.body,
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _PrivatePalette.surfaceAlt,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _PrivatePalette.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _row(
                Icons.notifications_active,
                'didPush()',
                'Called when this route is pushed and is now the top-most.',
                _PrivatePalette.success,
              ),
              _row(
                Icons.layers_outlined,
                'didPushNext()',
                'A new route was pushed *on top of* the one we are aware of.',
                _PrivatePalette.builder,
              ),
              _row(
                Icons.arrow_back,
                'didPop()',
                'Our route was popped — last chance for the State to react.',
                _PrivatePalette.warning,
              ),
              _row(
                Icons.refresh,
                'didPopNext()',
                'The route on top popped — we are visible again.  Refresh!',
                _PrivatePalette.material,
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFF0E1422),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DefaultTextStyle(
            style: _PrivateType.monoSmall.copyWith(color: Color(0xFFE6E9F2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('// Wiring',
                    style: _PrivateType.monoSmall
                        .copyWith(color: Color(0xFF6F7BA5))),
                SizedBox(height: 4),
                Text('final RouteObserver<PageRoute> obs = RouteObserver();',
                    style: _PrivateType.monoSmall
                        .copyWith(color: Color(0xFFE6E9F2))),
                Text('MaterialApp(navigatorObservers: [obs], ...)',
                    style: _PrivateType.monoSmall
                        .copyWith(color: Color(0xFFE6E9F2))),
                SizedBox(height: 8),
                Text('// Inside State<MyScreen> with RouteAware:',
                    style: _PrivateType.monoSmall
                        .copyWith(color: Color(0xFF6F7BA5))),
                Text('void didChangeDependencies() {',
                    style: _PrivateType.monoSmall
                        .copyWith(color: Color(0xFFE6E9F2))),
                Text('  super.didChangeDependencies();',
                    style: _PrivateType.monoSmall
                        .copyWith(color: Color(0xFFE6E9F2))),
                Text('  obs.subscribe(this, ModalRoute.of(context)!);',
                    style: _PrivateType.monoSmall
                        .copyWith(color: Color(0xFFA9B8FF))),
                Text('}',
                    style: _PrivateType.monoSmall
                        .copyWith(color: Color(0xFFE6E9F2))),
                Text('void dispose() {',
                    style: _PrivateType.monoSmall
                        .copyWith(color: Color(0xFFE6E9F2))),
                Text('  obs.unsubscribe(this);',
                    style: _PrivateType.monoSmall
                        .copyWith(color: Color(0xFFA9B8FF))),
                Text('  super.dispose();',
                    style: _PrivateType.monoSmall
                        .copyWith(color: Color(0xFFE6E9F2))),
                Text('}',
                    style: _PrivateType.monoSmall
                        .copyWith(color: Color(0xFFE6E9F2))),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// 10.  Pitfalls
// =====================================================================

class _PrivatePitfall {
  final String title;
  final String body;
  final IconData icon;
  final Color color;
  const _PrivatePitfall({
    required this.title,
    required this.body,
    required this.icon,
    required this.color,
  });
}

class _PrivatePitfallList extends StatelessWidget {
  const _PrivatePitfallList();

  @override
  Widget build(BuildContext context) {
    final List<_PrivatePitfall> pitfalls = [
      _PrivatePitfall(
        title: 'push() returns a Future, it does NOT await on its own',
        body: 'Navigator.push returns Future<T?> immediately.  If you forget '
            'await, the calling code keeps running and the result-handling '
            'block executes before the user has done anything.',
        icon: Icons.bolt,
        color: _PrivatePalette.warning,
      ),
      _PrivatePitfall(
        title: 'arguments is Object?, not a typed parameter',
        body: 'RouteSettings.arguments is Object? for backwards compatibility. '
            'Cast at the receiving site, ideally inside a small typed '
            'extractor — never sprinkle "as Map" all over the screen widget.',
        icon: Icons.warning_amber,
        color: _PrivatePalette.danger,
      ),
      _PrivatePitfall(
        title: 'barrierDismissible only matters for modal routes',
        body: 'Setting barrierDismissible=true on a PageRoute has no effect '
            '— PageRoutes are opaque and have no barrier.  Use it on '
            'PopupRoute / DialogRoute / RawDialogRoute.',
        icon: Icons.shield,
        color: _PrivatePalette.builder,
      ),
      _PrivatePitfall(
        title: 'maintainState=false drops the widget tree under it',
        body: 'PageRoute.maintainState=false rebuilds when re-shown.  Useful '
            'for memory but breaks any TextEditingController state held in '
            'the page — keep state outside the page (Bloc/Riverpod/InheritedW).',
        icon: Icons.memory,
        color: _PrivatePalette.material,
      ),
      _PrivatePitfall(
        title: 'pop with a result of the wrong type silently returns null',
        body: 'If your route is MaterialPageRoute<bool> but you pop with an '
            'int, the future yields null.  Strongly type the route and use '
            'the same type for pop<T>(value).',
        icon: Icons.error_outline,
        color: _PrivatePalette.danger,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final _PrivatePitfall p in pitfalls)
          Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: p.color.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: p.color.withValues(alpha: 0.4)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(p.icon, color: p.color, size: 18),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(p.title, style: _PrivateType.h3),
                      SizedBox(height: 4),
                      Text(p.body, style: _PrivateType.small),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

// =====================================================================
// 11.  Footer
// =====================================================================

class _PrivateFooter extends StatelessWidget {
  const _PrivateFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(18, 24, 18, 28),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _PrivatePalette.surfaceAlt,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _PrivatePalette.border),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _PrivatePalette.accent.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.alt_route, color: _PrivatePalette.accent),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Route<T> visual deep demo', style: _PrivateType.h3),
                SizedBox(height: 2),
                Text(
                  'Static reference render — no navigator interaction.  '
                  'The whole tree is built once from build(BuildContext).',
                  style: _PrivateType.small,
                ),
              ],
            ),
          ),
          _PrivatePill(label: 'AST · STATIC', color: _PrivatePalette.success),
        ],
      ),
    );
  }
}

// =====================================================================
// Entry point
// =====================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Route<T> visual deep demo',
    home: Scaffold(
      backgroundColor: _PrivatePalette.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Hero
            _PrivateHeroCard(),

            // 2. Inheritance diagram
            _PrivateSectionHeader(
              index: '02',
              title: 'Inheritance: from Route<T> down to MaterialPageRoute',
            ),
            _PrivateCard(
              title: 'Class hierarchy',
              subtitle: 'Route → OverlayRoute → TransitionRoute → ModalRoute → PageRoute',
              icon: Icons.account_tree,
              accent: _PrivatePalette.accent,
              child: _PrivateInheritanceDiagram(),
            ),

            // 3. RouteSettings anatomy
            _PrivateSectionHeader(
              index: '03',
              title: 'RouteSettings — name + arguments',
            ),
            _PrivateCard(
              title: 'Settings anatomy',
              subtitle: 'Route metadata that observers can read',
              icon: Icons.tune,
              accent: _PrivatePalette.material,
              child: _PrivateRouteSettingsPanel(),
            ),

            // 4. Lifecycle
            _PrivateSectionHeader(
              index: '04',
              title: 'Lifecycle — install → animate → dispose',
            ),
            _PrivateCard(
              title: 'Route lifecycle',
              subtitle: 'install · didPush · didChangeNext · didPopNext · didPop · dispose',
              icon: Icons.timeline,
              accent: _PrivatePalette.success,
              child: _PrivateLifecycleTimeline(),
            ),

            // 5. Page-route gallery
            _PrivateSectionHeader(
              index: '05',
              title: 'Page-route gallery',
            ),
            _PrivateCard(
              title: 'Page routes you actually use',
              subtitle: 'Material · Cupertino · Builder · RawDialog',
              icon: Icons.collections,
              accent: _PrivatePalette.builder,
              child: _PrivatePageRouteGallery(),
            ),

            // 6. Modal comparison
            _PrivateSectionHeader(
              index: '06',
              title: 'Modal-route comparison',
            ),
            _PrivateCard(
              title: 'Barrier semantics',
              subtitle: 'PopupRoute · DialogRoute · RawDialogRoute · ModalRoute',
              icon: Icons.layers,
              accent: _PrivatePalette.popup,
              child: _PrivateModalComparison(),
            ),

            // 7. Code listing
            _PrivateSectionHeader(
              index: '07',
              title: 'Navigator.push() — the canonical example',
            ),
            _PrivateCard(
              title: 'Code listing',
              subtitle: 'Navigator.of(ctx).push(MaterialPageRoute(builder: ...))',
              icon: Icons.code,
              accent: _PrivatePalette.material,
              child: _PrivateCodeListing(),
            ),

            // 8. RoutePopDisposition
            _PrivateSectionHeader(
              index: '08',
              title: 'RoutePopDisposition — pop / doNotPop / bubble',
            ),
            _PrivateCard(
              title: 'Pop disposition',
              subtitle: 'Route.willPop() decides what happens',
              icon: Icons.swap_vert,
              accent: _PrivatePalette.danger,
              child: _PrivateDispositionPanel(),
            ),

            // 9. RouteAware
            _PrivateSectionHeader(
              index: '09',
              title: 'RouteAware — subscribe / unsubscribe',
            ),
            _PrivateCard(
              title: 'RouteAware mixin',
              subtitle: 'didPush · didPushNext · didPop · didPopNext',
              icon: Icons.hearing,
              accent: _PrivatePalette.builder,
              child: _PrivateRouteAwarePanel(),
            ),

            // 10. Pitfalls
            _PrivateSectionHeader(
              index: '10',
              title: 'Pitfalls — things to know before push()ing',
            ),
            _PrivateCard(
              title: 'Common pitfalls',
              subtitle: 'push returns Future · arguments is Object? · barriers',
              icon: Icons.report_problem_outlined,
              accent: _PrivatePalette.warning,
              child: _PrivatePitfallList(),
            ),

            // 11. Footer
            _PrivateFooter(),
          ],
        ),
      ),
    ),
  );
}

// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// =====================================================================
//  InheritedModel<T> -- Visual Deep Demo
// =====================================================================
//
//  Subject: Flutter's InheritedModel<T> -- the InheritedWidget variant
//  that lets descendant widgets subscribe to *aspects* of a model,
//  rebuilding only when their slice of the model actually changes.
//
//  This file is a hand-written, static, single-build-pass visual
//  documentation surface intended for the analyzer-free interpreter
//  test corpus. It does not animate, does not call setState, and does
//  not spawn timers, futures, tickers or streams. Every "live" bit of
//  state is derived synchronously inside `build`.
//
// =====================================================================

import 'package:flutter/material.dart';

// =====================================================================
//  Aspect enum + InheritedModel implementation
// =====================================================================

enum _PrivateColorAspect {
  primary,
  secondary,
  tertiary,
  success,
  warning,
  danger,
}

/// A real, concrete InheritedModel exposing a six-slot palette where
/// each slot is a distinct aspect. Subscribers depend on a single slot
/// via [_PrivatePaletteModel.of(context, aspect)].
class _PrivatePaletteModel extends InheritedModel<_PrivateColorAspect> {
  const _PrivatePaletteModel({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.success,
    required this.warning,
    required this.danger,
    required super.child,
  });

  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color success;
  final Color warning;
  final Color danger;

  static _PrivatePaletteModel of(
    BuildContext context,
    _PrivateColorAspect aspect,
  ) {
    final model = InheritedModel.inheritFrom<_PrivatePaletteModel>(
      context,
      aspect: aspect,
    );
    return model!;
  }

  Color colorFor(_PrivateColorAspect aspect) {
    switch (aspect) {
      case _PrivateColorAspect.primary:
        return primary;
      case _PrivateColorAspect.secondary:
        return secondary;
      case _PrivateColorAspect.tertiary:
        return tertiary;
      case _PrivateColorAspect.success:
        return success;
      case _PrivateColorAspect.warning:
        return warning;
      case _PrivateColorAspect.danger:
        return danger;
    }
  }

  @override
  bool updateShouldNotify(_PrivatePaletteModel oldWidget) {
    return primary != oldWidget.primary ||
        secondary != oldWidget.secondary ||
        tertiary != oldWidget.tertiary ||
        success != oldWidget.success ||
        warning != oldWidget.warning ||
        danger != oldWidget.danger;
  }

  @override
  bool updateShouldNotifyDependent(
    _PrivatePaletteModel oldWidget,
    Set<_PrivateColorAspect> dependencies,
  ) {
    if (dependencies.contains(_PrivateColorAspect.primary) &&
        primary != oldWidget.primary) {
      return true;
    }
    if (dependencies.contains(_PrivateColorAspect.secondary) &&
        secondary != oldWidget.secondary) {
      return true;
    }
    if (dependencies.contains(_PrivateColorAspect.tertiary) &&
        tertiary != oldWidget.tertiary) {
      return true;
    }
    if (dependencies.contains(_PrivateColorAspect.success) &&
        success != oldWidget.success) {
      return true;
    }
    if (dependencies.contains(_PrivateColorAspect.warning) &&
        warning != oldWidget.warning) {
      return true;
    }
    if (dependencies.contains(_PrivateColorAspect.danger) &&
        danger != oldWidget.danger) {
      return true;
    }
    return false;
  }
}

// =====================================================================
//  build entry point
// =====================================================================

dynamic build(BuildContext context) {
  // -------------------------------------------------------------------
  // Single instance of the palette model; the whole document tree is
  // wrapped in this so consumer cards can subscribe to single aspects.
  // -------------------------------------------------------------------
  const _PrivateColorPalette palette = _PrivateColorPalette(
    primary: Color(0xFF4F46E5),
    secondary: Color(0xFF0EA5E9),
    tertiary: Color(0xFF8B5CF6),
    success: Color(0xFF10B981),
    warning: Color(0xFFF59E0B),
    danger: Color(0xFFEF4444),
    background: Color(0xFFF8FAFC),
    surface: Color(0xFFFFFFFF),
    border: Color(0xFFE2E8F0),
    ink: Color(0xFF0F172A),
    inkSoft: Color(0xFF475569),
    inkMute: Color(0xFF94A3B8),
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'InheritedModel Deep Demo',
    home: _PrivatePaletteModel(
      primary: palette.primary,
      secondary: palette.secondary,
      tertiary: palette.tertiary,
      success: palette.success,
      warning: palette.warning,
      danger: palette.danger,
      child: Scaffold(
        backgroundColor: palette.background,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 28,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1180),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _PrivateSectionHero(palette: palette),
                    const SizedBox(height: 36),
                    _PrivateSectionAnatomy(palette: palette),
                    const SizedBox(height: 36),
                    _PrivateSectionLivePalette(palette: palette),
                    const SizedBox(height: 36),
                    _PrivateSectionContrastBroad(palette: palette),
                    const SizedBox(height: 36),
                    _PrivateSectionUpdateMethods(palette: palette),
                    const SizedBox(height: 36),
                    _PrivateSectionRecipe(palette: palette),
                    const SizedBox(height: 36),
                    _PrivateSectionMediaQueryAspects(palette: palette),
                    const SizedBox(height: 36),
                    _PrivateSectionPerfBars(palette: palette),
                    const SizedBox(height: 36),
                    _PrivateSectionPitfalls(palette: palette),
                    const SizedBox(height: 36),
                    _PrivateSectionFooter(palette: palette),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

// =====================================================================
//  Palette holder (plain const data class -- not the InheritedModel)
// =====================================================================

class _PrivateColorPalette {
  const _PrivateColorPalette({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.success,
    required this.warning,
    required this.danger,
    required this.background,
    required this.surface,
    required this.border,
    required this.ink,
    required this.inkSoft,
    required this.inkMute,
  });

  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color success;
  final Color warning;
  final Color danger;
  final Color background;
  final Color surface;
  final Color border;
  final Color ink;
  final Color inkSoft;
  final Color inkMute;
}

// =====================================================================
//  Section 1 -- Hero
// =====================================================================

class _PrivateSectionHero extends StatelessWidget {
  const _PrivateSectionHero({required this.palette});
  final _PrivateColorPalette palette;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(36, 36, 36, 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            palette.primary,
            palette.tertiary,
            palette.secondary,
          ],
          stops: const [0.0, 0.55, 1.0],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: palette.primary.withValues(alpha: 0.28),
            blurRadius: 32,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.45),
                    width: 1,
                  ),
                ),
                child: const Text(
                  'flutter / widgets / InheritedModel<T>',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'monospace',
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              const Spacer(),
              const _PrivateAspectChip(
                label: 'aspect-scoped',
                tone: Colors.white,
              ),
              const SizedBox(width: 8),
              const _PrivateAspectChip(
                label: 'selective rebuild',
                tone: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 28),
          const Text(
            'InheritedModel',
            style: TextStyle(
              color: Colors.white,
              fontSize: 56,
              fontWeight: FontWeight.w800,
              height: 1.05,
              letterSpacing: -1.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'subscribe to a slice, not the whole model',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.92),
              fontSize: 22,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 26),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.32),
                width: 1,
              ),
            ),
            child: const Text(
              'A regular InheritedWidget is "all-or-nothing": every '
              'descendant that called dependOnInheritedWidgetOfExactType '
              'rebuilds when the widget instance changes. InheritedModel '
              'lets descendants declare which *aspect* of the model they '
              'care about -- and the framework only notifies them when '
              'that aspect actually changed.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                height: 1.55,
              ),
            ),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              _PrivateHeroStat(
                value: '1',
                label: 'aspect per subscription',
              ),
              const SizedBox(width: 18),
              _PrivateHeroStat(
                value: 'O(deps)',
                label: 'dispatch cost',
              ),
              const SizedBox(width: 18),
              _PrivateHeroStat(
                value: '6',
                label: 'aspects in this demo',
              ),
              const SizedBox(width: 18),
              _PrivateHeroStat(
                value: '0',
                label: 'wasted rebuilds',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PrivateHeroStat extends StatelessWidget {
  const _PrivateHeroStat({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 11,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrivateAspectChip extends StatelessWidget {
  const _PrivateAspectChip({required this.label, required this.tone});
  final String label;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: tone.withValues(alpha: 0.5), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: tone,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

// =====================================================================
//  Section 2 -- Anatomy diagram of the inheritance tree
// =====================================================================

class _PrivateSectionAnatomy extends StatelessWidget {
  const _PrivateSectionAnatomy({required this.palette});
  final _PrivateColorPalette palette;

  @override
  Widget build(BuildContext context) {
    return _PrivateSectionFrame(
      palette: palette,
      number: '02',
      title: 'Anatomy of an InheritedModel tree',
      subtitle:
          'One model widget at the top; many descendants each binding to a '
          'single aspect. Notification flow is per-aspect, not per-tree.',
      child: Column(
        children: [
          _PrivateAnatomyNode(
            palette: palette,
            label: 'PaletteModel  (extends InheritedModel<ColorAspect>)',
            sub:
                'fields: primary, secondary, tertiary, success, warning, danger',
            color: palette.primary,
          ),
          const SizedBox(height: 14),
          _PrivateTreeBranch(palette: palette, count: 6),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _PrivateAnatomyLeaf(
                  palette: palette,
                  aspect: 'primary',
                  swatch: palette.primary,
                  binding: 'inheritFrom(ctx, primary)',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _PrivateAnatomyLeaf(
                  palette: palette,
                  aspect: 'secondary',
                  swatch: palette.secondary,
                  binding: 'inheritFrom(ctx, secondary)',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _PrivateAnatomyLeaf(
                  palette: palette,
                  aspect: 'tertiary',
                  swatch: palette.tertiary,
                  binding: 'inheritFrom(ctx, tertiary)',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _PrivateAnatomyLeaf(
                  palette: palette,
                  aspect: 'success',
                  swatch: palette.success,
                  binding: 'inheritFrom(ctx, success)',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _PrivateAnatomyLeaf(
                  palette: palette,
                  aspect: 'warning',
                  swatch: palette.warning,
                  binding: 'inheritFrom(ctx, warning)',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _PrivateAnatomyLeaf(
                  palette: palette,
                  aspect: 'danger',
                  swatch: palette.danger,
                  binding: 'inheritFrom(ctx, danger)',
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: palette.background,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: palette.border, width: 1),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.auto_awesome_rounded,
                  size: 20,
                  color: palette.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Each leaf is a separate subscription. When primary '
                    'changes, only the primary leaf reconciles. The tertiary, '
                    'warning, and danger leaves are skipped entirely.',
                    style: TextStyle(
                      color: palette.inkSoft,
                      fontSize: 13,
                      height: 1.55,
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

class _PrivateAnatomyNode extends StatelessWidget {
  const _PrivateAnatomyNode({
    required this.palette,
    required this.label,
    required this.sub,
    required this.color,
  });

  final _PrivateColorPalette palette;
  final String label;
  final String sub;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.45), width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.account_tree_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: palette.ink,
                    fontSize: 14,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  sub,
                  style: TextStyle(
                    color: palette.inkSoft,
                    fontSize: 12,
                    fontFamily: 'monospace',
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

class _PrivateTreeBranch extends StatelessWidget {
  const _PrivateTreeBranch({
    required this.palette,
    required this.count,
  });

  final _PrivateColorPalette palette;
  final int count;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List<Widget>.generate(count, (int i) {
          return Container(
            width: 2,
            color: palette.border,
          );
        }),
      ),
    );
  }
}

class _PrivateAnatomyLeaf extends StatelessWidget {
  const _PrivateAnatomyLeaf({
    required this.palette,
    required this.aspect,
    required this.swatch,
    required this.binding,
  });

  final _PrivateColorPalette palette;
  final String aspect;
  final Color swatch;
  final String binding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: palette.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 28,
            decoration: BoxDecoration(
              color: swatch,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            aspect,
            style: TextStyle(
              color: palette.ink,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 2),
          Text(
            binding,
            style: TextStyle(
              color: palette.inkMute,
              fontSize: 9,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
//  Section 3 -- Live aspect consumers (calls into the InheritedModel)
// =====================================================================

class _PrivateSectionLivePalette extends StatelessWidget {
  const _PrivateSectionLivePalette({required this.palette});
  final _PrivateColorPalette palette;

  @override
  Widget build(BuildContext context) {
    return _PrivateSectionFrame(
      palette: palette,
      number: '03',
      title: 'Live aspect consumers',
      subtitle:
          'Each card below calls _PrivatePaletteModel.of(context, aspect). '
          'The framework registers a per-aspect dependency and only this '
          'card would rebuild when its aspect changes.',
      child: Wrap(
        spacing: 14,
        runSpacing: 14,
        children: [
          _PrivateAspectConsumerCard(
            palette: palette,
            aspect: _PrivateColorAspect.primary,
            title: 'primary',
            caption: 'CTA buttons, focused fields, primary nav highlight',
          ),
          _PrivateAspectConsumerCard(
            palette: palette,
            aspect: _PrivateColorAspect.secondary,
            title: 'secondary',
            caption: 'Secondary buttons, info banners, link emphasis',
          ),
          _PrivateAspectConsumerCard(
            palette: palette,
            aspect: _PrivateColorAspect.tertiary,
            title: 'tertiary',
            caption: 'Decorative accents, illustrations, gradient seeds',
          ),
          _PrivateAspectConsumerCard(
            palette: palette,
            aspect: _PrivateColorAspect.success,
            title: 'success',
            caption: 'Confirmations, "saved" toasts, healthy status pills',
          ),
          _PrivateAspectConsumerCard(
            palette: palette,
            aspect: _PrivateColorAspect.warning,
            title: 'warning',
            caption: 'Caution callouts, soft-error banners, near-quota meters',
          ),
          _PrivateAspectConsumerCard(
            palette: palette,
            aspect: _PrivateColorAspect.danger,
            title: 'danger',
            caption: 'Destructive actions, hard errors, validation failures',
          ),
        ],
      ),
    );
  }
}

class _PrivateAspectConsumerCard extends StatelessWidget {
  const _PrivateAspectConsumerCard({
    required this.palette,
    required this.aspect,
    required this.title,
    required this.caption,
  });

  final _PrivateColorPalette palette;
  final _PrivateColorAspect aspect;
  final String title;
  final String caption;

  @override
  Widget build(BuildContext context) {
    // Real call into the InheritedModel: this registers a per-aspect
    // dependency for this BuildContext.
    final model = _PrivatePaletteModel.of(context, aspect);
    final swatch = model.colorFor(aspect);

    return Container(
      width: 178,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: palette.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: swatch.withValues(alpha: 0.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [swatch, swatch.withValues(alpha: 0.65)],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.all(8),
            child: Text(
              _PrivateUtils.colorToHex(swatch),
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              color: palette.ink,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            caption,
            style: TextStyle(
              color: palette.inkSoft,
              fontSize: 11,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: swatch.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: swatch.withValues(alpha: 0.4),
                width: 1,
              ),
            ),
            child: Text(
              'aspect: $title',
              style: TextStyle(
                color: swatch,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
//  Section 4 -- Contrast: a non-aspectful InheritedWidget
// =====================================================================

class _PrivateSectionContrastBroad extends StatelessWidget {
  const _PrivateSectionContrastBroad({required this.palette});
  final _PrivateColorPalette palette;

  @override
  Widget build(BuildContext context) {
    return _PrivateSectionFrame(
      palette: palette,
      number: '04',
      title: 'Contrast: a non-aspectful InheritedWidget',
      subtitle:
          'A naive InheritedWidget cannot express "depend on one field". '
          'Every dependent rebuilds when *any* of the fields changes.',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _PrivateContrastCard(
              palette: palette,
              title: 'Plain InheritedWidget',
              meterColor: palette.danger,
              meterRatio: 1.0,
              meterCaption: '6 / 6 dependents rebuilt',
              bullets: [
                'updateShouldNotify(prev) returns true.',
                'Framework walks every registered dependent.',
                'No way to express "I only care about primary".',
                'Cost grows linearly with dependent count.',
              ],
              bars: [
                _PrivateBarSlice(label: 'primary', filled: true, palette: palette),
                _PrivateBarSlice(label: 'secondary', filled: true, palette: palette),
                _PrivateBarSlice(label: 'tertiary', filled: true, palette: palette),
                _PrivateBarSlice(label: 'success', filled: true, palette: palette),
                _PrivateBarSlice(label: 'warning', filled: true, palette: palette),
                _PrivateBarSlice(label: 'danger', filled: true, palette: palette),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: _PrivateContrastCard(
              palette: palette,
              title: 'InheritedModel<ColorAspect>',
              meterColor: palette.success,
              meterRatio: 0.18,
              meterCaption: '1 / 6 dependents rebuilt',
              bullets: [
                'updateShouldNotifyDependent(prev, deps) is consulted.',
                'Only dependents whose aspects changed reconcile.',
                'Subscribers declare their slice via inheritFrom(... aspect:).',
                'Cost scales with *changed aspects*, not dependent count.',
              ],
              bars: [
                _PrivateBarSlice(label: 'primary', filled: true, palette: palette),
                _PrivateBarSlice(label: 'secondary', filled: false, palette: palette),
                _PrivateBarSlice(label: 'tertiary', filled: false, palette: palette),
                _PrivateBarSlice(label: 'success', filled: false, palette: palette),
                _PrivateBarSlice(label: 'warning', filled: false, palette: palette),
                _PrivateBarSlice(label: 'danger', filled: false, palette: palette),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateContrastCard extends StatelessWidget {
  const _PrivateContrastCard({
    required this.palette,
    required this.title,
    required this.meterColor,
    required this.meterRatio,
    required this.meterCaption,
    required this.bullets,
    required this.bars,
  });

  final _PrivateColorPalette palette;
  final String title;
  final Color meterColor;
  final double meterRatio;
  final String meterCaption;
  final List<String> bullets;
  final List<_PrivateBarSlice> bars;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: palette.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: palette.ink,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 14),
          // rebuild-cost meter
          Container(
            height: 22,
            decoration: BoxDecoration(
              color: palette.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: palette.border, width: 1),
            ),
            clipBehavior: Clip.antiAlias,
            child: Row(
              children: [
                Flexible(
                  flex: (meterRatio * 100).round(),
                  child: Container(color: meterColor),
                ),
                Flexible(
                  flex: 100 - (meterRatio * 100).round(),
                  child: const SizedBox.shrink(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            meterCaption,
            style: TextStyle(
              color: palette.inkSoft,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: bars
                .map<Widget>(
                  (b) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: b,
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 14),
          ...bullets.map<Widget>(
            (b) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: palette.inkSoft,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      b,
                      style: TextStyle(
                        color: palette.inkSoft,
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateBarSlice extends StatelessWidget {
  const _PrivateBarSlice({
    required this.label,
    required this.filled,
    required this.palette,
  });

  final String label;
  final bool filled;
  final _PrivateColorPalette palette;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 38,
          decoration: BoxDecoration(
            color: filled
                ? palette.danger.withValues(alpha: 0.85)
                : palette.border,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: filled ? palette.ink : palette.inkMute,
            fontSize: 9,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }
}

// =====================================================================
//  Section 5 -- updateShouldNotify vs updateShouldNotifyDependent
// =====================================================================

class _PrivateSectionUpdateMethods extends StatelessWidget {
  const _PrivateSectionUpdateMethods({required this.palette});
  final _PrivateColorPalette palette;

  @override
  Widget build(BuildContext context) {
    return _PrivateSectionFrame(
      palette: palette,
      number: '05',
      title: 'updateShouldNotify vs updateShouldNotifyDependent',
      subtitle:
          'Two different gates. The first short-circuits the entire model; '
          'the second is consulted per-dependent against its declared aspects.',
      child: Column(
        children: [
          _PrivateMethodRow(
            palette: palette,
            tone: palette.primary,
            method: 'updateShouldNotify(T oldWidget) -> bool',
            triggers: 'Once per InheritedModel update',
            answers:
                'Should we even bother walking the dependent list at all?',
            tip:
                'Return true if *any* aspect could conceivably have changed. '
                'Return false to skip the entire notification step.',
          ),
          const SizedBox(height: 12),
          _PrivateMethodRow(
            palette: palette,
            tone: palette.tertiary,
            method:
                'updateShouldNotifyDependent(T old, Set<Aspect> deps) -> bool',
            triggers: 'Once per registered dependent (after the gate above)',
            answers:
                'For *this* dependent, given the aspects it subscribed to, '
                'do any of those aspects actually differ?',
            tip:
                'Compare each aspect in the deps set against oldWidget. '
                'Return true only if a relevant slice changed.',
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: palette.background,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: palette.border, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order of evaluation',
                  style: TextStyle(
                    color: palette.ink,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '1. New PaletteModel is mounted as a replacement.\n'
                  '2. Framework calls updateShouldNotify(oldModel).\n'
                  '   - false => stop. No dependent is touched.\n'
                  '   - true  => continue.\n'
                  '3. For each dependent D with aspect set deps_D:\n'
                  '     framework calls updateShouldNotifyDependent(\n'
                  '       oldModel, deps_D).\n'
                  '   - false => skip D.\n'
                  '   - true  => mark D dirty for the next frame.',
                  style: TextStyle(
                    color: palette.inkSoft,
                    fontSize: 12,
                    height: 1.55,
                    fontFamily: 'monospace',
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

class _PrivateMethodRow extends StatelessWidget {
  const _PrivateMethodRow({
    required this.palette,
    required this.tone,
    required this.method,
    required this.triggers,
    required this.answers,
    required this.tip,
  });

  final _PrivateColorPalette palette;
  final Color tone;
  final String method;
  final String triggers;
  final String answers;
  final String tip;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: palette.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: tone.withValues(alpha: 0.10),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              method,
              style: TextStyle(
                color: tone,
                fontSize: 13,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 10),
          _PrivateLabeledLine(
            palette: palette,
            label: 'fires',
            value: triggers,
          ),
          const SizedBox(height: 6),
          _PrivateLabeledLine(
            palette: palette,
            label: 'answers',
            value: answers,
          ),
          const SizedBox(height: 6),
          _PrivateLabeledLine(
            palette: palette,
            label: 'tip',
            value: tip,
          ),
        ],
      ),
    );
  }
}

class _PrivateLabeledLine extends StatelessWidget {
  const _PrivateLabeledLine({
    required this.palette,
    required this.label,
    required this.value,
  });

  final _PrivateColorPalette palette;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70,
          child: Text(
            label,
            style: TextStyle(
              color: palette.inkMute,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
              letterSpacing: 0.6,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: palette.inkSoft,
              fontSize: 12,
              height: 1.55,
            ),
          ),
        ),
      ],
    );
  }
}

// =====================================================================
//  Section 6 -- 3-step recipe (code-listing card)
// =====================================================================

class _PrivateSectionRecipe extends StatelessWidget {
  const _PrivateSectionRecipe({required this.palette});
  final _PrivateColorPalette palette;

  @override
  Widget build(BuildContext context) {
    return _PrivateSectionFrame(
      palette: palette,
      number: '06',
      title: 'Three-step recipe to build your own InheritedModel',
      subtitle:
          'Define an aspect type, extend InheritedModel<Aspect>, expose a '
          'static of(context, aspect) helper.',
      child: Column(
        children: [
          _PrivateRecipeStep(
            palette: palette,
            index: 1,
            title: 'Define an Aspect type',
            description:
                'An enum is the most common choice. Aspects must implement '
                '== and hashCode -- enums and value-types do this for free.',
            code:
                'enum ColorAspect { primary, secondary, tertiary, success, warning, danger }',
          ),
          const SizedBox(height: 12),
          _PrivateRecipeStep(
            palette: palette,
            index: 2,
            title: 'Extend InheritedModel<Aspect>',
            description:
                'Override updateShouldNotify (cheap pre-check) and '
                'updateShouldNotifyDependent (per-aspect comparison).',
            code:
                'class PaletteModel extends InheritedModel<ColorAspect> {\n'
                '  const PaletteModel({\n'
                '    required this.primary, required this.secondary, ...\n'
                '    required super.child,\n'
                '  });\n'
                '  final Color primary; final Color secondary; /* ... */\n'
                '\n'
                '  @override\n'
                '  bool updateShouldNotify(PaletteModel old) =>\n'
                '      primary != old.primary || secondary != old.secondary || /* ... */;\n'
                '\n'
                '  @override\n'
                '  bool updateShouldNotifyDependent(\n'
                '    PaletteModel old, Set<ColorAspect> deps,\n'
                '  ) =>\n'
                '      (deps.contains(ColorAspect.primary)   && primary   != old.primary)   ||\n'
                '      (deps.contains(ColorAspect.secondary) && secondary != old.secondary) || /* ... */;\n'
                '}',
          ),
          const SizedBox(height: 12),
          _PrivateRecipeStep(
            palette: palette,
            index: 3,
            title: 'Expose a static of(context, aspect) helper',
            description:
                'Subscribers call PaletteModel.of(ctx, aspect). Internally '
                'it forwards to InheritedModel.inheritFrom with the aspect.',
            code:
                'static PaletteModel of(BuildContext context, ColorAspect aspect) {\n'
                '  final m = InheritedModel.inheritFrom<PaletteModel>(\n'
                '    context, aspect: aspect,\n'
                '  );\n'
                '  assert(m != null, "No PaletteModel in scope");\n'
                '  return m!;\n'
                '}',
          ),
        ],
      ),
    );
  }
}

class _PrivateRecipeStep extends StatelessWidget {
  const _PrivateRecipeStep({
    required this.palette,
    required this.index,
    required this.title,
    required this.description,
    required this.code,
  });

  final _PrivateColorPalette palette;
  final int index;
  final String title;
  final String description;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: palette.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [palette.primary, palette.tertiary],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$index',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: palette.ink,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(
              color: palette.inkSoft,
              fontSize: 12,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: palette.ink,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              code,
              style: const TextStyle(
                color: Color(0xFFE5E7EB),
                fontSize: 11.5,
                fontFamily: 'monospace',
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
//  Section 7 -- MediaQuery is an InheritedModel
// =====================================================================

class _PrivateSectionMediaQueryAspects extends StatelessWidget {
  const _PrivateSectionMediaQueryAspects({required this.palette});
  final _PrivateColorPalette palette;

  @override
  Widget build(BuildContext context) {
    final aspects = <_PrivateMediaQueryEntry>[
      _PrivateMediaQueryEntry(
        name: 'size',
        accessor: 'MediaQuery.sizeOf(ctx)',
        oneLiner: 'Logical pixel Size of the surrounding window/region.',
        tone: palette.primary,
      ),
      _PrivateMediaQueryEntry(
        name: 'padding',
        accessor: 'MediaQuery.paddingOf(ctx)',
        oneLiner:
            'System UI insets (status bar, notch, gesture chrome) -- the '
            'safe-content padding.',
        tone: palette.tertiary,
      ),
      _PrivateMediaQueryEntry(
        name: 'viewInsets',
        accessor: 'MediaQuery.viewInsetsOf(ctx)',
        oneLiner:
            'Soft-keyboard / IME inset. Animates open/close, used to hoist '
            'forms above the keyboard.',
        tone: palette.secondary,
      ),
      _PrivateMediaQueryEntry(
        name: 'viewPadding',
        accessor: 'MediaQuery.viewPaddingOf(ctx)',
        oneLiner:
            'Like padding, but unaffected by viewInsets. Useful when you '
            'want the chrome offset even with the keyboard open.',
        tone: palette.success,
      ),
      _PrivateMediaQueryEntry(
        name: 'devicePixelRatio',
        accessor: 'MediaQuery.devicePixelRatioOf(ctx)',
        oneLiner: 'Physical:logical pixel ratio for crisp asset selection.',
        tone: palette.warning,
      ),
      _PrivateMediaQueryEntry(
        name: 'textScaler',
        accessor: 'MediaQuery.textScalerOf(ctx)',
        oneLiner: 'OS-level text scale factor (accessibility larger text).',
        tone: palette.danger,
      ),
      _PrivateMediaQueryEntry(
        name: 'platformBrightness',
        accessor: 'MediaQuery.platformBrightnessOf(ctx)',
        oneLiner: 'System-wide light/dark setting.',
        tone: palette.primary,
      ),
      _PrivateMediaQueryEntry(
        name: 'orientation',
        accessor: 'MediaQuery.orientationOf(ctx)',
        oneLiner: 'Portrait vs Landscape -- derived from size aspect ratio.',
        tone: palette.secondary,
      ),
      _PrivateMediaQueryEntry(
        name: 'accessibleNavigation',
        accessor: 'MediaQuery.accessibleNavigationOf(ctx)',
        oneLiner:
            'A screen reader / switch control is active -- prefer larger '
            'tap targets.',
        tone: palette.tertiary,
      ),
      _PrivateMediaQueryEntry(
        name: 'highContrast',
        accessor: 'MediaQuery.highContrastOf(ctx)',
        oneLiner: 'OS high-contrast accessibility setting.',
        tone: palette.success,
      ),
      _PrivateMediaQueryEntry(
        name: 'disableAnimations',
        accessor: 'MediaQuery.disableAnimationsOf(ctx)',
        oneLiner: '"Reduce motion" accessibility setting -- skip transitions.',
        tone: palette.warning,
      ),
      _PrivateMediaQueryEntry(
        name: 'navigationMode',
        accessor: 'MediaQuery.navigationModeOf(ctx)',
        oneLiner: 'Touch vs directional (TV, desktop arrow-key) navigation.',
        tone: palette.danger,
      ),
    ];

    return _PrivateSectionFrame(
      palette: palette,
      number: '07',
      title: 'MediaQuery: a real InheritedModel in the SDK',
      subtitle:
          'MediaQuery extends InheritedModel<_MediaQueryAspect>. Each '
          'sizeOf / paddingOf / textScalerOf / ... is an aspect-scoped '
          'subscription that only rebuilds you when your slice changes.',
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: aspects.map<Widget>((a) {
          return _PrivateMediaQueryChip(palette: palette, entry: a);
        }).toList(),
      ),
    );
  }
}

class _PrivateMediaQueryEntry {
  const _PrivateMediaQueryEntry({
    required this.name,
    required this.accessor,
    required this.oneLiner,
    required this.tone,
  });

  final String name;
  final String accessor;
  final String oneLiner;
  final Color tone;
}

class _PrivateMediaQueryChip extends StatelessWidget {
  const _PrivateMediaQueryChip({
    required this.palette,
    required this.entry,
  });

  final _PrivateColorPalette palette;
  final _PrivateMediaQueryEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: entry.tone.withValues(alpha: 0.32),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: entry.tone,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                entry.name,
                style: TextStyle(
                  color: palette.ink,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            entry.accessor,
            style: TextStyle(
              color: entry.tone,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 6),
          Text(
            entry.oneLiner,
            style: TextStyle(
              color: palette.inkSoft,
              fontSize: 11,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
//  Section 8 -- Performance comparison panel
// =====================================================================

class _PrivateSectionPerfBars extends StatelessWidget {
  const _PrivateSectionPerfBars({required this.palette});
  final _PrivateColorPalette palette;

  @override
  Widget build(BuildContext context) {
    final rows = <_PrivatePerfRow>[
      _PrivatePerfRow(
        label: 'Plain InheritedWidget',
        sublabel: 'every dependent rebuilds on any change',
        ratio: 1.00,
        color: palette.danger,
        cost: '100% (baseline)',
      ),
      _PrivatePerfRow(
        label: 'InheritedModel (broad subscribe)',
        sublabel: 'depend-on without aspect == falls back to InheritedWidget',
        ratio: 0.92,
        color: palette.warning,
        cost: '~92%',
      ),
      _PrivatePerfRow(
        label: 'InheritedModel (aspect subscribe)',
        sublabel: 'inheritFrom(ctx, aspect: oneSlice)',
        ratio: 0.22,
        color: palette.success,
        cost: '~22%',
      ),
      _PrivatePerfRow(
        label: 'Provider / Riverpod selector',
        sublabel: 'select((s) => s.field) with == short-circuit',
        ratio: 0.18,
        color: palette.primary,
        cost: '~18%',
      ),
    ];

    return _PrivateSectionFrame(
      palette: palette,
      number: '08',
      title: 'Relative rebuild count under one model mutation',
      subtitle:
          'Six dependents subscribe; one aspect changes. Lower is better. '
          'Numbers are illustrative orders-of-magnitude, not benchmarks.',
      child: Column(
        children: rows
            .map<Widget>(
              (r) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _PrivatePerfBar(palette: palette, row: r),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _PrivatePerfRow {
  const _PrivatePerfRow({
    required this.label,
    required this.sublabel,
    required this.ratio,
    required this.color,
    required this.cost,
  });

  final String label;
  final String sublabel;
  final double ratio;
  final Color color;
  final String cost;
}

class _PrivatePerfBar extends StatelessWidget {
  const _PrivatePerfBar({required this.palette, required this.row});
  final _PrivateColorPalette palette;
  final _PrivatePerfRow row;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: palette.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      row.label,
                      style: TextStyle(
                        color: palette.ink,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      row.sublabel,
                      style: TextStyle(
                        color: palette.inkSoft,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: row.color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  row.cost,
                  style: TextStyle(
                    color: row.color,
                    fontSize: 11,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 14,
            decoration: BoxDecoration(
              color: palette.background,
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: palette.border, width: 1),
            ),
            clipBehavior: Clip.antiAlias,
            child: Row(
              children: [
                Flexible(
                  flex: (row.ratio * 1000).round(),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          row.color.withValues(alpha: 0.7),
                          row.color,
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1000 - (row.ratio * 1000).round(),
                  child: const SizedBox.shrink(),
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
//  Section 9 -- Pitfalls
// =====================================================================

class _PrivateSectionPitfalls extends StatelessWidget {
  const _PrivateSectionPitfalls({required this.palette});
  final _PrivateColorPalette palette;

  @override
  Widget build(BuildContext context) {
    final items = <_PrivatePitfall>[
      _PrivatePitfall(
        title: 'Do NOT call dependOnInheritedWidgetOfExactType directly',
        body:
            'That bypasses the aspect machinery. The dependent gets registered '
            'with an empty aspect set, which behaves like "subscribe to '
            'everything" -- you lose the selective rebuild benefit. Always '
            'go through InheritedModel.inheritFrom(ctx, aspect: ...).',
        color: palette.danger,
      ),
      _PrivatePitfall(
        title: 'Aspects must implement == and hashCode correctly',
        body:
            'Aspects are stored in a Set. Two equal aspect values that are '
            '!= will register as different dependencies. Stick with enums or '
            'symbol-like value types -- never freshly-allocated objects with '
            'identity equality.',
        color: palette.warning,
      ),
      _PrivatePitfall(
        title: 'updateShouldNotifyDependent must be cheap',
        body:
            'It is called once per dependent on every relevant rebuild. '
            'Avoid map lookups, allocation, or anything sub-linear in the '
            'aspect set. Prefer a switch / chain of contains-checks.',
        color: palette.tertiary,
      ),
      _PrivatePitfall(
        title: 'Do not forget updateShouldNotify',
        body:
            'It is the cheap pre-gate. If you return false here, none of the '
            'per-dependent work runs. A common mistake is to only override '
            'updateShouldNotifyDependent and forget the outer gate.',
        color: palette.primary,
      ),
      _PrivatePitfall(
        title: 'A single aspect-less inheritFrom poisons the dependent',
        body:
            'Calling inheritFrom without an aspect (or via the legacy '
            '.of helper) registers the dependent with an empty aspect set. '
            'Once that happens for a context, it will be rebuilt on *every* '
            'model change, regardless of any other aspect-scoped calls.',
        color: palette.secondary,
      ),
      _PrivatePitfall(
        title: 'Aspects are per-call, not per-context',
        body:
            'Each call to inheritFrom adds the supplied aspect to that '
            'dependent\'s set. To cleanly migrate, ensure every read of the '
            'model in a given build path uses the right aspect.',
        color: palette.success,
      ),
    ];

    return _PrivateSectionFrame(
      palette: palette,
      number: '09',
      title: 'Pitfalls and gotchas',
      subtitle:
          'The aspect machinery is opt-in; mis-use silently degrades to the '
          'plain InheritedWidget behavior.',
      child: Column(
        children: items
            .map<Widget>(
              (p) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _PrivatePitfallCard(palette: palette, pitfall: p),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _PrivatePitfall {
  const _PrivatePitfall({
    required this.title,
    required this.body,
    required this.color,
  });

  final String title;
  final String body;
  final Color color;
}

class _PrivatePitfallCard extends StatelessWidget {
  const _PrivatePitfallCard({
    required this.palette,
    required this.pitfall,
  });

  final _PrivateColorPalette palette;
  final _PrivatePitfall pitfall;

  @override
  Widget build(BuildContext context) {
    // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #116, P5(a)):
    // Original decoration combined `borderRadius: 12` with a *non-uniform*
    // `Border(left: pitfall.color/4, top/right/bottom: palette.border/1)`.
    // Flutter requires uniform colors when a borderRadius is present, so the
    // mismatched left vs. {top,right,bottom} colours triggered "A
    // borderRadius can only be given on borders with uniform colors." The
    // card is rendered six times (one per pitfall in section 9), which is
    // why the baseline reports six identical framework errors.
    //
    // Refactor: paint the rounded rectangle once via `ClipRRect(12)` around
    // an `IntrinsicHeight > Row(stretch)` whose first child is a 4 px-wide
    // coloured "accent strip" Container and whose second child is an
    // Expanded with the original padded content. The remaining frame uses a
    // uniform `Border.all(color: palette.border, width: 1)`. Visually
    // identical (left edge tinted by `pitfall.color`, rounded corners,
    // single-px frame), but with only uniform-coloured borders.
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: IntrinsicHeight(
        child: Container(
          decoration: BoxDecoration(
            color: palette.surface,
            border: Border.all(color: palette.border, width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(width: 4, color: pitfall.color),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: pitfall.color.withValues(alpha: 0.13),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.report_gmailerrorred_rounded,
                          size: 18,
                          color: pitfall.color,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pitfall.title,
                              style: TextStyle(
                                color: palette.ink,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              pitfall.body,
                              style: TextStyle(
                                color: palette.inkSoft,
                                fontSize: 12,
                                height: 1.55,
                              ),
                            ),
                          ],
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
    );
  }
}

// =====================================================================
//  Section 10 -- Footer / call-to-action
// =====================================================================

class _PrivateSectionFooter extends StatelessWidget {
  const _PrivateSectionFooter({required this.palette});
  final _PrivateColorPalette palette;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(28, 26, 28, 26),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [palette.ink, palette.inkSoft],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Reach for InheritedModel when:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '- you have one wide model with many independent fields\n'
                  '- consumers naturally cluster around individual fields\n'
                  '- you cannot afford to rebuild every consumer on every '
                  'change\n'
                  '- you do NOT want to pull in a state-management library',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 13,
                    height: 1.7,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.25),
                width: 1,
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'try-it',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    letterSpacing: 0.6,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'PaletteModel.of(\n'
                  '  context,\n'
                  '  ColorAspect.primary,\n'
                  ')',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontFamily: 'monospace',
                    height: 1.45,
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
//  Shared section frame
// =====================================================================

class _PrivateSectionFrame extends StatelessWidget {
  const _PrivateSectionFrame({
    required this.palette,
    required this.number,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final _PrivateColorPalette palette;
  final String number;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: palette.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: palette.ink.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: palette.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: palette.primary.withValues(alpha: 0.32),
                    width: 1,
                  ),
                ),
                child: Text(
                  number,
                  style: TextStyle(
                    color: palette.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                    letterSpacing: 0.6,
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
                      style: TextStyle(
                        color: palette.ink,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: palette.inkSoft,
                        fontSize: 13,
                        height: 1.55,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}

// =====================================================================
//  Utilities
// =====================================================================

class _PrivateUtils {
  const _PrivateUtils._();

  static String colorToHex(Color c) {
    final r = (c.r * 255.0).round() & 0xff;
    final g = (c.g * 255.0).round() & 0xff;
    final b = (c.b * 255.0).round() & 0xff;
    return '#'
        '${r.toRadixString(16).padLeft(2, '0').toUpperCase()}'
        '${g.toRadixString(16).padLeft(2, '0').toUpperCase()}'
        '${b.toRadixString(16).padLeft(2, '0').toUpperCase()}';
  }
}

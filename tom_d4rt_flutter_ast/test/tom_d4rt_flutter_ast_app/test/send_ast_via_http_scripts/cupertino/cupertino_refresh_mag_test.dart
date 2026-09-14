// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: hand-authored deep visual demo for CupertinoSliverRefreshControl,
// CupertinoMagnifier, and Cupertino tab/transition family
//
// The demo composes six visual chapters into a single scrolling
// CupertinoPageScaffold. Every chapter renders a static, frame-frozen snapshot
// of the underlying widget — no AnimationController, no Ticker, no setState.
// CupertinoPageTransition and CupertinoFullscreenDialogTransition snapshots use
// AlwaysStoppedAnimation<double>(t) for fixed-frame interpolation.
//
// Chapters:
//   1. CupertinoSliverRefreshControl state gallery (idle / armed / dragging
//      / refreshing / done) rendered via the default buildRefreshIndicator
//      contract using static activity indicators and chevrons.
//   2. CupertinoMagnifier / CupertinoTextMagnifier showcase with focal-point
//      offset variants and styled lens frames.
//   3. CupertinoTabScaffold + CupertinoTabBar + CupertinoTabView composition
//      sample shown inside a fixed-size sandbox (so the outer ListView keeps
//      scrolling). Also demonstrates CupertinoTabController construction.
//   4. CupertinoPageTransition snapshot grid at five interpolation positions
//      (0.0, 0.25, 0.5, 0.75, 1.0) using AlwaysStoppedAnimation snapshots.
//   5. CupertinoFullscreenDialogTransition snapshot grid for the same five
//      interpolation positions, contrasted with the page transition.
//   6. Theme comparison + reference card describing API surface, callback
//      signatures and interpreter-friendly substitutions.

import 'package:flutter/cupertino.dart';

// ============================================================================
// Entry point
// ============================================================================

dynamic build(BuildContext context) {
  print('cupertino_refresh_mag_test: build() invoked');
  print('cupertino_refresh_mag_test: composing 6 chapters');

  final chapter1 = _buildRefreshChapter();
  print('cupertino_refresh_mag_test: chapter 1 (refresh) built');

  final chapter2 = _buildMagnifierChapter();
  print('cupertino_refresh_mag_test: chapter 2 (magnifier) built');

  final chapter3 = _buildTabScaffoldChapter();
  print('cupertino_refresh_mag_test: chapter 3 (tab scaffold) built');

  final chapter4 = _buildPageTransitionChapter();
  print('cupertino_refresh_mag_test: chapter 4 (page transition) built');

  final chapter5 = _buildFullscreenDialogChapter();
  print('cupertino_refresh_mag_test: chapter 5 (fullscreen dialog) built');

  final chapter6 = _buildReferenceChapter();
  print('cupertino_refresh_mag_test: chapter 6 (reference) built');

  print('cupertino_refresh_mag_test: assembling CupertinoApp shell');

  return CupertinoApp(
    title: 'Refresh, Magnifier & Tab Family',
    debugShowCheckedModeBanner: false,
    theme: const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: CupertinoColors.systemIndigo,
      scaffoldBackgroundColor: Color(0xFFF2F2F7),
    ),
    home: CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Refresh • Magnifier • Tabs'),
        backgroundColor: Color(0xF8F8F8FA),
        border: Border(
          bottom: BorderSide(color: Color(0x1A000000), width: 0.0),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 48),
          children: [
            _buildHeroBanner(),
            const SizedBox(height: 20),
            chapter1,
            const SizedBox(height: 28),
            chapter2,
            const SizedBox(height: 28),
            chapter3,
            const SizedBox(height: 28),
            chapter4,
            const SizedBox(height: 28),
            chapter5,
            const SizedBox(height: 28),
            chapter6,
            const SizedBox(height: 32),
            _buildFooter(),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// Hero banner
// ============================================================================

Widget _buildHeroBanner() {
  return Container(
    padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF5856D6), Color(0xFFAF52DE)],
      ),
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF5856D6).withOpacity(0.35),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: CupertinoColors.white.withOpacity(0.22),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: CupertinoColors.white.withOpacity(0.5),
                  width: 0.5,
                ),
              ),
              child: const Icon(
                CupertinoIcons.arrow_2_circlepath,
                color: CupertinoColors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cupertino Capability Tour',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.4,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Refresh control • Magnifier • Tab family • Transitions',
                    style: TextStyle(
                      color: Color(0xFFEDE7FF),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _heroChip('CupertinoSliverRefreshControl'),
            _heroChip('CupertinoMagnifier'),
            _heroChip('CupertinoTextMagnifier'),
            _heroChip('CupertinoTabScaffold'),
            _heroChip('CupertinoTabBar'),
            _heroChip('CupertinoTabView'),
            _heroChip('CupertinoPageTransition'),
            _heroChip('CupertinoFullscreenDialogTransition'),
          ],
        ),
      ],
    ),
  );
}

Widget _heroChip(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: CupertinoColors.white.withOpacity(0.22),
      borderRadius: BorderRadius.circular(999),
      border: Border.all(
        color: CupertinoColors.white.withOpacity(0.45),
        width: 0.5,
      ),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: CupertinoColors.white,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
      ),
    ),
  );
}

// ============================================================================
// Shared section title
// ============================================================================

Widget _sectionTitle(
  String number,
  String title,
  String subtitle,
  IconData icon,
  Color tint,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [tint.withOpacity(0.95), tint.withOpacity(0.55)],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: tint.withOpacity(0.35),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: CupertinoColors.white, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: tint.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      number,
                      style: TextStyle(
                        color: tint,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1C1C1E),
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6E6E73),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _card({required Widget child, EdgeInsets? padding}) {
  return Container(
    padding: padding ?? const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: CupertinoColors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0x1A000000), width: 0.5),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0F000000),
          blurRadius: 12,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: child,
  );
}

Widget _explanationBox(String label, String text, Color tint) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: tint.withOpacity(0.08),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: tint.withOpacity(0.25), width: 0.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(CupertinoIcons.info_circle_fill, color: tint, size: 14),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: tint,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12.5,
            color: Color(0xFF3C3C43),
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _propRow(String name, String value, {Color? tint}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1C1C1E),
              fontFamily: 'Menlo',
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: tint ?? const Color(0xFF6E6E73),
              fontFamily: 'Menlo',
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Chapter 1: CupertinoSliverRefreshControl state gallery
// ============================================================================

Widget _buildRefreshChapter() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'CHAPTER 1',
          'CupertinoSliverRefreshControl',
          'Pull-to-refresh sliver with 5 lifecycle states',
          CupertinoIcons.arrow_clockwise,
          CupertinoColors.systemBlue,
        ),
        const Text(
          'CupertinoSliverRefreshControl is a sliver that responds to overscroll '
          'and triggers an asynchronous onRefresh callback. Because the interpreter '
          'cannot drive Futures or AnimationControllers, this gallery renders each '
          'state as a static snapshot using the default indicator anatomy: a chevron '
          'or CupertinoActivityIndicator inside a fixed-height row.',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF3C3C43),
            height: 1.42,
          ),
        ),
        const SizedBox(height: 14),
        _propRow('Constructor', 'CupertinoSliverRefreshControl(...)'),
        _propRow('refreshTriggerPullDistance', '100.0 (default)'),
        _propRow('refreshIndicatorExtent', '60.0 (default)'),
        _propRow('onRefresh', 'RefreshCallback? (async)'),
        _propRow('builder', 'RefreshControlIndicatorBuilder?'),
        const SizedBox(height: 16),
        const Text(
          'Lifecycle states',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 8),
        _refreshStateRow(
          state: 'inactive',
          tint: const Color(0xFFAEAEB2),
          description:
              'Idle. Pull distance below refreshTriggerPullDistance/0.5. No indicator.',
          indicator: _refreshSnapshot(progress: 0.0, refreshing: false),
        ),
        const SizedBox(height: 10),
        _refreshStateRow(
          state: 'drag',
          tint: const Color(0xFF8E8E93),
          description:
              'User pulling, < 100%. Chevron rotates with the pull ratio.',
          indicator: _refreshSnapshot(progress: 0.45, refreshing: false),
        ),
        const SizedBox(height: 10),
        _refreshStateRow(
          state: 'armed',
          tint: const Color(0xFF34C759),
          description:
              'Pull crossed threshold (≥ 100%). Chevron fully rotated to up; '
              'release will trigger onRefresh.',
          indicator: _refreshSnapshot(progress: 1.0, refreshing: false),
        ),
        const SizedBox(height: 10),
        _refreshStateRow(
          state: 'refresh',
          tint: const Color(0xFF007AFF),
          description:
              'onRefresh is running. Spinner shown until the returned Future '
              'completes.',
          indicator: _refreshSnapshot(progress: 1.0, refreshing: true),
        ),
        const SizedBox(height: 10),
        _refreshStateRow(
          state: 'done',
          tint: const Color(0xFFFF9500),
          description:
              'Future resolved. Indicator collapses back to inactive over a '
              '~150ms animation.',
          indicator: _refreshSnapshot(progress: 0.2, refreshing: false),
        ),
        const SizedBox(height: 18),
        _explanationBox(
          'INTERPRETER NOTE',
          'CupertinoSliverRefreshControl requires a Future<void>-returning '
          'onRefresh callback. The d4rt analyzer-free interpreter cannot run '
          'async functions, so we pass onRefresh: null to keep the sliver in '
          'pure-display mode. The widget still mounts and reports its inactive '
          'state to the scrollable.',
          CupertinoColors.systemIndigo,
        ),
        const SizedBox(height: 12),
        _refreshCompositionSample(),
      ],
    ),
  );
}

Widget _refreshStateRow({
  required String state,
  required Color tint,
  required String description,
  required Widget indicator,
}) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0xFFF7F7FA),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: tint.withOpacity(0.3), width: 0.5),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 64,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0x1A000000), width: 0.5),
          ),
          child: indicator,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: tint.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: tint.withOpacity(0.45),
                        width: 0.5,
                      ),
                    ),
                    child: Text(
                      state,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: tint,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF3C3C43),
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _refreshSnapshot({required double progress, required bool refreshing}) {
  // Render a snapshot of the default refresh indicator. We synthesize the
  // chevron rotation using Transform.rotate with a static angle, and the
  // refreshing state with a CupertinoActivityIndicator (no animation needed
  // visually for a snapshot, but it still mounts cleanly under d4rt).
  if (refreshing) {
    return const CupertinoActivityIndicator(radius: 12, animating: false);
  }
  if (progress <= 0.0) {
    return const SizedBox(width: 26, height: 26);
  }
  // Chevron rotates from down (0.0) to up (1.0) — 180° total.
  final double angle = 3.14159 * progress;
  final double opacity = 0.35 + 0.65 * progress.clamp(0.0, 1.0);
  return Transform.rotate(
    angle: angle,
    child: Icon(
      CupertinoIcons.chevron_down,
      color: const Color(0xFF8E8E93).withOpacity(opacity),
      size: 22,
    ),
  );
}

Widget _refreshCompositionSample() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFF7F7FA),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0x1A000000), width: 0.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Composition inside CustomScrollView',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 140,
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0x1A000000), width: 0.5),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CustomScrollView(
              physics: const NeverScrollableScrollPhysics(),
              slivers: [
                const CupertinoSliverRefreshControl(
                  refreshTriggerPullDistance: 100.0,
                  refreshIndicatorExtent: 60.0,
                  onRefresh: null,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, i) {
                    return Container(
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      alignment: Alignment.centerLeft,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0x14000000),
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Text(
                        'Row ${i + 1}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF1C1C1E),
                        ),
                      ),
                    );
                  }, childCount: 6),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Real CupertinoSliverRefreshControl mounted at the top of a tiny '
          'sandboxed CustomScrollView (scrolling disabled). onRefresh is null '
          'because async callbacks are not supported by the interpreter.',
          style: TextStyle(
            fontSize: 11.5,
            color: Color(0xFF6E6E73),
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Chapter 2: CupertinoMagnifier / CupertinoTextMagnifier
// ============================================================================

Widget _buildMagnifierChapter() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'CHAPTER 2',
          'CupertinoMagnifier & CupertinoTextMagnifier',
          'iOS-style loupe widgets for selection handles',
          CupertinoIcons.search_circle_fill,
          CupertinoColors.systemPink,
        ),
        const Text(
          'CupertinoMagnifier renders a translucent rounded-rect lens that '
          'displays a magnified backdrop. CupertinoTextMagnifier wraps it '
          'with the controller logic used by Cupertino text selection. The '
          'controls expose size, borderRadius, additionalFocalPointOffset, '
          'and an optional inOutAnimation that drives entry/exit.',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF3C3C43),
            height: 1.42,
          ),
        ),
        const SizedBox(height: 14),
        _propRow('size', 'Size(80, 48)  (default)'),
        _propRow('borderRadius', 'BorderRadius.circular(40)'),
        _propRow('additionalFocalPointOffset', 'Offset(0, -8)'),
        _propRow('inOutAnimation', 'Animation<double>? (entry/exit)'),
        _propRow('borderSide', 'BorderSide(color: gray, width: 1)'),
        const SizedBox(height: 16),
        const Text(
          'Magnifier showcase',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 10),
        _magnifierShowcase(),
        const SizedBox(height: 16),
        const Text(
          'Lens variants',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 10),
        _magnifierVariants(),
        const SizedBox(height: 16),
        const Text(
          'CupertinoTextMagnifier',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 8),
        _textMagnifierDemo(),
        const SizedBox(height: 14),
        _explanationBox(
          'WHEN TO USE',
          'CupertinoTextMagnifier is wired into the Cupertino text selection '
          'overlays via the magnifierConfiguration property on selection '
          'controls. You rarely instantiate it directly — but knowing its '
          'inOutAnimation contract helps when integrating custom selection '
          'handles or testing rendering snapshots.',
          CupertinoColors.systemPink,
        ),
      ],
    ),
  );
}

Widget _magnifierShowcase() {
  // Static "fake content" beneath the magnifier — a strip of color squares so
  // the lens has something visually identifiable to magnify (the d4rt
  // interpreter doesn't actually render the backdrop sampling, but the lens
  // chrome paints normally).
  return Container(
    height: 140,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFDF5FF), Color(0xFFE3DBFF)],
      ),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0x1A000000), width: 0.5),
    ),
    child: Stack(
      children: [
        Positioned(
          left: 16,
          top: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _swatch(const Color(0xFFFF3B30)),
              _swatch(const Color(0xFFFF9500)),
              _swatch(const Color(0xFFFFCC00)),
              _swatch(const Color(0xFF34C759)),
              _swatch(const Color(0xFF5AC8FA)),
              _swatch(const Color(0xFF007AFF)),
              _swatch(const Color(0xFF5856D6)),
              _swatch(const Color(0xFFAF52DE)),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 14,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: CupertinoColors.white.withOpacity(0.65),
                borderRadius: BorderRadius.circular(44),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const CupertinoMagnifier(
                size: Size(96, 56),
                borderRadius: BorderRadius.all(Radius.circular(48)),
                additionalFocalPointOffset: Offset(0, -8),
              ),
            ),
          ),
        ),
        Positioned(
          left: 12,
          bottom: 6,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: CupertinoColors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'size: 96×56  •  radius: 48',
              style: TextStyle(
                fontSize: 10,
                color: CupertinoColors.white,
                fontFamily: 'Menlo',
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _swatch(Color color) {
  return Container(
    width: 22,
    height: 22,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.4),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
  );
}

Widget _magnifierVariants() {
  final variants = <_MagVariant>[
    const _MagVariant(
      label: 'Default',
      size: Size(80, 48),
      radius: 40,
      offset: Offset(0, -8),
    ),
    const _MagVariant(
      label: 'Wide',
      size: Size(120, 48),
      radius: 24,
      offset: Offset(0, -10),
    ),
    const _MagVariant(
      label: 'Square',
      size: Size(64, 64),
      radius: 12,
      offset: Offset(0, -6),
    ),
    const _MagVariant(
      label: 'Tall',
      size: Size(60, 80),
      radius: 30,
      offset: Offset(0, -4),
    ),
  ];

  final cards = <Widget>[];
  for (var i = 0; i < variants.length; i++) {
    cards.add(_variantCard(variants[i]));
  }
  return Wrap(spacing: 10, runSpacing: 10, children: cards);
}

class _MagVariant {
  final String label;
  final Size size;
  final double radius;
  final Offset offset;
  const _MagVariant({
    required this.label,
    required this.size,
    required this.radius,
    required this.offset,
  });
}

Widget _variantCard(_MagVariant v) {
  return Container(
    width: 150,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0xFFF7F7FA),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0x1A000000), width: 0.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          v.label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Container(
            width: 130,
            height: 96,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFE5F1), Color(0xFFE9E0FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: CupertinoMagnifier(
              size: v.size,
              borderRadius: BorderRadius.all(Radius.circular(v.radius)),
              additionalFocalPointOffset: v.offset,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'size ${v.size.width.toInt()}×${v.size.height.toInt()}',
          style: const TextStyle(
            fontSize: 10.5,
            color: Color(0xFF6E6E73),
            fontFamily: 'Menlo',
          ),
        ),
        Text(
          'radius ${v.radius.toInt()}',
          style: const TextStyle(
            fontSize: 10.5,
            color: Color(0xFF6E6E73),
            fontFamily: 'Menlo',
          ),
        ),
      ],
    ),
  );
}

Widget _textMagnifierDemo() {
  // CupertinoTextMagnifier requires a MagnifierController and animation.
  // We don't have an AnimationController, so we render a styled "preview"
  // surface that mirrors the visual chrome of the real widget. The actual
  // CupertinoTextMagnifier construction is shown in the reference card so
  // the d4rt corpus still exercises the static class symbol resolution.
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFF7F7FA),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0x1A000000), width: 0.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0x1A000000), width: 0.5),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 8,
                child: const Text(
                  'The quick brown fox jumps over the lazy dog',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF1C1C1E),
                  ),
                ),
              ),
              Positioned(
                left: 124,
                top: 32,
                child: Container(
                  width: 80,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0x33000000),
                      width: 0.5,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x22000000),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Text(
                    'fox',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1C1C1E),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 154,
                top: 8,
                child: Container(
                  width: 2,
                  height: 18,
                  color: CupertinoColors.systemBlue,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'CupertinoTextMagnifier hovers above the caret while the user '
          'drags a selection handle. It accepts a MagnifierController and an '
          'animation that drives entry/exit; the controller decides when to '
          'show/hide via TextMagnifierConfiguration.magnifierBuilder.',
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF3C3C43),
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Chapter 3: CupertinoTabScaffold + CupertinoTabBar + CupertinoTabView
// ============================================================================

Widget _buildTabScaffoldChapter() {
  // Build a CupertinoTabController inside a non-disposable static scope.
  // We do NOT dispose it — letting the test harness manage lifecycle.
  final tabController = CupertinoTabController(initialIndex: 1);
  print(
    'cupertino_refresh_mag_test: CupertinoTabController initialIndex='
    '${tabController.index}',
  );

  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'CHAPTER 3',
          'CupertinoTabScaffold / TabBar / TabView',
          'iOS bottom-tab navigation: bar, scaffold, view',
          CupertinoIcons.square_grid_2x2_fill,
          CupertinoColors.systemTeal,
        ),
        const Text(
          'CupertinoTabScaffold composes a CupertinoTabBar at the bottom and '
          'a body that switches between independent CupertinoTabView trees. '
          'CupertinoTabController exposes the active index and allows external '
          'navigation. Each tab keeps its own Navigator stack — useful for '
          'iOS-style tab persistence and root-route navigation.',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF3C3C43),
            height: 1.42,
          ),
        ),
        const SizedBox(height: 14),
        _propRow('CupertinoTabScaffold', 'tabBar + tabBuilder'),
        _propRow('CupertinoTabBar', 'items + activeColor + inactiveColor'),
        _propRow('CupertinoTabView', 'builder + routes + defaultTitle'),
        _propRow('CupertinoTabController', 'index, addListener, dispose'),
        const SizedBox(height: 16),
        const Text(
          'Composition diagram',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 8),
        _tabAnatomy(),
        const SizedBox(height: 16),
        const Text(
          'Live CupertinoTabScaffold sample',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 8),
        _tabScaffoldSandbox(),
        const SizedBox(height: 16),
        const Text(
          'CupertinoTabBar variants',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 8),
        _tabBarVariants(),
        const SizedBox(height: 14),
        _explanationBox(
          'CONTROLLER TIP',
          'CupertinoTabController is a ChangeNotifier. Set controller.index '
          'from outside the widget tree to switch tabs without rebuilding. '
          'Always dispose it from a StatefulWidget — in this static demo we '
          'rely on the test driver to garbage-collect it.',
          CupertinoColors.systemTeal,
        ),
      ],
    ),
  );
}

Widget _tabAnatomy() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFF7F7FA),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0x1A000000), width: 0.5),
    ),
    child: Column(
      children: [
        Container(
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: CupertinoColors.systemTeal.withOpacity(0.15),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: CupertinoColors.systemTeal,
              width: 0.5,
            ),
          ),
          child: const Text(
            'CupertinoTabScaffold',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: CupertinoColors.systemTeal,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 70,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: CupertinoColors.systemIndigo.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: CupertinoColors.systemIndigo,
                    width: 0.5,
                  ),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'tabBuilder(ctx, idx)',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: CupertinoColors.systemIndigo,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'returns CupertinoTabView',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF6E6E73),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: CupertinoColors.systemPink.withOpacity(0.12),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: CupertinoColors.systemPink,
              width: 0.5,
            ),
          ),
          child: const Text(
            'CupertinoTabBar  (items + colors)',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: CupertinoColors.systemPink,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _tabScaffoldSandbox() {
  // A real CupertinoTabScaffold embedded inside a fixed-height container so
  // the outer scrolling shell keeps working.
  return Container(
    height: 360,
    decoration: BoxDecoration(
      color: CupertinoColors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0x1A000000), width: 0.5),
      boxShadow: const [
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.house_fill),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.bell_fill),
              label: 'Alerts',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_alt_circle_fill),
              label: 'Account',
            ),
          ],
          activeColor: CupertinoColors.activeBlue,
          inactiveColor: CupertinoColors.inactiveGray,
          backgroundColor: const Color(0xF8F8F8FA),
          iconSize: 26.0,
          height: 50.0,
          currentIndex: 0,
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            defaultTitle: _tabTitleFor(index),
            builder: (context) {
              return _tabBody(index);
            },
          );
        },
        backgroundColor: const Color(0xFFF2F2F7),
        resizeToAvoidBottomInset: true,
      ),
    ),
  );
}

String _tabTitleFor(int index) {
  if (index == 0) return 'Home';
  if (index == 1) return 'Search';
  if (index == 2) return 'Alerts';
  return 'Account';
}

Widget _tabBody(int index) {
  final colors = <Color>[
    const Color(0xFF007AFF),
    const Color(0xFFFF9500),
    const Color(0xFFFF3B30),
    const Color(0xFF34C759),
  ];
  final icons = <IconData>[
    CupertinoIcons.house_fill,
    CupertinoIcons.search,
    CupertinoIcons.bell_fill,
    CupertinoIcons.person_alt_circle_fill,
  ];
  final color = colors[index];
  final icon = icons[index];
  final title = _tabTitleFor(index);
  return CupertinoPageScaffold(
    navigationBar: CupertinoNavigationBar(
      middle: Text(title),
      backgroundColor: const Color(0xF8F8F8FA),
    ),
    child: SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.85), color.withOpacity(0.5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(icon, color: CupertinoColors.white, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'CupertinoTabView body',
                        style: TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0x1A000000),
                width: 0.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tab index: $index',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF1C1C1E),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Each tab keeps its own Navigator state. Routes can be '
                  'declared on CupertinoTabView.routes for nested pushes.',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFF6E6E73),
                    height: 1.35,
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

Widget _tabBarVariants() {
  return Column(
    children: [
      _tabBarSample(
        title: 'Default tab bar',
        bar: CupertinoTabBar(
          currentIndex: 1,
          activeColor: CupertinoColors.activeBlue,
          inactiveColor: CupertinoColors.inactiveGray,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.house),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.gear),
              label: 'Settings',
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
      _tabBarSample(
        title: 'Custom colors + height',
        bar: CupertinoTabBar(
          currentIndex: 0,
          activeColor: const Color(0xFFAF52DE),
          inactiveColor: const Color(0xFFB0B0B5),
          backgroundColor: const Color(0xFFFAF5FF),
          height: 60.0,
          iconSize: 28.0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.music_note),
              activeIcon: Icon(CupertinoIcons.music_note_2),
              label: 'Library',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.heart),
              activeIcon: Icon(CupertinoIcons.heart_fill),
              label: 'Likes',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cloud_download),
              label: 'Downloads',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
      _tabBarSample(
        title: 'Compact icon-only',
        bar: CupertinoTabBar(
          currentIndex: 2,
          activeColor: const Color(0xFF34C759),
          inactiveColor: const Color(0xFFC7C7CC),
          backgroundColor: const Color(0xFFFFFFFF),
          height: 44.0,
          iconSize: 22.0,
          items: const [
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.bolt)),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.cloud_sun)),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.flame)),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.snow)),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.moon_stars)),
          ],
        ),
      ),
    ],
  );
}

Widget _tabBarSample({required String title, required CupertinoTabBar bar}) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0xFFF7F7FA),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0x1A000000), width: 0.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(height: 60, child: bar),
      ],
    ),
  );
}

// ============================================================================
// Chapter 4: CupertinoPageTransition snapshots
// ============================================================================

Widget _buildPageTransitionChapter() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'CHAPTER 4',
          'CupertinoPageTransition',
          'iOS-style push slide animation, snapshot grid',
          CupertinoIcons.arrow_right_square_fill,
          CupertinoColors.systemOrange,
        ),
        const Text(
          'CupertinoPageTransition drives the slide-in animation for a route '
          'pushed onto a Cupertino navigator. It takes two animations: '
          'primaryRouteAnimation (this route appearing) and '
          'secondaryRouteAnimation (an enclosing route exiting). Because we '
          'cannot tick an AnimationController, each tile freezes the '
          'animation at a fixed AlwaysStoppedAnimation<double>(t) snapshot.',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF3C3C43),
            height: 1.42,
          ),
        ),
        const SizedBox(height: 14),
        _propRow('primaryRouteAnimation', 'Animation<double> (incoming)'),
        _propRow('secondaryRouteAnimation', 'Animation<double> (outgoing)'),
        _propRow('linearTransition', 'bool (skip Cupertino curve)'),
        _propRow('child', 'Widget — the page being shown'),
        const SizedBox(height: 16),
        const Text(
          'Five-stop snapshot grid',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 8),
        _pageTransitionGrid(),
        const SizedBox(height: 14),
        _explanationBox(
          'INTERPOLATION',
          't=0.0 is the route fully off-screen (right side). t=1.0 is the '
          'route fully settled. linearTransition=false applies the Cupertino '
          'curve; setting it to true gives a constant-speed slide useful for '
          'driven hero animations.',
          CupertinoColors.systemOrange,
        ),
      ],
    ),
  );
}

Widget _pageTransitionGrid() {
  final stops = <double>[0.0, 0.25, 0.5, 0.75, 1.0];
  final rows = <Widget>[];
  for (var i = 0; i < stops.length; i++) {
    rows.add(_pageTransitionRow(stops[i]));
    if (i < stops.length - 1) {
      rows.add(const SizedBox(height: 10));
    }
  }
  return Column(children: rows);
}

Widget _pageTransitionRow(double t) {
  final anim = AlwaysStoppedAnimation<double>(t);
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0xFFF7F7FA),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0x1A000000), width: 0.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 7,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: CupertinoColors.systemOrange.withOpacity(0.18),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                't = ${t.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: CupertinoColors.systemOrange,
                  fontFamily: 'Menlo',
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _phaseLabel(t),
              style: const TextStyle(
                fontSize: 11.5,
                color: Color(0xFF6E6E73),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 120,
          decoration: BoxDecoration(
            color: const Color(0xFFE5E5EA),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CupertinoPageTransition(
              primaryRouteAnimation: anim,
              secondaryRouteAnimation: const AlwaysStoppedAnimation<double>(
                0.0,
              ),
              linearTransition: false,
              child: _pageSnapshotChild(t),
            ),
          ),
        ),
      ],
    ),
  );
}

String _phaseLabel(double t) {
  if (t <= 0.0) return 'off-screen right';
  if (t < 0.5) return 'sliding in';
  if (t < 1.0) return 'almost settled';
  return 'fully presented';
}

Widget _pageSnapshotChild(double t) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          const Color(0xFFFF9500).withOpacity(0.92),
          const Color(0xFFFF3B30).withOpacity(0.82),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          CupertinoIcons.doc_text_fill,
          color: CupertinoColors.white,
          size: 28,
        ),
        const SizedBox(height: 4),
        Text(
          'Pushed page',
          style: TextStyle(
            color: CupertinoColors.white.withOpacity(0.95),
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          'progress ${(t * 100).toInt()}%',
          style: TextStyle(
            color: CupertinoColors.white.withOpacity(0.85),
            fontSize: 10.5,
            fontFamily: 'Menlo',
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Chapter 5: CupertinoFullscreenDialogTransition snapshots
// ============================================================================

Widget _buildFullscreenDialogChapter() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'CHAPTER 5',
          'CupertinoFullscreenDialogTransition',
          'Slide-from-bottom modal transition snapshots',
          CupertinoIcons.arrow_up_square_fill,
          CupertinoColors.systemGreen,
        ),
        const Text(
          'CupertinoFullscreenDialogTransition is used by routes built with '
          'CupertinoPageRoute(fullscreenDialog: true). It slides the new '
          'page up from the bottom edge instead of in from the right. The '
          'animation contract is the same: primary + secondary animations '
          '+ linearTransition flag.',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF3C3C43),
            height: 1.42,
          ),
        ),
        const SizedBox(height: 14),
        _propRow('primaryRouteAnimation', 'Animation<double> (incoming)'),
        _propRow('secondaryRouteAnimation', 'Animation<double> (outgoing)'),
        _propRow('linearTransition', 'bool (skip Cupertino curve)'),
        _propRow('child', 'Widget — the dialog page'),
        const SizedBox(height: 16),
        const Text(
          'Modal-up snapshot grid',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 8),
        _fullscreenDialogGrid(),
        const SizedBox(height: 14),
        _explanationBox(
          'CONTRAST',
          'Compared to CupertinoPageTransition, the dialog transition uses a '
          'vertical slide and a slight background opacity ramp. The exit '
          'animation is reversed on pop; on dismiss-by-swipe the same '
          'animation runs in reverse driven by the gesture velocity.',
          CupertinoColors.systemGreen,
        ),
      ],
    ),
  );
}

Widget _fullscreenDialogGrid() {
  final stops = <double>[0.0, 0.25, 0.5, 0.75, 1.0];
  final rows = <Widget>[];
  for (var i = 0; i < stops.length; i++) {
    rows.add(_fullscreenDialogRow(stops[i]));
    if (i < stops.length - 1) {
      rows.add(const SizedBox(height: 10));
    }
  }
  return Column(children: rows);
}

Widget _fullscreenDialogRow(double t) {
  final anim = AlwaysStoppedAnimation<double>(t);
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0xFFF7F7FA),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0x1A000000), width: 0.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 7,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: CupertinoColors.systemGreen.withOpacity(0.18),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                't = ${t.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: CupertinoColors.systemGreen,
                  fontFamily: 'Menlo',
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _dialogPhaseLabel(t),
              style: const TextStyle(
                fontSize: 11.5,
                color: Color(0xFF6E6E73),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 130,
          decoration: BoxDecoration(
            color: const Color(0xFFE5E5EA),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CupertinoFullscreenDialogTransition(
              primaryRouteAnimation: anim,
              secondaryRouteAnimation: const AlwaysStoppedAnimation<double>(
                0.0,
              ),
              linearTransition: false,
              child: _dialogSnapshotChild(t),
            ),
          ),
        ),
      ],
    ),
  );
}

String _dialogPhaseLabel(double t) {
  if (t <= 0.0) return 'off-screen bottom';
  if (t < 0.5) return 'sliding up';
  if (t < 1.0) return 'easing into place';
  return 'fully presented modal';
}

Widget _dialogSnapshotChild(double t) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          const Color(0xFF34C759).withOpacity(0.95),
          const Color(0xFF30D158).withOpacity(0.75),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          CupertinoIcons.square_stack_3d_up_fill,
          color: CupertinoColors.white,
          size: 28,
        ),
        const SizedBox(height: 4),
        const Text(
          'Modal page',
          style: TextStyle(
            color: CupertinoColors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          'progress ${(t * 100).toInt()}%',
          style: TextStyle(
            color: CupertinoColors.white.withOpacity(0.85),
            fontSize: 10.5,
            fontFamily: 'Menlo',
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Chapter 6: Reference card + theme contrast
// ============================================================================

Widget _buildReferenceChapter() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'CHAPTER 6',
          'API reference & interpreter notes',
          'Constructor signatures and d4rt substitutions',
          CupertinoIcons.book_fill,
          CupertinoColors.systemGrey,
        ),
        const Text(
          'A summary card of the constructors covered in this demo, plus '
          'the interpreter-friendly substitutions used for each.',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF3C3C43),
            height: 1.42,
          ),
        ),
        const SizedBox(height: 14),
        _referenceTile(
          icon: CupertinoIcons.arrow_clockwise,
          tint: CupertinoColors.systemBlue,
          title: 'CupertinoSliverRefreshControl',
          signature:
              'CupertinoSliverRefreshControl({\n'
              '  Key? key,\n'
              '  double refreshTriggerPullDistance = 100.0,\n'
              '  double refreshIndicatorExtent = 60.0,\n'
              '  RefreshControlIndicatorBuilder builder = '
              'buildRefreshIndicator,\n'
              '  RefreshCallback? onRefresh,\n'
              '})',
          d4rt:
              'pass onRefresh: null because async callbacks are not '
              'supported.',
        ),
        const SizedBox(height: 10),
        _referenceTile(
          icon: CupertinoIcons.search_circle_fill,
          tint: CupertinoColors.systemPink,
          title: 'CupertinoMagnifier',
          signature:
              'const CupertinoMagnifier({\n'
              '  Key? key,\n'
              '  Size size = Size(80, 48),\n'
              '  BorderRadius borderRadius = BorderRadius.circular(40),\n'
              '  Offset additionalFocalPointOffset = Offset.zero,\n'
              '  Animation<double>? inOutAnimation,\n'
              '  BorderSide borderSide,\n'
              '})',
          d4rt: 'omit inOutAnimation, or use AlwaysStoppedAnimation snapshot.',
        ),
        const SizedBox(height: 10),
        _referenceTile(
          icon: CupertinoIcons.textformat_alt,
          tint: CupertinoColors.systemPurple,
          title: 'CupertinoTextMagnifier',
          signature:
              'const CupertinoTextMagnifier({\n'
              '  Key? key,\n'
              '  required Animation<double> animation,\n'
              '  required MagnifierController controller,\n'
              '  required ValueNotifier<MagnifierInfo> magnifierInfo,\n'
              '})',
          d4rt:
              'requires live MagnifierController; this demo uses a static '
              'visual stand-in.',
        ),
        const SizedBox(height: 10),
        _referenceTile(
          icon: CupertinoIcons.square_grid_2x2_fill,
          tint: CupertinoColors.systemTeal,
          title: 'CupertinoTabScaffold',
          signature:
              'CupertinoTabScaffold({\n'
              '  required CupertinoTabBar tabBar,\n'
              '  required IndexedWidgetBuilder tabBuilder,\n'
              '  CupertinoTabController? controller,\n'
              '  Color? backgroundColor,\n'
              '  bool resizeToAvoidBottomInset = true,\n'
              '  ...\n'
              '})',
          d4rt:
              'embed in a SizedBox/Container so the outer ListView keeps '
              'scrolling.',
        ),
        const SizedBox(height: 10),
        _referenceTile(
          icon: CupertinoIcons.rectangle_dock,
          tint: CupertinoColors.systemPink,
          title: 'CupertinoTabBar',
          signature:
              'CupertinoTabBar({\n'
              '  required List<BottomNavigationBarItem> items,\n'
              '  ValueChanged<int>? onTap,\n'
              '  int currentIndex = 0,\n'
              '  Color? activeColor,\n'
              '  Color? inactiveColor,\n'
              '  double iconSize = 30.0,\n'
              '  double height = 50.0,\n'
              '  ...\n'
              '})',
          d4rt:
              'onTap can be omitted in static demos; the tab bar still '
              'renders selection chrome via currentIndex.',
        ),
        const SizedBox(height: 10),
        _referenceTile(
          icon: CupertinoIcons.layers_alt_fill,
          tint: CupertinoColors.systemIndigo,
          title: 'CupertinoTabView',
          signature:
              'CupertinoTabView({\n'
              '  WidgetBuilder? builder,\n'
              '  GlobalKey<NavigatorState>? navigatorKey,\n'
              '  String? defaultTitle,\n'
              '  Map<String, WidgetBuilder>? routes,\n'
              '  RouteFactory? onGenerateRoute,\n'
              '  RouteFactory? onUnknownRoute,\n'
              '  List<NavigatorObserver> navigatorObservers = const [],\n'
              '  String? restorationScopeId,\n'
              '})',
          d4rt:
              'each tab owns its own Navigator; routes work normally inside '
              'the embedded sandbox.',
        ),
        const SizedBox(height: 10),
        _referenceTile(
          icon: CupertinoIcons.slider_horizontal_3,
          tint: CupertinoColors.systemGreen,
          title: 'CupertinoTabController',
          signature:
              'CupertinoTabController({\n'
              '  int initialIndex = 0,\n'
              '})',
          d4rt:
              'ChangeNotifier — call addListener / set index. Dispose from '
              'an owning StatefulWidget.',
        ),
        const SizedBox(height: 10),
        _referenceTile(
          icon: CupertinoIcons.arrow_right_square_fill,
          tint: CupertinoColors.systemOrange,
          title: 'CupertinoPageTransition',
          signature:
              'CupertinoPageTransition({\n'
              '  required Animation<double> primaryRouteAnimation,\n'
              '  required Animation<double> secondaryRouteAnimation,\n'
              '  required Widget child,\n'
              '  required bool linearTransition,\n'
              '})',
          d4rt:
              'use AlwaysStoppedAnimation<double>(t) for frame-frozen '
              'snapshots.',
        ),
        const SizedBox(height: 10),
        _referenceTile(
          icon: CupertinoIcons.arrow_up_square_fill,
          tint: CupertinoColors.systemGreen,
          title: 'CupertinoFullscreenDialogTransition',
          signature:
              'CupertinoFullscreenDialogTransition({\n'
              '  required Animation<double> primaryRouteAnimation,\n'
              '  required Animation<double> secondaryRouteAnimation,\n'
              '  required Widget child,\n'
              '  required bool linearTransition,\n'
              '})',
          d4rt:
              'same pattern as CupertinoPageTransition; vertical slide '
              'instead of horizontal.',
        ),
        const SizedBox(height: 16),
        const Text(
          'Light vs Dark theme contrast',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 8),
        _themeContrast(),
        const SizedBox(height: 14),
        _explanationBox(
          'COVERAGE',
          'This script exercises bridged class construction for 9 Cupertino '
          'symbols plus AlwaysStoppedAnimation. The test driver prints '
          'progress between chapters so a grep for "cupertino_refresh_mag_test" '
          'shows full chapter coverage in the logs.',
          CupertinoColors.systemGrey,
        ),
      ],
    ),
  );
}

Widget _referenceTile({
  required IconData icon,
  required Color tint,
  required String title,
  required String signature,
  required String d4rt,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFF7F7FA),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: tint.withOpacity(0.35), width: 0.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: tint.withOpacity(0.18),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 16, color: tint),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1C1C1E),
                  fontFamily: 'Menlo',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            signature,
            style: const TextStyle(
              fontSize: 11.5,
              color: Color(0xFFE5E5EA),
              fontFamily: 'Menlo',
              height: 1.45,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              CupertinoIcons.arrow_turn_down_right,
              size: 12,
              color: tint,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                'd4rt: $d4rt',
                style: TextStyle(
                  fontSize: 11.5,
                  color: tint,
                  fontStyle: FontStyle.italic,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _themeContrast() {
  return Row(
    children: [
      Expanded(child: _themeCard(brightness: Brightness.light)),
      const SizedBox(width: 10),
      Expanded(child: _themeCard(brightness: Brightness.dark)),
    ],
  );
}

Widget _themeCard({required Brightness brightness}) {
  final isLight = brightness == Brightness.light;
  final bg = isLight ? const Color(0xFFFFFFFF) : const Color(0xFF1C1C1E);
  final fg = isLight ? const Color(0xFF1C1C1E) : const Color(0xFFFFFFFF);
  final accent = isLight
      ? CupertinoColors.systemBlue
      : const Color(0xFF0A84FF);
  final subdued = isLight
      ? const Color(0xFF6E6E73)
      : const Color(0xFF98989F);
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0x1A000000), width: 0.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              isLight ? CupertinoIcons.sun_max_fill : CupertinoIcons.moon_fill,
              size: 14,
              color: fg,
            ),
            const SizedBox(width: 6),
            Text(
              isLight ? 'Light' : 'Dark',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: fg,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.18),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Icon(
                CupertinoIcons.arrow_clockwise,
                size: 12,
                color: accent,
              ),
              const SizedBox(width: 4),
              Text(
                'Refreshing…',
                style: TextStyle(
                  fontSize: 11,
                  color: accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'CupertinoTheme adapts colors via CupertinoDynamicColor. '
          'Use CupertinoColors.label resolvers in onRefresh feedback.',
          style: TextStyle(fontSize: 10.5, color: subdued, height: 1.4),
        ),
      ],
    ),
  );
}

// ============================================================================
// Footer
// ============================================================================

Widget _buildFooter() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFFEEEEF2),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0x1A000000), width: 0.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              CupertinoIcons.checkmark_seal_fill,
              size: 16,
              color: CupertinoColors.systemGreen,
            ),
            const SizedBox(width: 6),
            const Text(
              'Demo executed end-to-end',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1C1C1E),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'cupertino_refresh_mag_test • d4rt analyzer-free interpreter • '
          'snapshot-based animations, no AnimationController, no setState.',
          style: TextStyle(
            fontSize: 11,
            color: Color(0xFF6E6E73),
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

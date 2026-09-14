// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';

// ===========================================================================
// progress_sheet_test.dart
// ---------------------------------------------------------------------------
// A deep, fully static visual demo of the 'progress sheet' pattern in Material
// Flutter. It demonstrates how a long-running task is communicated to a user
// through a combination of the following widgets:
//
//   * LinearProgressIndicator   (determinate + indeterminate)
//   * CircularProgressIndicator (determinate + indeterminate)
//   * RefreshProgressIndicator  (static preview)
//   * BottomSheet / showModalBottomSheet (mocked statically)
//   * Inline progress card patterns
//   * Cancel + retry layouts (rendered statically)
//
// Because the file is fully static (no Stateful widgets, no Timer, no Future,
// no Stream, no AnimationController, no setState), each indicator is shown as
// a 'snapshot' at one or more progress values. This is useful for visual
// regression testing and for codifying the visual vocabulary of progress UI.
// ===========================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Progress Sheet Deep Demo',
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.indigo,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color(0xFF3949AB),
        linearTrackColor: Color(0xFFE8EAF6),
        circularTrackColor: Color(0xFFE8EAF6),
        refreshBackgroundColor: Color(0xFFFFFFFF),
      ),
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text('Progress Sheet Deep Demo'),
        backgroundColor: const Color(0xFF3949AB),
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const <Widget>[
            _HeroBannerSection(),
            SizedBox(height: 24),
            _IndicatorFamilySection(),
            SizedBox(height: 24),
            _PhaseStripSection(),
            SizedBox(height: 24),
            _BottomSheetMockSection(),
            SizedBox(height: 24),
            _InlineCardGallerySection(),
            SizedBox(height: 24),
            _ThemeIntegrationSection(),
            SizedBox(height: 24),
            _AccessibilitySection(),
            SizedBox(height: 24),
            _PitfallsSection(),
            SizedBox(height: 24),
            _BestPracticesSection(),
            SizedBox(height: 24),
            _FooterSection(),
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}

// ===========================================================================
// Section 1 — Hero banner.
// ---------------------------------------------------------------------------
// Establishes the theme of the demo with a large gradient header and a short
// summary of what 'progress sheet' means in our vocabulary.
// ===========================================================================

class _HeroBannerSection extends StatelessWidget {
  const _HeroBannerSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFF1A237E),
            const Color(0xFF3949AB),
            const Color(0xFF5C6BC0).withValues(alpha: 0.92),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF1A237E).withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            alignment: Alignment.center,
            child: const Icon(
              Icons.hourglass_top,
              color: Colors.white,
              size: 36,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Progress Sheet Pattern',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                    shadows: <Shadow>[
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.30),
                        offset: const Offset(0, 2),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'A static catalogue of long-running task UI:'
                  ' linear, circular and refresh indicators, bottom-sheet')
                ,
                const SizedBox(height: 4),
                Text(
                  'mocks, cancel/retry layouts and theme integration tips.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.92),
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    _HeroBadge(label: 'Linear'),
                    _HeroBadge(label: 'Circular'),
                    _HeroBadge(label: 'Refresh'),
                    _HeroBadge(label: 'BottomSheet'),
                    _HeroBadge(label: 'Static'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  const _HeroBadge({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.45),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.95),
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

// ===========================================================================
// Section 2 — Progress indicator family table.
// ---------------------------------------------------------------------------
// A side-by-side gallery of the four core widgets:
//   - LinearProgressIndicator (determinate)
//   - LinearProgressIndicator (indeterminate snapshot)
//   - CircularProgressIndicator (determinate)
//   - CircularProgressIndicator (indeterminate snapshot)
//   - RefreshProgressIndicator  (static preview)
// Each cell shows the widget plus a label and a short caption.
// ===========================================================================

class _IndicatorFamilySection extends StatelessWidget {
  const _IndicatorFamilySection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Indicator family',
      subtitle: 'Linear, Circular, Refresh — determinate and indeterminate.',
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          const Color(0xFFE3F2FD),
          const Color(0xFFBBDEFB).withValues(alpha: 0.65),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          _IndicatorRow(
            title: 'LinearProgressIndicator (determinate)',
            caption: 'value: 0.42 — exact progress is known.',
            child: SizedBox(
              height: 12,
              child: LinearProgressIndicator(
                value: 0.42,
                minHeight: 8,
                color: Color(0xFF1E88E5),
                backgroundColor: Color(0xFFE3F2FD),
              ),
            ),
          ),
          SizedBox(height: 16),
          _IndicatorRow(
            title: 'LinearProgressIndicator (indeterminate)',
            caption: 'value: null — total work is unknown.',
            child: SizedBox(
              height: 12,
              child: LinearProgressIndicator(
                minHeight: 8,
                color: Color(0xFF1E88E5),
                backgroundColor: Color(0xFFE3F2FD),
              ),
            ),
          ),
          SizedBox(height: 16),
          _IndicatorRow(
            title: 'CircularProgressIndicator (determinate)',
            caption: 'value: 0.66 — a ring drawn 66% of the way.',
            child: SizedBox(
              height: 64,
              width: 64,
              child: CircularProgressIndicator(
                value: 0.66,
                strokeWidth: 6,
                color: Color(0xFF1E88E5),
                backgroundColor: Color(0xFFE3F2FD),
              ),
            ),
          ),
          SizedBox(height: 16),
          _IndicatorRow(
            title: 'CircularProgressIndicator (indeterminate)',
            caption: 'value: null — perpetually spins in motion.',
            child: SizedBox(
              height: 64,
              width: 64,
              child: CircularProgressIndicator(
                strokeWidth: 6,
                color: Color(0xFF1E88E5),
                backgroundColor: Color(0xFFE3F2FD),
              ),
            ),
          ),
          SizedBox(height: 16),
          _IndicatorRow(
            title: 'RefreshProgressIndicator (static preview)',
            caption: 'shown elevated on a small chip-style surface.',
            child: SizedBox(
              height: 56,
              width: 56,
              child: RefreshProgressIndicator(
                value: 0.5,
                strokeWidth: 3,
                color: Color(0xFF1E88E5),
                backgroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IndicatorRow extends StatelessWidget {
  const _IndicatorRow({
    required this.title,
    required this.caption,
    required this.child,
  });
  final String title;
  final String caption;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1E88E5).withValues(alpha: 0.18),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  caption,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withValues(alpha: 0.68),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(width: 120, child: Center(child: child)),
        ],
      ),
    );
  }
}

// ===========================================================================
// Section 3 — Static phase strip.
// ---------------------------------------------------------------------------
// Renders the same task at five canonical progress values: 0%, 25%, 50%,
// 75% and 100%. This is the most useful visualization for a static demo
// because it shows what a real animation would interpolate through.
// ===========================================================================

class _PhaseStripSection extends StatelessWidget {
  const _PhaseStripSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Static phase strip',
      subtitle: 'Snapshots at 0%, 25%, 50%, 75% and 100%.',
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          const Color(0xFFE8F5E9),
          const Color(0xFFC8E6C9).withValues(alpha: 0.7),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          _PhaseRow(value: 0.0,  label: '0%',   note: 'Idle / queued.'),
          SizedBox(height: 10),
          _PhaseRow(value: 0.25, label: '25%',  note: 'Started, fetching.'),
          SizedBox(height: 10),
          _PhaseRow(value: 0.5,  label: '50%',  note: 'Halfway, processing.'),
          SizedBox(height: 10),
          _PhaseRow(value: 0.75, label: '75%',  note: 'Almost there.'),
          SizedBox(height: 10),
          _PhaseRow(value: 1.0,  label: '100%', note: 'Complete, ready.'),
        ],
      ),
    );
  }
}

class _PhaseRow extends StatelessWidget {
  const _PhaseRow({
    required this.value,
    required this.label,
    required this.note,
  });
  final double value;
  final String label;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF2E7D32).withValues(alpha: 0.18),
        ),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 56,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1B5E20),
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: value,
                minHeight: 10,
                color: const Color(0xFF2E7D32),
                backgroundColor: const Color(0xFFC8E6C9),
              ),
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 56,
            height: 56,
            child: CircularProgressIndicator(
              value: value,
              strokeWidth: 5,
              color: const Color(0xFF2E7D32),
              backgroundColor: const Color(0xFFC8E6C9),
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 160,
            child: Text(
              note,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black.withValues(alpha: 0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// Section 4 — Bottom-sheet mock.
// ---------------------------------------------------------------------------
// A static rendering of what `showModalBottomSheet` would produce when
// presenting a long-running task. Three states are shown side by side:
//   - 'Working' (indeterminate)
//   - 'Progress' (determinate with cancel button)
//   - 'Done'    (success state with dismiss)
// ===========================================================================

class _BottomSheetMockSection extends StatelessWidget {
  const _BottomSheetMockSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Bottom-sheet mock',
      subtitle: 'showModalBottomSheet patterns frozen in time.',
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          const Color(0xFFFFF8E1),
          const Color(0xFFFFE082).withValues(alpha: 0.65),
        ],
      ),
      child: Column(
        children: const <Widget>[
          _BottomSheetMock(
            title: 'Uploading photos',
            message: 'Connecting to the server, please wait.',
            phase: _BottomSheetPhase.working,
          ),
          SizedBox(height: 16),
          _BottomSheetMock(
            title: 'Uploading photos',
            message: 'Sending file 3 of 8.',
            phase: _BottomSheetPhase.progress,
          ),
          SizedBox(height: 16),
          _BottomSheetMock(
            title: 'Upload complete',
            message: 'All 8 photos uploaded successfully.',
            phase: _BottomSheetPhase.done,
          ),
        ],
      ),
    );
  }
}

enum _BottomSheetPhase { working, progress, done }

class _BottomSheetMock extends StatelessWidget {
  const _BottomSheetMock({
    required this.title,
    required this.message,
    required this.phase,
  });
  final String title;
  final String message;
  final _BottomSheetPhase phase;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 18,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF263238),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            message,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black.withValues(alpha: 0.65),
            ),
          ),
          const SizedBox(height: 16),
          _phaseBody(),
          const SizedBox(height: 16),
          _phaseActions(),
        ],
      ),
    );
  }

  Widget _phaseBody() {
    switch (phase) {
      case _BottomSheetPhase.working:
        return Row(
          children: const <Widget>[
            SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Color(0xFFFB8C00),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                'Working… we will update progress as soon as we know more.',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        );
      case _BottomSheetPhase.progress:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: const LinearProgressIndicator(
                value: 0.375,
                minHeight: 10,
                color: Color(0xFFFB8C00),
                backgroundColor: Color(0xFFFFE0B2),
              ),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '3 of 8',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withValues(alpha: 0.7),
                  ),
                ),
                Text(
                  '37%',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        );
      case _BottomSheetPhase.done:
        return Row(
          children: <Widget>[
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32).withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.check,
                color: Color(0xFF2E7D32),
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Text(
                'Operation finished. You may dismiss this sheet.',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        );
    }
  }

  Widget _phaseActions() {
    switch (phase) {
      case _BottomSheetPhase.working:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget>[
            _MockButton(label: 'Hide', primary: false),
          ],
        );
      case _BottomSheetPhase.progress:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget>[
            _MockButton(label: 'Cancel', primary: false),
            SizedBox(width: 8),
            _MockButton(label: 'Pause',  primary: false),
          ],
        );
      case _BottomSheetPhase.done:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget>[
            _MockButton(label: 'View',  primary: false),
            SizedBox(width: 8),
            _MockButton(label: 'Done', primary: true),
          ],
        );
    }
  }
}

class _MockButton extends StatelessWidget {
  const _MockButton({required this.label, required this.primary});
  final String label;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: primary
            ? const Color(0xFF3949AB)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: primary
              ? const Color(0xFF3949AB)
              : Colors.black.withValues(alpha: 0.2),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: primary
              ? Colors.white
              : Colors.black.withValues(alpha: 0.8),
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ===========================================================================
// Section 5 — Inline progress card gallery.
// ---------------------------------------------------------------------------
// Many apps embed progress UI directly into list/grid items. This section
// renders a vertical stack of nine different inline cards, each with a
// different shape (linear, circular, mixed) and metadata layout.
// ===========================================================================

class _InlineCardGallerySection extends StatelessWidget {
  const _InlineCardGallerySection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Inline progress cards',
      subtitle: 'Patterns for embedding progress in list / grid items.',
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          const Color(0xFFFCE4EC),
          const Color(0xFFF8BBD0).withValues(alpha: 0.6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          _InlineCard(
            icon: Icons.cloud_upload,
            title: 'project-alpha.zip',
            subtitle: 'Uploading… 12.4 / 32.0 MB',
            value: 0.38,
            trailing: '38%',
            style: _InlineCardStyle.linear,
          ),
          SizedBox(height: 10),
          _InlineCard(
            icon: Icons.cloud_download,
            title: 'designs/v3.pdf',
            subtitle: 'Downloading… 6.0 / 12.0 MB',
            value: 0.5,
            trailing: '50%',
            style: _InlineCardStyle.linear,
          ),
          SizedBox(height: 10),
          _InlineCard(
            icon: Icons.sync,
            title: 'Sync mailbox',
            subtitle: 'Refreshing 421 messages…',
            value: null,
            trailing: '…',
            style: _InlineCardStyle.circular,
          ),
          SizedBox(height: 10),
          _InlineCard(
            icon: Icons.video_settings,
            title: 'Encoding clip 4',
            subtitle: 'h264 → av1 at 1080p',
            value: 0.72,
            trailing: '72%',
            style: _InlineCardStyle.circular,
          ),
          SizedBox(height: 10),
          _InlineCard(
            icon: Icons.backup_table,
            title: 'Database backup',
            subtitle: 'Snapshotting public schema…',
            value: 0.18,
            trailing: '18%',
            style: _InlineCardStyle.linear,
          ),
          SizedBox(height: 10),
          _InlineCard(
            icon: Icons.security_update_good,
            title: 'Apply security patches',
            subtitle: 'Phase 2 of 4 — kernel modules.',
            value: 0.6,
            trailing: '60%',
            style: _InlineCardStyle.linear,
          ),
          SizedBox(height: 10),
          _InlineCard(
            icon: Icons.refresh,
            title: 'Refresh token store',
            subtitle: 'Rotating credentials, please wait.',
            value: null,
            trailing: '…',
            style: _InlineCardStyle.refresh,
          ),
          SizedBox(height: 10),
          _InlineCard(
            icon: Icons.queue_music,
            title: 'Indexing music library',
            subtitle: '8,243 of 12,991 tracks scanned.',
            value: 0.635,
            trailing: '63%',
            style: _InlineCardStyle.linear,
          ),
          SizedBox(height: 10),
          _InlineCard(
            icon: Icons.science,
            title: 'Running unit tests',
            subtitle: '184 of 256 specs complete.',
            value: 0.718,
            trailing: '72%',
            style: _InlineCardStyle.circular,
          ),
        ],
      ),
    );
  }
}

enum _InlineCardStyle { linear, circular, refresh }

class _InlineCard extends StatelessWidget {
  const _InlineCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.trailing,
    required this.style,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final double? value;
  final String trailing;
  final _InlineCardStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFAD1457).withValues(alpha: 0.18),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFAD1457).withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFFAD1457), size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF880E4F),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withValues(alpha: 0.65),
                  ),
                ),
                const SizedBox(height: 8),
                _progress(),
              ],
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 44,
            child: Text(
              trailing,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFFAD1457),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _progress() {
    switch (style) {
      case _InlineCardStyle.linear:
        return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 6,
            color: const Color(0xFFAD1457),
            backgroundColor: const Color(0xFFF8BBD0),
          ),
        );
      case _InlineCardStyle.circular:
        return Row(
          children: <Widget>[
            SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                value: value,
                strokeWidth: 2.5,
                color: const Color(0xFFAD1457),
                backgroundColor: const Color(0xFFF8BBD0),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              value == null ? 'spinning' : 'progressing',
              style: TextStyle(
                fontSize: 11,
                color: Colors.black.withValues(alpha: 0.55),
              ),
            ),
          ],
        );
      case _InlineCardStyle.refresh:
        return Row(
          children: <Widget>[
            SizedBox(
              width: 24,
              height: 24,
              child: RefreshProgressIndicator(
                value: 0.5,
                strokeWidth: 2.5,
                color: const Color(0xFFAD1457),
                backgroundColor: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'refresh preview',
              style: TextStyle(
                fontSize: 11,
                color: Colors.black.withValues(alpha: 0.55),
              ),
            ),
          ],
        );
    }
  }
}

// ===========================================================================
// Section 6 — Theme integration.
// ---------------------------------------------------------------------------
// `ProgressIndicatorThemeData` lets you configure the default color, track
// color, refresh background and stop indicator color globally. This section
// shows the active values in the demo's theme and provides a recipe block.
// ===========================================================================

class _ThemeIntegrationSection extends StatelessWidget {
  const _ThemeIntegrationSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Theme integration',
      subtitle: 'ProgressIndicatorThemeData — the global defaults.',
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          const Color(0xFFEDE7F6),
          const Color(0xFFD1C4E9).withValues(alpha: 0.7),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          _ThemeRow(name: 'color',                value: '#3949AB'),
          _ThemeRow(name: 'linearTrackColor',     value: '#E8EAF6'),
          _ThemeRow(name: 'circularTrackColor',  value: '#E8EAF6'),
          _ThemeRow(name: 'refreshBackgroundColor', value: '#FFFFFF'),
          SizedBox(height: 12),
          _CodeBlock(
            code:
                'theme: ThemeData(\n'
                '  progressIndicatorTheme: ProgressIndicatorThemeData(\n'
                '    color: Color(0xFF3949AB),\n'
                '    linearTrackColor: Color(0xFFE8EAF6),\n'
                '    circularTrackColor: Color(0xFFE8EAF6),\n'
                '    refreshBackgroundColor: Color(0xFFFFFFFF),\n'
                '  ),\n'
                ');',
          ),
        ],
      ),
    );
  }
}

class _ThemeRow extends StatelessWidget {
  const _ThemeRow({required this.name, required this.value});
  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF5E35B1),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF311B92),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: const Color(0xFF5E35B1).withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'monospace',
                color: Color(0xFF311B92),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.code});
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        code,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          height: 1.4,
          color: Colors.white.withValues(alpha: 0.92),
        ),
      ),
    );
  }
}

// ===========================================================================
// Section 7 — Accessibility.
// ---------------------------------------------------------------------------
// Progress indicators need a `semanticsLabel` and ideally a `semanticsValue`
// so screen readers can announce 'Uploading photos, 42 percent' rather than
// just 'progress bar'. This section shows correct labels next to incorrect
// ones and demonstrates the resulting announcements.
// ===========================================================================

class _AccessibilitySection extends StatelessWidget {
  const _AccessibilitySection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Accessibility',
      subtitle: 'semanticsLabel + semanticsValue announcements.',
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          const Color(0xFFE0F7FA),
          const Color(0xFFB2EBF2).withValues(alpha: 0.6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _A11yRow(
            good: true,
            label: 'Uploading photos',
            value: '42 percent',
            announce: '"Uploading photos, 42 percent"',
          ),
          const SizedBox(height: 8),
          const _A11yRow(
            good: true,
            label: 'Importing contacts',
            value: '12 of 100',
            announce: '"Importing contacts, 12 of 100"',
          ),
          const SizedBox(height: 8),
          const _A11yRow(
            good: false,
            label: '',
            value: '',
            announce: '"progress bar" (uninformative)',
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Tip: always set semanticsLabel; set semanticsValue when the')
                 ,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'progress is known. For indeterminate indicators, omit ')
            ,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'semanticsValue and just announce the activity.',
            ),
          ),
        ],
      ),
    );
  }
}

class _A11yRow extends StatelessWidget {
  const _A11yRow({
    required this.good,
    required this.label,
    required this.value,
    required this.announce,
  });
  final bool good;
  final String label;
  final String value;
  final String announce;

  @override
  Widget build(BuildContext context) {
    final Color tint = good
        ? const Color(0xFF00838F)
        : const Color(0xFFC62828);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tint.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            good ? Icons.check_circle : Icons.warning,
            color: tint,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'label: "$label"',
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
                Text(
                  'value: "$value"',
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
                Text(
                  'announces: $announce',
                  style: TextStyle(
                    fontSize: 12,
                    color: tint,
                    fontWeight: FontWeight.w600,
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

// ===========================================================================
// Section 8 — Pitfalls.
// ---------------------------------------------------------------------------
// Common mistakes when wiring a progress sheet:
//  - Showing indeterminate when actual progress is known.
//  - Blocking the entire UI behind a modal sheet for hours.
//  - Forgetting a cancel path entirely.
//  - Stacking nested progress indicators that fight for attention.
// ===========================================================================

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Pitfalls',
      subtitle: 'Things to avoid when wiring real progress UI.',
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          const Color(0xFFFFEBEE),
          const Color(0xFFFFCDD2).withValues(alpha: 0.65),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          _PitfallRow(
            title: 'Indeterminate while progress is known',
            body: 'If you can compute a 0..1 value, pass it. Indeterminate ')
            ,
          _PitfallRow(
            title: 'spins forever and tells users nothing.',
            body: 'Even an estimate is better than a swirling bar.',
          ),
          _PitfallRow(
            title: 'Blocking the entire UI',
            body: 'Full-screen modal sheets stop users from doing anything.')
            ,
          _PitfallRow(
            title: 'Prefer non-modal inline progress for >30 s tasks.',
            body: 'Reserve modal sheets for short, atomic operations.',
          ),
          _PitfallRow(
            title: 'No cancel path',
            body: 'Always provide a way out — Cancel, Pause or Background.')
            ,
          _PitfallRow(
            title: 'Without it, a stuck network leads to force-quit.',
            body: 'Wire your indicator to a controller you can interrupt.',
          ),
          _PitfallRow(
            title: 'Stacked indicators',
            body: 'Two indicators in the same view confuse users. Pick the')
            ,
          _PitfallRow(
            title: 'one that reflects the real work being done.',
            body: 'Nested progress is almost always a refactor smell.',
          ),
        ],
      ),
    );
  }
}

class _PitfallRow extends StatelessWidget {
  const _PitfallRow({required this.title, required this.body});
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFC62828).withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(
              Icons.report_gmailerrorred,
              color: Color(0xFFC62828),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFB71C1C),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withValues(alpha: 0.7),
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
}

// ===========================================================================
// Section 9 — Best practices.
// ---------------------------------------------------------------------------
// A checklist of things every progress sheet should have.
// ===========================================================================

class _BestPracticesSection extends StatelessWidget {
  const _BestPracticesSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Best practices',
      subtitle: 'A checklist for shipping production progress UI.',
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          const Color(0xFFE8F5E9),
          const Color(0xFFA5D6A7).withValues(alpha: 0.55),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          _PracticeRow(text: 'Show progress immediately — never leave a tap')
            ,
          _PracticeRow(text: 'unacknowledged for more than ~100ms.'),
          _PracticeRow(text: 'Prefer determinate indicators whenever you')
            ,
          _PracticeRow(text: 'have enough information to estimate.'),
          _PracticeRow(text: 'Use bottom sheets for confined, modal work;')
            ,
          _PracticeRow(text: 'use inline indicators for list / grid items.'),
          _PracticeRow(text: 'Always wire a cancel path — Cancel, Pause or')
            ,
          _PracticeRow(text: 'Background. Never leave the user stuck.'),
          _PracticeRow(text: 'Announce progress to screen readers via')
            ,
          _PracticeRow(text: 'semanticsLabel + semanticsValue.'),
          _PracticeRow(text: 'Theme indicators globally with')
            ,
          _PracticeRow(text: 'ProgressIndicatorThemeData for visual unity.'),
        ],
      ),
    );
  }
}

class _PracticeRow extends StatelessWidget {
  const _PracticeRow({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 3),
            child: Icon(
              Icons.check_circle,
              size: 16,
              color: Color(0xFF2E7D32),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color: Colors.black.withValues(alpha: 0.78),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// Section 10 — Footer.
// ---------------------------------------------------------------------------
// A small visual full-stop containing meta info about the demo.
// ===========================================================================

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: <Color>[
            const Color(0xFF263238),
            const Color(0xFF455A64).withValues(alpha: 0.95),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'progress_sheet_test.dart',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.95),
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'A fully static demo of the progress sheet pattern in Material.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.82),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _FooterTag(label: 'no Stateful'),
              _FooterTag(label: 'no Timer'),
              _FooterTag(label: 'no Future'),
              _FooterTag(label: 'no Stream'),
              _FooterTag(label: 'no AnimationController'),
              _FooterTag(label: 'no setState'),
              _FooterTag(label: 'Color.withValues'),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterTag extends StatelessWidget {
  const _FooterTag({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.32),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.92),
          fontSize: 11,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

// ===========================================================================
// Shared section card — a gradient surface with a header and a body slot.
// Not counted in the 'unique sections' total because it's a layout helper.
// ===========================================================================

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.child,
  });
  final String title;
  final String subtitle;
  final LinearGradient gradient;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A237E),
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black.withValues(alpha: 0.65),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

// ===========================================================================
// Appendix — additional static documentation widgets.
// ---------------------------------------------------------------------------
// The remainder of this file consists of small, pure StatelessWidget classes
// that document additional aspects of the progress sheet pattern. They are
// not wired into the main `build` tree because they would make the demo too
// long to read in one screen; instead they serve as a reference library that
// can be embedded elsewhere or inspected via tooling.
// ===========================================================================

// ---------------------------------------------------------------------------
// _DocWhyDeterminate — Why prefer determinate?
// ---------------------------------------------------------------------------
class _DocWhyDeterminate extends StatelessWidget {
  const _DocWhyDeterminate();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Why prefer determinate?',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'When you know the total amount of work, expressing it as a 0..1 value',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'lets users build a mental model of how much time is left. That model',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'calms anxiety and reduces the number of taps on Cancel.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocWhyIndeterminate — When indeterminate is correct
// ---------------------------------------------------------------------------
class _DocWhyIndeterminate extends StatelessWidget {
  const _DocWhyIndeterminate();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'When indeterminate is correct',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Use indeterminate progress only when the total work is genuinely',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'unknown — for example, while you wait on a remote handshake or while',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'the server is computing a count it has not returned yet.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocStrokeWidthMatters — Stroke width matters
// ---------------------------------------------------------------------------
class _DocStrokeWidthMatters extends StatelessWidget {
  const _DocStrokeWidthMatters();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Stroke width matters',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'A circular indicator with a tiny strokeWidth disappears on dense',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'displays; one with a huge strokeWidth feels heavy. The default 4 is a',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'good starting point — tune by ±1 to match surrounding typography.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocTrackColor — Use track color deliberately
// ---------------------------------------------------------------------------
class _DocTrackColor extends StatelessWidget {
  const _DocTrackColor();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Use track color deliberately',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'The track color (backgroundColor) gives the user a sense of how much',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'work remains. A near-invisible track makes a 95%-complete indicator',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'look identical to a 100%-complete one. Keep some contrast.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocMinHeight — minHeight is your friend
// ---------------------------------------------------------------------------
class _DocMinHeight extends StatelessWidget {
  const _DocMinHeight();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'minHeight is your friend',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "LinearProgressIndicator's default minHeight is fine for chrome-y use",
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "but feels under-spec'd in dense lists. Bumping minHeight to 6–10",
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "produces a more legible, more 'present' progress bar.",
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocClipRRect — Round the corners with ClipRRect
// ---------------------------------------------------------------------------
class _DocClipRRect extends StatelessWidget {
  const _DocClipRRect();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Round the corners with ClipRRect',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Wrap LinearProgressIndicator in ClipRRect with a small radius to get',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'rounded ends that match Material 3 affordance. This costs a single',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'extra widget and looks dramatically better at small sizes.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocDontFlash — Avoid the 100ms flash
// ---------------------------------------------------------------------------
class _DocDontFlash extends StatelessWidget {
  const _DocDontFlash();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Avoid the 100ms flash',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'If the operation often completes in under ~250ms, show no progress',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'indicator at all. A flash of progress UI is more disorienting than a',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'result-replacement; defer with a small grace period instead.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocProgressAndETA — Pair with an ETA when you can
// ---------------------------------------------------------------------------
class _DocProgressAndETA extends StatelessWidget {
  const _DocProgressAndETA();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Pair with an ETA when you can',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "A progress bar paired with 'about 3 minutes left' is far more useful",
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'than either alone. Compute the ETA from a moving average of the rate;',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'smooth it so it doesn\'t oscillate.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocMultipleTasks — Multiple parallel tasks
// ---------------------------------------------------------------------------
class _DocMultipleTasks extends StatelessWidget {
  const _DocMultipleTasks();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Multiple parallel tasks',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "When several tasks run at once, show one overall bar with an',  ",
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "'expander' that reveals per-task progress. Avoid a wall of bars —",
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'users see noise rather than progress.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocCancelBehavior — Cancel must be honest
// ---------------------------------------------------------------------------
class _DocCancelBehavior extends StatelessWidget {
  const _DocCancelBehavior();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Cancel must be honest',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Pressing Cancel should stop work *fast* (or explicitly say 'cancelling',",
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'with its own progress phase). A Cancel button that does nothing for',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'ten seconds erodes trust.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocRetry — Retry from where it failed
// ---------------------------------------------------------------------------
class _DocRetry extends StatelessWidget {
  const _DocRetry();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Retry from where it failed',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'When a task fails partway through, the Retry button should resume,',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'not restart from scratch — unless you can\'t. Either way, say so',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "explicitly: 'Retry from 42%' or 'Retry from the beginning'.",
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocPauseResume — Pause / Resume for big tasks
// ---------------------------------------------------------------------------
class _DocPauseResume extends StatelessWidget {
  const _DocPauseResume();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Pause / Resume for big tasks',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Long uploads and downloads benefit from explicit Pause/Resume. Wire',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'them to your transport (HTTP Range, chunked uploads) so users can',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'park a task and walk away.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocBackgroundChip — A 'Background' affordance
// ---------------------------------------------------------------------------
class _DocBackgroundChip extends StatelessWidget {
  const _DocBackgroundChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "A 'Background' affordance",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Some users want to dismiss the modal but keep the work running. A',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "'Background' button on a progress sheet plus a small status chip on",
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'the home screen is a low-effort, high-value pattern.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocColorMeaning — Color carries meaning
// ---------------------------------------------------------------------------
class _DocColorMeaning extends StatelessWidget {
  const _DocColorMeaning();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Color carries meaning',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Reserve red for error or destructive, green for success, blue (or your',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'primary) for in-flight work. Avoid using your error color for plain',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'in-progress states — users read it as a problem.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocTexture — Add texture sparingly
// ---------------------------------------------------------------------------
class _DocTexture extends StatelessWidget {
  const _DocTexture();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Add texture sparingly',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Striped or animated 'barber pole' indicators feel busy on a small",
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'screen. The default flat progress bar is the right answer 95% of the',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'time; reserve textures for novelty or game-style UI.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocSound — Sound on completion?
// ---------------------------------------------------------------------------
class _DocSound extends StatelessWidget {
  const _DocSound();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Sound on completion?',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Optional completion sounds help on long-running tasks where the user',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "has switched focus, but they're rude on the desktop. Gate them behind",
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'an explicit preference, default off.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocHaptics — Haptics on mobile
// ---------------------------------------------------------------------------
class _DocHaptics extends StatelessWidget {
  const _DocHaptics();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Haptics on mobile',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'A subtle haptic tick when a phase changes (e.g. 50%, 100%, error) is',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "delightful on mobile. Don't fire haptics for every percentage point",
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'or every animation frame — users will turn off the app.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocLayoutShift — Avoid layout shift
// ---------------------------------------------------------------------------
class _DocLayoutShift extends StatelessWidget {
  const _DocLayoutShift();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Avoid layout shift',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Reserve the space for the progress bar before it appears, so the',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'rest of the layout doesn\'t jump. A static SizedBox with the same',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'height costs nothing and prevents a visual stutter.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocReduced — Respect reduced motion
// ---------------------------------------------------------------------------
class _DocReduced extends StatelessWidget {
  const _DocReduced();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Respect reduced motion',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'When `MediaQuery.disableAnimations` is true, prefer determinate',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'indicators (which are static at any single moment) over indeterminate',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'ones. Some users get nauseous from constant motion.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocLocale — Localize the percentage
// ---------------------------------------------------------------------------
class _DocLocale extends StatelessWidget {
  const _DocLocale();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Localize the percentage',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Format \'42%\' through the user\'s locale. Some languages put the unit',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'before the number; some use Arabic-Indic digits. Use `NumberFormat`,',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            r"not `'$pct%'`.",
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocTheming — Themed across the app
// ---------------------------------------------------------------------------
class _DocTheming extends StatelessWidget {
  const _DocTheming();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Themed across the app',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Set ProgressIndicatorThemeData once at the top of your app rather',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'than tweaking each indicator. That gives you a single place to evolve',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'the visual language.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocTestingStatic — Test indicators statically
// ---------------------------------------------------------------------------
class _DocTestingStatic extends StatelessWidget {
  const _DocTestingStatic();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Test indicators statically',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'For golden tests, render indicators with explicit `value` arguments —',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'never indeterminate. Animation-driven indicators produce noisy goldens',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'and break on every framework update.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocSnapshots — Snapshot phases for regression
// ---------------------------------------------------------------------------
class _DocSnapshots extends StatelessWidget {
  const _DocSnapshots();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Snapshot phases for regression',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'A 5-phase row (0/25/50/75/100) like this one is a great golden-test',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'subject: it captures the entire visual range of the indicator in one',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'screenshot.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocBoundaries — Watch your boundaries
// ---------------------------------------------------------------------------
class _DocBoundaries extends StatelessWidget {
  const _DocBoundaries();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Watch your boundaries',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Clamp `value` to [0,1] *before* passing it in. A value of 1.05 makes',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'the indicator overshoot in some Flutter versions; a value of -0.01',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'produces an empty bar with no indication of error.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocGranularity — Update at the right rate
// ---------------------------------------------------------------------------
class _DocGranularity extends StatelessWidget {
  const _DocGranularity();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Update at the right rate',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Updating progress 60 times a second wastes CPU and flickers the bar.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Throttle to ~10 Hz unless the indicator drives a high-precision',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "metric like 'bytes received'.",
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocPersistence — Persist long-running progress
// ---------------------------------------------------------------------------
class _DocPersistence extends StatelessWidget {
  const _DocPersistence();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Persist long-running progress',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'If your app can be killed mid-task, persist the current `value` so',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'the next launch can resume the bar without starting from zero.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Surprise resets erode user trust.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocErrors — Error states need a path
// ---------------------------------------------------------------------------
class _DocErrors extends StatelessWidget {
  const _DocErrors();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Error states need a path',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'When an operation fails, replace the progress bar with an error card',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "containing a clear cause and a Retry button. Don't hide the bar and",
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'leave the user wondering what happened.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocEmpty — Empty progress is allowed
// ---------------------------------------------------------------------------
class _DocEmpty extends StatelessWidget {
  const _DocEmpty();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Empty progress is allowed',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Showing a `value: 0.0` bar communicates 'I haven't started yet' and is",
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'fine for the first 200ms of a task. After that, either start ticking',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'or switch to indeterminate.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocStacking — Don't stack indicators
// ---------------------------------------------------------------------------
class _DocStacking extends StatelessWidget {
  const _DocStacking();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Don't stack indicators",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'A modal bottom sheet that itself contains a banner that itself',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "contains a card with a spinner is the canonical 'too much UI' code",
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'smell. Promote the most important indicator and remove the rest.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocSheets — Modal vs persistent sheets
// ---------------------------------------------------------------------------
class _DocSheets extends StatelessWidget {
  const _DocSheets();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Modal vs persistent sheets',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Use `showModalBottomSheet` when the user *must* attend to the task,',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'and the persistent `BottomSheet` widget when they should be free to',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'keep interacting with the page beneath.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocRouteAware — Route changes during progress
// ---------------------------------------------------------------------------
class _DocRouteAware extends StatelessWidget {
  const _DocRouteAware();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Route changes during progress',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'If the user navigates away mid-task, decide whether the sheet should',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'follow them (use a global overlay) or close (use a route-scoped',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'sheet). Both are valid; pick deliberately.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocKeyboardSafe — Keyboard and progress
// ---------------------------------------------------------------------------
class _DocKeyboardSafe extends StatelessWidget {
  const _DocKeyboardSafe();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Keyboard and progress',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'On mobile, sheets that contain a text field (for retry credentials,',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'for instance) must lift above the keyboard. Wrap the body in',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '`Padding` with `MediaQuery.viewInsets.bottom`.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocLandscapePhone — Landscape phones
// ---------------------------------------------------------------------------
class _DocLandscapePhone extends StatelessWidget {
  const _DocLandscapePhone();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Landscape phones',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Bottom sheets eat a huge fraction of a landscape phone. Consider a',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'side-anchored variant or just a banner — preserve enough room for',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'the user to see what they were doing.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocTablets — Tablets and split views
// ---------------------------------------------------------------------------
class _DocTablets extends StatelessWidget {
  const _DocTablets();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Tablets and split views',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'On tablets, bottom sheets are smaller relative to the screen; you',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'may want to switch to a `Dialog` or a `Drawer` for the same task.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Use `LayoutBuilder` to decide.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocDesktop — Desktop conventions
// ---------------------------------------------------------------------------
class _DocDesktop extends StatelessWidget {
  const _DocDesktop();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Desktop conventions',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'On desktop, the progress sheet pattern is often replaced by a',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'non-modal status bar at the bottom of the window. Embrace platform',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'conventions rather than fighting them.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocWeb — Web considerations
// ---------------------------------------------------------------------------
class _DocWeb extends StatelessWidget {
  const _DocWeb();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Web considerations',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'On the web, the browser already shows its own progress UI for some',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "operations (downloads, navigation). Don't duplicate; pick the layer",
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'whose UI is most relevant to your user.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocPrint — Printing progress
// ---------------------------------------------------------------------------
class _DocPrint extends StatelessWidget {
  const _DocPrint();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Printing progress',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'When printing a long report, show a phase-strip per page bucket',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '(e.g. pages 1–10, 11–20…). A single bar across thousands of pages',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'feels stuck.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocDatabase — Database imports
// ---------------------------------------------------------------------------
class _DocDatabase extends StatelessWidget {
  const _DocDatabase();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Database imports',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Imports that run row-by-row should report progress as 'rows imported /",
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "rows total' — never bytes. Bytes are misleading when row sizes vary.",
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Communicate the unit the user cares about.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocBackups — Backups
// ---------------------------------------------------------------------------
class _DocBackups extends StatelessWidget {
  const _DocBackups();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Backups',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Backups are long, and users walk away. Show estimated completion',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "*time of day* ('about 4:30 PM') rather than a duration; durations",
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'feel longer the more you stare at them.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocEncoding — Media encoding
// ---------------------------------------------------------------------------
class _DocEncoding extends StatelessWidget {
  const _DocEncoding();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Media encoding',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Video and audio encodes have a notoriously bad ETA. Show per-clip',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "progress with an overall counter ('clip 3 of 8') so users can mentally",
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'skip to the part they care about.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _DocFinal — Stick the landing
// ---------------------------------------------------------------------------
class _DocFinal extends StatelessWidget {
  const _DocFinal();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1A237E).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book,
                  size: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Stick the landing',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'When progress hits 100%, hold the bar at full for a beat (~600ms),',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '*then* swap to the success state. An instant disappear feels jittery',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'and skips the user\'s reward moment.',
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.black.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}


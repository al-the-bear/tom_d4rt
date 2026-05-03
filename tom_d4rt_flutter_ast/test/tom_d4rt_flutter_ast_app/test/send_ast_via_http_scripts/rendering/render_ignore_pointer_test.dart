// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: IgnorePointer deep demo
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'IgnorePointer Deep Demo',
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF1E3A8A),
      scaffoldBackgroundColor: const Color(0xFFF1F5F9),
      fontFamily: 'Roboto',
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        elevation: 6,
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        title: const Text(
          'RenderIgnorePointer — silent hit-test bypass',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
        ),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.touch_app),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.block),
          ),
        ],
      ),
      body: const _DemoBody(),
    ),
  );
}

class _DemoBody extends StatelessWidget {
  const _DemoBody();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      children: const <Widget>[
        _HeroHeader(),
        SizedBox(height: 28),
        _SectionTitle(
          index: 1,
          icon: Icons.dashboard,
          title: 'Side-by-side button cards',
          subtitle: 'Three identical buttons under different IgnorePointer treatments.',
        ),
        SizedBox(height: 14),
        _ButtonCardsRow(),
        SizedBox(height: 32),
        _SectionTitle(
          index: 2,
          icon: Icons.compare_arrows,
          title: 'IgnorePointer vs AbsorbPointer',
          subtitle: 'IgnorePointer steps aside; AbsorbPointer catches and swallows.',
        ),
        SizedBox(height: 14),
        _CompareIgnoreAbsorb(),
        SizedBox(height: 32),
        _SectionTitle(
          index: 3,
          icon: Icons.layers,
          title: 'Layered overlay scenario',
          subtitle: 'A tinted overlay sits visually on top yet does not steal events.',
        ),
        SizedBox(height: 14),
        _LayeredOverlayDemo(),
        SizedBox(height: 32),
        _SectionTitle(
          index: 4,
          icon: Icons.edit_note,
          title: 'Form disabled-state mock',
          subtitle: 'Wrap a section in IgnorePointer + Opacity to imply "read only".',
        ),
        SizedBox(height: 14),
        _FormDisabledMock(),
        SizedBox(height: 32),
        _SectionTitle(
          index: 5,
          icon: Icons.accessibility_new,
          title: 'Semantics flag matrix',
          subtitle: 'Legacy ignoringSemantics vs the modern Semantics-driven approach.',
        ),
        SizedBox(height: 14),
        _SemanticsMatrix(),
        SizedBox(height: 32),
        _SectionTitle(
          index: 6,
          icon: Icons.account_tree,
          title: 'Hit-test flow diagram',
          subtitle: 'How a tap travels when RenderIgnorePointer says "skip me".',
        ),
        SizedBox(height: 14),
        _HitTestFlow(),
        SizedBox(height: 32),
        _SectionTitle(
          index: 7,
          icon: Icons.api,
          title: 'API parameter reference',
          subtitle: 'ignoring, ignoringSemantics, child — every constructor argument explained.',
        ),
        SizedBox(height: 14),
        _ApiReferenceGrid(),
        SizedBox(height: 32),
        _SectionTitle(
          index: 8,
          icon: Icons.lightbulb_outline,
          title: 'Common use-cases',
          subtitle: 'Real-world deployments of IgnorePointer in product UIs.',
        ),
        SizedBox(height: 14),
        _UseCaseList(),
        SizedBox(height: 32),
        _SectionTitle(
          index: 9,
          icon: Icons.warning_amber,
          title: 'Pitfalls + see-also',
          subtitle: 'Adjacent APIs and traps to avoid.',
        ),
        SizedBox(height: 14),
        _PitfallSection(),
        SizedBox(height: 32),
        _FooterCard(),
        SizedBox(height: 30),
      ],
    );
  }
}

// ============================================================================
// HERO HEADER
// ============================================================================

class _HeroHeader extends StatelessWidget {
  const _HeroHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF1E3A8A),
            Color(0xFF2563EB),
            Color(0xFF60A5FA),
          ],
          stops: <double>[0.0, 0.55, 1.0],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 24,
            offset: Offset(0, 14),
          ),
          BoxShadow(
            color: Color(0x22FFFFFF),
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.shield_moon, color: Colors.white, size: 38),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'IgnorePointer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              Icon(Icons.touch_app, color: Color(0xFFBFDBFE), size: 32),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'A render-tree node that silently bypasses hit testing for its subtree. '
            'Descendants still paint exactly as they would otherwise — only their '
            'pointer events are skipped, falling through to whichever sibling '
            'happens to live underneath at the same z-position.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.5,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: const <Widget>[
              _HeroChip(
                icon: Icons.visibility,
                label: 'Visually identical',
                color: Color(0xFFBBF7D0),
              ),
              SizedBox(width: 10),
              _HeroChip(
                icon: Icons.touch_app,
                label: 'Interaction skipped',
                color: Color(0xFFFECACA),
              ),
              SizedBox(width: 10),
              _HeroChip(
                icon: Icons.bolt,
                label: 'Zero overdraw',
                color: Color(0xFFFEF3C7),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0x22FFFFFF),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0x44FFFFFF)),
            ),
            child: Row(
              children: const <Widget>[
                Icon(Icons.info_outline, size: 18, color: Colors.white),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Compare with AbsorbPointer (which catches the hit and stops it) '
                    'and Visibility(maintainInteractivity: false) which structurally '
                    'rebuilds the subtree.',
                    style: TextStyle(color: Colors.white, fontSize: 12.5),
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

class _HeroChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _HeroChip({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0x33FFFFFF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.7)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION TITLE
// ============================================================================

class _SectionTitle extends StatelessWidget {
  final int index;
  final IconData icon;
  final String title;
  final String subtitle;

  const _SectionTitle({
    required this.index,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFF6366F1), Color(0xFF8B5CF6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x336366F1),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '$index',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(icon, color: const Color(0xFF1E293B), size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// SECTION 1: BUTTON CARDS ROW
// ============================================================================

class _ButtonCardsRow extends StatelessWidget {
  const _ButtonCardsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        Expanded(
          child: _ButtonCard(
            title: 'Plain button',
            badgeLabel: 'hits child',
            badgeColor: Color(0xFF16A34A),
            icon: Icons.check_circle,
            description: 'No IgnorePointer at all. Tap reaches the button as usual.',
            mode: _ButtonCardMode.plain,
          ),
        ),
        SizedBox(width: 14),
        Expanded(
          child: _ButtonCard(
            title: 'IgnorePointer\nignoring: true',
            badgeLabel: 'skips child',
            badgeColor: Color(0xFFDC2626),
            icon: Icons.block,
            description: 'Wrapped subtree is invisible to hit-testing.',
            mode: _ButtonCardMode.ignoring,
          ),
        ),
        SizedBox(width: 14),
        Expanded(
          child: _ButtonCard(
            title: 'IgnorePointer\nignoring: false',
            badgeLabel: 'hits child',
            badgeColor: Color(0xFF16A34A),
            icon: Icons.check_circle_outline,
            description: 'Wrapped but disabled — pointer events fall through normally.',
            mode: _ButtonCardMode.passthrough,
          ),
        ),
      ],
    );
  }
}

enum _ButtonCardMode { plain, ignoring, passthrough }

class _ButtonCard extends StatelessWidget {
  final String title;
  final String badgeLabel;
  final Color badgeColor;
  final IconData icon;
  final String description;
  final _ButtonCardMode mode;

  const _ButtonCard({
    required this.title,
    required this.badgeLabel,
    required this.badgeColor,
    required this.icon,
    required this.description,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    final bool faded = mode == _ButtonCardMode.ignoring;
    Widget button = ElevatedButton.icon(
      icon: const Icon(Icons.send),
      label: const Text('Submit'),
      onPressed: () => print('button tapped: $title'),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1E40AF),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    if (mode == _ButtonCardMode.ignoring) {
      button = Opacity(
        opacity: 0.55,
        child: IgnorePointer(
          ignoring: true,
          child: button,
        ),
      );
    } else if (mode == _ButtonCardMode.passthrough) {
      button = IgnorePointer(
        ignoring: false,
        child: button,
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: faded
              ? const <Color>[Color(0xFFFEE2E2), Color(0xFFFFF1F2)]
              : const <Color>[Color(0xFFDCFCE7), Color(0xFFF0FDF4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: faded
              ? const Color(0xFFFCA5A5)
              : const Color(0xFF86EFAC),
          width: 1.4,
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, size: 22, color: badgeColor),
              const SizedBox(width: 6),
              _Badge(label: badgeLabel, color: badgeColor),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Color(0xFF1E293B),
              height: 1.3,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF475569),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 14),
          Align(alignment: Alignment.centerLeft, child: button),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xCCFFFFFF),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  faded ? Icons.do_not_touch : Icons.touch_app,
                  size: 14,
                  color: badgeColor,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    faded ? 'Tap is silently dropped' : 'Tap reaches button',
                    style: TextStyle(
                      fontSize: 11,
                      color: badgeColor,
                      fontWeight: FontWeight.w600,
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

class _Badge extends StatelessWidget {
  final String label;
  final Color color;

  const _Badge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION 2: IGNORE vs ABSORB COMPARISON
// ============================================================================

class _CompareIgnoreAbsorb extends StatelessWidget {
  const _CompareIgnoreAbsorb();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: _CompareColumn(
              title: 'IgnorePointer',
              colorPrimary: const Color(0xFF1D4ED8),
              colorAccent: const Color(0xFFBFDBFE),
              icon: Icons.fast_forward,
              tagline: 'falls through',
              detail:
                  'Tap travels right past this branch as if it did not exist. '
                  'Sibling widgets behind/around it can still receive the event.',
              wrapped: IgnorePointer(
                ignoring: true,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Try'),
                  onPressed: () => print('ignore-pointer button'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D4ED8),
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 1,
            height: 220,
            margin: const EdgeInsets.symmetric(horizontal: 14),
            color: const Color(0xFFE2E8F0),
          ),
          Expanded(
            child: _CompareColumn(
              title: 'AbsorbPointer',
              colorPrimary: const Color(0xFFB91C1C),
              colorAccent: const Color(0xFFFECACA),
              icon: Icons.front_hand,
              tagline: 'catches & stops',
              detail:
                  'AbsorbPointer registers the hit on itself and consumes it. '
                  'Children do NOT receive the event, but neither do the siblings underneath.',
              wrapped: AbsorbPointer(
                absorbing: true,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.front_hand),
                  label: const Text('Try'),
                  onPressed: () => print('absorb-pointer button'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB91C1C),
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompareColumn extends StatelessWidget {
  final String title;
  final Color colorPrimary;
  final Color colorAccent;
  final IconData icon;
  final String tagline;
  final String detail;
  final Widget wrapped;

  const _CompareColumn({
    required this.title,
    required this.colorPrimary,
    required this.colorAccent,
    required this.icon,
    required this.tagline,
    required this.detail,
    required this.wrapped,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[colorPrimary, colorAccent],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: colorPrimary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: colorAccent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            tagline,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: colorPrimary,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          detail,
          style: const TextStyle(
            fontSize: 12.5,
            color: Color(0xFF334155),
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14),
        wrapped,
      ],
    );
  }
}

// ============================================================================
// SECTION 3: LAYERED OVERLAY
// ============================================================================

class _LayeredOverlayDemo extends StatelessWidget {
  const _LayeredOverlayDemo();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFFFFFFFF), Color(0xFFF8FAFC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x16000000),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.layers_outlined, size: 20, color: Color(0xFF7C3AED)),
              SizedBox(width: 8),
              Text(
                'Stack with a translucent overlay on top',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.5,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: SizedBox(
              height: 260,
              child: Stack(
                children: <Widget>[
                  // Bottom layer: real content with interactive things.
                  Positioned.fill(
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[Color(0xFFE0F2FE), Color(0xFFBAE6FD)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Underlying interactive content',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: Color(0xFF075985),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              ElevatedButton.icon(
                                icon: const Icon(Icons.play_arrow),
                                label: const Text('Play'),
                                onPressed: () => print('Play tapped'),
                              ),
                              const SizedBox(width: 8),
                              OutlinedButton.icon(
                                icon: const Icon(Icons.pause),
                                label: const Text('Pause'),
                                onPressed: () => print('Pause tapped'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                  color: Color(0x18000000),
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: const <Widget>[
                                Icon(Icons.music_note,
                                    size: 18, color: Color(0xFF0369A1)),
                                SizedBox(width: 8),
                                Text(
                                  'Track 03 — buttons remain hot',
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    color: Color(0xFF075985),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Top layer: visual tint, ignores pointer.
                  Positioned.fill(
                    child: IgnorePointer(
                      ignoring: true,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0x33A855F7),
                              Color(0x66EC4899),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                  color: Color(0x33000000),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const <Widget>[
                                Icon(Icons.auto_awesome,
                                    size: 18, color: Color(0xFF7C3AED)),
                                SizedBox(width: 8),
                                Text(
                                  'Decorative overlay (ignores pointer)',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFFCD34D)),
            ),
            child: Row(
              children: const <Widget>[
                Icon(Icons.lightbulb, color: Color(0xFFB45309), size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'The visual overlay does not steal events because it ignores pointer events. '
                    'The Play and Pause buttons underneath still receive taps.',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Color(0xFF92400E),
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

// ============================================================================
// SECTION 4: FORM DISABLED-STATE MOCK
// ============================================================================

class _FormDisabledMock extends StatelessWidget {
  const _FormDisabledMock();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 14,
            offset: Offset(0, 6),
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
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: <Color>[Color(0xFFE2E8F0), Color(0xFFCBD5E1)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    Icon(Icons.lock_outline,
                        size: 14, color: Color(0xFF334155)),
                    SizedBox(width: 6),
                    Text(
                      'Disabled section',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF334155),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Text(
                'IgnorePointer + Opacity 0.5',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF64748B),
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Opacity(
            opacity: 0.5,
            child: IgnorePointer(
              ignoring: true,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const _FormFieldLabel(
                      icon: Icons.person,
                      label: 'Customer name',
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Acme Industries Ltd.',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: Color(0xFFCBD5E1)),
                        ),
                        prefixIcon: const Icon(Icons.business, size: 18),
                      ),
                    ),
                    const SizedBox(height: 14),
                    const _FormFieldLabel(
                      icon: Icons.public,
                      label: 'Region',
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: Row(
                        children: const <Widget>[
                          Icon(Icons.location_on, size: 18,
                              color: Color(0xFF64748B)),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'EU — Europe (Frankfurt)',
                              style: TextStyle(fontSize: 13.5),
                            ),
                          ),
                          Icon(Icons.arrow_drop_down,
                              color: Color(0xFF64748B)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    const _FormFieldLabel(
                      icon: Icons.notifications_active,
                      label: 'Notification channels',
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: const <Widget>[
                        _CheckboxRow(label: 'Email', checked: true),
                        SizedBox(width: 14),
                        _CheckboxRow(label: 'SMS', checked: false),
                        SizedBox(width: 14),
                        _CheckboxRow(label: 'Webhook', checked: true),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.save),
                        label: const Text('Save changes'),
                        onPressed: () => print('save pressed (disabled)'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2563EB),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFBFDBFE)),
            ),
            child: Row(
              children: const <Widget>[
                Icon(Icons.info, color: Color(0xFF1D4ED8), size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Wrapping a section with IgnorePointer + Opacity is the canonical '
                    '"disable a sub-form" pattern: visuals stay, taps go nowhere.',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Color(0xFF1E3A8A),
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

class _FormFieldLabel extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FormFieldLabel({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon, size: 16, color: const Color(0xFF334155)),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: Color(0xFF334155),
          ),
        ),
      ],
    );
  }
}

class _CheckboxRow extends StatelessWidget {
  final String label;
  final bool checked;

  const _CheckboxRow({required this.label, required this.checked});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: checked ? const Color(0xFF2563EB) : Colors.white,
            border: Border.all(
              color: checked
                  ? const Color(0xFF2563EB)
                  : const Color(0xFF94A3B8),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: checked
              ? const Icon(Icons.check, color: Colors.white, size: 14)
              : null,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 12.5, color: Color(0xFF334155)),
        ),
      ],
    );
  }
}

// ============================================================================
// SECTION 5: SEMANTICS MATRIX
// ============================================================================

class _SemanticsMatrix extends StatelessWidget {
  const _SemanticsMatrix();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.accessibility_new,
                  size: 18, color: Color(0xFF0F766E)),
              SizedBox(width: 8),
              Text(
                'Semantics matrix — what assistive tech sees',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.5,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const <Widget>[
              Expanded(
                child: _SemanticsCard(
                  caption: 'IgnorePointer(ignoring: true)',
                  description:
                      'By default, IgnorePointer also drops semantics for descendants — '
                      'the subtree becomes invisible to screen readers as well.',
                  bullet1: 'Hit-test: skipped',
                  bullet2: 'Semantics: hidden (default)',
                  color: Color(0xFFDC2626),
                  icon: Icons.volume_off,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _SemanticsCard(
                  caption: 'IgnorePointer(ignoring: true,\nignoringSemantics: false)',
                  description:
                      'Legacy parameter (now deprecated): hit-test still skipped, '
                      'but semantics are preserved so a screen reader still announces them.',
                  bullet1: 'Hit-test: skipped',
                  bullet2: 'Semantics: visible',
                  color: Color(0xFFCA8A04),
                  icon: Icons.warning_amber,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _SemanticsCard(
                  caption: 'Modern: IgnorePointer\n+ Semantics(child:)',
                  description:
                      'Prefer the modern Semantics widget to author labels explicitly. '
                      'IgnorePointer continues to handle pointer behavior only.',
                  bullet1: 'Hit-test: skipped',
                  bullet2: 'Semantics: explicit & flexible',
                  color: Color(0xFF15803D),
                  icon: Icons.verified,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SemanticsCard extends StatelessWidget {
  final String caption;
  final String description;
  final String bullet1;
  final String bullet2;
  final Color color;
  final IconData icon;

  const _SemanticsCard({
    required this.caption,
    required this.description,
    required this.bullet1,
    required this.bullet2,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 16),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  caption,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: color,
                    fontFamily: 'monospace',
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF334155),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          _BulletLine(text: bullet1),
          const SizedBox(height: 4),
          _BulletLine(text: bullet2),
        ],
      ),
    );
  }
}

class _BulletLine extends StatelessWidget {
  final String text;

  const _BulletLine({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 5),
          child: Icon(Icons.fiber_manual_record,
              size: 8, color: Color(0xFF64748B)),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 11.5,
              color: Color(0xFF1E293B),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// SECTION 6: HIT-TEST FLOW DIAGRAM
// ============================================================================

class _HitTestFlow extends StatelessWidget {
  const _HitTestFlow();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFFFFFFFF), Color(0xFFF1F5F9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x16000000),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.account_tree, size: 18, color: Color(0xFF7C3AED)),
              SizedBox(width: 8),
              Text(
                'How a tap travels through the render tree',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.5,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _FlowStep(
            number: '1',
            title: 'WidgetsApp.gestureBinding',
            detail: 'Receives the raw PointerDownEvent from the platform.',
            color: Color(0xFF0EA5E9),
            icon: Icons.flag,
          ),
          _FlowArrow(),
          _FlowStep(
            number: '2',
            title: 'Listener / RenderPointerListener',
            detail: 'Standard pointer routing into the render tree.',
            color: Color(0xFF6366F1),
            icon: Icons.alt_route,
          ),
          _FlowArrow(),
          _FlowStep(
            number: '3',
            title: 'RenderIgnorePointer (ignoring=true)',
            detail:
                'Returns false from hitTest() — its subtree is not even consulted.',
            color: Color(0xFFEF4444),
            icon: Icons.block,
            highlighted: true,
          ),
          _FlowArrow(),
          _FlowStep(
            number: '4',
            title: 'Sibling render object at same z',
            detail:
                'The hit search continues to other candidates layered behind the ignored subtree.',
            color: Color(0xFF22C55E),
            icon: Icons.subdirectory_arrow_right,
          ),
          _FlowArrow(),
          _FlowStep(
            number: '5',
            title: 'GestureRecognizer.acceptGesture',
            detail: 'Whichever sibling wins the arena receives the tap callback.',
            color: Color(0xFF0F766E),
            icon: Icons.check_circle,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFAF5FF),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFD8B4FE)),
            ),
            child: Row(
              children: const <Widget>[
                Icon(Icons.tips_and_updates,
                    color: Color(0xFF7C3AED), size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Mental model: IgnorePointer behaves like Visibility(visible: true) '
                    'for paint, and Visibility(visible: false) for hit-testing.',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Color(0xFF6B21A8),
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

class _FlowStep extends StatelessWidget {
  final String number;
  final String title;
  final String detail;
  final Color color;
  final IconData icon;
  final bool highlighted;

  const _FlowStep({
    required this.number,
    required this.title,
    required this.detail,
    required this.color,
    required this.icon,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: highlighted
            ? LinearGradient(
                colors: <Color>[color.withOpacity(0.18), Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: highlighted ? null : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(highlighted ? 0.7 : 0.3)),
        boxShadow: highlighted
            ? <BoxShadow>[
                BoxShadow(
                  color: color.withOpacity(0.18),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : const <BoxShadow>[
                BoxShadow(
                  color: Color(0x10000000),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: color,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  detail,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF334155),
                    height: 1.4,
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

class _FlowArrow extends StatelessWidget {
  const _FlowArrow();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 18),
      child: Icon(Icons.arrow_downward, color: Color(0xFF94A3B8), size: 20),
    );
  }
}

// ============================================================================
// SECTION 7: API REFERENCE GRID
// ============================================================================

class _ApiReferenceGrid extends StatelessWidget {
  const _ApiReferenceGrid();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        _ApiCard(
          parameter: 'ignoring',
          type: 'bool',
          required: true,
          summary:
              'Whether to skip pointer events for the subtree. When true, hits go through.',
          example: 'IgnorePointer(ignoring: true, child: ...)',
          icon: Icons.toggle_on,
          accent: Color(0xFF1D4ED8),
        ),
        SizedBox(height: 12),
        _ApiCard(
          parameter: 'ignoringSemantics',
          type: 'bool? (deprecated)',
          required: false,
          summary:
              'Legacy escape hatch to keep semantics visible while ignoring pointers. '
              'Prefer composing with the Semantics widget instead.',
          example: 'IgnorePointer(ignoring: true, ignoringSemantics: false, ...)',
          icon: Icons.history_edu,
          accent: Color(0xFFB45309),
        ),
        SizedBox(height: 12),
        _ApiCard(
          parameter: 'child',
          type: 'Widget?',
          required: false,
          summary:
              'The subtree whose pointer events are conditionally suppressed. '
              'Always paints regardless of "ignoring".',
          example: 'IgnorePointer(child: MyButtons())',
          icon: Icons.account_tree_outlined,
          accent: Color(0xFF15803D),
        ),
      ],
    );
  }
}

class _ApiCard extends StatelessWidget {
  final String parameter;
  final String type;
  final bool required;
  final String summary;
  final String example;
  final IconData icon;
  final Color accent;

  const _ApiCard({
    required this.parameter,
    required this.type,
    required this.required,
    required this.summary,
    required this.example,
    required this.icon,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withOpacity(0.25)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[accent, accent.withOpacity(0.6)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 10),
              Text(
                parameter,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: accent,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  type,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF1E40AF),
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              if (required)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEE2E2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'required',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFFB91C1C),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'optional',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF475569),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            summary,
            style: const TextStyle(
              fontSize: 12.5,
              color: Color(0xFF334155),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: <Widget>[
                const Icon(Icons.code,
                    color: Color(0xFF38BDF8), size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    example,
                    style: const TextStyle(
                      color: Color(0xFFE2E8F0),
                      fontFamily: 'monospace',
                      fontSize: 12,
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

// ============================================================================
// SECTION 8: USE-CASE LIST
// ============================================================================

class _UseCaseList extends StatelessWidget {
  const _UseCaseList();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _UseCaseRow(
            icon: Icons.lock,
            color: Color(0xFFDC2626),
            title: 'Disabled UI states',
            detail:
                'Wrap form sections that should appear but cannot be edited (e.g. "saving…" state).',
          ),
          SizedBox(height: 10),
          _UseCaseRow(
            icon: Icons.layers,
            color: Color(0xFF7C3AED),
            title: 'Decorative overlays',
            detail:
                'Watermarks, badges, gradient flares — visible on top, but not stealing taps.',
          ),
          SizedBox(height: 10),
          _UseCaseRow(
            icon: Icons.swipe,
            color: Color(0xFF0EA5E9),
            title: 'Drag affordances',
            detail:
                'Show drag handles or hit hints without intercepting the parent draggable.',
          ),
          SizedBox(height: 10),
          _UseCaseRow(
            icon: Icons.tour,
            color: Color(0xFF0F766E),
            title: 'Onboarding spotlights',
            detail:
                'Render a tutorial pulse over a button while keeping the button itself tappable.',
          ),
          SizedBox(height: 10),
          _UseCaseRow(
            icon: Icons.flash_on,
            color: Color(0xFFCA8A04),
            title: 'Skeleton loading shimmer',
            detail:
                'Animate placeholder shimmer above the real content to keep its layout but block interaction until the data arrives.',
          ),
          SizedBox(height: 10),
          _UseCaseRow(
            icon: Icons.theaters,
            color: Color(0xFFB45309),
            title: 'Stage previews',
            detail:
                'Preview a card visually inside an editor without letting clicks fire — useful for theme galleries.',
          ),
          SizedBox(height: 10),
          _UseCaseRow(
            icon: Icons.timer,
            color: Color(0xFF6366F1),
            title: 'Time-limited interactions',
            detail:
                'Briefly disable a CTA button after press to debounce repeated taps.',
          ),
        ],
      ),
    );
  }
}

class _UseCaseRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String detail;

  const _UseCaseRow({
    required this.icon,
    required this.color,
    required this.title,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[color.withOpacity(0.06), Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.18)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.13),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  detail,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF334155),
                    height: 1.4,
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

// ============================================================================
// SECTION 9: PITFALLS + SEE-ALSO
// ============================================================================

class _PitfallSection extends StatelessWidget {
  const _PitfallSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        _PitfallCard(
          title: 'Pitfalls',
          icon: Icons.warning_amber,
          color: Color(0xFFB91C1C),
          gradientStart: Color(0xFFFEE2E2),
          gradientEnd: Color(0xFFFFFFFF),
          rows: <_PitfallRow>[
            _PitfallRow(
              icon: Icons.cancel,
              text:
                  'Ancestor GestureDetectors can still receive the event — IgnorePointer only blanks out *its own subtree*, not parents.',
            ),
            _PitfallRow(
              icon: Icons.cancel,
              text:
                  'Forgetting Opacity. IgnorePointer alone keeps full visual fidelity; users may not realize the section is disabled.',
            ),
            _PitfallRow(
              icon: Icons.cancel,
              text:
                  'Using IgnorePointer to "fix" a layout overlay that should not be on top in the first place — usually a Stack ordering smell.',
            ),
            _PitfallRow(
              icon: Icons.cancel,
              text:
                  'Hover and mouse cursors are still affected differently — test on web/desktop too.',
            ),
            _PitfallRow(
              icon: Icons.cancel,
              text:
                  'Mixing IgnorePointer with AbsorbPointer in the same branch will produce surprising results. Pick one.',
            ),
          ],
        ),
        SizedBox(height: 14),
        _PitfallCard(
          title: 'See also',
          icon: Icons.menu_book,
          color: Color(0xFF1D4ED8),
          gradientStart: Color(0xFFDBEAFE),
          gradientEnd: Color(0xFFFFFFFF),
          rows: <_PitfallRow>[
            _PitfallRow(
              icon: Icons.front_hand,
              text:
                  'AbsorbPointer — receives the hit itself but blocks descendants from receiving it.',
            ),
            _PitfallRow(
              icon: Icons.mouse,
              text:
                  'Listener / RenderPointerListener — for raw pointer event observation without consuming.',
            ),
            _PitfallRow(
              icon: Icons.gesture,
              text:
                  'GestureDetector(behavior: HitTestBehavior.translucent) — receive events but allow them to propagate.',
            ),
            _PitfallRow(
              icon: Icons.visibility_off,
              text:
                  'Visibility(maintainInteractivity: false) — full structural removal of interactivity.',
            ),
            _PitfallRow(
              icon: Icons.toggle_off,
              text:
                  'ExcludeSemantics — drop a subtree from the semantic tree without affecting hit-testing.',
            ),
            _PitfallRow(
              icon: Icons.layers_clear,
              text:
                  'Offstage — keeps a widget in the tree but stops painting and hit-testing.',
            ),
          ],
        ),
      ],
    );
  }
}

class _PitfallCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Color gradientStart;
  final Color gradientEnd;
  final List<_PitfallRow> rows;

  const _PitfallCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.gradientStart,
    required this.gradientEnd,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[gradientStart, gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...rows.map<Widget>((_PitfallRow r) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: Icon(r.icon, color: color, size: 16),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        r.text,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: Color(0xFF1E293B),
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _PitfallRow {
  final IconData icon;
  final String text;

  const _PitfallRow({required this.icon, required this.text});
}

// ============================================================================
// FOOTER
// ============================================================================

class _FooterCard extends StatelessWidget {
  const _FooterCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF0F172A), Color(0xFF1E3A8A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.bookmark, color: Color(0xFFBFDBFE), size: 22),
              SizedBox(width: 10),
              Text(
                'Quick recap',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'IgnorePointer is the smallest, cheapest tool for "render but do not '
            'interact". When you need the hit to be caught and stopped (rather than '
            'falling through to siblings), reach for AbsorbPointer instead. When you '
            'need the subtree gone entirely, use Visibility or Offstage.',
            style: TextStyle(
              color: Color(0xFFE2E8F0),
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: const <Widget>[
              _FooterChip(label: 'render-tree level', icon: Icons.layers),
              SizedBox(width: 8),
              _FooterChip(label: 'no rebuilds', icon: Icons.bolt),
              SizedBox(width: 8),
              _FooterChip(label: 'paints normally', icon: Icons.brush),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const _FooterChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0x33FFFFFF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0x55FFFFFF)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: const Color(0xFFBFDBFE), size: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFBFDBFE),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

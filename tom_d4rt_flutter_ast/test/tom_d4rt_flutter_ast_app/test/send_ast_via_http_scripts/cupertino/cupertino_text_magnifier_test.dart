// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoPageScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 60),
          child: Column(children: const <Widget>[
            _HeroHeader(),
            SizedBox(height: 24),
            _AnatomySection(),
            SizedBox(height: 28),
            _TriggerFlowSection(),
            SizedBox(height: 28),
            _ApiSurfaceSection(),
            SizedBox(height: 28),
            _MagnifierInfoSection(),
            SizedBox(height: 28),
            _ControllerStateSection(),
            SizedBox(height: 28),
            _ComparisonSection(),
            SizedBox(height: 28),
            _MagnificationMathSection(),
            SizedBox(height: 28),
            _PlatformBehaviorSection(),
            SizedBox(height: 28),
            _PitfallsSection(),
            SizedBox(height: 28),
            _CanonicalUsageSection(),
            SizedBox(height: 28),
            _FooterStamp(),
          ]),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION HEADER CARD
// ---------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  final String number;
  final String title;
  final String subtitle;
  final List<Color> gradient;
  final IconData icon;

  const _SectionHeader({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.gradient,
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
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(18.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: gradient.first.withValues(alpha: 0.35),
            blurRadius: 18.0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 56.0,
            height: 56.0,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF).withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(
                color: const Color(0xFFFFFFFF).withValues(alpha: 0.35),
                width: 1.0,
              ),
            ),
            child: Icon(
              icon,
              color: const Color(0xFFFFFFFF),
              size: 28.0,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Section $number',
                  style: const TextStyle(
                    fontFamily: 'CupertinoSystemText',
                    color: Color(0xFFE7EAF6),
                    fontSize: 11.0,
                    letterSpacing: 1.6,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'CupertinoSystemText',
                    color: Color(0xFFFFFFFF),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.1,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'CupertinoSystemText',
                    color: const Color(0xFFFFFFFF).withValues(alpha: 0.85),
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
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

// ---------------------------------------------------------------------------
// HERO HEADER
// ---------------------------------------------------------------------------

class _HeroHeader extends StatelessWidget {
  const _HeroHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 30, 24, 30),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF0A2540),
            Color(0xFF1E3A8A),
            Color(0xFF3B5CB8),
          ],
        ),
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF0A2540).withValues(alpha: 0.45),
            blurRadius: 28.0,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: const Color(0xFFFFFFFF).withValues(alpha: 0.35),
                    width: 1.0,
                  ),
                ),
                child: const Text(
                  'flutter/cupertino.dart',
                  style: TextStyle(
                    fontFamily: 'Menlo',
                    color: Color(0xFFE7EAF6),
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF34C759).withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: const Color(0xFF34C759).withValues(alpha: 0.6),
                    width: 1.0,
                  ),
                ),
                child: const Text(
                  'iOS LOUPE',
                  style: TextStyle(
                    fontFamily: 'CupertinoSystemText',
                    color: Color(0xFFB8F5C3),
                    fontSize: 10.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18.0),
          const Text(
            'CupertinoTextMagnifier',
            style: TextStyle(
              fontFamily: 'CupertinoSystemText',
              color: Color(0xFFFFFFFF),
              fontSize: 30.0,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'A static visual deep dive into the iOS-style magnifying loupe that '
            'appears above a CupertinoTextField when the user drags a text '
            'selection handle. Includes anatomy, API surface, MagnifierInfo '
            'data, controller state, comparison vs Material, magnification '
            'math, platform behavior, pitfalls, and canonical usage.',
            style: TextStyle(
              fontFamily: 'CupertinoSystemText',
              color: const Color(0xFFFFFFFF).withValues(alpha: 0.88),
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18.0),
          Row(
            children: const <Widget>[
              _HeroChip(label: 'Stateful', color: Color(0xFFF59E0B)),
              SizedBox(width: 8.0),
              _HeroChip(label: 'Overlay', color: Color(0xFF06B6D4)),
              SizedBox(width: 8.0),
              _HeroChip(label: '1.5x default', color: Color(0xFFEC4899)),
              SizedBox(width: 8.0),
              _HeroChip(label: 'iOS only', color: Color(0xFF8B5CF6)),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  final String label;
  final Color color;

  const _HeroChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.7), width: 1.0),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'CupertinoSystemText',
          color: color,
          fontSize: 10.5,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 1. ANATOMY SECTION
// ---------------------------------------------------------------------------

class _AnatomySection extends StatelessWidget {
  const _AnatomySection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const _SectionHeader(
          number: '01',
          title: 'Anatomy of the Loupe',
          subtitle: 'A labeled diagram of the magnifier with its callouts.',
          gradient: <Color>[Color(0xFF0A2540), Color(0xFF1E40AF)],
          icon: CupertinoIcons.search_circle_fill,
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xFFF8FAFC), Color(0xFFE2E8F0)],
            ),
            borderRadius: BorderRadius.circular(18.0),
            border: Border.all(color: const Color(0xFFCBD5E1), width: 1.0),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 280.0,
                child: Stack(
                  alignment: Alignment.center,
                  children: const <Widget>[
                    _AnatomyDiagram(),
                  ],
                ),
              ),
              const SizedBox(height: 18.0),
              const _AnatomyLegend(),
            ],
          ),
        ),
      ],
    );
  }
}

class _AnatomyDiagram extends StatelessWidget {
  const _AnatomyDiagram();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        // Underlying text strip representing the text field content.
        Positioned(
          left: 0,
          right: 0,
          top: 188.0,
          child: Container(
            height: 26.0,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: const Color(0xFFCBD5E1), width: 1.0),
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: const Text(
              'The quick brown fox jumps over the lazy dog.',
              style: TextStyle(
                fontFamily: 'CupertinoSystemText',
                fontSize: 13.0,
                color: Color(0xFF111827),
              ),
            ),
          ),
        ),
        // Lens shadow
        Positioned(
          top: 64.0,
          child: Container(
            width: 140.0,
            height: 36.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: const Color(0xFF0F172A).withValues(alpha: 0.35),
                  blurRadius: 22.0,
                  offset: const Offset(0, 14),
                ),
              ],
            ),
          ),
        ),
        // The lens (oval) holding magnified text
        Positioned(
          top: 50.0,
          child: Container(
            width: 140.0,
            height: 70.0,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color(0xFFFFFFFF),
                  Color(0xFFE2E8F0),
                ],
              ),
              borderRadius: BorderRadius.circular(60.0),
              border: Border.all(color: const Color(0xFFCBD5E1), width: 1.5),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: const Color(0xFF000000).withValues(alpha: 0.10),
                  blurRadius: 4.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Text(
              'brown fox',
              style: TextStyle(
                fontFamily: 'CupertinoSystemText',
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
        ),
        // Target offset arrow region
        Positioned(
          top: 124.0,
          child: Container(
            width: 3.0,
            height: 60.0,
            color: const Color(0xFF3B82F6),
          ),
        ),
        // Target caret position dot on text strip
        Positioned(
          top: 184.0,
          child: Container(
            width: 14.0,
            height: 14.0,
            decoration: const BoxDecoration(
              color: Color(0xFFEF4444),
              shape: BoxShape.circle,
            ),
          ),
        ),
        // Callouts
        Positioned(
          right: 0,
          top: 40.0,
          child: const _Callout(
            label: 'Lens border',
            color: Color(0xFF6366F1),
          ),
        ),
        Positioned(
          left: 0,
          top: 80.0,
          child: const _Callout(
            label: '1.5x magnified',
            color: Color(0xFFEC4899),
          ),
        ),
        Positioned(
          right: 0,
          top: 120.0,
          child: const _Callout(
            label: 'Target offset',
            color: Color(0xFF3B82F6),
          ),
        ),
        Positioned(
          left: 0,
          top: 160.0,
          child: const _Callout(
            label: 'Drop shadow',
            color: Color(0xFF0F172A),
          ),
        ),
        Positioned(
          right: 0,
          top: 200.0,
          child: const _Callout(
            label: 'Caret target',
            color: Color(0xFFEF4444),
          ),
        ),
      ],
    );
  }
}

class _Callout extends StatelessWidget {
  final String label;
  final Color color;

  const _Callout({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: color.withValues(alpha: 0.7), width: 1.0),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'CupertinoSystemText',
          color: color,
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _AnatomyLegend extends StatelessWidget {
  const _AnatomyLegend();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        _LegendRow(
          color: Color(0xFF6366F1),
          label: 'Lens border',
          description: 'Rounded-rect outline of the oval loupe glass.',
        ),
        _LegendRow(
          color: Color(0xFFEC4899),
          label: 'Magnification factor',
          description: 'Default 1.5x; static for the lifetime of the magnifier.',
        ),
        _LegendRow(
          color: Color(0xFF3B82F6),
          label: 'Target offset',
          description: 'Vertical distance from lens to caret in the field.',
        ),
        _LegendRow(
          color: Color(0xFF0F172A),
          label: 'Drop shadow',
          description: 'Soft elevated shadow under the loupe.',
        ),
        _LegendRow(
          color: Color(0xFFEF4444),
          label: 'Caret target',
          description: 'The drag handle position the loupe is anchored to.',
        ),
      ],
    );
  }
}

class _LegendRow extends StatelessWidget {
  final Color color;
  final String label;
  final String description;

  const _LegendRow({
    required this.color,
    required this.label,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 14.0,
            height: 14.0,
            margin: const EdgeInsets.only(top: 2.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'CupertinoSystemText',
                    fontSize: 13.0,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  description,
                  style: const TextStyle(
                    fontFamily: 'CupertinoSystemText',
                    fontSize: 12.5,
                    color: Color(0xFF475569),
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

// ---------------------------------------------------------------------------
// 2. TRIGGER FLOW SECTION
// ---------------------------------------------------------------------------

class _TriggerFlowSection extends StatelessWidget {
  const _TriggerFlowSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const _SectionHeader(
          number: '02',
          title: 'Trigger Flow',
          subtitle: 'Three static phone-frame states: idle, press, drag.',
          gradient: <Color>[Color(0xFF0E7490), Color(0xFF06B6D4)],
          icon: CupertinoIcons.hand_draw_fill,
        ),
        const SizedBox(height: 14.0),
        Row(
          children: const <Widget>[
            Expanded(
              child: _PhoneFrame(
                state: 'Idle',
                stateColor: Color(0xFF64748B),
                showHandle: false,
                showMagnifier: false,
                description: 'Plain CupertinoTextField with caret.',
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _PhoneFrame(
                state: 'Press',
                stateColor: Color(0xFFF59E0B),
                showHandle: true,
                showMagnifier: false,
                description: 'Handle visible; long-press registered.',
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _PhoneFrame(
                state: 'Drag',
                stateColor: Color(0xFF10B981),
                showHandle: true,
                showMagnifier: true,
                description: 'Magnifier follows handle drag.',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PhoneFrame extends StatelessWidget {
  final String state;
  final Color stateColor;
  final bool showHandle;
  final bool showMagnifier;
  final String description;

  const _PhoneFrame({
    required this.state,
    required this.stateColor,
    required this.showHandle,
    required this.showMagnifier,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Color(0xFFF1F5F9), Color(0xFFE2E8F0)],
        ),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFCBD5E1), width: 1.0),
      ),
      padding: const EdgeInsets.fromLTRB(10, 12, 10, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: stateColor.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(6.0),
              border:
                  Border.all(color: stateColor.withValues(alpha: 0.7), width: 1.0),
            ),
            child: Text(
              state.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'CupertinoSystemText',
                color: stateColor,
                fontSize: 10.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            height: 200.0,
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(22.0),
              border: Border.all(color: const Color(0xFF1F2937), width: 4.0),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(16.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Note',
                        style: TextStyle(
                          fontFamily: 'CupertinoSystemText',
                          fontSize: 9.0,
                          color: Color(0xFF6B7280),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Container(
                        height: 1.0,
                        color: const Color(0xFFE5E7EB),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Reminder: pick up the\nmilk on the way home.',
                        style: TextStyle(
                          fontFamily: 'CupertinoSystemText',
                          fontSize: 10.5,
                          color: Color(0xFF111827),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                  if (showHandle)
                    Positioned(
                      left: 32.0,
                      top: 58.0,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 8.0,
                            height: 8.0,
                            decoration: const BoxDecoration(
                              color: Color(0xFF0A84FF),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: 2.0,
                            height: 16.0,
                            color: const Color(0xFF0A84FF),
                          ),
                        ],
                      ),
                    ),
                  if (showMagnifier)
                    Positioned(
                      left: 6.0,
                      top: 12.0,
                      child: Container(
                        width: 100.0,
                        height: 46.0,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Color(0xFFFFFFFF),
                              Color(0xFFE2E8F0),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(40.0),
                          border: Border.all(
                            color: const Color(0xFFCBD5E1),
                            width: 1.0,
                          ),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: const Color(0xFF000000)
                                  .withValues(alpha: 0.25),
                              blurRadius: 8.0,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Reminder',
                          style: TextStyle(
                            fontFamily: 'CupertinoSystemText',
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'CupertinoSystemText',
              fontSize: 11.0,
              color: Color(0xFF475569),
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 3. API SURFACE SECTION
// ---------------------------------------------------------------------------

class _ApiSurfaceSection extends StatelessWidget {
  const _ApiSurfaceSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const _SectionHeader(
          number: '03',
          title: 'API Surface',
          subtitle: 'Constructor parameters of CupertinoTextMagnifier.',
          gradient: <Color>[Color(0xFF7C3AED), Color(0xFFA855F7)],
          icon: CupertinoIcons.cube_box_fill,
        ),
        const SizedBox(height: 14.0),
        Column(
          children: const <Widget>[
            _ApiCard(
              name: 'controller',
              type: 'MagnifierController',
              required: true,
              description:
                  'Drives show()/hide() animation and tracks shown state. '
                  'Owned by the text field selection toolbar.',
            ),
            SizedBox(height: 10.0),
            _ApiCard(
              name: 'magnifierInfo',
              type: 'ValueNotifier<MagnifierInfo>',
              required: true,
              description:
                  'Streams gesture position, field bounds, caret rect, and '
                  'current line boundaries so the magnifier can reposition.',
            ),
            SizedBox(height: 10.0),
            _ApiCard(
              name: 'dragResistance',
              type: 'double',
              required: false,
              description:
                  'Pixels the touch may move vertically before the magnifier '
                  'follows; gives a sticky baseline. Default 10.0.',
            ),
            SizedBox(height: 10.0),
            _ApiCard(
              name: 'hideBelowThreshold',
              type: 'double',
              required: false,
              description:
                  'When the gesture sits this many logical pixels below the '
                  'caret, the magnifier hides itself. Default 48.0.',
            ),
            SizedBox(height: 10.0),
            _ApiCard(
              name: 'horizontalScreenEdgePadding',
              type: 'double',
              required: false,
              description:
                  'Min horizontal padding kept between magnifier edge and '
                  'screen edges so the loupe never clips. Default 10.0.',
            ),
            SizedBox(height: 10.0),
            _ApiCard(
              name: 'animationCurve',
              type: 'Curve',
              required: false,
              description:
                  'Curve for the show/hide transition. Default '
                  'Curves.easeOut.',
            ),
          ],
        ),
      ],
    );
  }
}

class _ApiCard extends StatelessWidget {
  final String name;
  final String type;
  final bool required;
  final String description;

  const _ApiCard({
    required this.name,
    required this.type,
    required this.required,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFFFAF5FF), Color(0xFFF3E8FF)],
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: const Color(0xFFDDD6FE), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF7C3AED).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    color: const Color(0xFF7C3AED).withValues(alpha: 0.5),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  name,
                  style: const TextStyle(
                    fontFamily: 'Menlo',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF6D28D9),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                type,
                style: const TextStyle(
                  fontFamily: 'Menlo',
                  fontSize: 11.5,
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 7.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: required
                      ? const Color(0xFFEF4444).withValues(alpha: 0.15)
                      : const Color(0xFF10B981).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  required ? 'required' : 'optional',
                  style: TextStyle(
                    fontFamily: 'CupertinoSystemText',
                    fontSize: 10.0,
                    fontWeight: FontWeight.w800,
                    color: required
                        ? const Color(0xFFB91C1C)
                        : const Color(0xFF047857),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            description,
            style: const TextStyle(
              fontFamily: 'CupertinoSystemText',
              fontSize: 12.5,
              color: Color(0xFF334155),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 4. MAGNIFIERINFO SECTION
// ---------------------------------------------------------------------------

class _MagnifierInfoSection extends StatelessWidget {
  const _MagnifierInfoSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const _SectionHeader(
          number: '04',
          title: 'MagnifierInfo Data Class',
          subtitle: 'Fields streamed via ValueNotifier into the loupe.',
          gradient: <Color>[Color(0xFFB45309), Color(0xFFF59E0B)],
          icon: CupertinoIcons.doc_text_fill,
        ),
        const SizedBox(height: 14.0),
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xFFFFFBEB), Color(0xFFFEF3C7)],
            ),
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: const Color(0xFFFDE68A), width: 1.0),
          ),
          child: Column(
            children: const <Widget>[
              _MagnifierInfoRow(
                isHeader: true,
                field: 'Field',
                type: 'Type',
                meaning: 'What it represents',
              ),
              _MagnifierInfoRow(
                field: 'globalGesturePosition',
                type: 'Offset',
                meaning: 'Current pointer in global coords.',
              ),
              _MagnifierInfoRow(
                field: 'fieldBounds',
                type: 'Rect',
                meaning: 'Bounds of the parent text field.',
              ),
              _MagnifierInfoRow(
                field: 'caretRect',
                type: 'Rect',
                meaning: 'Caret bounding box for the touch.',
              ),
              _MagnifierInfoRow(
                field: 'currentLineBoundaries',
                type: 'Rect',
                meaning: 'Top/bottom of the current line.',
              ),
              _MagnifierInfoRow(
                field: 'MagnifierInfo.empty',
                type: 'static',
                meaning: 'Sentinel used when nothing is dragged.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MagnifierInfoRow extends StatelessWidget {
  final String field;
  final String type;
  final String meaning;
  final bool isHeader;

  const _MagnifierInfoRow({
    required this.field,
    required this.type,
    required this.meaning,
    this.isHeader = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor =
        isHeader ? const Color(0xFF7C2D12) : const Color(0xFF422006);
    final FontWeight weight =
        isHeader ? FontWeight.w800 : FontWeight.w600;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFFDE68A).withValues(alpha: 0.9),
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              field,
              style: TextStyle(
                fontFamily: 'Menlo',
                fontSize: 12.0,
                color: textColor,
                fontWeight: weight,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              type,
              style: TextStyle(
                fontFamily: 'Menlo',
                fontSize: 11.5,
                color: textColor.withValues(alpha: 0.8),
                fontWeight: weight,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              meaning,
              style: TextStyle(
                fontFamily: 'CupertinoSystemText',
                fontSize: 12.0,
                color: textColor,
                fontWeight: isHeader ? FontWeight.w700 : FontWeight.w500,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 5. CONTROLLER STATE SECTION
// ---------------------------------------------------------------------------

class _ControllerStateSection extends StatelessWidget {
  const _ControllerStateSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const _SectionHeader(
          number: '05',
          title: 'MagnifierController State',
          subtitle: 'Lifecycle states of the loupe overlay.',
          gradient: <Color>[Color(0xFF065F46), Color(0xFF10B981)],
          icon: CupertinoIcons.dot_radiowaves_left_right,
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(18.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xFFECFDF5), Color(0xFFD1FAE5)],
            ),
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: const Color(0xFFA7F3D0), width: 1.0),
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: const <Widget>[
                  Expanded(
                    child: _StateBubble(
                      label: 'hidden',
                      color: Color(0xFF6B7280),
                      icon: CupertinoIcons.eye_slash_fill,
                    ),
                  ),
                  _StateArrow(label: 'show()'),
                  Expanded(
                    child: _StateBubble(
                      label: 'animating in',
                      color: Color(0xFFF59E0B),
                      icon: CupertinoIcons.arrow_up_circle_fill,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14.0),
              Row(
                children: const <Widget>[
                  Expanded(
                    child: _StateBubble(
                      label: 'visible',
                      color: Color(0xFF10B981),
                      icon: CupertinoIcons.eye_fill,
                    ),
                  ),
                  _StateArrow(label: 'hide()'),
                  Expanded(
                    child: _StateBubble(
                      label: 'animating out',
                      color: Color(0xFFEF4444),
                      icon: CupertinoIcons.arrow_down_circle_fill,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14.0),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF).withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: const Color(0xFFA7F3D0),
                    width: 1.0,
                  ),
                ),
                child: const Text(
                  'controller.shown is true between show() and the start of '
                  'hide()\'s reverse animation. The overlay is inserted into '
                  'Overlay.of(context) by show() and removed after the '
                  'reverse animation completes.',
                  style: TextStyle(
                    fontFamily: 'CupertinoSystemText',
                    fontSize: 12.5,
                    color: Color(0xFF064E3B),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StateBubble extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;

  const _StateBubble({
    required this.label,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.65), width: 1.0),
      ),
      child: Column(
        children: <Widget>[
          Icon(icon, color: color, size: 22.0),
          const SizedBox(height: 6.0),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'CupertinoSystemText',
              color: color,
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _StateArrow extends StatelessWidget {
  final String label;

  const _StateArrow({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Column(
        children: <Widget>[
          const Icon(
            CupertinoIcons.arrow_right,
            color: Color(0xFF065F46),
            size: 18.0,
          ),
          const SizedBox(height: 4.0),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Menlo',
              fontSize: 10.0,
              color: Color(0xFF065F46),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 6. COMPARISON SECTION
// ---------------------------------------------------------------------------

class _ComparisonSection extends StatelessWidget {
  const _ComparisonSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const _SectionHeader(
          number: '06',
          title: 'Cupertino vs Material vs Raw',
          subtitle: 'Side-by-side feature comparison.',
          gradient: <Color>[Color(0xFFBE185D), Color(0xFFEC4899)],
          icon: CupertinoIcons.rectangle_split_3x3_fill,
        ),
        const SizedBox(height: 14.0),
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xFFFDF2F8), Color(0xFFFCE7F3)],
            ),
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: const Color(0xFFFBCFE8), width: 1.0),
          ),
          child: Column(
            children: const <Widget>[
              _CompareRow(
                isHeader: true,
                feature: 'Property',
                a: 'Cupertino',
                b: 'Material',
                c: 'Raw',
              ),
              _CompareRow(
                feature: 'Shape',
                a: 'Oval',
                b: 'Rounded rect',
                c: 'Caller decides',
              ),
              _CompareRow(
                feature: 'Default zoom',
                a: '1.5x',
                b: '1.5x',
                c: 'Caller decides',
              ),
              _CompareRow(
                feature: 'Platform',
                a: 'iOS only',
                b: 'Android',
                c: 'All',
              ),
              _CompareRow(
                feature: 'Drag stickiness',
                a: 'Yes',
                b: 'No',
                c: 'No',
              ),
              _CompareRow(
                feature: 'Auto-hide below caret',
                a: 'Yes',
                b: 'No',
                c: 'No',
              ),
              _CompareRow(
                feature: 'Edge clamping',
                a: 'Yes',
                b: 'Yes',
                c: 'No',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CompareRow extends StatelessWidget {
  final String feature;
  final String a;
  final String b;
  final String c;
  final bool isHeader;

  const _CompareRow({
    required this.feature,
    required this.a,
    required this.b,
    required this.c,
    this.isHeader = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color color =
        isHeader ? const Color(0xFF9D174D) : const Color(0xFF831843);
    final FontWeight weight =
        isHeader ? FontWeight.w800 : FontWeight.w600;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isHeader
            ? const Color(0xFFFBCFE8).withValues(alpha: 0.4)
            : const Color(0x00000000),
        border: const Border(
          bottom: BorderSide(color: Color(0xFFFBCFE8), width: 1.0),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              feature,
              style: TextStyle(
                fontFamily: 'CupertinoSystemText',
                fontSize: 12.5,
                fontWeight: weight,
                color: color,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              a,
              style: TextStyle(
                fontFamily: 'CupertinoSystemText',
                fontSize: 12.0,
                fontWeight: weight,
                color: color,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              b,
              style: TextStyle(
                fontFamily: 'CupertinoSystemText',
                fontSize: 12.0,
                fontWeight: weight,
                color: color,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              c,
              style: TextStyle(
                fontFamily: 'CupertinoSystemText',
                fontSize: 12.0,
                fontWeight: weight,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 7. MAGNIFICATION MATH SECTION
// ---------------------------------------------------------------------------

class _MagnificationMathSection extends StatelessWidget {
  const _MagnificationMathSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const _SectionHeader(
          number: '07',
          title: 'Magnification Math',
          subtitle: 'Visual scale comparison: 1.0x / 1.5x / 2.5x.',
          gradient: <Color>[Color(0xFF1D4ED8), Color(0xFF60A5FA)],
          icon: CupertinoIcons.zoom_in,
        ),
        const SizedBox(height: 14.0),
        Row(
          children: const <Widget>[
            Expanded(
              child: _MagPreview(
                title: '1.0x baseline',
                scale: 1.0,
                accent: Color(0xFF64748B),
                formula: 'scale = 1.0',
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _MagPreview(
                title: '1.5x default',
                scale: 1.5,
                accent: Color(0xFF1D4ED8),
                formula: 'scale = 3/2',
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _MagPreview(
                title: '2.5x exaggerated',
                scale: 2.5,
                accent: Color(0xFFEC4899),
                formula: 'scale = 5/2',
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xFFEFF6FF), Color(0xFFDBEAFE)],
            ),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: const Color(0xFFBFDBFE), width: 1.0),
          ),
          child: const Text(
            'Note: CupertinoTextMagnifier itself is hard-coded by the platform '
            'look. The scale factor here is illustrative — the actual loupe '
            'renders text via the iOS rendering pipeline using a fixed '
            'magnification (~1.5x in stock iOS).',
            style: TextStyle(
              fontFamily: 'CupertinoSystemText',
              fontSize: 12.0,
              color: Color(0xFF1E3A8A),
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }
}

class _MagPreview extends StatelessWidget {
  final String title;
  final double scale;
  final Color accent;
  final String formula;

  const _MagPreview({
    required this.title,
    required this.scale,
    required this.accent,
    required this.formula,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFFFFFFFF),
            accent.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: accent.withValues(alpha: 0.45), width: 1.0),
      ),
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontFamily: 'CupertinoSystemText',
              fontSize: 12.0,
              fontWeight: FontWeight.w800,
              color: accent,
            ),
          ),
          const SizedBox(height: 10.0),
          ClipOval(
            child: Container(
              width: 90.0,
              height: 90.0,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Color(0xFFFFFFFF), Color(0xFFE2E8F0)],
                ),
              ),
              alignment: Alignment.center,
              child: Transform.scale(
                scale: scale,
                child: const Text(
                  'fox',
                  style: TextStyle(
                    fontFamily: 'CupertinoSystemText',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              formula,
              style: TextStyle(
                fontFamily: 'Menlo',
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
                color: accent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 8. PLATFORM BEHAVIOR SECTION
// ---------------------------------------------------------------------------

class _PlatformBehaviorSection extends StatelessWidget {
  const _PlatformBehaviorSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const _SectionHeader(
          number: '08',
          title: 'Platform Behavior',
          subtitle: 'When the loupe is actually shown.',
          gradient: <Color>[Color(0xFF4338CA), Color(0xFF818CF8)],
          icon: CupertinoIcons.device_phone_portrait,
        ),
        const SizedBox(height: 14.0),
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xFFEEF2FF), Color(0xFFE0E7FF)],
            ),
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: const Color(0xFFC7D2FE), width: 1.0),
          ),
          child: Column(
            children: const <Widget>[
              _PlatformRow(
                isHeader: true,
                platform: 'Platform',
                supported: 'Default?',
                notes: 'Notes',
              ),
              _PlatformRow(
                platform: 'iOS',
                supported: 'Yes',
                notes: 'Built-in loupe used by Cupertino selection.',
                supportedColor: Color(0xFF10B981),
              ),
              _PlatformRow(
                platform: 'iPadOS',
                supported: 'Yes',
                notes: 'Same Cupertino loupe; bigger field bounds.',
                supportedColor: Color(0xFF10B981),
              ),
              _PlatformRow(
                platform: 'macOS',
                supported: 'No',
                notes: 'Pointer-driven; no touch loupe by default.',
                supportedColor: Color(0xFFEF4444),
              ),
              _PlatformRow(
                platform: 'Android / others',
                supported: 'No',
                notes: 'Material TextMagnifier is used instead.',
                supportedColor: Color(0xFFEF4444),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PlatformRow extends StatelessWidget {
  final String platform;
  final String supported;
  final String notes;
  final bool isHeader;
  final Color supportedColor;

  const _PlatformRow({
    required this.platform,
    required this.supported,
    required this.notes,
    this.isHeader = false,
    this.supportedColor = const Color(0xFF312E81),
  });

  @override
  Widget build(BuildContext context) {
    final Color color =
        isHeader ? const Color(0xFF312E81) : const Color(0xFF1E1B4B);
    final FontWeight weight =
        isHeader ? FontWeight.w800 : FontWeight.w600;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isHeader
            ? const Color(0xFFC7D2FE).withValues(alpha: 0.4)
            : const Color(0x00000000),
        border: const Border(
          bottom: BorderSide(color: Color(0xFFC7D2FE), width: 1.0),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              platform,
              style: TextStyle(
                fontFamily: 'CupertinoSystemText',
                fontSize: 12.5,
                fontWeight: weight,
                color: color,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              supported,
              style: TextStyle(
                fontFamily: 'CupertinoSystemText',
                fontSize: 12.0,
                fontWeight: FontWeight.w800,
                color: isHeader ? color : supportedColor,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              notes,
              style: TextStyle(
                fontFamily: 'CupertinoSystemText',
                fontSize: 12.0,
                fontWeight: weight,
                color: color,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 9. PITFALLS SECTION
// ---------------------------------------------------------------------------

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const _SectionHeader(
          number: '09',
          title: 'Common Pitfalls',
          subtitle: 'Five things to watch out for in production.',
          gradient: <Color>[Color(0xFF991B1B), Color(0xFFF87171)],
          icon: CupertinoIcons.exclamationmark_triangle_fill,
        ),
        const SizedBox(height: 14.0),
        Column(
          children: const <Widget>[
            _PitfallCard(
              index: '1',
              title: 'Don\'t instantiate directly',
              body:
                  'Avoid building CupertinoTextMagnifier yourself. Use '
                  'TextMagnifierConfiguration.adaptiveMagnifierConfiguration '
                  'so the framework picks Cupertino on iOS automatically.',
            ),
            SizedBox(height: 10.0),
            _PitfallCard(
              index: '2',
              title: 'Requires an Overlay',
              body:
                  'The magnifier inserts itself into Overlay.of(context). If '
                  'no Overlay is present above the text field, show() is a '
                  'no-op and you will see nothing.',
            ),
            SizedBox(height: 10.0),
            _PitfallCard(
              index: '3',
              title: 'Selection toolbar must forward gestures',
              body:
                  'Custom selection toolbars must keep forwarding the '
                  'long-press/drag gesture to the underlying handles, '
                  'otherwise the magnifier never receives MagnifierInfo '
                  'updates.',
            ),
            SizedBox(height: 10.0),
            _PitfallCard(
              index: '4',
              title: 'Don\'t reuse a hidden controller',
              body:
                  'A MagnifierController kept alive across many text fields '
                  'may end up in an inconsistent state. Prefer one controller '
                  'per active selection session.',
            ),
            SizedBox(height: 10.0),
            _PitfallCard(
              index: '5',
              title: 'Disable when you really mean it',
              body:
                  'To hide the magnifier completely (e.g. on a secure field), '
                  'pass magnifierConfiguration: TextMagnifierConfiguration.'
                  'disabled — clearing the controller is not enough.',
            ),
          ],
        ),
      ],
    );
  }
}

class _PitfallCard extends StatelessWidget {
  final String index;
  final String title;
  final String body;

  const _PitfallCard({
    required this.index,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFFFEF2F2), Color(0xFFFEE2E2)],
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: const Color(0xFFFCA5A5), width: 1.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 30.0,
            height: 30.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF991B1B),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              index,
              style: const TextStyle(
                fontFamily: 'CupertinoSystemText',
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.w800,
                fontSize: 14.0,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'CupertinoSystemText',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF7F1D1D),
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  body,
                  style: const TextStyle(
                    fontFamily: 'CupertinoSystemText',
                    fontSize: 12.5,
                    color: Color(0xFF7F1D1D),
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

// ---------------------------------------------------------------------------
// 10. CANONICAL USAGE SECTION
// ---------------------------------------------------------------------------

class _CanonicalUsageSection extends StatelessWidget {
  const _CanonicalUsageSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const _SectionHeader(
          number: '10',
          title: 'Canonical Usage',
          subtitle: 'How real code interacts with the loupe.',
          gradient: <Color>[Color(0xFF111827), Color(0xFF374151)],
          icon: CupertinoIcons.chevron_left_slash_chevron_right,
        ),
        const SizedBox(height: 14.0),
        const _CodeCard(
          title: 'Disable the loupe',
          code: 'CupertinoTextField(\n'
              '  magnifierConfiguration:\n'
              '      TextMagnifierConfiguration.disabled,\n'
              ')',
        ),
        const SizedBox(height: 12.0),
        const _CodeCard(
          title: 'Adaptive (recommended)',
          code: 'CupertinoTextField(\n'
              '  magnifierConfiguration:\n'
              '      TextMagnifierConfiguration\n'
              '          .adaptiveMagnifierConfiguration,\n'
              ')',
        ),
        const SizedBox(height: 12.0),
        const _CodeCard(
          title: 'Custom builder',
          code: 'TextMagnifierConfiguration(\n'
              '  magnifierBuilder: (ctx, ctrl, info) =>\n'
              '      CupertinoTextMagnifier(\n'
              '        controller: ctrl,\n'
              '        magnifierInfo: info!,\n'
              '      ),\n'
              ')',
        ),
      ],
    );
  }
}

class _CodeCard extends StatelessWidget {
  final String title;
  final String code;

  const _CodeCard({required this.title, required this.code});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFF0F172A), Color(0xFF1F2937)],
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: const Color(0xFF374151), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: const BoxDecoration(
              color: Color(0xFF1F2937),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14.0),
                topRight: Radius.circular(14.0),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEF4444),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6.0),
                Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF59E0B),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6.0),
                Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: const BoxDecoration(
                    color: Color(0xFF10B981),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 14.0),
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'CupertinoSystemText',
                    color: Color(0xFFE5E7EB),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Text(
              code,
              style: const TextStyle(
                fontFamily: 'Menlo',
                fontSize: 12.0,
                color: Color(0xFFE0F2FE),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// FOOTER
// ---------------------------------------------------------------------------

class _FooterStamp extends StatelessWidget {
  const _FooterStamp();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFF111827), Color(0xFF0F172A)],
        ),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFF1F2937), width: 1.0),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 44.0,
            height: 44.0,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: const Color(0xFFFFFFFF).withValues(alpha: 0.18),
                width: 1.0,
              ),
            ),
            child: const Icon(
              CupertinoIcons.search_circle_fill,
              color: Color(0xFFE5E7EB),
              size: 24.0,
            ),
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'CupertinoTextMagnifier — visual deep demo',
                  style: TextStyle(
                    fontFamily: 'CupertinoSystemText',
                    color: Color(0xFFFFFFFF),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Static snapshot. No animations, no async, no assets. '
                  'Flutter SDK >= 3.27 (uses Color.withValues).',
                  style: TextStyle(
                    fontFamily: 'CupertinoSystemText',
                    color: const Color(0xFFFFFFFF).withValues(alpha: 0.7),
                    fontSize: 11.5,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: const Color(0xFF10B981).withValues(alpha: 0.6),
                width: 1.0,
              ),
            ),
            child: const Text(
              'v1.0',
              style: TextStyle(
                fontFamily: 'Menlo',
                color: Color(0xFFA7F3D0),
                fontSize: 11.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

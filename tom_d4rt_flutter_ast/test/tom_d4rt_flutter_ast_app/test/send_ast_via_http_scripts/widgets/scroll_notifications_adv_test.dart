// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true),
    home: Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 60),
          child: Column(children: const <Widget>[
            _HeroCard(),
            SizedBox(height: 22),
            _SectionHeader(
              index: 1,
              title: 'Notification class hierarchy',
              subtitle: 'How ScrollNotification fits in the Notification tree',
              accent: Color(0xFF3F51B5),
            ),
            SizedBox(height: 14),
            _HierarchyTree(),
            SizedBox(height: 26),
            _SectionHeader(
              index: 2,
              title: 'Lifecycle timeline',
              subtitle: 'idle -> start -> update.. -> end',
              accent: Color(0xFF009688),
            ),
            SizedBox(height: 14),
            _LifecycleTimeline(),
            SizedBox(height: 26),
            _SectionHeader(
              index: 3,
              title: 'ScrollMetrics anatomy',
              subtitle: 'pixels, extents, viewport, axis, direction',
              accent: Color(0xFFE91E63),
            ),
            SizedBox(height: 14),
            _MetricsAnatomyCard(),
            SizedBox(height: 26),
            _SectionHeader(
              index: 4,
              title: 'OverscrollNotification',
              subtitle: 'When users drag past the edge',
              accent: Color(0xFFFF7043),
            ),
            SizedBox(height: 14),
            _OverscrollCard(),
            SizedBox(height: 26),
            _SectionHeader(
              index: 5,
              title: 'UserScrollNotification',
              subtitle: 'Direction: forward, reverse, idle',
              accent: Color(0xFF7E57C2),
            ),
            SizedBox(height: 14),
            _UserScrollCard(),
            SizedBox(height: 26),
            _SectionHeader(
              index: 6,
              title: 'NotificationListener pattern',
              subtitle: 'How you actually consume ScrollNotification',
              accent: Color(0xFF455A64),
            ),
            SizedBox(height: 14),
            _CodeBlock(),
            SizedBox(height: 26),
            _SectionHeader(
              index: 7,
              title: 'Bubbling-up behavior',
              subtitle: 'return true stops propagation, false bubbles',
              accent: Color(0xFF2E7D32),
            ),
            SizedBox(height: 14),
            _BubblingDiagram(),
            SizedBox(height: 26),
            _SectionHeader(
              index: 8,
              title: 'Common use cases',
              subtitle: 'What people actually build with these',
              accent: Color(0xFF1976D2),
            ),
            SizedBox(height: 14),
            _UseCaseGrid(),
            SizedBox(height: 26),
            _SectionHeader(
              index: 9,
              title: 'Pitfalls',
              subtitle: 'Where ScrollNotification stings developers',
              accent: Color(0xFFC62828),
            ),
            SizedBox(height: 14),
            _PitfallsCard(),
            SizedBox(height: 26),
            _SectionHeader(
              index: 10,
              title: 'Listener vs Controller vs Position',
              subtitle: 'Three different scroll observation strategies',
              accent: Color(0xFF6A1B9A),
            ),
            SizedBox(height: 14),
            _ComparisonTable(),
            SizedBox(height: 30),
            _Footer(),
          ]),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// HERO
// ---------------------------------------------------------------------------

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF1A237E),
            Color(0xFF3949AB),
            Color(0xFF5C6BC0),
          ],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF1A237E).withValues(alpha: 0.35),
            blurRadius: 22.0,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: <Widget>[
            Container(
              width: 56.0,
              height: 56.0,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withValues(alpha: 0.4), width: 1.5),
              ),
              child: const Icon(Icons.swap_vert_rounded, color: Colors.white, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFC107).withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'FLUTTER WIDGETS',
                      style: TextStyle(
                        color: Color(0xFF1A237E),
                        fontSize: 10.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'ScrollNotification',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w800,
                      height: 1.05,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Listening to the scroll lifecycle',
                    style: TextStyle(
                      color: Color(0xFFE8EAF6),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ]),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
            ),
            child: const Text(
              'ScrollNotification is the bubbling-up mechanism that lets ancestor widgets '
              'observe scroll activity originating from any descendant Scrollable, without '
              'needing a direct ScrollController reference. Six concrete subclasses describe '
              'the lifecycle: start, update, end, overscroll, user-direction, and metrics-change.',
              style: TextStyle(
                color: Color(0xFFE8EAF6),
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: const <Widget>[
              _HeroChip(text: 'ScrollStartNotification', color: Color(0xFF66BB6A)),
              _HeroChip(text: 'ScrollUpdateNotification', color: Color(0xFF42A5F5)),
              _HeroChip(text: 'ScrollEndNotification', color: Color(0xFFEF5350)),
              _HeroChip(text: 'OverscrollNotification', color: Color(0xFFFF7043)),
              _HeroChip(text: 'UserScrollNotification', color: Color(0xFFAB47BC)),
              _HeroChip(text: 'ScrollMetricsNotification', color: Color(0xFF26A69A)),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  final String text;
  final Color color;
  const _HeroChip({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.55), width: 1.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION HEADER
// ---------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  final int index;
  final String title;
  final String subtitle;
  final Color accent;
  const _SectionHeader({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 18, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E3EB)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF1A237E).withValues(alpha: 0.06),
            blurRadius: 8.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(children: <Widget>[
        Container(
          width: 42.0,
          height: 42.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[accent, accent.withValues(alpha: 0.55)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            '$index',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
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
                  color: Color(0xFF1A237E),
                  fontSize: 17.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF607D8B),
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 10.0,
          height: 28.0,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ]),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 1 — HIERARCHY TREE
// ---------------------------------------------------------------------------

class _HierarchyTree extends StatelessWidget {
  const _HierarchyTree();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E3EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Class hierarchy',
            style: TextStyle(
              color: Color(0xFF263238),
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: _TreeNode(
              label: 'Notification',
              color: Color(0xFF455A64),
              isRoot: true,
            ),
          ),
          const _TreeConnector(),
          Row(
            children: const <Widget>[
              Expanded(
                child: _TreeNode(
                  label: 'LayoutChangedNotification',
                  color: Color(0xFF8E24AA),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _TreeNode(
                  label: 'ScrollNotification (abstract)',
                  color: Color(0xFF1565C0),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            margin: const EdgeInsets.only(left: 20),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF1565C0).withValues(alpha: 0.4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                _LeafRow(label: 'ScrollStartNotification', color: Color(0xFF66BB6A)),
                _LeafRow(label: 'ScrollUpdateNotification', color: Color(0xFF42A5F5)),
                _LeafRow(label: 'ScrollEndNotification', color: Color(0xFFEF5350)),
                _LeafRow(label: 'OverscrollNotification', color: Color(0xFFFF7043)),
                _LeafRow(label: 'UserScrollNotification', color: Color(0xFFAB47BC)),
                _LeafRow(label: 'ScrollMetricsNotification', color: Color(0xFF26A69A)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFDE7),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFFBC02D).withValues(alpha: 0.5)),
            ),
            child: Row(children: const <Widget>[
              Icon(Icons.lightbulb_outline, color: Color(0xFFF57F17), size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'All six leaf classes inherit from ScrollNotification and carry a '
                  'ScrollMetrics snapshot. They differ only in supplementary data.',
                  style: TextStyle(
                    color: Color(0xFF6D4C00),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    height: 1.45,
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class _TreeNode extends StatelessWidget {
  final String label;
  final Color color;
  final bool isRoot;
  const _TreeNode({required this.label, required this.color, this.isRoot = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[color, color.withValues(alpha: 0.6)],
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 6.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: isRoot ? 14.0 : 12.0,
          fontWeight: FontWeight.w700,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

class _TreeConnector extends StatelessWidget {
  const _TreeConnector();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22.0,
      alignment: Alignment.center,
      child: Container(
        width: 2.0,
        height: 22.0,
        color: const Color(0xFFB0BEC5),
      ),
    );
  }
}

class _LeafRow extends StatelessWidget {
  final String label;
  final Color color;
  const _LeafRow({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: <Widget>[
        Container(
          width: 12.0,
          height: 12.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 14.0,
          height: 2.0,
          color: const Color(0xFF90A4AE),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF263238),
            fontSize: 13.0,
            fontWeight: FontWeight.w600,
            fontFamily: 'monospace',
          ),
        ),
      ]),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 2 — LIFECYCLE TIMELINE
// ---------------------------------------------------------------------------

class _LifecycleTimeline extends StatelessWidget {
  const _LifecycleTimeline();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E3EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'A typical drag sequence',
            style: TextStyle(
              color: Color(0xFF263238),
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 90.0,
            child: Stack(children: <Widget>[
              Positioned(
                left: 18.0,
                right: 18.0,
                top: 36.0,
                child: Container(
                  height: 4.0,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: <Color>[
                        Color(0xFF90A4AE),
                        Color(0xFF66BB6A),
                        Color(0xFF42A5F5),
                        Color(0xFF42A5F5),
                        Color(0xFFEF5350),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Positioned(
                left: 0.0,
                top: 0.0,
                child: _TimelineDot(
                  label: 'idle',
                  color: Color(0xFF90A4AE),
                  icon: Icons.pause_circle_outline,
                ),
              ),
              const Positioned(
                left: 70.0,
                top: 0.0,
                child: _TimelineDot(
                  label: 'start',
                  color: Color(0xFF66BB6A),
                  icon: Icons.play_arrow_rounded,
                ),
              ),
              const Positioned(
                left: 145.0,
                top: 0.0,
                child: _TimelineDot(
                  label: 'update',
                  color: Color(0xFF42A5F5),
                  icon: Icons.swap_vert,
                ),
              ),
              const Positioned(
                left: 220.0,
                top: 0.0,
                child: _TimelineDot(
                  label: 'update',
                  color: Color(0xFF42A5F5),
                  icon: Icons.swap_vert,
                ),
              ),
              const Positioned(
                left: 295.0,
                top: 0.0,
                child: _TimelineDot(
                  label: 'end',
                  color: Color(0xFFEF5350),
                  icon: Icons.stop_rounded,
                ),
              ),
            ]),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFE8EAF6),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF3F51B5).withValues(alpha: 0.25)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                _StepText(step: 1, text: 'ScrollStartNotification fires when a Scrollable begins moving.'),
                _StepText(step: 2, text: 'A run of ScrollUpdateNotifications fires per frame while pixels change.'),
                _StepText(step: 3, text: 'OverscrollNotification interleaves if drag goes past extents.'),
                _StepText(step: 4, text: 'ScrollEndNotification fires when motion settles to rest.'),
                _StepText(step: 5, text: 'UserScrollNotification fires when the active drag direction changes.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineDot extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;
  const _TimelineDot({required this.label, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[color, color.withValues(alpha: 0.55)],
          ),
          shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: color.withValues(alpha: 0.4),
              blurRadius: 8.0,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
      const SizedBox(height: 6),
      Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    ]);
  }
}

class _StepText extends StatelessWidget {
  final int step;
  final String text;
  const _StepText({required this.step, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 22.0,
            height: 22.0,
            decoration: BoxDecoration(
              color: const Color(0xFF3F51B5),
              borderRadius: BorderRadius.circular(11),
            ),
            alignment: Alignment.center,
            child: Text(
              '$step',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF263238),
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 3 — METRICS ANATOMY
// ---------------------------------------------------------------------------

class _MetricsAnatomyCard extends StatelessWidget {
  const _MetricsAnatomyCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E3EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'ScrollMetrics fields',
            style: TextStyle(
              color: Color(0xFF263238),
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Row(children: const <Widget>[
            Expanded(child: _MetricField(name: 'pixels', value: '500.0', color: Color(0xFFE91E63))),
            SizedBox(width: 10),
            Expanded(child: _MetricField(name: 'viewportDimension', value: '600.0', color: Color(0xFF1976D2))),
          ]),
          const SizedBox(height: 10),
          Row(children: const <Widget>[
            Expanded(child: _MetricField(name: 'minScrollExtent', value: '0.0', color: Color(0xFF66BB6A))),
            SizedBox(width: 10),
            Expanded(child: _MetricField(name: 'maxScrollExtent', value: '1000.0', color: Color(0xFFFF7043))),
          ]),
          const SizedBox(height: 10),
          Row(children: const <Widget>[
            Expanded(child: _MetricField(name: 'axis', value: 'Axis.vertical', color: Color(0xFF7E57C2))),
            SizedBox(width: 10),
            Expanded(child: _MetricField(name: 'axisDirection', value: 'AxisDirection.down', color: Color(0xFF26A69A))),
          ]),
          const SizedBox(height: 20),
          const _RulerDiagram(),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF3E5F5),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF8E24AA).withValues(alpha: 0.35)),
            ),
            child: Row(children: const <Widget>[
              Icon(Icons.info_outline, color: Color(0xFF6A1B9A), size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Every ScrollNotification carries a ScrollMetrics snapshot taken at the '
                  'moment the notification was dispatched.',
                  style: TextStyle(
                    color: Color(0xFF4A148C),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    height: 1.45,
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class _MetricField extends StatelessWidget {
  final String name;
  final String value;
  final Color color;
  const _MetricField({required this.name, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            style: TextStyle(
              color: color,
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF263238),
              fontSize: 13.0,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class _RulerDiagram extends StatelessWidget {
  const _RulerDiagram();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'pixels along extent',
          style: TextStyle(
            color: Color(0xFF607D8B),
            fontSize: 11.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 56.0,
          child: Stack(children: <Widget>[
            Positioned(
              left: 0.0,
              right: 0.0,
              top: 22.0,
              child: Container(
                height: 14.0,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: <Color>[Color(0xFFE0E0E0), Color(0xFFBDBDBD), Color(0xFFE0E0E0)],
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
            Positioned(
              left: 0.0,
              top: 22.0,
              child: Container(
                width: 4.0,
                height: 14.0,
                decoration: const BoxDecoration(
                  color: Color(0xFF66BB6A),
                ),
              ),
            ),
            Positioned(
              right: 0.0,
              top: 22.0,
              child: Container(
                width: 4.0,
                height: 14.0,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF7043),
                ),
              ),
            ),
            Positioned(
              left: 150.0,
              top: 18.0,
              child: Column(children: <Widget>[
                Container(
                  width: 14.0,
                  height: 22.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE91E63),
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: const Color(0xFFE91E63).withValues(alpha: 0.4),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            const Positioned(
              left: 0.0,
              top: 42.0,
              child: Text(
                '0.0\nmin',
                style: TextStyle(
                  color: Color(0xFF66BB6A),
                  fontSize: 9.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Positioned(
              left: 140.0,
              top: 42.0,
              child: Text(
                '500.0\npixels',
                style: TextStyle(
                  color: Color(0xFFE91E63),
                  fontSize: 9.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Positioned(
              right: 0.0,
              top: 42.0,
              child: Text(
                '1000.0\nmax',
                style: TextStyle(
                  color: Color(0xFFFF7043),
                  fontSize: 9.0,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ]),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 4 — OVERSCROLL CARD
// ---------------------------------------------------------------------------

class _OverscrollCard extends StatelessWidget {
  const _OverscrollCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E3EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Dragging past the edge',
            style: TextStyle(
              color: Color(0xFF263238),
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Row(children: const <Widget>[
            Expanded(
              child: _OverscrollPanel(
                title: 'Leading edge',
                description: 'User pulls down at top of list',
                overscroll: '-32.0',
                color: Color(0xFF42A5F5),
                arrow: Icons.arrow_upward_rounded,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _OverscrollPanel(
                title: 'Trailing edge',
                description: 'User pulls up at bottom of list',
                overscroll: '+48.0',
                color: Color(0xFFEF5350),
                arrow: Icons.arrow_downward_rounded,
              ),
            ),
          ]),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFF7043).withValues(alpha: 0.4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'OverscrollNotification.overscroll',
                  style: TextStyle(
                    color: Color(0xFFBF360C),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Signed magnitude of how far past the extent the drag tried to go. '
                  'Negative = leading, positive = trailing. Velocity field reports settle speed.',
                  style: TextStyle(
                    color: Color(0xFF5D4037),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
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

class _OverscrollPanel extends StatelessWidget {
  final String title;
  final String description;
  final String overscroll;
  final Color color;
  final IconData arrow;
  const _OverscrollPanel({
    required this.title,
    required this.description,
    required this.overscroll,
    required this.color,
    required this.arrow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: <Widget>[
            Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(arrow, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ]),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              color: Color(0xFF455A64),
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withValues(alpha: 0.5)),
            ),
            child: Text(
              'overscroll = $overscroll',
              style: TextStyle(
                color: color,
                fontSize: 12.0,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 5 — USER SCROLL CARD
// ---------------------------------------------------------------------------

class _UserScrollCard extends StatelessWidget {
  const _UserScrollCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E3EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Drag-direction signaling',
            style: TextStyle(
              color: Color(0xFF263238),
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Row(children: const <Widget>[
            Expanded(
              child: _DirectionBadge(
                label: 'forward',
                description: 'Scroll position increases',
                color: Color(0xFF66BB6A),
                icon: Icons.south_rounded,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _DirectionBadge(
                label: 'reverse',
                description: 'Scroll position decreases',
                color: Color(0xFFEF5350),
                icon: Icons.north_rounded,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _DirectionBadge(
                label: 'idle',
                description: 'No user-driven motion',
                color: Color(0xFF90A4AE),
                icon: Icons.pause_rounded,
              ),
            ),
          ]),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xFFEDE7F6), Color(0xFFD1C4E9)],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF7E57C2).withValues(alpha: 0.4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'UserScrollNotification.direction',
                  style: TextStyle(
                    color: Color(0xFF4527A0),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Distinguishes user drag vs ballistic settling. Use this to hide an app-bar '
                  'on forward drag (scrolling content down) and reveal on reverse.',
                  style: TextStyle(
                    color: Color(0xFF311B92),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
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

class _DirectionBadge extends StatelessWidget {
  final String label;
  final String description;
  final Color color;
  final IconData icon;
  const _DirectionBadge({
    required this.label,
    required this.description,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[color.withValues(alpha: 0.15), color.withValues(alpha: 0.04)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: color.withValues(alpha: 0.4),
                  blurRadius: 6.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 14.0,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              color: Color(0xFF455A64),
              fontSize: 11.0,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 6 — CODE BLOCK
// ---------------------------------------------------------------------------

class _CodeBlock extends StatelessWidget {
  const _CodeBlock();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF1E1E2E),
            Color(0xFF2A2D3E),
          ],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF1E1E2E).withValues(alpha: 0.35),
            blurRadius: 12.0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.25),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(children: <Widget>[
              Container(width: 12.0, height: 12.0, decoration: const BoxDecoration(color: Color(0xFFFF5F57), shape: BoxShape.circle)),
              const SizedBox(width: 6),
              Container(width: 12.0, height: 12.0, decoration: const BoxDecoration(color: Color(0xFFFEBC2E), shape: BoxShape.circle)),
              const SizedBox(width: 6),
              Container(width: 12.0, height: 12.0, decoration: const BoxDecoration(color: Color(0xFF28C840), shape: BoxShape.circle)),
              const SizedBox(width: 14),
              const Text(
                'scroll_listener.dart',
                style: TextStyle(
                  color: Color(0xFFB0BEC5),
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                _CodeLine(n: 1, code: 'NotificationListener<ScrollNotification>(', color: Color(0xFFCE9178)),
                _CodeLine(n: 2, code: '  onNotification: (notification) {', color: Color(0xFFD4D4D4)),
                _CodeLine(n: 3, code: '    if (notification is ScrollStartNotification) {', color: Color(0xFF569CD6)),
                _CodeLine(n: 4, code: '      // begin tracking drag', color: Color(0xFF6A9955)),
                _CodeLine(n: 5, code: '    } else if (notification is ScrollUpdateNotification) {', color: Color(0xFF569CD6)),
                _CodeLine(n: 6, code: '      final delta = notification.scrollDelta;', color: Color(0xFFD4D4D4)),
                _CodeLine(n: 7, code: '      final pixels = notification.metrics.pixels;', color: Color(0xFFD4D4D4)),
                _CodeLine(n: 8, code: '    } else if (notification is OverscrollNotification) {', color: Color(0xFF569CD6)),
                _CodeLine(n: 9, code: '      final amount = notification.overscroll;', color: Color(0xFFD4D4D4)),
                _CodeLine(n: 10, code: '    } else if (notification is UserScrollNotification) {', color: Color(0xFF569CD6)),
                _CodeLine(n: 11, code: '      final dir = notification.direction;', color: Color(0xFFD4D4D4)),
                _CodeLine(n: 12, code: '    } else if (notification is ScrollEndNotification) {', color: Color(0xFF569CD6)),
                _CodeLine(n: 13, code: '      // commit final position', color: Color(0xFF6A9955)),
                _CodeLine(n: 14, code: '    }', color: Color(0xFFD4D4D4)),
                _CodeLine(n: 15, code: '    return false; // let ancestors keep observing', color: Color(0xFF6A9955)),
                _CodeLine(n: 16, code: '  },', color: Color(0xFFD4D4D4)),
                _CodeLine(n: 17, code: '  child: ListView(children: items),', color: Color(0xFFD4D4D4)),
                _CodeLine(n: 18, code: ')', color: Color(0xFFCE9178)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeLine extends StatelessWidget {
  final int n;
  final String code;
  final Color color;
  const _CodeLine({required this.n, required this.code, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 24.0,
            child: Text(
              '$n',
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Color(0xFF6E7681),
                fontSize: 11.0,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              code,
              style: TextStyle(
                color: color,
                fontSize: 11.5,
                fontFamily: 'monospace',
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 7 — BUBBLING DIAGRAM
// ---------------------------------------------------------------------------

class _BubblingDiagram extends StatelessWidget {
  const _BubblingDiagram();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E3EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Notification travels up the widget tree',
            style: TextStyle(
              color: Color(0xFF263238),
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          const _BubblingLevel(
            label: 'MaterialApp',
            depth: 0,
            color: Color(0xFF1A237E),
            note: 'Outermost listener',
          ),
          const _ArrowUp(text: 'bubble up'),
          const _BubblingLevel(
            label: 'Scaffold > NotificationListener (outer)',
            depth: 1,
            color: Color(0xFF3949AB),
            note: 'Receives if inner returns false',
          ),
          const _ArrowUp(text: 'bubble up'),
          const _BubblingLevel(
            label: 'Column > NotificationListener (inner)',
            depth: 2,
            color: Color(0xFF5C6BC0),
            note: 'return true here -> stops here',
          ),
          const _ArrowUp(text: 'bubble up'),
          const _BubblingLevel(
            label: 'ListView (Scrollable)',
            depth: 3,
            color: Color(0xFF7986CB),
            note: 'Origin of notification',
          ),
          const SizedBox(height: 16),
          Row(children: const <Widget>[
            Expanded(
              child: _BubbleLegend(
                text: 'return true',
                description: 'absorbs',
                color: Color(0xFFC62828),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _BubbleLegend(
                text: 'return false',
                description: 'bubbles further',
                color: Color(0xFF2E7D32),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

class _BubblingLevel extends StatelessWidget {
  final String label;
  final int depth;
  final Color color;
  final String note;
  const _BubblingLevel({
    required this.label,
    required this.depth,
    required this.color,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[color.withValues(alpha: 0.16), color.withValues(alpha: 0.04)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(children: <Widget>[
        Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            'd=$depth',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11.0,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 2),
              Text(
                note,
                style: const TextStyle(
                  color: Color(0xFF607D8B),
                  fontSize: 11.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class _ArrowUp extends StatelessWidget {
  final String text;
  const _ArrowUp({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: <Widget>[
        const SizedBox(width: 18),
        Container(
          width: 2.0,
          height: 20.0,
          color: const Color(0xFF90A4AE),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.arrow_upward_rounded, color: Color(0xFF607D8B), size: 16),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            color: Color(0xFF607D8B),
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
          ),
        ),
      ]),
    );
  }
}

class _BubbleLegend extends StatelessWidget {
  final String text;
  final String description;
  final Color color;
  const _BubbleLegend({required this.text, required this.description, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12.0,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 2),
          Text(
            description,
            style: const TextStyle(
              color: Color(0xFF455A64),
              fontSize: 11.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 8 — USE CASES
// ---------------------------------------------------------------------------

class _UseCaseGrid extends StatelessWidget {
  const _UseCaseGrid();

  @override
  Widget build(BuildContext context) {
    return Column(children: const <Widget>[
      Row(children: <Widget>[
        Expanded(
          child: _UseCaseCard(
            icon: Icons.refresh_rounded,
            title: 'Pull-to-refresh',
            description:
                'Detect OverscrollNotification at leading edge plus a release point to trigger reload.',
            color: Color(0xFF2196F3),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _UseCaseCard(
            icon: Icons.push_pin_outlined,
            title: 'Sticky header',
            description:
                'Watch ScrollUpdateNotification.metrics.pixels to pin a header once a threshold is crossed.',
            color: Color(0xFF4CAF50),
          ),
        ),
      ]),
      SizedBox(height: 12),
      Row(children: <Widget>[
        Expanded(
          child: _UseCaseCard(
            icon: Icons.visibility_off_outlined,
            title: 'Fading app-bar',
            description:
                'Use UserScrollNotification.direction to hide on forward, reveal on reverse drag.',
            color: Color(0xFFFF9800),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _UseCaseCard(
            icon: Icons.cloud_download_outlined,
            title: 'Infinite scroll',
            description:
                'When pixels >= maxScrollExtent - threshold inside ScrollUpdate, fetch the next page.',
            color: Color(0xFF9C27B0),
          ),
        ),
      ]),
    ]);
  }
}

class _UseCaseCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  const _UseCaseCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE0E3EB)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 42.0,
            height: 42.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[color, color.withValues(alpha: 0.6)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF263238),
              fontSize: 14.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(
              color: Color(0xFF607D8B),
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 9 — PITFALLS
// ---------------------------------------------------------------------------

class _PitfallsCard extends StatelessWidget {
  const _PitfallsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E3EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'Things to watch out for',
            style: TextStyle(
              color: Color(0xFF263238),
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 14),
          _PitfallBullet(
            number: 1,
            title: 'Return value semantics inverted',
            text: 'return true STOPS bubbling, return false lets it bubble. Easy to flip.',
          ),
          _PitfallBullet(
            number: 2,
            title: 'Depth filtering forgotten',
            text: 'Nested Scrollables produce notifications at different depths. Filter via notification.depth.',
          ),
          _PitfallBullet(
            number: 3,
            title: 'Listener overhead at 120fps',
            text: 'onNotification runs on every frame during a drag. Avoid heavy work or expensive isinstance branches.',
          ),
          _PitfallBullet(
            number: 4,
            title: 'setState in onNotification',
            text: 'Triggering rebuild on every ScrollUpdateNotification is a common cause of jank. Use ValueNotifier instead.',
          ),
          _PitfallBullet(
            number: 5,
            title: 'OverscrollIndicatorNotification confusion',
            text: 'That is a separate notification type for suppressing the glow. It is not part of the scroll lifecycle proper.',
          ),
        ],
      ),
    );
  }
}

class _PitfallBullet extends StatelessWidget {
  final int number;
  final String title;
  final String text;
  const _PitfallBullet({required this.number, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 28.0,
            height: 28.0,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xFFEF5350), Color(0xFFC62828)],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              '$number',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFFB71C1C),
                    fontSize: 13.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  text,
                  style: const TextStyle(
                    color: Color(0xFF455A64),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
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

// ---------------------------------------------------------------------------
// SECTION 10 — COMPARISON TABLE
// ---------------------------------------------------------------------------

class _ComparisonTable extends StatelessWidget {
  const _ComparisonTable();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E3EB)),
      ),
      child: Column(children: const <Widget>[
        _TableHeaderRow(),
        _TableRow(
          aspect: 'Coupling',
          listener: 'Decoupled (ancestor)',
          controller: 'Tight (attached)',
          position: 'Internal (per-scrollable)',
          alt: false,
        ),
        _TableRow(
          aspect: 'Reach',
          listener: 'All descendants',
          controller: 'Single scrollable',
          position: 'Single scrollable',
          alt: true,
        ),
        _TableRow(
          aspect: 'Lifecycle data',
          listener: 'Discrete events',
          controller: 'Polled .offset',
          position: 'Polled .pixels',
          alt: false,
        ),
        _TableRow(
          aspect: 'Setup cost',
          listener: 'Zero (wrap)',
          controller: 'Construct + dispose',
          position: 'Implicit via Scrollable',
          alt: true,
        ),
        _TableRow(
          aspect: 'Use for',
          listener: 'Sticky / fade / pull',
          controller: 'animateTo / jumpTo',
          position: 'Custom physics',
          alt: false,
        ),
        _TableRow(
          aspect: 'Direction info',
          listener: 'UserScrollNotification',
          controller: 'Manual via offset diff',
          position: 'userScrollDirection',
          alt: true,
        ),
      ]),
    );
  }
}

class _TableHeaderRow extends StatelessWidget {
  const _TableHeaderRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFF6A1B9A), Color(0xFFAB47BC)],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Row(children: const <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            'Aspect',
            style: TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.w800),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'NotificationListener',
            style: TextStyle(color: Colors.white, fontSize: 11.0, fontWeight: FontWeight.w800),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'ScrollController',
            style: TextStyle(color: Colors.white, fontSize: 11.0, fontWeight: FontWeight.w800),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'ScrollPosition',
            style: TextStyle(color: Colors.white, fontSize: 11.0, fontWeight: FontWeight.w800),
          ),
        ),
      ]),
    );
  }
}

class _TableRow extends StatelessWidget {
  final String aspect;
  final String listener;
  final String controller;
  final String position;
  final bool alt;
  const _TableRow({
    required this.aspect,
    required this.listener,
    required this.controller,
    required this.position,
    required this.alt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: alt ? const Color(0xFFFAFAFA) : Colors.white,
        border: const Border(
          bottom: BorderSide(color: Color(0xFFE0E0E0), width: 0.5),
        ),
      ),
      child: Row(children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            aspect,
            style: const TextStyle(
              color: Color(0xFF6A1B9A),
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            listener,
            style: const TextStyle(
              color: Color(0xFF263238),
              fontSize: 11.0,
              fontWeight: FontWeight.w500,
              height: 1.35,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            controller,
            style: const TextStyle(
              color: Color(0xFF263238),
              fontSize: 11.0,
              fontWeight: FontWeight.w500,
              height: 1.35,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            position,
            style: const TextStyle(
              color: Color(0xFF263238),
              fontSize: 11.0,
              fontWeight: FontWeight.w500,
              height: 1.35,
            ),
          ),
        ),
      ]),
    );
  }
}

// ---------------------------------------------------------------------------
// FOOTER
// ---------------------------------------------------------------------------

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFF263238), Color(0xFF455A64)],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Container(
            width: 30.0,
            height: 30.0,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.swap_vert_rounded, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 10),
          const Text(
            'ScrollNotification — Visual Deep Demo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ]),
        const SizedBox(height: 8),
        const Text(
          'package:flutter/widgets.dart  |  static snapshot  |  v1.0',
          style: TextStyle(
            color: Color(0xFFB0BEC5),
            fontSize: 10.5,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.4,
          ),
        ),
      ]),
    );
  }
}

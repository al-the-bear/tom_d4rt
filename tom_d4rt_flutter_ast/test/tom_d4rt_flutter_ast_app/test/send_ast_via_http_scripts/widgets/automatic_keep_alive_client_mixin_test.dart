// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// =====================================================================
//  AutomaticKeepAliveClientMixin<T> — Static Visual Walkthrough
// ---------------------------------------------------------------------
//  This file is a fully STATIC, hand-authored visual walk-through of
//  the AutomaticKeepAliveClientMixin<T> mixin. The mixin is applied to
//  a State<T extends StatefulWidget> in order to keep that state alive
//  even when its parent widget (commonly a lazy list, page view, or
//  tab view) would otherwise dispose it for performance reasons.
//
//  Because this demo is rendered through a single build() pass with no
//  live frame pump, it does NOT host any real StatefulWidget, animation
//  controller, page controller, scroll controller, async future, or
//  setState call. Instead, every visual is a stateless mock-up that
//  shows what the user WOULD observe if state preservation were active.
//
//  Top-level rules followed:
//
//    * Only `package:flutter/material.dart` is imported.
//    * The entry point is a top-level `dynamic build(BuildContext)`.
//    * No StatefulWidget anywhere — every authored widget is Stateless.
//    * No timers, futures, controllers, or setState — every state
//      snapshot is a baked-in literal.
//    * `dart analyze` passes cleanly with zero issues.
//
//  The mixin contract in plain words:
//
//    1. Mix `AutomaticKeepAliveClientMixin` into a `State<T>`.
//    2. Override `bool get wantKeepAlive` and decide when to keep alive.
//    3. In `build`, call `super.build(context)` first — this registers
//       the keep-alive request with the closest AutomaticKeepAlive
//       ancestor (provided automatically by lazy parents like ListView,
//       PageView, GridView, and TabBarView when their
//       `addAutomaticKeepAlives` flag is true, which is the default).
//    4. If `wantKeepAlive` ever changes value at runtime, call
//       `updateKeepAlive()` so the framework picks up the new value.
// =====================================================================

dynamic build(BuildContext context) {
  print('=== AutomaticKeepAliveClientMixin Static Demo ===');
  return MaterialApp(
    title: 'AutomaticKeepAliveClientMixin Static Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: const Color(0xFFF5F6FB),
    ),
    home: const _KeepAliveDemoHome(),
  );
}

// =====================================================================
//  Top-level home page
// =====================================================================

class _KeepAliveDemoHome extends StatelessWidget {
  const _KeepAliveDemoHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AutomaticKeepAliveClientMixin'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              _HeroCard(),
              SizedBox(height: 24),
              _SectionTitle('1. The contract — anatomy of a keep-alive State'),
              _ContractAnatomySection(),
              SizedBox(height: 24),
              _SectionTitle('2. Lifecycle WITHOUT the mixin'),
              _WithoutMixinLifecycleSection(),
              SizedBox(height: 24),
              _SectionTitle('3. Lifecycle WITH the mixin'),
              _WithMixinLifecycleSection(),
              SizedBox(height: 24),
              _SectionTitle('4. Minimal code recipe'),
              _MinimalCodeSection(),
              SizedBox(height: 24),
              _SectionTitle('5. Use case A — PageView with kept counters'),
              _PageViewMockSection(),
              SizedBox(height: 24),
              _SectionTitle('6. Use case B — TabBarView with preserved forms'),
              _TabFormMockSection(),
              SizedBox(height: 24),
              _SectionTitle('7. Use case C — Sliver list sparse keep-alive'),
              _SparseSkylineSection(),
              SizedBox(height: 24),
              _SectionTitle('8. Use case D — Conditional wantKeepAlive'),
              _ConditionalSection(),
              SizedBox(height: 24),
              _SectionTitle('9. The super.build(context) rule'),
              _SuperBuildSection(),
              SizedBox(height: 24),
              _SectionTitle('10. Common pitfalls'),
              _PitfallsSection(),
              SizedBox(height: 24),
              _SectionTitle('11. When NOT to use the mixin'),
              _WhenNotToUseSection(),
              SizedBox(height: 24),
              _SectionTitle('12. Reference table'),
              _ReferenceTableSection(),
              SizedBox(height: 32),
              _FooterCard(),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
//  Shared layout helpers
// =====================================================================

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 6,
            height: 28,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.indigo.shade400,
                  Colors.indigo.shade800,
                ],
              ),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Caption extends StatelessWidget {
  final String text;
  const _Caption(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade800,
          height: 1.45,
        ),
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  final String code;
  const _CodeBlock(this.code);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            offset: const Offset(0, 3),
            blurRadius: 8,
          ),
        ],
        border: Border.all(color: Colors.grey.shade700, width: 1),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          color: Colors.greenAccent,
          fontSize: 13,
          height: 1.45,
        ),
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;
  const _BulletPoint(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 6, right: 10),
            child: Icon(
              Icons.circle,
              size: 8,
              color: Colors.indigo.shade500,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, height: 1.45),
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientCard extends StatelessWidget {
  final List<Color> colors;
  final Widget child;

  const _GradientCard({
    required this.colors,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colors.last.withOpacity(0.35),
            offset: const Offset(0, 6),
            blurRadius: 14,
          ),
        ],
      ),
      child: child,
    );
  }
}

class _PlainCard extends StatelessWidget {
  final Widget child;
  const _PlainCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: child,
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  final Color color;
  final IconData? icon;
  const _Pill({required this.text, required this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 5),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _Chevron extends StatelessWidget {
  const _Chevron();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Icon(
        Icons.chevron_right,
        size: 24,
        color: Colors.grey.shade500,
      ),
    );
  }
}

class _DownArrow extends StatelessWidget {
  const _DownArrow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Icon(
        Icons.arrow_downward,
        size: 22,
        color: Colors.grey.shade500,
      ),
    );
  }
}

// =====================================================================
//  Hero card
// =====================================================================

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Colors.indigo.shade900,
            Colors.deepPurple.shade700,
            Colors.purple.shade400,
          ],
          stops: const <double>[0.0, 0.5, 1.0],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.indigo.shade900.withOpacity(0.35),
            offset: const Offset(0, 10),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.layers,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Text(
                  'AutomaticKeepAliveClientMixin<T>',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Mix into a State<T> to opt out of disposal by lazy parents '
            '(PageView, ListView, SliverList, TabBarView, NestedScrollView). '
            'Override wantKeepAlive and call super.build(context) first.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: const <Widget>[
              _Pill(
                text: 'static demo',
                color: Colors.white,
                icon: Icons.image,
              ),
              _Pill(
                text: 'no live state',
                color: Colors.white,
                icon: Icons.bolt,
              ),
              _Pill(
                text: 'concept-only',
                color: Colors.white,
                icon: Icons.menu_book,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.22),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white.withOpacity(0.18)),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.info_outline, color: Colors.white70, size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Disclaimer: this is a static walkthrough rendered through '
                    'a single build pass. Sample tiles show baked-in literal '
                    'values that depict what kept-alive State would look like.',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Colors.white70,
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

// =====================================================================
//  Section 1 — Anatomy of a keep-alive State
// =====================================================================

class _ContractAnatomySection extends StatelessWidget {
  const _ContractAnatomySection();

  @override
  Widget build(BuildContext context) {
    return _PlainCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _Caption(
            'The mixin is a thin protocol layered on top of State<T>. It '
            'expects four things to be in place: the State subclass, the '
            'mixin declaration, the wantKeepAlive getter, and the call to '
            'super.build(context) inside build. Each piece participates '
            'in a small handshake with the closest AutomaticKeepAlive '
            'ancestor inserted by the lazy parent.',
          ),
          const SizedBox(height: 4),
          const _AnatomyDiagram(),
          const SizedBox(height: 12),
          const _Caption(
            'When build runs, super.build(context) walks up to the nearest '
            'AutomaticKeepAlive and either subscribes (wantKeepAlive=true) '
            'or unsubscribes. The lazy parent then asks each kept-alive '
            'subscriber whether it still wants to live before recycling.',
          ),
          const SizedBox(height: 8),
          const _ProtocolSequence(),
        ],
      ),
    );
  }
}

class _AnatomyDiagram extends StatelessWidget {
  const _AnatomyDiagram();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Colors.indigo.shade50,
            Colors.deepPurple.shade50,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.indigo.shade200),
      ),
      child: Column(
        children: <Widget>[
          _AnatomyRow(
            badge: 'class',
            label: 'class _MyState',
            sub: 'extends State<MyWidget>',
            color: Colors.blue.shade700,
            icon: Icons.code,
          ),
          const _DownArrow(),
          _AnatomyRow(
            badge: 'mixin',
            label: 'with AutomaticKeepAliveClientMixin<MyWidget>',
            sub: 'adds the keep-alive protocol',
            color: Colors.deepPurple.shade600,
            icon: Icons.extension,
          ),
          const _DownArrow(),
          _AnatomyRow(
            badge: 'getter',
            label: 'bool get wantKeepAlive => true;',
            sub: 'returns the desired keep-alive policy',
            color: Colors.teal.shade700,
            icon: Icons.toggle_on,
          ),
          const _DownArrow(),
          _AnatomyRow(
            badge: 'build',
            label: 'super.build(context); // FIRST line',
            sub: 'registers with the AutomaticKeepAlive ancestor',
            color: Colors.orange.shade800,
            icon: Icons.build_circle,
          ),
          const _DownArrow(),
          _AnatomyRow(
            badge: 'parent',
            label: 'AutomaticKeepAlive (inserted by ListView/PageView)',
            sub: 'asks each subscriber whether to keep alive',
            color: Colors.green.shade700,
            icon: Icons.account_tree,
          ),
        ],
      ),
    );
  }
}

class _AnatomyRow extends StatelessWidget {
  final String badge;
  final String label;
  final String sub;
  final Color color;
  final IconData icon;

  const _AnatomyRow({
    required this.badge,
    required this.label,
    required this.sub,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.4)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withOpacity(0.15),
            offset: const Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 70,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.18),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: color),
            ),
            child: Text(
              badge,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  sub,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
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

class _ProtocolSequence extends StatelessWidget {
  const _ProtocolSequence();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.handshake, color: Colors.indigo.shade600, size: 18),
              const SizedBox(width: 6),
              const Text(
                'Handshake order',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: const <Widget>[
              _Pill(
                text: '1. mount',
                color: Colors.blue,
                icon: Icons.flag,
              ),
              _Chevron(),
              _Pill(
                text: '2. build',
                color: Colors.indigo,
                icon: Icons.layers,
              ),
              _Chevron(),
              _Pill(
                text: '3. subscribe',
                color: Colors.teal,
                icon: Icons.link,
              ),
              _Chevron(),
              _Pill(
                text: '4. survive',
                color: Colors.green,
                icon: Icons.shield,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =====================================================================
//  Section 2 — Lifecycle WITHOUT the mixin
// =====================================================================

class _WithoutMixinLifecycleSection extends StatelessWidget {
  const _WithoutMixinLifecycleSection();

  @override
  Widget build(BuildContext context) {
    return _PlainCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _Caption(
            'Without the mixin, the State subtree of a lazy parent is '
            'disposed when its index leaves the cache extent. When the '
            'user scrolls back, a fresh State() is constructed and '
            'initState() runs again — every counter, scroll offset, '
            'animation phase, and form input resets to its default.',
          ),
          const SizedBox(height: 8),
          const _LifecycleStrip(
            label: 'Default disposal sequence',
            startColor: Color(0xFFEF5350),
            endColor: Color(0xFFFF8A65),
            steps: <_LifecycleStep>[
              _LifecycleStep('on screen', 'tap count: 7', Icons.visibility),
              _LifecycleStep('scroll out', 'about to leave cache', Icons.swap_horiz),
              _LifecycleStep('disposed', 'dispose() called', Icons.delete_forever),
              _LifecycleStep('returns', 'tap count: 0', Icons.refresh),
            ],
          ),
          const SizedBox(height: 12),
          const _Caption(
            'The visible failure mode: a user who typed three characters '
            'into a TextField on page 4 swipes to page 0 and back, then '
            'finds the field empty. The bug report says "the app forgets '
            'what I typed" — the underlying cause is unwanted disposal.',
          ),
          const SizedBox(height: 6),
          const _SampleTileFreshState(),
        ],
      ),
    );
  }
}

class _LifecycleStep {
  final String label;
  final String detail;
  final IconData icon;
  const _LifecycleStep(this.label, this.detail, this.icon);
}

class _LifecycleStrip extends StatelessWidget {
  final String label;
  final Color startColor;
  final Color endColor;
  final List<_LifecycleStep> steps;

  const _LifecycleStrip({
    required this.label,
    required this.startColor,
    required this.endColor,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            startColor.withOpacity(0.12),
            endColor.withOpacity(0.18),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: endColor.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: endColor.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final List<Widget> tiles = <Widget>[];
              for (int i = 0; i < steps.length; i++) {
                tiles.add(Expanded(child: _LifecycleTile(step: steps[i], color: endColor)));
                if (i < steps.length - 1) {
                  tiles.add(const _Chevron());
                }
              }
              return Row(children: tiles);
            },
          ),
        ],
      ),
    );
  }
}

class _LifecycleTile extends StatelessWidget {
  final _LifecycleStep step;
  final Color color;
  const _LifecycleTile({required this.step, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withOpacity(0.18),
            offset: const Offset(0, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Icon(step.icon, color: color, size: 22),
          const SizedBox(height: 6),
          Text(
            step.label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: color,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            step.detail,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.5,
              color: Colors.grey.shade700,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _SampleTileFreshState extends StatelessWidget {
  const _SampleTileFreshState();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.refresh, color: Colors.red.shade700),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'After scroll-back: state reset',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Counter: 0   |   Form input: ""   |   Scroll: 0px',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    color: Colors.red.shade800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'All ephemeral state was lost when the parent called dispose().',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red.shade700,
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
//  Section 3 — Lifecycle WITH the mixin
// =====================================================================

class _WithMixinLifecycleSection extends StatelessWidget {
  const _WithMixinLifecycleSection();

  @override
  Widget build(BuildContext context) {
    return _PlainCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _Caption(
            'With AutomaticKeepAliveClientMixin and wantKeepAlive=true the '
            'parent skips disposal: the State remains in memory while the '
            'subtree is parked off-screen, and re-entering the viewport '
            'returns the same instance with all of its private state '
            'intact. The user perceives "the page remembers me".',
          ),
          const SizedBox(height: 8),
          const _LifecycleStrip(
            label: 'Kept-alive sequence',
            startColor: Color(0xFF26A69A),
            endColor: Color(0xFF66BB6A),
            steps: <_LifecycleStep>[
              _LifecycleStep('on screen', 'tap count: 7', Icons.visibility),
              _LifecycleStep('scroll out', 'parked, not disposed', Icons.pause_circle),
              _LifecycleStep('kept', 'State retained in memory', Icons.shield),
              _LifecycleStep('returns', 'tap count: 7', Icons.check_circle),
            ],
          ),
          const SizedBox(height: 12),
          const _SampleTilePreservedState(),
          const SizedBox(height: 8),
          const _Caption(
            'The cost of keep-alive is real: the State subtree continues '
            'to occupy memory and may continue to receive notifications '
            'from controllers and streams it still subscribes to. Use it '
            'where the cost is justified by the user-perceptible benefit.',
          ),
        ],
      ),
    );
  }
}

class _SampleTilePreservedState extends StatelessWidget {
  const _SampleTilePreservedState();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.green.shade100.withOpacity(0.6),
            offset: const Offset(0, 3),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check_circle, color: Colors.green.shade700),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'After scroll-back: state preserved',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Counter: 7   |   Form input: "hello"   |   Scroll: 240px',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    color: Colors.green.shade900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'The same State instance survived because wantKeepAlive returned true.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green.shade800,
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
//  Section 4 — Minimal code recipe
// =====================================================================

class _MinimalCodeSection extends StatelessWidget {
  const _MinimalCodeSection();

  @override
  Widget build(BuildContext context) {
    return _PlainCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _Caption(
            'The smallest correct usage. Note four invariants: a private '
            'State class, the with-clause naming the mixin (with the same '
            'StatefulWidget type argument), the wantKeepAlive override, '
            'and super.build(context) as the very first call inside build.',
          ),
          _CodeBlock(
            'class CounterTab extends StatefulWidget {\n'
            '  const CounterTab({super.key});\n'
            '\n'
            '  @override\n'
            '  State<CounterTab> createState() => _CounterTabState();\n'
            '}\n'
            '\n'
            'class _CounterTabState extends State<CounterTab>\n'
            '    with AutomaticKeepAliveClientMixin<CounterTab> {\n'
            '  int _count = 0;\n'
            '\n'
            '  @override\n'
            '  bool get wantKeepAlive => true;\n'
            '\n'
            '  @override\n'
            '  Widget build(BuildContext context) {\n'
            '    super.build(context); // MUST be first\n'
            '    return ElevatedButton(\n'
            '      onPressed: () => setState(() => _count++),\n'
            '      child: Text("count: \$_count"),\n'
            '    );\n'
            '  }\n'
            '}',
          ),
          SizedBox(height: 8),
          _CodeBlock(
            '// Hosting parent — addAutomaticKeepAlives defaults to true.\n'
            'PageView(\n'
            '  children: const <Widget>[\n'
            '    CounterTab(),\n'
            '    CounterTab(),\n'
            '    CounterTab(),\n'
            '  ],\n'
            ');',
          ),
        ],
      ),
    );
  }
}

// =====================================================================
//  Section 5 — PageView with kept counters (mock)
// =====================================================================

class _PageViewMockSection extends StatelessWidget {
  const _PageViewMockSection();

  @override
  Widget build(BuildContext context) {
    return _PlainCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _Caption(
            'The PageView is the textbook case. Each page hosts a tiny '
            'counter. Without keep-alive, swiping back and forth resets '
            'every counter to zero. With keep-alive, the counters retain '
            'their values. Below is a side-by-side mock of the three '
            'pages as the user would see them after some interaction.',
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: _MockPageTile(
                  pageIndex: 0,
                  title: 'Inbox',
                  count: 12,
                  scroll: 80.0,
                  accent: Colors.indigo,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MockPageTile(
                  pageIndex: 1,
                  title: 'Today',
                  count: 5,
                  scroll: 0.0,
                  accent: Colors.teal,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MockPageTile(
                  pageIndex: 2,
                  title: 'Drafts',
                  count: 3,
                  scroll: 220.0,
                  accent: Colors.deepOrange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.swipe, color: Colors.indigo.shade700),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Swiping between pages would normally tear down the '
                    'off-screen children. The mixin keeps each page state '
                    'in memory so the user sees their counts preserved.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.indigo.shade900,
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

class _MockPageTile extends StatelessWidget {
  final int pageIndex;
  final String title;
  final int count;
  final double scroll;
  final MaterialColor accent;

  const _MockPageTile({
    required this.pageIndex,
    required this.title,
    required this.count,
    required this.scroll,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            accent.shade400,
            accent.shade700,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.shade300.withOpacity(0.5),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'page $pageIndex',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Text(
            'tap count',
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 11,
            ),
          ),
          Text(
            '$count',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.25),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'scroll: ${scroll.toStringAsFixed(0)}px',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
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
//  Section 6 — TabBarView with preserved forms (mock)
// =====================================================================

class _TabFormMockSection extends StatelessWidget {
  const _TabFormMockSection();

  @override
  Widget build(BuildContext context) {
    return _PlainCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _Caption(
            'TabBarView shares the lazy semantics of PageView. A multi-'
            'step form spread across tabs becomes infuriating without '
            'keep-alive: switching tabs wipes every input. Below is the '
            'mock-up of three tabs after the user has typed into them. '
            'Each tab keeps its TextField content intact when the user '
            'returns.',
          ),
          const SizedBox(height: 10),
          _MockTabBar(),
          const SizedBox(height: 14),
          const _MockFormTile(
            tab: 'Profile',
            fields: <_MockField>[
              _MockField('Name', 'Alex Morgan'),
              _MockField('Email', 'alex@example.com'),
              _MockField('Phone', '+1 555 0101'),
            ],
            color: Colors.indigo,
          ),
          const SizedBox(height: 10),
          const _MockFormTile(
            tab: 'Address',
            fields: <_MockField>[
              _MockField('Street', '221B Baker Street'),
              _MockField('City', 'London'),
              _MockField('Postcode', 'NW1 6XE'),
            ],
            color: Colors.teal,
          ),
          const SizedBox(height: 10),
          const _MockFormTile(
            tab: 'Payment',
            fields: <_MockField>[
              _MockField('Card', '•••• •••• •••• 4242'),
              _MockField('Holder', 'A. Morgan'),
              _MockField('Expiry', '12/29'),
            ],
            color: Colors.deepPurple,
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.amber.shade300),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.warning_amber, color: Colors.amber.shade800),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'TabBarView preserves these inputs only because each '
                    'tab body is a State that mixes in '
                    'AutomaticKeepAliveClientMixin and returns true. '
                    'Without it, the values would clear on every tab swap.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.amber.shade900,
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

class _MockTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            offset: const Offset(0, 1),
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          _MockTabItem(label: 'Profile', selected: true, color: Colors.indigo),
          _MockTabItem(label: 'Address', selected: false, color: Colors.teal),
          _MockTabItem(label: 'Payment', selected: false, color: Colors.deepPurple),
        ],
      ),
    );
  }
}

class _MockTabItem extends StatelessWidget {
  final String label;
  final bool selected;
  final MaterialColor color;
  const _MockTabItem({
    required this.label,
    required this.selected,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? color.shade700 : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: selected ? color.shade700 : Colors.grey.shade600,
            fontWeight: selected ? FontWeight.bold : FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _MockField {
  final String label;
  final String value;
  const _MockField(this.label, this.value);
}

class _MockFormTile extends StatelessWidget {
  final String tab;
  final List<_MockField> fields;
  final MaterialColor color;

  const _MockFormTile({
    required this.tab,
    required this.fields,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.shade200),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.shade100.withOpacity(0.4),
            offset: const Offset(0, 2),
            blurRadius: 6,
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
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: color.shade100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  tab,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: color.shade800,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'kept-alive after tab switch',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...fields.map((_MockField f) => _MockFieldRow(field: f, color: color)),
        ],
      ),
    );
  }
}

class _MockFieldRow extends StatelessWidget {
  final _MockField field;
  final MaterialColor color;
  const _MockFieldRow({required this.field, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 80,
            child: Text(
              field.label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: color.shade50,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: color.shade100),
              ),
              child: Text(
                field.value,
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
//  Section 7 — Sliver list sparse keep-alive (skyline)
// =====================================================================

class _SparseSkylineSection extends StatelessWidget {
  const _SparseSkylineSection();

  @override
  Widget build(BuildContext context) {
    return _PlainCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _Caption(
            'In a long SliverList only a fraction of items typically need '
            'keep-alive — perhaps the ones holding edits or playing media. '
            'Returning wantKeepAlive selectively per index produces a '
            '"skyline" of alive vs disposed positions. Below is a 24-item '
            'snapshot where bars indicate which indices are kept alive.',
          ),
          const SizedBox(height: 10),
          const _SkylineDiagram(
            keepAliveIndices: <int>[2, 3, 7, 8, 9, 14, 18, 19, 22],
            totalCount: 24,
          ),
          const SizedBox(height: 10),
          const _Caption(
            'Sparse keep-alive is a tradeoff: you pay memory only for the '
            'items that justify it. The pattern is to track per-item state '
            'in the State and return true from wantKeepAlive when that '
            'state is non-trivial (e.g. unsaved input, a playing video).',
          ),
          const SizedBox(height: 8),
          const _CodeBlock(
            'class _ItemState extends State<Item>\n'
            '    with AutomaticKeepAliveClientMixin<Item> {\n'
            '  String _draft = "";\n'
            '\n'
            '  @override\n'
            '  bool get wantKeepAlive => _draft.isNotEmpty;\n'
            '\n'
            '  @override\n'
            '  Widget build(BuildContext context) {\n'
            '    super.build(context);\n'
            '    return TextField(\n'
            '      onChanged: (String v) {\n'
            '        setState(() => _draft = v);\n'
            '        updateKeepAlive(); // notify the parent\n'
            '      },\n'
            '    );\n'
            '  }\n'
            '}',
          ),
        ],
      ),
    );
  }
}

class _SkylineDiagram extends StatelessWidget {
  final List<int> keepAliveIndices;
  final int totalCount;

  const _SkylineDiagram({
    required this.keepAliveIndices,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Colors.blueGrey.shade50,
            Colors.indigo.shade50,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.indigo.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const _Pill(
                text: 'kept',
                color: Colors.green,
                icon: Icons.shield,
              ),
              const SizedBox(width: 8),
              const _Pill(
                text: 'disposed',
                color: Colors.grey,
                icon: Icons.delete_outline,
              ),
              const Spacer(),
              Text(
                '${keepAliveIndices.length} / $totalCount alive',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 90,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List<Widget>.generate(totalCount, (int i) {
                final bool alive = keepAliveIndices.contains(i);
                final double height = alive ? 75.0 : 22.0;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          height: height,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: alive
                                  ? <Color>[
                                      Colors.green.shade400,
                                      Colors.green.shade700,
                                    ]
                                  : <Color>[
                                      Colors.grey.shade300,
                                      Colors.grey.shade400,
                                    ],
                            ),
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(3),
                            ),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '$i',
                          style: TextStyle(
                            fontSize: 8.5,
                            color: Colors.grey.shade700,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
//  Section 8 — Conditional wantKeepAlive
// =====================================================================

class _ConditionalSection extends StatelessWidget {
  const _ConditionalSection();

  @override
  Widget build(BuildContext context) {
    return _PlainCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _Caption(
            'wantKeepAlive is a getter. It can return a computed value '
            'that depends on State fields. Whenever those fields change '
            'in a way that flips the answer, call updateKeepAlive() so '
            'the framework can re-query and adjust the subscription.',
          ),
          const SizedBox(height: 8),
          const _CodeBlock(
            '@override\n'
            'bool get wantKeepAlive => _hasUnsavedEdits || _isPlayingVideo;\n'
            '\n'
            'void _onEdit(String text) {\n'
            '  setState(() => _hasUnsavedEdits = text.isNotEmpty);\n'
            '  updateKeepAlive();\n'
            '}',
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: _ConditionalTile(
                  title: 'Idle',
                  state: 'no edits, paused',
                  alive: false,
                  reason: 'wantKeepAlive returns false',
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ConditionalTile(
                  title: 'Editing',
                  state: 'draft = "hi"',
                  alive: true,
                  reason: 'unsaved edits → keep alive',
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ConditionalTile(
                  title: 'Playing',
                  state: 'video at 0:42',
                  alive: true,
                  reason: 'playback → keep alive',
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ConditionalTile extends StatelessWidget {
  final String title;
  final String state;
  final bool alive;
  final String reason;
  final MaterialColor color;

  const _ConditionalTile({
    required this.title,
    required this.state,
    required this.alive,
    required this.reason,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final Color accent = alive ? Colors.green.shade700 : Colors.grey.shade600;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.shade200),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.shade100.withOpacity(0.5),
            offset: const Offset(0, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: color.shade400,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            state,
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: accent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  alive ? Icons.shield : Icons.delete_outline,
                  size: 12,
                  color: accent,
                ),
                const SizedBox(width: 4),
                Text(
                  alive ? 'kept' : 'disposed',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: accent,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            reason,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade700,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
//  Section 9 — The super.build(context) rule
// =====================================================================

class _SuperBuildSection extends StatelessWidget {
  const _SuperBuildSection();

  @override
  Widget build(BuildContext context) {
    return _PlainCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _Caption(
            'super.build(context) is the line that performs the '
            'subscription. Forgetting it is the single most common '
            'mistake. The framework asserts on this in debug mode and '
            'throws a clear message; in release mode the keep-alive '
            'simply has no effect.',
          ),
          _CodeBlock(
            "// Assertion thrown by AutomaticKeepAliveClientMixin\n"
            "'super.build() must be called by subclasses of\n"
            " AutomaticKeepAliveClientMixin in their build method.'",
          ),
          SizedBox(height: 8),
          _Caption(
            'Why first thing? The assertion is implemented by setting an '
            'expected-call flag inside super.build and clearing it as '
            'soon as the subclass build returns. Calling it later still '
            'satisfies the assertion, but disciplined code puts the call '
            'at the top of build so it cannot be skipped along an early-'
            'return branch.',
          ),
          _CodeBlock(
            '// GOOD\n'
            'Widget build(BuildContext context) {\n'
            '  super.build(context);\n'
            '  if (!ready) return placeholder;\n'
            '  return realUi;\n'
            '}\n'
            '\n'
            '// BAD — early return skips super.build\n'
            'Widget build(BuildContext context) {\n'
            '  if (!ready) return placeholder; // assertion will fire\n'
            '  super.build(context);\n'
            '  return realUi;\n'
            '}',
          ),
        ],
      ),
    );
  }
}

// =====================================================================
//  Section 10 — Common pitfalls
// =====================================================================

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return _PlainCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _Caption(
            'A short field guide to the bugs that always come up. Each '
            'pitfall has a clear symptom and a clear fix.',
          ),
          const SizedBox(height: 8),
          const _PitfallCard(
            title: 'Forgot super.build(context)',
            symptom: 'AssertionError in debug; no keep-alive in release.',
            fix: 'Call super.build(context) as the first line of build.',
            color: Colors.red,
            icon: Icons.error,
          ),
          const _PitfallCard(
            title: 'Always returns wantKeepAlive => true',
            symptom: 'Memory grows unbounded for long lists.',
            fix: 'Compute the answer; return true only when justified.',
            color: Colors.orange,
            icon: Icons.warning,
          ),
          const _PitfallCard(
            title: 'Mixin on a StatelessWidget',
            symptom: 'Compile error: mixin requires State<T>.',
            fix: 'Convert to StatefulWidget and apply the mixin to State.',
            color: Colors.deepOrange,
            icon: Icons.block,
          ),
          const _PitfallCard(
            title: 'Parent has addAutomaticKeepAlives: false',
            symptom: 'Keep-alive request is silently ignored.',
            fix: 'Leave the default true OR wrap the child manually.',
            color: Colors.amber,
            icon: Icons.unsubscribe,
          ),
          const _PitfallCard(
            title: 'Changed wantKeepAlive without updateKeepAlive()',
            symptom: 'Old subscription state lingers until next rebuild.',
            fix: 'Call updateKeepAlive() after flipping the underlying field.',
            color: Colors.purple,
            icon: Icons.sync_problem,
          ),
          const _PitfallCard(
            title: 'Heavy controllers retained forever',
            symptom: 'Background animations or streams keep running off-screen.',
            fix: 'Pause / detach when wantKeepAlive flips to a low-cost mode.',
            color: Colors.blueGrey,
            icon: Icons.battery_alert,
          ),
        ],
      ),
    );
  }
}

class _PitfallCard extends StatelessWidget {
  final String title;
  final String symptom;
  final String fix;
  final MaterialColor color;
  final IconData icon;

  const _PitfallCard({
    required this.title,
    required this.symptom,
    required this.fix,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            color.shade50,
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color.shade800, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color.shade900,
                  ),
                ),
                const SizedBox(height: 6),
                _LabelledLine(label: 'symptom', text: symptom),
                _LabelledLine(label: 'fix', text: fix, accent: Colors.green.shade800),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LabelledLine extends StatelessWidget {
  final String label;
  final String text;
  final Color? accent;
  const _LabelledLine({required this.label, required this.text, this.accent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 64,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: accent ?? Colors.grey.shade700,
                letterSpacing: 0.4,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
//  Section 11 — When NOT to use the mixin
// =====================================================================

class _WhenNotToUseSection extends StatelessWidget {
  const _WhenNotToUseSection();

  @override
  Widget build(BuildContext context) {
    return _PlainCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _Caption(
            'AutomaticKeepAliveClientMixin solves a narrow problem: keep '
            'the State<T> of a particular subtree alive across the '
            'lazy-recycle boundary of its immediate scrolling parent. It '
            'is not a substitute for cross-route persistence, not a way '
            'to share data, and not a performance trick.',
          ),
          const SizedBox(height: 8),
          _GradientCard(
            colors: <Color>[
              Colors.deepPurple.shade50,
              Colors.deepPurple.shade100,
            ],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.lightbulb,
                        color: Colors.deepPurple.shade700),
                    const SizedBox(width: 8),
                    Text(
                      'Reach for these instead when the keep-alive mixin is wrong:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple.shade900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const _BulletPoint(
                  'Provider / InheritedWidget — share data between routes '
                  'or unrelated branches of the tree.',
                ),
                const _BulletPoint(
                  'Bloc / Cubit / Riverpod — manage long-lived business '
                  'state outside the widget tree.',
                ),
                const _BulletPoint(
                  'PageStorageKey — preserve scroll offsets across '
                  'route pushes without keeping the State alive.',
                ),
                const _BulletPoint(
                  'IndexedStack — render all children eagerly so they '
                  'never get disposed at the cost of upfront build time.',
                ),
                const _BulletPoint(
                  'Persistent storage (Hive, shared_preferences, sqlite) '
                  'when the data must outlive the process.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.do_not_disturb_on,
                    color: Colors.red.shade700),
                const SizedBox(width: 10),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.red.shade900,
                        height: 1.4,
                      ),
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'Anti-pattern: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              'using AutomaticKeepAliveClientMixin on every '
                              'item of an unbounded list. The whole point of '
                              'the lazy parent is that it can drop items it '
                              'cannot afford to keep. Override that and you '
                              'have a memory leak with extra steps.',
                        ),
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

// =====================================================================
//  Section 12 — Reference table
// =====================================================================

class _ReferenceTableSection extends StatelessWidget {
  const _ReferenceTableSection();

  @override
  Widget build(BuildContext context) {
    return _PlainCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _Caption(
            'Quick reference card for the mixin contract and its host '
            'parents.',
          ),
          SizedBox(height: 8),
          _RefRow(
            symbol: 'wantKeepAlive',
            kind: 'getter',
            description:
                'Return true to keep the subtree alive, false to allow disposal.',
          ),
          _RefRow(
            symbol: 'updateKeepAlive()',
            kind: 'method',
            description:
                'Notify the framework that wantKeepAlive may have flipped.',
          ),
          _RefRow(
            symbol: 'super.build(context)',
            kind: 'call',
            description:
                'MUST run inside build; performs the subscription handshake.',
          ),
          _RefRow(
            symbol: 'AutomaticKeepAlive',
            kind: 'parent',
            description:
                'Inserted by lazy parents; collects keep-alive subscriptions.',
          ),
          _RefRow(
            symbol: 'addAutomaticKeepAlives',
            kind: 'flag',
            description:
                'Defaults to true on ListView/GridView/PageView/SliverList.',
          ),
          _RefRow(
            symbol: 'KeepAliveNotification',
            kind: 'event',
            description:
                'Internal notification fired up the tree by the mixin.',
          ),
          _RefRow(
            symbol: 'KeepAlive widget',
            kind: 'manual',
            description:
                'Wrap a child manually when the mixin route is impractical.',
          ),
        ],
      ),
    );
  }
}

class _RefRow extends StatelessWidget {
  final String symbol;
  final String kind;
  final String description;

  const _RefRow({
    required this.symbol,
    required this.kind,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.indigo.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 170,
            child: Text(
              symbol,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: Colors.indigo.shade100,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              kind,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(fontSize: 12.5, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
//  Footer
// =====================================================================

class _FooterCard extends StatelessWidget {
  const _FooterCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Colors.indigo.shade700,
            Colors.deepPurple.shade600,
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.indigo.shade400.withOpacity(0.4),
            offset: const Offset(0, 6),
            blurRadius: 16,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.flag, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text(
                'Recap',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Mix AutomaticKeepAliveClientMixin into a State<T>, override '
            'wantKeepAlive, and call super.build(context) as the first '
            'line of build. Use it where the user expects the page to '
            'remember its private UI state. Reach for Provider/Bloc/'
            'Riverpod or persistent storage for anything that must '
            'outlive the immediate parent scrolling boundary.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: const <Widget>[
              _Pill(
                text: 'super.build first',
                color: Colors.white,
                icon: Icons.priority_high,
              ),
              _Pill(
                text: 'compute wantKeepAlive',
                color: Colors.white,
                icon: Icons.functions,
              ),
              _Pill(
                text: 'updateKeepAlive() on flip',
                color: Colors.white,
                icon: Icons.sync,
              ),
              _Pill(
                text: 'use sparingly',
                color: Colors.white,
                icon: Icons.balance,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

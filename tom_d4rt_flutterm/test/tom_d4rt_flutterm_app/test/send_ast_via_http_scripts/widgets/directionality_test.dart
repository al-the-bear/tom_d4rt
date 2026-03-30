import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _DirectionalityDeepDemoApp();
}

class _DirectionalityDeepDemoApp extends StatelessWidget {
  const _DirectionalityDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF255070)),
        useMaterial3: true,
      ),
      home: const _DirectionalityDemoPage(),
    );
  }
}

class _DirectionalityDemoPage extends StatefulWidget {
  const _DirectionalityDemoPage();

  @override
  State<_DirectionalityDemoPage> createState() => _DirectionalityDemoPageState();
}

class _DirectionalityDemoPageState extends State<_DirectionalityDemoPage> {
  bool _globalRtl = false;
  bool _compactCards = false;
  bool _showGuides = true;
  double _alignmentBias = 0.35;
  int _selectedToolbarIndex = 1;

  @override
  Widget build(BuildContext context) {
    const cNavy = Color(0xFF255070);
    const cAmber = Color(0xFFD9853B);
    const cTeal = Color(0xFF1D7A73);
    const cRose = Color(0xFF9A496D);
    const cIndigo = Color(0xFF5A57A6);

    return Directionality(
      textDirection: _globalRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F5F8),
        appBar: AppBar(
          toolbarHeight: 76,
          backgroundColor: cNavy,
          foregroundColor: Colors.white,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Directionality Deep Demo'),
              const SizedBox(height: 2),
              Text(
                _globalRtl
                    ? 'Global scope: Right-to-left (RTL)'
                    : 'Global scope: Left-to-right (LTR)',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeroDirectionBanner(
                globalRtl: _globalRtl,
                compactCards: _compactCards,
                showGuides: _showGuides,
                alignmentBias: _alignmentBias,
                onDirectionChanged: (value) => setState(() => _globalRtl = value),
                onCompactChanged: (value) => setState(() => _compactCards = value),
                onGuidesChanged: (value) => setState(() => _showGuides = value),
                onBiasChanged: (value) => setState(() => _alignmentBias = value),
              ),
              const SizedBox(height: 12),
              const _SceneSection(
                index: 1,
                accent: cNavy,
                title: 'Ambient Direction Inspector',
                subtitle:
                    'Understand how Directionality.of(context) and Directionality.maybeOf(context) expose ambient text direction.',
                child: _AmbientInspectorScene(),
              ),
              const SizedBox(height: 12),
              const _SceneSection(
                index: 2,
                accent: cAmber,
                title: 'Core LTR vs RTL Behaviors',
                subtitle:
                    'Compare the same UI in parallel LTR and RTL scopes: directional padding, alignment, and text behavior.',
                child: _CoreComparisonScene(),
              ),
              const SizedBox(height: 12),
              const _SceneSection(
                index: 3,
                accent: cTeal,
                title: 'Nested Directionality Scopes',
                subtitle:
                    'Directionality is inherited, so local subtrees can override parent direction to support multilingual islands.',
                child: _NestedScopeScene(),
              ),
              const SizedBox(height: 12),
              _SceneSection(
                index: 4,
                accent: cRose,
                title: 'Directional Layout Toolkit',
                subtitle:
                    'Visual examples for EdgeInsetsDirectional, AlignmentDirectional, PositionedDirectional, and textDirection-aware rows.',
                child: _ToolkitScene(
                  showGuides: _showGuides,
                  alignmentBias: _alignmentBias,
                ),
              ),
              const SizedBox(height: 12),
              _SceneSection(
                index: 5,
                accent: cIndigo,
                title: 'Interactive Toggle Lab',
                subtitle:
                    'Switch direction, compactness, and selection states to see how compositional patterns stay direction-correct.',
                child: _InteractiveLabScene(
                  compactCards: _compactCards,
                  selectedToolbarIndex: _selectedToolbarIndex,
                  onSelectToolbarIndex: (index) => setState(() => _selectedToolbarIndex = index),
                ),
              ),
              const SizedBox(height: 12),
              _SceneSection(
                index: 6,
                accent: const Color(0xFF6C5A2B),
                title: 'Practical Pattern Gallery',
                subtitle:
                    'Real-world pattern cards: chat rows, action bars, and metric strips that respect start/end semantics.',
                child: _PracticalPatternsScene(
                  compactCards: _compactCards,
                  showGuides: _showGuides,
                ),
              ),
              const SizedBox(height: 14),
              const _WrapUpCard(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroDirectionBanner extends StatelessWidget {
  const _HeroDirectionBanner({
    required this.globalRtl,
    required this.compactCards,
    required this.showGuides,
    required this.alignmentBias,
    required this.onDirectionChanged,
    required this.onCompactChanged,
    required this.onGuidesChanged,
    required this.onBiasChanged,
  });

  final bool globalRtl;
  final bool compactCards;
  final bool showGuides;
  final double alignmentBias;
  final ValueChanged<bool> onDirectionChanged;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onGuidesChanged;
  final ValueChanged<double> onBiasChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF255070), Color(0xFF4E638C), Color(0xFF8A4C67)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Directionality',
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Defines ambient text direction for a subtree. Widgets using start/end semantics resolve layout based on this inherited value.',
            style: TextStyle(fontSize: 13, color: Color(0xFFF5F8FF), height: 1.45),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: SwitchListTile(
                  value: globalRtl,
                  onChanged: onDirectionChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Global RTL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SwitchListTile(
                  value: compactCards,
                  onChanged: onCompactChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Compact cards', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SwitchListTile(
                  value: showGuides,
                  onChanged: onGuidesChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Show guides', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
          Text(
            'Directional alignment bias: ${alignmentBias.toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
          ),
          Slider(
            value: alignmentBias,
            min: 0,
            max: 1,
            divisions: 10,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.28),
            onChanged: onBiasChanged,
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _BannerChip(label: globalRtl ? 'Current: RTL' : 'Current: LTR'),
              const _BannerChip(label: 'Directionality.of(context)'),
              const _BannerChip(label: 'Directionality.maybeOf(context)'),
              const _BannerChip(label: 'EdgeInsetsDirectional'),
              const _BannerChip(label: 'AlignmentDirectional'),
              const _BannerChip(label: 'PositionedDirectional'),
            ],
          ),
        ],
      ),
    );
  }
}

class _BannerChip extends StatelessWidget {
  const _BannerChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.32)),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _SceneSection extends StatelessWidget {
  const _SceneSection({
    required this.index,
    required this.accent,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final int index;
  final Color accent;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.26)),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('$index', style: TextStyle(color: accent, fontWeight: FontWeight.w900)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(color: accent, fontSize: 19, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12, height: 1.45, color: accent.withValues(alpha: 0.84)),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _AmbientInspectorScene extends StatelessWidget {
  const _AmbientInspectorScene();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionInfoText(
          'Directionality is an inherited ambient value. Directionality.of(context) reads the nearest scope and throws if missing, while maybeOf(context) returns nullable.',
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            _AmbientProbeCard(title: 'Ambient from current subtree', direction: null),
            _AmbientProbeCard(title: 'Forced local LTR scope', direction: TextDirection.ltr),
            _AmbientProbeCard(title: 'Forced local RTL scope', direction: TextDirection.rtl),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFF4F7FA),
            border: Border.all(color: const Color(0xFFCBD6E0)),
          ),
          child: const SelectableText(
            'TextDirection dirA = Directionality.of(context);\n'
            'TextDirection? dirB = Directionality.maybeOf(context);\n\n'
            'Use of(context) when Directionality is guaranteed (MaterialApp/WidgetsApp subtree).\n'
            'Use maybeOf(context) in reusable utilities that may run outside a directionality scope.',
            style: TextStyle(fontFamily: 'monospace', fontSize: 11.2, height: 1.4),
          ),
        ),
      ],
    );
  }
}

class _AmbientProbeCard extends StatelessWidget {
  const _AmbientProbeCard({
    required this.title,
    required this.direction,
  });

  final String title;
  final TextDirection? direction;

  @override
  Widget build(BuildContext context) {
    Widget body = Builder(
      builder: (context) {
        final strict = Directionality.of(context);
        final soft = Directionality.maybeOf(context);
        final startLabel = strict == TextDirection.rtl ? 'Start -> right' : 'Start -> left';
        final endLabel = strict == TextDirection.rtl ? 'End -> left' : 'End -> right';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'of(context): $strict\nmaybeOf(context): $soft',
              style: const TextStyle(fontFamily: 'monospace', fontSize: 10.4, height: 1.35),
            ),
            const SizedBox(height: 8),
            _DirectionLane(
              leftText: startLabel,
              rightText: endLabel,
              accent: const Color(0xFF255070),
            ),
          ],
        );
      },
    );

    if (direction != null) {
      body = Directionality(textDirection: direction!, child: body);
    }

    return SizedBox(
      width: 302,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFF7FAFC),
          border: Border.all(color: const Color(0xFFCFDCEA)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF255070), fontSize: 13),
            ),
            const SizedBox(height: 8),
            body,
          ],
        ),
      ),
    );
  }
}

class _DirectionLane extends StatelessWidget {
  const _DirectionLane({
    required this.leftText,
    required this.rightText,
    required this.accent,
  });

  final String leftText;
  final String rightText;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(start: 10, end: 10, top: 8, bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: accent.withValues(alpha: 0.08),
        border: Border.all(color: accent.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Expanded(child: Text(leftText, style: TextStyle(color: accent, fontSize: 11))),
          Expanded(
            child: Text(
              rightText,
              style: TextStyle(color: accent, fontSize: 11),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

class _CoreComparisonScene extends StatelessWidget {
  const _CoreComparisonScene();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: const [
        _DirectionalRenderCard(
          title: 'LTR scope',
          direction: TextDirection.ltr,
          accent: Color(0xFFD9853B),
        ),
        _DirectionalRenderCard(
          title: 'RTL scope',
          direction: TextDirection.rtl,
          accent: Color(0xFFD9853B),
        ),
      ],
    );
  }
}

class _DirectionalRenderCard extends StatelessWidget {
  const _DirectionalRenderCard({
    required this.title,
    required this.direction,
    required this.accent,
  });

  final String title;
  final TextDirection direction;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Directionality(
        textDirection: direction,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: accent.withValues(alpha: 0.28)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title (${direction.name})',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: accent),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsetsDirectional.only(start: 16, end: 4, top: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: accent.withValues(alpha: 0.2)),
                ),
                child: const Text(
                  'EdgeInsetsDirectional.only(start: 16)\n'
                  'shifts this text from logical start side.',
                  style: TextStyle(fontSize: 11.2, height: 1.35),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 90,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: accent.withValues(alpha: 0.2)),
                      ),
                    ),
                    PositionedDirectional(
                      start: 10,
                      top: 10,
                      child: _Tag(text: 'start', accent: accent),
                    ),
                    PositionedDirectional(
                      end: 10,
                      bottom: 10,
                      child: _Tag(text: 'end', accent: accent),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Both cards use identical widget code; only Directionality changes, proving logical start/end resolution.',
                style: TextStyle(fontSize: 11.3, height: 1.35),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.text, required this.accent});

  final String text;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: accent,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
    );
  }
}

class _NestedScopeScene extends StatelessWidget {
  const _NestedScopeScene();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionInfoText(
          'Nested Directionality is useful when a screen has mixed-language sections. Wrap only the target subtree to avoid affecting siblings.',
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(
              child: _NestedScopeCard(
                title: 'Parent LTR with RTL island',
                parentDirection: TextDirection.ltr,
                localDirection: TextDirection.rtl,
                accent: Color(0xFF1D7A73),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _NestedScopeCard(
                title: 'Parent RTL with LTR island',
                parentDirection: TextDirection.rtl,
                localDirection: TextDirection.ltr,
                accent: Color(0xFF1D7A73),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _NestedScopeCard extends StatelessWidget {
  const _NestedScopeCard({
    required this.title,
    required this.parentDirection,
    required this.localDirection,
    required this.accent,
  });

  final String title;
  final TextDirection parentDirection;
  final TextDirection localDirection;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: parentDirection,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: accent.withValues(alpha: 0.28)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w800, color: accent, fontSize: 13),
            ),
            const SizedBox(height: 8),
            _MiniMessageBubble(
              text: 'Parent flow uses ${parentDirection.name}.',
              accent: accent,
            ),
            const SizedBox(height: 6),
            Directionality(
              textDirection: localDirection,
              child: _MiniMessageBubble(
                text: 'Nested island uses ${localDirection.name}.',
                accent: accent,
                emphasized: true,
              ),
            ),
            const SizedBox(height: 6),
            _MiniMessageBubble(
              text: 'Parent flow resumes unaffected.',
              accent: accent,
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: accent.withValues(alpha: 0.2)),
              ),
              child: Text(
                'Directionality.of inside island: ${localDirection.name}\n'
                'Directionality.of outside island: ${parentDirection.name}',
                style: TextStyle(fontFamily: 'monospace', fontSize: 10.2, color: accent.withValues(alpha: 0.85)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniMessageBubble extends StatelessWidget {
  const _MiniMessageBubble({
    required this.text,
    required this.accent,
    this.emphasized = false,
  });

  final String text;
  final Color accent;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final direction = Directionality.of(context);
    final isRtl = direction == TextDirection.rtl;

    return Row(
      mainAxisAlignment: isRtl ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 260),
          child: Container(
            padding: const EdgeInsetsDirectional.only(start: 10, end: 10, top: 8, bottom: 8),
            decoration: BoxDecoration(
              color: emphasized ? accent : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: accent.withValues(alpha: 0.25)),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 11.2,
                color: emphasized ? Colors.white : accent.withValues(alpha: 0.86),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ToolkitScene extends StatelessWidget {
  const _ToolkitScene({
    required this.showGuides,
    required this.alignmentBias,
  });

  final bool showGuides;
  final double alignmentBias;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _ToolkitCard(
          title: 'EdgeInsetsDirectional',
          accent: const Color(0xFF9A496D),
          child: const _PaddingDirectionalVisual(),
        ),
        _ToolkitCard(
          title: 'AlignmentDirectional',
          accent: const Color(0xFF9A496D),
          child: _AlignmentDirectionalVisual(
            alignmentBias: alignmentBias,
            showGuides: showGuides,
          ),
        ),
        _ToolkitCard(
          title: 'PositionedDirectional',
          accent: const Color(0xFF9A496D),
          child: _PositionedDirectionalVisual(showGuides: showGuides),
        ),
        _ToolkitCard(
          title: 'Row(textDirection: ...)',
          accent: const Color(0xFF9A496D),
          child: const _RowDirectionVisual(),
        ),
      ],
    );
  }
}

class _ToolkitCard extends StatelessWidget {
  const _ToolkitCard({
    required this.title,
    required this.accent,
    required this.child,
  });

  final String title;
  final Color accent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: accent.withValues(alpha: 0.27)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 13)),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}

class _PaddingDirectionalVisual extends StatelessWidget {
  const _PaddingDirectionalVisual();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _OneDirectionPadding(direction: TextDirection.ltr),
        const SizedBox(height: 8),
        _OneDirectionPadding(direction: TextDirection.rtl),
      ],
    );
  }
}

class _OneDirectionPadding extends StatelessWidget {
  const _OneDirectionPadding({required this.direction});

  final TextDirection direction;

  @override
  Widget build(BuildContext context) {
    final accent = const Color(0xFF9A496D);

    return Directionality(
      textDirection: direction,
      child: Container(
        padding: const EdgeInsetsDirectional.only(start: 18, end: 4, top: 6, bottom: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: accent.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Text(direction.name.toUpperCase(), style: TextStyle(fontSize: 10, color: accent)),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                'Start padding 18',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AlignmentDirectionalVisual extends StatelessWidget {
  const _AlignmentDirectionalVisual({required this.alignmentBias, required this.showGuides});

  final double alignmentBias;
  final bool showGuides;

  @override
  Widget build(BuildContext context) {
    final resolved = (alignmentBias * 2) - 1;

    return Container(
      height: 136,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF9A496D).withValues(alpha: 0.2)),
      ),
      child: Stack(
        children: [
          if (showGuides)
            Align(
              alignment: Alignment.center,
              child: Container(width: 1, color: const Color(0xFF9A496D).withValues(alpha: 0.25)),
            ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            alignment: AlignmentDirectional(resolved, 0),
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFF9A496D).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF9A496D).withValues(alpha: 0.45)),
              ),
              child: const Center(
                child: Text(
                  'AlignmentDirectional',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 8.8, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PositionedDirectionalVisual extends StatelessWidget {
  const _PositionedDirectionalVisual({required this.showGuides});

  final bool showGuides;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 136,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF9A496D).withValues(alpha: 0.2)),
      ),
      child: Stack(
        children: [
          if (showGuides)
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(painter: _GuidePainter(color: const Color(0xFF9A496D).withValues(alpha: 0.18))),
              ),
            ),
          PositionedDirectional(
            start: 10,
            top: 10,
            child: _Tag(text: 'start', accent: const Color(0xFF9A496D)),
          ),
          PositionedDirectional(
            end: 10,
            bottom: 10,
            child: _Tag(text: 'end', accent: const Color(0xFF9A496D)),
          ),
        ],
      ),
    );
  }
}

class _GuidePainter extends CustomPainter {
  _GuidePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawRect(Offset.zero & size, paint);
    canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2, size.height), paint);
    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);
  }

  @override
  bool shouldRepaint(covariant _GuidePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _RowDirectionVisual extends StatelessWidget {
  const _RowDirectionVisual();

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF9A496D);

    return Column(
      children: [
        _DirectionRow(direction: TextDirection.ltr, accent: accent),
        const SizedBox(height: 8),
        _DirectionRow(direction: TextDirection.rtl, accent: accent),
      ],
    );
  }
}

class _DirectionRow extends StatelessWidget {
  const _DirectionRow({required this.direction, required this.accent});

  final TextDirection direction;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.2)),
      ),
      child: Row(
        textDirection: direction,
        children: [
          Icon(Icons.arrow_back, color: accent, size: 16),
          const SizedBox(width: 6),
          Text(direction.name.toUpperCase(), style: TextStyle(fontSize: 10.5, color: accent, fontWeight: FontWeight.w700)),
          const Spacer(),
          Icon(Icons.arrow_forward, color: accent, size: 16),
        ],
      ),
    );
  }
}

class _InteractiveLabScene extends StatelessWidget {
  const _InteractiveLabScene({
    required this.compactCards,
    required this.selectedToolbarIndex,
    required this.onSelectToolbarIndex,
  });

  final bool compactCards;
  final int selectedToolbarIndex;
  final ValueChanged<int> onSelectToolbarIndex;

  @override
  Widget build(BuildContext context) {
    final direction = Directionality.of(context);
    final isRtl = direction == TextDirection.rtl;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionInfoText(
          isRtl
              ? 'RTL active: logical start is right; selected tool badge and panel flow mirror automatically.'
              : 'LTR active: logical start is left; selected tool badge and panel flow use default ordering.',
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF0FB),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFD1D5F1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Toolbar (direction-aware order)', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF5A57A6))),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _ToolbarButton(
                      label: 'Home',
                      selected: selectedToolbarIndex == 0,
                      onTap: () => onSelectToolbarIndex(0),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _ToolbarButton(
                      label: 'Projects',
                      selected: selectedToolbarIndex == 1,
                      onTap: () => onSelectToolbarIndex(1),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _ToolbarButton(
                      label: 'Insights',
                      selected: selectedToolbarIndex == 2,
                      onTap: () => onSelectToolbarIndex(2),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _SelectedPanel(
                selectedToolbarIndex: selectedToolbarIndex,
                compactCards: compactCards,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ToolbarButton extends StatelessWidget {
  const _ToolbarButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: selected ? const Color(0xFF5A57A6) : Colors.white,
          border: Border.all(color: const Color(0xFF5A57A6).withValues(alpha: 0.22)),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: selected ? Colors.white : const Color(0xFF5A57A6),
          ),
        ),
      ),
    );
  }
}

class _SelectedPanel extends StatelessWidget {
  const _SelectedPanel({
    required this.selectedToolbarIndex,
    required this.compactCards,
  });

  final int selectedToolbarIndex;
  final bool compactCards;

  @override
  Widget build(BuildContext context) {
    final labels = ['Home stream', 'Project board', 'Insight digest'];
    final accents = [const Color(0xFF5A57A6), const Color(0xFF3E7E74), const Color(0xFF8A5C34)];
    final accent = accents[selectedToolbarIndex];
    final itemHeight = compactCards ? 34.0 : 44.0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labels[selectedToolbarIndex], style: TextStyle(fontWeight: FontWeight.w800, color: accent, fontSize: 13)),
          const SizedBox(height: 8),
          _PanelListItem(title: 'Primary tile', height: itemHeight, accent: accent),
          const SizedBox(height: 6),
          _PanelListItem(title: 'Secondary tile', height: itemHeight, accent: accent),
          const SizedBox(height: 6),
          _PanelListItem(title: 'Context tile', height: itemHeight, accent: accent),
        ],
      ),
    );
  }
}

class _PanelListItem extends StatelessWidget {
  const _PanelListItem({
    required this.title,
    required this.height,
    required this.accent,
  });

  final String title;
  final double height;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: double.infinity,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.8),
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(8),
                bottomStart: Radius.circular(8),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w700))),
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 8),
            child: Icon(Icons.chevron_right_rounded, color: accent),
          ),
        ],
      ),
    );
  }
}

class _PracticalPatternsScene extends StatelessWidget {
  const _PracticalPatternsScene({required this.compactCards, required this.showGuides});

  final bool compactCards;
  final bool showGuides;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _PatternCard(
          title: 'Chat Pattern',
          accent: const Color(0xFF6C5A2B),
          child: _ChatPattern(compact: compactCards),
        ),
        _PatternCard(
          title: 'Action Strip Pattern',
          accent: const Color(0xFF6C5A2B),
          child: _ActionStripPattern(showGuides: showGuides),
        ),
        _PatternCard(
          title: 'Metrics Pattern',
          accent: const Color(0xFF6C5A2B),
          child: _MetricsPattern(compact: compactCards),
        ),
      ],
    );
  }
}

class _PatternCard extends StatelessWidget {
  const _PatternCard({
    required this.title,
    required this.accent,
    required this.child,
  });

  final String title;
  final Color accent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: accent.withValues(alpha: 0.28)),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: accent)),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}

class _ChatPattern extends StatelessWidget {
  const _ChatPattern({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final height = compact ? 30.0 : 40.0;

    return Column(
      children: [
        _ChatRow(
          incoming: true,
          text: 'Incoming message using start alignment.',
          height: height,
        ),
        const SizedBox(height: 6),
        _ChatRow(
          incoming: false,
          text: 'Outgoing message using end alignment.',
          height: height,
        ),
        const SizedBox(height: 6),
        _ChatRow(
          incoming: true,
          text: 'Directionality flips visual side without changing code.',
          height: height,
        ),
      ],
    );
  }
}

class _ChatRow extends StatelessWidget {
  const _ChatRow({
    required this.incoming,
    required this.text,
    required this.height,
  });

  final bool incoming;
  final String text;
  final double height;

  @override
  Widget build(BuildContext context) {
    final accent = const Color(0xFF6C5A2B);

    return Row(
      mainAxisAlignment: incoming ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 260),
          child: Container(
            height: height,
            alignment: AlignmentDirectional.centerStart,
            padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
            decoration: BoxDecoration(
              color: incoming ? accent.withValues(alpha: 0.12) : accent,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: accent.withValues(alpha: 0.25)),
            ),
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.8,
                color: incoming ? accent : Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ActionStripPattern extends StatelessWidget {
  const _ActionStripPattern({required this.showGuides});

  final bool showGuides;

  @override
  Widget build(BuildContext context) {
    final accent = const Color(0xFF6C5A2B);

    return Container(
      height: 136,
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.2)),
      ),
      child: Stack(
        children: [
          if (showGuides)
            Positioned.fill(
              child: CustomPaint(
                painter: _GuidePainter(color: accent.withValues(alpha: 0.16)),
              ),
            ),
          PositionedDirectional(
            top: 10,
            start: 10,
            child: _Tag(text: 'Back', accent: accent),
          ),
          PositionedDirectional(
            top: 10,
            end: 10,
            child: _Tag(text: 'Save', accent: accent),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 10, end: 10, bottom: 10),
              child: Row(
                children: [
                  Expanded(child: _StripButton(text: 'Cancel', accent: accent, filled: false)),
                  const SizedBox(width: 8),
                  Expanded(child: _StripButton(text: 'Apply', accent: accent, filled: true)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StripButton extends StatelessWidget {
  const _StripButton({required this.text, required this.accent, required this.filled});

  final String text;
  final Color accent;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: filled ? accent : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.25)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: filled ? Colors.white : accent,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _MetricsPattern extends StatelessWidget {
  const _MetricsPattern({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final accent = const Color(0xFF6C5A2B);

    return Column(
      children: [
        _MetricStrip(label: 'Completion', value: '92%', accent: accent, compact: compact),
        const SizedBox(height: 6),
        _MetricStrip(label: 'Cycle Time', value: '2.1d', accent: accent, compact: compact),
        const SizedBox(height: 6),
        _MetricStrip(label: 'Open Risks', value: '3', accent: accent, compact: compact),
      ],
    );
  }
}

class _MetricStrip extends StatelessWidget {
  const _MetricStrip({
    required this.label,
    required this.value,
    required this.accent,
    required this.compact,
  });

  final String label;
  final String value;
  final Color accent;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final height = compact ? 34.0 : 44.0;

    return Container(
      height: height,
      padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: accent.withValues(alpha: 0.08),
        border: Border.all(color: accent.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.assessment_rounded, color: accent, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.w700, color: accent),
            ),
          ),
          Text(value, style: TextStyle(fontWeight: FontWeight.w800, color: accent, fontSize: 16)),
        ],
      ),
    );
  }
}

class _WrapUpCard extends StatelessWidget {
  const _WrapUpCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFFEAF0F6), Color(0xFFF6ECE7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFFC6D0DB)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deep Demo Recap',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF324A5C)),
          ),
          SizedBox(height: 8),
          Text(
            '1) Directionality defines ambient TextDirection for a subtree.\n'
            '2) Directionality.of reads a required ambient scope, maybeOf reads a nullable scope.\n'
            '3) Logical start/end APIs (EdgeInsetsDirectional, AlignmentDirectional, PositionedDirectional) mirror automatically.\n'
            '4) Nested Directionality scopes allow mixed-language modules in one screen.\n'
            '5) Building with start/end semantics avoids manual left/right branching and improves maintainability.',
            style: TextStyle(fontSize: 12.5, height: 1.45),
          ),
        ],
      ),
    );
  }
}

class _SectionInfoText extends StatelessWidget {
  const _SectionInfoText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: 12.4, height: 1.45));
  }
}

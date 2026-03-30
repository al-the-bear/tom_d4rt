import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _DefaultTextHeightBehaviorDemoApp();
}

class _DefaultTextHeightBehaviorDemoApp extends StatelessWidget {
  const _DefaultTextHeightBehaviorDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0E6479)),
        useMaterial3: true,
      ),
      home: const _DefaultTextHeightBehaviorDemoPage(),
    );
  }
}

class _DefaultTextHeightBehaviorDemoPage extends StatefulWidget {
  const _DefaultTextHeightBehaviorDemoPage();

  @override
  State<_DefaultTextHeightBehaviorDemoPage> createState() => _DefaultTextHeightBehaviorDemoPageState();
}

class _DefaultTextHeightBehaviorDemoPageState extends State<_DefaultTextHeightBehaviorDemoPage> {
  final TextEditingController _editorA = TextEditingController(
    text: 'Editable text with scoped DefaultTextHeightBehavior.\nObserve top and bottom spacing.',
  );
  final TextEditingController _editorB = TextEditingController(
    text: 'DefaultTextStyle can also carry textHeightBehavior and may override local defaults.',
  );
  final TextEditingController _moduleOps = TextEditingController(text: 'Operations headline draft\nSpacing consistency check');
  final TextEditingController _moduleCreative = TextEditingController(text: 'Creative copy block\nVisual rhythm checkpoint');
  final TextEditingController _moduleResearch = TextEditingController(text: 'Research summary\nLeading distribution comparison');

  double _interactiveHeight = 1.6;
  bool _interactiveFirstAscent = true;
  bool _interactiveLastDescent = true;
  TextLeadingDistribution _interactiveLeading = TextLeadingDistribution.proportional;

  @override
  void dispose() {
    _editorA.dispose();
    _editorB.dispose();
    _moduleOps.dispose();
    _moduleCreative.dispose();
    _moduleResearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const cOcean = Color(0xFF0E6479);
    const cCoral = Color(0xFFE17258);
    const cForest = Color(0xFF2E7A65);
    const cViolet = Color(0xFF6C5AA1);
    const cSlate = Color(0xFF324652);
    const cSand = Color(0xFFF6F3EC);

    return Scaffold(
      backgroundColor: cSand,
      appBar: AppBar(
        backgroundColor: cOcean,
        foregroundColor: Colors.white,
        toolbarHeight: 74,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('DefaultTextHeightBehavior Deep Demo'),
            SizedBox(height: 2),
            Text(
              'Inherited line-height behavior for Text and EditableText',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _HeroBanner(),
            const SizedBox(height: 14),
            const _SceneCard(
              index: 1,
              title: 'Concept and API Surface',
              subtitle:
                  'Understand what DefaultTextHeightBehavior controls and where it sits relative to TextStyle.height and DefaultTextStyle.',
              accent: cOcean,
              child: _ConceptScene(),
            ),
            const SizedBox(height: 12),
            const _SceneCard(
              index: 2,
              title: 'applyHeightToFirstAscent Comparison',
              subtitle:
                  'Top edge behavior for the first line changes visual alignment in cards, headlines, and dense form layouts.',
              accent: cCoral,
              child: _FirstAscentScene(),
            ),
            const SizedBox(height: 12),
            const _SceneCard(
              index: 3,
              title: 'applyHeightToLastDescent Comparison',
              subtitle:
                  'Bottom edge behavior affects clipped descenders and baseline rhythm in multi-line content blocks.',
              accent: cForest,
              child: _LastDescentScene(),
            ),
            const SizedBox(height: 12),
            const _SceneCard(
              index: 4,
              title: 'leadingDistribution: proportional vs even',
              subtitle:
                  'How extra leading is distributed around glyphs can change readability and optical balance in UI typography.',
              accent: cViolet,
              child: _LeadingDistributionScene(),
            ),
            const SizedBox(height: 12),
            _SceneCard(
              index: 5,
              title: 'Interactive Height Behavior Lab',
              subtitle:
                  'Tune line height and behavior flags live to observe spacing changes in Text and EditableText under inherited defaults.',
              accent: cSlate,
              child: _InteractiveScene(
                height: _interactiveHeight,
                firstAscent: _interactiveFirstAscent,
                lastDescent: _interactiveLastDescent,
                leadingDistribution: _interactiveLeading,
                editorA: _editorA,
                editorB: _editorB,
                onHeightChanged: (value) => setState(() => _interactiveHeight = value),
                onFirstAscentChanged: (value) => setState(() => _interactiveFirstAscent = value),
                onLastDescentChanged: (value) => setState(() => _interactiveLastDescent = value),
                onLeadingChanged: (value) => setState(() => _interactiveLeading = value),
              ),
            ),
            const SizedBox(height: 12),
            _SceneCard(
              index: 6,
              title: 'Practical Module Architecture',
              subtitle:
                  'Reusable editors inherit module-specific text-height behavior without changing shared widget code.',
              accent: const Color(0xFF7A5B3D),
              child: _ArchitectureScene(
                opsController: _moduleOps,
                creativeController: _moduleCreative,
                researchController: _moduleResearch,
              ),
            ),
            const SizedBox(height: 16),
            const _RecapCard(),
            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0E6479),
            Color(0xFF2F879B),
            Color(0xFF6C5AA1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'DefaultTextHeightBehavior',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white),
          ),
          const SizedBox(height: 8),
          const Text(
            'Defines default TextHeightBehavior for descendant Text and EditableText widgets that do not explicitly '
            'set textHeightBehavior. Useful for typography consistency across feature subtrees.',
            style: TextStyle(fontSize: 13, height: 1.45, color: Color(0xFFF1FAFF)),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              _TagChip(label: 'applyHeightToFirstAscent'),
              _TagChip(label: 'applyHeightToLastDescent'),
              _TagChip(label: 'leadingDistribution'),
              _TagChip(label: 'maybeOf / of'),
              _TagChip(label: 'InheritedTheme behavior'),
            ],
          ),
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.45)),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _SceneCard extends StatelessWidget {
  const _SceneCard({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.child,
  });

  final int index;
  final String title;
  final String subtitle;
  final Color accent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.28)),
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
                  color: accent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$index',
                  style: TextStyle(color: accent, fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: accent),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12, height: 1.45, color: accent.withValues(alpha: 0.8)),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _ConceptScene extends StatelessWidget {
  const _ConceptScene();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _InfoLine(
          'DefaultTextHeightBehavior inserts a TextHeightBehavior into the inherited tree. '
          'Text and EditableText use it only when they do not already specify textHeightBehavior directly.',
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            _BehaviorFactCard(
              title: 'First ascent',
              accent: Color(0xFFE17258),
              line1: 'applyHeightToFirstAscent controls top edge of first line.',
              line2: 'Important for tight card headers and baseline alignment.',
            ),
            _BehaviorFactCard(
              title: 'Last descent',
              accent: Color(0xFF2E7A65),
              line1: 'applyHeightToLastDescent controls bottom edge of last line.',
              line2: 'Useful to avoid clipping in compact containers.',
            ),
            _BehaviorFactCard(
              title: 'Leading distribution',
              accent: Color(0xFF6C5AA1),
              line1: 'proportional vs even changes top/bottom extra spacing split.',
              line2: 'Influences optical text balance in multiline layouts.',
            ),
            _BehaviorFactCard(
              title: 'Priority rules',
              accent: Color(0xFF0E6479),
              line1: 'Explicit Text.textHeightBehavior overrides inherited default.',
              line2: 'DefaultTextStyle.textHeightBehavior can override inherited too.',
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F7FA),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFBCD2DD)),
          ),
          child: const SelectableText(
            'DefaultTextHeightBehavior(\n'
            '  textHeightBehavior: TextHeightBehavior(\n'
            '    applyHeightToFirstAscent: false,\n'
            '    applyHeightToLastDescent: true,\n'
            '    leadingDistribution: TextLeadingDistribution.even,\n'
            '  ),\n'
            '  child: Text("...")\n'
            ')',
            style: TextStyle(fontFamily: 'monospace', fontSize: 11, height: 1.4),
          ),
        ),
      ],
    );
  }
}

class _BehaviorFactCard extends StatelessWidget {
  const _BehaviorFactCard({
    required this.title,
    required this.accent,
    required this.line1,
    required this.line2,
  });

  final String title;
  final Color accent;
  final String line1;
  final String line2;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 298,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: accent.withValues(alpha: 0.27)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.w800, color: accent, fontSize: 13)),
            const SizedBox(height: 6),
            Text(line1, style: const TextStyle(fontSize: 11.6, height: 1.35)),
            const SizedBox(height: 3),
            Text(line2, style: const TextStyle(fontSize: 11.6, height: 1.35)),
          ],
        ),
      ),
    );
  }
}

class _FirstAscentScene extends StatelessWidget {
  const _FirstAscentScene();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _InfoLine(
          'The two cards below share identical text style and line height. Only applyHeightToFirstAscent differs.',
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [
            _HeightBehaviorCard(
              title: 'First ascent = true',
              accent: Color(0xFFE17258),
              textHeightBehavior: TextHeightBehavior(
                applyHeightToFirstAscent: true,
                applyHeightToLastDescent: true,
                leadingDistribution: TextLeadingDistribution.proportional,
              ),
              text:
                  'Headline block\nThe first line keeps top spacing from line-height multiplier.\nUseful when consistent rhythm is preferred.',
            ),
            _HeightBehaviorCard(
              title: 'First ascent = false',
              accent: Color(0xFFE17258),
              textHeightBehavior: TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: true,
                leadingDistribution: TextLeadingDistribution.proportional,
              ),
              text:
                  'Headline block\nTop edge hugs glyph ascent more tightly.\nUseful when header should align closer to container top.',
            ),
          ],
        ),
      ],
    );
  }
}

class _LastDescentScene extends StatelessWidget {
  const _LastDescentScene();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _InfoLine(
          'The bottom ruler highlights how applyHeightToLastDescent influences final line spacing and descender area.',
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [
            _HeightBehaviorCard(
              title: 'Last descent = true',
              accent: Color(0xFF2E7A65),
              textHeightBehavior: TextHeightBehavior(
                applyHeightToFirstAscent: true,
                applyHeightToLastDescent: true,
                leadingDistribution: TextLeadingDistribution.proportional,
              ),
              text:
                  'Metrics card\nObserve descender region with letters like g, y, p.\nBottom spacing includes multiplied line-height contribution.',
            ),
            _HeightBehaviorCard(
              title: 'Last descent = false',
              accent: Color(0xFF2E7A65),
              textHeightBehavior: TextHeightBehavior(
                applyHeightToFirstAscent: true,
                applyHeightToLastDescent: false,
                leadingDistribution: TextLeadingDistribution.proportional,
              ),
              text:
                  'Metrics card\nBottom edge is tighter against final baseline and descenders.\nUseful for compact components and tighter stacks.',
            ),
          ],
        ),
      ],
    );
  }
}

class _LeadingDistributionScene extends StatelessWidget {
  const _LeadingDistributionScene();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _InfoLine(
          'leadingDistribution controls how extra line leading is distributed above vs below text. Compare proportional and even.',
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [
            _HeightBehaviorCard(
              title: 'leadingDistribution = proportional',
              accent: Color(0xFF6C5AA1),
              textHeightBehavior: TextHeightBehavior(
                applyHeightToFirstAscent: true,
                applyHeightToLastDescent: true,
                leadingDistribution: TextLeadingDistribution.proportional,
              ),
              text:
                  'Interface copy\nProportional distribution follows font metrics more closely.\nOften feels natural in body text flows.',
            ),
            _HeightBehaviorCard(
              title: 'leadingDistribution = even',
              accent: Color(0xFF6C5AA1),
              textHeightBehavior: TextHeightBehavior(
                applyHeightToFirstAscent: true,
                applyHeightToLastDescent: true,
                leadingDistribution: TextLeadingDistribution.even,
              ),
              text:
                  'Interface copy\nEven distribution spreads extra leading more uniformly.\nUseful for visual centering in tightly framed labels.',
            ),
          ],
        ),
      ],
    );
  }
}

class _HeightBehaviorCard extends StatelessWidget {
  const _HeightBehaviorCard({
    required this.title,
    required this.accent,
    required this.textHeightBehavior,
    required this.text,
  });

  final String title;
  final Color accent;
  final TextHeightBehavior textHeightBehavior;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: DefaultTextHeightBehavior(
        textHeightBehavior: textHeightBehavior,
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
              Text(title, style: TextStyle(fontWeight: FontWeight.w800, color: accent, fontSize: 13.5)),
              const SizedBox(height: 7),
              _RulerFrame(
                accent: accent,
                child: Text(
                  text,
                  style: TextStyle(fontSize: 16, height: 1.8, color: accent.withValues(alpha: 0.9)),
                ),
              ),
              const SizedBox(height: 7),
              _BehaviorReadout(accent: accent),
            ],
          ),
        ),
      ),
    );
  }
}

class _RulerFrame extends StatelessWidget {
  const _RulerFrame({required this.accent, required this.child});

  final Color accent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(height: 2, color: accent.withValues(alpha: 0.45)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: child,
          ),
          Container(height: 2, color: accent.withValues(alpha: 0.45)),
        ],
      ),
    );
  }
}

class _BehaviorReadout extends StatelessWidget {
  const _BehaviorReadout({required this.accent});

  final Color accent;

  @override
  Widget build(BuildContext context) {
    final behavior = DefaultTextHeightBehavior.maybeOf(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.2)),
      ),
      child: SelectableText(
        'firstAscent=${behavior?.applyHeightToFirstAscent} | '
        'lastDescent=${behavior?.applyHeightToLastDescent} | '
        'leading=${behavior?.leadingDistribution}',
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 10.2,
          color: accent.withValues(alpha: 0.84),
        ),
      ),
    );
  }
}

class _InteractiveScene extends StatelessWidget {
  const _InteractiveScene({
    required this.height,
    required this.firstAscent,
    required this.lastDescent,
    required this.leadingDistribution,
    required this.editorA,
    required this.editorB,
    required this.onHeightChanged,
    required this.onFirstAscentChanged,
    required this.onLastDescentChanged,
    required this.onLeadingChanged,
  });

  final double height;
  final bool firstAscent;
  final bool lastDescent;
  final TextLeadingDistribution leadingDistribution;
  final TextEditingController editorA;
  final TextEditingController editorB;
  final ValueChanged<double> onHeightChanged;
  final ValueChanged<bool> onFirstAscentChanged;
  final ValueChanged<bool> onLastDescentChanged;
  final ValueChanged<TextLeadingDistribution> onLeadingChanged;

  @override
  Widget build(BuildContext context) {
    final behavior = TextHeightBehavior(
      applyHeightToFirstAscent: firstAscent,
      applyHeightToLastDescent: lastDescent,
      leadingDistribution: leadingDistribution,
    );

    return DefaultTextHeightBehavior(
      textHeightBehavior: behavior,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _InfoLine(
            'Adjust controls and watch Text + EditableText spacing update live. This demonstrates inherited behavior in practical UI tuning.',
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F8),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFC8D4DB)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Text height: ${height.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w700)),
                Slider(
                  value: height,
                  min: 1.0,
                  max: 2.4,
                  divisions: 14,
                  onChanged: onHeightChanged,
                ),
                Wrap(
                  spacing: 14,
                  runSpacing: 8,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(value: firstAscent, onChanged: (v) => onFirstAscentChanged(v ?? true)),
                        const Text('applyHeightToFirstAscent'),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(value: lastDescent, onChanged: (v) => onLastDescentChanged(v ?? true)),
                        const Text('applyHeightToLastDescent'),
                      ],
                    ),
                    DropdownButton<TextLeadingDistribution>(
                      value: leadingDistribution,
                      items: const [
                        DropdownMenuItem(
                          value: TextLeadingDistribution.proportional,
                          child: Text('leading: proportional'),
                        ),
                        DropdownMenuItem(
                          value: TextLeadingDistribution.even,
                          child: Text('leading: even'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          onLeadingChanged(value);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              SizedBox(
                width: 300,
                child: _RulerFrame(
                  accent: const Color(0xFF324652),
                  child: Text(
                    'Live preview line one\nLine two with descenders: gyjpq\nLine three for visual rhythm',
                    style: TextStyle(fontSize: 16, height: height),
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: editorA,
                  maxLines: 4,
                  style: TextStyle(fontSize: 16, height: height),
                  decoration: InputDecoration(
                    labelText: 'Editable preview A',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                child: DefaultTextStyle(
                  style: TextStyle(fontSize: 16, height: height, color: const Color(0xFF324652)),
                  textHeightBehavior: const TextHeightBehavior(
                    applyHeightToFirstAscent: false,
                    applyHeightToLastDescent: false,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFBFCED6)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('DefaultTextStyle override sample\n(uses explicit textHeightBehavior)'),
                        const SizedBox(height: 8),
                        TextField(
                          controller: editorB,
                          maxLines: 3,
                          style: TextStyle(fontSize: 16, height: height),
                          decoration: const InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(),
                            labelText: 'Editable preview B',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const _InfoLine(
            'Right panel intentionally uses DefaultTextStyle.textHeightBehavior to demonstrate precedence over inherited DefaultTextHeightBehavior.',
          ),
        ],
      ),
    );
  }
}

class _ArchitectureScene extends StatelessWidget {
  const _ArchitectureScene({
    required this.opsController,
    required this.creativeController,
    required this.researchController,
  });

  final TextEditingController opsController;
  final TextEditingController creativeController;
  final TextEditingController researchController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _InfoLine(
          'Each module below reuses the same editable component while wrapping it in different inherited text-height defaults.',
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            DefaultTextHeightBehavior(
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: true,
                leadingDistribution: TextLeadingDistribution.proportional,
              ),
              child: _ModuleCard(
                title: 'Operations module',
                accent: const Color(0xFF0E6479),
                controller: opsController,
                note: 'Compact top alignment for table-like dashboard blocks.',
              ),
            ),
            DefaultTextHeightBehavior(
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: true,
                applyHeightToLastDescent: true,
                leadingDistribution: TextLeadingDistribution.even,
              ),
              child: _ModuleCard(
                title: 'Creative module',
                accent: const Color(0xFFE17258),
                controller: creativeController,
                note: 'Even leading for visually centered paragraph cards.',
              ),
            ),
            DefaultTextHeightBehavior(
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: true,
                applyHeightToLastDescent: false,
                leadingDistribution: TextLeadingDistribution.proportional,
              ),
              child: _ModuleCard(
                title: 'Research module',
                accent: const Color(0xFF2E7A65),
                controller: researchController,
                note: 'Tighter bottom edge for dense analytical report rows.',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ModuleCard extends StatelessWidget {
  const _ModuleCard({
    required this.title,
    required this.accent,
    required this.controller,
    required this.note,
  });

  final String title;
  final Color accent;
  final TextEditingController controller;
  final String note;

  @override
  Widget build(BuildContext context) {
    final behavior = DefaultTextHeightBehavior.of(context);

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
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: accent)),
            const SizedBox(height: 4),
            Text(note, style: TextStyle(fontSize: 11.2, color: accent.withValues(alpha: 0.83), height: 1.35)),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              maxLines: 3,
              style: const TextStyle(fontSize: 15, height: 1.7),
              decoration: InputDecoration(
                labelText: 'Reusable module editor',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 8),
            SelectableText(
              'first=${behavior.applyHeightToFirstAscent}, '
              'last=${behavior.applyHeightToLastDescent}, '
              'leading=${behavior.leadingDistribution}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
                color: accent.withValues(alpha: 0.84),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecapCard extends StatelessWidget {
  const _RecapCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFFE9F3F8), Color(0xFFF7ECE3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFFB9CBD8)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deep Demo Recap',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF314B5B)),
          ),
          SizedBox(height: 8),
          Text(
            '1) DefaultTextHeightBehavior provides inherited TextHeightBehavior defaults.\n'
            '2) applyHeightToFirstAscent and applyHeightToLastDescent shape top/bottom text edges.\n'
            '3) leadingDistribution changes where extra leading is distributed.\n'
            '4) Interactive tuning helps pick reliable typography behavior per feature.\n'
            '5) Module-level wrappers can enforce consistent text rhythm with zero changes to shared widgets.',
            style: TextStyle(fontSize: 12.4, height: 1.45),
          ),
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: 12.5, height: 1.45));
  }
}

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _DefaultSelectionStyleDemoApp();
}

class _DefaultSelectionStyleDemoApp extends StatelessWidget {
  const _DefaultSelectionStyleDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF105C73)),
        useMaterial3: true,
      ),
      home: const _DefaultSelectionStyleDemoPage(),
    );
  }
}

class _DefaultSelectionStyleDemoPage extends StatefulWidget {
  const _DefaultSelectionStyleDemoPage();

  @override
  State<_DefaultSelectionStyleDemoPage> createState() => _DefaultSelectionStyleDemoPageState();
}

class _DefaultSelectionStyleDemoPageState extends State<_DefaultSelectionStyleDemoPage> {
  final _scene4ControllerA = TextEditingController(text: 'Type here and drag to select words.');
  final _scene4ControllerB = TextEditingController(text: 'The cursor and selection highlight come from scope.');
  final _scene4ControllerC = TextEditingController(text: 'DefaultSelectionStyle can vary per module.');

  final _scene6ControllerA = TextEditingController(text: 'Operations note draft...');
  final _scene6ControllerB = TextEditingController(text: 'Creative campaign copy...');
  final _scene6ControllerC = TextEditingController(text: 'Sustainability summary...');

  @override
  void dispose() {
    _scene4ControllerA.dispose();
    _scene4ControllerB.dispose();
    _scene4ControllerC.dispose();
    _scene6ControllerA.dispose();
    _scene6ControllerB.dispose();
    _scene6ControllerC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const cOcean = Color(0xFF105C73);
    const cCoral = Color(0xFFE26D5A);
    const cForest = Color(0xFF2C7A62);
    const cSlate = Color(0xFF31424F);
    const cSand = Color(0xFFF6F3EC);
    const cViolet = Color(0xFF6A57A3);

    return Scaffold(
      backgroundColor: cSand,
      appBar: AppBar(
        backgroundColor: cOcean,
        foregroundColor: Colors.white,
        toolbarHeight: 72,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('DefaultSelectionStyle Deep Demo'),
            SizedBox(height: 2),
            Text(
              'Inherited selection styling for EditableText and SelectableText',
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
            _HeroBanner(
              ocean: cOcean,
              coral: cCoral,
              forest: cForest,
              violet: cViolet,
            ),
            const SizedBox(height: 14),
            _SceneFrame(
              index: 1,
              title: 'Concept and API Surface',
              subtitle:
                  'Understand what DefaultSelectionStyle provides, what consumes it, and how fallback / of(context) behaves.',
              accent: cOcean,
              child: const _ConceptScene(),
            ),
            const SizedBox(height: 12),
            _SceneFrame(
              index: 2,
              title: 'Scoped Zones with Different Selection Styles',
              subtitle:
                  'Same widgets, different DefaultSelectionStyle ancestors. Nearest scope controls cursor, selection, and mouse cursor.',
              accent: cCoral,
              child: _ScopeZonesScene(
                ocean: cOcean,
                coral: cCoral,
                forest: cForest,
              ),
            ),
            const SizedBox(height: 12),
            _SceneFrame(
              index: 3,
              title: 'merge() for Partial Overrides',
              subtitle:
                  'Parent style defines defaults; nested merge() only overrides selected fields, preserving others automatically.',
              accent: cForest,
              child: _MergeScene(
                ocean: cOcean,
                coral: cCoral,
                violet: cViolet,
              ),
            ),
            const SizedBox(height: 12),
            _SceneFrame(
              index: 4,
              title: 'Interactive Selection and Editing',
              subtitle:
                  'Select text and edit fields to observe how visual feedback changes under different default selection styles.',
              accent: cViolet,
              child: _EditingScene(
                ocean: cOcean,
                coral: cCoral,
                forest: cForest,
                controllerA: _scene4ControllerA,
                controllerB: _scene4ControllerB,
                controllerC: _scene4ControllerC,
              ),
            ),
            const SizedBox(height: 12),
            _SceneFrame(
              index: 5,
              title: 'Mouse Cursor Defaults in Selectable Regions',
              subtitle:
                  'DefaultSelectionStyle can define subtree mouse cursor behavior for hover over selectable text widgets.',
              accent: cSlate,
              child: _MouseCursorScene(
                ocean: cOcean,
                coral: cCoral,
                forest: cForest,
              ),
            ),
            const SizedBox(height: 12),
            _SceneFrame(
              index: 6,
              title: 'Practical Feature-Module Architecture',
              subtitle:
                  'A mini app shell where each module injects local selection style while reusable widgets stay unchanged.',
              accent: const Color(0xFF7A5B3E),
              child: _ArchitectureScene(
                ocean: cOcean,
                coral: cCoral,
                forest: cForest,
                controllerA: _scene6ControllerA,
                controllerB: _scene6ControllerB,
                controllerC: _scene6ControllerC,
              ),
            ),
            const SizedBox(height: 16),
            const _RecapPanel(),
            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({
    required this.ocean,
    required this.coral,
    required this.forest,
    required this.violet,
  });

  final Color ocean;
  final Color coral;
  final Color forest;
  final Color violet;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            ocean,
            ocean.withValues(alpha: 0.84),
            violet.withValues(alpha: 0.78),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'DefaultSelectionStyle',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'An InheritedTheme that provides default cursor color, text selection color, and mouse cursor '
            'for descendant EditableText / SelectableText widgets when they do not define explicit values.',
            style: TextStyle(
              color: Color(0xFFF5FAFF),
              fontSize: 13,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 9,
            runSpacing: 8,
            children: [
              _Pill(label: 'cursorColor', color: coral),
              _Pill(label: 'selectionColor', color: forest),
              _Pill(label: 'mouseCursor', color: const Color(0xFFB2D8E8)),
              _Pill(label: 'of(context)', color: const Color(0xFFECD2BD)),
              _Pill(label: 'merge()', color: const Color(0xFFD4D0F2)),
            ],
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11, color: color),
      ),
    );
  }
}

class _SceneFrame extends StatelessWidget {
  const _SceneFrame({
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
        border: Border.all(color: accent.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.09),
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
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  '$index',
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: accent,
                  ),
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
    final style = DefaultSelectionStyle.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _InfoLine(
          'DefaultSelectionStyle is read by EditableText and selectable text surfaces when those widgets do not provide explicit values.',
        ),
        const SizedBox(height: 8),
        const _InfoLine(
          'Material and Cupertino app shells usually establish it for you; custom wrappers can override it in local subtrees.',
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _ReadoutTile(
              label: 'Current cursorColor',
              value: style.cursorColor?.toARGB32().toRadixString(16).toUpperCase() ?? 'null',
              color: const Color(0xFF105C73),
            ),
            _ReadoutTile(
              label: 'Current selectionColor',
              value: style.selectionColor?.toARGB32().toRadixString(16).toUpperCase() ?? 'null',
              color: const Color(0xFF2C7A62),
            ),
            _ReadoutTile(
              label: 'Current mouseCursor',
              value: style.mouseCursor?.toString() ?? 'null',
              color: const Color(0xFF6A57A3),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F7FB),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFB7CFDD)),
          ),
          child: const SelectableText(
            'DefaultSelectionStyle.of(context)\n\n'
            'DefaultSelectionStyle.merge(\n'
            '  cursorColor: ...,\n'
            '  selectionColor: ...,\n'
            '  mouseCursor: ...,\n'
            '  child: FeatureSubtree(),\n'
            ')',
            style: TextStyle(fontFamily: 'monospace', fontSize: 11.5, height: 1.4),
          ),
        ),
      ],
    );
  }
}

class _ReadoutTile extends StatelessWidget {
  const _ReadoutTile({required this.label, required this.value, required this.color});

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.28)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 12)),
            const SizedBox(height: 5),
            SelectableText(
              value,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: color.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScopeZonesScene extends StatelessWidget {
  const _ScopeZonesScene({
    required this.ocean,
    required this.coral,
    required this.forest,
  });

  final Color ocean;
  final Color coral;
  final Color forest;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _InfoLine(
          'Each panel requests the same reusable text/editor widgets. Differences come only from the local DefaultSelectionStyle scope.',
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            DefaultSelectionStyle(
              cursorColor: ocean,
              selectionColor: ocean.withValues(alpha: 0.28),
              mouseCursor: SystemMouseCursors.text,
              child: _ZonePanel(
                title: 'Ocean scope',
                accent: ocean,
                description: 'Text cursor and selection use ocean palette.',
              ),
            ),
            DefaultSelectionStyle(
              cursorColor: coral,
              selectionColor: coral.withValues(alpha: 0.3),
              mouseCursor: SystemMouseCursors.precise,
              child: _ZonePanel(
                title: 'Coral scope',
                accent: coral,
                description: 'Same widgets, but coral scope changes visuals.',
              ),
            ),
            DefaultSelectionStyle(
              cursorColor: forest,
              selectionColor: forest.withValues(alpha: 0.3),
              mouseCursor: SystemMouseCursors.click,
              child: _ZonePanel(
                title: 'Forest scope',
                accent: forest,
                description: 'Local feature module can own its selection theme.',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ZonePanel extends StatefulWidget {
  const _ZonePanel({
    required this.title,
    required this.accent,
    required this.description,
  });

  final String title;
  final Color accent;
  final String description;

  @override
  State<_ZonePanel> createState() => _ZonePanelState();
}

class _ZonePanelState extends State<_ZonePanel> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: 'Try selecting text in ${widget.title}.');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = DefaultSelectionStyle.of(context);

    return SizedBox(
      width: 300,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: widget.accent.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: widget.accent.withValues(alpha: 0.28)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: TextStyle(color: widget.accent, fontWeight: FontWeight.w800, fontSize: 14)),
            const SizedBox(height: 4),
            Text(widget.description, style: const TextStyle(fontSize: 11.7, height: 1.35)),
            const SizedBox(height: 8),
            SelectableText(
              'Reusable paragraph: drag-select this sentence to inspect highlight color behavior.',
              style: TextStyle(fontSize: 12, color: widget.accent.withValues(alpha: 0.9)),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Editable sample',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                isDense: true,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'cursor=${style.cursorColor} | selection=${style.selectionColor} | mouse=${style.mouseCursor}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
                color: widget.accent.withValues(alpha: 0.84),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MergeScene extends StatelessWidget {
  const _MergeScene({
    required this.ocean,
    required this.coral,
    required this.violet,
  });

  final Color ocean;
  final Color coral;
  final Color violet;

  @override
  Widget build(BuildContext context) {
    return DefaultSelectionStyle(
      cursorColor: ocean,
      selectionColor: ocean.withValues(alpha: 0.26),
      mouseCursor: SystemMouseCursors.text,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _InfoLine(
            'Base scope sets all 3 fields. Nested merge() calls override only one field at a time, inheriting the rest.',
          ),
          const SizedBox(height: 10),
          _MergeProbe(
            title: 'Base scope (all fields from parent)',
            accent: ocean,
          ),
          const SizedBox(height: 10),
          DefaultSelectionStyle.merge(
            selectionColor: coral.withValues(alpha: 0.3),
            child: _MergeProbe(
              title: 'merge(selectionColor: coral)',
              accent: coral,
            ),
          ),
          const SizedBox(height: 10),
          DefaultSelectionStyle.merge(
            mouseCursor: SystemMouseCursors.forbidden,
            child: _MergeProbe(
              title: 'merge(mouseCursor: forbidden)',
              accent: violet,
            ),
          ),
          const SizedBox(height: 10),
          DefaultSelectionStyle.merge(
            cursorColor: const Color(0xFFAA3E9B),
            selectionColor: const Color(0x50AA3E9B),
            child: const _MergeProbe(
              title: 'merge(cursorColor + selectionColor)',
              accent: Color(0xFFAA3E9B),
            ),
          ),
        ],
      ),
    );
  }
}

class _MergeProbe extends StatefulWidget {
  const _MergeProbe({
    required this.title,
    required this.accent,
  });

  final String title;
  final Color accent;

  @override
  State<_MergeProbe> createState() => _MergeProbeState();
}

class _MergeProbeState extends State<_MergeProbe> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: 'Merge probe text. Select me.');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = DefaultSelectionStyle.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: widget.accent.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.accent.withValues(alpha: 0.26)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title, style: TextStyle(fontWeight: FontWeight.w800, color: widget.accent)),
          const SizedBox(height: 7),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              isDense: true,
              labelText: 'Try selecting and moving cursor',
            ),
          ),
          const SizedBox(height: 7),
          Text(
            'cursor=${style.cursorColor} | selection=${style.selectionColor} | mouse=${style.mouseCursor}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.4,
              color: widget.accent.withValues(alpha: 0.86),
            ),
          ),
        ],
      ),
    );
  }
}

class _EditingScene extends StatelessWidget {
  const _EditingScene({
    required this.ocean,
    required this.coral,
    required this.forest,
    required this.controllerA,
    required this.controllerB,
    required this.controllerC,
  });

  final Color ocean;
  final Color coral;
  final Color forest;
  final TextEditingController controllerA;
  final TextEditingController controllerB;
  final TextEditingController controllerC;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _InfoLine(
          'This scene is intentionally interaction-heavy: click into each editor, type, drag text selection, and compare visual feedback.',
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            DefaultSelectionStyle(
              cursorColor: ocean,
              selectionColor: ocean.withValues(alpha: 0.28),
              child: _EditorCard(
                accent: ocean,
                title: 'Operations Draft',
                description: 'Calm blue selection style for data-heavy workflows.',
                controller: controllerA,
                sample: const SelectableText(
                  'Operations team note: inspect vessel queue before 17:30 and prioritize critical loads.',
                ),
              ),
            ),
            DefaultSelectionStyle(
              cursorColor: coral,
              selectionColor: coral.withValues(alpha: 0.3),
              child: _EditorCard(
                accent: coral,
                title: 'Campaign Draft',
                description: 'Warm coral style for content and collaboration surfaces.',
                controller: controllerB,
                sample: const SelectableText(
                  'Creative review checkpoint: align hero statement with launch campaign visuals and CTA.',
                ),
              ),
            ),
            DefaultSelectionStyle(
              cursorColor: forest,
              selectionColor: forest.withValues(alpha: 0.3),
              child: _EditorCard(
                accent: forest,
                title: 'Research Draft',
                description: 'Green style for technical or sustainability contexts.',
                controller: controllerC,
                sample: const SelectableText(
                  'Research summary: compare model deltas and confirm confidence intervals before publishing.',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _EditorCard extends StatelessWidget {
  const _EditorCard({
    required this.accent,
    required this.title,
    required this.description,
    required this.controller,
    required this.sample,
  });

  final Color accent;
  final String title;
  final String description;
  final TextEditingController controller;
  final Widget sample;

  @override
  Widget build(BuildContext context) {
    final style = DefaultSelectionStyle.of(context);

    return SizedBox(
      width: 300,
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
            Text(title, style: TextStyle(fontWeight: FontWeight.w800, color: accent, fontSize: 14)),
            const SizedBox(height: 3),
            Text(description, style: const TextStyle(fontSize: 11.4, height: 1.35)),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: accent.withValues(alpha: 0.22)),
              ),
              child: sample,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              maxLines: 2,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                labelText: 'Editable draft',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'style -> cursor:${style.cursorColor}, selection:${style.selectionColor}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 9.8,
                color: accent.withValues(alpha: 0.86),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MouseCursorScene extends StatelessWidget {
  const _MouseCursorScene({
    required this.ocean,
    required this.coral,
    required this.forest,
  });

  final Color ocean;
  final Color coral;
  final Color forest;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _InfoLine(
          'Hover behavior is most visible on desktop/web. These panels advertise active mouseCursor and still provide selectable text interaction.',
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            DefaultSelectionStyle(
              cursorColor: ocean,
              selectionColor: ocean.withValues(alpha: 0.26),
              mouseCursor: SystemMouseCursors.text,
              child: _MouseCursorCard(
                title: 'SystemMouseCursors.text',
                accent: ocean,
              ),
            ),
            DefaultSelectionStyle(
              cursorColor: coral,
              selectionColor: coral.withValues(alpha: 0.26),
              mouseCursor: SystemMouseCursors.precise,
              child: _MouseCursorCard(
                title: 'SystemMouseCursors.precise',
                accent: coral,
              ),
            ),
            DefaultSelectionStyle(
              cursorColor: forest,
              selectionColor: forest.withValues(alpha: 0.26),
              mouseCursor: SystemMouseCursors.grab,
              child: _MouseCursorCard(
                title: 'SystemMouseCursors.grab',
                accent: forest,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MouseCursorCard extends StatelessWidget {
  const _MouseCursorCard({required this.title, required this.accent});

  final String title;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final style = DefaultSelectionStyle.of(context);

    return SizedBox(
      width: 300,
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
            Text(title, style: TextStyle(fontWeight: FontWeight.w800, color: accent)),
            const SizedBox(height: 6),
            const SelectableText(
              'Hover and select this sentence. In desktop/web, cursor shape should match the scoped mouseCursor default.',
              style: TextStyle(fontSize: 12.2, height: 1.35),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: accent.withValues(alpha: 0.22)),
              ),
              child: SelectableText(
                'mouseCursor resolved: ${style.mouseCursor}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.5,
                  color: accent.withValues(alpha: 0.84),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArchitectureScene extends StatelessWidget {
  const _ArchitectureScene({
    required this.ocean,
    required this.coral,
    required this.forest,
    required this.controllerA,
    required this.controllerB,
    required this.controllerC,
  });

  final Color ocean;
  final Color coral;
  final Color forest;
  final TextEditingController controllerA;
  final TextEditingController controllerB;
  final TextEditingController controllerC;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _InfoLine(
          'Reusable editor module below does not hardcode cursor or selection visuals. Each feature wrapper injects local DefaultSelectionStyle.',
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F0E7),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFD2BDA7)),
          ),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              DefaultSelectionStyle.merge(
                cursorColor: ocean,
                selectionColor: ocean.withValues(alpha: 0.28),
                mouseCursor: SystemMouseCursors.text,
                child: _FeatureModuleCard(
                  title: 'Operations module',
                  accent: ocean,
                  controller: controllerA,
                  keyName: 'module.operations.editor',
                  prompt:
                      'Inspect route exceptions, then annotate shipment notes before handoff.',
                ),
              ),
              DefaultSelectionStyle.merge(
                cursorColor: coral,
                selectionColor: coral.withValues(alpha: 0.3),
                mouseCursor: SystemMouseCursors.precise,
                child: _FeatureModuleCard(
                  title: 'Creative module',
                  accent: coral,
                  controller: controllerB,
                  keyName: 'module.creative.editor',
                  prompt:
                      'Revise campaign copy to match launch tone and short-form constraints.',
                ),
              ),
              DefaultSelectionStyle.merge(
                cursorColor: forest,
                selectionColor: forest.withValues(alpha: 0.3),
                mouseCursor: SystemMouseCursors.grab,
                child: _FeatureModuleCard(
                  title: 'Sustainability module',
                  accent: forest,
                  controller: controllerC,
                  keyName: 'module.sustainability.editor',
                  prompt:
                      'Capture emissions delta rationale and attach supporting narrative.',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FeatureModuleCard extends StatelessWidget {
  const _FeatureModuleCard({
    required this.title,
    required this.accent,
    required this.controller,
    required this.keyName,
    required this.prompt,
  });

  final String title;
  final Color accent;
  final TextEditingController controller;
  final String keyName;
  final String prompt;

  @override
  Widget build(BuildContext context) {
    final style = DefaultSelectionStyle.of(context);

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
            Text(
              keyName,
              style: TextStyle(fontFamily: 'monospace', fontSize: 10.2, color: accent.withValues(alpha: 0.84)),
            ),
            const SizedBox(height: 8),
            SelectableText(prompt, style: const TextStyle(fontSize: 12, height: 1.35)),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              maxLines: 2,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                labelText: 'Module editor',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Resolved -> cursor:${style.cursorColor} | selection:${style.selectionColor} | mouse:${style.mouseCursor}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 9.5,
                color: accent.withValues(alpha: 0.84),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecapPanel extends StatelessWidget {
  const _RecapPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFFE8F3F8), Color(0xFFF6ECE2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFFB8CBD7)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deep Demo Recap',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF304B66)),
          ),
          SizedBox(height: 8),
          Text(
            '1) DefaultSelectionStyle supplies default cursor/selection/mouse behavior through inherited scope.\n'
            '2) Nearest ancestor wins; same widgets can look different by subtree.\n'
            '3) merge() is ideal for partial overrides without copying all fields.\n'
            '4) Interactive editors and selectable text clearly reveal scoped behavior.\n'
            '5) Feature modules can inject local defaults while shared widgets stay generic.',
            style: TextStyle(fontSize: 12.5, height: 1.45),
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

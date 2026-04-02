import 'package:flutter/material.dart';

const _page = Color(0xFFF3F7FC);
const _ink = Color(0xFF17384F);
const _blue = Color(0xFF2B6799);
const _teal = Color(0xFF2E8270);
const _amber = Color(0xFFAF7A34);
const _rose = Color(0xFF9C5F75);
const _violet = Color(0xFF685CB3);

dynamic build(BuildContext context) {
  return const _NavigationToolbarDeepDemoApp();
}

class _NavigationToolbarDeepDemoApp extends StatelessWidget {
  const _NavigationToolbarDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _blue),
        scaffoldBackgroundColor: _page,
      ),
      home: const _NavigationToolbarDeepDemoPage(),
    );
  }
}

class _NavigationToolbarDeepDemoPage extends StatefulWidget {
  const _NavigationToolbarDeepDemoPage();

  @override
  State<_NavigationToolbarDeepDemoPage> createState() => _NavigationToolbarDeepDemoPageState();
}

class _NavigationToolbarDeepDemoPageState extends State<_NavigationToolbarDeepDemoPage> {
  bool _compact = false;
  bool _guides = true;
  bool _notes = true;
  bool _rtl = false;
  double _zoom = 1.0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _ink,
          foregroundColor: Colors.white,
          toolbarHeight: 94,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('NavigationToolbar Deep Demo'),
              Text(
                'leading-middle-trailing composition | spacing and alignment behavior | responsive top-bar strategies',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.86), fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _GlobalDeck(
                compact: _compact,
                guides: _guides,
                notes: _notes,
                rtl: _rtl,
                zoom: _zoom,
                onCompactChanged: (v) => setState(() => _compact = v),
                onGuidesChanged: (v) => setState(() => _guides = v),
                onNotesChanged: (v) => setState(() => _notes = v),
                onRtlChanged: (v) => setState(() => _rtl = v),
                onZoomChanged: (v) => setState(() => _zoom = v),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 1,
                tone: _blue,
                title: 'NavigationToolbar Fundamentals Studio',
                subtitle:
                    'Tune centerMiddle, middleSpacing, and slot visibility while observing how leading, middle, and trailing are arranged.',
                child: _FundamentalsScene(compact: _compact, guides: _guides, notes: _notes, zoom: _zoom),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 2,
                tone: _teal,
                title: 'Alignment and Spacing Comparison Lab',
                subtitle:
                    'Side-by-side bars compare spacing profiles and center modes so layout differences are clear at a glance.',
                child: _ComparisonScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 3,
                tone: _amber,
                title: 'Responsive Header Workshop',
                subtitle:
                    'Preview toolbar behavior across narrow and wide frames with long titles, action density, and adaptive slot widgets.',
                child: _ResponsiveScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 4,
                tone: _rose,
                title: 'Directionality and Semantics Stage',
                subtitle:
                    'Visualize how slot placement reacts to LTR/RTL directionality and how top bars can include explicit semantics cues.',
                child: _DirectionalityScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 5,
                tone: _violet,
                title: 'Practical Product Console',
                subtitle:
                    'Three realistic modules use NavigationToolbar for dashboard, operations, and release contexts with instructive controls.',
                child: _PracticalScene(compact: _compact, guides: _guides, notes: _notes),
              ),
              const SizedBox(height: 12),
              const _RecapPanel(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlobalDeck extends StatelessWidget {
  const _GlobalDeck({
    required this.compact,
    required this.guides,
    required this.notes,
    required this.rtl,
    required this.zoom,
    required this.onCompactChanged,
    required this.onGuidesChanged,
    required this.onNotesChanged,
    required this.onRtlChanged,
    required this.onZoomChanged,
  });

  final bool compact;
  final bool guides;
  final bool notes;
  final bool rtl;
  final double zoom;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onGuidesChanged;
  final ValueChanged<bool> onNotesChanged;
  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<double> onZoomChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF18374D), Color(0xFF296A9D), Color(0xFF36816F), Color(0xFF675CB2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'NavigationToolbar Control Deck',
            style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          const Text(
            'NavigationToolbar is a low-level top-bar layout utility that arranges leading, middle, and trailing slots. '
            'It powers flexible app-header patterns where you need precise control over center alignment and spacing.',
            style: TextStyle(color: Color(0xFFDCECF8), height: 1.35),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: SwitchListTile(
                  value: compact,
                  onChanged: onCompactChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Compact scenes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: guides,
                  onChanged: onGuidesChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Guide overlays', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: notes,
                  onChanged: onNotesChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Instruction notes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: rtl,
                  onChanged: onRtlChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('RTL mode', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
          Text('Global scene zoom: ${zoom.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          Slider(
            value: zoom,
            min: 0.8,
            max: 1.35,
            divisions: 11,
            onChanged: onZoomChanged,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.32),
          ),
        ],
      ),
    );
  }
}

class _SceneShell extends StatelessWidget {
  const _SceneShell({
    required this.index,
    required this.tone,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final int index;
  final Color tone;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 14, offset: const Offset(0, 7)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: tone,
                  foregroundColor: Colors.white,
                  child: Text('$index', style: const TextStyle(fontWeight: FontWeight.w800)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800, fontSize: 19)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: const TextStyle(color: Color(0xFF3A4F61), height: 1.34)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}

class _FundamentalsScene extends StatefulWidget {
  const _FundamentalsScene({required this.compact, required this.guides, required this.notes, required this.zoom});

  final bool compact;
  final bool guides;
  final bool notes;
  final double zoom;

  @override
  State<_FundamentalsScene> createState() => _FundamentalsSceneState();
}

class _FundamentalsSceneState extends State<_FundamentalsScene> {
  bool _centerMiddle = true;
  double _middleSpacing = 16;
  bool _showLeading = true;
  bool _showMiddle = true;
  bool _showTrailing = true;
  String _titleText = 'Control Bridge Dashboard';
  int _leadingTap = 0;
  int _trailingTap = 0;
  final List<String> _events = <String>[];

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 930.0 : 1080.0;
    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Fundamentals controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        value: _centerMiddle,
                        onChanged: (v) => setState(() => _centerMiddle = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('centerMiddle'),
                      ),
                      SwitchListTile(
                        value: _showLeading,
                        onChanged: (v) => setState(() => _showLeading = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show leading'),
                      ),
                      SwitchListTile(
                        value: _showMiddle,
                        onChanged: (v) => setState(() => _showMiddle = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show middle'),
                      ),
                      SwitchListTile(
                        value: _showTrailing,
                        onChanged: (v) => setState(() => _showTrailing = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show trailing'),
                      ),
                      const SizedBox(height: 8),
                      _MiniSlider(
                        label: 'middleSpacing',
                        value: _middleSpacing,
                        min: 0,
                        max: 56,
                        onChanged: (v) => setState(() => _middleSpacing = v),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: TextEditingController(text: _titleText),
                        decoration: const InputDecoration(
                          labelText: 'Middle title text',
                          border: OutlineInputBorder(),
                        ),
                        onSubmitted: (v) {
                          setState(() => _titleText = v.trim().isEmpty ? _titleText : v.trim());
                          _push('title updated');
                        },
                      ),
                      const SizedBox(height: 8),
                      _DataTableCard(
                        rows: [
                          _DataRowItem('centerMiddle', _centerMiddle ? 'true' : 'false'),
                          _DataRowItem('middleSpacing', _middleSpacing.toStringAsFixed(1)),
                          _DataRowItem('leading taps', '$_leadingTap'),
                          _DataRowItem('trailing taps', '$_trailingTap'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _blue,
                          lines: const [
                            'NavigationToolbar gives low-level slot control for leading, middle, and trailing areas.',
                            'centerMiddle changes whether middle content is centered in available space or starts after leading and spacing.',
                            'middleSpacing affects the gap between leading and middle when middle is not centered.',
                          ],
                        ),
                      const SizedBox(height: 8),
                      const Text('Fundamentals events', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      SizedBox(height: 180, child: _LogCard(lines: _events)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _PanelSurface(
              guides: widget.guides,
              child: Transform.scale(
                scale: widget.zoom,
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      _ToolbarCard(
                        tone: _blue,
                        title: 'Primary Top Bar',
                        subtitle: 'Direct fundamentals toolbar with current control values.',
                        toolbar: _makeToolbar(
                          leadingColor: _blue,
                          trailingColor: _teal,
                          middleText: _titleText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _ToolbarCard(
                        tone: _teal,
                        title: 'Operations Header',
                        subtitle: 'Same rules with longer middle text and dense trailing actions.',
                        toolbar: _makeToolbar(
                          leadingColor: _teal,
                          trailingColor: _amber,
                          middleText: 'Ops Route / Stage / ${_titleText.split(' ').first}',
                        ),
                      ),
                      const SizedBox(height: 8),
                      _ToolbarCard(
                        tone: _amber,
                        title: 'Minimal Header',
                        subtitle: 'Simple variant emphasizing slot visibility toggles.',
                        toolbar: _makeToolbar(
                          leadingColor: _amber,
                          trailingColor: _rose,
                          middleText: 'Minimal Header Demo',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: _blue.withValues(alpha: 0.26)),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Observation helper', style: TextStyle(fontWeight: FontWeight.w800)),
                              SizedBox(height: 6),
                              Text(
                                'Toggle centerMiddle and middleSpacing while watching where the middle slot settles. '
                                'Then hide leading or trailing to understand fallback space allocation.',
                                style: TextStyle(height: 1.35),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _makeToolbar({
    required Color leadingColor,
    required Color trailingColor,
    required String middleText,
  }) {
    return NavigationToolbar(
      centerMiddle: _centerMiddle,
      middleSpacing: _middleSpacing,
      leading: _showLeading
          ? FilledButton.tonal(
              onPressed: () {
                setState(() => _leadingTap += 1);
                _push('leading pressed');
              },
              style: FilledButton.styleFrom(backgroundColor: leadingColor.withValues(alpha: 0.12)),
              child: const Text('Back'),
            )
          : null,
      middle: _showMiddle
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: leadingColor.withValues(alpha: 0.24)),
              ),
              child: Text(
                middleText,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(color: leadingColor, fontWeight: FontWeight.w800),
              ),
            )
          : null,
      trailing: _showTrailing
          ? Wrap(
              spacing: 6,
              children: [
                FilledButton.tonal(
                  onPressed: () {
                    setState(() => _trailingTap += 1);
                    _push('trail A pressed');
                  },
                  style: FilledButton.styleFrom(backgroundColor: trailingColor.withValues(alpha: 0.12)),
                  child: const Text('Save'),
                ),
                FilledButton.tonal(
                  onPressed: () {
                    setState(() => _trailingTap += 1);
                    _push('trail B pressed');
                  },
                  style: FilledButton.styleFrom(backgroundColor: trailingColor.withValues(alpha: 0.12)),
                  child: const Text('Share'),
                ),
              ],
            )
          : null,
    );
  }

  void _push(String msg) {
    setState(() {
      _events.insert(0, '${_clock()} | $msg');
      _trim(_events, 32);
    });
  }
}

class _ToolbarCard extends StatelessWidget {
  const _ToolbarCard({
    required this.tone,
    required this.title,
    required this.subtitle,
    required this.toolbar,
  });

  final Color tone;
  final String title;
  final String subtitle;
  final Widget toolbar;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tone.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(color: tone.withValues(alpha: 0.12), blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: toolbar,
          ),
        ],
      ),
    );
  }
}

class _ComparisonScene extends StatefulWidget {
  const _ComparisonScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_ComparisonScene> createState() => _ComparisonSceneState();
}

class _ComparisonSceneState extends State<_ComparisonScene> {
  final List<String> _events = <String>[];

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 940.0 : 1120.0;
    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Comparison notes', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    const Text(
                      'Each card below uses NavigationToolbar with fixed slot widgets but different centerMiddle and middleSpacing values.',
                      style: TextStyle(height: 1.35),
                    ),
                    const SizedBox(height: 8),
                    if (widget.notes)
                      _InstructionCard(
                        tone: _teal,
                        lines: const [
                          'centerMiddle=true keeps middle content centered as long as constraints allow.',
                          'centerMiddle=false aligns middle content after leading and middleSpacing.',
                          'Large middleSpacing can intentionally separate controls in dense navigation contexts.',
                        ],
                      ),
                    const SizedBox(height: 8),
                    const Text('Comparison event timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Expanded(child: _LogCard(lines: _events)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.05,
                  children: [
                    _ComparisonCard(
                      tone: _blue,
                      title: 'Centered / spacing 0',
                      centerMiddle: true,
                      middleSpacing: 0,
                      onEvent: (e) => _push(e),
                    ),
                    _ComparisonCard(
                      tone: _teal,
                      title: 'Centered / spacing 24',
                      centerMiddle: true,
                      middleSpacing: 24,
                      onEvent: (e) => _push(e),
                    ),
                    _ComparisonCard(
                      tone: _amber,
                      title: 'Start / spacing 8',
                      centerMiddle: false,
                      middleSpacing: 8,
                      onEvent: (e) => _push(e),
                    ),
                    _ComparisonCard(
                      tone: _rose,
                      title: 'Start / spacing 36',
                      centerMiddle: false,
                      middleSpacing: 36,
                      onEvent: (e) => _push(e),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _push(String msg) {
    setState(() {
      _events.insert(0, '${_clock()} | $msg');
      _trim(_events, 44);
    });
  }
}

class _ComparisonCard extends StatefulWidget {
  const _ComparisonCard({
    required this.tone,
    required this.title,
    required this.centerMiddle,
    required this.middleSpacing,
    required this.onEvent,
  });

  final Color tone;
  final String title;
  final bool centerMiddle;
  final double middleSpacing;
  final ValueChanged<String> onEvent;

  @override
  State<_ComparisonCard> createState() => _ComparisonCardState();
}

class _ComparisonCardState extends State<_ComparisonCard> {
  int _tapCount = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.tone.withValues(alpha: 0.32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title, style: TextStyle(color: widget.tone, fontWeight: FontWeight.w800, fontSize: 12)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: widget.tone.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: NavigationToolbar(
              centerMiddle: widget.centerMiddle,
              middleSpacing: widget.middleSpacing,
              leading: FilledButton.tonal(
                onPressed: () {
                  setState(() => _tapCount += 1);
                  widget.onEvent('${widget.title}: leading pressed');
                },
                child: const Text('Menu'),
              ),
              middle: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: widget.tone.withValues(alpha: 0.25)),
                ),
                child: const Text('Comparison Title', maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
              trailing: FilledButton.tonal(
                onPressed: () {
                  setState(() => _tapCount += 1);
                  widget.onEvent('${widget.title}: trailing pressed');
                },
                child: const Text('Action'),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text('taps: $_tapCount', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
          Text(
            'centerMiddle=${widget.centerMiddle} | spacing=${widget.middleSpacing.toStringAsFixed(0)}',
            style: const TextStyle(fontSize: 11),
          ),
          const Spacer(),
          const Text(
            'Compare where middle sits relative to leading/trailing under the same slot sizes.',
            style: TextStyle(fontSize: 11, height: 1.3),
          ),
        ],
      ),
    );
  }
}

class _ResponsiveScene extends StatefulWidget {
  const _ResponsiveScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_ResponsiveScene> createState() => _ResponsiveSceneState();
}

class _ResponsiveSceneState extends State<_ResponsiveScene> {
  double _frameWidth = 420;
  bool _denseActions = false;
  bool _centerMiddle = true;
  final List<String> _events = <String>[];

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 950.0 : 1140.0;
    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Responsive controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      _MiniSlider(
                        label: 'Frame width',
                        value: _frameWidth,
                        min: 280,
                        max: 680,
                        onChanged: (v) => setState(() => _frameWidth = v),
                      ),
                      SwitchListTile(
                        value: _denseActions,
                        onChanged: (v) => setState(() => _denseActions = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Dense trailing actions'),
                      ),
                      SwitchListTile(
                        value: _centerMiddle,
                        onChanged: (v) => setState(() => _centerMiddle = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('centerMiddle'),
                      ),
                      const SizedBox(height: 8),
                      _DataTableCard(
                        rows: [
                          _DataRowItem('frame width', _frameWidth.toStringAsFixed(0)),
                          _DataRowItem('dense actions', _denseActions ? 'true' : 'false'),
                          _DataRowItem('centerMiddle', _centerMiddle ? 'true' : 'false'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _amber,
                          lines: const [
                            'NavigationToolbar does not auto-collapse slot widgets; responsive behavior comes from the widgets you place in each slot.',
                            'As width narrows, long middle titles should truncate and trailing actions may need compaction.',
                            'Test centerMiddle with narrow widths to avoid visual crowding around leading/trailing controls.',
                          ],
                        ),
                      const SizedBox(height: 8),
                      const Text('Responsive event timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      SizedBox(height: 200, child: _LogCard(lines: _events)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _PanelSurface(
              guides: widget.guides,
              child: Center(
                child: Container(
                  width: _frameWidth,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _amber.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Responsive frame preview', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _amber.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: NavigationToolbar(
                          centerMiddle: _centerMiddle,
                          middleSpacing: 12,
                          leading: FilledButton.tonal(
                            onPressed: () => _push('leading pressed'),
                            child: const Text('Back'),
                          ),
                          middle: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: _amber.withValues(alpha: 0.25)),
                            ),
                            child: const Text(
                              'Long report title: release preparation and deployment readiness',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          trailing: _denseActions
                              ? Wrap(
                                  spacing: 6,
                                  children: [
                                    FilledButton.tonal(onPressed: () => _push('trail save'), child: const Text('Save')),
                                    FilledButton.tonal(onPressed: () => _push('trail export'), child: const Text('Export')),
                                    FilledButton.tonal(onPressed: () => _push('trail publish'), child: const Text('Publish')),
                                  ],
                                )
                              : FilledButton.tonal(onPressed: () => _push('trail action'), child: const Text('Action')),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: _amber.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Responsive tips', style: TextStyle(fontWeight: FontWeight.w800)),
                              SizedBox(height: 6),
                              Text('1) Keep middle text ellipsized for narrow widths.'),
                              Text('2) Reduce trailing action count when space is constrained.'),
                              Text('3) Validate centerMiddle with both compact and wide layouts.'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _push(String msg) {
    setState(() {
      _events.insert(0, '${_clock()} | $msg');
      _trim(_events, 40);
    });
  }
}

class _DirectionalityScene extends StatefulWidget {
  const _DirectionalityScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_DirectionalityScene> createState() => _DirectionalitySceneState();
}

class _DirectionalitySceneState extends State<_DirectionalityScene> {
  bool _rtlLocal = false;
  bool _centerMiddle = true;
  final List<String> _events = <String>[];

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 960.0 : 1140.0;
    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Directionality controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        value: _rtlLocal,
                        onChanged: (v) => setState(() => _rtlLocal = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Use RTL for this scene'),
                      ),
                      SwitchListTile(
                        value: _centerMiddle,
                        onChanged: (v) => setState(() => _centerMiddle = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('centerMiddle'),
                      ),
                      const SizedBox(height: 8),
                      _DataTableCard(
                        rows: [
                          _DataRowItem('direction', _rtlLocal ? 'RTL' : 'LTR'),
                          _DataRowItem('centerMiddle', _centerMiddle ? 'true' : 'false'),
                          _DataRowItem('events', '${_events.length}'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _rose,
                          lines: const [
                            'NavigationToolbar follows ambient text direction when placing leading and trailing regions.',
                            'Direction-aware icons and labels help avoid confusion in mixed-language products.',
                            'Always test top bars in both LTR and RTL when your app targets multilingual audiences.',
                          ],
                        ),
                      const SizedBox(height: 8),
                      const Text('Directionality events', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      SizedBox(height: 210, child: _LogCard(lines: _events)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _PanelSurface(
              guides: widget.guides,
              child: Directionality(
                textDirection: _rtlLocal ? TextDirection.rtl : TextDirection.ltr,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      _ToolbarCard(
                        tone: _rose,
                        title: 'Localized Header',
                        subtitle: 'Direction-aware composition sample.',
                        toolbar: NavigationToolbar(
                          centerMiddle: _centerMiddle,
                          middleSpacing: 14,
                          leading: FilledButton.tonal(
                            onPressed: () => _push('leading pressed'),
                            child: Text(_rtlLocal ? 'رجوع' : 'Back'),
                          ),
                          middle: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: _rose.withValues(alpha: 0.25)),
                            ),
                            child: Text(_rtlLocal ? 'لوحة الملاحة' : 'Navigation Board'),
                          ),
                          trailing: FilledButton.tonal(
                            onPressed: () => _push('trailing pressed'),
                            child: Text(_rtlLocal ? 'إجراء' : 'Action'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _ToolbarCard(
                        tone: _violet,
                        title: 'Semantics Focus Header',
                        subtitle: 'Adds explicit semantic labels around controls.',
                        toolbar: NavigationToolbar(
                          centerMiddle: _centerMiddle,
                          middleSpacing: 20,
                          leading: Semantics(
                            label: _rtlLocal ? 'التحكم في الرجوع' : 'Back control',
                            button: true,
                            child: FilledButton.tonal(
                              onPressed: () => _push('semantic back pressed'),
                              child: Text(_rtlLocal ? 'عودة' : 'Return'),
                            ),
                          ),
                          middle: Semantics(
                            label: _rtlLocal ? 'عنوان المرحلة الحالية' : 'Current stage title',
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: _violet.withValues(alpha: 0.25)),
                              ),
                              child: Text(_rtlLocal ? 'مرحلة الإطلاق' : 'Release Stage'),
                            ),
                          ),
                          trailing: Semantics(
                            label: _rtlLocal ? 'زر التأكيد' : 'Confirm button',
                            button: true,
                            child: FilledButton.tonal(
                              onPressed: () => _push('semantic confirm pressed'),
                              child: Text(_rtlLocal ? 'تأكيد' : 'Confirm'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: _rose.withValues(alpha: 0.24)),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Directionality checklist', style: TextStyle(fontWeight: FontWeight.w800)),
                              SizedBox(height: 6),
                              Text('1) Verify slot order in LTR and RTL.'),
                              Text('2) Use localized labels and direction-sensitive iconography.'),
                              Text('3) Include semantics labels for assistive technologies.'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _push(String msg) {
    setState(() {
      _events.insert(0, '${_clock()} | $msg');
      _trim(_events, 40);
    });
  }
}

class _PracticalScene extends StatefulWidget {
  const _PracticalScene({required this.compact, required this.guides, required this.notes});

  final bool compact;
  final bool guides;
  final bool notes;

  @override
  State<_PracticalScene> createState() => _PracticalSceneState();
}

class _PracticalSceneState extends State<_PracticalScene> {
  final List<String> _events = <String>[];
  int _revision = 1;

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 1170.0 : 1370.0;
    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilledButton.tonal(
                          onPressed: () => setState(() => _revision += 1),
                          child: Text('Refresh modules ($_revision)'),
                        ),
                        FilledButton.tonal(
                          onPressed: () {
                            setState(() {
                              _events.insert(0, '${_clock()} | snapshot captured');
                              _trim(_events, 60);
                            });
                          },
                          child: const Text('Capture snapshot'),
                        ),
                        FilledButton.tonal(
                          onPressed: () => setState(() => _events.clear()),
                          child: const Text('Clear events'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: _PracticalModule(
                              tone: _blue,
                              title: 'Dashboard Header',
                              subtitle: 'Status-centric top bar with centered context title.',
                              revision: _revision,
                              onEvent: (e) => _push('dashboard: $e'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _PracticalModule(
                              tone: _teal,
                              title: 'Operations Header',
                              subtitle: 'Action-heavy top bar for operations control.',
                              revision: _revision,
                              onEvent: (e) => _push('operations: $e'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _PracticalModule(
                              tone: _violet,
                              title: 'Release Header',
                              subtitle: 'Stage-oriented top bar for release milestones.',
                              revision: _revision,
                              onEvent: (e) => _push('release: $e'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guides: widget.guides,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Practical guidance', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    if (widget.notes)
                      _InstructionCard(
                        tone: _violet,
                        lines: const [
                          'NavigationToolbar is excellent when AppBar-level behavior is too rigid for custom product headers.',
                          'Use consistent slot semantics across modules so users always know where navigation and actions are located.',
                          'Document your centerMiddle and spacing conventions to keep top-bar behavior coherent across teams.',
                        ],
                      ),
                    const SizedBox(height: 8),
                    _DataTableCard(
                      rows: [
                        _DataRowItem('module revision', '$_revision'),
                        _DataRowItem('event count', '${_events.length}'),
                        _DataRowItem('time', _clock()),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('Practical event timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Expanded(child: _LogCard(lines: _events)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _push(String msg) {
    setState(() {
      _events.insert(0, '${_clock()} | $msg');
      _trim(_events, 60);
    });
  }
}

class _PracticalModule extends StatefulWidget {
  const _PracticalModule({
    required this.tone,
    required this.title,
    required this.subtitle,
    required this.revision,
    required this.onEvent,
  });

  final Color tone;
  final String title;
  final String subtitle;
  final int revision;
  final ValueChanged<String> onEvent;

  @override
  State<_PracticalModule> createState() => _PracticalModuleState();
}

class _PracticalModuleState extends State<_PracticalModule> {
  bool _centerMiddle = true;
  double _spacing = 16;
  int _tapCount = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.tone.withValues(alpha: 0.32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(widget.title, style: TextStyle(color: widget.tone, fontWeight: FontWeight.w800))),
              _ToneChip(tone: widget.tone, label: 'rev ${widget.revision}'),
            ],
          ),
          const SizedBox(height: 3),
          Text(widget.subtitle, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: widget.tone.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: NavigationToolbar(
              centerMiddle: _centerMiddle,
              middleSpacing: _spacing,
              leading: FilledButton.tonal(
                onPressed: () {
                  setState(() => _tapCount += 1);
                  widget.onEvent('${widget.title}: leading pressed');
                },
                child: const Text('Nav'),
              ),
              middle: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: widget.tone.withValues(alpha: 0.25)),
                ),
                child: Text(widget.title, overflow: TextOverflow.ellipsis),
              ),
              trailing: Wrap(
                spacing: 6,
                children: [
                  FilledButton.tonal(
                    onPressed: () {
                      setState(() => _tapCount += 1);
                      widget.onEvent('${widget.title}: action A');
                    },
                    child: const Text('A'),
                  ),
                  FilledButton.tonal(
                    onPressed: () {
                      setState(() => _tapCount += 1);
                      widget.onEvent('${widget.title}: action B');
                    },
                    child: const Text('B'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          SwitchListTile(
            value: _centerMiddle,
            onChanged: (v) {
              setState(() => _centerMiddle = v);
              widget.onEvent('${widget.title}: centerMiddle=$v');
            },
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: const Text('centerMiddle', style: TextStyle(fontSize: 12)),
          ),
          _MiniSlider(
            label: 'spacing',
            value: _spacing,
            min: 0,
            max: 44,
            onChanged: (v) => setState(() => _spacing = v),
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: widget.tone.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'taps $_tapCount | center=${_centerMiddle ? 'true' : 'false'} | spacing=${_spacing.toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class _PanelSurface extends StatelessWidget {
  const _PanelSurface({required this.guides, required this.child});

  final bool guides;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC6D7E8)),
        gradient: const LinearGradient(
          colors: [Color(0xFFFAFCFF), Color(0xFFEFF5FC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (guides) const CustomPaint(painter: _GuidePainter()),
          child,
        ],
      ),
    );
  }
}

class _GuidePainter extends CustomPainter {
  const _GuidePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = const Color(0x13000000);
    const step = 22.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ToneChip extends StatelessWidget {
  const _ToneChip({required this.tone, required this.label});

  final Color tone;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label, style: TextStyle(color: tone, fontWeight: FontWeight.w700, fontSize: 11)),
    );
  }
}

class _DataRowItem {
  const _DataRowItem(this.label, this.value);

  final String label;
  final String value;
}

class _DataTableCard extends StatelessWidget {
  const _DataTableCard({required this.rows});

  final List<_DataRowItem> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F8FD),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD2E1EF)),
      ),
      child: Column(
        children: rows
            .map(
              (r) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    SizedBox(width: 138, child: Text(r.label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700))),
                    Expanded(child: Text(r.value, style: const TextStyle(fontSize: 12))),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _MiniSlider extends StatelessWidget {
  const _MiniSlider({required this.label, required this.value, required this.min, required this.max, required this.onChanged});

  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 86, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
        Expanded(child: Slider(value: value, min: min, max: max, onChanged: onChanged)),
      ],
    );
  }
}

class _InstructionCard extends StatelessWidget {
  const _InstructionCard({required this.tone, required this.lines});

  final Color tone;
  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lines
            .map(
              (line) => Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Icon(Icons.circle, size: 7, color: Color(0xFFBFE3FF)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(line, style: const TextStyle(color: Color(0xFFEAF6FF), height: 1.35))),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _LogCard extends StatelessWidget {
  const _LogCard({required this.lines});

  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFCFDEEC)),
      ),
      child: lines.isEmpty
          ? const Text('No events yet.', style: TextStyle(color: Color(0xFF62798D)))
          : ListView.builder(
              itemCount: lines.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(lines[index], style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
                );
              },
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
        color: const Color(0xFF14374E),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recap: NavigationToolbar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'NavigationToolbar is a compact but powerful layout primitive for building custom top bars. '
            'By composing the leading, middle, and trailing slots carefully, you can deliver expressive and consistent header behavior across complex app surfaces.',
            style: TextStyle(color: Color(0xFFD8E9F6), height: 1.35),
          ),
        ],
      ),
    );
  }
}

void _trim(List<String> events, int limit) {
  if (events.length > limit) {
    events.removeRange(limit, events.length);
  }
}

String _clock() => DateTime.now().toIso8601String().substring(11, 19);

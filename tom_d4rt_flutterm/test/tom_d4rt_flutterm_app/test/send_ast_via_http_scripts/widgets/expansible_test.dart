import 'package:flutter/material.dart';

const _cNavy = Color(0xFF1F4E74);
const _cAmber = Color(0xFFC47B37);
const _cTeal = Color(0xFF287D72);
const _cRose = Color(0xFF90466A);
const _cIndigo = Color(0xFF5653A0);
const _cOlive = Color(0xFF6B692C);

dynamic build(BuildContext context) {
  return const _ExpansibleDeepDemoApp();
}

class _ExpansibleDeepDemoApp extends StatelessWidget {
  const _ExpansibleDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _cNavy),
      ),
      home: const _ExpansibleDemoPage(),
    );
  }
}

class _ExpansibleDemoPage extends StatefulWidget {
  const _ExpansibleDemoPage();

  @override
  State<_ExpansibleDemoPage> createState() => _ExpansibleDemoPageState();
}

class _ExpansibleDemoPageState extends State<_ExpansibleDemoPage> {
  bool _rtl = false;
  bool _compact = false;
  bool _showGuides = true;

  double _durationMs = 520;
  _CurveOption _curve = _CurveOption.easeOutCubic;
  _CurveOption _reverseCurve = _CurveOption.easeInCubic;

  @override
  Widget build(BuildContext context) {
    final animationStyle = AnimationStyle(
      duration: Duration(milliseconds: _durationMs.round()),
      curve: _curve.curve,
      reverseCurve: _reverseCurve.curve,
    );

    return Directionality(
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F5F8),
        appBar: AppBar(
          backgroundColor: _cNavy,
          foregroundColor: Colors.white,
          toolbarHeight: 78,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Expansible Deep Demo'),
              const SizedBox(height: 2),
              Text(
                _rtl ? 'Ambient direction: RTL' : 'Ambient direction: LTR',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeroDeck(
                rtl: _rtl,
                compact: _compact,
                showGuides: _showGuides,
                durationMs: _durationMs,
                curve: _curve,
                reverseCurve: _reverseCurve,
                onRtlChanged: (value) => setState(() => _rtl = value),
                onCompactChanged: (value) => setState(() => _compact = value),
                onShowGuidesChanged: (value) => setState(() => _showGuides = value),
                onDurationChanged: (value) => setState(() => _durationMs = value),
                onCurveChanged: (value) => setState(() => _curve = value),
                onReverseCurveChanged: (value) => setState(() => _reverseCurve = value),
              ),
              const SizedBox(height: 12),
              const _ScenePanel(
                index: 1,
                accent: _cNavy,
                title: 'Core Model and Contracts',
                subtitle:
                    'Expansible combines a controller, headerBuilder, bodyBuilder, and optional expansibleBuilder for fully custom layout.',
                child: _ConceptScene(),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 2,
                accent: _cAmber,
                title: 'Controller API and Context Lookup',
                subtitle:
                    'Use expand/collapse directly, query isExpanded, and compare ExpansibleController.of versus maybeOf in different contexts.',
                child: _ControllerApiScene(
                  compact: _compact,
                  showGuides: _showGuides,
                  animationStyle: animationStyle,
                ),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 3,
                accent: _cTeal,
                title: 'maintainState True vs False',
                subtitle:
                    'A side-by-side lab that shows whether body state is preserved after collapse and re-expand.',
                child: _MaintainStateScene(
                  compact: _compact,
                  showGuides: _showGuides,
                  animationStyle: animationStyle,
                ),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 4,
                accent: _cRose,
                title: 'Custom expansibleBuilder Composition',
                subtitle:
                    'Demonstrates layouts beyond a simple column by rebuilding header and body inside a richer shell.',
                child: _CustomBuilderScene(
                  compact: _compact,
                  showGuides: _showGuides,
                  animationStyle: animationStyle,
                ),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 5,
                accent: _cIndigo,
                title: 'PageStorage Persistence in Scrollables',
                subtitle:
                    'Expanded state can survive list view swaps when keys and PageStorage are configured.',
                child: _PageStorageScene(
                  compact: _compact,
                  showGuides: _showGuides,
                  animationStyle: animationStyle,
                ),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 6,
                accent: _cOlive,
                title: 'Practical Pattern: Section Command Center',
                subtitle:
                    'Programmatic bulk control across multiple Expansible sections for dashboard-like flows.',
                child: _PracticalScene(
                  compact: _compact,
                  showGuides: _showGuides,
                  animationStyle: animationStyle,
                ),
              ),
              const SizedBox(height: 12),
              const _RecapCard(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

enum _CurveOption {
  linear('Linear', Curves.linear),
  easeOutCubic('Ease Out Cubic', Curves.easeOutCubic),
  easeInCubic('Ease In Cubic', Curves.easeInCubic),
  easeInOut('Ease In Out', Curves.easeInOut),
  fastOutSlowIn('Fast Out Slow In', Curves.fastOutSlowIn),
  easeOutBack('Ease Out Back', Curves.easeOutBack);

  const _CurveOption(this.label, this.curve);

  final String label;
  final Curve curve;
}

class _HeroDeck extends StatelessWidget {
  const _HeroDeck({
    required this.rtl,
    required this.compact,
    required this.showGuides,
    required this.durationMs,
    required this.curve,
    required this.reverseCurve,
    required this.onRtlChanged,
    required this.onCompactChanged,
    required this.onShowGuidesChanged,
    required this.onDurationChanged,
    required this.onCurveChanged,
    required this.onReverseCurveChanged,
  });

  final bool rtl;
  final bool compact;
  final bool showGuides;
  final double durationMs;
  final _CurveOption curve;
  final _CurveOption reverseCurve;

  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onShowGuidesChanged;
  final ValueChanged<double> onDurationChanged;
  final ValueChanged<_CurveOption> onCurveChanged;
  final ValueChanged<_CurveOption> onReverseCurveChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF1F4E74), Color(0xFF44698A), Color(0xFF724D66)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Expansible Control Deck',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 27),
          ),
          const SizedBox(height: 8),
          const Text(
            'Drive all scenes with one animation style profile. Focus on controller behavior, maintainState semantics, and custom layout composition.',
            style: TextStyle(color: Color(0xFFF4F8FF), fontSize: 13, height: 1.45),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: SwitchListTile(
                  value: rtl,
                  onChanged: onRtlChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('RTL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SwitchListTile(
                  value: compact,
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
                  onChanged: onShowGuidesChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Show guide grid', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
          Text(
            'Animation duration: ${durationMs.toStringAsFixed(0)} ms',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          Slider(
            value: durationMs,
            min: 120,
            max: 1400,
            divisions: 32,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.3),
            onChanged: onDurationChanged,
          ),
          Row(
            children: [
              Expanded(
                child: _CurveDropdown(
                  title: 'Curve',
                  value: curve,
                  onChanged: onCurveChanged,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _CurveDropdown(
                  title: 'Reverse curve',
                  value: reverseCurve,
                  onChanged: onReverseCurveChanged,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _Tag(label: 'ExpansibleController.expand()/collapse()'),
              _Tag(label: 'headerBuilder + bodyBuilder + expansibleBuilder'),
              _Tag(label: 'maintainState controls body subtree retention'),
              _Tag(label: 'PageStorageKey restores expanded state'),
            ],
          ),
        ],
      ),
    );
  }
}

class _CurveDropdown extends StatelessWidget {
  const _CurveDropdown({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final _CurveOption value;
  final ValueChanged<_CurveOption> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
        const SizedBox(height: 6),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.13),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withValues(alpha: 0.28)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<_CurveOption>(
              value: value,
              isExpanded: true,
              borderRadius: BorderRadius.circular(12),
              dropdownColor: const Color(0xFF3D607C),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              items: _CurveOption.values
                  .map(
                    (option) => DropdownMenuItem<_CurveOption>(
                      value: option,
                      child: Text(option.label, style: const TextStyle(color: Colors.white)),
                    ),
                  )
                  .toList(),
              onChanged: (selected) {
                if (selected != null) {
                  onChanged(selected);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class _ScenePanel extends StatelessWidget {
  const _ScenePanel({
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
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
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
                  backgroundColor: accent,
                  foregroundColor: Colors.white,
                  child: Text('$index', style: const TextStyle(fontWeight: FontWeight.w800)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 18)),
                      const SizedBox(height: 3),
                      Text(subtitle, style: const TextStyle(height: 1.4, color: Color(0xFF2F3B45))),
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

class _ConceptScene extends StatelessWidget {
  const _ConceptScene();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Expansible anatomy', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFD),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFDDE5EE)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Bullet(text: 'headerBuilder always builds and typically hosts toggle interactions.'),
              _Bullet(text: 'bodyBuilder receives animation and is wrapped in Offstage/Align clipping.'),
              _Bullet(text: 'expansibleBuilder decides the outer shell layout from header + body.'),
              _Bullet(text: 'controller.isExpanded is logical state and may be true before animation completes.'),
              _Bullet(text: 'maintainState=false removes body subtree when fully collapsed.'),
              _Bullet(text: 'PageStorage stores expanded state using the widget context and key.'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFD8E3ED)),
          ),
          child: const Text(
            'Expansible is intentionally lower-level than ExpansionTile. You provide explicit controller logic and can shape header/body composition without Material-specific assumptions.',
            style: TextStyle(height: 1.45, color: Color(0xFF3F5060)),
          ),
        ),
      ],
    );
  }
}

class _ControllerApiScene extends StatefulWidget {
  const _ControllerApiScene({
    required this.compact,
    required this.showGuides,
    required this.animationStyle,
  });

  final bool compact;
  final bool showGuides;
  final AnimationStyle animationStyle;

  @override
  State<_ControllerApiScene> createState() => _ControllerApiSceneState();
}

class _ControllerApiSceneState extends State<_ControllerApiScene> {
  final ExpansibleController _controller = ExpansibleController();
  final List<String> _events = <String>[];
  String _outsideMaybeOf = 'not sampled';

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    setState(() {
      _events.insert(0, '${DateTime.now().toIso8601String().substring(11, 19)} -> isExpanded=${_controller.isExpanded}');
      if (_events.length > 8) {
        _events.removeRange(8, _events.length);
      }
    });
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onControllerChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maybe = ExpansibleController.maybeOf(context);
    if (_outsideMaybeOf != '${maybe == null}') {
      _outsideMaybeOf = '${maybe == null}';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ActionButton(
              label: 'expand()',
              color: _cNavy,
              onPressed: () => _controller.expand(),
            ),
            _ActionButton(
              label: 'collapse()',
              color: _cRose,
              onPressed: () => _controller.collapse(),
            ),
            _ActionButton(
              label: 'toggle',
              color: _cTeal,
              onPressed: () {
                if (_controller.isExpanded) {
                  _controller.collapse();
                } else {
                  _controller.expand();
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text('Outside maybeOf(context) == null: $_outsideMaybeOf', style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        SizedBox(
          height: widget.compact ? 230 : 290,
          child: _GuideStage(
            showGuides: widget.showGuides,
            child: Center(
              child: Container(
                width: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFD8E2EC)),
                ),
                padding: const EdgeInsets.all(10),
                child: Expansible(
                  key: const PageStorageKey<String>('controller-api-expansible'),
                  controller: _controller,
                  animationStyle: widget.animationStyle,
                  headerBuilder: (context, animation) {
                    return AnimatedBuilder(
                      animation: animation,
                      builder: (context, _) {
                        return InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            final insideController = ExpansibleController.of(context);
                            if (insideController.isExpanded) {
                              insideController.collapse();
                            } else {
                              insideController.expand();
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F9FD),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: const Color(0xFFDDE7F1)),
                            ),
                            child: Row(
                              children: [
                                RotationTransition(
                                  turns: Tween<double>(begin: 0, end: 0.5).animate(animation),
                                  child: const Icon(Icons.expand_more, color: _cNavy),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Header tap uses ExpansibleController.of(context)',
                                    style: const TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Text('anim ${animation.value.toStringAsFixed(2)}'),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  bodyBuilder: (context, animation) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Body content remains clipped by Expansible while animation runs.',
                            style: TextStyle(height: 1.35),
                          ),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: animation.value,
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(999),
                            color: _cAmber,
                            backgroundColor: _cAmber.withValues(alpha: 0.2),
                          ),
                          const SizedBox(height: 8),
                          Text('animation.value = ${animation.value.toStringAsFixed(3)}'),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        _EventLog(events: _events),
      ],
    );
  }
}

class _MaintainStateScene extends StatefulWidget {
  const _MaintainStateScene({
    required this.compact,
    required this.showGuides,
    required this.animationStyle,
  });

  final bool compact;
  final bool showGuides;
  final AnimationStyle animationStyle;

  @override
  State<_MaintainStateScene> createState() => _MaintainStateSceneState();
}

class _MaintainStateSceneState extends State<_MaintainStateScene> {
  final ExpansibleController _keepController = ExpansibleController();
  final ExpansibleController _dropController = ExpansibleController();

  final GlobalKey<_BodyStateProbeState> _keepKey = GlobalKey<_BodyStateProbeState>();
  final GlobalKey<_BodyStateProbeState> _dropKey = GlobalKey<_BodyStateProbeState>();

  String _snapshot = 'Take a snapshot after interacting with both bodies.';

  @override
  void dispose() {
    _keepController.dispose();
    _dropController.dispose();
    super.dispose();
  }

  void _captureSnapshot() {
    final keepCounter = _keepKey.currentState?.counter ?? -1;
    final keepText = _keepKey.currentState?.text ?? '';

    final dropCounter = _dropKey.currentState?.counter ?? -1;
    final dropText = _dropKey.currentState?.text ?? '';

    setState(() {
      _snapshot = 'maintainState=true -> counter $keepCounter, text "$keepText" | maintainState=false -> counter $dropCounter, text "$dropText"';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ActionButton(
              label: _keepController.isExpanded ? 'Collapse keep-state' : 'Expand keep-state',
              color: _cTeal,
              onPressed: () {
                setState(() {
                  if (_keepController.isExpanded) {
                    _keepController.collapse();
                  } else {
                    _keepController.expand();
                  }
                });
              },
            ),
            _ActionButton(
              label: _dropController.isExpanded ? 'Collapse drop-state' : 'Expand drop-state',
              color: _cRose,
              onPressed: () {
                setState(() {
                  if (_dropController.isExpanded) {
                    _dropController.collapse();
                  } else {
                    _dropController.expand();
                  }
                });
              },
            ),
            _ActionButton(
              label: 'Capture Snapshot',
              color: _cNavy,
              onPressed: _captureSnapshot,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _GuideStage(
                showGuides: widget.showGuides,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFD8E2EC)),
                  ),
                  child: Expansible(
                    key: const PageStorageKey<String>('maintain-true-expansible'),
                    controller: _keepController,
                    maintainState: true,
                    animationStyle: widget.animationStyle,
                    headerBuilder: (context, animation) {
                      return _StateHeader(
                        animation: animation,
                        color: _cTeal,
                        title: 'maintainState: true',
                        subtitle: 'Body stays in tree when collapsed',
                      );
                    },
                    bodyBuilder: (context, animation) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: _BodyStateProbe(
                          key: _keepKey,
                          accent: _cTeal,
                          label: 'Persistent body',
                          animationValue: animation.value,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _GuideStage(
                showGuides: widget.showGuides,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFD8E2EC)),
                  ),
                  child: Expansible(
                    key: const PageStorageKey<String>('maintain-false-expansible'),
                    controller: _dropController,
                    maintainState: false,
                    animationStyle: widget.animationStyle,
                    headerBuilder: (context, animation) {
                      return _StateHeader(
                        animation: animation,
                        color: _cRose,
                        title: 'maintainState: false',
                        subtitle: 'Body gets removed when collapsed',
                      );
                    },
                    bodyBuilder: (context, animation) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: _BodyStateProbe(
                          key: _dropKey,
                          accent: _cRose,
                          label: 'Recreated body',
                          animationValue: animation.value,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFF7FBFF),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFDCE8F4)),
          ),
          child: Text(_snapshot, style: const TextStyle(fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}

class _StateHeader extends StatelessWidget {
  const _StateHeader({
    required this.animation,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  final Animation<double> animation;
  final Color color;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.28)),
      ),
      child: Row(
        children: [
          RotationTransition(
            turns: Tween<double>(begin: 0, end: 0.5).animate(animation),
            child: Icon(Icons.expand_more, color: color),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w800)),
                Text(subtitle, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Text(animation.value.toStringAsFixed(2), style: const TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _BodyStateProbe extends StatefulWidget {
  const _BodyStateProbe({
    super.key,
    required this.accent,
    required this.label,
    required this.animationValue,
  });

  final Color accent;
  final String label;
  final double animationValue;

  @override
  State<_BodyStateProbe> createState() => _BodyStateProbeState();
}

class _BodyStateProbeState extends State<_BodyStateProbe> {
  final TextEditingController _controller = TextEditingController();
  int _counter = 0;

  int get counter => _counter;
  String get text => _controller.text;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.accent.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label, style: TextStyle(color: widget.accent, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(isDense: true, border: OutlineInputBorder(), hintText: 'Type and collapse/expand'),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              FilledButton(
                onPressed: () => setState(() => _counter += 1),
                child: const Text('+1'),
              ),
              const SizedBox(width: 8),
              Text('Counter $_counter', style: const TextStyle(fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 6),
          Text('Text length ${_controller.text.length} | animation ${widget.animationValue.toStringAsFixed(2)}'),
        ],
      ),
    );
  }
}

class _CustomBuilderScene extends StatefulWidget {
  const _CustomBuilderScene({
    required this.compact,
    required this.showGuides,
    required this.animationStyle,
  });

  final bool compact;
  final bool showGuides;
  final AnimationStyle animationStyle;

  @override
  State<_CustomBuilderScene> createState() => _CustomBuilderSceneState();
}

class _CustomBuilderSceneState extends State<_CustomBuilderScene> {
  final ExpansibleController _controller = ExpansibleController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ActionButton(
              label: _controller.isExpanded ? 'Collapse' : 'Expand',
              color: _cRose,
              onPressed: () {
                setState(() {
                  if (_controller.isExpanded) {
                    _controller.collapse();
                  } else {
                    _controller.expand();
                  }
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: widget.compact ? 210 : 270,
          child: _GuideStage(
            showGuides: widget.showGuides,
            child: Center(
              child: Container(
                width: 620,
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFD9E3EE)),
                ),
                child: Expansible(
                  key: const PageStorageKey<String>('custom-builder-expansible'),
                  controller: _controller,
                  animationStyle: widget.animationStyle,
                  headerBuilder: (context, animation) {
                    return _StateHeader(
                      animation: animation,
                      color: _cRose,
                      title: 'Custom shell heading',
                      subtitle: 'Header and body placed in a bespoke frame',
                    );
                  },
                  bodyBuilder: (context, animation) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Body area with custom ornaments and telemetry.'),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: animation.value,
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(999),
                            color: _cRose,
                            backgroundColor: _cRose.withValues(alpha: 0.18),
                          ),
                          const SizedBox(height: 8),
                          Text('animation.value = ${animation.value.toStringAsFixed(3)}'),
                        ],
                      ),
                    );
                  },
                  expansibleBuilder: (context, header, body, animation) {
                    return AnimatedBuilder(
                      animation: animation,
                      builder: (context, _) {
                        return Stack(
                          children: [
                            Positioned(
                              top: 0,
                              bottom: 0,
                              left: 0,
                              child: Container(
                                width: 6,
                                decoration: BoxDecoration(
                                  color: _cRose.withValues(alpha: 0.5 + animation.value * 0.4),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 10, 10, 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [header, body],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PageStorageScene extends StatefulWidget {
  const _PageStorageScene({
    required this.compact,
    required this.showGuides,
    required this.animationStyle,
  });

  final bool compact;
  final bool showGuides;
  final AnimationStyle animationStyle;

  @override
  State<_PageStorageScene> createState() => _PageStorageSceneState();
}

class _PageStorageSceneState extends State<_PageStorageScene> {
  final PageStorageBucket _bucket = PageStorageBucket();
  bool _showFirstList = true;

  final List<ExpansibleController> _controllersA = List<ExpansibleController>.generate(4, (_) => ExpansibleController());
  final List<ExpansibleController> _controllersB = List<ExpansibleController>.generate(4, (_) => ExpansibleController());

  @override
  void dispose() {
    for (final controller in _controllersA) {
      controller.dispose();
    }
    for (final controller in _controllersB) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildList(String group, List<ExpansibleController> controllers) {
    return ListView.separated(
      key: PageStorageKey<String>('list-$group'),
      padding: const EdgeInsets.all(10),
      itemCount: controllers.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final controller = controllers[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFD9E3EE)),
          ),
          padding: const EdgeInsets.all(8),
          child: Expansible(
            key: PageStorageKey<String>('expansible-$group-$index'),
            controller: controller,
            animationStyle: widget.animationStyle,
            headerBuilder: (context, animation) {
              return InkWell(
                onTap: () {
                  if (controller.isExpanded) {
                    controller.collapse();
                  } else {
                    controller.expand();
                  }
                  setState(() {});
                },
                child: Row(
                  children: [
                    RotationTransition(
                      turns: Tween<double>(begin: 0, end: 0.5).animate(animation),
                      child: const Icon(Icons.expand_more, color: _cIndigo),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text('List $group / item $index', style: const TextStyle(fontWeight: FontWeight.w700)),
                    ),
                    Text(controller.isExpanded ? 'open' : 'closed'),
                  ],
                ),
              );
            },
            bodyBuilder: (context, animation) {
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Expanded body for list $group item $index (animation ${animation.value.toStringAsFixed(2)}).',
                  style: const TextStyle(height: 1.35),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ActionButton(
              label: _showFirstList ? 'Switch to list B' : 'Switch to list A',
              color: _cIndigo,
              onPressed: () => setState(() => _showFirstList = !_showFirstList),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Open a few rows, switch lists, then come back. PageStorageKey preserves expanded state per list group.',
          style: TextStyle(height: 1.35),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: widget.compact ? 220 : 290,
          child: _GuideStage(
            showGuides: widget.showGuides,
            child: PageStorage(
              bucket: _bucket,
              child: _showFirstList ? _buildList('A', _controllersA) : _buildList('B', _controllersB),
            ),
          ),
        ),
      ],
    );
  }
}

class _PracticalScene extends StatefulWidget {
  const _PracticalScene({
    required this.compact,
    required this.showGuides,
    required this.animationStyle,
  });

  final bool compact;
  final bool showGuides;
  final AnimationStyle animationStyle;

  @override
  State<_PracticalScene> createState() => _PracticalSceneState();
}

class _PracticalSceneState extends State<_PracticalScene> {
  final List<ExpansibleController> _controllers = List<ExpansibleController>.generate(4, (_) => ExpansibleController());

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  int get _openCount => _controllers.where((controller) => controller.isExpanded).length;

  void _expandAll() {
    for (final controller in _controllers) {
      controller.expand();
    }
    setState(() {});
  }

  void _collapseAll() {
    for (final controller in _controllers) {
      controller.collapse();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final sections = <_SectionSpec>[
      const _SectionSpec('System Health', 'CPU, memory, and process-level metrics.'),
      const _SectionSpec('Deployments', 'Recent rollouts and version history.'),
      const _SectionSpec('Alerts', 'Escalations and incident summaries.'),
      const _SectionSpec('Audit Trail', 'User actions and policy events.'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ActionButton(label: 'Expand All', color: _cOlive, onPressed: _expandAll),
            _ActionButton(label: 'Collapse All', color: _cRose, onPressed: _collapseAll),
          ],
        ),
        const SizedBox(height: 8),
        Text('Open sections: $_openCount / ${_controllers.length}', style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        SizedBox(
          height: widget.compact ? 260 : 330,
          child: _GuideStage(
            showGuides: widget.showGuides,
            child: ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: sections.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final section = sections[index];
                final controller = _controllers[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFD9E3EE)),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Expansible(
                    key: PageStorageKey<String>('practical-section-$index'),
                    controller: controller,
                    animationStyle: widget.animationStyle,
                    headerBuilder: (context, animation) {
                      return InkWell(
                        onTap: () {
                          if (controller.isExpanded) {
                            controller.collapse();
                          } else {
                            controller.expand();
                          }
                          setState(() {});
                        },
                        child: Row(
                          children: [
                            RotationTransition(
                              turns: Tween<double>(begin: 0, end: 0.5).animate(animation),
                              child: const Icon(Icons.expand_more, color: _cOlive),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(section.title, style: const TextStyle(fontWeight: FontWeight.w800)),
                            ),
                            Text(controller.isExpanded ? 'open' : 'closed', style: const TextStyle(color: Color(0xFF4A5B6B))),
                          ],
                        ),
                      );
                    },
                    bodyBuilder: (context, animation) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(section.description),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: animation.value,
                              minHeight: 7,
                              borderRadius: BorderRadius.circular(999),
                              color: _cOlive,
                              backgroundColor: _cOlive.withValues(alpha: 0.2),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionSpec {
  const _SectionSpec(this.title, this.description);

  final String title;
  final String description;
}

class _GuideStage extends StatelessWidget {
  const _GuideStage({
    required this.showGuides,
    required this.child,
  });

  final bool showGuides;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFFF7FBFF), Color(0xFFEAF2F8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFFD4E0EB)),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (showGuides)
            CustomPaint(
              painter: _GridPainter(),
            ),
          child,
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const step = 22.0;
    final paint = Paint()..color = const Color(0x11000000);

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.color,
    required this.onPressed,
  });

  final String label;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(backgroundColor: color, foregroundColor: Colors.white),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Icon(Icons.circle, size: 7, color: Color(0xFF36536D)),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(height: 1.35))),
        ],
      ),
    );
  }
}

class _EventLog extends StatelessWidget {
  const _EventLog({required this.events});

  final List<String> events;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFCFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFDCE6F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Controller events', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          if (events.isEmpty)
            const Text('No events yet.', style: TextStyle(color: Color(0xFF617386)))
          else
            ...events.map(
              (event) => Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(event, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
              ),
            ),
        ],
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
        color: const Color(0xFF10273C),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recap: When to use Expansible',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
          ),
          SizedBox(height: 8),
          Text(
            'Use Expansible for low-level expandable composition where you need direct controller ownership, maintainState control, and custom shell construction beyond Material expansion presets.',
            style: TextStyle(color: Color(0xFFD9E5F1), height: 1.4),
          ),
        ],
      ),
    );
  }
}

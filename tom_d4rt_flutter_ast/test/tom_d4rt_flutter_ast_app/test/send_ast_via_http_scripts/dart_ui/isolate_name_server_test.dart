// D4rt test script: Deep demo for IsolateNameServer from dart:ui.
import 'dart:ui' as ui;
import 'dart:isolate';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const _IsolateNameServerDeepDemo(),
  );
}

class _IsolateNameServerDeepDemo extends StatefulWidget {
  const _IsolateNameServerDeepDemo();

  @override
  State<_IsolateNameServerDeepDemo> createState() => _IsolateNameServerDeepDemoState();
}

class _IsolateNameServerDeepDemoState extends State<_IsolateNameServerDeepDemo> {
  static const String _channelA = 'demo_channel_alpha';
  static const String _channelB = 'demo_channel_beta';
  static const String _channelC = 'demo_channel_gamma';

  final List<String> _passed = <String>[];
  final List<String> _failed = <String>[];
  final List<String> _events = <String>[];

  ReceivePort? _alphaPort;
  ReceivePort? _betaPort;
  ReceivePort? _gammaPort;

  SendPort? _alphaSend;
  SendPort? _betaSend;
  SendPort? _gammaSend;

  int _activeChannel = 0;
  int _payloadMode = 0;
  double _packetDensity = 0.5;
  bool _animateFlow = true;
  bool _showGrid = true;
  int _paletteIndex = 0;

  double _animValue = 0.0;
  double _flowPulse = 0;

  final List<List<Color>> _palettes = <List<Color>>[
    <Color>[const Color(0xFF0F172A), const Color(0xFF1E293B), const Color(0xFF38BDF8)],
    <Color>[const Color(0xFF3B0764), const Color(0xFF6B21A8), const Color(0xFFC084FC)],
    <Color>[const Color(0xFF064E3B), const Color(0xFF047857), const Color(0xFF34D399)],
  ];

  @override
  void initState() {
    super.initState();
    _runProbes();
  }

  @override
  void dispose() {
    _cleanupAll();
    super.dispose();
  }

  void _recordProbe(String label, bool ok) {
    if (ok) {
      _passed.add(label);
    } else {
      _failed.add(label);
    }
  }

  void _log(String text) {
    final DateTime now = DateTime.now();
    final String stamp = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    _events.insert(0, '[$stamp] $text');
    if (_events.length > 28) {
      _events.removeLast();
    }
  }

  void _cleanupAll() {
    ui.IsolateNameServer.removePortNameMapping(_channelA);
    ui.IsolateNameServer.removePortNameMapping(_channelB);
    ui.IsolateNameServer.removePortNameMapping(_channelC);
    _alphaPort?.close();
    _betaPort?.close();
    _gammaPort?.close();
    _alphaPort = null;
    _betaPort = null;
    _gammaPort = null;
    _alphaSend = null;
    _betaSend = null;
    _gammaSend = null;
  }

  void _registerChannel(String name) {
    ReceivePort? rp;
    if (name == _channelA) {
      _alphaPort?.close();
      rp = ReceivePort();
      _alphaPort = rp;
    } else if (name == _channelB) {
      _betaPort?.close();
      rp = ReceivePort();
      _betaPort = rp;
    } else {
      _gammaPort?.close();
      rp = ReceivePort();
      _gammaPort = rp;
    }

    rp.listen((dynamic message) {
      _log('$name received: $message');
      if (mounted) {
        setState(() {});
      }
    });

    final bool ok = ui.IsolateNameServer.registerPortWithName(rp.sendPort, name);
    if (ok) {
      if (name == _channelA) {
        _alphaSend = rp.sendPort;
      } else if (name == _channelB) {
        _betaSend = rp.sendPort;
      } else {
        _gammaSend = rp.sendPort;
      }
      _log('Registered $name');
    } else {
      _log('Registration failed for $name (already registered?)');
    }
  }

  String _activeName() {
    if (_activeChannel == 0) {
      return _channelA;
    }
    if (_activeChannel == 1) {
      return _channelB;
    }
    return _channelC;
  }

  void _sendToActive() {
    final String name = _activeName();
    final SendPort? port = ui.IsolateNameServer.lookupPortByName(name);
    if (port == null) {
      _log('Lookup failed: no port for $name');
      setState(() {});
      return;
    }

    dynamic payload;
    if (_payloadMode == 0) {
      payload = 'message:${(1000 * _flowPulse).round()}';
    } else if (_payloadMode == 1) {
      payload = <String, dynamic>{
        'channel': name,
        'density': _packetDensity.toStringAsFixed(2),
        'tick': DateTime.now().millisecondsSinceEpoch,
      };
    } else {
      final int count = (_packetDensity * 10).round().clamp(1, 10);
      payload = List<int>.generate(count, (int i) => (i * 17 + count) % 97);
    }

    port.send(payload);
    _log('Sent payload to $name');
    setState(() {});
  }

  void _runProbes() {
    _passed.clear();
    _failed.clear();

    _recordProbe(
      'lookup unknown name returns null',
      ui.IsolateNameServer.lookupPortByName('unknown_name_${DateTime.now().microsecondsSinceEpoch}') == null,
    );

    final ReceivePort rp = ReceivePort();
    final String unique = 'probe_${DateTime.now().microsecondsSinceEpoch}';
    final bool reg = ui.IsolateNameServer.registerPortWithName(rp.sendPort, unique);
    _recordProbe('registerPortWithName returns true for unique name', reg);

    final SendPort? found = ui.IsolateNameServer.lookupPortByName(unique);
    _recordProbe('lookupPortByName finds registered port', found != null);

    final ReceivePort rp2 = ReceivePort();
    final bool dup = ui.IsolateNameServer.registerPortWithName(rp2.sendPort, unique);
    _recordProbe('duplicate registration returns false', dup == false);

    final bool removed = ui.IsolateNameServer.removePortNameMapping(unique);
    _recordProbe('removePortNameMapping removes existing name', removed);

    final bool removedAgain = ui.IsolateNameServer.removePortNameMapping(unique);
    _recordProbe('removePortNameMapping returns false when missing', removedAgain == false);

    rp.close();
    rp2.close();
    if (mounted) {
      setState(() {});
    }
  }

  Widget _sectionTitle(String title, String subtitle, IconData icon, Color accent) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accent.withAlpha(22),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withAlpha(88)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: accent.withAlpha(36),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: accent),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(fontSize: 12.2)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    final List<Color> p = _palettes[_paletteIndex];
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: p),
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(color: p[1].withAlpha(95), blurRadius: 16, offset: const Offset(0, 8)),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'IsolateNameServer',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 8),
          Text(
            'IsolateNameServer maps string names to SendPort instances, enabling lookup-based '
            'messaging across isolates. This deep demo shows registration, lookup, removal, '
            'message routing, and operational guardrails.',
            style: TextStyle(color: Colors.white, fontSize: 13.1, height: 1.35),
          ),
        ],
      ),
    );
  }

  Widget _conceptCard(String t, String d, IconData i, Color c) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: c.withAlpha(20),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: c.withAlpha(90)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(i, color: c),
            const SizedBox(height: 8),
            Text(t, style: TextStyle(color: c, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(d, style: const TextStyle(fontSize: 11.8)),
          ],
        ),
      ),
    );
  }

  Widget _conceptOverview() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          _conceptCard('Register', 'Map a name to a SendPort.', Icons.app_registration,
              const Color(0xFF2563EB)),
          _conceptCard('Lookup', 'Resolve a name to route messages.', Icons.search,
              const Color(0xFF0F766E)),
          _conceptCard('Remove', 'Delete mappings when no longer needed.', Icons.delete_outline,
              const Color(0xFF7C3AED)),
          _conceptCard('Global namespace', 'Avoid collisions with clear naming.', Icons.public,
              const Color(0xFFB45309)),
        ],
      ),
    );
  }

  Widget _channelStatus(String name, SendPort? send) {
    final bool active = send != null;
    final Color color = active ? const Color(0xFF16A34A) : const Color(0xFF9CA3AF);
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withAlpha(18),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withAlpha(92)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(name, style: TextStyle(color: color, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(active ? 'Registered' : 'Not registered', style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _topologyPanel() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Messaging topology snapshot', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              _channelStatus(_channelA, _alphaSend),
              _channelStatus(_channelB, _betaSend),
              _channelStatus(_channelC, _gammaSend),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 180,
            child: CustomPaint(
              painter: _TopologyPainter(
                pulse: _flowPulse,
                animate: _animateFlow,
                showGrid: _showGrid,
                activeChannel: _activeChannel,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _controlsPanel() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Registry controls', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: <Widget>[
              ChoiceChip(
                label: const Text('Alpha'),
                selected: _activeChannel == 0,
                onSelected: (_) => setState(() => _activeChannel = 0),
              ),
              ChoiceChip(
                label: const Text('Beta'),
                selected: _activeChannel == 1,
                onSelected: (_) => setState(() => _activeChannel = 1),
              ),
              ChoiceChip(
                label: const Text('Gamma'),
                selected: _activeChannel == 2,
                onSelected: (_) => setState(() => _activeChannel = 2),
              ),
            ],
          ),
          const SizedBox(height: 8),
          DropdownButton<int>(
            value: _payloadMode,
            isExpanded: true,
            onChanged: (int? v) {
              if (v != null) {
                setState(() {
                  _payloadMode = v;
                });
              }
            },
            items: const <DropdownMenuItem<int>>[
              DropdownMenuItem<int>(value: 0, child: Text('String payload')),
              DropdownMenuItem<int>(value: 1, child: Text('Map payload')),
              DropdownMenuItem<int>(value: 2, child: Text('Integer list payload')),
            ],
          ),
          Text('Packet density: ${_packetDensity.toStringAsFixed(2)}'),
          Slider(
            value: _packetDensity,
            min: 0,
            max: 1,
            divisions: 100,
            onChanged: (double v) => setState(() => _packetDensity = v),
          ),
          Wrap(
            spacing: 10,
            children: <Widget>[
              FilterChip(
                label: const Text('Animate flow'),
                selected: _animateFlow,
                onSelected: (bool v) {
                  setState(() {
                    _animateFlow = v;
                    if (_animateFlow) {
                      /* animation removed */
                    } else {
                      /* animation removed */
                    }
                  });
                },
              ),
              FilterChip(
                label: const Text('Grid'),
                selected: _showGrid,
                onSelected: (bool v) => setState(() => _showGrid = v),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  _registerChannel(_activeName());
                  setState(() {});
                },
                child: const Text('Register active'),
              ),
              OutlinedButton(
                onPressed: () {
                  final String name = _activeName();
                  final SendPort? p = ui.IsolateNameServer.lookupPortByName(name);
                  _log(p == null ? 'Lookup failed for $name' : 'Lookup success for $name');
                  setState(() {});
                },
                child: const Text('Lookup active'),
              ),
              OutlinedButton(
                onPressed: _sendToActive,
                child: const Text('Send payload'),
              ),
              OutlinedButton(
                onPressed: () {
                  final String name = _activeName();
                  final bool removed = ui.IsolateNameServer.removePortNameMapping(name);
                  _log(removed ? 'Removed mapping $name' : 'No mapping to remove for $name');
                  if (name == _channelA) {
                    _alphaSend = null;
                    _alphaPort?.close();
                    _alphaPort = null;
                  } else if (name == _channelB) {
                    _betaSend = null;
                    _betaPort?.close();
                    _betaPort = null;
                  } else {
                    _gammaSend = null;
                    _gammaPort?.close();
                    _gammaPort = null;
                  }
                  setState(() {});
                },
                child: const Text('Remove active'),
              ),
              OutlinedButton(
                onPressed: () {
                  _cleanupAll();
                  _log('Cleared all mappings and ports');
                  setState(() {});
                },
                child: const Text('Clear all'),
              ),
              OutlinedButton(
                onPressed: () {
                  _events.clear();
                  setState(() {});
                },
                child: const Text('Clear log'),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _paletteIndex = (_paletteIndex + 1) % _palettes.length;
                  });
                },
                icon: const Icon(Icons.palette_outlined, size: 18),
                label: const Text('Palette'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _useCaseCard(String t, String d, IconData i, List<Color> colors) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(i, color: Colors.white),
            const SizedBox(height: 8),
            Text(t, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(d, style: const TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _useCases() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          _useCaseCard(
            'Background workers',
            'Expose shared service ports for compute isolates.',
            Icons.workspaces,
            const <Color>[Color(0xFF2563EB), Color(0xFF60A5FA)],
          ),
          _useCaseCard(
            'Plugin bridge',
            'Route messages between app and plugin isolate handlers.',
            Icons.extension,
            const <Color>[Color(0xFF7C3AED), Color(0xFFA78BFA)],
          ),
          _useCaseCard(
            'App service bus',
            'Name-based channels for decoupled message routing.',
            Icons.hub,
            const <Color>[Color(0xFF0F766E), Color(0xFF2DD4BF)],
          ),
        ],
      ),
    );
  }

  Widget _probeLine(String text, bool ok) {
    final Color color = ok ? const Color(0xFF15803D) : const Color(0xFFB91C1C);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha(92)),
      ),
      child: Row(
        children: <Widget>[
          Icon(ok ? Icons.check_circle : Icons.cancel, color: color, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 12.2))),
        ],
      ),
    );
  }

  Widget _probeDashboard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Runtime probe dashboard', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text('Passed: ${_passed.length}, Failed: ${_failed.length}'),
          const SizedBox(height: 8),
          ..._passed.map((String p) => _probeLine(p, true)),
          ..._failed.map((String f) => _probeLine(f, false)),
        ],
      ),
    );
  }

  Widget _eventLogPanel() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Event log', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: ListView.builder(
              itemCount: _events.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(_events[index], style: const TextStyle(fontSize: 12)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _summary() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD6E0EA)),
      ),
      child: const Text(
        'IsolateNameServer deep demo summary: name-based SendPort discovery enables decoupled '
        'message routing between isolate contexts. This demo covers registration lifecycle, '
        'duplicate handling, unknown lookups, and operational cleanup patterns.',
        style: TextStyle(fontSize: 12.3, height: 1.35),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('dart:ui - IsolateNameServer'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        elevation: 0.6,
      ),
      body: ListView(
        children: <Widget>[
          _header(),
          _sectionTitle(
            '1) Concept overview',
            'Understand the global name-to-port registry model.',
            Icons.menu_book,
            const Color(0xFF2563EB),
          ),
          _conceptOverview(),
          _sectionTitle(
            '2) Messaging topology',
            'Visual map of channels and routed traffic.',
            Icons.hub,
            const Color(0xFF0F766E),
          ),
          _topologyPanel(),
          _sectionTitle(
            '3) Namespace controls',
            'Register, lookup, send, and remove active channel mappings.',
            Icons.tune,
            const Color(0xFF7C3AED),
          ),
          _controlsPanel(),
          _sectionTitle(
            '4) Practical use-cases',
            'Common architecture patterns for named port messaging.',
            Icons.widgets,
            const Color(0xFFB45309),
          ),
          _useCases(),
          _sectionTitle(
            '5) Probe checks',
            'Runtime verification for lookup/register/remove semantics.',
            Icons.fact_check,
            const Color(0xFF166534),
          ),
          _probeDashboard(),
          _sectionTitle(
            '6) Event telemetry',
            'Observe real messages and operations in chronological order.',
            Icons.history,
            const Color(0xFF334155),
          ),
          _eventLogPanel(),
          _sectionTitle(
            '7) Final notes',
            'Operational guidance for safe lifecycle management.',
            Icons.info_outline,
            const Color(0xFF475569),
          ),
          _summary(),
        ],
      ),
    );
  }
}

class _TopologyPainter extends CustomPainter {
  const _TopologyPainter({
    required this.pulse,
    required this.animate,
    required this.showGrid,
    required this.activeChannel,
  });

  final double pulse;
  final bool animate;
  final bool showGrid;
  final int activeChannel;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFF111827).withAlpha(25);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10)),
      bg,
    );

    if (showGrid) {
      final Paint gp = Paint()
        ..color = Colors.white24
        ..strokeWidth = 1;
      const double gap = 16;
      for (double x = 0; x <= size.width; x += gap) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), gp);
      }
      for (double y = 0; y <= size.height; y += gap) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), gp);
      }
    }

    final Offset producer = Offset(size.width * 0.18, size.height * 0.5);
    final Offset router = Offset(size.width * 0.48, size.height * 0.5);
    final Offset a = Offset(size.width * 0.8, size.height * 0.2);
    final Offset b = Offset(size.width * 0.8, size.height * 0.5);
    final Offset c = Offset(size.width * 0.8, size.height * 0.8);

    final Paint line = Paint()
      ..color = const Color(0xFF64748B)
      ..strokeWidth = 2;
    canvas.drawLine(producer, router, line);
    canvas.drawLine(router, a, line);
    canvas.drawLine(router, b, line);
    canvas.drawLine(router, c, line);

    void drawNode(Offset pos, String label, Color color) {
      final Paint p = Paint()..color = color;
      canvas.drawCircle(pos, 16, p);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: label,
          style: const TextStyle(fontSize: 10, color: Colors.black87),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(pos.dx - tp.width / 2, pos.dy + 20));
    }

    drawNode(producer, 'Producer', const Color(0xFF38BDF8));
    drawNode(router, 'Registry', const Color(0xFF818CF8));
    drawNode(a, 'Alpha', activeChannel == 0 ? const Color(0xFF22C55E) : const Color(0xFFA3A3A3));
    drawNode(b, 'Beta', activeChannel == 1 ? const Color(0xFF22C55E) : const Color(0xFFA3A3A3));
    drawNode(c, 'Gamma', activeChannel == 2 ? const Color(0xFF22C55E) : const Color(0xFFA3A3A3));

    if (animate) {
      final double t = pulse;
      final Offset p = Offset.lerp(producer, router, t) ?? producer;
      final Paint dot = Paint()..color = const Color(0xFF0EA5E9);
      canvas.drawCircle(p, 5, dot);

      final Offset target = activeChannel == 0 ? a : (activeChannel == 1 ? b : c);
      final Offset p2 = Offset.lerp(router, target, t) ?? router;
      final Paint dot2 = Paint()..color = const Color(0xFF22C55E);
      canvas.drawCircle(p2, 5, dot2);
    }
  }

  @override
  bool shouldRepaint(covariant _TopologyPainter oldDelegate) {
    return oldDelegate.pulse != pulse ||
        oldDelegate.animate != animate ||
        oldDelegate.showGrid != showGrid ||
        oldDelegate.activeChannel != activeChannel;
  }
}

// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable
// D4rt test script: Deep Demo — WidgetInspectorService
// ================================================================
// A surveyor's-desk tour of Flutter's WidgetInspectorService — the
// singleton that exposes the widget tree to DevTools via the VM
// service. Every card is hand-drawn with sepia ink, brass rivets
// and a green-felt blotter, in homage to a field notebook kept by
// a 19th century land surveyor mapping an unseen territory: the
// widget tree.
// ================================================================
import 'package:flutter/material.dart';

// ============================================================
// SURVEYOR'S PALETTE — sepia / brass / green felt
// ============================================================
class _WisvInk {
  static const Color felt = Color(0xFF2F4F3A); // green blotter
  static const Color feltDark = Color(0xFF1E3427);
  static const Color feltLight = Color(0xFF3F6A4E);

  static const Color paper = Color(0xFFF4E9CE); // sepia paper
  static const Color paperDark = Color(0xFFE4D1A8);
  static const Color paperLight = Color(0xFFFBF4DF);

  static const Color ink = Color(0xFF3B2A18); // iron-gall ink
  static const Color inkFaded = Color(0xFF6B5840);
  static const Color inkGhost = Color(0xFFA99675);

  static const Color brass = Color(0xFFB58A3A); // polished brass
  static const Color brassDark = Color(0xFF8B6523);
  static const Color brassLight = Color(0xFFD4AE5F);

  static const Color crimson = Color(0xFFA23A2F); // selection halo
  static const Color crimsonDeep = Color(0xFF6E2019);
  static const Color crimsonSoft = Color(0xFFD46A5A);

  static const Color seal = Color(0xFF4B2E1F); // wax seal brown
  static const Color linen = Color(0xFFEDE0C2);
  static const Color chart = Color(0xFFB7A36A);
}

dynamic build(BuildContext context) {
  print('WidgetInspectorService Deep Demo executing');
  print('Theme: Surveyor\'s desk (sepia/brass/green felt)');
  print('Prefix: _Wisv');
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'WidgetInspectorService — Surveyor\'s Desk',
    home: _WisvHome(),
  );
}

// ============================================================
// ROOT — the desk
// ============================================================
class _WisvHome extends StatefulWidget {
  const _WisvHome();

  @override
  State<_WisvHome> createState() => _WisvHomeState();
}

class _WisvHomeState extends State<_WisvHome> {
  final ValueNotifier<String?> _selectedNode =
      ValueNotifier<String?>('RootMaterialApp');
  final ValueNotifier<int> _activeGroupCount = ValueNotifier<int>(3);
  int _activeCardIndex = 0;

  void _setSelection(String? id) {
    _selectedNode.value = id;
    print('  [selection] now: $id');
  }

  @override
  void dispose() {
    _selectedNode.dispose();
    _activeGroupCount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _WisvInk.felt,
      appBar: _WisvAppBar(
        activeCardIndex: _activeCardIndex,
        onCardTap: (i) => setState(() => _activeCardIndex = i),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
        children: [
          const _WisvMasthead(),
          const SizedBox(height: 22),
          const _WisvDossierSection(),
          const SizedBox(height: 22),
          const _WisvSingletonAccessCard(),
          const SizedBox(height: 22),
          _WisvSelectionShowcase(
            selected: _selectedNode,
            onSelect: _setSelection,
          ),
          const SizedBox(height: 22),
          _WisvTreeWalkVisualiser(selected: _selectedNode),
          const SizedBox(height: 22),
          const _WisvServiceExtensionRouting(),
          const SizedBox(height: 22),
          _WisvGroupLifecycle(groupCount: _activeGroupCount),
          const SizedBox(height: 22),
          const _WisvRecipeCards(),
          const SizedBox(height: 22),
          const _WisvComparisonTable(),
          const SizedBox(height: 22),
          const _WisvGlossaryEpilogue(),
          const SizedBox(height: 28),
          const _WisvColophon(),
          const SizedBox(height: 18),
        ],
      ),
    );
  }
}

// ============================================================
// APP BAR — brass rail with title and tab dots
// ============================================================
class _WisvAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _WisvAppBar({
    required this.activeCardIndex,
    required this.onCardTap,
  });

  final int activeCardIndex;
  final ValueChanged<int> onCardTap;

  @override
  Size get preferredSize => const Size.fromHeight(76);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: _WisvInk.feltDark,
      elevation: 0,
      toolbarHeight: 76,
      title: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _WisvInk.brass,
              border: Border.all(color: _WisvInk.brassDark, width: 2),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(1, 2),
                  blurRadius: 3,
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'W',
                style: TextStyle(
                  color: _WisvInk.seal,
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'WidgetInspectorService',
                  style: TextStyle(
                    color: _WisvInk.paperLight,
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                    letterSpacing: 0.6,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Surveyor\'s field notebook · deep demo',
                  style: TextStyle(
                    color: _WisvInk.brassLight,
                    fontStyle: FontStyle.italic,
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: List<Widget>.generate(5, (i) {
              final active = i == activeCardIndex;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: GestureDetector(
                  onTap: () => onCardTap(i),
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: active ? _WisvInk.brass : _WisvInk.paperDark,
                      border: Border.all(
                        color: _WisvInk.brassDark,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// MASTHEAD — the engraved title block
// ============================================================
class _WisvMasthead extends StatelessWidget {
  const _WisvMasthead();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 22),
      decoration: BoxDecoration(
        color: _WisvInk.paper,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _WisvInk.brassDark, width: 2.5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(0, 6),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _WisvCompassRose(size: 58),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'A Surveyor\'s Guide to',
                      style: TextStyle(
                        fontSize: 13,
                        color: _WisvInk.inkFaded,
                        letterSpacing: 2.4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'WidgetInspectorService',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: _WisvInk.ink,
                        letterSpacing: 0.6,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Being a thorough account of the singleton\n'
                      'that carries the widget tree to DevTools,\n'
                      'with maps, diagrams and marginalia.',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontStyle: FontStyle.italic,
                        color: _WisvInk.inkFaded,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              _WisvWaxSeal(),
            ],
          ),
          const SizedBox(height: 16),
          Container(height: 1.2, color: _WisvInk.inkGhost),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Volume I · Folio A',
                style: TextStyle(
                  fontSize: 11,
                  color: _WisvInk.inkFaded,
                  letterSpacing: 1.5,
                ),
              ),
              Text(
                'Plate 01 — Masthead',
                style: TextStyle(
                  fontSize: 11,
                  color: _WisvInk.inkFaded,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================
// COMPASS ROSE — drawn in brass over sepia
// ============================================================
class _WisvCompassRose extends StatelessWidget {
  const _WisvCompassRose({required this.size});
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _WisvCompassRosePainter()),
    );
  }
}

class _WisvCompassRosePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final r = size.shortestSide / 2 - 2;

    final outline = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = _WisvInk.brassDark;
    canvas.drawCircle(center, r, outline);
    canvas.drawCircle(center, r * 0.78, outline);

    final fill = Paint()..color = _WisvInk.brass;
    final fillSoft = Paint()..color = _WisvInk.brassLight;

    void ray(double angle, double length, Paint p) {
      final dx = length * cosApprox(angle);
      final dy = length * sinApprox(angle);
      final pth = Path()
        ..moveTo(center.dx, center.dy)
        ..lineTo(center.dx + dx * 0.12, center.dy + dy * 0.12)
        ..lineTo(center.dx + dx, center.dy + dy)
        ..lineTo(center.dx - dx * 0.12, center.dy - dy * 0.12)
        ..close();
      canvas.drawPath(pth, p);
    }

    // Four cardinal points
    ray(-1.5708, r * 0.95, fill); // N
    ray(1.5708, r * 0.95, fillSoft); // S
    ray(0.0, r * 0.80, fill); // E
    ray(3.1416, r * 0.80, fillSoft); // W

    // Four intercardinals
    ray(-0.7854, r * 0.55, fillSoft);
    ray(0.7854, r * 0.55, fill);
    ray(2.3562, r * 0.55, fillSoft);
    ray(-2.3562, r * 0.55, fill);

    final dot = Paint()..color = _WisvInk.seal;
    canvas.drawCircle(center, 3, dot);

    // N marker
    final tp = TextPainter(
      text: const TextSpan(
        text: 'N',
        style: TextStyle(
          color: _WisvInk.seal,
          fontWeight: FontWeight.w900,
          fontSize: 9,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(center.dx - tp.width / 2, 0));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Tiny trig approximations — the d4rt harness lacks dart:math by
// default in some pipelines; these approximations are good enough
// for decorative glyphs. For real math, use dart:math.
double cosApprox(double a) {
  // Normalize to -pi..pi
  const twoPi = 6.283185307179586;
  var x = a;
  while (x > 3.141592653589793) {
    x -= twoPi;
  }
  while (x < -3.141592653589793) {
    x += twoPi;
  }
  final x2 = x * x;
  return 1 - x2 / 2 + x2 * x2 / 24 - x2 * x2 * x2 / 720;
}

double sinApprox(double a) {
  return cosApprox(a - 1.5707963267948966);
}

// ============================================================
// WAX SEAL — flourish on the masthead
// ============================================================
class _WisvWaxSeal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            _WisvInk.crimsonSoft,
            _WisvInk.crimson,
            _WisvInk.crimsonDeep,
          ],
          stops: const [0.1, 0.55, 1.0],
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: const Center(
        child: Text(
          'WIS',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            color: _WisvInk.paperLight,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SECTION 1 — DOSSIER / PREAMBLE
// Six cards describing the singleton and its wiring.
// ============================================================
class _WisvDossierSection extends StatelessWidget {
  const _WisvDossierSection();

  @override
  Widget build(BuildContext context) {
    const entries = <_WisvDossierEntry>[
      _WisvDossierEntry(
        plate: 'Plate 02',
        icon: Icons.menu_book,
        title: 'What the service is',
        body:
            'WidgetInspectorService is a singleton living in the Flutter '
            'framework at package:flutter/src/widgets/widget_inspector.dart. '
            'It exposes the running widget tree to external tools — chiefly '
            'Flutter DevTools — as a set of JSON-serialisable nodes keyed '
            'by opaque string identifiers.',
        accent: _WisvInk.brass,
      ),
      _WisvDossierEntry(
        plate: 'Plate 03',
        icon: Icons.flash_on,
        title: 'How it is initialised',
        body:
            'The Flutter binding constructs the singleton eagerly on the '
            'first call to WidgetsFlutterBinding.ensureInitialized(). The '
            'service then installs its VM service extensions during '
            'initServiceExtensions(), wiring method names to internal '
            'handlers. There is no explicit setup in user code.',
        accent: _WisvInk.seal,
      ),
      _WisvDossierEntry(
        plate: 'Plate 04',
        icon: Icons.cable,
        title: 'How DevTools reaches it',
        body:
            'DevTools connects over the VM service protocol (a WebSocket '
            'shaped by the Observatory spec). It issues callServiceExtension '
            'RPCs with names like ext.flutter.inspector.getRootWidget. '
            'WidgetInspectorService routes each call to the matching '
            'method and returns a JSON response.',
        accent: _WisvInk.feltDark,
      ),
      _WisvDossierEntry(
        plate: 'Plate 05',
        icon: Icons.key,
        title: 'Singleton access',
        body:
            'A single global accessor — WidgetInspectorService.instance — '
            'returns the live service. The constructor is private; the '
            'framework reserves the right to swap the instance in debug '
            'and profile modes. In release mode many methods are no-ops '
            'and the overlay UI is stripped entirely.',
        accent: _WisvInk.crimsonDeep,
      ),
      _WisvDossierEntry(
        plate: 'Plate 06',
        icon: Icons.account_tree,
        title: 'What it knows about',
        body:
            'The service walks the Element tree rooted at the WidgetsBinding '
            'and hands back nodes described by _Location (file, line, column '
            'of creation), the Widget subtype, and a chain of ancestors. It '
            'also tracks the currently-selected node and offers a selection '
            'callback used by the inspector overlay.',
        accent: _WisvInk.feltLight,
      ),
      _WisvDossierEntry(
        plate: 'Plate 07',
        icon: Icons.layers,
        title: 'Relation to the inspector overlay',
        body:
            'The WidgetInspector widget — the tap-to-select overlay you '
            'see in debug mode — is a thin UI that consults the singleton '
            'for the tree and writes back to its selection field. The '
            'service therefore plays two roles at once: transport for '
            'DevTools, and state for the on-device picker.',
        accent: _WisvInk.chart,
      ),
      _WisvDossierEntry(
        plate: 'Plate 08',
        icon: Icons.lock_clock,
        title: 'Memory model',
        body:
            'Every JSON id minted by the service is tied to a group name. '
            'DevTools picks a group per query batch and later calls '
            'disposeGroup to release the references. This keeps the '
            'weakly-held Element tree from being pinned in memory by an '
            'idle DevTools session. See Plate 20.',
        accent: _WisvInk.brassDark,
      ),
    ];

    final cards = <Widget>[];
    for (var i = 0; i < entries.length; i++) {
      cards.add(_WisvDossierCard(entry: entries[i], index: i));
      if (i != entries.length - 1) {
        cards.add(const SizedBox(height: 12));
      }
    }

    return _WisvFolio(
      plate: 'Folio I',
      title: 'Dossier — What the Singleton Is',
      subtitle: 'Seven cards of provenance, wiring and scope.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: cards,
      ),
    );
  }
}

class _WisvDossierEntry {
  const _WisvDossierEntry({
    required this.plate,
    required this.icon,
    required this.title,
    required this.body,
    required this.accent,
  });
  final String plate;
  final IconData icon;
  final String title;
  final String body;
  final Color accent;
}

class _WisvDossierCard extends StatelessWidget {
  const _WisvDossierCard({required this.entry, required this.index});
  final _WisvDossierEntry entry;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _WisvInk.linen,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: _WisvInk.inkGhost, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: entry.accent.withOpacity(0.18),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: entry.accent, width: 1.2),
            ),
            child: Icon(entry.icon, color: entry.accent, size: 26),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entry.title,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                        color: _WisvInk.ink,
                      ),
                    ),
                    Text(
                      entry.plate,
                      style: const TextStyle(
                        fontSize: 10,
                        letterSpacing: 1.5,
                        color: _WisvInk.inkFaded,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  entry.body,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.45,
                    color: _WisvInk.inkFaded,
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

// ============================================================
// Reusable "folio" wrapper — a section heading with a brass rule.
// ============================================================
class _WisvFolio extends StatelessWidget {
  const _WisvFolio({
    required this.plate,
    required this.title,
    required this.subtitle,
    required this.child,
  });
  final String plate;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 22),
      decoration: BoxDecoration(
        color: _WisvInk.paper,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _WisvInk.brassDark, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _WisvInk.brass,
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(color: _WisvInk.brassDark, width: 1),
                ),
                child: Text(
                  plate.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    color: _WisvInk.seal,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.8,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: _WisvInk.ink,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontStyle: FontStyle.italic,
                        color: _WisvInk.inkFaded,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(height: 1.4, color: _WisvInk.inkGhost),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

// ============================================================
// SECTION 2 — SINGLETON ACCESS LIVE DEMO
// Safely reads WidgetInspectorService.instance, reports its
// runtimeType and hashCode, and narrates the access pattern.
// ============================================================
class _WisvSingletonAccessCard extends StatelessWidget {
  const _WisvSingletonAccessCard();

  @override
  Widget build(BuildContext context) {
    final probe = _probeSingleton();

    return _WisvFolio(
      plate: 'Folio II',
      title: 'Singleton Access — Live Probe',
      subtitle:
          'WidgetInspectorService.instance returns the same object on '
          'every read. We probe it here without mutating any selection.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _WisvInstanceReadout(probe: probe),
          const SizedBox(height: 14),
          _WisvSingletonNarrative(),
          const SizedBox(height: 14),
          _WisvSingletonCodeSnippet(),
          const SizedBox(height: 14),
          _WisvSingletonSafetyNote(),
        ],
      ),
    );
  }
}

class _WisvSingletonProbe {
  const _WisvSingletonProbe({
    required this.available,
    required this.runtimeTypeName,
    required this.hashCodeValue,
    required this.message,
  });
  final bool available;
  final String runtimeTypeName;
  final int hashCodeValue;
  final String message;
}

_WisvSingletonProbe _probeSingleton() {
  // Guarded access — the d4rt harness may or may not have the
  // framework binding initialised; either way we report a result
  // rather than throwing uncaught errors at render time.
  try {
    // The real call, wrapped so analyzer sees a live reference.
    final svc = WidgetInspectorService.instance;
    final typeName = svc.runtimeType.toString();
    final hc = svc.hashCode;
    print('  [singleton] runtimeType=$typeName hashCode=$hc');
    return _WisvSingletonProbe(
      available: true,
      runtimeTypeName: typeName,
      hashCodeValue: hc,
      message: 'available',
    );
  } catch (e, _) {
    final msg = e.toString();
    print('  [singleton] error while reading instance: $msg');
    return _WisvSingletonProbe(
      available: false,
      runtimeTypeName: '<unavailable>',
      hashCodeValue: 0,
      message: 'error: ${_truncate(msg, 120)}',
    );
  }
}

String _truncate(String s, int n) {
  if (s.length <= n) return s;
  return '${s.substring(0, n)}…';
}

class _WisvInstanceReadout extends StatelessWidget {
  const _WisvInstanceReadout({required this.probe});
  final _WisvSingletonProbe probe;

  @override
  Widget build(BuildContext context) {
    final ok = probe.available;
    final accent = ok ? _WisvInk.feltDark : _WisvInk.crimsonDeep;
    final tint = ok ? _WisvInk.feltLight : _WisvInk.crimsonSoft;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _WisvInk.linen,
        border: Border.all(color: accent, width: 1.4),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: tint.withOpacity(0.3),
                  border: Border.all(color: accent, width: 1.2),
                ),
                child: Icon(
                  ok ? Icons.check_circle : Icons.error_outline,
                  color: accent,
                  size: 26,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ok
                          ? 'Service located on the desk.'
                          : 'Service could not be reached.',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Result: ${probe.message}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: _WisvInk.inkFaded,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _WisvFieldRow(
            label: 'runtimeType',
            value: probe.runtimeTypeName,
          ),
          _WisvFieldRow(
            label: 'hashCode',
            value: probe.available
                ? '0x${probe.hashCodeValue.toRadixString(16)}'
                : '—',
          ),
          _WisvFieldRow(
            label: 'identical on reread',
            value: probe.available ? 'yes — same singleton' : 'n/a',
          ),
          _WisvFieldRow(
            label: 'created by',
            value: 'WidgetsFlutterBinding.ensureInitialized()',
          ),
        ],
      ),
    );
  }
}

class _WisvFieldRow extends StatelessWidget {
  const _WisvFieldRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11.5,
                color: _WisvInk.inkFaded,
                letterSpacing: 0.6,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12.5,
                color: _WisvInk.ink,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WisvSingletonNarrative extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _WisvInk.paperLight,
        border: Border.all(color: _WisvInk.inkGhost, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The singleton pattern, in prose.',
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w800,
              color: _WisvInk.ink,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'WidgetInspectorService exposes exactly one instance per '
            'isolate. The implementation is approximately:',
            style: TextStyle(
              fontSize: 12,
              color: _WisvInk.inkFaded,
              height: 1.5,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '  static WidgetInspectorService get instance => _instance;\n'
            '  static WidgetInspectorService _instance = WidgetInspectorService._();',
            style: TextStyle(
              fontSize: 11.5,
              color: _WisvInk.seal,
              fontFamily: 'monospace',
              height: 1.5,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Because the backing field is eagerly initialised, a probe '
            'from any isolate observer — the on-device inspector overlay, '
            'a DevTools RPC, a VM-service extension handler — sees the '
            'same object with the same hashCode. Identity is the contract.',
            style: TextStyle(
              fontSize: 12,
              color: _WisvInk.inkFaded,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _WisvSingletonCodeSnippet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2B22),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: _WisvInk.feltDark, width: 1),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.terminal, color: _WisvInk.brassLight, size: 16),
              SizedBox(width: 6),
              Text(
                'user-land probe',
                style: TextStyle(
                  color: _WisvInk.brassLight,
                  fontSize: 10.5,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            '// Safe to call in debug and profile modes.\n'
            'try {\n'
            '  final svc = WidgetInspectorService.instance;\n'
            '  debugPrint(\'kind: \${svc.runtimeType}\');\n'
            '  debugPrint(\'hash: \${svc.hashCode}\');\n'
            '} catch (e) {\n'
            '  debugPrint(\'inspector not available: \$e\');\n'
            '}',
            style: TextStyle(
              color: _WisvInk.paperLight,
              fontSize: 11.5,
              fontFamily: 'monospace',
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _WisvSingletonSafetyNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _WisvInk.brassLight.withOpacity(0.22),
        border: Border.all(color: _WisvInk.brassDark, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber, color: _WisvInk.brassDark, size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Do not treat the singleton as stable public API. Method '
              'names and signatures are internal; DevTools is the only '
              'intended client. The probe above is diagnostic, not '
              'contractual.',
              style: TextStyle(
                fontSize: 11.5,
                color: _WisvInk.seal,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SECTION 3 — SELECTION SHOWCASE
// A grid of widget cards. Tapping a card "selects" it locally
// via a ValueNotifier that mirrors WidgetInspectorService's
// selection field — WITHOUT calling the real setSelection().
// ============================================================
class _WisvSelectionShowcase extends StatelessWidget {
  const _WisvSelectionShowcase({
    required this.selected,
    required this.onSelect,
  });

  final ValueNotifier<String?> selected;
  final ValueChanged<String?> onSelect;

  static const List<_WisvSelectable> specimens = <_WisvSelectable>[
    _WisvSelectable(
      id: 'RootMaterialApp',
      title: 'MaterialApp',
      subtitle: 'The root widget',
      icon: Icons.apps,
      tint: _WisvInk.brass,
    ),
    _WisvSelectable(
      id: 'Scaffold/home',
      title: 'Scaffold',
      subtitle: 'Page skeleton',
      icon: Icons.dashboard,
      tint: _WisvInk.seal,
    ),
    _WisvSelectable(
      id: 'AppBar/0',
      title: 'AppBar',
      subtitle: 'Top rail',
      icon: Icons.view_agenda,
      tint: _WisvInk.crimson,
    ),
    _WisvSelectable(
      id: 'ListView/body',
      title: 'ListView',
      subtitle: 'Scrollable body',
      icon: Icons.list,
      tint: _WisvInk.feltDark,
    ),
    _WisvSelectable(
      id: 'Card/42',
      title: 'Card',
      subtitle: 'Item tile',
      icon: Icons.bookmark,
      tint: _WisvInk.brassDark,
    ),
    _WisvSelectable(
      id: 'Padding/17',
      title: 'Padding',
      subtitle: 'Inset shim',
      icon: Icons.crop_square,
      tint: _WisvInk.feltLight,
    ),
    _WisvSelectable(
      id: 'Text/caption',
      title: 'Text',
      subtitle: 'Caption',
      icon: Icons.format_color_text,
      tint: _WisvInk.crimsonDeep,
    ),
    _WisvSelectable(
      id: 'IconButton/0',
      title: 'IconButton',
      subtitle: 'Tap target',
      icon: Icons.radio_button_checked,
      tint: _WisvInk.chart,
    ),
    _WisvSelectable(
      id: 'Row/nav',
      title: 'Row',
      subtitle: 'Horizontal layout',
      icon: Icons.table_rows,
      tint: _WisvInk.brass,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _WisvFolio(
      plate: 'Folio III',
      title: 'Selection Showcase',
      subtitle:
          'Tap a specimen to set a local selection. The real '
          'WidgetInspectorService.selection field holds an Element plus '
          'a RenderObject; we mirror only the id here.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _WisvSelectionNarrative(),
          const SizedBox(height: 12),
          _WisvSelectionGrid(
            specimens: specimens,
            selected: selected,
            onSelect: onSelect,
          ),
          const SizedBox(height: 14),
          _WisvSelectionReadout(selected: selected),
          const SizedBox(height: 14),
          _WisvSelectionCaveat(),
        ],
      ),
    );
  }
}

class _WisvSelectable {
  const _WisvSelectable({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.tint,
  });
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color tint;
}

class _WisvSelectionNarrative extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _WisvInk.linen,
        border: Border.all(color: _WisvInk.inkGhost, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Text(
        'In the real service, selection is mediated by an internal '
        '_InspectorSelection object holding both the current Element and '
        'the current RenderObject. DevTools writes to it via a '
        'service extension; the on-device WidgetInspector widget writes '
        'to it from a hit-test on user tap. Readers see a SelectableNotifier '
        'change and repaint the highlight overlay.',
        style: TextStyle(
          fontSize: 12,
          color: _WisvInk.inkFaded,
          height: 1.5,
        ),
      ),
    );
  }
}

class _WisvSelectionGrid extends StatelessWidget {
  const _WisvSelectionGrid({
    required this.specimens,
    required this.selected,
    required this.onSelect,
  });

  final List<_WisvSelectable> specimens;
  final ValueNotifier<String?> selected;
  final ValueChanged<String?> onSelect;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final perRow = width > 520 ? 3 : 2;
        final cellW = (width - (perRow - 1) * 10) / perRow;

        final rows = <Widget>[];
        for (var i = 0; i < specimens.length; i += perRow) {
          final rowItems = <Widget>[];
          for (var j = 0; j < perRow; j++) {
            final k = i + j;
            if (k >= specimens.length) {
              rowItems.add(SizedBox(width: cellW));
            } else {
              rowItems.add(SizedBox(
                width: cellW,
                child: _WisvSelectionTile(
                  specimen: specimens[k],
                  selected: selected,
                  onSelect: onSelect,
                ),
              ));
            }
            if (j != perRow - 1) rowItems.add(const SizedBox(width: 10));
          }
          rows.add(Padding(
            padding: EdgeInsets.only(bottom: i + perRow < specimens.length ? 10 : 0),
            child: Row(children: rowItems),
          ));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: rows,
        );
      },
    );
  }
}

class _WisvSelectionTile extends StatelessWidget {
  const _WisvSelectionTile({
    required this.specimen,
    required this.selected,
    required this.onSelect,
  });
  final _WisvSelectable specimen;
  final ValueNotifier<String?> selected;
  final ValueChanged<String?> onSelect;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: selected,
      builder: (context, currentId, _) {
        final isSelected = currentId == specimen.id;
        return GestureDetector(
          onTap: () => onSelect(specimen.id),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _WisvInk.paperLight,
                  border: Border.all(
                    color: isSelected ? _WisvInk.crimson : _WisvInk.inkGhost,
                    width: isSelected ? 1.8 : 1,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: specimen.tint.withOpacity(0.22),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: specimen.tint,
                              width: 1,
                            ),
                          ),
                          child:
                              Icon(specimen.icon, size: 18, color: specimen.tint),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            specimen.title,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: _WisvInk.ink,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      specimen.subtitle,
                      style: const TextStyle(
                        fontSize: 11,
                        color: _WisvInk.inkFaded,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'id: ${specimen.id}',
                      style: const TextStyle(
                        fontSize: 10,
                        color: _WisvInk.inkFaded,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Positioned.fill(
                  child: IgnorePointer(
                    child: _WisvPulsingHalo(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

// ============================================================
// PULSING HALO — subtle animation driven by TweenAnimationBuilder
// (no AnimationController, no late fields — d4rt friendly).
// ============================================================
class _WisvPulsingHalo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOut,
      builder: (context, t, _) {
        // The builder receives a value 0..1; the tween runs once
        // when the widget mounts. Good enough for a wash of ink.
        final glow = 0.35 + 0.45 * t;
        final thickness = 1.6 + 1.6 * t;
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: _WisvInk.crimson.withOpacity(glow),
              width: thickness,
            ),
            boxShadow: [
              BoxShadow(
                color: _WisvInk.crimson.withOpacity(0.35 * t),
                blurRadius: 8 * t,
                spreadRadius: 1 + t,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _WisvSelectionReadout extends StatelessWidget {
  const _WisvSelectionReadout({required this.selected});
  final ValueNotifier<String?> selected;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: selected,
      builder: (context, id, _) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _WisvInk.feltDark,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: _WisvInk.feltLight, width: 1),
          ),
          child: Row(
            children: [
              const Icon(Icons.center_focus_strong,
                  color: _WisvInk.brassLight, size: 20),
              const SizedBox(width: 10),
              const Text(
                'selection →',
                style: TextStyle(
                  color: _WisvInk.brassLight,
                  fontSize: 11,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  id ?? '(none)',
                  style: const TextStyle(
                    color: _WisvInk.paperLight,
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _WisvSelectionCaveat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _WisvInk.crimsonSoft.withOpacity(0.18),
        border: Border.all(color: _WisvInk.crimsonDeep, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.report_outlined,
              color: _WisvInk.crimsonDeep, size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'We do NOT call WidgetInspectorService.setSelection from this '
              'card. The real API expects a live Element, not an id string, '
              'and writes to a notifier observed by the on-device overlay. '
              'This showcase paints the pattern without touching the service '
              'state — the correct posture for a demo script.',
              style: TextStyle(
                fontSize: 11.5,
                color: _WisvInk.seal,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SECTION 4 — TREE-WALK VISUALISER
// A custom-painted miniature widget tree. The currently-selected
// node (from the showcase above) is highlighted; a side panel
// shows the parent chain, children, and mock "properties".
// ============================================================
class _WisvTreeWalkVisualiser extends StatelessWidget {
  const _WisvTreeWalkVisualiser({required this.selected});
  final ValueNotifier<String?> selected;

  @override
  Widget build(BuildContext context) {
    return _WisvFolio(
      plate: 'Folio IV',
      title: 'Tree-Walk Visualiser',
      subtitle:
          'A schematic of getChildren / getParentChain / getProperties '
          'as they would be served by the singleton for the selected '
          'node.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ValueListenableBuilder<String?>(
            valueListenable: selected,
            builder: (context, id, _) {
              return _WisvTreeCanvas(selectedId: id);
            },
          ),
          const SizedBox(height: 14),
          ValueListenableBuilder<String?>(
            valueListenable: selected,
            builder: (context, id, _) {
              return _WisvTreePanels(selectedId: id);
            },
          ),
        ],
      ),
    );
  }
}

class _WisvTreeNode {
  const _WisvTreeNode({
    required this.id,
    required this.label,
    required this.depth,
    required this.order,
    this.parent,
    this.children = const <String>[],
  });
  final String id;
  final String label;
  final int depth;
  final int order;
  final String? parent;
  final List<String> children;
}

const Map<String, _WisvTreeNode> _wisvTree = <String, _WisvTreeNode>{
  'RootMaterialApp': _WisvTreeNode(
    id: 'RootMaterialApp',
    label: 'MaterialApp',
    depth: 0,
    order: 0,
    children: ['Scaffold/home'],
  ),
  'Scaffold/home': _WisvTreeNode(
    id: 'Scaffold/home',
    label: 'Scaffold',
    depth: 1,
    order: 0,
    parent: 'RootMaterialApp',
    children: ['AppBar/0', 'ListView/body'],
  ),
  'AppBar/0': _WisvTreeNode(
    id: 'AppBar/0',
    label: 'AppBar',
    depth: 2,
    order: 0,
    parent: 'Scaffold/home',
    children: ['Row/nav'],
  ),
  'Row/nav': _WisvTreeNode(
    id: 'Row/nav',
    label: 'Row',
    depth: 3,
    order: 0,
    parent: 'AppBar/0',
    children: ['IconButton/0'],
  ),
  'IconButton/0': _WisvTreeNode(
    id: 'IconButton/0',
    label: 'IconButton',
    depth: 4,
    order: 0,
    parent: 'Row/nav',
  ),
  'ListView/body': _WisvTreeNode(
    id: 'ListView/body',
    label: 'ListView',
    depth: 2,
    order: 1,
    parent: 'Scaffold/home',
    children: ['Card/42'],
  ),
  'Card/42': _WisvTreeNode(
    id: 'Card/42',
    label: 'Card',
    depth: 3,
    order: 0,
    parent: 'ListView/body',
    children: ['Padding/17'],
  ),
  'Padding/17': _WisvTreeNode(
    id: 'Padding/17',
    label: 'Padding',
    depth: 4,
    order: 0,
    parent: 'Card/42',
    children: ['Text/caption'],
  ),
  'Text/caption': _WisvTreeNode(
    id: 'Text/caption',
    label: 'Text',
    depth: 5,
    order: 0,
    parent: 'Padding/17',
  ),
};

class _WisvTreeCanvas extends StatelessWidget {
  const _WisvTreeCanvas({required this.selectedId});
  final String? selectedId;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      decoration: BoxDecoration(
        color: _WisvInk.paperLight,
        border: Border.all(color: _WisvInk.inkGhost, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: CustomPaint(
        painter: _WisvTreePainter(selectedId: selectedId),
        child: Container(),
      ),
    );
  }
}

class _WisvTreePainter extends CustomPainter {
  _WisvTreePainter({required this.selectedId});
  final String? selectedId;

  @override
  void paint(Canvas canvas, Size size) {
    // Layout in a compact horizontal banner.
    // Positions are keyed off depth (x) and a hand-tuned y for siblings.
    final positions = <String, Offset>{
      'RootMaterialApp': Offset(size.width * 0.07, size.height * 0.5),
      'Scaffold/home': Offset(size.width * 0.21, size.height * 0.5),
      'AppBar/0': Offset(size.width * 0.37, size.height * 0.22),
      'Row/nav': Offset(size.width * 0.53, size.height * 0.22),
      'IconButton/0': Offset(size.width * 0.69, size.height * 0.22),
      'ListView/body': Offset(size.width * 0.37, size.height * 0.78),
      'Card/42': Offset(size.width * 0.53, size.height * 0.78),
      'Padding/17': Offset(size.width * 0.69, size.height * 0.78),
      'Text/caption': Offset(size.width * 0.86, size.height * 0.78),
    };

    // Draw edges first.
    final edgePaint = Paint()
      ..color = _WisvInk.inkGhost
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;

    final edgeHiPaint = Paint()
      ..color = _WisvInk.crimson
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke;

    _wisvTree.forEach((id, node) {
      final from = positions[id];
      if (from == null) return;
      for (final childId in node.children) {
        final to = positions[childId];
        if (to == null) continue;
        final onPath = _isOnParentChain(childId, selectedId) ||
            _isOnChildSubtree(childId, selectedId);
        final p = onPath ? edgeHiPaint : edgePaint;
        final cp1 = Offset((from.dx + to.dx) / 2, from.dy);
        final cp2 = Offset((from.dx + to.dx) / 2, to.dy);
        final path = Path()
          ..moveTo(from.dx, from.dy)
          ..cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, to.dx, to.dy);
        canvas.drawPath(path, p);
      }
    });

    // Draw nodes on top of edges.
    positions.forEach((id, center) {
      final node = _wisvTree[id]!;
      final selected = id == selectedId;
      final onChain = _isOnParentChain(id, selectedId);

      final nodePaint = Paint()
        ..color = selected
            ? _WisvInk.crimson.withOpacity(0.28)
            : onChain
                ? _WisvInk.brass.withOpacity(0.22)
                : _WisvInk.linen;
      final borderPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = selected ? 2.4 : 1.4
        ..color = selected
            ? _WisvInk.crimson
            : onChain
                ? _WisvInk.brassDark
                : _WisvInk.inkFaded;

      final rr = RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: 88, height: 36),
        const Radius.circular(4),
      );
      canvas.drawRRect(rr, nodePaint);
      canvas.drawRRect(rr, borderPaint);

      final tp = TextPainter(
        text: TextSpan(
          text: node.label,
          style: TextStyle(
            fontSize: 11,
            color: _WisvInk.ink,
            fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: 84);
      tp.paint(
        canvas,
        Offset(center.dx - tp.width / 2, center.dy - tp.height / 2),
      );
    });

    // Caption along the top.
    final capTp = TextPainter(
      text: const TextSpan(
        text: 'getChildren / getParentChain / getProperties — tree walk',
        style: TextStyle(
          fontSize: 10,
          color: _WisvInk.inkFaded,
          letterSpacing: 1.5,
          fontStyle: FontStyle.italic,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    capTp.paint(canvas, const Offset(8, 4));
  }

  bool _isOnParentChain(String id, String? sel) {
    if (sel == null) return false;
    var cur = _wisvTree[sel];
    while (cur != null) {
      if (cur.id == id) return true;
      cur = cur.parent == null ? null : _wisvTree[cur.parent!];
    }
    return false;
  }

  bool _isOnChildSubtree(String id, String? sel) {
    if (sel == null) return false;
    // Mark an edge red if its child endpoint lies under the selected node.
    var cur = _wisvTree[id];
    while (cur != null) {
      if (cur.id == sel) return true;
      cur = cur.parent == null ? null : _wisvTree[cur.parent!];
    }
    return false;
  }

  @override
  bool shouldRepaint(covariant _WisvTreePainter oldDelegate) =>
      oldDelegate.selectedId != selectedId;
}

// ============================================================
// TREE PANELS — parent chain, children, properties
// ============================================================
class _WisvTreePanels extends StatelessWidget {
  const _WisvTreePanels({required this.selectedId});
  final String? selectedId;

  @override
  Widget build(BuildContext context) {
    final sel = selectedId == null ? null : _wisvTree[selectedId];

    final parentChain = <String>[];
    var cur = sel;
    while (cur != null) {
      parentChain.insert(0, cur.label);
      cur = cur.parent == null ? null : _wisvTree[cur.parent!];
    }

    final children = sel == null
        ? const <String>[]
        : sel.children.map((id) => _wisvTree[id]?.label ?? id).toList();

    final props = _mockPropsFor(sel?.label);

    return LayoutBuilder(builder: (context, constraints) {
      final wide = constraints.maxWidth > 620;
      final a = _WisvPanel(
        title: 'parent chain',
        icon: Icons.arrow_upward,
        accent: _WisvInk.brassDark,
        items: parentChain,
      );
      final b = _WisvPanel(
        title: 'children',
        icon: Icons.arrow_downward,
        accent: _WisvInk.feltDark,
        items: children,
      );
      final c = _WisvPropsPanel(props: props);

      if (wide) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: a),
            const SizedBox(width: 10),
            Expanded(child: b),
            const SizedBox(width: 10),
            Expanded(flex: 2, child: c),
          ],
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          a,
          const SizedBox(height: 10),
          b,
          const SizedBox(height: 10),
          c,
        ],
      );
    });
  }

  List<MapEntry<String, String>> _mockPropsFor(String? label) {
    if (label == null) {
      return const <MapEntry<String, String>>[
        MapEntry('(nothing selected)', '—'),
      ];
    }
    switch (label) {
      case 'MaterialApp':
        return const [
          MapEntry('title', 'Surveyor\'s Desk'),
          MapEntry('debugShowCheckedModeBanner', 'false'),
          MapEntry('theme', 'ThemeData.light()'),
        ];
      case 'Scaffold':
        return const [
          MapEntry('backgroundColor', '0xFF2F4F3A'),
          MapEntry('appBar', 'AppBar'),
          MapEntry('body', 'ListView'),
        ];
      case 'AppBar':
        return const [
          MapEntry('elevation', '0'),
          MapEntry('toolbarHeight', '76.0'),
          MapEntry('backgroundColor', '0xFF1E3427'),
        ];
      case 'Row':
        return const [
          MapEntry('mainAxisAlignment', 'start'),
          MapEntry('crossAxisAlignment', 'center'),
        ];
      case 'IconButton':
        return const [
          MapEntry('icon', 'Icon(…)'),
          MapEntry('onPressed', 'Closure'),
          MapEntry('iconSize', '24.0'),
        ];
      case 'ListView':
        return const [
          MapEntry('scrollDirection', 'vertical'),
          MapEntry('padding', 'EdgeInsets(18, 22, 18, 22)'),
        ];
      case 'Card':
        return const [
          MapEntry('elevation', '2.0'),
          MapEntry('color', '0xFFF4E9CE'),
        ];
      case 'Padding':
        return const [
          MapEntry('padding', 'EdgeInsets.all(14)'),
        ];
      case 'Text':
        return const [
          MapEntry('data', 'A surveyor\'s note.'),
          MapEntry('style', 'TextStyle(…)'),
        ];
      default:
        return const [MapEntry('(unknown widget)', '—')];
    }
  }
}

class _WisvPanel extends StatelessWidget {
  const _WisvPanel({
    required this.title,
    required this.icon,
    required this.accent,
    required this.items,
  });
  final String title;
  final IconData icon;
  final Color accent;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _WisvInk.linen,
        border: Border.all(color: accent, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(icon, color: accent, size: 16),
              const SizedBox(width: 6),
              Text(
                title.toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.8,
                  color: accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (items.isEmpty)
            const Text(
              '(empty)',
              style: TextStyle(
                fontSize: 11,
                color: _WisvInk.inkFaded,
                fontStyle: FontStyle.italic,
              ),
            )
          else
            ...items.map((line) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    '• $line',
                    style: const TextStyle(
                      fontSize: 12,
                      color: _WisvInk.ink,
                      fontFamily: 'monospace',
                    ),
                  ),
                )),
        ],
      ),
    );
  }
}

class _WisvPropsPanel extends StatelessWidget {
  const _WisvPropsPanel({required this.props});
  final List<MapEntry<String, String>> props;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _WisvInk.linen,
        border: Border.all(color: _WisvInk.crimsonDeep, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: const [
              Icon(Icons.list_alt,
                  color: _WisvInk.crimsonDeep, size: 16),
              SizedBox(width: 6),
              Text(
                'PROPERTIES',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.8,
                  color: _WisvInk.crimsonDeep,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...props.map((e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 110,
                      child: Text(
                        e.key,
                        style: const TextStyle(
                          fontSize: 11,
                          color: _WisvInk.inkFaded,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        e.value,
                        style: const TextStyle(
                          fontSize: 11.5,
                          color: _WisvInk.ink,
                          fontFamily: 'monospace',
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

// ============================================================
// SECTION 5 — SERVICE-EXTENSION ROUTING
// Maps method names from WidgetInspectorServiceExtensions to
// their high-level purpose. Displayed as a routing ledger.
// ============================================================
class _WisvServiceExtensionRouting extends StatelessWidget {
  const _WisvServiceExtensionRouting();

  @override
  Widget build(BuildContext context) {
    const rows = <_WisvRouteRow>[
      _WisvRouteRow(
        methodName: 'getRootWidget',
        purpose:
            'Return the id of the root widget element so DevTools can '
            'start walking the tree. Used on connection.',
      ),
      _WisvRouteRow(
        methodName: 'getChildren',
        purpose:
            'Return ids of direct children for a given parent id. Paged '
            'to keep payloads manageable on deep trees.',
      ),
      _WisvRouteRow(
        methodName: 'getProperties',
        purpose:
            'Return the DiagnosticsNode list for a widget — its fields, '
            'annotations, and styled labels for DevTools\' panel.',
      ),
      _WisvRouteRow(
        methodName: 'getSelectedWidget',
        purpose:
            'Return the currently selected widget, if any. DevTools polls '
            'this to sync its highlighted row.',
      ),
      _WisvRouteRow(
        methodName: 'setPubRootDirectories',
        purpose:
            'Restrict tree-walks to user code by filtering on the source '
            'location (pub root). Hides framework innards.',
      ),
      _WisvRouteRow(
        methodName: 'disposeGroup',
        purpose:
            'Release all ids minted under a group. Prevents unbounded '
            'retention of Element references.',
      ),
      _WisvRouteRow(
        methodName: 'disposeAllGroups',
        purpose:
            'Wipe all groups. Called when DevTools disconnects or when '
            'the user explicitly clears the tree cache.',
      ),
      _WisvRouteRow(
        methodName: 'screenshot',
        purpose:
            'Render a single widget subtree to an image and return PNG '
            'bytes. Powers the "take screenshot" action in DevTools.',
      ),
      _WisvRouteRow(
        methodName: 'setSelection',
        purpose:
            'Set the current selection from an id. Causes the inspector '
            'overlay to repaint with a highlight.',
      ),
      _WisvRouteRow(
        methodName: 'structuredErrors',
        purpose:
            'Switch error reporting to DevTools-friendly JSON payloads '
            'instead of plain debugPrint lines.',
      ),
    ];

    return _WisvFolio(
      plate: 'Folio V',
      title: 'Service-Extension Routing Ledger',
      subtitle:
          'Each row is an ext.flutter.inspector.<name> RPC. The '
          'WidgetInspectorServiceExtensions enum defines the canonical '
          'method names.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _WisvRoutingLedgerHeader(),
          for (var i = 0; i < rows.length; i++)
            _WisvRoutingLedgerRow(row: rows[i], stripe: i.isEven),
          const SizedBox(height: 12),
          _WisvRoutingDiagram(),
        ],
      ),
    );
  }
}

class _WisvRouteRow {
  const _WisvRouteRow({required this.methodName, required this.purpose});
  final String methodName;
  final String purpose;
}

class _WisvRoutingLedgerHeader extends StatelessWidget {
  const _WisvRoutingLedgerHeader();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: _WisvInk.feltDark,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
      ),
      child: const Row(
        children: [
          SizedBox(
            width: 200,
            child: Text(
              'ext.flutter.inspector.…',
              style: TextStyle(
                color: _WisvInk.brassLight,
                fontWeight: FontWeight.w800,
                fontSize: 11.5,
                letterSpacing: 1.2,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              'purpose',
              style: TextStyle(
                color: _WisvInk.brassLight,
                fontWeight: FontWeight.w800,
                fontSize: 11.5,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WisvRoutingLedgerRow extends StatelessWidget {
  const _WisvRoutingLedgerRow({required this.row, required this.stripe});
  final _WisvRouteRow row;
  final bool stripe;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: stripe ? _WisvInk.linen : _WisvInk.paperLight,
        border: const Border(
          left: BorderSide(color: _WisvInk.inkGhost, width: 1),
          right: BorderSide(color: _WisvInk.inkGhost, width: 1),
          bottom: BorderSide(color: _WisvInk.inkGhost, width: 0.6),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: Text(
              row.methodName,
              style: const TextStyle(
                fontSize: 12,
                color: _WisvInk.seal,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              row.purpose,
              style: const TextStyle(
                fontSize: 11.5,
                color: _WisvInk.inkFaded,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WisvRoutingDiagram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _WisvInk.paperLight,
        border: Border.all(color: _WisvInk.inkGhost, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: CustomPaint(
        painter: _WisvRoutingDiagramPainter(),
        child: Container(),
      ),
    );
  }
}

class _WisvRoutingDiagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final left = Rect.fromLTWH(4, 14, 150, size.height - 28);
    final middle = Rect.fromLTWH(
        (size.width - 150) / 2, 14, 150, size.height - 28);
    final right = Rect.fromLTWH(
        size.width - 154, 14, 150, size.height - 28);

    void drawBox(Rect r, String head, String sub, Color tint) {
      final fill = Paint()..color = tint.withOpacity(0.16);
      final border = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..color = tint;
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(4)),
        fill,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(4)),
        border,
      );
      final tp = TextPainter(
        text: TextSpan(children: [
          TextSpan(
            text: '$head\n',
            style: TextStyle(
              color: tint,
              fontSize: 12.5,
              fontWeight: FontWeight.w900,
            ),
          ),
          TextSpan(
            text: sub,
            style: const TextStyle(
              color: _WisvInk.inkFaded,
              fontSize: 10.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ]),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: r.width - 10);
      tp.paint(
        canvas,
        Offset(r.center.dx - tp.width / 2, r.center.dy - tp.height / 2),
      );
    }

    drawBox(left, 'DevTools', 'callServiceExtension', _WisvInk.feltDark);
    drawBox(
        middle, 'VM Service', 'ext.flutter.inspector.*', _WisvInk.brassDark);
    drawBox(right, 'WidgetInspectorService',
        'method dispatch', _WisvInk.crimsonDeep);

    final arrow = Paint()
      ..color = _WisvInk.ink
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    void drawArrow(Offset from, Offset to) {
      canvas.drawLine(from, to, arrow);
      final tip = Path()
        ..moveTo(to.dx, to.dy)
        ..lineTo(to.dx - 6, to.dy - 4)
        ..lineTo(to.dx - 6, to.dy + 4)
        ..close();
      canvas.drawPath(tip, Paint()..color = _WisvInk.ink);
    }

    drawArrow(
      Offset(left.right, left.center.dy),
      Offset(middle.left - 2, middle.center.dy),
    );
    drawArrow(
      Offset(middle.right, middle.center.dy),
      Offset(right.left - 2, right.center.dy),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================================
// SECTION 6 — GROUP LIFECYCLE
// Narrates disposeGroup / disposeAllGroups with a diagram.
// ============================================================
class _WisvGroupLifecycle extends StatelessWidget {
  const _WisvGroupLifecycle({required this.groupCount});
  final ValueNotifier<int> groupCount;

  @override
  Widget build(BuildContext context) {
    return _WisvFolio(
      plate: 'Folio VI',
      title: 'Group Lifecycle — Memory Hygiene',
      subtitle:
          'Every id minted by the service lives in a group. Groups are '
          'allocated by DevTools for each query batch, then released.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ValueListenableBuilder<int>(
            valueListenable: groupCount,
            builder: (context, n, _) {
              return _WisvGroupDiagram(count: n);
            },
          ),
          const SizedBox(height: 12),
          _WisvGroupControls(groupCount: groupCount),
          const SizedBox(height: 12),
          const _WisvGroupRationale(),
        ],
      ),
    );
  }
}

class _WisvGroupDiagram extends StatelessWidget {
  const _WisvGroupDiagram({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    final groups = <_WisvGroupSketch>[
      const _WisvGroupSketch(
        name: 'devtools-0',
        ids: ['w-0', 'w-1', 'w-2', 'w-3'],
        purpose: 'initial tree walk',
      ),
      const _WisvGroupSketch(
        name: 'devtools-1',
        ids: ['w-4', 'w-5'],
        purpose: 'children of Scaffold',
      ),
      const _WisvGroupSketch(
        name: 'devtools-2',
        ids: ['w-6'],
        purpose: 'property query',
      ),
      const _WisvGroupSketch(
        name: 'devtools-3',
        ids: ['w-7', 'w-8', 'w-9'],
        purpose: 'selection probe',
      ),
      const _WisvGroupSketch(
        name: 'devtools-4',
        ids: ['w-10', 'w-11'],
        purpose: 'screenshot request',
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _WisvInk.paperLight,
        border: Border.all(color: _WisvInk.inkGhost, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.group_work,
                  color: _WisvInk.brassDark, size: 18),
              const SizedBox(width: 8),
              const Text(
                'GROUPS',
                style: TextStyle(
                  fontSize: 10.5,
                  letterSpacing: 1.8,
                  fontWeight: FontWeight.w900,
                  color: _WisvInk.brassDark,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _WisvInk.brass,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'active: $count / ${groups.length}',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: _WisvInk.seal,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List<Widget>.generate(groups.length, (i) {
              final alive = i < count;
              return _WisvGroupCard(group: groups[i], alive: alive);
            }),
          ),
        ],
      ),
    );
  }
}

class _WisvGroupSketch {
  const _WisvGroupSketch({
    required this.name,
    required this.ids,
    required this.purpose,
  });
  final String name;
  final List<String> ids;
  final String purpose;
}

class _WisvGroupCard extends StatelessWidget {
  const _WisvGroupCard({required this.group, required this.alive});
  final _WisvGroupSketch group;
  final bool alive;

  @override
  Widget build(BuildContext context) {
    final color = alive ? _WisvInk.feltDark : _WisvInk.inkGhost;
    return Container(
      width: 180,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: alive
            ? _WisvInk.feltLight.withOpacity(0.18)
            : _WisvInk.linen,
        border: Border.all(color: color, width: 1.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                alive ? Icons.radio_button_checked : Icons.cancel_outlined,
                color: color,
                size: 14,
              ),
              const SizedBox(width: 6),
              Text(
                group.name,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: color,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            group.purpose,
            style: const TextStyle(
              fontSize: 10.5,
              color: _WisvInk.inkFaded,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: group.ids
                .map((id) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: alive
                            ? _WisvInk.brass.withOpacity(0.22)
                            : _WisvInk.paperDark,
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(
                            color: _WisvInk.inkGhost, width: 0.6),
                      ),
                      child: Text(
                        id,
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'monospace',
                          color: alive
                              ? _WisvInk.seal
                              : _WisvInk.inkFaded,
                          decoration: alive
                              ? TextDecoration.none
                              : TextDecoration.lineThrough,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _WisvGroupControls extends StatelessWidget {
  const _WisvGroupControls({required this.groupCount});
  final ValueNotifier<int> groupCount;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: groupCount,
      builder: (context, n, _) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _WisvInk.linen,
            border: Border.all(color: _WisvInk.brassDark, width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              _WisvInkButton(
                label: 'allocate group',
                icon: Icons.add_circle_outline,
                onTap: () {
                  groupCount.value = (n + 1).clamp(0, 5);
                },
              ),
              const SizedBox(width: 8),
              _WisvInkButton(
                label: 'disposeGroup',
                icon: Icons.remove_circle_outline,
                onTap: () {
                  groupCount.value = (n - 1).clamp(0, 5);
                },
              ),
              const SizedBox(width: 8),
              _WisvInkButton(
                label: 'disposeAllGroups',
                icon: Icons.delete_sweep_outlined,
                onTap: () {
                  groupCount.value = 0;
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _WisvInkButton extends StatelessWidget {
  const _WisvInkButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: _WisvInk.paperLight,
            border: Border.all(color: _WisvInk.brassDark, width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: _WisvInk.seal, size: 14),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: _WisvInk.seal,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WisvGroupRationale extends StatelessWidget {
  const _WisvGroupRationale();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _WisvInk.brassLight.withOpacity(0.2),
        border: Border.all(color: _WisvInk.brassDark, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Text(
        'Why groups at all? Because ids returned to DevTools keep '
        'the underlying Element alive. A long-lived DevTools session '
        'on a busy app could accumulate millions of ids. The group '
        'discipline lets DevTools batch-release everything from a '
        'prior query before issuing a new one.',
        style: TextStyle(
          fontSize: 12,
          color: _WisvInk.seal,
          height: 1.5,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}

// ============================================================
// SECTION 7 — RECIPE CARDS
// Five+ hand-sketched recipes for common integrations.
// ============================================================
class _WisvRecipeCards extends StatelessWidget {
  const _WisvRecipeCards();

  @override
  Widget build(BuildContext context) {
    const recipes = <_WisvRecipe>[
      _WisvRecipe(
        number: '01',
        title: 'Override selection in a custom overlay',
        steps: [
          'Build your own tap-to-select gesture handler.',
          'On tap, resolve the hit-tested Element via a RenderBox lookup.',
          'Write svc.selection.current = element; svc.selection.notifyListeners();',
          'Repaint highlights from a ValueListenable of svc.selection.',
        ],
        accent: _WisvInk.crimsonDeep,
      ),
      _WisvRecipe(
        number: '02',
        title: 'Custom inspector buttons in debug UI',
        steps: [
          'Add a FloatingActionButton only when !kReleaseMode.',
          'On press, call WidgetInspectorService.instance.disposeAllGroups().',
          'Follow with a toast confirming memory was released.',
          'Guard against accidental production builds with kDebugMode.',
        ],
        accent: _WisvInk.brassDark,
      ),
      _WisvRecipe(
        number: '03',
        title: 'Wire structured errors into reporting',
        steps: [
          'Call WidgetInspectorService.instance.structuredErrors = true.',
          'FlutterError.onError then emits JSON-shaped diagnostics.',
          'Pipe the JSON into Sentry/Crashlytics adapters.',
          'DevTools still shows the rich view when connected.',
        ],
        accent: _WisvInk.seal,
      ),
      _WisvRecipe(
        number: '04',
        title: 'On-device screenshot of a subtree',
        steps: [
          'Wrap the subtree in a RepaintBoundary with a GlobalKey.',
          'At capture time, obtain the RenderRepaintBoundary.',
          'Call boundary.toImage(pixelRatio: 2.5), then image.toByteData(...).',
          'Stash the PNG bytes or upload via platform channel.',
        ],
        accent: _WisvInk.feltDark,
      ),
      _WisvRecipe(
        number: '05',
        title: 'Narrow the tree to user code',
        steps: [
          'At app start: setPubRootDirectories([\'lib\']).',
          'Framework widgets are then filtered from DevTools\' default view.',
          'Toggle the "Show implementation widgets" control in DevTools as needed.',
          'Re-call with [] to clear the filter at runtime.',
        ],
        accent: _WisvInk.chart,
      ),
      _WisvRecipe(
        number: '06',
        title: 'Sync a bespoke picker with selection',
        steps: [
          'Listen to WidgetInspectorService.instance.selection (it extends ChangeNotifier).',
          'In onChanged, read .currentElement and .currentRenderObject.',
          'Update your sidebar selection to match.',
          'Write back on user taps by mutating .current and notifying.',
        ],
        accent: _WisvInk.feltLight,
      ),
    ];

    return _WisvFolio(
      plate: 'Folio VII',
      title: 'Recipe Cards',
      subtitle:
          'Six bench-tested patterns. Keep these in the margin of any '
          'debug tooling you ship.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < recipes.length; i++) ...[
            _WisvRecipeCard(recipe: recipes[i]),
            if (i != recipes.length - 1) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _WisvRecipe {
  const _WisvRecipe({
    required this.number,
    required this.title,
    required this.steps,
    required this.accent,
  });
  final String number;
  final String title;
  final List<String> steps;
  final Color accent;
}

class _WisvRecipeCard extends StatelessWidget {
  const _WisvRecipeCard({required this.recipe});
  final _WisvRecipe recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _WisvInk.paperLight,
        border: Border.all(color: recipe.accent, width: 1.2),
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            offset: Offset(1, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: recipe.accent,
              border: Border.all(color: _WisvInk.brassDark, width: 1.4),
            ),
            child: Center(
              child: Text(
                recipe.number,
                style: const TextStyle(
                  color: _WisvInk.paperLight,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: recipe.accent,
                  ),
                ),
                const SizedBox(height: 6),
                ...List<Widget>.generate(recipe.steps.length, (i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 4, right: 8),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: recipe.accent,
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            recipe.steps[i],
                            style: const TextStyle(
                              fontSize: 12,
                              color: _WisvInk.ink,
                              height: 1.45,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SECTION 8 — COMPARISON WITH OTHER INSPECTION TOOLS
// Table: WidgetInspectorService vs debugPrint / debugDumpApp /
// describeElement / toStringDeep.
// ============================================================
class _WisvComparisonTable extends StatelessWidget {
  const _WisvComparisonTable();

  @override
  Widget build(BuildContext context) {
    const rows = <_WisvCmpRow>[
      _WisvCmpRow(
        tool: 'WidgetInspectorService',
        audience: 'DevTools / on-device picker',
        output: 'JSON, via VM service',
        bestFor:
            'Interactive inspection with navigation, property editing, and '
            'live selection sync.',
      ),
      _WisvCmpRow(
        tool: 'debugPrint',
        audience: 'console / logs',
        output: 'plain text lines',
        bestFor:
            'Ad-hoc tracing of a single value at a specific moment. Batched '
            'to avoid flooding on Android.',
      ),
      _WisvCmpRow(
        tool: 'debugDumpApp',
        audience: 'console / crash logs',
        output: 'multi-line text tree',
        bestFor:
            'Snapshotting the entire widget/element tree to text for post-mortem. '
            'No interactivity.',
      ),
      _WisvCmpRow(
        tool: 'describeElement',
        audience: 'error reports',
        output: 'DiagnosticsNode',
        bestFor:
            'Attaching structured context to a single Element when building '
            'FlutterErrorDetails.',
      ),
      _WisvCmpRow(
        tool: 'toStringDeep',
        audience: 'console',
        output: 'multi-line text',
        bestFor:
            'Dumping a subtree on demand — useful in unit tests or inside '
            'custom debugFillProperties implementations.',
      ),
    ];

    return _WisvFolio(
      plate: 'Folio VIII',
      title: 'Comparison — Where Each Inspection Tool Fits',
      subtitle:
          'Five inspection avenues; each has a different audience and '
          'output shape. Choose by intent.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: _WisvInk.feltDark,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
            child: Row(
              children: const [
                _WisvCmpHeader('tool', flex: 3),
                _WisvCmpHeader('audience', flex: 3),
                _WisvCmpHeader('output', flex: 3),
                _WisvCmpHeader('best for', flex: 6),
              ],
            ),
          ),
          for (var i = 0; i < rows.length; i++)
            _WisvCmpRowWidget(row: rows[i], stripe: i.isEven),
        ],
      ),
    );
  }
}

class _WisvCmpRow {
  const _WisvCmpRow({
    required this.tool,
    required this.audience,
    required this.output,
    required this.bestFor,
  });
  final String tool;
  final String audience;
  final String output;
  final String bestFor;
}

class _WisvCmpHeader extends StatelessWidget {
  const _WisvCmpHeader(this.text, {required this.flex});
  final String text;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: _WisvInk.brassLight,
          fontWeight: FontWeight.w900,
          fontSize: 10.5,
          letterSpacing: 1.8,
        ),
      ),
    );
  }
}

class _WisvCmpRowWidget extends StatelessWidget {
  const _WisvCmpRowWidget({required this.row, required this.stripe});
  final _WisvCmpRow row;
  final bool stripe;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: stripe ? _WisvInk.linen : _WisvInk.paperLight,
        border: const Border(
          left: BorderSide(color: _WisvInk.inkGhost, width: 1),
          right: BorderSide(color: _WisvInk.inkGhost, width: 1),
          bottom: BorderSide(color: _WisvInk.inkGhost, width: 0.6),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _WisvCmpCell(row.tool, flex: 3, mono: true, bold: true),
          _WisvCmpCell(row.audience, flex: 3),
          _WisvCmpCell(row.output, flex: 3),
          _WisvCmpCell(row.bestFor, flex: 6),
        ],
      ),
    );
  }
}

class _WisvCmpCell extends StatelessWidget {
  const _WisvCmpCell(
    this.text, {
    required this.flex,
    this.mono = false,
    this.bold = false,
  });
  final String text;
  final int flex;
  final bool mono;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11.5,
            color: bold ? _WisvInk.seal : _WisvInk.inkFaded,
            fontWeight: bold ? FontWeight.w800 : FontWeight.w500,
            fontFamily: mono ? 'monospace' : null,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SECTION 9 — GLOSSARY / EPILOGUE
// ============================================================
class _WisvGlossaryEpilogue extends StatelessWidget {
  const _WisvGlossaryEpilogue();

  @override
  Widget build(BuildContext context) {
    const entries = <_WisvGlossaryEntry>[
      _WisvGlossaryEntry(
        term: 'Element',
        meaning:
            'The framework\'s mutable node in the widget tree; what the '
            'service actually points at.',
      ),
      _WisvGlossaryEntry(
        term: 'DiagnosticsNode',
        meaning:
            'A labelled value-with-description used by the framework to '
            'describe any debuggable object.',
      ),
      _WisvGlossaryEntry(
        term: 'id / diagnosticsId',
        meaning:
            'Opaque string handed to DevTools; maps back to a specific '
            'Element/DiagnosticsNode within a group.',
      ),
      _WisvGlossaryEntry(
        term: 'group',
        meaning:
            'A named pool of ids the service hands out. disposeGroup '
            'releases the pool\'s references in one shot.',
      ),
      _WisvGlossaryEntry(
        term: 'pub-root directory',
        meaning:
            'A path under which widgets are considered user code. Used to '
            'filter framework widgets from the default view.',
      ),
      _WisvGlossaryEntry(
        term: 'service extension',
        meaning:
            'A registered VM-service method, reachable as '
            'ext.flutter.inspector.<name>.',
      ),
      _WisvGlossaryEntry(
        term: 'structuredErrors',
        meaning:
            'Flag that switches FlutterError formatting to machine-readable '
            'JSON for DevTools/tooling consumption.',
      ),
      _WisvGlossaryEntry(
        term: 'selection',
        meaning:
            'The current (Element, RenderObject) pair that the inspector '
            'overlay highlights. A ChangeNotifier-shaped field.',
      ),
    ];

    return _WisvFolio(
      plate: 'Folio IX',
      title: 'Glossary & Epilogue',
      subtitle:
          'Margin terms, neatly labelled. Close the notebook when done.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: entries
                .map((e) => SizedBox(
                      width: 320,
                      child: _WisvGlossaryCard(entry: e),
                    ))
                .toList(),
          ),
          const SizedBox(height: 14),
          const _WisvEpilogueLetter(),
        ],
      ),
    );
  }
}

class _WisvGlossaryEntry {
  const _WisvGlossaryEntry({required this.term, required this.meaning});
  final String term;
  final String meaning;
}

class _WisvGlossaryCard extends StatelessWidget {
  const _WisvGlossaryCard({required this.entry});
  final _WisvGlossaryEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _WisvInk.linen,
        border: Border.all(color: _WisvInk.inkGhost, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 40,
            decoration: BoxDecoration(
              color: _WisvInk.brassDark,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.term,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: _WisvInk.ink,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  entry.meaning,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: _WisvInk.inkFaded,
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

class _WisvEpilogueLetter extends StatelessWidget {
  const _WisvEpilogueLetter();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _WisvInk.paperLight,
        border: Border.all(color: _WisvInk.brassDark, width: 1.4),
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'On closing the field notebook —',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: _WisvInk.ink,
              letterSpacing: 0.6,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'WidgetInspectorService is a plain singleton that happens to '
            'be wired into two ecosystems at once: the VM service for '
            'off-device tooling, and the on-device inspector overlay for '
            'the developer at the workbench. It works by walking the '
            'Element tree on demand, serialising DiagnosticsNodes, and '
            'shepherding ids into groups so nothing leaks between queries.',
            style: TextStyle(
              fontSize: 12,
              color: _WisvInk.inkFaded,
              height: 1.55,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Treat its methods as private in spirit even where the symbol '
            'is public. Read .instance, listen to .selection, and call '
            'structuredErrors — but leave the lower-level RPC names to '
            'DevTools.',
            style: TextStyle(
              fontSize: 12,
              color: _WisvInk.inkFaded,
              height: 1.55,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '— the Surveyor',
            style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: _WisvInk.seal,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// COLOPHON
// ============================================================
class _WisvColophon extends StatelessWidget {
  const _WisvColophon();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _WisvInk.feltDark,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: _WisvInk.feltLight, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _WisvInk.brass,
            ),
            child: const Icon(
              Icons.auto_stories,
              size: 18,
              color: _WisvInk.seal,
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Colophon',
                  style: TextStyle(
                    color: _WisvInk.brassLight,
                    fontSize: 11,
                    letterSpacing: 1.8,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Deep demo for WidgetInspectorService, set in sepia '
                  'ink on green felt. Compiled in the surveyor\'s '
                  'workshop; no widget was harmed in its drafting.',
                  style: TextStyle(
                    color: _WisvInk.paperLight,
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
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

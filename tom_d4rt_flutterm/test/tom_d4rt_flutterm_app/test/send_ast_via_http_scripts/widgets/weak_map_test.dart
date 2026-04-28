import 'dart:math' as math;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Crystal-lattice palette. Aqua, silver, and indigo tones used throughout the
// demo to echo a mineral / clean-room aesthetic.
// ---------------------------------------------------------------------------
const Color _wmLatInkDeep = Color(0xFF0B1230);
const Color _wmLatInk = Color(0xFF131A3F);
const Color _wmLatInkSoft = Color(0xFF2B3364);
const Color _wmLatPaper = Color(0xFFEDF3FA);
const Color _wmLatPaperAlt = Color(0xFFDDE6F2);
const Color _wmLatSilver = Color(0xFFC6D0DE);
const Color _wmLatSilverSoft = Color(0xFFE4EAF2);
const Color _wmLatAqua = Color(0xFF38BFD1);
const Color _wmLatAquaDeep = Color(0xFF0E8FA1);
const Color _wmLatAquaPale = Color(0xFFBEEBF2);
const Color _wmLatIndigo = Color(0xFF4F4FB1);
const Color _wmLatIndigoDeep = Color(0xFF2E2E7A);
const Color _wmLatIndigoPale = Color(0xFFD7D7F1);
const Color _wmLatAmber = Color(0xFFE0A83A);
const Color _wmLatAmberPale = Color(0xFFF7E6BD);
const Color _wmLatRose = Color(0xFFC8587A);
const Color _wmLatMint = Color(0xFF4AA990);
const Color _wmLatMintPale = Color(0xFFCDE9E0);
const Color _wmLatDanger = Color(0xFFB94B4B);
const Color _wmLatDangerPale = Color(0xFFF3D4D4);

// ---------------------------------------------------------------------------
// d4rt entry point. Single top-level `build` returning a MaterialApp whose
// home is the deep demo shell.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return const _WmLatApp();
}

// ===========================================================================
// ROOT APP
// ===========================================================================
class _WmLatApp extends StatelessWidget {
  const _WmLatApp();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: _wmLatIndigo,
      brightness: Brightness.light,
    ).copyWith(
      primary: _wmLatIndigoDeep,
      secondary: _wmLatAquaDeep,
      surface: _wmLatPaper,
    );
    final ThemeData theme = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: _wmLatPaper,
      fontFamily: 'RobotoMono',
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _wmLatInk, height: 1.4),
        titleLarge: TextStyle(
          color: _wmLatInkDeep,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.4,
        ),
      ),
      dividerColor: _wmLatSilver,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const _WmLatShell(),
    );
  }
}

// ===========================================================================
// SHELL — one long scrollable page composed of a vertical stack of chapters.
// ===========================================================================
class _WmLatShell extends StatefulWidget {
  const _WmLatShell();

  @override
  State<_WmLatShell> createState() => _WmLatShellState();
}

class _WmLatShellState extends State<_WmLatShell>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shimmer;

  @override
  void initState() {
    super.initState();
    _shimmer = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _wmLatPaper,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _shimmer,
              builder: (BuildContext context, Widget? child) {
                return CustomPaint(
                  painter: _WmLatBackgroundPainter(phase: _shimmer.value),
                );
              },
            ),
          ),
          Positioned.fill(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 192,
                  backgroundColor: _wmLatInkDeep,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: _WmLatAppBarBackdrop(phase: _shimmer),
                    titlePadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                    title: const _WmLatAppBarTitle(),
                  ),
                ),
                const SliverToBoxAdapter(child: _WmLatTableOfContents()),
                const SliverToBoxAdapter(child: _WmLatChapterPreamble()),
                const SliverToBoxAdapter(child: _WmLatChapterAnatomy()),
                const SliverToBoxAdapter(child: _WmLatChapterPlayground()),
                const SliverToBoxAdapter(child: _WmLatChapterCache()),
                const SliverToBoxAdapter(child: _WmLatChapterMatrix()),
                const SliverToBoxAdapter(child: _WmLatChapterContrast()),
                const SliverToBoxAdapter(child: _WmLatChapterRecipes()),
                const SliverToBoxAdapter(child: _WmLatChapterEpilogue()),
                const SliverToBoxAdapter(child: SizedBox(height: 64)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// APP BAR TITLE AND BACKDROP
// ===========================================================================
class _WmLatAppBarTitle extends StatelessWidget {
  const _WmLatAppBarTitle();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[_wmLatAqua, _wmLatIndigo],
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: (_wmLatAqua ?? const Color(0xFF000000)).withValues(alpha: 0.5),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: const Text(
            'WM',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 1.3,
            ),
          ),
        ),
        const SizedBox(width: 12),
        const Flexible(
          child: Text(
            'WeakMap — Crystal Lattice Dossier',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ],
    );
  }
}

class _WmLatAppBarBackdrop extends StatelessWidget {
  const _WmLatAppBarBackdrop({required this.phase});

  final Animation<double> phase;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: phase,
      builder: (BuildContext context, Widget? child) {
        return CustomPaint(
          painter: _WmLatAppBarPainter(phase: phase.value),
        );
      },
    );
  }
}

class _WmLatAppBarPainter extends CustomPainter {
  _WmLatAppBarPainter({required this.phase});

  final double phase;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_wmLatInkDeep, _wmLatIndigoDeep, _wmLatInk],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bg);

    final Paint hex = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8
      ..color = (_wmLatAqua ?? const Color(0xFF000000)).withValues(alpha: 0.22);
    const double r = 22;
    final double h = r * math.sqrt(3.0);
    for (double y = -h; y < size.height + h; y += h) {
      final double xShift = ((y ~/ h) % 2 == 0) ? 0.0 : r * 1.5;
      for (double x = -r; x < size.width + r; x += r * 3) {
        _wmLatDrawHexagon(canvas, Offset(x + xShift, y + r), r, hex);
      }
    }

    final Paint pulse = Paint()
      ..style = PaintingStyle.fill
      ..shader = RadialGradient(
        colors: <Color>[
          (_wmLatAqua ?? const Color(0xFF000000)).withValues(alpha: 0.45),
          (_wmLatAqua ?? const Color(0xFF000000)).withValues(alpha: 0.0),
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(
            size.width * (0.3 + 0.4 * math.sin(phase * math.pi * 2)),
            size.height * 0.55,
          ),
          radius: 120,
        ),
      );
    canvas.drawCircle(
      Offset(
        size.width * (0.3 + 0.4 * math.sin(phase * math.pi * 2)),
        size.height * 0.55,
      ),
      120,
      pulse,
    );
  }

  @override
  bool shouldRepaint(covariant _WmLatAppBarPainter oldDelegate) =>
      oldDelegate.phase != phase;
}

void _wmLatDrawHexagon(Canvas canvas, Offset c, double r, Paint paint) {
  final Path p = Path();
  for (int i = 0; i < 6; i++) {
    final double theta = (math.pi / 3) * i + math.pi / 6;
    final Offset v = c + Offset(r * math.cos(theta), r * math.sin(theta));
    if (i == 0) {
      p.moveTo(v.dx, v.dy);
    } else {
      p.lineTo(v.dx, v.dy);
    }
  }
  p.close();
  canvas.drawPath(p, paint);
}

// ===========================================================================
// BACKGROUND LATTICE PAINTER — subtle shimmer over the whole page.
// ===========================================================================
class _WmLatBackgroundPainter extends CustomPainter {
  _WmLatBackgroundPainter({required this.phase});

  final double phase;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _wmLatPaper;
    canvas.drawRect(Offset.zero & size, bg);

    final Paint lattice = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.6
      ..color = (_wmLatIndigo ?? const Color(0xFF000000)).withValues(alpha: 0.08);
    const double r = 30;
    final double h = r * math.sqrt(3.0);
    for (double y = -h; y < size.height + h; y += h) {
      final double xShift = ((y ~/ h) % 2 == 0) ? 0.0 : r * 1.5;
      for (double x = -r; x < size.width + r; x += r * 3) {
        _wmLatDrawHexagon(canvas, Offset(x + xShift, y + r), r, lattice);
      }
    }

    final Paint sweep = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          (_wmLatAqua ?? const Color(0xFF000000)).withValues(alpha: 0.0),
          (_wmLatAqua ?? const Color(0xFF000000)).withValues(alpha: 0.09),
          (_wmLatAqua ?? const Color(0xFF000000)).withValues(alpha: 0.0),
        ],
        stops: <double>[
          (phase - 0.2).clamp(0.0, 1.0),
          phase,
          (phase + 0.2).clamp(0.0, 1.0),
        ],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, sweep);
  }

  @override
  bool shouldRepaint(covariant _WmLatBackgroundPainter oldDelegate) =>
      oldDelegate.phase != phase;
}

// ===========================================================================
// TABLE OF CONTENTS
// ===========================================================================
class _WmLatTableOfContents extends StatelessWidget {
  const _WmLatTableOfContents();

  @override
  Widget build(BuildContext context) {
    const List<_WmLatTocEntry> entries = <_WmLatTocEntry>[
      _WmLatTocEntry('I',   'Preamble',  'what and why',           _wmLatAqua),
      _WmLatTocEntry('II',  'Anatomy',   'API surface of WeakMap', _wmLatIndigo),
      _WmLatTocEntry('III', 'Playground','live particle registry', _wmLatMint),
      _WmLatTocEntry('IV',  'Cache',     'derived-data on objects',_wmLatAmber),
      _WmLatTocEntry('V',   'Matrix',    'WeakMap vs Map vs …',    _wmLatRose),
      _WmLatTocEntry('VI',  'Contrast',  'strong vs weak side-by-side', _wmLatAquaDeep),
      _WmLatTocEntry('VII', 'Recipes',   'snippets you can copy',  _wmLatIndigoDeep),
      _WmLatTocEntry('VIII','Epilogue',  'gotchas and production', _wmLatDanger),
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
      child: _WmLatCard(
        accent: _wmLatIndigo,
        title: 'Dossier contents',
        subtitle: 'scroll the page — each chapter is a unique scene',
        body: Column(
          children: <Widget>[
            for (final _WmLatTocEntry e in entries)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 40,
                      height: 28,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: (e.accent ?? const Color(0xFF000000)).withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: (e.accent ?? const Color(0xFF000000)).withValues(alpha: 0.7),
                        ),
                      ),
                      child: Text(
                        e.numeral,
                        style: TextStyle(
                          color: e.accent,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      e.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: _wmLatInkDeep,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        e.caption,
                        style: const TextStyle(
                          color: _wmLatInkSoft,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _WmLatTocEntry {
  const _WmLatTocEntry(this.numeral, this.title, this.caption, this.accent);
  final String numeral;
  final String title;
  final String caption;
  final Color accent;
}

// ===========================================================================
// SHARED CARD WIDGET
// ===========================================================================
class _WmLatCard extends StatelessWidget {
  const _WmLatCard({
    required this.title,
    required this.body,
    this.subtitle,
    this.accent = _wmLatIndigo,
    this.trailing,
  });

  final String title;
  final String? subtitle;
  final Widget body;
  final Color accent;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _wmLatSilver),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: (_wmLatIndigo ?? const Color(0xFF000000)).withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
            decoration: BoxDecoration(
              color: (accent ?? const Color(0xFF000000)).withValues(alpha: 0.08),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14),
              ),
              border: Border(
                bottom: BorderSide(color: (accent ?? const Color(0xFF000000)).withValues(alpha: 0.35)),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 10,
                  height: 26,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: accent.r + accent.g + accent.b > 2.0
                              ? _wmLatInkDeep
                              : accent,
                        ),
                      ),
                      if (subtitle != null) ...<Widget>[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: _wmLatInkSoft,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                ?trailing,
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: body,
          ),
        ],
      ),
    );
  }
}

class _WmLatChapterHeader extends StatelessWidget {
  const _WmLatChapterHeader({
    required this.numeral,
    required this.title,
    required this.blurb,
    required this.accent,
  });

  final String numeral;
  final String title;
  final String blurb;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 56,
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[accent, (accent ?? const Color(0xFF000000)).withValues(alpha: 0.7)],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              numeral,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.white,
                fontSize: 18,
                letterSpacing: 1.2,
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
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: _wmLatInkDeep,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  blurb,
                  style: const TextStyle(
                    color: _wmLatInkSoft,
                    fontSize: 13,
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

class _WmLatPill extends StatelessWidget {
  const _WmLatPill({
    required this.label,
    required this.color,
    this.icon,
  });

  final String label;
  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: (color ?? const Color(0xFF000000)).withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: (color ?? const Color(0xFF000000)).withValues(alpha: 0.55)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 13, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 11,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _WmLatCodeBlock extends StatelessWidget {
  const _WmLatCodeBlock({required this.code, this.caption});

  final String code;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _wmLatInkDeep,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _wmLatIndigoDeep),
          ),
          child: Text(
            code,
            style: const TextStyle(
              color: _wmLatAquaPale,
              fontFamily: 'monospace',
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ),
        if (caption != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              caption!,
              style: const TextStyle(
                color: _wmLatInkSoft,
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }
}

class _WmLatDivider extends StatelessWidget {
  const _WmLatDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 1,
      color: (_wmLatSilver ?? const Color(0xFF000000)).withValues(alpha: 0.7),
    );
  }
}

// ===========================================================================
// CHAPTER I — PREAMBLE
// ===========================================================================
class _WmLatChapterPreamble extends StatelessWidget {
  const _WmLatChapterPreamble();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _WmLatChapterHeader(
          numeral: 'I',
          title: 'What WeakMap is',
          blurb:
              'A map whose keys do not prevent garbage collection — a crystal lattice that dissolves when no one is looking.',
          accent: _wmLatAqua,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _WmLatCard(
            accent: _wmLatAqua,
            title: 'The one-line definition',
            subtitle: 'package:flutter/foundation.dart — WeakMap<K, V>',
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'WeakMap stores key/value pairs, but holds its keys weakly. '
                  'When the rest of your program drops all references to a key, '
                  'the WeakMap entry becomes eligible for garbage collection. '
                  'That property makes it safe to attach ephemeral metadata to '
                  'user-owned objects without creating memory leaks.',
                  style: TextStyle(color: _wmLatInk, fontSize: 13.5, height: 1.5),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const <Widget>[
                    _WmLatPill(label: 'weak keys', color: _wmLatAqua),
                    _WmLatPill(label: 'strong values', color: _wmLatIndigo),
                    _WmLatPill(label: 'no iteration', color: _wmLatRose),
                    _WmLatPill(label: 'Expando-backed (VM)', color: _wmLatMint),
                    _WmLatPill(label: 'JS-backed (web)', color: _wmLatAmber),
                  ],
                ),
                const _WmLatDivider(),
                const _WmLatCodeBlock(
                  code: '// From package:flutter/foundation.dart\n'
                      'final WeakMap<Object, int> notes = WeakMap<Object, int>();\n'
                      'final Object key = Object();\n'
                      'notes[key] = 42;                 // set\n'
                      'final int? v = notes[key];       // get — 42\n'
                      'notes.remove(key);               // drop entry',
                  caption:
                      'Operator [] and []= mirror Map — there is no iteration, no keys getter.',
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _WmLatCard(
            accent: _wmLatIndigo,
            title: 'Why Flutter ships one',
            subtitle: 'internal caches that follow the lifetime of user objects',
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                _WmLatBullet(
                  color: _wmLatIndigo,
                  title: 'Derived data without leaks',
                  body:
                      'The framework sometimes needs to remember a derived value for an object you created. If it stored the mapping in a regular Map, Flutter would hold that object alive forever.',
                ),
                _WmLatBullet(
                  color: _wmLatAqua,
                  title: 'Platform parity',
                  body:
                      'On the VM, WeakMap delegates to dart:core Expando. On the web, it wraps the native JavaScript WeakMap. The Flutter-level API is identical.',
                ),
                _WmLatBullet(
                  color: _wmLatMint,
                  title: 'No iteration by design',
                  body:
                      'You can only ask "what is the value for this key" — you cannot enumerate, because entries may disappear asynchronously.',
                ),
                _WmLatBullet(
                  color: _wmLatAmber,
                  title: 'Keys must be objects',
                  body:
                      'Primitives like numbers and strings are canonicalised by the runtime — weak semantics would be meaningless, so WeakMap rejects them implicitly.',
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _WmLatCard(
            accent: _wmLatMint,
            title: 'Analogy — the crystal lattice',
            subtitle: 'a visualisation you can keep in your head',
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'Imagine a three-dimensional lattice of silver atoms (the keys) '
                  'with indigo labels (the values) suspended between them. The '
                  'lattice stays rigid only as long as at least one outside hand '
                  'holds each silver atom in place. When an atom is released, the '
                  'labels attached to that atom fall silently out of the lattice.',
                  style: TextStyle(color: _wmLatInk, height: 1.5, fontSize: 13.5),
                ),
                const SizedBox(height: 12),
                _WmLatLatticeIllustration(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _WmLatBullet extends StatelessWidget {
  const _WmLatBullet({
    required this.color,
    required this.title,
    required this.body,
  });

  final Color color;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(top: 6, right: 10),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: _wmLatInkDeep,
                    fontSize: 13.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  body,
                  style: const TextStyle(
                    color: _wmLatInkSoft,
                    fontSize: 12.5,
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

class _WmLatLatticeIllustration extends StatelessWidget {
  const _WmLatLatticeIllustration();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: CustomPaint(
        painter: _WmLatLatticeDiagramPainter(),
        size: const Size.fromHeight(180),
      ),
    );
  }
}

class _WmLatLatticeDiagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint frame = Paint()
      ..color = _wmLatSilverSoft
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10)),
      frame,
    );

    final Paint edge = Paint()
      ..color = (_wmLatIndigo ?? const Color(0xFF000000)).withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    final List<Offset> nodes = <Offset>[];
    for (int row = 0; row < 4; row++) {
      for (int col = 0; col < 7; col++) {
        final double x = 40.0 + col * (size.width - 80) / 6;
        final double y = 20.0 + row * 45.0 + (col.isOdd ? 10.0 : 0.0);
        nodes.add(Offset(x, y));
      }
    }
    for (int i = 0; i < nodes.length; i++) {
      for (int j = i + 1; j < nodes.length; j++) {
        final double d = (nodes[i] - nodes[j]).distance;
        if (d < 60) canvas.drawLine(nodes[i], nodes[j], edge);
      }
    }
    final Paint nodePaint = Paint()..color = _wmLatAqua;
    final Paint nodeBorder = Paint()
      ..style = PaintingStyle.stroke
      ..color = _wmLatAquaDeep
      ..strokeWidth = 1.5;
    for (final Offset n in nodes) {
      canvas.drawCircle(n, 5, nodePaint);
      canvas.drawCircle(n, 5, nodeBorder);
    }
  }

  @override
  bool shouldRepaint(covariant _WmLatLatticeDiagramPainter oldDelegate) =>
      false;
}

// ===========================================================================
// CHAPTER II — ANATOMY
// ===========================================================================
class _WmLatChapterAnatomy extends StatelessWidget {
  const _WmLatChapterAnatomy();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _WmLatChapterHeader(
          numeral: 'II',
          title: 'Anatomy of the API',
          blurb:
              'Three operators, one removal. That is the entire surface — smaller than Map on purpose.',
          accent: _wmLatIndigo,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _WmLatCard(
            accent: _wmLatIndigo,
            title: 'Operators and methods',
            subtitle: 'a minimal surface reduces room for mistakes',
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const <Widget>[
                _WmLatApiRow(
                  symbol: 'operator [](K key)',
                  color: _wmLatAqua,
                  ret: 'V?',
                  detail:
                      'Returns the value for key or null if the key is absent or has been collected.',
                ),
                _WmLatApiRow(
                  symbol: 'operator []=(K k, V v)',
                  color: _wmLatIndigo,
                  ret: 'void',
                  detail:
                      'Associates k with v. Holds v strongly and k weakly. Replaces any previous value.',
                ),
                _WmLatApiRow(
                  symbol: 'remove(K key)',
                  color: _wmLatMint,
                  ret: 'V?',
                  detail:
                      'Drops the entry, returning the previous value if present.',
                ),
                _WmLatApiRow(
                  symbol: 'clear()',
                  color: _wmLatAmber,
                  ret: 'void',
                  detail:
                      'Discards all entries at once. Useful in tests and on hot-reload boundaries.',
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _WmLatCard(
            accent: _wmLatAqua,
            title: 'Construction',
            subtitle: 'zero-argument, no growth policy, no bucket size',
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const <Widget>[
                _WmLatCodeBlock(
                  code: 'final WeakMap<Widget, int> stamps =\n'
                      '    WeakMap<Widget, int>();\n\n'
                      '// Type parameters default to <dynamic, dynamic>.\n'
                      'final WeakMap<Object, String> plain = WeakMap();',
                  caption: 'Parameterise K to your actual key type for safety.',
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _WmLatCard(
            accent: _wmLatMint,
            title: 'Lifetime diagram',
            subtitle: 'what a successful lookup looks like, step by step',
            body: _WmLatLifetimeDiagram(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _WmLatCard(
            accent: _wmLatAmber,
            title: 'Platform implementations',
            subtitle: '_capabilities_io.dart vs _capabilities_web.dart',
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(child: _WmLatPlatformCard(
                      title: 'Dart VM',
                      accent: _wmLatAqua,
                      lines: const <String>[
                        'Wraps dart:core Expando<Object>.',
                        'Uses native weak references provided by the VM.',
                        'Reliable weak semantics, GC timing is VM-specific.',
                        'No JS-interop indirection.',
                      ],
                    )),
                    const SizedBox(width: 12),
                    Expanded(child: _WmLatPlatformCard(
                      title: 'Web (JS)',
                      accent: _wmLatIndigo,
                      lines: const <String>[
                        'Wraps the global JavaScript WeakMap.',
                        'Keys must be non-primitive JS values.',
                        'GC follows the browser engine — opaque.',
                        'FinalizationRegistry is available but separate.',
                      ],
                    )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _WmLatApiRow extends StatelessWidget {
  const _WmLatApiRow({
    required this.symbol,
    required this.ret,
    required this.detail,
    required this.color,
  });
  final String symbol;
  final String ret;
  final String detail;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: (color ?? const Color(0xFF000000)).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: (color ?? const Color(0xFF000000)).withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  ret,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  symbol,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w800,
                    color: _wmLatInkDeep,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            detail,
            style: const TextStyle(color: _wmLatInkSoft, fontSize: 12.5),
          ),
        ],
      ),
    );
  }
}

class _WmLatPlatformCard extends StatelessWidget {
  const _WmLatPlatformCard({
    required this.title,
    required this.accent,
    required this.lines,
  });
  final String title;
  final Color accent;
  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (accent ?? const Color(0xFF000000)).withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: (accent ?? const Color(0xFF000000)).withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.w800,
              fontSize: 14,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          for (final String l in lines)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('• ',
                      style: TextStyle(
                        color: _wmLatInkSoft,
                        fontWeight: FontWeight.w900,
                      )),
                  Expanded(
                    child: Text(
                      l,
                      style: const TextStyle(
                        color: _wmLatInk,
                        fontSize: 12.5,
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

class _WmLatLifetimeDiagram extends StatelessWidget {
  const _WmLatLifetimeDiagram();

  @override
  Widget build(BuildContext context) {
    const List<_WmLatLifetimeStep> steps = <_WmLatLifetimeStep>[
      _WmLatLifetimeStep(
        phase: 'create',
        title: 'Object is created',
        body: 'Your code allocates an object — the runtime stores a strong '
            'reference from your variable.',
        color: _wmLatAqua,
      ),
      _WmLatLifetimeStep(
        phase: 'attach',
        title: 'WeakMap entry attached',
        body: 'You call map[object] = meta. The WeakMap holds object weakly, '
            'meta strongly.',
        color: _wmLatIndigo,
      ),
      _WmLatLifetimeStep(
        phase: 'use',
        title: 'Lookups succeed',
        body: 'Reads via map[object] return meta as long as at least one '
            'strong reference to object exists somewhere else.',
        color: _wmLatMint,
      ),
      _WmLatLifetimeStep(
        phase: 'release',
        title: 'External strong references drop',
        body: 'Your code clears its variables. The WeakMap entry becomes '
            'eligible for collection — but not necessarily collected yet.',
        color: _wmLatAmber,
      ),
      _WmLatLifetimeStep(
        phase: 'collect',
        title: 'GC reclaims the key',
        body: 'At a later time, the GC reclaims object. Any subsequent '
            'map[object] would return null — but there is no "object" left to ask.',
        color: _wmLatRose,
      ),
    ];
    return Column(
      children: <Widget>[
        for (int i = 0; i < steps.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: steps[i].color,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: (steps[i].color ?? const Color(0xFF000000)).withValues(alpha: 0.35),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${i + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    if (i < steps.length - 1)
                      Container(
                        width: 2,
                        height: 36,
                        color: (steps[i].color ?? const Color(0xFF000000)).withValues(alpha: 0.4),
                      ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 4),
                    decoration: BoxDecoration(
                      color: (steps[i].color ?? const Color(0xFF000000)).withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: (steps[i].color ?? const Color(0xFF000000)).withValues(alpha: 0.35),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              steps[i].title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: _wmLatInkDeep,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: steps[i].color,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                steps[i].phase,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.6,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          steps[i].body,
                          style: const TextStyle(
                            color: _wmLatInkSoft,
                            fontSize: 12.5,
                            height: 1.4,
                          ),
                        ),
                      ],
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

class _WmLatLifetimeStep {
  const _WmLatLifetimeStep({
    required this.phase,
    required this.title,
    required this.body,
    required this.color,
  });
  final String phase;
  final String title;
  final String body;
  final Color color;
}

// ===========================================================================
// CHAPTER III — LIVE PLAYGROUND
// ===========================================================================
class _WmLatParticleData {
  _WmLatParticleData({
    required this.label,
    required this.glyph,
    required this.hue,
    required this.energy,
    required this.spin,
    required this.createdTick,
  });

  final String label;
  final String glyph;
  final Color hue;
  int energy;
  int spin;
  final int createdTick;
  int readCount = 0;
  int writeCount = 0;
}

class _WmLatChapterPlayground extends StatefulWidget {
  const _WmLatChapterPlayground();

  @override
  State<_WmLatChapterPlayground> createState() =>
      _WmLatChapterPlaygroundState();
}

class _WmLatChapterPlaygroundState extends State<_WmLatChapterPlayground> {
  final WeakMap<Object, _WmLatParticleData> _registry =
      WeakMap<Object, _WmLatParticleData>();

  final List<Object> _strongKeys = <Object>[];
  final List<Object> _droppedKeys = <Object>[];
  final List<String> _log = <String>[];
  int _tick = 0;
  int _seed = 1;
  int _selected = 0;

  static const List<String> _glyphs = <String>[
    'Alpha', 'Beta', 'Gamma', 'Delta', 'Epsilon', 'Zeta', 'Eta', 'Theta',
    'Iota', 'Kappa', 'Lambda', 'Mu', 'Nu', 'Xi', 'Omicron', 'Pi',
  ];
  static const List<Color> _huePool = <Color>[
    _wmLatAqua,
    _wmLatIndigo,
    _wmLatMint,
    _wmLatAmber,
    _wmLatRose,
    _wmLatAquaDeep,
    _wmLatIndigoDeep,
  ];

  @override
  void initState() {
    super.initState();
    _addParticle();
    _addParticle();
    _addParticle();
    _log.clear();
    _log.add('tick 0 — lattice initialised with three particles');
  }

  void _addParticle() {
    setState(() {
      _tick += 1;
      final Object key = Object();
      _strongKeys.add(key);
      final _WmLatParticleData data = _WmLatParticleData(
        label: 'P-${_strongKeys.length.toString().padLeft(2, '0')}',
        glyph: _glyphs[(_seed * 7) % _glyphs.length],
        hue: _huePool[(_seed * 3) % _huePool.length],
        energy: 40 + (_seed * 13) % 60,
        spin: (_seed * 5) % 8,
        createdTick: _tick,
      );
      _registry[key] = data;
      _seed += 1;
      _log.insert(
        0,
        'tick $_tick — attached ${data.label} (${data.glyph}) energy=${data.energy}',
      );
      if (_log.length > 10) _log.removeLast();
      _selected = _strongKeys.length - 1;
    });
  }

  void _touch(int index) {
    if (index < 0 || index >= _strongKeys.length) return;
    setState(() {
      _tick += 1;
      final Object key = _strongKeys[index];
      final _WmLatParticleData? data = _registry[key];
      if (data != null) {
        data.readCount += 1;
        _log.insert(
          0,
          'tick $_tick — read ${data.label} readCount=${data.readCount}',
        );
        if (_log.length > 10) _log.removeLast();
      }
    });
  }

  void _mutate(int index, int delta) {
    if (index < 0 || index >= _strongKeys.length) return;
    setState(() {
      _tick += 1;
      final Object key = _strongKeys[index];
      final _WmLatParticleData? data = _registry[key];
      if (data != null) {
        data.energy = (data.energy + delta).clamp(0, 200);
        data.writeCount += 1;
        _log.insert(
          0,
          'tick $_tick — mutated ${data.label} energy=${data.energy}',
        );
        if (_log.length > 10) _log.removeLast();
      }
    });
  }

  void _spin(int index) {
    if (index < 0 || index >= _strongKeys.length) return;
    setState(() {
      _tick += 1;
      final Object key = _strongKeys[index];
      final _WmLatParticleData? data = _registry[key];
      if (data != null) {
        data.spin = (data.spin + 1) % 8;
        data.writeCount += 1;
        _log.insert(
          0,
          'tick $_tick — spun ${data.label} spin=${data.spin}',
        );
        if (_log.length > 10) _log.removeLast();
      }
    });
  }

  void _detach(int index) {
    if (index < 0 || index >= _strongKeys.length) return;
    setState(() {
      _tick += 1;
      final Object key = _strongKeys[index];
      final _WmLatParticleData? removed = _registry.remove(key);
      _log.insert(
        0,
        'tick $_tick — detached ${removed?.label ?? "?"} via remove()',
      );
      if (_log.length > 10) _log.removeLast();
      _strongKeys.removeAt(index);
      if (_selected >= _strongKeys.length) {
        _selected = _strongKeys.length - 1;
      }
    });
  }

  void _dropStrongHalf() {
    setState(() {
      _tick += 1;
      final int half = _strongKeys.length ~/ 2;
      if (half == 0) {
        _log.insert(
          0,
          'tick $_tick — nothing to drop (need at least two particles)',
        );
        return;
      }
      final List<Object> dropped = _strongKeys.sublist(0, half);
      _droppedKeys.addAll(dropped);
      _strongKeys.removeRange(0, half);
      if (_selected >= _strongKeys.length) {
        _selected = _strongKeys.length - 1;
      }
      _log.insert(
        0,
        'tick $_tick — released strong refs on $half particle(s). GC may collect when it wants.',
      );
      if (_log.length > 10) _log.removeLast();
    });
  }

  void _reset() {
    setState(() {
      _tick += 1;
      _registry.clear();
      _strongKeys.clear();
      _droppedKeys.clear();
      _log
        ..clear()
        ..add('tick $_tick — registry cleared via WeakMap.clear()');
      _selected = 0;
      _seed = 1;
      _addParticle();
      _addParticle();
      _addParticle();
    });
  }

  int _droppedStillPresentCount() {
    int n = 0;
    for (final Object k in _droppedKeys) {
      if (_registry[k] != null) n += 1;
    }
    return n;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _WmLatChapterHeader(
          numeral: 'III',
          title: 'Live particle playground',
          blurb:
              'Each particle is a real Object; the registry is a real WeakMap. Mutate, detach, or release strong refs.',
          accent: _wmLatMint,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _WmLatCard(
            accent: _wmLatMint,
            title: 'Registry state',
            subtitle:
                'tick $_tick  ·  live particles ${_strongKeys.length}  ·  released ${_droppedKeys.length}',
            trailing: _WmLatPill(
              label: 'weak-held',
              color: _wmLatMint,
              icon: Icons.bolt,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildToolbar(),
                const _WmLatDivider(),
                _buildParticleGrid(),
                const _WmLatDivider(),
                _buildDetailPanel(),
                const _WmLatDivider(),
                _buildReleasedPanel(),
                const _WmLatDivider(),
                _buildLogPanel(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildToolbar() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: <Widget>[
        _WmLatToolbarButton(
          label: 'Add particle',
          icon: Icons.add_circle_outline,
          color: _wmLatMint,
          onTap: _addParticle,
        ),
        _WmLatToolbarButton(
          label: 'Touch selected',
          icon: Icons.touch_app,
          color: _wmLatAqua,
          onTap: () => _touch(_selected),
        ),
        _WmLatToolbarButton(
          label: 'Energy +10',
          icon: Icons.flash_on,
          color: _wmLatIndigo,
          onTap: () => _mutate(_selected, 10),
        ),
        _WmLatToolbarButton(
          label: 'Energy −10',
          icon: Icons.flash_off,
          color: _wmLatAmber,
          onTap: () => _mutate(_selected, -10),
        ),
        _WmLatToolbarButton(
          label: 'Spin ++',
          icon: Icons.rotate_right,
          color: _wmLatAquaDeep,
          onTap: () => _spin(_selected),
        ),
        _WmLatToolbarButton(
          label: 'remove(selected)',
          icon: Icons.close,
          color: _wmLatRose,
          onTap: () => _detach(_selected),
        ),
        _WmLatToolbarButton(
          label: 'Drop strong refs (½)',
          icon: Icons.link_off,
          color: _wmLatDanger,
          onTap: _dropStrongHalf,
        ),
        _WmLatToolbarButton(
          label: 'clear()',
          icon: Icons.refresh,
          color: _wmLatInkSoft,
          onTap: _reset,
        ),
      ],
    );
  }

  Widget _buildParticleGrid() {
    if (_strongKeys.isEmpty) {
      return const _WmLatEmptyPanel(
        message: 'The lattice is empty — press "Add particle".',
      );
    }
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: <Widget>[
        for (int i = 0; i < _strongKeys.length; i++)
          _WmLatParticleTile(
            key: ValueKey<int>(i),
            index: i,
            selected: i == _selected,
            data: _registry[_strongKeys[i]],
            onTap: () => setState(() => _selected = i),
          ),
      ],
    );
  }

  Widget _buildDetailPanel() {
    if (_strongKeys.isEmpty) {
      return const _WmLatEmptyPanel(
        message: 'No particle selected — nothing to describe.',
      );
    }
    final _WmLatParticleData? d = _registry[_strongKeys[_selected]];
    if (d == null) {
      return const _WmLatEmptyPanel(
        message: 'Metadata missing — entry collected or removed.',
      );
    }
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (d.hue ?? const Color(0xFF000000)).withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: (d.hue ?? const Color(0xFF000000)).withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 72,
            height: 72,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: d.hue,
              borderRadius: BorderRadius.circular(12),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: (d.hue ?? const Color(0xFF000000)).withValues(alpha: 0.45),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              d.label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 14,
                letterSpacing: 0.8,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Glyph: ${d.glyph}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: _wmLatInkDeep,
                  ),
                ),
                const SizedBox(height: 4),
                Text('Energy: ${d.energy}',
                    style: const TextStyle(color: _wmLatInk, fontSize: 13)),
                Text('Spin: ${d.spin}',
                    style: const TextStyle(color: _wmLatInk, fontSize: 13)),
                Text('Created at tick: ${d.createdTick}',
                    style: const TextStyle(color: _wmLatInkSoft, fontSize: 12)),
                Text(
                  'Reads: ${d.readCount}  ·  Writes: ${d.writeCount}',
                  style: const TextStyle(color: _wmLatInkSoft, fontSize: 12),
                ),
                const SizedBox(height: 6),
                Row(
                  children: <Widget>[
                    const _WmLatPill(
                      label: 'held weakly',
                      color: _wmLatMint,
                    ),
                    const SizedBox(width: 6),
                    _WmLatPill(
                      label: 'value held strongly',
                      color: d.hue,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReleasedPanel() {
    if (_droppedKeys.isEmpty) {
      return const _WmLatEmptyPanel(
        message: 'No released keys yet. Press "Drop strong refs" to try it.',
      );
    }
    final int still = _droppedStillPresentCount();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: (_wmLatDangerPale ?? const Color(0xFF000000)).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: (_wmLatDanger ?? const Color(0xFF000000)).withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.warning_amber, color: _wmLatDanger, size: 18),
              const SizedBox(width: 6),
              const Expanded(
                child: Text(
                  'Strong-ref ledger',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: _wmLatInkDeep,
                  ),
                ),
              ),
              _WmLatPill(
                label: '$still / ${_droppedKeys.length} still visible',
                color: _wmLatDanger,
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'The playground dropped its own strong references to these keys. '
            'In real Dart, the GC may or may not have collected them yet — this '
            'demo does NOT attempt to force a collection. The ledger above tells '
            'you whether the WeakMap still reports a value for each key this tick.',
            style: TextStyle(color: _wmLatInk, fontSize: 12.5, height: 1.4),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              for (int i = 0; i < _droppedKeys.length; i++)
                _WmLatReleasedKeyTile(
                  key: ValueKey<int>(i),
                  index: i,
                  alive: _registry[_droppedKeys[i]] != null,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLogPanel() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _wmLatInkDeep,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Event log',
            style: TextStyle(
              color: _wmLatAquaPale,
              fontWeight: FontWeight.w800,
              fontSize: 12,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 6),
          for (final String l in _log)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                l,
                style: const TextStyle(
                  color: _wmLatSilverSoft,
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  height: 1.4,
                ),
              ),
            ),
          if (_log.isEmpty)
            const Text(
              '(no events yet)',
              style: TextStyle(
                color: _wmLatSilver,
                fontFamily: 'monospace',
                fontSize: 11.5,
              ),
            ),
        ],
      ),
    );
  }
}

class _WmLatToolbarButton extends StatelessWidget {
  const _WmLatToolbarButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: (color ?? const Color(0xFF000000)).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: (color ?? const Color(0xFF000000)).withValues(alpha: 0.5)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, color: color, size: 15),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WmLatParticleTile extends StatelessWidget {
  const _WmLatParticleTile({
    super.key,
    required this.index,
    required this.selected,
    required this.data,
    required this.onTap,
  });

  final int index;
  final bool selected;
  final _WmLatParticleData? data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color accent = data?.hue ?? _wmLatSilver;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 120,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: selected
                ? (accent ?? const Color(0xFF000000)).withValues(alpha: 0.15)
                : (_wmLatSilverSoft ?? const Color(0xFF000000)).withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selected ? accent : _wmLatSilver,
              width: selected ? 2 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: accent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    data?.label ?? 'P-??',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: _wmLatInkDeep,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                data?.glyph ?? '—',
                style: const TextStyle(
                  color: _wmLatInk,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'E ${data?.energy ?? 0}',
                style: const TextStyle(color: _wmLatInkSoft, fontSize: 11),
              ),
              Text(
                'spin ${data?.spin ?? 0}',
                style: const TextStyle(color: _wmLatInkSoft, fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WmLatReleasedKeyTile extends StatelessWidget {
  const _WmLatReleasedKeyTile({
    super.key,
    required this.index,
    required this.alive,
  });

  final int index;
  final bool alive;

  @override
  Widget build(BuildContext context) {
    final Color color = alive ? _wmLatAmber : _wmLatInkSoft;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: (color ?? const Color(0xFF000000)).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: (color ?? const Color(0xFF000000)).withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(alive ? Icons.visibility : Icons.visibility_off,
              size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            'key#$index ${alive ? "reachable" : "collected?"}',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 11.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _WmLatEmptyPanel extends StatelessWidget {
  const _WmLatEmptyPanel({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (_wmLatSilverSoft ?? const Color(0xFF000000)).withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _wmLatSilver),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.info_outline, color: _wmLatInkSoft, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: _wmLatInkSoft),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// CHAPTER IV — METADATA CACHE
// ===========================================================================
class _WmLatCacheEntry {
  _WmLatCacheEntry({
    required this.digest,
    required this.bytes,
    required this.costMs,
    required this.builtAtTick,
  });

  final String digest;
  final int bytes;
  final int costMs;
  final int builtAtTick;
}

class _WmLatChapterCache extends StatefulWidget {
  const _WmLatChapterCache();

  @override
  State<_WmLatChapterCache> createState() => _WmLatChapterCacheState();
}

class _WmLatChapterCacheState extends State<_WmLatChapterCache> {
  final WeakMap<Object, _WmLatCacheEntry> _cache =
      WeakMap<Object, _WmLatCacheEntry>();
  final List<Object> _documents = <Object>[];
  final List<String> _titles = <String>[];
  final List<int> _versions = <int>[];
  int _tick = 0;
  int _seed = 3;
  int _hits = 0;
  int _misses = 0;

  @override
  void initState() {
    super.initState();
    _addDocument('Pyrite spec');
    _addDocument('Calcite plan');
    _addDocument('Feldspar memo');
  }

  void _addDocument(String title) {
    setState(() {
      _tick += 1;
      final Object doc = Object();
      _documents.add(doc);
      _titles.add(title);
      _versions.add(1);
      _seed += 1;
    });
  }

  _WmLatCacheEntry _derive(int index) {
    final int v = _versions[index];
    final int digest = (_titles[index].length * 31 + v * 17 + _seed) % 9999;
    return _WmLatCacheEntry(
      digest: digest.toRadixString(16).toUpperCase().padLeft(4, '0'),
      bytes: 128 + v * 64 + digest % 128,
      costMs: 18 + v * 3 + digest % 5,
      builtAtTick: _tick,
    );
  }

  void _access(int index) {
    setState(() {
      _tick += 1;
      final Object doc = _documents[index];
      _WmLatCacheEntry? entry = _cache[doc];
      if (entry == null) {
        entry = _derive(index);
        _cache[doc] = entry;
        _misses += 1;
      } else {
        _hits += 1;
      }
    });
  }

  void _invalidate(int index) {
    setState(() {
      _tick += 1;
      final Object doc = _documents[index];
      _cache.remove(doc);
    });
  }

  void _edit(int index) {
    setState(() {
      _tick += 1;
      _versions[index] += 1;
      _cache.remove(_documents[index]);
    });
  }

  void _dropDocument(int index) {
    setState(() {
      _tick += 1;
      _documents.removeAt(index);
      _titles.removeAt(index);
      _versions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _WmLatChapterHeader(
          numeral: 'IV',
          title: 'Expensive-derived-data cache',
          blurb:
              'A classic production use — keep the precomputed digest beside the document object without keeping the document alive.',
          accent: _wmLatAmber,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _WmLatCard(
            accent: _wmLatAmber,
            title: 'Cache ledger',
            subtitle:
                'hits $_hits  ·  misses $_misses  ·  tick $_tick  ·  live docs ${_documents.length}',
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'Each card represents a document object. The derived digest '
                  'and bytes are stored in a WeakMap keyed on that object. If '
                  'you drop the document, the cache entry becomes unreachable.',
                  style: TextStyle(color: _wmLatInk, height: 1.4, fontSize: 13),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: <Widget>[
                    for (int i = 0; i < _documents.length; i++)
                      _buildDocCard(i),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: <Widget>[
                    _WmLatToolbarButton(
                      label: 'Add doc',
                      icon: Icons.note_add,
                      color: _wmLatAmber,
                      onTap: () => _addDocument('Doc ${_documents.length + 1}'),
                    ),
                    const SizedBox(width: 8),
                    _WmLatToolbarButton(
                      label: 'Clear cache',
                      icon: Icons.cleaning_services,
                      color: _wmLatInkSoft,
                      onTap: () => setState(() {
                        _cache.clear();
                        _tick += 1;
                      }),
                    ),
                  ],
                ),
                const _WmLatDivider(),
                _buildCacheExplainer(),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _WmLatCard(
            accent: _wmLatIndigo,
            title: 'Why this is the textbook use',
            subtitle:
                'derived data that is cheap to rebuild but wasteful to recompute',
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                _WmLatBullet(
                  color: _wmLatAmber,
                  title: 'Lifetime follows the key',
                  body:
                      'The cached entry lives exactly as long as the object it describes — no TTL gymnastics needed.',
                ),
                _WmLatBullet(
                  color: _wmLatAqua,
                  title: 'No leak from long-lived modules',
                  body:
                      'A cache stored in a global Map keeps every key it ever saw alive. A WeakMap doesn\'t.',
                ),
                _WmLatBullet(
                  color: _wmLatMint,
                  title: 'Safe with third-party objects',
                  body:
                      'You can cache against objects from libraries that never gave you a disposal hook.',
                ),
                _WmLatBullet(
                  color: _wmLatRose,
                  title: 'Pair with Finalizer for hooks',
                  body:
                      'If you need to run cleanup when an entry disappears, dart:core Finalizer is the right companion — but its callbacks are not deterministic either.',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDocCard(int i) {
    final _WmLatCacheEntry? entry = _cache[_documents[i]];
    final bool hot = entry != null;
    return Container(
      width: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: hot
            ? (_wmLatAmberPale ?? const Color(0xFF000000)).withValues(alpha: 0.5)
            : (_wmLatSilverSoft ?? const Color(0xFF000000)).withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: hot ? _wmLatAmber : _wmLatSilver),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                hot ? Icons.local_fire_department : Icons.ac_unit,
                color: hot ? _wmLatAmber : _wmLatInkSoft,
                size: 14,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  _titles[i],
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: _wmLatInkDeep,
                  ),
                ),
              ),
              Text(
                'v${_versions[i]}',
                style: const TextStyle(
                  color: _wmLatInkSoft,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          if (entry != null) ...<Widget>[
            Text('digest ${entry.digest}',
                style: const TextStyle(
                    color: _wmLatInk, fontSize: 12, fontWeight: FontWeight.w700)),
            Text('bytes ${entry.bytes}',
                style: const TextStyle(color: _wmLatInk, fontSize: 11.5)),
            Text('cost ${entry.costMs} ms',
                style: const TextStyle(color: _wmLatInk, fontSize: 11.5)),
            Text('built @ t=${entry.builtAtTick}',
                style: const TextStyle(color: _wmLatInkSoft, fontSize: 11)),
          ] else ...<Widget>[
            const Text(
              'cold — next access will recompute',
              style: TextStyle(
                color: _wmLatInkSoft,
                fontStyle: FontStyle.italic,
                fontSize: 11.5,
              ),
            ),
          ],
          const SizedBox(height: 8),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: <Widget>[
              _WmLatTinyBtn(
                label: 'access',
                color: _wmLatMint,
                onTap: () => _access(i),
              ),
              _WmLatTinyBtn(
                label: 'edit',
                color: _wmLatAqua,
                onTap: () => _edit(i),
              ),
              _WmLatTinyBtn(
                label: 'invalidate',
                color: _wmLatRose,
                onTap: () => _invalidate(i),
              ),
              _WmLatTinyBtn(
                label: 'drop',
                color: _wmLatDanger,
                onTap: () => _dropDocument(i),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCacheExplainer() {
    final double ratio = (_hits + _misses) == 0
        ? 0.0
        : _hits / (_hits + _misses);
    return Row(
      children: <Widget>[
        Container(
          width: 84,
          height: 84,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: (_wmLatIndigo ?? const Color(0xFF000000)).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: (_wmLatIndigo ?? const Color(0xFF000000)).withValues(alpha: 0.5)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '${(ratio * 100).toStringAsFixed(0)}%',
                style: const TextStyle(
                  color: _wmLatIndigoDeep,
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                ),
              ),
              const Text(
                'hit ratio',
                style: TextStyle(
                  color: _wmLatInkSoft,
                  fontSize: 10,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Hits come from accessing a document whose cache entry is still '
            'present. Misses happen when the entry was never built or was '
            'invalidated. Notice how editing bumps a document version AND '
            'evicts the entry — a cache-aware pattern you would normally hand-'
            'code next to a regular Map, but that comes almost for free when '
            'the key is held weakly.',
            style: const TextStyle(
              color: _wmLatInk,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }
}

class _WmLatTinyBtn extends StatelessWidget {
  const _WmLatTinyBtn({
    required this.label,
    required this.color,
    required this.onTap,
  });
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: (color ?? const Color(0xFF000000)).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: (color ?? const Color(0xFF000000)).withValues(alpha: 0.55)),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}

// ===========================================================================
// CHAPTER V — COMPARISON MATRIX
// ===========================================================================
class _WmLatMatrixCell {
  const _WmLatMatrixCell(this.text, this.tone);
  final String text;
  final _WmLatTone tone;
}

enum _WmLatTone { ok, warn, no, info }

class _WmLatMatrixRow {
  const _WmLatMatrixRow(this.feature, this.cells);
  final String feature;
  final List<_WmLatMatrixCell> cells;
}

class _WmLatChapterMatrix extends StatelessWidget {
  const _WmLatChapterMatrix();

  static const List<String> _columns = <String>[
    'WeakMap',
    'Map',
    'Expando',
    'LinkedHashMap',
  ];

  static const List<_WmLatMatrixRow> _rows = <_WmLatMatrixRow>[
    _WmLatMatrixRow(
      'Holds keys strongly',
      <_WmLatMatrixCell>[
        _WmLatMatrixCell('no — weak', _WmLatTone.ok),
        _WmLatMatrixCell('yes', _WmLatTone.warn),
        _WmLatMatrixCell('no — weak', _WmLatTone.ok),
        _WmLatMatrixCell('yes', _WmLatTone.warn),
      ],
    ),
    _WmLatMatrixRow(
      'Iterable keys / values',
      <_WmLatMatrixCell>[
        _WmLatMatrixCell('no', _WmLatTone.no),
        _WmLatMatrixCell('yes', _WmLatTone.ok),
        _WmLatMatrixCell('no', _WmLatTone.no),
        _WmLatMatrixCell('yes, ordered', _WmLatTone.ok),
      ],
    ),
    _WmLatMatrixRow(
      'Keys can be primitives',
      <_WmLatMatrixCell>[
        _WmLatMatrixCell('no (objects only)', _WmLatTone.no),
        _WmLatMatrixCell('yes', _WmLatTone.ok),
        _WmLatMatrixCell('no (objects only)', _WmLatTone.no),
        _WmLatMatrixCell('yes', _WmLatTone.ok),
      ],
    ),
    _WmLatMatrixRow(
      'Constant-time lookup',
      <_WmLatMatrixCell>[
        _WmLatMatrixCell('yes (amortised)', _WmLatTone.ok),
        _WmLatMatrixCell('yes (amortised)', _WmLatTone.ok),
        _WmLatMatrixCell('yes (amortised)', _WmLatTone.ok),
        _WmLatMatrixCell('yes (amortised)', _WmLatTone.ok),
      ],
    ),
    _WmLatMatrixRow(
      'Preserves insertion order',
      <_WmLatMatrixCell>[
        _WmLatMatrixCell('n/a (no iteration)', _WmLatTone.info),
        _WmLatMatrixCell('yes', _WmLatTone.ok),
        _WmLatMatrixCell('n/a', _WmLatTone.info),
        _WmLatMatrixCell('yes', _WmLatTone.ok),
      ],
    ),
    _WmLatMatrixRow(
      'Length / size query',
      <_WmLatMatrixCell>[
        _WmLatMatrixCell('no', _WmLatTone.no),
        _WmLatMatrixCell('yes', _WmLatTone.ok),
        _WmLatMatrixCell('no', _WmLatTone.no),
        _WmLatMatrixCell('yes', _WmLatTone.ok),
      ],
    ),
    _WmLatMatrixRow(
      'On-web implementation',
      <_WmLatMatrixCell>[
        _WmLatMatrixCell('JS WeakMap', _WmLatTone.info),
        _WmLatMatrixCell('dart2js HashMap', _WmLatTone.info),
        _WmLatMatrixCell('not available (VM only)', _WmLatTone.no),
        _WmLatMatrixCell('dart2js LinkedHashMap', _WmLatTone.info),
      ],
    ),
    _WmLatMatrixRow(
      'Built-in observability',
      <_WmLatMatrixCell>[
        _WmLatMatrixCell('none', _WmLatTone.no),
        _WmLatMatrixCell('keys, values, length', _WmLatTone.ok),
        _WmLatMatrixCell('none', _WmLatTone.no),
        _WmLatMatrixCell('keys, values, length', _WmLatTone.ok),
      ],
    ),
    _WmLatMatrixRow(
      'Typical use',
      <_WmLatMatrixCell>[
        _WmLatMatrixCell('metadata on user objects', _WmLatTone.info),
        _WmLatMatrixCell('general key → value', _WmLatTone.info),
        _WmLatMatrixCell('private state by object', _WmLatTone.info),
        _WmLatMatrixCell('ordered config / cache', _WmLatTone.info),
      ],
    ),
    _WmLatMatrixRow(
      'Cleanup on key GC',
      <_WmLatMatrixCell>[
        _WmLatMatrixCell('automatic', _WmLatTone.ok),
        _WmLatMatrixCell('none — manual', _WmLatTone.warn),
        _WmLatMatrixCell('automatic', _WmLatTone.ok),
        _WmLatMatrixCell('none — manual', _WmLatTone.warn),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _WmLatChapterHeader(
          numeral: 'V',
          title: 'WeakMap vs Map vs Expando vs LinkedHashMap',
          blurb:
              'The trade-off table you want at your elbow when picking a structure.',
          accent: _wmLatRose,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _WmLatCard(
            accent: _wmLatRose,
            title: 'Feature matrix',
            subtitle:
                'tones: ok/strong, warn/attention, no/missing, info/nuance',
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildHeaderRow(),
                const _WmLatDivider(),
                for (int i = 0; i < _rows.length; i++) _buildRow(i),
                const _WmLatDivider(),
                _buildLegend(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderRow() {
    return Row(
      children: <Widget>[
        const SizedBox(
          width: 150,
          child: Text(
            'Feature',
            style: TextStyle(
              color: _wmLatInkDeep,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
        ),
        for (final String c in _columns)
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: (_wmLatIndigo ?? const Color(0xFF000000)).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: (_wmLatIndigo ?? const Color(0xFF000000)).withValues(alpha: 0.5)),
              ),
              child: Text(
                c,
                style: const TextStyle(
                  color: _wmLatIndigoDeep,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildRow(int i) {
    final _WmLatMatrixRow r = _rows[i];
    final Color bg = i.isEven
        ? (_wmLatSilverSoft ?? const Color(0xFF000000)).withValues(alpha: 0.4)
        : Colors.transparent;
    // NOTE [E2 batch 3 fix]: Row had `crossAxisAlignment: CrossAxisAlignment.stretch`
    // while sitting inside a SliverToBoxAdapter (unbounded vertical). Stretch on
    // Row's cross-axis (= vertical) tries to size children to the parent's max
    // height, which is infinite, cascading through the relayoutBoundary chain.
    // Cells are icon+text containers with their own intrinsic height — no need
    // to align them to a stretched vertical band.
    return Container(
      color: bg,
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Text(
                r.feature,
                style: const TextStyle(
                  color: _wmLatInkDeep,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.5,
                ),
              ),
            ),
          ),
          for (final _WmLatMatrixCell c in r.cells)
            Expanded(child: _buildCell(c)),
        ],
      ),
    );
  }

  Widget _buildCell(_WmLatMatrixCell c) {
    final Color color = switch (c.tone) {
      _WmLatTone.ok => _wmLatMint,
      _WmLatTone.warn => _wmLatAmber,
      _WmLatTone.no => _wmLatDanger,
      _WmLatTone.info => _wmLatIndigo,
    };
    final IconData icon = switch (c.tone) {
      _WmLatTone.ok => Icons.check_circle,
      _WmLatTone.warn => Icons.error,
      _WmLatTone.no => Icons.cancel,
      _WmLatTone.info => Icons.info,
    };
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: (color ?? const Color(0xFF000000)).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: (color ?? const Color(0xFF000000)).withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: color, size: 13),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              c.text,
              style: TextStyle(
                color: color,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Wrap(
      spacing: 10,
      runSpacing: 6,
      children: const <Widget>[
        _WmLatPill(label: 'strong', color: _wmLatMint, icon: Icons.check_circle),
        _WmLatPill(label: 'attention', color: _wmLatAmber, icon: Icons.error),
        _WmLatPill(label: 'missing', color: _wmLatDanger, icon: Icons.cancel),
        _WmLatPill(label: 'nuance', color: _wmLatIndigo, icon: Icons.info),
      ],
    );
  }
}

// ===========================================================================
// CHAPTER VI — STRONG vs WEAK CONTRAST
// ===========================================================================
class _WmLatChapterContrast extends StatefulWidget {
  const _WmLatChapterContrast();

  @override
  State<_WmLatChapterContrast> createState() => _WmLatChapterContrastState();
}

class _WmLatChapterContrastState extends State<_WmLatChapterContrast> {
  final Map<Object, String> _strongMap = <Object, String>{};
  final WeakMap<Object, String> _weakMap = WeakMap<Object, String>();

  final List<Object> _syntheticKeys = <Object>[];
  final List<String> _labels = <String>[];
  final List<bool> _heldStrong = <bool>[];
  int _seq = 0;
  int _tick = 0;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 6; i++) {
      _spawn();
    }
  }

  void _spawn() {
    setState(() {
      _tick += 1;
      final Object k = Object();
      _seq += 1;
      final String label = 'S-${_seq.toString().padLeft(2, '0')}';
      _syntheticKeys.add(k);
      _labels.add(label);
      _heldStrong.add(true);
      _strongMap[k] = '$label • strong';
      _weakMap[k] = '$label • weak';
    });
  }

  void _dropExternalRefs() {
    setState(() {
      _tick += 1;
      for (int i = 0; i < _heldStrong.length; i++) {
        _heldStrong[i] = false;
      }
    });
  }

  void _resetBoth() {
    setState(() {
      _tick += 1;
      _strongMap.clear();
      _weakMap.clear();
      _syntheticKeys.clear();
      _labels.clear();
      _heldStrong.clear();
      _seq = 0;
      for (int i = 0; i < 6; i++) {
        _spawn();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final int stillStrong = _heldStrong.where((bool h) => h).length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _WmLatChapterHeader(
          numeral: 'VI',
          title: 'Strong vs weak, side by side',
          blurb:
              'Two containers track the same keys. One of them keeps the keys alive forever.',
          accent: _wmLatAquaDeep,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _WmLatCard(
            accent: _wmLatAquaDeep,
            title: 'Controls',
            subtitle:
                'tick $_tick  ·  external strong refs remaining $stillStrong/${_syntheticKeys.length}',
            body: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                _WmLatToolbarButton(
                  label: 'Spawn key',
                  icon: Icons.add,
                  color: _wmLatMint,
                  onTap: _spawn,
                ),
                _WmLatToolbarButton(
                  label: 'Drop external refs',
                  icon: Icons.link_off,
                  color: _wmLatDanger,
                  onTap: _dropExternalRefs,
                ),
                _WmLatToolbarButton(
                  label: 'Reset both maps',
                  icon: Icons.refresh,
                  color: _wmLatInkSoft,
                  onTap: _resetBoth,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: _buildStrongPanel()),
              const SizedBox(width: 12),
              Expanded(child: _buildWeakPanel()),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _WmLatCard(
            accent: _wmLatIndigo,
            title: 'Reading this comparison',
            subtitle: 'the difference is not about what you see now',
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                _WmLatBullet(
                  color: _wmLatRose,
                  title: 'Strong map holds the key',
                  body:
                      'Even after you press "Drop external refs", the Map itself still has a strong reference to every key — so none of them can be collected.',
                ),
                _WmLatBullet(
                  color: _wmLatMint,
                  title: 'Weak map does not',
                  body:
                      'When the external strong reference goes, the WeakMap\'s reference is the last one — and a weak one. The runtime is free to reclaim.',
                ),
                _WmLatBullet(
                  color: _wmLatAmber,
                  title: 'This demo does not force GC',
                  body:
                      'Dart provides no public "runGC" call. A live program would see the WeakMap entries disappear over time, at times chosen by the VM.',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStrongPanel() {
    return _WmLatCard(
      accent: _wmLatRose,
      title: 'Map<Object, String>',
      subtitle:
          'entries: ${_strongMap.length}  ·  all keys alive because Map holds them',
      body: SizedBox(
        height: 200,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              for (int i = 0; i < _syntheticKeys.length; i++)
                _buildKeyLine(
                  label: _labels[i],
                  strongHeld: _heldStrong[i],
                  value: _strongMap[_syntheticKeys[i]],
                  accent: _wmLatRose,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeakPanel() {
    return _WmLatCard(
      accent: _wmLatMint,
      title: 'WeakMap<Object, String>',
      subtitle: 'entries may vanish when external refs drop',
      body: SizedBox(
        height: 200,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              for (int i = 0; i < _syntheticKeys.length; i++)
                _buildKeyLine(
                  label: _labels[i],
                  strongHeld: _heldStrong[i],
                  value: _weakMap[_syntheticKeys[i]],
                  accent: _wmLatMint,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKeyLine({
    required String label,
    required bool strongHeld,
    required String? value,
    required Color accent,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: (accent ?? const Color(0xFF000000)).withValues(alpha: strongHeld ? 0.1 : 0.03),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: (accent ?? const Color(0xFF000000)).withValues(alpha: strongHeld ? 0.5 : 0.25),
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            strongHeld ? Icons.link : Icons.link_off,
            size: 14,
            color: strongHeld ? accent : _wmLatInkSoft,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: strongHeld ? _wmLatInkDeep : _wmLatInkSoft,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          Text(
            value ?? '(null)',
            style: TextStyle(
              color: value == null ? _wmLatInkSoft : accent,
              fontStyle: value == null ? FontStyle.italic : FontStyle.normal,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// CHAPTER VII — CODE RECIPE CARDS
// ===========================================================================
class _WmLatRecipe {
  const _WmLatRecipe({
    required this.title,
    required this.blurb,
    required this.code,
    required this.notes,
    required this.accent,
    required this.icon,
  });

  final String title;
  final String blurb;
  final String code;
  final String notes;
  final Color accent;
  final IconData icon;
}

class _WmLatChapterRecipes extends StatelessWidget {
  const _WmLatChapterRecipes();

  static const List<_WmLatRecipe> _recipes = <_WmLatRecipe>[
    _WmLatRecipe(
      icon: Icons.cached,
      accent: _wmLatAqua,
      title: 'Recipe 1 — memoise a derived value',
      blurb: 'Avoid recomputing per-object work inside a build method.',
      code: 'final WeakMap<Widget, _Derived> _memo = WeakMap();\n\n'
          '_Derived derivedFor(Widget w) {\n'
          '  final _Derived? hit = _memo[w];\n'
          '  if (hit != null) return hit;\n'
          '  final _Derived fresh = _expensive(w);\n'
          '  _memo[w] = fresh;\n'
          '  return fresh;\n'
          '}',
      notes:
          'The cache entry fades out as soon as the Widget is no longer referenced — no cleanup timer, no LRU bookkeeping.',
    ),
    _WmLatRecipe(
      icon: Icons.settings_ethernet,
      accent: _wmLatIndigo,
      title: 'Recipe 2 — per-controller flags',
      blurb:
          'Attach framework-side debug flags to user controllers without subclassing.',
      code: 'final WeakMap<ScrollController, bool> _firstPaintSeen = WeakMap();\n\n'
          'void onFirstPaint(ScrollController c) {\n'
          '  if (_firstPaintSeen[c] == true) return;\n'
          '  _firstPaintSeen[c] = true;\n'
          '  debugPrint("first paint for controller");\n'
          '}',
      notes:
          'User disposes their controller naturally; your flag disappears with it. No hook into dispose().',
    ),
    _WmLatRecipe(
      icon: Icons.label_important,
      accent: _wmLatMint,
      title: 'Recipe 3 — tag third-party objects',
      blurb: 'Decorate objects from a library that never offered a Finalizer.',
      code: 'final WeakMap<Object, String> _tags = WeakMap<Object, String>();\n\n'
          'void tag(Object o, String tag) => _tags[o] = tag;\n'
          'String? tagOf(Object o) => _tags[o];',
      notes:
          'You can safely call this on every object passed to your API without worrying about retaining them past their natural life.',
    ),
    _WmLatRecipe(
      icon: Icons.settings_input_component,
      accent: _wmLatAmber,
      title: 'Recipe 4 — pair with Finalizer',
      blurb:
          'Run cleanup code when an externally-owned object is collected.',
      code: 'final Finalizer<String> _finaliser =\n'
          '    Finalizer<String>((String id) {\n'
          '  debugPrint("finalised: \$id");\n'
          '});\n\n'
          'final WeakMap<Object, String> _ids = WeakMap();\n'
          'void track(Object o, String id) {\n'
          '  _ids[o] = id;\n'
          '  _finaliser.attach(o, id, detach: o);\n'
          '}',
      notes:
          'Finalizer callbacks are advisory — they might never fire. Use them for telemetry, not for correctness.',
    ),
    _WmLatRecipe(
      icon: Icons.bolt,
      accent: _wmLatRose,
      title: 'Recipe 5 — write-through with invalidation',
      blurb: 'Evict entries when the underlying object mutates.',
      code: 'class Thumbnail { /* ... */ }\n\n'
          'final WeakMap<Image, Thumbnail> _thumbs = WeakMap();\n\n'
          'Thumbnail thumbFor(Image img, {bool force = false}) {\n'
          '  if (force) _thumbs.remove(img);\n'
          '  return _thumbs[img] ??= _render(img);\n'
          '}',
      notes:
          'When the image source changes, call with force: true. The rest of the lifetime management is implicit.',
    ),
    _WmLatRecipe(
      icon: Icons.stacked_bar_chart,
      accent: _wmLatAquaDeep,
      title: 'Recipe 6 — per-frame scratch state',
      blurb: 'Cheap sidecar state that must not outlive a frame\'s objects.',
      code: 'final WeakMap<RenderObject, _Scratch> _scratch = WeakMap();\n\n'
          'void annotate(RenderObject r, _Scratch s) {\n'
          '  _scratch[r] = s;\n'
          '}\n'
          '_Scratch? read(RenderObject r) => _scratch[r];',
      notes:
          'When a render object is swapped, the scratch entry dies with it; no dispose() coupling.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _WmLatChapterHeader(
          numeral: 'VII',
          title: 'Recipes — six patterns ready to copy',
          blurb:
              'Each card is a miniature decision: what you want, how WeakMap gives it to you, and what to watch for.',
          accent: _wmLatIndigoDeep,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              for (final _WmLatRecipe r in _recipes) _buildRecipeCard(r),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecipeCard(_WmLatRecipe r) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double w = constraints.maxWidth > 700
            ? (constraints.maxWidth - 24) / 2
            : constraints.maxWidth;
        return SizedBox(
          width: w,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: (r.accent ?? const Color(0xFF000000)).withValues(alpha: 0.5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: (r.accent ?? const Color(0xFF000000)).withValues(alpha: 0.12),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                  decoration: BoxDecoration(
                    color: (r.accent ?? const Color(0xFF000000)).withValues(alpha: 0.12),
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: r.accent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(r.icon, color: Colors.white, size: 16),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          r.title,
                          style: const TextStyle(
                            color: _wmLatInkDeep,
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        r.blurb,
                        style: const TextStyle(
                          color: _wmLatInk,
                          fontSize: 12.5,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _WmLatCodeBlock(code: r.code),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: (_wmLatAmberPale ?? const Color(0xFF000000)).withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: (_wmLatAmber ?? const Color(0xFF000000)).withValues(alpha: 0.45),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Icon(
                              Icons.lightbulb_outline,
                              color: _wmLatAmber,
                              size: 15,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                r.notes,
                                style: const TextStyle(
                                  color: _wmLatInk,
                                  fontSize: 12,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ===========================================================================
// CHAPTER VIII — EPILOGUE
// ===========================================================================
class _WmLatChapterEpilogue extends StatelessWidget {
  const _WmLatChapterEpilogue();

  static const List<_WmLatGotcha> _gotchas = <_WmLatGotcha>[
    _WmLatGotcha(
      icon: Icons.block,
      color: _wmLatDanger,
      title: 'Keys must be objects',
      body:
          'Do not pass ints, doubles, strings, bools, records, or null. These are canonicalised; the runtime cannot express a meaningful weak reference to them. A hand-rolled variant that silently promoted primitives to a strong Map would be a footgun.',
    ),
    _WmLatGotcha(
      icon: Icons.all_inclusive,
      color: _wmLatAmber,
      title: 'No iteration — by design',
      body:
          'There is no keys, values, length, or forEach. That is a feature: the collection is allowed to shrink asynchronously, so any snapshot would be lying. If you need iteration, you probably want Map plus an explicit dispose hook.',
    ),
    _WmLatGotcha(
      icon: Icons.hourglass_bottom,
      color: _wmLatRose,
      title: 'Lookups can return null after GC',
      body:
          'Always treat `map[k]` as nullable. Defensive reads are non-negotiable — the entry may have been reclaimed between two consecutive frames.',
    ),
    _WmLatGotcha(
      icon: Icons.public,
      color: _wmLatIndigo,
      title: 'Web vs VM behaviour differs',
      body:
          'On the VM you get Expando-backed weak refs with well-understood semantics. On the web you rely on the JS engine\'s WeakMap. Both are correct, but GC pressure patterns and finalisation timings differ.',
    ),
    _WmLatGotcha(
      icon: Icons.cleaning_services,
      color: _wmLatMint,
      title: 'Pair with Finalizer for cleanup hooks',
      body:
          'WeakMap does not tell you when something is collected. If you must free external resources (file handles, native memory), use dart:core Finalizer alongside it, and assume callbacks are advisory.',
    ),
    _WmLatGotcha(
      icon: Icons.memory,
      color: _wmLatAquaDeep,
      title: 'Values are held strongly — be careful',
      body:
          'The value side of the map is not weak. If your value holds a reference back to the key, you have re-created a leak. Keep values small and independent of the key\'s graph.',
    ),
    _WmLatGotcha(
      icon: Icons.timeline,
      color: _wmLatIndigoDeep,
      title: 'Not a substitute for a real dispose()',
      body:
          'Use WeakMap for opportunistic caches and side-car state. For deterministic teardown — close streams, dispose ChangeNotifier — you still need an explicit lifecycle hook.',
    ),
    _WmLatGotcha(
      icon: Icons.science,
      color: _wmLatRose,
      title: 'Testing requires patience',
      body:
          'Do not assert "the entry was collected". Dart does not expose a forced-GC API. Test behaviour through observable side effects, and use clear() to force a known state.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _WmLatChapterHeader(
          numeral: 'VIII',
          title: 'Production notes and gotchas',
          blurb:
              'Everything the docs assume you know after you have shipped a release using it.',
          accent: _wmLatDanger,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _WmLatCard(
            accent: _wmLatDanger,
            title: 'Eight sharp edges',
            subtitle: 'read all of them at least once',
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                for (final _WmLatGotcha g in _gotchas) _buildGotcha(g),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _WmLatCard(
            accent: _wmLatIndigoDeep,
            title: 'Mental model — one sentence',
            subtitle: 'stick this on a monitor',
            body: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[_wmLatIndigoPale, _wmLatAquaPale],
                ),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: (_wmLatIndigo ?? const Color(0xFF000000)).withValues(alpha: 0.45),
                ),
              ),
              child: const Column(
                children: <Widget>[
                  Text(
                    '"A WeakMap is the metadata you carry around that never '
                    'overstays its welcome."',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _wmLatInkDeep,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.italic,
                      height: 1.45,
                      letterSpacing: 0.3,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Use it for caches, flags, annotations, and scratch state — '
                    'never for the primary record of what exists.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _wmLatInkSoft,
                      fontSize: 12.5,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _WmLatCard(
            accent: _wmLatMint,
            title: 'Checklist before you reach for WeakMap',
            subtitle: 'five quick questions',
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const <Widget>[
                _WmLatChecklistItem(
                  text: 'Are the keys real objects (not primitives)?',
                ),
                _WmLatChecklistItem(
                  text:
                      'Do I want the entry to vanish when the key is no longer referenced elsewhere?',
                ),
                _WmLatChecklistItem(
                  text:
                      'Can I live without iteration, length, or any deterministic cleanup signal?',
                ),
                _WmLatChecklistItem(
                  text:
                      'Is the value cheap, or at least rebuildable from the key when missed?',
                ),
                _WmLatChecklistItem(
                  text:
                      'Are all code paths robust to a null lookup result?',
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _wmLatPaperAlt,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _wmLatSilver),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.architecture, color: _wmLatIndigoDeep, size: 18),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'End of dossier. Scroll up to revisit any chapter — the '
                    'crystal lattice shimmer keeps running regardless.',
                    style: TextStyle(
                      color: _wmLatInkDeep,
                      fontSize: 13,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGotcha(_WmLatGotcha g) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: (g.color ?? const Color(0xFF000000)).withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: (g.color ?? const Color(0xFF000000)).withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: g.color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(g.icon, color: Colors.white, size: 17),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  g.title,
                  style: const TextStyle(
                    color: _wmLatInkDeep,
                    fontWeight: FontWeight.w800,
                    fontSize: 13.5,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  g.body,
                  style: const TextStyle(
                    color: _wmLatInkSoft,
                    fontSize: 12.5,
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

class _WmLatGotcha {
  const _WmLatGotcha({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
  });
  final IconData icon;
  final Color color;
  final String title;
  final String body;
}

class _WmLatChecklistItem extends StatelessWidget {
  const _WmLatChecklistItem({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: _wmLatMintPale,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: _wmLatMint),
            ),
            child: const Icon(
              Icons.check,
              size: 13,
              color: _wmLatMint,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: _wmLatInk,
                fontSize: 13,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// ===========================================================================
// WidgetStatePropertyAll<T> — Deep Visual Demo
// ---------------------------------------------------------------------------
// Theme: Rubber-stamp office. A notary sits behind an oak desk. Every
// paper that slides across the blotter comes out with the same seal —
// regardless of who signed it, what color their pen was, or whether the
// intern hovered nervously over the inkwell. That's WidgetStatePropertyAll:
// "use this value for every state, no matter what."
// ---------------------------------------------------------------------------
// Prefix: _Wspa  (WidgetStateProperty-All)
// ===========================================================================

// ---------------------------------------------------------------------------
// Palette — warm oak, ivory paper, red/blue/green stamp inks, brass accents.
// ---------------------------------------------------------------------------
const Color _kOakDark = Color(0xFF4A2E16);
const Color _kOakMid = Color(0xFF6B4423);
const Color _kPaper = Color(0xFFF5EFE0);
const Color _kPaperShade = Color(0xFFE8DFC6);
const Color _kPaperEdge = Color(0xFFC9BE9A);
const Color _kInkRed = Color(0xFFB2292E);
const Color _kInkRedSoft = Color(0xFFE8A6A8);
const Color _kInkBlue = Color(0xFF1F4E79);
const Color _kInkBlueSoft = Color(0xFFA6B9D1);
const Color _kInkGreen = Color(0xFF2F6B3E);
const Color _kInkGreenSoft = Color(0xFFA8C8B1);
const Color _kBrassSoft = Color(0xFFE5D2A0);
const Color _kBrassDark = Color(0xFF7A5E20);
const Color _kShadow = Color(0x331A0C00);
const Color _kText = Color(0xFF2B1B0A);
const Color _kTextMuted = Color(0xFF6B5540);
const Color _kSeal = Color(0xFF8B0000);
const Color _kBrass = Color(0xFFB08A3C);

// ---------------------------------------------------------------------------
// Entry point — d4rt expects a top-level `build` returning a widget tree.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return const _WspaApp();
}

// ===========================================================================
// Root MaterialApp — Material 3 theme seeded from oak brown.
// ===========================================================================
class _WspaApp extends StatelessWidget {
  const _WspaApp();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: _kOakMid,
      brightness: Brightness.light,
    );
    final ThemeData theme = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: _kPaper,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _kText, height: 1.4, fontSize: 13),
        bodySmall: TextStyle(color: _kTextMuted, height: 1.35, fontSize: 11),
        titleLarge: TextStyle(
          color: _kText,
          fontWeight: FontWeight.w800,
          fontSize: 22,
          letterSpacing: 0.3,
        ),
        titleMedium: TextStyle(
          color: _kText,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
        titleSmall: TextStyle(
          color: _kText,
          fontWeight: FontWeight.w700,
          fontSize: 13,
          letterSpacing: 0.5,
        ),
        labelLarge: TextStyle(
          color: _kText,
          fontWeight: FontWeight.w700,
          fontSize: 12,
          letterSpacing: 0.4,
        ),
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const _WspaHome(),
    );
  }
}

// ===========================================================================
// Home scaffold — an 11-tab notary office of examples.
// ===========================================================================
class _WspaHome extends StatelessWidget {
  const _WspaHome();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 11,
      child: Scaffold(
        backgroundColor: _kPaper,
        appBar: AppBar(
          backgroundColor: _kOakDark,
          foregroundColor: _kPaper,
          elevation: 0,
          toolbarHeight: 96,
          title: const _WspaTitleBar(),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(52),
            child: _WspaTabBar(),
          ),
        ),
        body: Stack(
          children: const <Widget>[
            Positioned.fill(child: _WspaDeskBackdrop()),
            Positioned.fill(
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  _WspaDossierTab(),
                  _WspaAnatomyTab(),
                  _WspaShowcaseTab(),
                  _WspaVsFromMapTab(),
                  _WspaTypedGalleryTab(),
                  _WspaButtonGalleryTab(),
                  _WspaMixedStylingTab(),
                  _WspaWhenNotToUseTab(),
                  _WspaRecipesTab(),
                  _WspaComparisonTab(),
                  _WspaGlossaryTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// Title bar — seal + title + subtitle.
// ===========================================================================
class _WspaTitleBar extends StatelessWidget {
  const _WspaTitleBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _kInkRed.withValues(alpha: 0.18),
            border: Border.all(color: _kInkRed, width: 2.4),
          ),
          alignment: Alignment.center,
          child: const Text(
            'ALL',
            style: TextStyle(
              color: _kInkRed,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(width: 14),
        const Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'WidgetStatePropertyAll<T>',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                  color: _kPaper,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'The rubber-stamp of widget state properties — one value for every state',
                style: TextStyle(
                  fontSize: 12,
                  color: _kBrassSoft,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ===========================================================================
// Tab bar.
// ===========================================================================
class _WspaTabBar extends StatelessWidget {
  const _WspaTabBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kOakDark,
      child: const TabBar(
        isScrollable: true,
        indicatorColor: _kInkRed,
        indicatorWeight: 3,
        labelColor: _kPaper,
        unselectedLabelColor: _kBrassSoft,
        labelStyle: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.4),
        tabs: <Widget>[
          Tab(text: 'Dossier'),
          Tab(text: 'Anatomy'),
          Tab(text: 'Showcase'),
          Tab(text: 'vs fromMap'),
          Tab(text: 'Typed Gallery'),
          Tab(text: 'Buttons'),
          Tab(text: 'Mixed Styling'),
          Tab(text: 'Not-To-Use'),
          Tab(text: 'Recipes'),
          Tab(text: 'Comparison'),
          Tab(text: 'Glossary'),
        ],
      ),
    );
  }
}

// ===========================================================================
// Oak desk backdrop — a CustomPainter draws a warm wood-grain surface
// with ink-pad smudges and a faint paper-tray outline.
// ===========================================================================
class _WspaDeskBackdrop extends StatelessWidget {
  const _WspaDeskBackdrop();

  @override
  Widget build(BuildContext context) {
    return const IgnorePointer(
      child: CustomPaint(
        painter: _WspaDeskPainter(),
        child: SizedBox.expand(),
      ),
    );
  }
}

class _WspaDeskPainter extends CustomPainter {
  const _WspaDeskPainter();

  @override
  void paint(Canvas canvas, Size size) {
    // Base oak fill with a warm vertical gradient.
    final Rect rect = Offset.zero & size;
    final Paint base = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[_kPaper, _kPaperShade],
      ).createShader(rect);
    canvas.drawRect(rect, base);

    // Faint horizontal wood-grain streaks suggesting the oak underneath.
    final Paint grain = Paint()
      ..color = _kPaperEdge.withValues(alpha: 0.35)
      ..strokeWidth = 0.6
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < 40; i++) {
      final double y = (size.height / 40) * i + (i % 3) * 1.7;
      final Path p = Path()..moveTo(0, y);
      for (double x = 0; x <= size.width; x += 18) {
        final double jitter = ((i * 13 + x.toInt()) % 7) * 0.5 - 1.5;
        p.lineTo(x, y + jitter);
      }
      canvas.drawPath(p, grain);
    }

    // Three subtle ink-pad smudges in red / blue / green at corners.
    _drawSmudge(canvas, Offset(size.width * 0.08, size.height * 0.15),
        _kInkRed.withValues(alpha: 0.05), 120);
    _drawSmudge(canvas, Offset(size.width * 0.92, size.height * 0.25),
        _kInkBlue.withValues(alpha: 0.05), 140);
    _drawSmudge(canvas, Offset(size.width * 0.5, size.height * 0.88),
        _kInkGreen.withValues(alpha: 0.05), 160);
  }

  void _drawSmudge(Canvas canvas, Offset center, Color color, double radius) {
    final Paint p = Paint()
      ..shader = RadialGradient(
        colors: <Color>[color, color.withValues(alpha: 0)],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, p);
  }

  @override
  bool shouldRepaint(covariant _WspaDeskPainter oldDelegate) => false;
}

// ===========================================================================
// Shared atoms — page header, section header, paper card, tag, info row.
// ===========================================================================
class _WspaPageHeader extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String subtitle;
  final Color accent;
  const _WspaPageHeader({
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    this.accent = _kInkRed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: _kPaperEdge, width: 1.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(color: accent, width: 1),
                ),
                child: Text(
                  eyebrow.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: accent,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 13,
              color: _kTextMuted,
              height: 1.4,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class _WspaSectionHeader extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  const _WspaSectionHeader({
    required this.text,
    required this.icon,
    this.color = _kOakDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
      child: Row(
        children: <Widget>[
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
              color: color,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(height: 1, color: _kPaperEdge),
          ),
        ],
      ),
    );
  }
}

class _WspaPaperCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color paperColor;
  const _WspaPaperCard({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.paperColor = _kPaper,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: paperColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _kPaperEdge, width: 1),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: _kShadow,
            offset: Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: child,
    );
  }
}

class _WspaTag extends StatelessWidget {
  final String text;
  final Color color;
  final IconData? icon;
  // ignore: unused_element_parameter
  const _WspaTag({required this.text, required this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: color, width: 0.8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 11, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _WspaInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? accent;
  const _WspaInfoRow({
    required this.label,
    required this.value,
    this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: _kTextMuted,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                color: accent ?? _kText,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WspaCodeBlock extends StatelessWidget {
  final String code;
  final Color accent;
  const _WspaCodeBlock({required this.code, this.accent = _kInkBlue});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _kOakDark,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: accent, width: 1),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.5,
          color: _kBrassSoft,
          height: 1.5,
        ),
      ),
    );
  }
}

// ===========================================================================
// SECTION 1: DOSSIER / PREAMBLE
// Six cards introducing WidgetStatePropertyAll.
// ===========================================================================
class _WspaDossierTab extends StatelessWidget {
  const _WspaDossierTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 40),
      children: const <Widget>[
        _WspaPageHeader(
          eyebrow: 'Dossier',
          title: 'The rubber-stamp of WidgetStateProperty',
          subtitle:
              'A constant value dressed up as a state-resolving property. Ideal when no '
              'interaction should change it.',
        ),
        SizedBox(height: 14),
        _WspaSectionHeader(
          text: 'Six foundational cards',
          icon: Icons.menu_book_rounded,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: _WspaDossierGrid(),
        ),
        SizedBox(height: 22),
        _WspaSectionHeader(
          text: 'One-line mental model',
          icon: Icons.psychology_alt_outlined,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: _WspaMentalModelCard(),
        ),
        SizedBox(height: 22),
        _WspaSectionHeader(
          text: 'Where it sits in the Flutter SDK',
          icon: Icons.account_tree_outlined,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: _WspaSdkLocationCard(),
        ),
        SizedBox(height: 22),
      ],
    );
  }
}

class _WspaDossierGrid extends StatelessWidget {
  const _WspaDossierGrid();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext ctx, BoxConstraints c) {
      final bool wide = c.maxWidth > 820;
      final int cols = wide ? 3 : (c.maxWidth > 540 ? 2 : 1);
      final List<_WspaDossierEntry> entries = _dossierEntries;
      return Wrap(
        spacing: 14,
        runSpacing: 14,
        children: <Widget>[
          for (final _WspaDossierEntry e in entries)
            SizedBox(
              width: (c.maxWidth - (cols - 1) * 14) / cols,
              child: _WspaDossierCard(entry: e),
            ),
        ],
      );
    });
  }
}

class _WspaDossierEntry {
  final String title;
  final String body;
  final IconData icon;
  final Color ink;
  final String tag;
  const _WspaDossierEntry({
    required this.title,
    required this.body,
    required this.icon,
    required this.ink,
    required this.tag,
  });
}

const List<_WspaDossierEntry> _dossierEntries = <_WspaDossierEntry>[
  _WspaDossierEntry(
    title: 'What is it?',
    body:
        'WidgetStatePropertyAll<T> is a WidgetStateProperty whose resolve(states) '
        'always returns the same stored value, ignoring the state set entirely.',
    icon: Icons.help_outline,
    ink: _kInkRed,
    tag: 'core',
  ),
  _WspaDossierEntry(
    title: 'When to use it?',
    body:
        'When a style value should not depend on hover, pressed, focused, selected, '
        'disabled, or any other WidgetState — i.e. it is a constant.',
    icon: Icons.check_circle_outline,
    ink: _kInkGreen,
    tag: 'usage',
  ),
  _WspaDossierEntry(
    title: 'The one-line rule',
    body:
        'If you would have written a plain value if the API allowed it, wrap that '
        'value in WidgetStatePropertyAll. It is the boxing adapter.',
    icon: Icons.rule,
    ink: _kInkBlue,
    tag: 'rule',
  ),
  _WspaDossierEntry(
    title: 'vs resolveWith',
    body:
        'WidgetStateProperty.resolveWith((states) => value) is equivalent — but '
        'allocates a callback. WidgetStatePropertyAll is the cheap, const-friendly form.',
    icon: Icons.compare_arrows,
    ink: _kBrassDark,
    tag: 'contrast',
  ),
  _WspaDossierEntry(
    title: 'vs fromMap',
    body:
        'WidgetStateColor.fromMap({state: color, ...}) reads the states set. '
        'WidgetStatePropertyAll does not even look at it. Fundamentally different intent.',
    icon: Icons.map_outlined,
    ink: _kSeal,
    tag: 'contrast',
  ),
  _WspaDossierEntry(
    title: 'Deprecation context',
    body:
        'Replaces MaterialStatePropertyAll from earlier Flutter versions. Same semantics, '
        'new WidgetStateProperty family. Most IDE migrations are one-to-one.',
    icon: Icons.update,
    ink: _kOakDark,
    tag: 'history',
  ),
];

class _WspaDossierCard extends StatelessWidget {
  final _WspaDossierEntry entry;
  const _WspaDossierCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    return _WspaPaperCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: entry.ink.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                  border: Border.all(color: entry.ink, width: 1.2),
                ),
                child: Icon(entry.icon, color: entry.ink, size: 16),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  entry.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: _kText,
                  ),
                ),
              ),
              _WspaTag(text: entry.tag, color: entry.ink),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            entry.body,
            style: const TextStyle(fontSize: 12, height: 1.45, color: _kText),
          ),
        ],
      ),
    );
  }
}

class _WspaMentalModelCard extends StatelessWidget {
  const _WspaMentalModelCard();

  @override
  Widget build(BuildContext context) {
    return _WspaPaperCard(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: _kInkRed.withValues(alpha: 0.08),
              shape: BoxShape.circle,
              border: Border.all(color: _kInkRed, width: 2.5),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.approval, color: _kInkRed, size: 34),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '"Whatever the state is, stamp the same value."',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _kText,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'The notary does not care who signed the paper. The same red seal '
                  'goes on every single one. Hover, press, focus, disable — the seal '
                  'is the seal.',
                  style: TextStyle(
                    fontSize: 12,
                    color: _kTextMuted,
                    height: 1.4,
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

class _WspaSdkLocationCard extends StatelessWidget {
  const _WspaSdkLocationCard();

  @override
  Widget build(BuildContext context) {
    return _WspaPaperCard(
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _WspaInfoRow(
            label: 'Library',
            value: 'package:flutter/widgets.dart (re-exported by material.dart)',
          ),
          _WspaInfoRow(
            label: 'Source',
            value: 'flutter/lib/src/widgets/widget_state.dart',
          ),
          _WspaInfoRow(
            label: 'Declaration',
            value: 'class WidgetStatePropertyAll<T> implements WidgetStateProperty<T>',
          ),
          _WspaInfoRow(
            label: 'Constructor',
            value: 'const WidgetStatePropertyAll(this.value)',
          ),
          _WspaInfoRow(
            label: 'Field',
            value: 'final T value;',
          ),
          _WspaInfoRow(
            label: 'resolve(states)',
            value: '=> value;   // never touches the states set',
            accent: _kInkRed,
          ),
          _WspaInfoRow(
            label: 'Supersedes',
            value: 'MaterialStatePropertyAll<T>',
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 2: ANATOMY
// Break down the class declaration, generic parameter, and resolve rule.
// ===========================================================================
class _WspaAnatomyTab extends StatelessWidget {
  const _WspaAnatomyTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 40),
      children: const <Widget>[
        _WspaPageHeader(
          eyebrow: 'Anatomy',
          title: 'Under the microscope',
          subtitle:
              'Five moving parts: class header, type parameter, constructor, field, '
              'and the one-line resolve implementation.',
          accent: _kInkBlue,
        ),
        SizedBox(height: 14),
        _WspaSectionHeader(
          text: '1. Class declaration',
          icon: Icons.code,
          color: _kInkBlue,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: _WspaAnatomyDeclarationCard(),
        ),
        SizedBox(height: 18),
        _WspaSectionHeader(
          text: '2. Generic parameter <T>',
          icon: Icons.text_fields,
          color: _kInkBlue,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: _WspaAnatomyGenericCard(),
        ),
        SizedBox(height: 18),
        _WspaSectionHeader(
          text: '3. Constructor + final field',
          icon: Icons.settings,
          color: _kInkBlue,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: _WspaAnatomyCtorCard(),
        ),
        SizedBox(height: 18),
        _WspaSectionHeader(
          text: '4. resolve(states) — always returns value',
          icon: Icons.sync_alt,
          color: _kInkRed,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: _WspaAnatomyResolveCard(),
        ),
        SizedBox(height: 18),
        _WspaSectionHeader(
          text: '5. Where it shows up in ButtonStyle',
          icon: Icons.auto_awesome,
          color: _kInkBlue,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: _WspaAnatomyButtonStyleCard(),
        ),
        SizedBox(height: 22),
      ],
    );
  }
}

class _WspaAnatomyDeclarationCard extends StatelessWidget {
  const _WspaAnatomyDeclarationCard();

  @override
  Widget build(BuildContext context) {
    return _WspaPaperCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'The full, exact declaration in the Flutter SDK:',
            style: TextStyle(fontSize: 12, color: _kTextMuted),
          ),
          SizedBox(height: 10),
          _WspaCodeBlock(
            code: '// package:flutter/src/widgets/widget_state.dart\n'
                'class WidgetStatePropertyAll<T> implements WidgetStateProperty<T> {\n'
                '  const WidgetStatePropertyAll(this.value);\n'
                '\n'
                '  final T value;\n'
                '\n'
                '  @override\n'
                '  T resolve(Set<WidgetState> states) => value;\n'
                '\n'
                '  @override\n'
                '  String toString() {\n'
                '    if (value is double) {\n'
                '      return \'WidgetStatePropertyAll(\${debugFormatDouble(value as double)})\';\n'
                '    }\n'
                '    return \'WidgetStatePropertyAll(\$value)\';\n'
                '  }\n'
                '}',
          ),
          SizedBox(height: 10),
          Text(
            'Three lines of substance: a const constructor, a final value, and a '
            'resolve that ignores its argument. That is the whole class.',
            style: TextStyle(fontSize: 12, color: _kText, height: 1.4),
          ),
        ],
      ),
    );
  }
}

class _WspaAnatomyGenericCard extends StatelessWidget {
  const _WspaAnatomyGenericCard();

  @override
  Widget build(BuildContext context) {
    return _WspaPaperCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'The type parameter <T> can be literally any type that the particular '
            'ButtonStyle / theme slot expects. Common instantiations:',
            style: TextStyle(fontSize: 12, color: _kText, height: 1.4),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const <Widget>[
              _WspaTag(text: 'Color', color: _kInkRed),
              _WspaTag(text: 'TextStyle', color: _kInkBlue),
              _WspaTag(text: 'EdgeInsetsGeometry', color: _kInkGreen),
              _WspaTag(text: 'double', color: _kBrassDark),
              _WspaTag(text: 'Size', color: _kSeal),
              _WspaTag(text: 'OutlinedBorder', color: _kOakDark),
              _WspaTag(text: 'BorderSide', color: _kInkRed),
              _WspaTag(text: 'MouseCursor', color: _kInkBlue),
              _WspaTag(text: 'Icon', color: _kInkGreen),
              _WspaTag(text: 'AlignmentGeometry', color: _kBrassDark),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'The type is usually inferred by context — you write '
            'WidgetStatePropertyAll(Colors.teal) and <Color> is inferred from the '
            'ButtonStyle.backgroundColor slot.',
            style: TextStyle(fontSize: 11, color: _kTextMuted, height: 1.4),
          ),
        ],
      ),
    );
  }
}

class _WspaAnatomyCtorCard extends StatelessWidget {
  const _WspaAnatomyCtorCard();

  @override
  Widget build(BuildContext context) {
    return _WspaPaperCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'The constructor is const and takes a single positional argument. '
            'The stored value is immutable (final).',
            style: TextStyle(fontSize: 12, color: _kText, height: 1.4),
          ),
          SizedBox(height: 10),
          _WspaCodeBlock(
            code: 'const WidgetStatePropertyAll<Color>(Color(0xFFB2292E))\n'
                '// fully const-evaluable — lives in the const pool',
          ),
          SizedBox(height: 10),
          _WspaInfoRow(
            label: 'const?',
            value: 'Yes, if the inner value is const.',
          ),
          _WspaInfoRow(
            label: 'final value',
            value: 'Yes — same reference returned every resolve.',
          ),
          _WspaInfoRow(
            label: 'copyWith?',
            value: 'No — construct a new instance with a different value.',
          ),
        ],
      ),
    );
  }
}

class _WspaAnatomyResolveCard extends StatelessWidget {
  const _WspaAnatomyResolveCard();

  @override
  Widget build(BuildContext context) {
    return _WspaPaperCard(
      paperColor: _kInkRedSoft.withValues(alpha: 0.25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.priority_high, color: _kInkRed, size: 20),
              SizedBox(width: 6),
              Text(
                'The heart of the class',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  color: _kInkRed,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          _WspaCodeBlock(
            code: '@override\n'
                'T resolve(Set<WidgetState> states) => value;',
            accent: _kInkRed,
          ),
          SizedBox(height: 10),
          Text(
            'Notice: the "states" parameter is never read. Whether the widget is '
            'hovered, pressed, focused, selected, dragged, scrolledUnder, disabled, '
            'or error — the same value comes out. This is the rubber stamp.',
            style: TextStyle(fontSize: 12, color: _kText, height: 1.45),
          ),
        ],
      ),
    );
  }
}

class _WspaAnatomyButtonStyleCard extends StatelessWidget {
  const _WspaAnatomyButtonStyleCard();

  @override
  Widget build(BuildContext context) {
    return _WspaPaperCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'Every slot of ButtonStyle that ends in "Property" accepts a '
            'WidgetStateProperty. WidgetStatePropertyAll is just the most compact '
            'way to feed it a constant:',
            style: TextStyle(fontSize: 12, color: _kText, height: 1.4),
          ),
          SizedBox(height: 10),
          _WspaCodeBlock(
            code: 'FilledButton(\n'
                '  style: ButtonStyle(\n'
                '    backgroundColor: WidgetStatePropertyAll(Colors.teal),\n'
                '    foregroundColor: WidgetStatePropertyAll(Colors.white),\n'
                '    padding: WidgetStatePropertyAll(\n'
                '      EdgeInsets.symmetric(horizontal: 20, vertical: 12),\n'
                '    ),\n'
                '  ),\n'
                '  onPressed: () {},\n'
                '  child: Text(\'Stamped\'),\n'
                ')',
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 3: RUBBER-STAMP SHOWCASE
// A grid of "papers" — hoverable/pressable cards whose visual values all come
// from WidgetStatePropertyAll. Live state panel + AnimationController for
// the stamp-press animation.
// ===========================================================================
class _WspaShowcaseTab extends StatefulWidget {
  const _WspaShowcaseTab();

  @override
  State<_WspaShowcaseTab> createState() => _WspaShowcaseTabState();
}

class _WspaShowcaseTabState extends State<_WspaShowcaseTab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _stampCtrl;
  final Set<int> _hovered = <int>{};
  final Set<int> _pressed = <int>{};
  int _activeIndex = -1;

  @override
  void initState() {
    super.initState();
    _stampCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
  }

  @override
  void dispose() {
    _stampCtrl.dispose();
    super.dispose();
  }

  void _onHoverChange(int i, bool hover) {
    setState(() {
      if (hover) {
        _hovered.add(i);
      } else {
        _hovered.remove(i);
      }
    });
  }

  void _onTapDown(int i) {
    setState(() {
      _pressed.add(i);
      _activeIndex = i;
    });
    _stampCtrl.forward(from: 0).then<void>((void _) {
      if (mounted) _stampCtrl.reverse();
    });
  }

  void _onTapCancel(int i) {
    setState(() => _pressed.remove(i));
  }

  void _onTapUp(int i) {
    setState(() => _pressed.remove(i));
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 40),
      children: <Widget>[
        const _WspaPageHeader(
          eyebrow: 'Showcase',
          title: 'Hover. Press. Nothing moves.',
          subtitle:
              'Every visual value on every paper card is wrapped in '
              'WidgetStatePropertyAll — so no matter the state, it stays put. '
              'Side panel shows the live state set for proof.',
          accent: _kInkGreen,
        ),
        const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: LayoutBuilder(
              builder: (BuildContext ctx, BoxConstraints c) {
            final bool wide = c.maxWidth > 760;
            if (wide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(flex: 7, child: _buildGrid(c.maxWidth * 7 / 10 - 14)),
                  const SizedBox(width: 14),
                  Expanded(flex: 3, child: _buildLivePanel()),
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildGrid(c.maxWidth),
                const SizedBox(height: 14),
                _buildLivePanel(),
              ],
            );
          }),
        ),
      ],
    );
  }

  Widget _buildGrid(double width) {
    final int cols = width > 560 ? 3 : (width > 340 ? 2 : 1);
    final double spacing = 12;
    final double cardWidth = (width - (cols - 1) * spacing) / cols;
    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: <Widget>[
        for (int i = 0; i < 9; i++)
          SizedBox(
            width: cardWidth,
            child: _WspaStampCard(
              index: i,
              hovered: _hovered.contains(i),
              pressed: _pressed.contains(i),
              active: _activeIndex == i,
              stampProgress: _activeIndex == i ? _stampCtrl : null,
              onHover: (bool h) => _onHoverChange(i, h),
              onTapDown: () => _onTapDown(i),
              onTapUp: () => _onTapUp(i),
              onTapCancel: () => _onTapCancel(i),
            ),
          ),
      ],
    );
  }

  Widget _buildLivePanel() {
    return _WspaPaperCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Live state observer',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
          ),
          const SizedBox(height: 6),
          const Text(
            'Hover or press any card above. The set<WidgetState> updates here. '
            'The card visuals do not.',
            style: TextStyle(fontSize: 11, color: _kTextMuted, height: 1.4),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kOakDark,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'hovered: ${_hovered.isEmpty ? "{}" : _hovered.join(", ")}',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: _kBrassSoft,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'pressed: ${_pressed.isEmpty ? "{}" : _pressed.join(", ")}',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: _kBrassSoft,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'active: ${_activeIndex < 0 ? "none" : _activeIndex}',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: _kBrassSoft,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kInkGreen.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: _kInkGreen, width: 1),
            ),
            child: const Row(
              children: <Widget>[
                Icon(Icons.check_circle, color: _kInkGreen, size: 16),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'All states resolve to the same value',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: _kInkGreen,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Every card below uses:',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          const _WspaCodeBlock(
            code: 'backgroundColor:\n'
                '  WidgetStatePropertyAll(paper)\n'
                'border:\n'
                '  WidgetStatePropertyAll(edge)\n'
                'textStyle:\n'
                '  WidgetStatePropertyAll(stamp)',
            accent: _kInkGreen,
          ),
        ],
      ),
    );
  }
}

class _WspaStampCard extends StatelessWidget {
  final int index;
  final bool hovered;
  final bool pressed;
  final bool active;
  final Animation<double>? stampProgress;
  final ValueChanged<bool> onHover;
  final VoidCallback onTapDown;
  final VoidCallback onTapUp;
  final VoidCallback onTapCancel;
  const _WspaStampCard({
    required this.index,
    required this.hovered,
    required this.pressed,
    required this.active,
    required this.stampProgress,
    required this.onHover,
    required this.onTapDown,
    required this.onTapUp,
    required this.onTapCancel,
  });

  @override
  Widget build(BuildContext context) {
    // Every visual below is wrapped in WidgetStatePropertyAll. We resolve
    // them with an arbitrary (and differing!) state set to prove they are
    // identical regardless.
    const WidgetStateProperty<Color> paperProp =
        WidgetStatePropertyAll<Color>(_kPaper);
    const WidgetStateProperty<Color> edgeProp =
        WidgetStatePropertyAll<Color>(_kPaperEdge);
    const WidgetStateProperty<TextStyle> stampProp =
        WidgetStatePropertyAll<TextStyle>(
      TextStyle(
        fontFamily: 'monospace',
        fontWeight: FontWeight.w900,
        fontSize: 12,
        color: _kInkRed,
        letterSpacing: 1.2,
      ),
    );

    final Set<WidgetState> provoked = <WidgetState>{
      if (hovered) WidgetState.hovered,
      if (pressed) WidgetState.pressed,
    };
    final Color bg = paperProp.resolve(provoked);
    final Color edge = edgeProp.resolve(provoked);
    final TextStyle stamp = stampProp.resolve(provoked);

    final String docNumber = 'DOC-${(1000 + index).toString()}';
    final String signer = _stampSigners[index % _stampSigners.length];

    return MouseRegion(
      onEnter: (PointerEnterEvent _) => onHover(true),
      onExit: (PointerExitEvent _) => onHover(false),
      child: GestureDetector(
        onTapDown: (TapDownDetails _) => onTapDown(),
        onTapUp: (TapUpDetails _) => onTapUp(),
        onTapCancel: onTapCancel,
        child: Container(
          height: 168,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: edge, width: 1),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: _kShadow,
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        docNumber,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11,
                          color: _kTextMuted,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      _WspaTag(
                        text: hovered
                            ? 'HOVER'
                            : (pressed ? 'PRESS' : 'IDLE'),
                        color: hovered
                            ? _kInkBlue
                            : (pressed ? _kInkRed : _kTextMuted),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(height: 1, color: _kPaperEdge),
                  const SizedBox(height: 10),
                  Text(
                    'Request #$index',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: _kText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Signed by $signer',
                    style: const TextStyle(
                      fontSize: 11,
                      color: _kTextMuted,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _stampDates[index % _stampDates.length],
                            style: const TextStyle(
                              fontSize: 10,
                              color: _kTextMuted,
                              fontFamily: 'monospace',
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'APPROVED',
                            style: stamp,
                          ),
                        ],
                      ),
                      _WspaMiniSeal(progress: active ? stampProgress : null),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const List<String> _stampSigners = <String>[
  'J. Abernathy',
  'M. Cortez',
  'R. Ibsen',
  'T. Okafor',
  'H. Marwick',
  'Y. Choudhury',
  'P. Valenti',
  'N. Brahmani',
  'S. O\'Mara',
];
const List<String> _stampDates = <String>[
  '1987-04-02',
  '1991-11-14',
  '1996-06-30',
  '2001-09-18',
  '2007-03-22',
  '2013-08-09',
  '2018-12-05',
  '2021-02-17',
  '2024-10-01',
];

class _WspaMiniSeal extends StatelessWidget {
  final Animation<double>? progress;
  const _WspaMiniSeal({required this.progress});

  @override
  Widget build(BuildContext context) {
    final Animation<double>? p = progress;
    if (p == null) {
      return const _WspaSealBody(press: 0);
    }
    return AnimatedBuilder(
      animation: p,
      builder: (BuildContext ctx, Widget? child) {
        return _WspaSealBody(press: p.value);
      },
    );
  }
}

class _WspaSealBody extends StatelessWidget {
  final double press;
  const _WspaSealBody({required this.press});

  @override
  Widget build(BuildContext context) {
    final double scale = 1.0 - press * 0.12;
    final double opacity = 0.85 + press * 0.15;
    return Transform.scale(
      scale: scale,
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _kInkRed.withValues(alpha: 0.15),
            border: Border.all(color: _kInkRed, width: 2),
          ),
          alignment: Alignment.center,
          child: const Text(
            'ALL',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: _kInkRed,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}

// ===========================================================================
// SECTION 4: SIDE-BY-SIDE WITH fromMap
// Two buttons — one "All", one stateful. Hover both, compare.
// ===========================================================================
class _WspaVsFromMapTab extends StatefulWidget {
  const _WspaVsFromMapTab();

  @override
  State<_WspaVsFromMapTab> createState() => _WspaVsFromMapTabState();
}

class _WspaVsFromMapTabState extends State<_WspaVsFromMapTab> {
  bool _leftHover = false;
  bool _rightHover = false;
  bool _leftPress = false;
  bool _rightPress = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 40),
      children: <Widget>[
        const _WspaPageHeader(
          eyebrow: 'vs fromMap',
          title: 'One is a stamp. The other reacts.',
          subtitle:
              'Identical layout, identical label — different WidgetStateProperty. '
              'Hover each: only the right reacts to state.',
          accent: _kInkBlue,
        ),
        const SizedBox(height: 14),
        const _WspaSectionHeader(
          text: 'Duel: All vs fromMap',
          icon: Icons.compare,
          color: _kInkBlue,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: LayoutBuilder(
              builder: (BuildContext ctx, BoxConstraints c) {
            final bool wide = c.maxWidth > 620;
            final Widget left = _buildButtonCard(
              title: 'WidgetStatePropertyAll(Colors.teal)',
              subtitle: 'Rubber-stamp: always Colors.teal.',
              accent: _kInkRed,
              reactive: false,
              hover: _leftHover,
              press: _leftPress,
              onHover: (bool h) => setState(() => _leftHover = h),
              onPress: (bool p) => setState(() => _leftPress = p),
            );
            final Widget right = _buildButtonCard(
              title: 'WidgetStateColor.fromMap({...})',
              subtitle:
                  'Reactive: hovered → orange, pressed → brown, default → teal.',
              accent: _kInkGreen,
              reactive: true,
              hover: _rightHover,
              press: _rightPress,
              onHover: (bool h) => setState(() => _rightHover = h),
              onPress: (bool p) => setState(() => _rightPress = p),
            );
            if (wide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(child: left),
                  const SizedBox(width: 14),
                  Expanded(child: right),
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                left,
                const SizedBox(height: 14),
                right,
              ],
            );
          }),
        ),
        const SizedBox(height: 18),
        const _WspaSectionHeader(
          text: 'Narration',
          icon: Icons.record_voice_over,
          color: _kInkBlue,
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: _WspaNarrationCard(),
        ),
        const SizedBox(height: 22),
      ],
    );
  }

  Widget _buildButtonCard({
    required String title,
    required String subtitle,
    required Color accent,
    required bool reactive,
    required bool hover,
    required bool press,
    required ValueChanged<bool> onHover,
    required ValueChanged<bool> onPress,
  }) {
    final Set<WidgetState> states = <WidgetState>{
      if (hover) WidgetState.hovered,
      if (press) WidgetState.pressed,
    };

    // Left button color: WidgetStatePropertyAll — constant teal.
    // Right button color: WidgetStateColor.fromMap — reacts.
    final WidgetStateProperty<Color> bg = reactive
        ? WidgetStateColor.fromMap(const <WidgetStatesConstraint, Color>{
            WidgetState.pressed: Color(0xFF8B5E34),
            WidgetState.hovered: Color(0xFFD97706),
            WidgetState.any: Color(0xFF0F766E),
          })
        : const WidgetStatePropertyAll<Color>(Color(0xFF0F766E));
    final Color resolved = bg.resolve(states);

    return _WspaPaperCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                reactive ? Icons.change_circle : Icons.lock,
                color: accent,
                size: 18,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w800,
                    fontSize: 11.5,
                    color: _kText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 11, color: _kTextMuted),
          ),
          const SizedBox(height: 14),
          MouseRegion(
            onEnter: (PointerEnterEvent _) => onHover(true),
            onExit: (PointerExitEvent _) => onHover(false),
            child: GestureDetector(
              onTapDown: (TapDownDetails _) => onPress(true),
              onTapUp: (TapUpDetails _) => onPress(false),
              onTapCancel: () => onPress(false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color: resolved,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: _kShadow,
                      offset: Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Hover / Press me',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _kOakDark,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(
              'states: ${states.isEmpty ? "{}" : states.map((WidgetState s) => s.name).join(", ")}\n'
              'resolved: 0x${resolved.toARGB32().toRadixString(16).padLeft(8, "0").toUpperCase()}',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
                color: _kBrassSoft,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WspaNarrationCard extends StatelessWidget {
  const _WspaNarrationCard();

  @override
  Widget build(BuildContext context) {
    return _WspaPaperCard(
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _WspaNarrationBullet(
            icon: Icons.looks_one,
            text: 'Both accept the same ButtonStyle.backgroundColor slot type '
                '(WidgetStateProperty<Color>).',
          ),
          _WspaNarrationBullet(
            icon: Icons.looks_two,
            text: 'The left one hands back the same teal from resolve() no matter '
                'what states the framework passes in.',
          ),
          _WspaNarrationBullet(
            icon: Icons.looks_3,
            text: 'The right one inspects the state set and picks orange for hover, '
                'brown for press, teal otherwise.',
          ),
          _WspaNarrationBullet(
            icon: Icons.looks_4,
            text: 'Choose All when the value is genuinely constant; choose fromMap '
                'or resolveWith when state matters.',
          ),
          _WspaNarrationBullet(
            icon: Icons.looks_5,
            text: 'Mixing them in a single ButtonStyle is fine — different slots can '
                'have different WidgetStateProperty strategies.',
          ),
        ],
      ),
    );
  }
}

class _WspaNarrationBullet extends StatelessWidget {
  final IconData icon;
  final String text;
  const _WspaNarrationBullet({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, size: 18, color: _kInkBlue),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 12, color: _kText, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 5: TYPED GALLERY
// Cards for <Color>, <TextStyle>, <EdgeInsets>, <double>, <OutlinedBorder>,
// <BorderSide>.
// ===========================================================================
class _WspaTypedGalleryTab extends StatelessWidget {
  const _WspaTypedGalleryTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 40),
      children: const <Widget>[
        _WspaPageHeader(
          eyebrow: 'Typed Gallery',
          title: 'Same pattern, six different T',
          subtitle:
              'WidgetStatePropertyAll is generic. Below is a gallery of the most '
              'common instantiations, each rendered in a useful visual.',
          accent: _kBrassDark,
        ),
        SizedBox(height: 14),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: _WspaTypedGalleryGrid(),
        ),
        SizedBox(height: 22),
      ],
    );
  }
}

class _WspaTypedGalleryGrid extends StatelessWidget {
  const _WspaTypedGalleryGrid();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints c) {
      final bool wide = c.maxWidth > 820;
      final int cols = wide ? 3 : (c.maxWidth > 540 ? 2 : 1);
      final double spacing = 14;
      final double cardWidth = (c.maxWidth - (cols - 1) * spacing) / cols;
      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: <Widget>[
          SizedBox(
            width: cardWidth,
            child: const _WspaTypeCardColor(),
          ),
          SizedBox(
            width: cardWidth,
            child: const _WspaTypeCardTextStyle(),
          ),
          SizedBox(
            width: cardWidth,
            child: const _WspaTypeCardEdgeInsets(),
          ),
          SizedBox(
            width: cardWidth,
            child: const _WspaTypeCardDouble(),
          ),
          SizedBox(
            width: cardWidth,
            child: const _WspaTypeCardOutlinedBorder(),
          ),
          SizedBox(
            width: cardWidth,
            child: const _WspaTypeCardBorderSide(),
          ),
        ],
      );
    });
  }
}

class _WspaTypeCardShell extends StatelessWidget {
  final String title;
  final String code;
  final Color accent;
  final Widget visual;
  const _WspaTypeCardShell({
    required this.title,
    required this.code,
    required this.accent,
    required this.visual,
  });

  @override
  Widget build(BuildContext context) {
    return _WspaPaperCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8,
                height: 20,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: _kText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _kPaperShade,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: _kPaperEdge, width: 0.8),
            ),
            child: visual,
          ),
          const SizedBox(height: 10),
          _WspaCodeBlock(code: code, accent: accent),
        ],
      ),
    );
  }
}

class _WspaTypeCardColor extends StatelessWidget {
  const _WspaTypeCardColor();

  @override
  Widget build(BuildContext context) {
    const WidgetStateProperty<Color> prop =
        WidgetStatePropertyAll<Color>(_kInkRed);
    final Color color = prop.resolve(const <WidgetState>{});
    return _WspaTypeCardShell(
      title: 'WidgetStatePropertyAll<Color>',
      code: 'WidgetStatePropertyAll<Color>(_kInkRed)',
      accent: _kInkRed,
      visual: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: _kShadow,
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: const Text(
          'INK',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}

class _WspaTypeCardTextStyle extends StatelessWidget {
  const _WspaTypeCardTextStyle();

  @override
  Widget build(BuildContext context) {
    const WidgetStateProperty<TextStyle> prop =
        WidgetStatePropertyAll<TextStyle>(
      TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w900,
        color: _kInkBlue,
        letterSpacing: 1.8,
        fontStyle: FontStyle.italic,
      ),
    );
    final TextStyle style = prop.resolve(const <WidgetState>{});
    return _WspaTypeCardShell(
      title: 'WidgetStatePropertyAll<TextStyle>',
      code: 'WidgetStatePropertyAll<TextStyle>(\n'
          '  TextStyle(fontSize: 20, color: blue),\n'
          ')',
      accent: _kInkBlue,
      visual: Text('CERTIFIED', style: style),
    );
  }
}

class _WspaTypeCardEdgeInsets extends StatelessWidget {
  const _WspaTypeCardEdgeInsets();

  @override
  Widget build(BuildContext context) {
    const WidgetStateProperty<EdgeInsets> prop =
        WidgetStatePropertyAll<EdgeInsets>(
      EdgeInsets.symmetric(horizontal: 22, vertical: 10),
    );
    final EdgeInsets pad = prop.resolve(const <WidgetState>{});
    return _WspaTypeCardShell(
      title: 'WidgetStatePropertyAll<EdgeInsets>',
      code: 'WidgetStatePropertyAll<EdgeInsets>(\n'
          '  EdgeInsets.symmetric(h:22,v:10),\n'
          ')',
      accent: _kInkGreen,
      visual: Container(
        padding: pad,
        decoration: BoxDecoration(
          color: _kInkGreen,
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Text(
          'PADDED',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.6,
          ),
        ),
      ),
    );
  }
}

class _WspaTypeCardDouble extends StatelessWidget {
  const _WspaTypeCardDouble();

  @override
  Widget build(BuildContext context) {
    const WidgetStateProperty<double> prop =
        WidgetStatePropertyAll<double>(6.0);
    final double elev = prop.resolve(const <WidgetState>{});
    return _WspaTypeCardShell(
      title: 'WidgetStatePropertyAll<double>',
      code: 'WidgetStatePropertyAll<double>(6.0)\n'
          '// elevation always 6.0',
      accent: _kBrassDark,
      visual: Material(
        elevation: elev,
        color: _kBrass,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          width: 110,
          height: 48,
          alignment: Alignment.center,
          child: Text(
            'elev: ${elev.toStringAsFixed(1)}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ),
    );
  }
}

class _WspaTypeCardOutlinedBorder extends StatelessWidget {
  const _WspaTypeCardOutlinedBorder();

  @override
  Widget build(BuildContext context) {
    const WidgetStateProperty<OutlinedBorder> prop =
        WidgetStatePropertyAll<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
    );
    final OutlinedBorder shape = prop.resolve(const <WidgetState>{});
    return _WspaTypeCardShell(
      title: 'WidgetStatePropertyAll<OutlinedBorder>',
      code: 'WidgetStatePropertyAll<OutlinedBorder>(\n'
          '  RoundedRectangleBorder(r:14),\n'
          ')',
      accent: _kSeal,
      visual: Container(
        width: 110,
        height: 60,
        decoration: ShapeDecoration(
          color: _kSeal,
          shape: shape,
          shadows: const <BoxShadow>[
            BoxShadow(
              color: _kShadow,
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: const Text(
          'SHAPE',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.6,
          ),
        ),
      ),
    );
  }
}

class _WspaTypeCardBorderSide extends StatelessWidget {
  const _WspaTypeCardBorderSide();

  @override
  Widget build(BuildContext context) {
    const WidgetStateProperty<BorderSide> prop =
        WidgetStatePropertyAll<BorderSide>(
      BorderSide(color: _kInkRed, width: 3, style: BorderStyle.solid),
    );
    final BorderSide side = prop.resolve(const <WidgetState>{});
    return _WspaTypeCardShell(
      title: 'WidgetStatePropertyAll<BorderSide>',
      code: 'WidgetStatePropertyAll<BorderSide>(\n'
          '  BorderSide(color: red, width: 3),\n'
          ')',
      accent: _kInkRed,
      visual: Container(
        width: 110,
        height: 60,
        decoration: BoxDecoration(
          color: _kPaper,
          border: Border.all(
            color: side.color,
            width: side.width,
            style: side.style,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        alignment: Alignment.center,
        child: Text(
          'w:${side.width.toStringAsFixed(0)}',
          style: const TextStyle(
            color: _kText,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
          ),
        ),
      ),
    );
  }
}

// ===========================================================================
// SECTION 6: BUTTON THEME GALLERY
// Four Material button flavors — each styled with WidgetStatePropertyAll.
// An AnimationController drives a reactive hover indicator underneath,
// providing a cute contrast: the buttons stay still, the indicator moves.
// ===========================================================================
class _WspaButtonGalleryTab extends StatefulWidget {
  const _WspaButtonGalleryTab();

  @override
  State<_WspaButtonGalleryTab> createState() => _WspaButtonGalleryTabState();
}

class _WspaButtonGalleryTabState extends State<_WspaButtonGalleryTab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _indicatorCtrl;
  int _hoverButton = -1;

  @override
  void initState() {
    super.initState();
    _indicatorCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: 0,
    );
  }

  @override
  void dispose() {
    _indicatorCtrl.dispose();
    super.dispose();
  }

  void _onHoverButton(int i, bool on) {
    setState(() {
      if (on) {
        _hoverButton = i;
        _indicatorCtrl.forward();
      } else if (_hoverButton == i) {
        _hoverButton = -1;
        _indicatorCtrl.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<_WspaButtonSpec> specs = <_WspaButtonSpec>[
      _WspaButtonSpec(
        label: 'FilledButton',
        color: _kInkRed,
        kind: _WspaButtonKind.filled,
      ),
      _WspaButtonSpec(
        label: 'ElevatedButton',
        color: _kInkBlue,
        kind: _WspaButtonKind.elevated,
      ),
      _WspaButtonSpec(
        label: 'OutlinedButton',
        color: _kInkGreen,
        kind: _WspaButtonKind.outlined,
      ),
      _WspaButtonSpec(
        label: 'TextButton',
        color: _kSeal,
        kind: _WspaButtonKind.text,
      ),
    ];
    return ListView(
      padding: const EdgeInsets.only(bottom: 40),
      children: <Widget>[
        const _WspaPageHeader(
          eyebrow: 'Buttons',
          title: 'Four flavors, one stamp',
          subtitle:
              'FilledButton, ElevatedButton, OutlinedButton, TextButton — each '
              'styled entirely with WidgetStatePropertyAll values. Hover a button: '
              'a separate indicator animates, but the button itself holds still.',
          accent: _kInkRed,
        ),
        const SizedBox(height: 14),
        const _WspaSectionHeader(
          text: 'Gallery',
          icon: Icons.grid_view,
          color: _kInkRed,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: LayoutBuilder(
              builder: (BuildContext ctx, BoxConstraints c) {
            final int cols = c.maxWidth > 700 ? 4 : (c.maxWidth > 480 ? 2 : 1);
            final double spacing = 12;
            final double cardWidth =
                (c.maxWidth - (cols - 1) * spacing) / cols;
            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: <Widget>[
                for (int i = 0; i < specs.length; i++)
                  SizedBox(
                    width: cardWidth,
                    child: _WspaButtonGalleryCard(
                      spec: specs[i],
                      index: i,
                      isHovered: _hoverButton == i,
                      indicator: _indicatorCtrl,
                      onHover: (bool h) => _onHoverButton(i, h),
                    ),
                  ),
              ],
            );
          }),
        ),
        const SizedBox(height: 18),
        const _WspaSectionHeader(
          text: 'Why the indicator moves but the button doesn\'t',
          icon: Icons.info_outline,
          color: _kInkRed,
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: _WspaButtonExplainCard(),
        ),
        const SizedBox(height: 22),
      ],
    );
  }
}

enum _WspaButtonKind { filled, elevated, outlined, text }

class _WspaButtonSpec {
  final String label;
  final Color color;
  final _WspaButtonKind kind;
  const _WspaButtonSpec({
    required this.label,
    required this.color,
    required this.kind,
  });
}

class _WspaButtonGalleryCard extends StatelessWidget {
  final _WspaButtonSpec spec;
  final int index;
  final bool isHovered;
  final Animation<double> indicator;
  final ValueChanged<bool> onHover;
  const _WspaButtonGalleryCard({
    required this.spec,
    required this.index,
    required this.isHovered,
    required this.indicator,
    required this.onHover,
  });

  ButtonStyle _buildStyle() {
    // Every single slot is WidgetStatePropertyAll — not state-sensitive.
    switch (spec.kind) {
      case _WspaButtonKind.filled:
        return ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(spec.color),
          foregroundColor: const WidgetStatePropertyAll<Color>(Colors.white),
          padding: const WidgetStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          ),
          textStyle: const WidgetStatePropertyAll<TextStyle>(
            TextStyle(fontWeight: FontWeight.w800, letterSpacing: 0.4),
          ),
          shape: const WidgetStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        );
      case _WspaButtonKind.elevated:
        return ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(spec.color),
          foregroundColor: const WidgetStatePropertyAll<Color>(Colors.white),
          elevation: const WidgetStatePropertyAll<double>(4),
          padding: const WidgetStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          ),
          shape: const WidgetStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        );
      case _WspaButtonKind.outlined:
        return ButtonStyle(
          foregroundColor: WidgetStatePropertyAll<Color>(spec.color),
          side: WidgetStatePropertyAll<BorderSide>(
            BorderSide(color: spec.color, width: 2),
          ),
          padding: const WidgetStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          ),
          shape: const WidgetStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        );
      case _WspaButtonKind.text:
        return ButtonStyle(
          foregroundColor: WidgetStatePropertyAll<Color>(spec.color),
          padding: const WidgetStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          ),
          textStyle: const WidgetStatePropertyAll<TextStyle>(
            TextStyle(fontWeight: FontWeight.w800, letterSpacing: 0.4),
          ),
        );
    }
  }

  Widget _buildButton() {
    final ButtonStyle style = _buildStyle();
    switch (spec.kind) {
      case _WspaButtonKind.filled:
        return FilledButton(
          style: style,
          onPressed: () {},
          child: const Text('STAMP'),
        );
      case _WspaButtonKind.elevated:
        return ElevatedButton(
          style: style,
          onPressed: () {},
          child: const Text('STAMP'),
        );
      case _WspaButtonKind.outlined:
        return OutlinedButton(
          style: style,
          onPressed: () {},
          child: const Text('STAMP'),
        );
      case _WspaButtonKind.text:
        return TextButton(
          style: style,
          onPressed: () {},
          child: const Text('STAMP'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _WspaPaperCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10,
                height: 18,
                decoration: BoxDecoration(
                  color: spec.color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  spec.label,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: _kText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          MouseRegion(
            onEnter: (PointerEnterEvent _) => onHover(true),
            onExit: (PointerExitEvent _) => onHover(false),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildButton(),
                const SizedBox(height: 8),
                // The hover indicator — this reacts (animates) while the
                // button above uses only WidgetStatePropertyAll and doesn't.
                SizedBox(
                  height: 6,
                  child: AnimatedBuilder(
                    animation: indicator,
                    builder: (BuildContext ctx, Widget? child) {
                      final double v = isHovered ? indicator.value : 0;
                      return Container(
                        width: 44 + v * 100,
                        height: 4,
                        decoration: BoxDecoration(
                          color: spec.color
                              .withValues(alpha: 0.35 + v * 0.55),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'All ButtonStyle slots: WidgetStatePropertyAll',
            style: TextStyle(
              fontSize: 10.5,
              color: spec.color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _WspaButtonExplainCard extends StatelessWidget {
  const _WspaButtonExplainCard();

  @override
  Widget build(BuildContext context) {
    return _WspaPaperCard(
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'The button uses a ButtonStyle where every WidgetStateProperty slot is '
            'a WidgetStatePropertyAll. When the framework asks resolve(hovered), '
            'resolve(pressed), or resolve(disabled), the answer is always the same: '
            'the stored value. So the button\'s paint is literally identical between '
            'states.',
            style: TextStyle(fontSize: 12, color: _kText, height: 1.45),
          ),
          SizedBox(height: 10),
          Text(
            'The little bar underneath is a separate widget with its own state, its '
            'own AnimationController, and its own width/alpha computation. That is '
            'where the visual feedback lives — by design, not by accident.',
            style: TextStyle(fontSize: 12, color: _kText, height: 1.45),
          ),
          SizedBox(height: 10),
          Text(
            'Takeaway: if you want reactive button styling, do not rely on '
            'WidgetStatePropertyAll. Swap it for resolveWith or fromMap on the '
            'slots that should change.',
            style: TextStyle(
              fontSize: 12,
              color: _kInkRed,
              fontWeight: FontWeight.w700,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 7: MIXED STYLING
// A card where backgroundColor is reactive (resolveWith) but foregroundColor
// is always white via WidgetStatePropertyAll. Both coexist.
// ===========================================================================
class _WspaMixedStylingTab extends StatefulWidget {
  const _WspaMixedStylingTab();

  @override
  State<_WspaMixedStylingTab> createState() => _WspaMixedStylingTabState();
}

class _WspaMixedStylingTabState extends State<_WspaMixedStylingTab> {
  bool _hover = false;
  bool _press = false;

  @override
  Widget build(BuildContext context) {
    final Set<WidgetState> states = <WidgetState>{
      if (_hover) WidgetState.hovered,
      if (_press) WidgetState.pressed,
    };

    final WidgetStateProperty<Color> bg =
        WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> s) {
        if (s.contains(WidgetState.pressed)) return _kInkRed;
        if (s.contains(WidgetState.hovered)) return _kInkBlue;
        return _kInkGreen;
      },
    );
    const WidgetStateProperty<Color> fg =
        WidgetStatePropertyAll<Color>(Colors.white);

    final Color resolvedBg = bg.resolve(states);
    final Color resolvedFg = fg.resolve(states);

    return ListView(
      padding: const EdgeInsets.only(bottom: 40),
      children: <Widget>[
        const _WspaPageHeader(
          eyebrow: 'Mixed styling',
          title: 'All and stateful, side by side',
          subtitle:
              'A single ButtonStyle can freely mix WidgetStatePropertyAll and '
              'reactive WidgetStateProperty implementations. Different slots — '
              'different strategies.',
          accent: _kInkGreen,
        ),
        const SizedBox(height: 14),
        const _WspaSectionHeader(
          text: 'Demo',
          icon: Icons.color_lens,
          color: _kInkGreen,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: _WspaPaperCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'backgroundColor reacts to state; foregroundColor is always white.',
                  style: TextStyle(fontSize: 12, color: _kText),
                ),
                const SizedBox(height: 14),
                Center(
                  child: MouseRegion(
                    onEnter: (PointerEnterEvent _) =>
                        setState(() => _hover = true),
                    onExit: (PointerExitEvent _) =>
                        setState(() => _hover = false),
                    child: GestureDetector(
                      onTapDown: (TapDownDetails _) =>
                          setState(() => _press = true),
                      onTapUp: (TapUpDetails _) =>
                          setState(() => _press = false),
                      onTapCancel: () => setState(() => _press = false),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        width: 240,
                        height: 64,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: resolvedBg,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: _kShadow,
                              offset: Offset(0, 2),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Text(
                          _hover
                              ? (_press ? 'PRESSED' : 'HOVERED')
                              : 'IDLE',
                          style: TextStyle(
                            color: resolvedFg,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                const _WspaCodeBlock(
                  code: 'ButtonStyle(\n'
                      '  backgroundColor: WidgetStateProperty.resolveWith(\n'
                      '    (states) {\n'
                      '      if (states.contains(WidgetState.pressed)) return red;\n'
                      '      if (states.contains(WidgetState.hovered)) return blue;\n'
                      '      return green;\n'
                      '    },\n'
                      '  ),\n'
                      '  foregroundColor: WidgetStatePropertyAll(Colors.white),\n'
                      ')',
                  accent: _kInkGreen,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),
        const _WspaSectionHeader(
          text: 'Key insight',
          icon: Icons.lightbulb_outline,
          color: _kInkGreen,
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: _WspaPaperCard(
            child: Text(
              'WidgetStatePropertyAll is not an "either/or" decision for the whole '
              'ButtonStyle — it is per-slot. Ask for each property separately: '
              '"should this value depend on interaction?" If no, use '
              'WidgetStatePropertyAll. If yes, use resolveWith or fromMap. Mix and '
              'match freely.',
              style: TextStyle(fontSize: 12, color: _kText, height: 1.45),
            ),
          ),
        ),
        const SizedBox(height: 22),
      ],
    );
  }
}

// ===========================================================================
// SECTION 8: WHEN NOT TO USE
// Demonstrate the failure mode: using PropertyAll when state sensitivity is
// desired, vs. the fix.
// ===========================================================================
class _WspaWhenNotToUseTab extends StatefulWidget {
  const _WspaWhenNotToUseTab();

  @override
  State<_WspaWhenNotToUseTab> createState() => _WspaWhenNotToUseTabState();
}

class _WspaWhenNotToUseTabState extends State<_WspaWhenNotToUseTab> {
  bool _beforeHover = false;
  bool _afterHover = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 40),
      children: <Widget>[
        const _WspaPageHeader(
          eyebrow: 'Not-to-use',
          title: 'When PropertyAll is the wrong stamp',
          subtitle:
              'If you actually want state-aware visuals, PropertyAll is a bug '
              'magnet. Here is the failure, and here is the fix.',
          accent: _kSeal,
        ),
        const SizedBox(height: 14),
        const _WspaSectionHeader(
          text: 'Before / After',
          icon: Icons.warning_amber,
          color: _kSeal,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: LayoutBuilder(
              builder: (BuildContext ctx, BoxConstraints c) {
            final bool wide = c.maxWidth > 620;
            final Widget before = _WspaBrokenCard(
              hover: _beforeHover,
              onHover: (bool h) => setState(() => _beforeHover = h),
            );
            final Widget after = _WspaFixedCard(
              hover: _afterHover,
              onHover: (bool h) => setState(() => _afterHover = h),
            );
            if (wide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(child: before),
                  const SizedBox(width: 14),
                  Expanded(child: after),
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                before,
                const SizedBox(height: 14),
                after,
              ],
            );
          }),
        ),
        const SizedBox(height: 22),
      ],
    );
  }
}

class _WspaBrokenCard extends StatelessWidget {
  final bool hover;
  final ValueChanged<bool> onHover;
  const _WspaBrokenCard({required this.hover, required this.onHover});

  @override
  Widget build(BuildContext context) {
    // Developer *wanted* hover feedback, but used PropertyAll. Bug.
    const WidgetStateProperty<Color> bg =
        WidgetStatePropertyAll<Color>(_kInkBlue);
    final Set<WidgetState> states = <WidgetState>{
      if (hover) WidgetState.hovered,
    };
    final Color resolved = bg.resolve(states);
    return _WspaPaperCard(
      paperColor: _kInkRedSoft.withValues(alpha: 0.18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.close, color: _kSeal, size: 18),
              SizedBox(width: 6),
              Text(
                'BEFORE — broken',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: _kSeal,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Intent: hover should lighten the button. Implementation: '
            'PropertyAll. Result: nothing moves.',
            style: TextStyle(fontSize: 11, color: _kText),
          ),
          const SizedBox(height: 12),
          MouseRegion(
            onEnter: (PointerEnterEvent _) => onHover(true),
            onExit: (PointerExitEvent _) => onHover(false),
            child: Container(
              width: double.infinity,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: resolved,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'Hover me',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const _WspaCodeBlock(
            code: 'backgroundColor:\n'
                '  WidgetStatePropertyAll(blue) // wrong choice',
            accent: _kSeal,
          ),
        ],
      ),
    );
  }
}

class _WspaFixedCard extends StatelessWidget {
  final bool hover;
  final ValueChanged<bool> onHover;
  const _WspaFixedCard({required this.hover, required this.onHover});

  @override
  Widget build(BuildContext context) {
    final WidgetStateProperty<Color> bg =
        WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> s) =>
          s.contains(WidgetState.hovered) ? _kInkBlueSoft : _kInkBlue,
    );
    final Set<WidgetState> states = <WidgetState>{
      if (hover) WidgetState.hovered,
    };
    final Color resolved = bg.resolve(states);
    return _WspaPaperCard(
      paperColor: _kInkGreenSoft.withValues(alpha: 0.22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.check, color: _kInkGreen, size: 18),
              SizedBox(width: 6),
              Text(
                'AFTER — fixed',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: _kInkGreen,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Intent: hover should lighten. Implementation: resolveWith. '
            'Result: the color reacts.',
            style: TextStyle(fontSize: 11, color: _kText),
          ),
          const SizedBox(height: 12),
          MouseRegion(
            onEnter: (PointerEnterEvent _) => onHover(true),
            onExit: (PointerExitEvent _) => onHover(false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: double.infinity,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: resolved,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'Hover me',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const _WspaCodeBlock(
            code: 'backgroundColor:\n'
                '  WidgetStateProperty.resolveWith(\n'
                '    (s) => s.contains(hovered) ? soft : base,\n'
                '  )',
            accent: _kInkGreen,
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 9: RECIPES
// Five+ small recipe cards showing common PropertyAll uses.
// ===========================================================================
class _WspaRecipesTab extends StatelessWidget {
  const _WspaRecipesTab();

  @override
  Widget build(BuildContext context) {
    const List<_WspaRecipe> recipes = <_WspaRecipe>[
      _WspaRecipe(
        title: 'Constant text color',
        summary:
            'Brand-color label that should never vary with interaction state.',
        code: 'foregroundColor: WidgetStatePropertyAll(Color(0xFFB2292E))',
        icon: Icons.format_color_text,
        color: _kInkRed,
      ),
      _WspaRecipe(
        title: 'Stable padding',
        summary:
            'Hit-target padding is usually fixed. No reason to recompute on hover.',
        code: 'padding: WidgetStatePropertyAll(\n'
            '  EdgeInsets.symmetric(horizontal: 20, vertical: 12),\n'
            ')',
        icon: Icons.space_bar,
        color: _kInkBlue,
      ),
      _WspaRecipe(
        title: 'Always-rounded shape',
        summary:
            'Brand guideline: every button corners are 12. One stamp for all.',
        code: 'shape: WidgetStatePropertyAll(\n'
            '  RoundedRectangleBorder(\n'
            '    borderRadius: BorderRadius.circular(12),\n'
            '  ),\n'
            ')',
        icon: Icons.rounded_corner,
        color: _kInkGreen,
      ),
      _WspaRecipe(
        title: 'Forced uppercase textStyle',
        summary:
            'A TextStyle with letterSpacing and weight wrapped so all buttons read the same.',
        code: 'textStyle: WidgetStatePropertyAll(\n'
            '  TextStyle(\n'
            '    fontWeight: FontWeight.w900,\n'
            '    letterSpacing: 1.2,\n'
            '  ),\n'
            ')',
        icon: Icons.text_format,
        color: _kBrassDark,
      ),
      _WspaRecipe(
        title: 'Consistent icon size',
        summary:
            'IconButton theme where size never changes with pressed/hover/etc.',
        code: 'iconSize: WidgetStatePropertyAll<double>(22)',
        icon: Icons.photo_size_select_small,
        color: _kSeal,
      ),
      _WspaRecipe(
        title: 'Fixed minimum size',
        summary:
            'Buttons must be at least 48 high regardless of state (for a11y).',
        code: 'minimumSize: WidgetStatePropertyAll<Size>(Size(88, 48))',
        icon: Icons.height,
        color: _kOakDark,
      ),
      _WspaRecipe(
        title: 'Non-reactive elevation',
        summary:
            'Every state, same drop shadow. The card does not pop when hovered.',
        code: 'elevation: WidgetStatePropertyAll<double>(3)',
        icon: Icons.layers,
        color: _kInkRed,
      ),
    ];
    return ListView(
      padding: const EdgeInsets.only(bottom: 40),
      children: <Widget>[
        const _WspaPageHeader(
          eyebrow: 'Recipes',
          title: 'Copy-paste stamps',
          subtitle:
              'A small pantry of WidgetStatePropertyAll recipes — the kind of '
              'one-liner you write repeatedly across a codebase.',
          accent: _kBrassDark,
        ),
        const SizedBox(height: 14),
        const _WspaSectionHeader(
          text: 'Pantry',
          icon: Icons.kitchen,
          color: _kBrassDark,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: LayoutBuilder(
              builder: (BuildContext ctx, BoxConstraints c) {
            final int cols = c.maxWidth > 760 ? 2 : 1;
            final double spacing = 12;
            final double cardWidth =
                (c.maxWidth - (cols - 1) * spacing) / cols;
            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: <Widget>[
                for (final _WspaRecipe r in recipes)
                  SizedBox(
                    width: cardWidth,
                    child: _WspaRecipeCard(recipe: r),
                  ),
              ],
            );
          }),
        ),
        const SizedBox(height: 22),
      ],
    );
  }
}

class _WspaRecipe {
  final String title;
  final String summary;
  final String code;
  final IconData icon;
  final Color color;
  const _WspaRecipe({
    required this.title,
    required this.summary,
    required this.code,
    required this.icon,
    required this.color,
  });
}

class _WspaRecipeCard extends StatelessWidget {
  final _WspaRecipe recipe;
  const _WspaRecipeCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return _WspaPaperCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: recipe.color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                  border: Border.all(color: recipe.color, width: 1.2),
                ),
                child: Icon(recipe.icon, color: recipe.color, size: 14),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  recipe.title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: _kText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            recipe.summary,
            style: const TextStyle(
              fontSize: 11.5,
              color: _kTextMuted,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          _WspaCodeBlock(code: recipe.code, accent: recipe.color),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 10: COMPARISON TABLE
// WidgetStatePropertyAll vs .all static vs resolveWith(_=>v) vs fromMap(any:v)
// ===========================================================================
class _WspaComparisonTab extends StatelessWidget {
  const _WspaComparisonTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 40),
      children: const <Widget>[
        _WspaPageHeader(
          eyebrow: 'Comparison',
          title: 'Four ways to say "always this value"',
          subtitle:
              'They are not all equivalent — they differ in terseness, '
              'allocation, const-ability, and deprecation status.',
          accent: _kOakDark,
        ),
        SizedBox(height: 14),
        _WspaSectionHeader(
          text: 'Side-by-side',
          icon: Icons.table_chart,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: _WspaComparisonTable(),
        ),
        SizedBox(height: 18),
        _WspaSectionHeader(
          text: 'Takeaway',
          icon: Icons.flag_outlined,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: _WspaComparisonTakeaway(),
        ),
        SizedBox(height: 22),
      ],
    );
  }
}

class _WspaComparisonTable extends StatelessWidget {
  const _WspaComparisonTable();

  @override
  Widget build(BuildContext context) {
    const List<List<String>> rows = <List<String>>[
      <String>[
        'WidgetStatePropertyAll<T>(v)',
        'const',
        'trivial',
        'current',
        'The recommended form.',
      ],
      <String>[
        'WidgetStateProperty.all<T>(v)',
        'no',
        'trivial',
        'deprecated in some versions — use PropertyAll',
        'Older static factory. Usually a linter suggests the new form.',
      ],
      <String>[
        'WidgetStateProperty.resolveWith((_) => v)',
        'no',
        'closure allocation',
        'current',
        'Functionally identical, but heavier. Use if you already have a callback.',
      ],
      <String>[
        'WidgetStateColor.fromMap({WidgetState.any: v})',
        'no',
        'map allocation',
        'current (Color-specific)',
        'Works but overkill. Only makes sense if other entries matter.',
      ],
    ];
    return _WspaPaperCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: <Widget>[
          Container(
            color: _kOakDark,
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: const <Widget>[
                Expanded(
                  flex: 4,
                  child: Text(
                    'Form',
                    style: TextStyle(
                      color: _kPaper,
                      fontWeight: FontWeight.w800,
                      fontSize: 11.5,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'const?',
                    style: TextStyle(
                      color: _kPaper,
                      fontWeight: FontWeight.w800,
                      fontSize: 11.5,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'cost',
                    style: TextStyle(
                      color: _kPaper,
                      fontWeight: FontWeight.w800,
                      fontSize: 11.5,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'status',
                    style: TextStyle(
                      color: _kPaper,
                      fontWeight: FontWeight.w800,
                      fontSize: 11.5,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    'notes',
                    style: TextStyle(
                      color: _kPaper,
                      fontWeight: FontWeight.w800,
                      fontSize: 11.5,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
          for (int i = 0; i < rows.length; i++)
            Container(
              decoration: BoxDecoration(
                color: i.isEven ? _kPaper : _kPaperShade,
                border: const Border(
                  bottom: BorderSide(color: _kPaperEdge, width: 0.6),
                ),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Text(
                      rows[i][0],
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: _kText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      rows[i][1],
                      style: const TextStyle(fontSize: 11, color: _kText),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      rows[i][2],
                      style: const TextStyle(fontSize: 11, color: _kText),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      rows[i][3],
                      style: const TextStyle(fontSize: 11, color: _kText),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      rows[i][4],
                      style: const TextStyle(
                        fontSize: 11,
                        color: _kTextMuted,
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

class _WspaComparisonTakeaway extends StatelessWidget {
  const _WspaComparisonTakeaway();

  @override
  Widget build(BuildContext context) {
    return _WspaPaperCard(
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Pick WidgetStatePropertyAll when you want to express "always this '
            'value" in the most direct way: a const constructor, a single final '
            'field, and a resolve that returns it. The other three forms exist '
            'for historical or specific reasons — they are not wrong, but they '
            'rarely spark joy.',
            style: TextStyle(fontSize: 12, color: _kText, height: 1.45),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 11: GLOSSARY / EPILOGUE
// ===========================================================================
class _WspaGlossaryTab extends StatelessWidget {
  const _WspaGlossaryTab();

  @override
  Widget build(BuildContext context) {
    const List<_WspaGlossaryTerm> terms = <_WspaGlossaryTerm>[
      _WspaGlossaryTerm(
        term: 'WidgetStateProperty<T>',
        definition:
            'Abstract interface with T resolve(Set<WidgetState> states). The root '
            'of the family.',
      ),
      _WspaGlossaryTerm(
        term: 'WidgetStatePropertyAll<T>',
        definition:
            'Concrete implementation whose resolve always returns the stored value.',
      ),
      _WspaGlossaryTerm(
        term: 'WidgetState',
        definition:
            'Enum of interaction states: hovered, pressed, focused, selected, '
            'disabled, dragged, scrolledUnder, error.',
      ),
      _WspaGlossaryTerm(
        term: 'WidgetStatesConstraint',
        definition:
            'Logical constraint over a state set, used as the key in fromMap.',
      ),
      _WspaGlossaryTerm(
        term: 'WidgetStateColor.fromMap',
        definition:
            'Color-typed property that picks the first matching entry from an '
            'ordered map of (constraint -> color).',
      ),
      _WspaGlossaryTerm(
        term: 'resolveWith',
        definition:
            'Factory that wraps a (Set<WidgetState>) => T function as a property.',
      ),
      _WspaGlossaryTerm(
        term: 'MaterialStatePropertyAll',
        definition:
            'Older name for the same concept. Replaced by WidgetStatePropertyAll.',
      ),
      _WspaGlossaryTerm(
        term: 'ButtonStyle',
        definition:
            'A bundle of WidgetStateProperty slots controlling a Material button\'s '
            'visual styling.',
      ),
    ];
    return ListView(
      padding: const EdgeInsets.only(bottom: 40),
      children: <Widget>[
        const _WspaPageHeader(
          eyebrow: 'Glossary',
          title: 'Terms you\'ll see nearby',
          subtitle:
              'Quick reference. Every term links back to WidgetStatePropertyAll '
              'in one hop.',
          accent: _kOakDark,
        ),
        const SizedBox(height: 14),
        const _WspaSectionHeader(
          text: 'Terms',
          icon: Icons.menu_book,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: _WspaPaperCard(
            child: Column(
              children: <Widget>[
                for (int i = 0; i < terms.length; i++) ...<Widget>[
                  _WspaGlossaryRow(term: terms[i]),
                  if (i < terms.length - 1)
                    const Divider(height: 18, color: _kPaperEdge),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),
        const _WspaSectionHeader(
          text: 'Epilogue',
          icon: Icons.auto_stories,
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: _WspaEpilogueCard(),
        ),
        const SizedBox(height: 22),
      ],
    );
  }
}

class _WspaGlossaryTerm {
  final String term;
  final String definition;
  const _WspaGlossaryTerm({required this.term, required this.definition});
}

class _WspaGlossaryRow extends StatelessWidget {
  final _WspaGlossaryTerm term;
  const _WspaGlossaryRow({required this.term});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 200,
          child: Text(
            term.term,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: _kInkBlue,
            ),
          ),
        ),
        Expanded(
          child: Text(
            term.definition,
            style: const TextStyle(fontSize: 12, color: _kText, height: 1.4),
          ),
        ),
      ],
    );
  }
}

class _WspaEpilogueCard extends StatelessWidget {
  const _WspaEpilogueCard();

  @override
  Widget build(BuildContext context) {
    return _WspaPaperCard(
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'WidgetStatePropertyAll is the most boring member of the '
            'WidgetStateProperty family — and that is exactly why it is useful. '
            'Most style values do not need to vary. The class lets you say so '
            'without ceremony, without a callback, without a map, and often '
            'without leaving const.',
            style: TextStyle(fontSize: 12, color: _kText, height: 1.45),
          ),
          SizedBox(height: 10),
          Text(
            'Whenever you find yourself writing "WidgetStateProperty.resolveWith(('
            'states) => someConst)" — stop. That is a rubber stamp. Use '
            'WidgetStatePropertyAll(someConst) and move on.',
            style: TextStyle(
              fontSize: 12,
              color: _kInkRed,
              fontWeight: FontWeight.w700,
              height: 1.45,
            ),
          ),
          SizedBox(height: 12),
          Text(
            '— End of dossier.',
            style: TextStyle(
              fontSize: 11,
              color: _kTextMuted,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

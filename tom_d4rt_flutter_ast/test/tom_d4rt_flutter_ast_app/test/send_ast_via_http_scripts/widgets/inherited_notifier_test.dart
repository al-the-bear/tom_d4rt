import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette — calm teal + amber Material 3 seeds, reused across all tabs.
// ---------------------------------------------------------------------------
const Color _kSeed = Color(0xFF0F6E6E);
const Color _kInk = Color(0xFF0C2B2B);
const Color _kSurface = Color(0xFFF2F8F8);
const Color _kSurfaceAlt = Color(0xFFE6F1F1);
const Color _kBorder = Color(0xFFB7D0D0);
const Color _kAccent = Color(0xFFB97C2F);
const Color _kAccentSoft = Color(0xFFEED9B8);
const Color _kRose = Color(0xFF9A4F6E);
const Color _kViolet = Color(0xFF6C5CA6);
const Color _kOlive = Color(0xFF6F7A3A);
const Color _kOk = Color(0xFF2F7A44);
const Color _kWarn = Color(0xFFB27200);
const Color _kBad = Color(0xFFB23A3A);

// ---------------------------------------------------------------------------
// Top-level ValueNotifiers — allowed by the constraints to let stateless
// widgets still drive reactive rebuilds through InheritedNotifier scopes.
// ---------------------------------------------------------------------------
final ValueNotifier<int> _counterA = ValueNotifier<int>(0);
final ValueNotifier<int> _counterB = ValueNotifier<int>(7);

// Custom Listenable — cart model with items, subtotal, optional discount.
final _CartListenable _cart = _CartListenable.seeded();

// Theme notifier for the nested scopes tab.
final ValueNotifier<_PaletteChoice> _palette =
    ValueNotifier<_PaletteChoice>(_PaletteChoice.teal);

// ---------------------------------------------------------------------------
// Entry point (d4rt expects a top-level `build` returning a widget tree).
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return const _InheritedNotifierDeepDemo();
}

// ===========================================================================
// Root app: MaterialApp with Material 3 theme + 9-tab scaffold.
// ===========================================================================
class _InheritedNotifierDeepDemo extends StatelessWidget {
  const _InheritedNotifierDeepDemo();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme =
        ColorScheme.fromSeed(seedColor: _kSeed, brightness: Brightness.light);
    final ThemeData theme = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: _kSurface,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _kInk, height: 1.35),
        titleLarge: TextStyle(
          color: _kInk,
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const _ShellScaffold(),
    );
  }
}

class _ShellScaffold extends StatelessWidget {
  const _ShellScaffold();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        backgroundColor: _kSurface,
        appBar: AppBar(
          backgroundColor: _kInk,
          foregroundColor: Colors.white,
          toolbarHeight: 96,
          elevation: 0,
          title: const _AppBarTitle(),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(52),
            child: _ShellTabBar(),
          ),
        ),
        body: const TabBarView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            _HeroBannerTab(),
            _LiveCounterTab(),
            _CustomListenableTab(),
            _MultipleNotifiersTab(),
            _OptionalNotifierTab(),
            _DiagramTab(),
            _ComparisonTab(),
            _PitfallsTab(),
            _UseCasesAndApiTab(),
          ],
        ),
      ),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: <Color>[_kSeed, _kAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          alignment: Alignment.center,
          child: const Text(
            'IN',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 1.4,
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
                'InheritedNotifier Deep Demo',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Inherited widget that rebuilds descendants on Listenable notifications',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFFB8D2D2),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ShellTabBar extends StatelessWidget {
  const _ShellTabBar();

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      isScrollable: true,
      indicatorColor: _kAccent,
      indicatorWeight: 3,
      labelColor: Colors.white,
      unselectedLabelColor: Color(0xFFA8C2C2),
      labelStyle: TextStyle(fontWeight: FontWeight.w700),
      tabs: <Widget>[
        Tab(text: 'Hero'),
        Tab(text: 'Live Counter'),
        Tab(text: 'Custom Listenable'),
        Tab(text: 'Multiple Scopes'),
        Tab(text: 'Optional Notifier'),
        Tab(text: 'Diagram'),
        Tab(text: 'Comparison'),
        Tab(text: 'Pitfalls'),
        Tab(text: 'Use Cases & API'),
      ],
    );
  }
}

// ===========================================================================
// Shared atoms — page header, section header, info chip, code chip, divider.
// ===========================================================================
class _PageHeader extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color tone;
  const _PageHeader({
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.tone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kBorder),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: tone.withValues(alpha: 0.14),
              border: Border.all(color: tone.withValues(alpha: 0.35)),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: tone, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  eyebrow.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    letterSpacing: 1.6,
                    fontWeight: FontWeight.w800,
                    color: tone,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: _kInk,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: Color(0xFF425858),
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

class _SectionHeader extends StatelessWidget {
  final String label;
  final String? trailing;
  const _SectionHeader({required this.label, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 8),
      child: Row(
        children: <Widget>[
          Container(
            width: 5,
            height: 22,
            decoration: BoxDecoration(
              color: _kAccent,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 17,
                color: _kInk,
              ),
            ),
          ),
          if (trailing != null)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: _kAccentSoft,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                trailing!,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: _kInk,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color tone;
  const _InfoChip({
    required this.icon,
    required this.text,
    required this.tone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.12),
        border: Border.all(color: tone.withValues(alpha: 0.45)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 14, color: tone),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: tone,
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeChip extends StatelessWidget {
  final String text;
  const _CodeChip(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6F6),
        border: Border.all(color: _kBorder),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: _kInk,
        ),
      ),
    );
  }
}

class _SoftDivider extends StatelessWidget {
  const _SoftDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      height: 1,
      color: _kBorder,
    );
  }
}

// ===========================================================================
// InheritedNotifier subclasses — the core educational payload.
// ===========================================================================

/// CountScope — minimal `InheritedNotifier<ValueNotifier<int>>` recipe.
class _CountScope extends InheritedNotifier<ValueNotifier<int>> {
  const _CountScope({
    required super.notifier,
    required super.child,
  });

  static _CountScope? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_CountScope>();

  static _CountScope of(BuildContext context) {
    final _CountScope? scope = maybeOf(context);
    assert(scope != null, '_CountScope.of() called with no _CountScope above.');
    return scope!;
  }
}

/// Cart payload — real Listenable with domain logic.
class _CartItem {
  final String name;
  final double price;
  final IconData icon;
  final Color tone;
  const _CartItem(this.name, this.price, this.icon, this.tone);
}

class _CartListenable extends ChangeNotifier {
  final List<_CartItem> _items = <_CartItem>[];
  double _discount = 0.0;

  _CartListenable.seeded() {
    _items.add(const _CartItem(
      'Notebook',
      6.50,
      Icons.menu_book_outlined,
      _kBlueTone,
    ));
    _items.add(const _CartItem(
      'Espresso',
      3.20,
      Icons.coffee_outlined,
      _kAccent,
    ));
  }

  int get count => _items.length;
  double get subtotal =>
      _items.fold<double>(0.0, (double a, _CartItem b) => a + b.price);
  double get discount => _discount;
  double get total => (subtotal - _discount).clamp(0.0, double.infinity);
  List<_CartItem> get items => List<_CartItem>.unmodifiable(_items);

  void addItem(_CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeLast() {
    if (_items.isNotEmpty) {
      _items.removeLast();
      notifyListeners();
    }
  }

  void applyDiscount(double value) {
    _discount = value.clamp(0.0, subtotal);
    notifyListeners();
  }

  void reset() {
    _items.clear();
    _discount = 0.0;
    notifyListeners();
  }
}

const Color _kBlueTone = Color(0xFF3E78A8);

class _CartScope extends InheritedNotifier<_CartListenable> {
  const _CartScope({required _CartListenable super.notifier, required super.child});

  static _CartScope? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_CartScope>();

  static _CartScope of(BuildContext context) {
    final _CartScope? s = maybeOf(context);
    assert(s != null, '_CartScope.of() called with no _CartScope above.');
    return s!;
  }
}

/// Theme palette notifier scope — shows nested InheritedNotifiers.
enum _PaletteChoice { teal, rose, violet, olive }

class _PaletteScope extends InheritedNotifier<ValueNotifier<_PaletteChoice>> {
  const _PaletteScope({
    required ValueNotifier<_PaletteChoice> super.notifier,
    required super.child,
  });

  static _PaletteScope of(BuildContext context) {
    final _PaletteScope? s =
        context.dependOnInheritedWidgetOfExactType<_PaletteScope>();
    assert(s != null, '_PaletteScope.of() called with no _PaletteScope above.');
    return s!;
  }
}

Color _paletteColor(_PaletteChoice c) {
  switch (c) {
    case _PaletteChoice.teal:
      return _kSeed;
    case _PaletteChoice.rose:
      return _kRose;
    case _PaletteChoice.violet:
      return _kViolet;
    case _PaletteChoice.olive:
      return _kOlive;
  }
}

String _paletteLabel(_PaletteChoice c) {
  switch (c) {
    case _PaletteChoice.teal:
      return 'Teal';
    case _PaletteChoice.rose:
      return 'Rose';
    case _PaletteChoice.violet:
      return 'Violet';
    case _PaletteChoice.olive:
      return 'Olive';
  }
}

// ===========================================================================
// TAB 1 — Hero banner + conceptual intro + contrast with InheritedWidget.
// ===========================================================================
class _HeroBannerTab extends StatelessWidget {
  const _HeroBannerTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 32),
      children: const <Widget>[
        _HeroBanner(),
        _SectionHeader(label: 'Three sentences', trailing: 'tl;dr'),
        _HeroThreeSentenceCards(),
        _SectionHeader(label: 'InheritedNotifier vs InheritedWidget'),
        _IwVsInContrastCard(),
        _SectionHeader(label: 'When would I reach for it?'),
        _WhenToReach(),
        _SoftDivider(),
        _SectionHeader(label: 'Signature and inheritance chain'),
        _SignatureCard(),
        SizedBox(height: 16),
      ],
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: <Color>[_kInk, Color(0xFF144A4A), _kSeed],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'InheritedNotifier<T extends Listenable>',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 0.4,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'An InheritedWidget that plumbs a Listenable down the tree and '
            'automatically rebuilds descendants whenever that Listenable '
            'notifies. No updateShouldNotify boilerplate. No equality tricks. '
            'Just: give it a ValueNotifier, ChangeNotifier, Animation, '
            'ScrollController, TabController, or anything else Listenable-'
            'shaped, and descendants get reactive access via .of(context).',
            style: TextStyle(
              color: Color(0xFFDDE8E8),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _HeroChip(label: 'InheritedWidget base', tone: _kAccentSoft),
              _HeroChip(label: 'Listens to T', tone: _kAccentSoft),
              _HeroChip(label: 'Auto rebuild', tone: _kAccentSoft),
              _HeroChip(label: 'O(1) lookup via .of', tone: _kAccentSoft),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  final String label;
  final Color tone;
  const _HeroChip({required this.label, required this.tone});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: tone,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: _kInk,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _HeroThreeSentenceCards extends StatelessWidget {
  const _HeroThreeSentenceCards();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Column(
        children: <Widget>[
          _HeroSentenceCard(
            index: '01',
            title: 'It extends InheritedWidget.',
            body:
                'All the inherited-lookup plumbing still applies: descendants '
                'register a dependency via context.dependOnInheritedWidget'
                'OfExactType.',
          ),
          SizedBox(height: 10),
          _HeroSentenceCard(
            index: '02',
            title: 'It listens to T.',
            body:
                'It wires addListener/removeListener for you, so whenever the '
                'notifier fires, the element marks itself as needing rebuild.',
          ),
          SizedBox(height: 10),
          _HeroSentenceCard(
            index: '03',
            title: 'Dependents rebuild automatically.',
            body:
                'Every widget that called .of(context) on this scope sees its '
                'build method called on the next frame. No setState. No ticker.',
          ),
        ],
      ),
    );
  }
}

class _HeroSentenceCard extends StatelessWidget {
  final String index;
  final String title;
  final String body;
  const _HeroSentenceCard({
    required this.index,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: _kSurfaceAlt,
              border: Border.all(color: _kBorder),
            ),
            child: Text(
              index,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
                color: _kInk,
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
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: _kInk,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF425858),
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

class _IwVsInContrastCard extends StatelessWidget {
  const _IwVsInContrastCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Expanded(
            child: _ContrastBlock(
              title: 'InheritedWidget',
              icon: Icons.layers_outlined,
              tone: _kViolet,
              bullets: <String>[
                'Rebuilds descendants when the widget config changes.',
                'You implement updateShouldNotify yourself.',
                'Trigger: parent rebuild with new constructor args.',
                'Idiom: value objects like Theme, MediaQuery.',
              ],
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _ContrastBlock(
              title: 'InheritedNotifier',
              icon: Icons.notifications_active_outlined,
              tone: _kSeed,
              bullets: <String>[
                'Rebuilds descendants when the notifier notifies.',
                'updateShouldNotify is already correct for you.',
                'Trigger: notifier.notifyListeners() at any time.',
                'Idiom: mutable state objects like counters, carts.',
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContrastBlock extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color tone;
  final List<String> bullets;
  const _ContrastBlock({
    required this.title,
    required this.icon,
    required this.tone,
    required this.bullets,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tone.withValues(alpha: 0.30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, size: 18, color: tone),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: tone,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...bullets.map((String b) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.circle, size: 6, color: tone),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        b,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: _kInk,
                          height: 1.4,
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

class _WhenToReach extends StatelessWidget {
  const _WhenToReach();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kAccentSoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kAccent.withValues(alpha: 0.4)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.lightbulb_outline, color: _kInk),
              SizedBox(width: 8),
              Text(
                'Reach for InheritedNotifier when:',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  color: _kInk,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            '1. You already hold a Listenable and want it ambient.\n'
            '2. You want .of(context) access without InheritedWidget boilerplate.\n'
            '3. You need dependents to rebuild on every notifyListeners() call.\n'
            '4. You need something smaller than a full Provider / Riverpod dep.',
            style: TextStyle(
              fontSize: 13,
              color: _kInk,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

class _SignatureCard extends StatelessWidget {
  const _SignatureCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kInk,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'class chain',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF9FBEBE),
              letterSpacing: 1.4,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Object',
            style: TextStyle(fontFamily: 'monospace', color: Color(0xFFD9E7E7)),
          ),
          Text(
            '  └─ Widget',
            style: TextStyle(fontFamily: 'monospace', color: Color(0xFFD9E7E7)),
          ),
          Text(
            '       └─ ProxyWidget',
            style: TextStyle(fontFamily: 'monospace', color: Color(0xFFD9E7E7)),
          ),
          Text(
            '            └─ InheritedWidget',
            style: TextStyle(fontFamily: 'monospace', color: Color(0xFFD9E7E7)),
          ),
          Text(
            '                 └─ InheritedNotifier<T extends Listenable>',
            style: TextStyle(
              fontFamily: 'monospace',
              color: _kAccentSoft,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 2 — Live counter demo.
// ===========================================================================
class _LiveCounterTab extends StatelessWidget {
  const _LiveCounterTab();

  @override
  Widget build(BuildContext context) {
    return _CountScope(
      notifier: _counterA,
      child: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: const <Widget>[
          _PageHeader(
            eyebrow: 'live demo',
            title: 'A counter driven by a ValueNotifier<int>',
            subtitle:
                'The scope is a _CountScope — an InheritedNotifier<ValueNotifier<int>>. '
                'Descendants call _CountScope.of(context) and rebuild automatically '
                'whenever the notifier publishes a new value.',
            icon: Icons.exposure_plus_1_outlined,
            tone: _kSeed,
          ),
          _SectionHeader(label: 'Counter readout', trailing: 'listens to T'),
          _LiveCounterReadout(),
          _SectionHeader(label: 'Controls'),
          _LiveCounterControls(),
          _SectionHeader(label: 'Receipt from descendants'),
          _LiveCounterReceipts(),
          _SectionHeader(label: 'Gauge descendant'),
          _LiveCounterGauge(),
          _SoftDivider(),
          _SectionHeader(label: 'Minimal subclass source'),
          _CountScopeSourceBlock(),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _LiveCounterReadout extends StatelessWidget {
  const _LiveCounterReadout();

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int>? n = _CountScope.of(context).notifier;
    final int value = n?.value ?? 0;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 72,
            height: 72,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: _kSeed.withValues(alpha: 0.12),
              border: Border.all(color: _kSeed.withValues(alpha: 0.4)),
            ),
            child: Text(
              '$value',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: _kInk,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'counterA.value',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    color: Color(0xFF425858),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value.isEven
                      ? 'Even — boring but stable.'
                      : 'Odd — quietly interesting.',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _kInk,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: <Widget>[
                    _InfoChip(
                      icon: Icons.refresh,
                      text: value % 7 == 0 ? 'multiple of 7' : 'not mult of 7',
                      tone: value % 7 == 0 ? _kOk : _kOlive,
                    ),
                    const SizedBox(width: 8),
                    _InfoChip(
                      icon: Icons.tag,
                      text: value >= 10 ? 'double digits' : 'single digit',
                      tone: value >= 10 ? _kAccent : _kViolet,
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
}

class _LiveCounterControls extends StatelessWidget {
  const _LiveCounterControls();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: <Widget>[
          _PillButton(
            icon: Icons.add,
            label: '+1',
            tone: _kSeed,
            onTap: () => _counterA.value = _counterA.value + 1,
          ),
          _PillButton(
            icon: Icons.remove,
            label: '-1',
            tone: _kRose,
            onTap: () => _counterA.value = _counterA.value - 1,
          ),
          _PillButton(
            icon: Icons.bolt_outlined,
            label: '+10',
            tone: _kAccent,
            onTap: () => _counterA.value = _counterA.value + 10,
          ),
          _PillButton(
            icon: Icons.restart_alt,
            label: 'reset',
            tone: _kViolet,
            onTap: () => _counterA.value = 0,
          ),
          _PillButton(
            icon: Icons.shuffle,
            label: 'shuffle',
            tone: _kOlive,
            onTap: () =>
                _counterA.value = (_counterA.value * 2 + 3) % 99,
          ),
        ],
      ),
    );
  }
}

class _PillButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color tone;
  final VoidCallback onTap;
  const _PillButton({
    required this.icon,
    required this.label,
    required this.tone,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: tone,
            borderRadius: BorderRadius.circular(12),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: tone.withValues(alpha: 0.35),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 18, color: Colors.white),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LiveCounterReceipts extends StatelessWidget {
  const _LiveCounterReceipts();

  @override
  Widget build(BuildContext context) {
    final int value = _CountScope.of(context).notifier?.value ?? 0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          _ReceiptLine(
            index: 1,
            label: 'Descendant #1 (binary view)',
            value: value.toRadixString(2).padLeft(8, '0'),
            tone: _kViolet,
          ),
          const SizedBox(height: 8),
          _ReceiptLine(
            index: 2,
            label: 'Descendant #2 (hex view)',
            value: '0x${value.toRadixString(16).toUpperCase()}',
            tone: _kAccent,
          ),
          const SizedBox(height: 8),
          _ReceiptLine(
            index: 3,
            label: 'Descendant #3 (squared)',
            value: '${value * value}',
            tone: _kSeed,
          ),
          const SizedBox(height: 8),
          _ReceiptLine(
            index: 4,
            label: 'Descendant #4 (divisibility)',
            value: _divisibility(value),
            tone: _kOlive,
          ),
        ],
      ),
    );
  }

  String _divisibility(int n) {
    final List<int> hits = <int>[];
    for (int d = 2; d <= 10; d++) {
      if (n != 0 && n % d == 0) hits.add(d);
    }
    return hits.isEmpty ? 'prime-ish' : hits.join(', ');
  }
}

class _ReceiptLine extends StatelessWidget {
  final int index;
  final String label;
  final String value;
  final Color tone;
  const _ReceiptLine({
    required this.index,
    required this.label,
    required this.value,
    required this.tone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '#$index',
              style: TextStyle(
                color: tone,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _kInk,
              ),
            ),
          ),
          _CodeChip(value),
        ],
      ),
    );
  }
}

class _LiveCounterGauge extends StatelessWidget {
  const _LiveCounterGauge();

  @override
  Widget build(BuildContext context) {
    final int v = _CountScope.of(context).notifier?.value ?? 0;
    final double pct = ((v % 100) / 100).clamp(0.0, 1.0);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Expanded(
                child: Text(
                  'Gauge — (counterA mod 100) / 100',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: _kInk,
                  ),
                ),
              ),
              Text(
                '${(pct * 100).round()}%',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: _kInk,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 14,
              child: LinearProgressIndicator(
                value: pct,
                backgroundColor: _kSurfaceAlt,
                valueColor: const AlwaysStoppedAnimation<Color>(_kSeed),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CountScopeSourceBlock extends StatelessWidget {
  const _CountScopeSourceBlock();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: _CodeBlock(
        title: '_CountScope subclass',
        lines: <String>[
          'class _CountScope extends InheritedNotifier<ValueNotifier<int>> {',
          '  const _CountScope({',
          '    required ValueNotifier<int>? notifier,',
          '    required Widget child,',
          '  }) : super(notifier: notifier, child: child);',
          '',
          '  static _CountScope? maybeOf(BuildContext c) =>',
          '      c.dependOnInheritedWidgetOfExactType<_CountScope>();',
          '',
          '  static _CountScope of(BuildContext c) =>',
          '      maybeOf(c)!;',
          '}',
        ],
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  final String title;
  final List<String> lines;
  const _CodeBlock({required this.title, required this.lines});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kInk,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.code, color: Color(0xFF9FBEBE), size: 16),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF9FBEBE),
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...lines.map((String l) => Text(
                l.isEmpty ? ' ' : l,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: Color(0xFFE4EFEF),
                  height: 1.5,
                ),
              )),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 3 — Custom Listenable (cart) demo.
// ===========================================================================
class _CustomListenableTab extends StatelessWidget {
  const _CustomListenableTab();

  @override
  Widget build(BuildContext context) {
    return _CartScope(
      notifier: _cart,
      child: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: const <Widget>[
          _PageHeader(
            eyebrow: 'custom listenable',
            title: 'A ChangeNotifier as the T of InheritedNotifier',
            subtitle:
                '_CartScope is an InheritedNotifier<_CartListenable>, where '
                '_CartListenable is a ChangeNotifier holding a list of '
                'items, a discount, and helpers. Descendants observe the '
                'cart state without ever reaching out to a singleton.',
            icon: Icons.shopping_cart_outlined,
            tone: _kAccent,
          ),
          _SectionHeader(label: 'Header summary'),
          _CartSummaryHeader(),
          _SectionHeader(label: 'Items'),
          _CartItemsList(),
          _SectionHeader(label: 'Mutations'),
          _CartMutationButtons(),
          _SectionHeader(label: 'Discount slider'),
          _CartDiscountRow(),
          _SectionHeader(label: 'Receipts from nested descendants'),
          _CartNestedReceipts(),
          _SoftDivider(),
          _SectionHeader(label: '_CartListenable shape'),
          _CartListenableSource(),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _CartSummaryHeader extends StatelessWidget {
  const _CartSummaryHeader();

  @override
  Widget build(BuildContext context) {
    final _CartListenable? c = _CartScope.of(context).notifier;
    if (c == null) return const SizedBox.shrink();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        children: <Widget>[
          _CartBigNumber(
              label: 'items', value: '${c.count}', tone: _kSeed),
          const SizedBox(width: 14),
          _CartBigNumber(
              label: 'subtotal',
              value: '\$${c.subtotal.toStringAsFixed(2)}',
              tone: _kViolet),
          const SizedBox(width: 14),
          _CartBigNumber(
              label: 'discount',
              value: '-\$${c.discount.toStringAsFixed(2)}',
              tone: _kRose),
          const SizedBox(width: 14),
          _CartBigNumber(
              label: 'total',
              value: '\$${c.total.toStringAsFixed(2)}',
              tone: _kAccent),
        ],
      ),
    );
  }
}

class _CartBigNumber extends StatelessWidget {
  final String label;
  final String value;
  final Color tone;
  const _CartBigNumber({
    required this.label,
    required this.value,
    required this.tone,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: tone.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: tone.withValues(alpha: 0.35)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: tone,
                letterSpacing: 1.3,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: _kInk,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartItemsList extends StatelessWidget {
  const _CartItemsList();

  @override
  Widget build(BuildContext context) {
    final _CartListenable? c = _CartScope.of(context).notifier;
    if (c == null || c.items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: _EmptyCartCard(),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          for (int i = 0; i < c.items.length; i++) ...<Widget>[
            _CartItemTile(index: i, item: c.items[i]),
            if (i != c.items.length - 1) const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class _EmptyCartCard extends StatelessWidget {
  const _EmptyCartCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kSurfaceAlt,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder),
      ),
      child: const Row(
        children: <Widget>[
          Icon(Icons.inbox_outlined, color: _kInk),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Cart is empty. Try adding an item below — descendants rebuild automatically.',
              style: TextStyle(color: _kInk, fontSize: 13, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _CartItemTile extends StatelessWidget {
  final int index;
  final _CartItem item;
  const _CartItemTile({required this.index, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: item.tone.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(item.icon, color: item.tone),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: _kInk,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'item #$index',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF607272),
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$${item.price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: _kInk,
            ),
          ),
        ],
      ),
    );
  }
}

class _CartMutationButtons extends StatelessWidget {
  const _CartMutationButtons();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: <Widget>[
          _PillButton(
            icon: Icons.menu_book_outlined,
            label: '+ Notebook',
            tone: _kBlueTone,
            onTap: () => _cart.addItem(const _CartItem(
              'Notebook',
              6.50,
              Icons.menu_book_outlined,
              _kBlueTone,
            )),
          ),
          _PillButton(
            icon: Icons.coffee_outlined,
            label: '+ Espresso',
            tone: _kAccent,
            onTap: () => _cart.addItem(const _CartItem(
              'Espresso',
              3.20,
              Icons.coffee_outlined,
              _kAccent,
            )),
          ),
          _PillButton(
            icon: Icons.cake_outlined,
            label: '+ Muffin',
            tone: _kRose,
            onTap: () => _cart.addItem(const _CartItem(
              'Muffin',
              2.80,
              Icons.cake_outlined,
              _kRose,
            )),
          ),
          _PillButton(
            icon: Icons.remove_circle_outline,
            label: 'remove last',
            tone: _kViolet,
            onTap: () => _cart.removeLast(),
          ),
          _PillButton(
            icon: Icons.clear_all,
            label: 'reset',
            tone: _kOlive,
            onTap: () => _cart.reset(),
          ),
        ],
      ),
    );
  }
}

class _CartDiscountRow extends StatelessWidget {
  const _CartDiscountRow();

  @override
  Widget build(BuildContext context) {
    final _CartListenable? c = _CartScope.of(context).notifier;
    final double subtotal = c?.subtotal ?? 0;
    final double current = c?.discount ?? 0;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Expanded(
                child: Text(
                  'Discount',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: _kInk,
                  ),
                ),
              ),
              Text(
                '\$${current.toStringAsFixed(2)} / \$${subtotal.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: _kInk,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Slider(
            min: 0.0,
            max: subtotal <= 0 ? 0.01 : subtotal,
            value: current.clamp(0.0, subtotal <= 0 ? 0.01 : subtotal),
            activeColor: _kAccent,
            inactiveColor: _kAccentSoft,
            onChanged: subtotal <= 0
                ? null
                : (double v) => _cart.applyDiscount(v),
          ),
        ],
      ),
    );
  }
}

class _CartNestedReceipts extends StatelessWidget {
  const _CartNestedReceipts();

  @override
  Widget build(BuildContext context) {
    final _CartListenable? c = _CartScope.of(context).notifier;
    if (c == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          _ReceiptLine(
            index: 1,
            label: 'Descendant A (avg unit price)',
            value: c.count == 0
                ? '—'
                : '\$${(c.subtotal / c.count).toStringAsFixed(2)}',
            tone: _kSeed,
          ),
          const SizedBox(height: 8),
          _ReceiptLine(
            index: 2,
            label: 'Descendant B (most expensive)',
            value: c.items.isEmpty
                ? '—'
                : c.items
                    .reduce((_CartItem a, _CartItem b) =>
                        a.price >= b.price ? a : b)
                    .name,
            tone: _kAccent,
          ),
          const SizedBox(height: 8),
          _ReceiptLine(
            index: 3,
            label: 'Descendant C (names joined)',
            value: c.items.isEmpty
                ? '—'
                : c.items.map((_CartItem i) => i.name).join(', '),
            tone: _kViolet,
          ),
          const SizedBox(height: 8),
          _ReceiptLine(
            index: 4,
            label: 'Descendant D (status)',
            value: c.total == 0
                ? 'waiting for items'
                : c.total < 5
                    ? 'small order'
                    : c.total < 15
                        ? 'regular'
                        : 'hungry',
            tone: _kRose,
          ),
        ],
      ),
    );
  }
}

class _CartListenableSource extends StatelessWidget {
  const _CartListenableSource();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: _CodeBlock(
        title: '_CartListenable + _CartScope',
        lines: <String>[
          'class _CartListenable extends ChangeNotifier {',
          '  final List<_CartItem> _items = <_CartItem>[];',
          '  double _discount = 0.0;',
          '  void addItem(_CartItem i) { _items.add(i); notifyListeners(); }',
          '  void removeLast() { if (_items.isNotEmpty) { _items.removeLast(); notifyListeners(); } }',
          '  void applyDiscount(double v) { _discount = v; notifyListeners(); }',
          '}',
          '',
          'class _CartScope extends InheritedNotifier<_CartListenable> {',
          '  const _CartScope({required super.notifier, required super.child});',
          '  static _CartScope of(BuildContext c) =>',
          '      c.dependOnInheritedWidgetOfExactType<_CartScope>()!;',
          '}',
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 4 — Multiple notifiers demo (palette + counter nested).
// ===========================================================================
class _MultipleNotifiersTab extends StatelessWidget {
  const _MultipleNotifiersTab();

  @override
  Widget build(BuildContext context) {
    return _PaletteScope(
      notifier: _palette,
      child: _CountScope(
        notifier: _counterB,
        child: ListView(
          padding: const EdgeInsets.only(bottom: 32),
          children: const <Widget>[
            _PageHeader(
              eyebrow: 'nested scopes',
              title: '_PaletteScope nested over _CountScope',
              subtitle:
                  'Two InheritedNotifiers stacked over the same subtree. '
                  'Descendants read from either, both, or neither — each '
                  'scope triggers rebuilds independently via .of(context).',
              icon: Icons.layers_outlined,
              tone: _kViolet,
            ),
            _SectionHeader(label: 'Palette picker'),
            _PalettePicker(),
            _SectionHeader(label: 'Counter + palette combo'),
            _ComboReadout(),
            _SectionHeader(label: 'Counter controls'),
            _MultiScopeCountControls(),
            _SectionHeader(label: 'Swatch panel'),
            _SwatchPanel(),
            _SectionHeader(label: 'Grid of descendants'),
            _MultiScopeGrid(),
            _SoftDivider(),
            _SectionHeader(label: 'Nesting source'),
            _NestedSource(),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _PalettePicker extends StatelessWidget {
  const _PalettePicker();

  @override
  Widget build(BuildContext context) {
    final _PaletteChoice current = _PaletteScope.of(context).notifier!.value;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: _PaletteChoice.values.map((_PaletteChoice c) {
          final bool active = c == current;
          final Color tone = _paletteColor(c);
          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _palette.value = c,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: active ? tone : tone.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: tone),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    active ? Icons.check_circle : Icons.circle_outlined,
                    color: active ? Colors.white : tone,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _paletteLabel(c),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: active ? Colors.white : tone,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _ComboReadout extends StatelessWidget {
  const _ComboReadout();

  @override
  Widget build(BuildContext context) {
    final _PaletteChoice p = _PaletteScope.of(context).notifier!.value;
    final int v = _CountScope.of(context).notifier?.value ?? 0;
    final Color tone = _paletteColor(p);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: tone.withValues(alpha: 0.45)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 64,
            height: 64,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tone,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              '$v',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 26,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _paletteLabel(p),
                  style: TextStyle(
                    color: tone,
                    fontWeight: FontWeight.w800,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Two independent notifiers driving one descendant.',
                  style: TextStyle(color: _kInk, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MultiScopeCountControls extends StatelessWidget {
  const _MultiScopeCountControls();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: <Widget>[
          _PillButton(
            icon: Icons.add,
            label: '+1',
            tone: _paletteColor(_palette.value),
            onTap: () => _counterB.value = _counterB.value + 1,
          ),
          _PillButton(
            icon: Icons.remove,
            label: '-1',
            tone: _kRose,
            onTap: () => _counterB.value = _counterB.value - 1,
          ),
          _PillButton(
            icon: Icons.exposure,
            label: 'double',
            tone: _kViolet,
            onTap: () => _counterB.value = _counterB.value * 2,
          ),
          _PillButton(
            icon: Icons.restart_alt,
            label: 'reset 7',
            tone: _kOlive,
            onTap: () => _counterB.value = 7,
          ),
        ],
      ),
    );
  }
}

class _SwatchPanel extends StatelessWidget {
  const _SwatchPanel();

  @override
  Widget build(BuildContext context) {
    final _PaletteChoice p = _PaletteScope.of(context).notifier!.value;
    final Color base = _paletteColor(p);
    final List<double> alphas = <double>[0.15, 0.3, 0.5, 0.7, 1.0];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: alphas.map((double a) {
          return Expanded(
            child: Container(
              height: 52,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: base.withValues(alpha: a),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                (a * 100).round().toString(),
                style: TextStyle(
                  color: a < 0.5 ? _kInk : Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _MultiScopeGrid extends StatelessWidget {
  const _MultiScopeGrid();

  @override
  Widget build(BuildContext context) {
    final _PaletteChoice p = _PaletteScope.of(context).notifier!.value;
    final int v = _CountScope.of(context).notifier?.value ?? 0;
    final Color tone = _paletteColor(p);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 1.6,
        children: List<Widget>.generate(9, (int i) {
          final int cellValue = (v + i * 3) % 100;
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: tone.withValues(alpha: 0.45)),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'cell ${i + 1}',
                  style: TextStyle(
                    color: tone,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '$cellValue',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: _kInk,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _NestedSource extends StatelessWidget {
  const _NestedSource();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: _CodeBlock(
        title: 'nesting two InheritedNotifiers',
        lines: <String>[
          '_PaletteScope(',
          '  notifier: paletteNotifier,',
          '  child: _CountScope(',
          '    notifier: counterNotifier,',
          '    child: TabContent(),',
          '  ),',
          ')',
          '',
          '// Descendants read either scope independently:',
          'final choice = _PaletteScope.of(context).notifier!.value;',
          'final value  = _CountScope.of(context).notifier?.value ?? 0;',
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 5 — Optional notifier (null) demo.
// ===========================================================================
class _OptionalNotifierTab extends StatelessWidget {
  const _OptionalNotifierTab();

  @override
  Widget build(BuildContext context) {
    return _CountScope(
      notifier: null, // Deliberately null — demonstrates graceful no-op.
      child: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: const <Widget>[
          _PageHeader(
            eyebrow: 'optional notifier',
            title: 'What if notifier is null?',
            subtitle:
                'InheritedNotifier accepts a nullable T. With a null notifier, '
                'there is nothing to listen to, so notifications simply never '
                'arrive. Descendants using .maybeOf() still get a handle to '
                'the scope — they just see notifier == null.',
            icon: Icons.do_not_disturb_alt_outlined,
            tone: _kOlive,
          ),
          _SectionHeader(label: 'maybeOf pattern'),
          _MaybeOfCard(),
          _SectionHeader(label: 'What you see vs what you would see'),
          _NullVsNonNullTable(),
          _SectionHeader(label: 'Defensive descendants'),
          _DefensiveDescendantsList(),
          _SoftDivider(),
          _SectionHeader(label: 'Why not always require non-null?'),
          _WhyNullableExplainer(),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _MaybeOfCard extends StatelessWidget {
  const _MaybeOfCard();

  @override
  Widget build(BuildContext context) {
    final _CountScope? scope = _CountScope.maybeOf(context);
    final ValueNotifier<int>? n = scope?.notifier;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                scope == null ? Icons.error_outline : Icons.check_circle,
                color: scope == null ? _kBad : _kOk,
              ),
              const SizedBox(width: 8),
              Text(
                scope == null
                    ? 'No _CountScope ancestor — scope is null.'
                    : n == null
                        ? 'Scope present but notifier is null.'
                        : 'Scope present; current = ${n.value}.',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: _kInk,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const _CodeBlock(
            title: 'maybeOf usage',
            lines: <String>[
              'final scope = _CountScope.maybeOf(context);',
              'final n = scope?.notifier;',
              'final v = n?.value ?? fallback;',
              '// No throws. No asserts. Just safe defaults.',
            ],
          ),
        ],
      ),
    );
  }
}

class _NullVsNonNullTable extends StatelessWidget {
  const _NullVsNonNullTable();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _kBorder),
        ),
        child: const Column(
          children: <Widget>[
            _TableRow(
              a: 'aspect',
              b: 'notifier == null',
              c: 'notifier != null',
              header: true,
            ),
            _TableRow(
              a: 'Listener wiring',
              b: 'none attached',
              c: 'addListener called',
            ),
            _TableRow(
              a: 'Rebuild triggers',
              b: 'only on widget config change',
              c: 'on every notifyListeners',
            ),
            _TableRow(
              a: '.of(context) result',
              b: 'scope handle, notifier null',
              c: 'scope handle, notifier present',
            ),
            _TableRow(
              a: 'Typical use',
              b: 'placeholder while loading',
              c: 'active state source',
            ),
          ],
        ),
      ),
    );
  }
}

class _TableRow extends StatelessWidget {
  final String a;
  final String b;
  final String c;
  final bool header;
  const _TableRow({
    required this.a,
    required this.b,
    required this.c,
    this.header = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: header ? _kSurfaceAlt : Colors.white,
        border: Border(bottom: BorderSide(color: _kBorder.withValues(alpha: 0.7))),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              a,
              style: TextStyle(
                fontWeight: header ? FontWeight.w800 : FontWeight.w600,
                color: _kInk,
                fontSize: 12.5,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              b,
              style: TextStyle(
                fontWeight: header ? FontWeight.w800 : FontWeight.w500,
                color: header ? _kInk : _kRose,
                fontSize: 12.5,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              c,
              style: TextStyle(
                fontWeight: header ? FontWeight.w800 : FontWeight.w500,
                color: header ? _kInk : _kOk,
                fontSize: 12.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DefensiveDescendantsList extends StatelessWidget {
  const _DefensiveDescendantsList();

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int>? n = _CountScope.maybeOf(context)?.notifier;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          _DefenseLine(
            label: 'fallback value',
            value: '${n?.value ?? -1}',
            tone: _kOlive,
            icon: Icons.shield_outlined,
          ),
          const SizedBox(height: 8),
          _DefenseLine(
            label: 'value != null ?',
            value: n?.value == null ? 'no' : 'yes',
            tone: _kViolet,
            icon: Icons.question_mark,
          ),
          const SizedBox(height: 8),
          _DefenseLine(
            label: 'display string',
            value: n == null ? 'not connected' : '${n.value}',
            tone: _kBlueTone,
            icon: Icons.info_outline,
          ),
          const SizedBox(height: 8),
          _DefenseLine(
            label: 'action state',
            value: n == null ? 'disabled' : 'enabled',
            tone: n == null ? _kBad : _kOk,
            icon: Icons.toggle_on_outlined,
          ),
        ],
      ),
    );
  }
}

class _DefenseLine extends StatelessWidget {
  final String label;
  final String value;
  final Color tone;
  final IconData icon;
  const _DefenseLine({
    required this.label,
    required this.value,
    required this.tone,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: tone),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: _kInk,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          _CodeChip(value),
        ],
      ),
    );
  }
}

class _WhyNullableExplainer extends StatelessWidget {
  const _WhyNullableExplainer();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kAccentSoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kAccent.withValues(alpha: 0.4)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Because real apps look like this:',
            style: TextStyle(fontWeight: FontWeight.w800, color: _kInk),
          ),
          SizedBox(height: 8),
          Text(
            '• Until login completes, the user object is null.\n'
            '• Until the first route loads, the scroll controller may be unattached.\n'
            '• Until the socket handshakes, the live model is empty.\n'
            '• A placeholder scope with notifier: null lets descendants render without '
            'scattering if-null checks across the tree.',
            style: TextStyle(color: _kInk, height: 1.55, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 6 — Diagram (CustomPainter).
// ===========================================================================
class _DiagramTab extends StatelessWidget {
  const _DiagramTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 32),
      children: const <Widget>[
        _PageHeader(
          eyebrow: 'diagram',
          title: 'How notifyListeners() reaches every descendant',
          subtitle:
              'A CustomPainter-drawn tree shows the path: notifier → scope → '
              'element subscription → markNeedsBuild on each dependent → '
              'rebuild on the next frame.',
          icon: Icons.account_tree_outlined,
          tone: _kBlueTone,
        ),
        _SectionHeader(label: 'Tree diagram'),
        _DiagramCanvas(),
        _SectionHeader(label: 'Legend'),
        _DiagramLegend(),
        _SoftDivider(),
        _SectionHeader(label: 'Step by step'),
        _DiagramSteps(),
        SizedBox(height: 12),
      ],
    );
  }
}

class _DiagramCanvas extends StatelessWidget {
  const _DiagramCanvas();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AspectRatio(
        aspectRatio: 1.55,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _kBorder),
          ),
          padding: const EdgeInsets.all(10),
          child: CustomPaint(
            painter: _TreeDiagramPainter(),
          ),
        ),
      ),
    );
  }
}

class _TreeDiagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final Paint bg = Paint()..color = const Color(0xFFF6FBFB);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, w, h),
        const Radius.circular(12),
      ),
      bg,
    );

    // Grid.
    final Paint grid = Paint()
      ..color = const Color(0xFFE0EDED)
      ..strokeWidth = 1;
    for (double x = 0; x < w; x += 24) {
      canvas.drawLine(Offset(x, 0), Offset(x, h), grid);
    }
    for (double y = 0; y < h; y += 24) {
      canvas.drawLine(Offset(0, y), Offset(w, y), grid);
    }

    // Notifier node (top).
    final Rect notifierRect = Rect.fromLTWH(w / 2 - 100, 14, 200, 46);
    _drawNode(
      canvas,
      notifierRect,
      title: 'ValueNotifier<int>',
      subtitle: 'notifyListeners()',
      fill: _kAccent,
      labelColor: Colors.white,
    );

    // Scope node.
    final Rect scopeRect = Rect.fromLTWH(w / 2 - 110, 90, 220, 46);
    _drawNode(
      canvas,
      scopeRect,
      title: '_CountScope (InheritedNotifier)',
      subtitle: 'wraps the notifier',
      fill: _kSeed,
      labelColor: Colors.white,
    );

    // Subtree container.
    final Rect subtreeRect =
        Rect.fromLTWH(w * 0.06, 166, w * 0.88, h - 182);
    final Paint subtreePaint = Paint()
      ..color = _kViolet.withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(subtreeRect, const Radius.circular(10)),
      subtreePaint,
    );
    final Paint subtreeBorder = Paint()
      ..color = _kViolet.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3;
    canvas.drawRRect(
      RRect.fromRectAndRadius(subtreeRect, const Radius.circular(10)),
      subtreeBorder,
    );
    _label(canvas, 'subtree', subtreeRect.topLeft + const Offset(8, 4),
        _kViolet, 10);

    // 4 leaf descendants.
    final double leafTop = subtreeRect.top + 36;
    final double leafH = 44.0;
    final List<String> leafLabels = <String>[
      'descendant A',
      'descendant B',
      'descendant C',
      'descendant D',
    ];
    final double gap = (subtreeRect.width - 4 * 130) / 5;
    final List<Rect> leafRects = <Rect>[];
    for (int i = 0; i < 4; i++) {
      final double x = subtreeRect.left + gap + i * (130 + gap);
      final Rect r = Rect.fromLTWH(x, leafTop, 130, leafH);
      leafRects.add(r);
      _drawNode(
        canvas,
        r,
        title: leafLabels[i],
        subtitle: 'dependOnInherited…',
        fill: Colors.white,
        labelColor: _kInk,
        border: _kBorder,
      );
    }

    // Arrows: notifier -> scope, scope -> each leaf, and also
    // notifier -> each leaf (rebuild arrows) shown dashed.
    final Paint solidArrow = Paint()
      ..color = _kAccent
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke;
    final Paint dashedArrow = Paint()
      ..color = _kSeed
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;

    _drawArrow(
      canvas,
      Offset(notifierRect.center.dx, notifierRect.bottom),
      Offset(scopeRect.center.dx, scopeRect.top),
      solidArrow,
      label: 'notify',
    );

    for (final Rect leaf in leafRects) {
      _drawArrow(
        canvas,
        Offset(scopeRect.center.dx, scopeRect.bottom),
        Offset(leaf.center.dx, leaf.top),
        dashedArrow,
      );
    }

    // Side legend labels.
    _label(
      canvas,
      'markNeedsBuild on each',
      Offset(subtreeRect.left + 10, subtreeRect.bottom - 22),
      _kSeed,
      11,
    );
  }

  void _drawNode(
    Canvas canvas,
    Rect rect, {
    required String title,
    required String subtitle,
    required Color fill,
    required Color labelColor,
    Color? border,
  }) {
    final Paint fillPaint = Paint()..color = fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(10)),
      fillPaint,
    );
    if (border != null) {
      final Paint borderPaint = Paint()
        ..color = border
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2;
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(10)),
        borderPaint,
      );
    }
    final TextPainter tp = TextPainter(
      text: TextSpan(
        style: TextStyle(
          color: labelColor,
          fontWeight: FontWeight.w800,
          fontSize: 11,
        ),
        text: title,
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: rect.width - 10);
    tp.paint(
      canvas,
      Offset(rect.left + (rect.width - tp.width) / 2, rect.top + 6),
    );

    final TextPainter tp2 = TextPainter(
      text: TextSpan(
        style: TextStyle(
          color: labelColor.withValues(alpha: 0.85),
          fontSize: 9.5,
        ),
        text: subtitle,
      ),
      textDirection: TextDirection.ltr,
    );
    tp2.layout(maxWidth: rect.width - 10);
    tp2.paint(
      canvas,
      Offset(rect.left + (rect.width - tp2.width) / 2, rect.top + 24),
    );
  }

  void _drawArrow(
    Canvas canvas,
    Offset from,
    Offset to,
    Paint paint, {
    String? label,
  }) {
    canvas.drawLine(from, to, paint);
    final double ang =
        (to - from).direction; // radians from origin.
    const double size = 8;
    final Offset tip = to;
    final Offset left = Offset(
      tip.dx - size * _cos(ang - 0.4),
      tip.dy - size * _sin(ang - 0.4),
    );
    final Offset right = Offset(
      tip.dx - size * _cos(ang + 0.4),
      tip.dy - size * _sin(ang + 0.4),
    );
    final Paint fill = Paint()..color = paint.color;
    final Path arrow = Path()
      ..moveTo(tip.dx, tip.dy)
      ..lineTo(left.dx, left.dy)
      ..lineTo(right.dx, right.dy)
      ..close();
    canvas.drawPath(arrow, fill);
    if (label != null) {
      final TextPainter tp = TextPainter(
        text: TextSpan(
          style: TextStyle(
            color: paint.color,
            fontWeight: FontWeight.w800,
            fontSize: 10,
          ),
          text: label,
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(
        canvas,
        Offset((from.dx + to.dx) / 2 + 6, (from.dy + to.dy) / 2 - 14),
      );
    }
  }

  void _label(
    Canvas canvas,
    String text,
    Offset at,
    Color color,
    double size,
  ) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: FontWeight.w800,
        ),
        text: text,
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, at);
  }

  // Tiny trig helpers so we do not depend on dart:math for the script.
  double _cos(double x) {
    // Taylor series up to x^8. Normalise to [-pi, pi].
    double a = x;
    while (a > 3.1415926535) {
      a -= 6.283185307;
    }
    while (a < -3.1415926535) {
      a += 6.283185307;
    }
    final double a2 = a * a;
    return 1 -
        a2 / 2 +
        (a2 * a2) / 24 -
        (a2 * a2 * a2) / 720 +
        (a2 * a2 * a2 * a2) / 40320;
  }

  double _sin(double x) {
    double a = x;
    while (a > 3.1415926535) {
      a -= 6.283185307;
    }
    while (a < -3.1415926535) {
      a += 6.283185307;
    }
    final double a2 = a * a;
    return a -
        (a * a2) / 6 +
        (a * a2 * a2) / 120 -
        (a * a2 * a2 * a2) / 5040;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DiagramLegend extends StatelessWidget {
  const _DiagramLegend();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: <Widget>[
          _LegendChip(
            color: _kAccent,
            label: 'notifier → scope (listen)',
          ),
          _LegendChip(
            color: _kSeed,
            label: 'scope → dependent (rebuild)',
          ),
          _LegendChip(
            color: _kViolet,
            label: 'subtree bounds',
          ),
          _LegendChip(
            color: _kBorder,
            label: 'leaf widget',
          ),
        ],
      ),
    );
  }
}

class _LegendChip extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendChip({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: _kInk,
            ),
          ),
        ],
      ),
    );
  }
}

class _DiagramSteps extends StatelessWidget {
  const _DiagramSteps();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          _StepRow(
            n: 1,
            title: 'Parent builds _CountScope',
            body:
                'Constructor stores the notifier. InheritedNotifier calls '
                'addListener in updateShouldNotify-aware machinery.',
            tone: _kSeed,
          ),
          SizedBox(height: 8),
          _StepRow(
            n: 2,
            title: 'Descendants call .of(context)',
            body:
                'Each dependOnInheritedWidgetOfExactType registers the '
                'dependent element in the scope.',
            tone: _kViolet,
          ),
          SizedBox(height: 8),
          _StepRow(
            n: 3,
            title: 'Something calls notifier.notifyListeners()',
            body:
                'The InheritedNotifier receives it and iterates all '
                'registered dependent elements, calling markNeedsBuild.',
            tone: _kAccent,
          ),
          SizedBox(height: 8),
          _StepRow(
            n: 4,
            title: 'Next frame rebuilds exactly those dependents',
            body:
                'Siblings and other subtrees are not touched. Only elements '
                'that called .of on this exact scope rebuild.',
            tone: _kOk,
          ),
          SizedBox(height: 8),
          _StepRow(
            n: 5,
            title: 'New widget config propagates',
            body:
                'If the parent passes a new notifier instance, the old '
                'listener is removed and a new one attached automatically.',
            tone: _kRose,
          ),
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  final int n;
  final String title;
  final String body;
  final Color tone;
  const _StepRow({
    required this.n,
    required this.title,
    required this.body,
    required this.tone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tone,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$n',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: _kInk,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    color: Color(0xFF425858),
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

// ===========================================================================
// TAB 7 — Comparison table.
// ===========================================================================
class _ComparisonTab extends StatelessWidget {
  const _ComparisonTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 32),
      children: const <Widget>[
        _PageHeader(
          eyebrow: 'comparison',
          title: 'Four ways to share state through the tree',
          subtitle:
              'InheritedNotifier, InheritedWidget, Provider, InheritedModel — '
              'each trades boilerplate for precision. This matrix picks them apart.',
          icon: Icons.compare_arrows_outlined,
          tone: _kRose,
        ),
        _SectionHeader(label: 'Feature matrix'),
        _ComparisonMatrix(),
        _SectionHeader(label: 'Short verdict per tool'),
        _VerdictStack(),
        _SoftDivider(),
        _SectionHeader(label: 'Decision guide'),
        _DecisionGuide(),
        SizedBox(height: 12),
      ],
    );
  }
}

class _ComparisonMatrix extends StatelessWidget {
  const _ComparisonMatrix();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _kBorder),
        ),
        child: const Column(
          children: <Widget>[
            _MatrixRow(
              cells: <String>[
                'feature',
                'InheritedNotifier',
                'InheritedWidget',
                'Provider',
                'InheritedModel',
              ],
              header: true,
            ),
            _MatrixRow(
              cells: <String>[
                'auto-rebuild trigger',
                'notifyListeners()',
                'config change',
                'notifyListeners() + select',
                'config change + aspect',
              ],
            ),
            _MatrixRow(
              cells: <String>[
                'updateShouldNotify',
                'provided',
                'you implement',
                'provided',
                'provided + aspect',
              ],
            ),
            _MatrixRow(
              cells: <String>[
                'boilerplate',
                'tiny',
                'small',
                'medium (package)',
                'medium',
              ],
            ),
            _MatrixRow(
              cells: <String>[
                'partial rebuild',
                'all dependents',
                'all dependents',
                'selected slices',
                'aspect-scoped',
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MatrixRow extends StatelessWidget {
  final List<String> cells;
  final bool header;
  const _MatrixRow({required this.cells, this.header = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: header ? _kSurfaceAlt : Colors.white,
        border: Border(bottom: BorderSide(color: _kBorder.withValues(alpha: 0.7))),
      ),
      child: Row(
        children: <Widget>[
          for (int i = 0; i < cells.length; i++)
            Expanded(
              flex: i == 0 ? 3 : 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  cells[i],
                  style: TextStyle(
                    fontSize: 11.5,
                    color: _kInk,
                    fontWeight: header
                        ? FontWeight.w800
                        : (i == 0 ? FontWeight.w700 : FontWeight.w500),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _VerdictStack extends StatelessWidget {
  const _VerdictStack();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          _VerdictCard(
            title: 'InheritedNotifier',
            verdict: 'Best when you already hold a Listenable.',
            tone: _kSeed,
            icon: Icons.notifications_active_outlined,
          ),
          SizedBox(height: 8),
          _VerdictCard(
            title: 'InheritedWidget',
            verdict:
                'Best when rebuilds are driven by new widget configs only.',
            tone: _kViolet,
            icon: Icons.layers_outlined,
          ),
          SizedBox(height: 8),
          _VerdictCard(
            title: 'Provider',
            verdict:
                'Best when you want declarative scopes + `select` slicing.',
            tone: _kAccent,
            icon: Icons.account_tree_outlined,
          ),
          SizedBox(height: 8),
          _VerdictCard(
            title: 'InheritedModel',
            verdict:
                'Best when dependents care about specific aspects only.',
            tone: _kRose,
            icon: Icons.tune,
          ),
        ],
      ),
    );
  }
}

class _VerdictCard extends StatelessWidget {
  final String title;
  final String verdict;
  final Color tone;
  final IconData icon;
  const _VerdictCard({
    required this.title,
    required this.verdict,
    required this.tone,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: tone),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: tone,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  verdict,
                  style: const TextStyle(
                    color: _kInk,
                    fontSize: 13,
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

class _DecisionGuide extends StatelessWidget {
  const _DecisionGuide();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kAccentSoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kAccent.withValues(alpha: 0.4)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _DecisionLine(
            q: 'Already own a Listenable?',
            ans: 'InheritedNotifier.',
          ),
          _DecisionLine(
            q: 'Rebuild only when config changes?',
            ans: 'InheritedWidget.',
          ),
          _DecisionLine(
            q: 'Want Consumer/Selector conveniences?',
            ans: 'Provider.',
          ),
          _DecisionLine(
            q: 'Need per-aspect precision?',
            ans: 'InheritedModel.',
          ),
        ],
      ),
    );
  }
}

class _DecisionLine extends StatelessWidget {
  final String q;
  final String ans;
  const _DecisionLine({required this.q, required this.ans});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          const Icon(Icons.arrow_forward, size: 16, color: _kInk),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              q,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: _kInk,
                fontSize: 12.5,
              ),
            ),
          ),
          Text(
            ans,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: _kInk,
              fontSize: 12.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 8 — Pitfalls.
// ===========================================================================
class _PitfallsTab extends StatelessWidget {
  const _PitfallsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 32),
      children: const <Widget>[
        _PageHeader(
          eyebrow: 'pitfalls',
          title: 'Mistakes to avoid when subclassing',
          subtitle:
              'InheritedNotifier is small; its footguns are subtle. Each '
              'card below calls out one pattern that breaks perf, equality, '
              'or identity assumptions.',
          icon: Icons.warning_amber_outlined,
          tone: _kBad,
        ),
        _SectionHeader(label: 'Pitfall 1 — rebuilding the whole subtree'),
        _PitfallCard(
          title: 'Rebuilding the whole subtree',
          badExample:
              'Putting heavy widgets as direct children of the scope and '
              'having them call .of(context) — the entire subtree rebuilds '
              'on every notification.',
          goodExample:
              'Split reading into small leaf widgets. Only the leaves call '
              '.of(context), so only the leaves rebuild.',
          tone: _kBad,
        ),
        _SectionHeader(label: 'Pitfall 2 — overriding updateShouldNotify'),
        _PitfallCard(
          title: 'Overriding updateShouldNotify yourself',
          badExample:
              'bool updateShouldNotify(covariant _Scope old) => notifier != '
              'old.notifier; — this fights the base class, which already '
              'compares notifier identity correctly.',
          goodExample:
              'Do not override. If you need extra data, store it on the '
              'Listenable, not on the InheritedNotifier subclass.',
          tone: _kWarn,
        ),
        _SectionHeader(label: 'Pitfall 3 — replacing the Listenable'),
        _PitfallCard(
          title: 'Swapping a fresh Listenable on every rebuild',
          badExample:
              'Passing `notifier: ValueNotifier<int>(0)` inline in build() — '
              'every parent rebuild destroys the old notifier and makes a new '
              'one, so dependents see 0 again and again.',
          goodExample:
              'Own the Listenable at the nearest State / top-level singleton '
              'with a lifetime that outlives the parent widget.',
          tone: _kBad,
        ),
        _SectionHeader(label: 'Pitfall 4 — notifier leaks'),
        _PitfallCard(
          title: 'Forgetting to dispose',
          badExample:
              'Creating a ChangeNotifier in initState but never calling '
              'dispose() — listeners and closures live forever.',
          goodExample:
              'Own the notifier in a StatefulWidget, override dispose(), call '
              'notifier.dispose(). (Top-level notifiers last for the app.)',
          tone: _kWarn,
        ),
        _SectionHeader(label: 'Pitfall 5 — async rebuild storms'),
        _PitfallCard(
          title: 'Firing notifyListeners in a tight loop',
          badExample:
              'Calling notifyListeners() inside every microtask of a hot '
              'stream — descendants rebuild many times per frame.',
          goodExample:
              'Coalesce updates: keep an intermediate buffer, then call '
              'notifyListeners once per frame or once per batch.',
          tone: _kBad,
        ),
        _SectionHeader(label: 'Pitfall 6 — wrong T type'),
        _PitfallCard(
          title: 'T not exactly Listenable-shaped',
          badExample:
              'Using a plain data class as T — it has no addListener, so '
              'InheritedNotifier cannot wire anything.',
          goodExample:
              'Wrap data in ChangeNotifier or ValueNotifier. That is the '
              'whole contract.',
          tone: _kWarn,
        ),
        SizedBox(height: 12),
      ],
    );
  }
}

class _PitfallCard extends StatelessWidget {
  final String title;
  final String badExample;
  final String goodExample;
  final Color tone;
  const _PitfallCard({
    required this.title,
    required this.badExample,
    required this.goodExample,
    required this.tone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: tone.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.report_gmailerrorred_outlined, color: tone),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: tone,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _PitfallBlock(
            tag: 'bad',
            tone: _kBad,
            text: badExample,
          ),
          const SizedBox(height: 8),
          _PitfallBlock(
            tag: 'good',
            tone: _kOk,
            text: goodExample,
          ),
        ],
      ),
    );
  }
}

class _PitfallBlock extends StatelessWidget {
  final String tag;
  final Color tone;
  final String text;
  const _PitfallBlock({
    required this.tag,
    required this.tone,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.45)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: tone,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              tag,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: _kInk,
                fontSize: 12.5,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 9 — Use cases + API cheat sheet + recipe.
// ===========================================================================
class _UseCasesAndApiTab extends StatelessWidget {
  const _UseCasesAndApiTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 32),
      children: const <Widget>[
        _PageHeader(
          eyebrow: 'reference',
          title: 'Use cases, recipe, and API cheat sheet',
          subtitle:
              'Six situations where InheritedNotifier really shines, a full '
              'subclass recipe, and a compact API map.',
          icon: Icons.menu_book_outlined,
          tone: _kAccent,
        ),
        _SectionHeader(label: 'Six use cases'),
        _UseCaseGrid(),
        _SectionHeader(label: 'Subclassing recipe'),
        _RecipeCard(),
        _SectionHeader(label: 'API cheat sheet'),
        _ApiCheatSheet(),
        _SoftDivider(),
        _SectionHeader(label: 'Summary'),
        _SummaryCard(),
        SizedBox(height: 12),
      ],
    );
  }
}

class _UseCaseGrid extends StatelessWidget {
  const _UseCaseGrid();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: _UseCaseCard(
                  icon: Icons.numbers,
                  title: 'Counter',
                  tone: _kSeed,
                  body: 'Minimal reactive global — shopping bag badge, score, step count.',
                  notifierHint: 'ValueNotifier<int>',
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _UseCaseCard(
                  icon: Icons.lock_outline,
                  title: 'Auth state',
                  tone: _kRose,
                  body: 'Signed-in user + token; routes and app bars react on login/logout.',
                  notifierHint: 'AuthListenable',
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: _UseCaseCard(
                  icon: Icons.shopping_cart_outlined,
                  title: 'Cart',
                  tone: _kAccent,
                  body: 'List of items, subtotal, discounts — many widgets watch the summary.',
                  notifierHint: 'CartListenable',
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _UseCaseCard(
                  icon: Icons.palette_outlined,
                  title: 'Theme',
                  tone: _kViolet,
                  body: 'Palette, density, text-scale; swappable at runtime via notifier.',
                  notifierHint: 'PaletteListenable',
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: _UseCaseCard(
                  icon: Icons.swap_vert,
                  title: 'Scroll position',
                  tone: _kOlive,
                  body: 'Sharing a ScrollController so headers, badges, and pagers react.',
                  notifierHint: 'ScrollController',
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _UseCaseCard(
                  icon: Icons.music_note_outlined,
                  title: 'Music player',
                  tone: _kBlueTone,
                  body: 'Playing track, progress, volume — mini-players across the tree.',
                  notifierHint: 'PlayerListenable',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _UseCaseCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color tone;
  final String body;
  final String notifierHint;
  const _UseCaseCard({
    required this.icon,
    required this.title,
    required this.tone,
    required this.body,
    required this.notifierHint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: tone),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: tone,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: const TextStyle(
              fontSize: 12,
              color: _kInk,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 8),
          _CodeChip(notifierHint),
        ],
      ),
    );
  }
}

class _RecipeCard extends StatelessWidget {
  const _RecipeCard();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: _CodeBlock(
        title: 'Subclassing recipe — copy/paste starter',
        lines: <String>[
          '/// 1. Pick (or define) a Listenable.',
          'class ScoreListenable extends ChangeNotifier {',
          '  int _value = 0;',
          '  int get value => _value;',
          '  void bump() { _value++; notifyListeners(); }',
          '}',
          '',
          '/// 2. Write the InheritedNotifier subclass.',
          'class ScoreScope extends InheritedNotifier<ScoreListenable> {',
          '  const ScoreScope({',
          '    super.key,',
          '    required ScoreListenable super.notifier,',
          '    required super.child,',
          '  });',
          '',
          '  static ScoreScope? maybeOf(BuildContext context) =>',
          '      context.dependOnInheritedWidgetOfExactType<ScoreScope>();',
          '',
          '  static ScoreScope of(BuildContext context) {',
          '    final s = maybeOf(context);',
          '    assert(s != null, \'ScoreScope.of: no ScoreScope ancestor.\');',
          '    return s!;',
          '  }',
          '}',
          '',
          '/// 3. Read it anywhere in the tree.',
          'class ScoreBadge extends StatelessWidget {',
          '  const ScoreBadge({super.key});',
          '  @override',
          '  Widget build(BuildContext context) {',
          '    final n = ScoreScope.of(context).notifier!;',
          '    return Text(\'Score: \${n.value}\');',
          '  }',
          '}',
        ],
      ),
    );
  }
}

class _ApiCheatSheet extends StatelessWidget {
  const _ApiCheatSheet();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _kBorder),
        ),
        child: const Column(
          children: <Widget>[
            _ApiRow(
              left: 'Type',
              right: 'InheritedNotifier<T extends Listenable>',
              header: true,
            ),
            _ApiRow(
              left: 'Constructor',
              right: 'InheritedNotifier({Key? key, T? notifier, required Widget child})',
            ),
            _ApiRow(
              left: 'Property',
              right: 'final T? notifier',
            ),
            _ApiRow(
              left: 'Lookup (nullable)',
              right: 'context.dependOnInheritedWidgetOfExactType<MyScope>()',
            ),
            _ApiRow(
              left: 'Convention',
              right: 'static MyScope? maybeOf(BuildContext c)',
            ),
            _ApiRow(
              left: 'Convention',
              right: 'static MyScope of(BuildContext c) => maybeOf(c)!',
            ),
            _ApiRow(
              left: 'Override',
              right: 'do not — updateShouldNotify is handled',
            ),
            _ApiRow(
              left: 'Ownership',
              right: 'caller disposes the Listenable',
            ),
          ],
        ),
      ),
    );
  }
}

class _ApiRow extends StatelessWidget {
  final String left;
  final String right;
  final bool header;
  const _ApiRow({
    required this.left,
    required this.right,
    this.header = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: header ? _kSurfaceAlt : Colors.white,
        border: Border(bottom: BorderSide(color: _kBorder.withValues(alpha: 0.7))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 120,
            child: Text(
              left,
              style: TextStyle(
                color: _kInk,
                fontSize: 12,
                fontWeight: header ? FontWeight.w800 : FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              right,
              style: TextStyle(
                fontFamily: 'monospace',
                color: header ? _kInk : const Color(0xFF2A4949),
                fontSize: 12,
                fontWeight: header ? FontWeight.w800 : FontWeight.w500,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _kInk,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Takeaways',
            style: TextStyle(
              color: Color(0xFF9FBEBE),
              fontWeight: FontWeight.w800,
              letterSpacing: 1.4,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'InheritedNotifier is the smallest full-featured way to scope a '
            'Listenable. You get .of(context) lookups, precise dependent '
            'rebuilds, and no updateShouldNotify boilerplate. Everything you '
            'actually customise lives on the Listenable itself.',
            style: TextStyle(
              color: Color(0xFFE4EFEF),
              fontSize: 13.5,
              height: 1.55,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Use it for: counters, auth, carts, themes, scroll positions, players — '
            'anywhere a Listenable already exists and multiple widgets should track it.',
            style: TextStyle(
              color: Color(0xFFBCD3D3),
              fontSize: 12,
              fontStyle: FontStyle.italic,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}


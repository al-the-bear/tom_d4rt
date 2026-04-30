// D4rt deep demo: KeepAliveHandle — the small Listenable carried inside a
// KeepAliveNotification so a subtree can signal "keep me alive" to an
// ancestor AutomaticKeepAlive and later drop that request by calling
// release() (which notifies listeners).
import 'package:flutter/material.dart';

// ─── Top-level ValueNotifiers (allowed in stateless d4rt demo) ───
final ValueNotifier<int> _tabHint = ValueNotifier<int>(0);
final ValueNotifier<int> _pageIndex = ValueNotifier<int>(0);
final ValueNotifier<int> _counterA = ValueNotifier<int>(0);
final ValueNotifier<int> _counterB = ValueNotifier<int>(0);
final ValueNotifier<int> _counterC = ValueNotifier<int>(0);
final ValueNotifier<int> _counterD = ValueNotifier<int>(0);
final ValueNotifier<int> _counterE = ValueNotifier<int>(0);
final ValueNotifier<bool> _holdA = ValueNotifier<bool>(true);
final ValueNotifier<bool> _holdB = ValueNotifier<bool>(true);
final ValueNotifier<bool> _innerCapture = ValueNotifier<bool>(true);
final ValueNotifier<int> _releaseTick = ValueNotifier<int>(0);

dynamic build(BuildContext context) {
  return const _KeepAliveHandleDemoApp();
}

// ══════════════════════════════════════════════════════════════════════════
//  Root application
// ══════════════════════════════════════════════════════════════════════════
class _KeepAliveHandleDemoApp extends StatelessWidget {
  const _KeepAliveHandleDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KeepAliveHandle Deep Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2B6CB0),
          brightness: Brightness.light,
        ),
        cardTheme: const CardThemeData(
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
      home: const _KeepAliveHandleHome(),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
//  Home with a 9-tab DefaultTabController
// ══════════════════════════════════════════════════════════════════════════
class _KeepAliveHandleHome extends StatelessWidget {
  const _KeepAliveHandleHome();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        backgroundColor: scheme.surfaceContainerLowest,
        appBar: AppBar(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          toolbarHeight: 76,
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'KeepAliveHandle Deep Demo',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 2),
              Text(
                'Listenable handshake between subtree and AutomaticKeepAlive',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(52),
            child: _GuideTabBar(),
          ),
        ),
        body: const SafeArea(
          top: false,
          child: TabBarView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              _HeroTab(),
              _FlowDiagramTab(),
              _LazyListTab(),
              _ReleaseCycleTab(),
              _NestedScopeTab(),
              _PayloadTab(),
              _ContrastTab(),
              _UseCaseTab(),
              _CheatSheetTab(),
            ],
          ),
        ),
        bottomNavigationBar: const _BottomHintBar(),
      ),
    );
  }
}

// ── Guide-style tab bar that lightly animates the hint indicator ───────────
class _GuideTabBar extends StatelessWidget {
  const _GuideTabBar();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      color: scheme.primary,
      child: TabBar(
        isScrollable: true,
        indicatorColor: scheme.onPrimary,
        indicatorWeight: 3,
        labelColor: scheme.onPrimary,
        unselectedLabelColor: scheme.onPrimary.withValues(alpha: 0.7),
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        tabs: const <Widget>[
          Tab(icon: Icon(Icons.auto_awesome), text: 'Overview'),
          Tab(icon: Icon(Icons.account_tree), text: 'Flow'),
          Tab(icon: Icon(Icons.view_carousel), text: 'Lazy list'),
          Tab(icon: Icon(Icons.loop), text: 'Release'),
          Tab(icon: Icon(Icons.layers), text: 'Nested'),
          Tab(icon: Icon(Icons.receipt_long), text: 'Payload'),
          Tab(icon: Icon(Icons.compare_arrows), text: 'Contrast'),
          Tab(icon: Icon(Icons.widgets), text: 'Use cases'),
          Tab(icon: Icon(Icons.list_alt), text: 'Cheat'),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
//  Shared building blocks
// ══════════════════════════════════════════════════════════════════════════
class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.child,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Card(
      color: scheme.surface,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  accent.withValues(alpha: 0.92),
                  accent.withValues(alpha: 0.72),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white.withValues(alpha: 0.22),
                  child: Icon(icon, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.92),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _InlinePill extends StatelessWidget {
  const _InlinePill({
    required this.label,
    required this.background,
    required this.foreground,
    this.icon,
  });

  final String label;
  final Color background;
  final Color foreground;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 14, color: foreground),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: TextStyle(
              color: foreground,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletedLine extends StatelessWidget {
  const _BulletedLine({required this.text, required this.icon, required this.color});
  final String text;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, size: 17, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }
}

class _MonoBlock extends StatelessWidget {
  const _MonoBlock({required this.text, this.accent});
  final String text;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final Color c = accent ?? const Color(0xFF0F172A);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: c,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: SelectableText(
        text,
        style: const TextStyle(
          fontFamily: 'monospace',
          color: Color(0xFFE2E8F0),
          fontSize: 12.5,
          height: 1.45,
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
//  Tab 1 — Hero banner
// ══════════════════════════════════════════════════════════════════════════
class _HeroTab extends StatelessWidget {
  const _HeroTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _HeroBanner(scheme: scheme),
        const SizedBox(height: 16),
        _SectionCard(
          title: '1. What KeepAliveHandle is',
          subtitle: 'A Listenable passed by reference in a KeepAliveNotification',
          icon: Icons.anchor,
          accent: scheme.primary,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _BulletedLine(
                text: 'Tiny Listenable owned by the descendant that wants to stay alive.',
                icon: Icons.check_circle_outline,
                color: Color(0xFF0EA5E9),
              ),
              _BulletedLine(
                text: 'Passed upward inside KeepAliveNotification(handle: ...).',
                icon: Icons.north,
                color: Color(0xFF22C55E),
              ),
              _BulletedLine(
                text: 'Ancestor AutomaticKeepAlive adds a listener on the handle.',
                icon: Icons.hearing,
                color: Color(0xFFA855F7),
              ),
              _BulletedLine(
                text: 'When handle.release() fires notifyListeners, the keep-alive drops.',
                icon: Icons.remove_done,
                color: Color(0xFFEF4444),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _SectionCard(
          title: '2. Role in lazy viewports',
          subtitle: 'SliverList, GridView, PageView, and CustomScrollView slivers',
          icon: Icons.view_list,
          accent: scheme.secondary,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _BulletedLine(
                text: 'Lazy slivers recycle child RenderObjects when offscreen.',
                icon: Icons.recycling,
                color: Color(0xFF2563EB),
              ),
              _BulletedLine(
                text: 'KeepAliveHandle is the opt-out: keep the element mounted.',
                icon: Icons.block,
                color: Color(0xFFDB2777),
              ),
              _BulletedLine(
                text: 'Cheaper than a full Offstage rebuild; state is preserved.',
                icon: Icons.savings,
                color: Color(0xFF059669),
              ),
              _BulletedLine(
                text: 'Used by AutomaticKeepAliveClientMixin under the hood.',
                icon: Icons.extension,
                color: Color(0xFF9333EA),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _SectionCard(
          title: '3. Notification protocol',
          subtitle: 'Why a Notification and not an InheritedWidget',
          icon: Icons.notifications_active,
          accent: scheme.tertiary,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _BulletedLine(
                text: 'Notifications bubble up and are caught by the nearest listener.',
                icon: Icons.trending_up,
                color: Color(0xFFF97316),
              ),
              _BulletedLine(
                text: 'Zero coupling: descendant does not need to know about the sliver type.',
                icon: Icons.lock_open,
                color: Color(0xFF0EA5E9),
              ),
              _BulletedLine(
                text: 'AutomaticKeepAlive captures it in onNotification and stores the handle.',
                icon: Icons.inventory_2,
                color: Color(0xFF14B8A6),
              ),
              _BulletedLine(
                text: 'Descendant later notifies/releases; sliver drops the reference.',
                icon: Icons.cleaning_services,
                color: Color(0xFFE11D48),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _SectionCard(
          title: '4. Mental model',
          subtitle: 'Think of it as a lease with a remote self-destruct button',
          icon: Icons.psychology,
          accent: scheme.primaryContainer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _BulletedLine(
                text: 'The descendant holds the remote; the ancestor keeps the lease.',
                icon: Icons.settings_remote,
                color: Color(0xFF6366F1),
              ),
              const _BulletedLine(
                text: 'Lease starts on notification dispatch, ends on release().',
                icon: Icons.schedule,
                color: Color(0xFF0D9488),
              ),
              const _BulletedLine(
                text: 'No lease means lazy recycling is free to reuse the slot.',
                icon: Icons.open_in_new,
                color: Color(0xFFCA8A04),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: <Widget>[
                  _InlinePill(
                    label: 'extends Listenable',
                    background: scheme.primary.withValues(alpha: 0.12),
                    foreground: scheme.primary,
                    icon: Icons.hub,
                  ),
                  _InlinePill(
                    label: 'carries via KeepAliveNotification',
                    background: scheme.tertiary.withValues(alpha: 0.15),
                    foreground: scheme.tertiary,
                    icon: Icons.send,
                  ),
                  _InlinePill(
                    label: 'release() ≈ notifyListeners()',
                    background: scheme.secondary.withValues(alpha: 0.15),
                    foreground: scheme.secondary,
                    icon: Icons.campaign,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: <Color>[
            scheme.primary,
            scheme.tertiary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.22),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.handyman, color: Colors.white, size: 26),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'class KeepAliveHandle extends Listenable',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'A listener-based lease between descendant and AutomaticKeepAlive',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: <Widget>[
              _InlinePill(
                label: 'release()',
                background: Colors.white.withValues(alpha: 0.16),
                foreground: Colors.white,
                icon: Icons.cut,
              ),
              _InlinePill(
                label: 'addListener',
                background: Colors.white.withValues(alpha: 0.16),
                foreground: Colors.white,
                icon: Icons.hearing,
              ),
              _InlinePill(
                label: 'removeListener',
                background: Colors.white.withValues(alpha: 0.16),
                foreground: Colors.white,
                icon: Icons.hearing_disabled,
              ),
              _InlinePill(
                label: 'notifyListeners',
                background: Colors.white.withValues(alpha: 0.16),
                foreground: Colors.white,
                icon: Icons.campaign,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
//  Tab 2 — Notification flow diagram (CustomPainter)
// ══════════════════════════════════════════════════════════════════════════
class _FlowDiagramTab extends StatelessWidget {
  const _FlowDiagramTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionCard(
          title: 'Notification flow',
          subtitle: 'Descendant dispatches → AutomaticKeepAlive captures → lease active → release drops',
          icon: Icons.account_tree,
          accent: scheme.primary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.1,
                child: CustomPaint(
                  painter: _FlowPainter(scheme: scheme),
                  child: const SizedBox.expand(),
                ),
              ),
              const SizedBox(height: 12),
              const _BulletedLine(
                text: '1. Descendant creates KeepAliveHandle() and stores it.',
                icon: Icons.looks_one,
                color: Color(0xFF2563EB),
              ),
              const _BulletedLine(
                text: '2. Descendant dispatches KeepAliveNotification(handle: ...).',
                icon: Icons.looks_two,
                color: Color(0xFFD97706),
              ),
              const _BulletedLine(
                text: '3. Nearest AutomaticKeepAlive catches in onNotification.',
                icon: Icons.looks_3,
                color: Color(0xFF059669),
              ),
              const _BulletedLine(
                text: '4. AutomaticKeepAlive addListener(handle) to watch release.',
                icon: Icons.looks_4,
                color: Color(0xFF9333EA),
              ),
              const _BulletedLine(
                text: '5. Subtree stays mounted even when scrolled offscreen.',
                icon: Icons.looks_5,
                color: Color(0xFF0891B2),
              ),
              const _BulletedLine(
                text: '6. Descendant later invokes handle.release() → disposed.',
                icon: Icons.looks_6,
                color: Color(0xFFE11D48),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _SectionCard(
          title: 'Why the notification model?',
          subtitle: 'Loose coupling across arbitrary ancestor distance',
          icon: Icons.lightbulb,
          accent: scheme.tertiary,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _BulletedLine(
                text: 'Descendant does not import SliverList implementation details.',
                icon: Icons.scatter_plot,
                color: Color(0xFF0284C7),
              ),
              _BulletedLine(
                text: 'Any AutomaticKeepAlive wrapper can intercept the message.',
                icon: Icons.hub,
                color: Color(0xFF16A34A),
              ),
              _BulletedLine(
                text: 'If no one handles it, the widget simply is not kept alive.',
                icon: Icons.info_outline,
                color: Color(0xFFF59E0B),
              ),
              _BulletedLine(
                text: 'Notification.dispatch is safe from any context in the subtree.',
                icon: Icons.verified,
                color: Color(0xFF7C3AED),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _SectionCard(
          title: 'Listener lifecycle timing',
          subtitle: 'When add/remove happens',
          icon: Icons.timer,
          accent: scheme.secondary,
          child: const _MonoBlock(
            text:
              'dispatch:\n'
              '  KeepAliveNotification(handle).dispatch(context);\n\n'
              'ancestor onNotification:\n'
              '  handle.addListener(_onHandleReleased);\n'
              '  _keepAliveActive = true;\n'
              '  return true;\n\n'
              'release path:\n'
              '  handle.release(); // calls notifyListeners internally\n'
              '  -> _onHandleReleased runs\n'
              '  -> handle.removeListener(_onHandleReleased)\n'
              '  -> _keepAliveActive = false;\n',
          ),
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}

// ── CustomPainter: arrows descendant → AutomaticKeepAlive → subtree ────────
class _FlowPainter extends CustomPainter {
  _FlowPainter({required this.scheme});
  final ColorScheme scheme;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()
      ..color = scheme.surfaceContainerHigh;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(18),
      ),
      bg,
    );

    final double w = size.width;
    final double h = size.height;

    // Descendant node
    final Rect descendant = Rect.fromLTWH(w * 0.08, h * 0.76, w * 0.34, h * 0.14);
    _drawNode(canvas, descendant, scheme.primary, 'Descendant');

    // AutomaticKeepAlive
    final Rect ancestor = Rect.fromLTWH(w * 0.33, h * 0.36, w * 0.34, h * 0.14);
    _drawNode(canvas, ancestor, scheme.tertiary, 'AutomaticKeepAlive');

    // Subtree / Element
    final Rect element = Rect.fromLTWH(w * 0.58, h * 0.76, w * 0.34, h * 0.14);
    _drawNode(canvas, element, scheme.secondary, 'Kept-alive Subtree');

    // Notification source lower left
    final Rect payload = Rect.fromLTWH(w * 0.08, h * 0.05, w * 0.84, h * 0.22);
    _drawPayload(canvas, payload, scheme);

    // Arrows
    _drawArrow(
      canvas,
      Offset(descendant.center.dx, descendant.top),
      Offset(ancestor.center.dx - 30, ancestor.bottom),
      scheme.primary,
      label: 'dispatch()',
    );
    _drawArrow(
      canvas,
      Offset(ancestor.center.dx + 30, ancestor.bottom),
      Offset(element.center.dx, element.top),
      scheme.tertiary,
      label: 'keepAlive=true',
    );
    _drawArrow(
      canvas,
      Offset(element.left + 14, element.center.dy),
      Offset(descendant.right - 14, descendant.center.dy),
      scheme.error,
      label: 'release()',
    );
    _drawArrow(
      canvas,
      Offset(ancestor.center.dx, ancestor.top),
      Offset(payload.center.dx, payload.bottom + 2),
      scheme.outline,
      label: 'KeepAliveNotification',
      dashed: true,
    );
  }

  void _drawNode(Canvas canvas, Rect rect, Color color, String label) {
    final Paint fill = Paint()..color = color.withValues(alpha: 0.85);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(14)),
      fill,
    );
    final Paint shadow = Paint()
      ..color = color.withValues(alpha: 0.25)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect.translate(0, 4), const Radius.circular(14)),
      shadow,
    );
    final TextPainter tp = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      text: TextSpan(
        text: label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ),
    )..layout(maxWidth: rect.width - 10);
    tp.paint(
      canvas,
      Offset(rect.center.dx - tp.width / 2, rect.center.dy - tp.height / 2),
    );
  }

  void _drawPayload(Canvas canvas, Rect rect, ColorScheme scheme) {
    final Paint border = Paint()
      ..color = scheme.outline.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(14)),
      border,
    );
    final TextPainter tp = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      text: TextSpan(
        style: TextStyle(color: scheme.onSurface, fontSize: 12, height: 1.3),
        children: const <InlineSpan>[
          TextSpan(
            text: 'KeepAliveNotification\n',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          TextSpan(
            text: '  final KeepAliveHandle handle;\n',
            style: TextStyle(fontFamily: 'monospace', fontSize: 11),
          ),
          TextSpan(
            text: '  // dispatched by the subtree via Notification.dispatch',
            style: TextStyle(fontFamily: 'monospace', fontSize: 11),
          ),
        ],
      ),
    )..layout(maxWidth: rect.width - 20);
    tp.paint(canvas, Offset(rect.left + 10, rect.top + 10));
  }

  void _drawArrow(
    Canvas canvas,
    Offset a,
    Offset b,
    Color color, {
    String? label,
    bool dashed = false,
  }) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke;
    if (dashed) {
      const double dash = 6;
      const double gap = 4;
      final double len = (b - a).distance;
      final double dx = (b.dx - a.dx) / len;
      final double dy = (b.dy - a.dy) / len;
      double d = 0;
      while (d < len) {
        final Offset s = Offset(a.dx + dx * d, a.dy + dy * d);
        final double e = (d + dash).clamp(0, len);
        final Offset f = Offset(a.dx + dx * e, a.dy + dy * e);
        canvas.drawLine(s, f, paint);
        d += dash + gap;
      }
    } else {
      canvas.drawLine(a, b, paint);
    }

    final double angle =
        (b - a).direction;
    final Path head = Path();
    const double headSize = 10;
    final Offset tip = b;
    final Offset left = Offset(
      tip.dx - headSize * (0.9 * _cos(angle) - 0.4 * _sin(angle)),
      tip.dy - headSize * (0.9 * _sin(angle) + 0.4 * _cos(angle)),
    );
    final Offset right = Offset(
      tip.dx - headSize * (0.9 * _cos(angle) + 0.4 * _sin(angle)),
      tip.dy - headSize * (0.9 * _sin(angle) - 0.4 * _cos(angle)),
    );
    head.moveTo(tip.dx, tip.dy);
    head.lineTo(left.dx, left.dy);
    head.lineTo(right.dx, right.dy);
    head.close();
    canvas.drawPath(head, Paint()..color = color);

    if (label != null) {
      final TextPainter tp = TextPainter(
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        text: TextSpan(
          text: label,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            backgroundColor: Colors.white.withValues(alpha: 0.75),
          ),
        ),
      )..layout();
      final Offset mid = Offset((a.dx + b.dx) / 2, (a.dy + b.dy) / 2);
      tp.paint(canvas, Offset(mid.dx - tp.width / 2, mid.dy - tp.height / 2));
    }
  }

  double _cos(double r) => _taylorCos(r);
  double _sin(double r) => _taylorSin(r);

  double _taylorCos(double r) {
    // Normalize to [-pi, pi]
    double x = r;
    const double twoPi = 6.283185307179586;
    while (x > 3.141592653589793) {
      x -= twoPi;
    }
    while (x < -3.141592653589793) {
      x += twoPi;
    }
    final double x2 = x * x;
    return 1 - x2 / 2 + x2 * x2 / 24 - x2 * x2 * x2 / 720;
  }

  double _taylorSin(double r) {
    double x = r;
    const double twoPi = 6.283185307179586;
    while (x > 3.141592653589793) {
      x -= twoPi;
    }
    while (x < -3.141592653589793) {
      x += twoPi;
    }
    final double x2 = x * x;
    return x - x * x2 / 6 + x * x2 * x2 / 120 - x * x2 * x2 * x2 / 5040;
  }

  @override
  bool shouldRepaint(covariant _FlowPainter oldDelegate) =>
      oldDelegate.scheme != scheme;
}

// ══════════════════════════════════════════════════════════════════════════
//  Tab 3 — Simulated lazy list (PageView with counters)
// ══════════════════════════════════════════════════════════════════════════
class _LazyListTab extends StatelessWidget {
  const _LazyListTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final List<ValueNotifier<int>> counters = <ValueNotifier<int>>[
      _counterA,
      _counterB,
      _counterC,
      _counterD,
      _counterE,
    ];
    final List<String> titles = <String>[
      'Page 1 — Filter form',
      'Page 2 — Search history',
      'Page 3 — Media player',
      'Page 4 — Draft notes',
      'Page 5 — Cart',
    ];
    final List<Color> pageColors = <Color>[
      const Color(0xFF2563EB),
      const Color(0xFF0891B2),
      const Color(0xFFCA8A04),
      const Color(0xFF16A34A),
      const Color(0xFFDB2777),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionCard(
          title: 'Simulated lazy list',
          subtitle:
              'PageView with 5 pages; counters persist thanks to keep-alive semantics',
          icon: Icons.view_carousel,
          accent: scheme.primary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: scheme.primaryContainer.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'In a real app the page State would use AutomaticKeepAliveClientMixin, '
                      'which internally creates a KeepAliveHandle and dispatches '
                      'KeepAliveNotification(handle: ...). Here we simulate the outcome: '
                      'each page stores its counter in a top-level ValueNotifier so its '
                      'state "survives" the swipes regardless of page rebuilds.',
                      style: TextStyle(
                        color: scheme.onPrimaryContainer,
                        fontSize: 12.5,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: <Widget>[
                        _InlinePill(
                          label: 'handle held',
                          background: scheme.primary.withValues(alpha: 0.16),
                          foreground: scheme.primary,
                          icon: Icons.link,
                        ),
                        _InlinePill(
                          label: 'state preserved',
                          background: scheme.secondary.withValues(alpha: 0.18),
                          foreground: scheme.secondary,
                          icon: Icons.memory,
                        ),
                        _InlinePill(
                          label: 'no rebuild thrash',
                          background: scheme.tertiary.withValues(alpha: 0.18),
                          foreground: scheme.tertiary,
                          icon: Icons.speed,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 340,
                child: Stack(
                  children: <Widget>[
                    ValueListenableBuilder<int>(
                      valueListenable: _pageIndex,
                      builder: (BuildContext context, int idx, Widget? _) {
                        return _LazyPageView(
                          index: idx,
                          counters: counters,
                          titles: titles,
                          pageColors: pageColors,
                        );
                      },
                    ),
                    Positioned(
                      left: 12,
                      right: 12,
                      bottom: 8,
                      child: _PageIndicatorRow(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _CounterSummaryRow(counters: counters, titles: titles),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _SectionCard(
          title: 'Observe',
          subtitle: 'Interact with each page, then swipe away and back',
          icon: Icons.visibility,
          accent: scheme.secondary,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _BulletedLine(
                text: 'Counter value remains after navigating off-page.',
                icon: Icons.check_circle,
                color: Color(0xFF16A34A),
              ),
              _BulletedLine(
                text: 'Without keep-alive, the State would be disposed and reset.',
                icon: Icons.cancel,
                color: Color(0xFFEF4444),
              ),
              _BulletedLine(
                text: 'The handle is the mechanism, the mixin is the convenience.',
                icon: Icons.sticky_note_2,
                color: Color(0xFF0891B2),
              ),
              _BulletedLine(
                text: 'This simulation skips the element-level bookkeeping on purpose.',
                icon: Icons.info_outline,
                color: Color(0xFFCA8A04),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}

class _LazyPageView extends StatelessWidget {
  const _LazyPageView({
    required this.index,
    required this.counters,
    required this.titles,
    required this.pageColors,
  });
  final int index;
  final List<ValueNotifier<int>> counters;
  final List<String> titles;
  final List<Color> pageColors;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _SimulatedPage(
          key: ValueKey<int>(index),
          title: titles[index],
          color: pageColors[index],
          counter: counters[index],
          pageIndex: index,
        ),
      ),
    );
  }
}

class _SimulatedPage extends StatelessWidget {
  const _SimulatedPage({
    super.key,
    required this.title,
    required this.color,
    required this.counter,
    required this.pageIndex,
  });
  final String title;
  final Color color;
  final ValueNotifier<int> counter;
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            color.withValues(alpha: 0.92),
            color.withValues(alpha: 0.68),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(18, 22, 18, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Simulated lazy page with preserved counter state.',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: Center(
              child: ValueListenableBuilder<int>(
                valueListenable: counter,
                builder: (BuildContext context, int value, Widget? _) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.16),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.38),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '$value',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 44,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Page $pageIndex — counter value kept alive',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _PageButton(
                icon: Icons.remove,
                label: '-1',
                onPressed: () => counter.value -= 1,
              ),
              _PageButton(
                icon: Icons.refresh,
                label: 'Reset',
                onPressed: () => counter.value = 0,
              ),
              _PageButton(
                icon: Icons.add,
                label: '+1',
                onPressed: () => counter.value += 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PageButton extends StatelessWidget {
  const _PageButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withValues(alpha: 0.2),
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.white.withValues(alpha: 0.5)),
        ),
      ),
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
    );
  }
}

class _PageIndicatorRow extends StatelessWidget {
  const _PageIndicatorRow();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _pageIndex,
      builder: (BuildContext context, int current, Widget? _) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.28),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                visualDensity: VisualDensity.compact,
                color: Colors.white,
                onPressed: () {
                  if (current > 0) _pageIndex.value = current - 1;
                },
                icon: const Icon(Icons.chevron_left),
              ),
              for (int i = 0; i < 5; i++)
                GestureDetector(
                  onTap: () => _pageIndex.value = i,
                  child: Container(
                    width: i == current ? 22 : 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: i == current
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              IconButton(
                visualDensity: VisualDensity.compact,
                color: Colors.white,
                onPressed: () {
                  if (current < 4) _pageIndex.value = current + 1;
                },
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CounterSummaryRow extends StatelessWidget {
  const _CounterSummaryRow({required this.counters, required this.titles});
  final List<ValueNotifier<int>> counters;
  final List<String> titles;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: <Widget>[
        for (int i = 0; i < counters.length; i++)
          ValueListenableBuilder<int>(
            valueListenable: counters[i],
            builder: (BuildContext context, int v, Widget? _) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.bookmark, size: 14, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 6),
                    Text(
                      '${titles[i]}  ·  counter=$v',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
//  Tab 4 — Release cycle simulation
// ══════════════════════════════════════════════════════════════════════════
class _ReleaseCycleTab extends StatelessWidget {
  const _ReleaseCycleTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionCard(
          title: 'Release cycle simulation',
          subtitle: 'Hold and release a simulated KeepAliveHandle',
          icon: Icons.loop,
          accent: scheme.primary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: _HoldReleasePanel(
                      title: 'Subtree A',
                      color: const Color(0xFF2563EB),
                      hold: _holdA,
                      counter: _counterA,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _HoldReleasePanel(
                      title: 'Subtree B',
                      color: const Color(0xFFDB2777),
                      hold: _holdB,
                      counter: _counterB,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ValueListenableBuilder<int>(
                valueListenable: _releaseTick,
                builder: (BuildContext context, int tick, Widget? _) {
                  return _ReleaseTimeline(tick: tick);
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _SectionCard(
          title: 'Reading the banner',
          subtitle: 'Green = kept alive • Red = released and disposed',
          icon: Icons.traffic,
          accent: scheme.tertiary,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _BulletedLine(
                text: 'Toggling the checkbox simulates a renewed keep-alive request.',
                icon: Icons.check_box,
                color: Color(0xFF16A34A),
              ),
              _BulletedLine(
                text: 'Pressing Release calls handle.release(); banner turns red.',
                icon: Icons.stop_circle,
                color: Color(0xFFE11D48),
              ),
              _BulletedLine(
                text: 'Counters represent state that would be lost on disposal.',
                icon: Icons.inbox,
                color: Color(0xFFCA8A04),
              ),
              _BulletedLine(
                text: 'In the real API, dispose() typically calls release() as well.',
                icon: Icons.delete_sweep,
                color: Color(0xFF2563EB),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _SectionCard(
          title: 'Release implementation sketch',
          subtitle: 'What release() actually does',
          icon: Icons.code,
          accent: scheme.secondary,
          child: const _MonoBlock(
            text:
              'class KeepAliveHandle extends ChangeNotifier implements Listenable {\n'
              '  void release() {\n'
              '    notifyListeners();\n'
              '    dispose();\n'
              '  }\n'
              '}\n\n'
              '// Listener registered by AutomaticKeepAlive:\n'
              'void _onHandleReleased() {\n'
              '  _handle?.removeListener(_onHandleReleased);\n'
              '  _handle = null;\n'
              '  updateKeepAlive();\n'
              '}\n',
          ),
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}

class _HoldReleasePanel extends StatelessWidget {
  const _HoldReleasePanel({
    required this.title,
    required this.color,
    required this.hold,
    required this.counter,
  });
  final String title;
  final Color color;
  final ValueNotifier<bool> hold;
  final ValueNotifier<int> counter;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: hold,
      builder: (BuildContext context, bool held, Widget? _) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: held
                ? color.withValues(alpha: 0.08)
                : Colors.red.withValues(alpha: 0.06),
            border: Border.all(
              color: held
                  ? color.withValues(alpha: 0.5)
                  : Colors.red.withValues(alpha: 0.6),
              width: 1.4,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    held ? Icons.link : Icons.link_off,
                    color: held ? color : Colors.red,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    title,
                    style: TextStyle(
                      color: held ? color : Colors.red,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              AnimatedContainer(
                duration: const Duration(milliseconds: 260),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: held ? const Color(0xFFDCFCE7) : const Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      held ? Icons.verified : Icons.report,
                      color: held
                          ? const Color(0xFF166534)
                          : const Color(0xFF991B1B),
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      held ? 'kept alive' : 'subtree disposed',
                      style: TextStyle(
                        color: held
                            ? const Color(0xFF166534)
                            : const Color(0xFF991B1B),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ValueListenableBuilder<int>(
                valueListenable: counter,
                builder: (BuildContext context, int v, Widget? _) {
                  return Row(
                    children: <Widget>[
                      Text(
                        'counter: $v',
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12.5,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: held ? () => counter.value++ : null,
                        icon: const Icon(Icons.add_circle_outline),
                        iconSize: 20,
                      ),
                    ],
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: held,
                        onChanged: (bool? v) {
                          hold.value = v ?? false;
                          _releaseTick.value++;
                        },
                      ),
                      const Text('hold handle', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  TextButton.icon(
                    onPressed: held
                        ? () {
                            hold.value = false;
                            _releaseTick.value++;
                          }
                        : null,
                    icon: const Icon(Icons.cut, size: 16),
                    label: const Text('release()'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ReleaseTimeline extends StatelessWidget {
  const _ReleaseTimeline({required this.tick});
  final int tick;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.timeline, size: 16, color: scheme.primary),
              const SizedBox(width: 6),
              Text(
                'Release-cycle activity  ·  tick $tick',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 10),
          AspectRatio(
            aspectRatio: 4.6,
            child: CustomPaint(
              painter: _TimelinePainter(tick: tick, scheme: scheme),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Green pulses = keep-alive renewed.  Red mark = handle.release().',
            style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _TimelinePainter extends CustomPainter {
  _TimelinePainter({required this.tick, required this.scheme});
  final int tick;
  final ColorScheme scheme;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint line = Paint()
      ..color = scheme.outline
      ..strokeWidth = 1.6;
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      line,
    );
    final Paint pulse = Paint()..color = const Color(0xFF16A34A);
    final Paint release = Paint()..color = const Color(0xFFE11D48);
    final int marks = (tick.abs() % 12) + 3;
    for (int i = 0; i < marks; i++) {
      final double x = size.width * (i + 1) / (marks + 1);
      final bool isRelease = i % 4 == 3;
      final double r = isRelease ? 7 : 5;
      canvas.drawCircle(
        Offset(x, size.height / 2),
        r,
        isRelease ? release : pulse,
      );
      final TextPainter tp = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          text: isRelease ? 'R' : '•',
          style: TextStyle(
            color: Colors.white,
            fontSize: isRelease ? 9 : 10,
            fontWeight: FontWeight.w800,
          ),
        ),
      )..layout();
      tp.paint(
        canvas,
        Offset(x - tp.width / 2, size.height / 2 - tp.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _TimelinePainter oldDelegate) =>
      oldDelegate.tick != tick || oldDelegate.scheme != scheme;
}

// ══════════════════════════════════════════════════════════════════════════
//  Tab 5 — Nested keep-alive scopes
// ══════════════════════════════════════════════════════════════════════════
class _NestedScopeTab extends StatelessWidget {
  const _NestedScopeTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionCard(
          title: 'Nested AutomaticKeepAlive',
          subtitle: 'The nearest ancestor wins — inner scope captures the handle',
          icon: Icons.layers,
          accent: scheme.primary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ValueListenableBuilder<bool>(
                valueListenable: _innerCapture,
                builder: (BuildContext context, bool innerWins, Widget? _) {
                  return _NestedDiagram(innerWins: innerWins);
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: <Widget>[
                  const Text('Simulated handle captured by:'),
                  const SizedBox(width: 8),
                  ValueListenableBuilder<bool>(
                    valueListenable: _innerCapture,
                    builder: (BuildContext context, bool innerWins, Widget? _) {
                      return SegmentedButton<bool>(
                        segments: const <ButtonSegment<bool>>[
                          ButtonSegment<bool>(
                            value: true,
                            label: Text('Inner'),
                            icon: Icon(Icons.crop_square),
                          ),
                          ButtonSegment<bool>(
                            value: false,
                            label: Text('Outer'),
                            icon: Icon(Icons.layers_outlined),
                          ),
                        ],
                        selected: <bool>{innerWins},
                        onSelectionChanged: (Set<bool> v) {
                          _innerCapture.value = v.first;
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const _BulletedLine(
                text: 'Notifications bubble up and the first listener returning true absorbs them.',
                icon: Icons.arrow_upward,
                color: Color(0xFF2563EB),
              ),
              const _BulletedLine(
                text: 'Real AutomaticKeepAlive returns true from onNotification.',
                icon: Icons.check_circle,
                color: Color(0xFF16A34A),
              ),
              const _BulletedLine(
                text: 'Outer scope will only see it if the inner one intentionally re-dispatches.',
                icon: Icons.swap_vert,
                color: Color(0xFF9333EA),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _SectionCard(
          title: 'Why the inner scope typically wins',
          subtitle: 'Flutter notification semantics',
          icon: Icons.rule,
          accent: scheme.secondary,
          child: const _MonoBlock(
            text:
              '// Descendant dispatches the notification.\n'
              'KeepAliveNotification(handle).dispatch(context);\n\n'
              '// Flutter walks up. First NotificationListener that\n'
              '// handles the type AND returns true stops the bubbling.\n'
              'NotificationListener<KeepAliveNotification>(\n'
              '  onNotification: (KeepAliveNotification n) {\n'
              '    _handle = n.handle..addListener(_onHandleReleased);\n'
              '    return true; // absorbed here — outer scope never sees it\n'
              '  },\n'
              '  child: ...,\n'
              ');\n',
          ),
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}

class _NestedDiagram extends StatelessWidget {
  const _NestedDiagram({required this.innerWins});
  final bool innerWins;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return AspectRatio(
      aspectRatio: 1.6,
      child: CustomPaint(
        painter: _NestedPainter(innerWins: innerWins, scheme: scheme),
      ),
    );
  }
}

class _NestedPainter extends CustomPainter {
  _NestedPainter({required this.innerWins, required this.scheme});
  final bool innerWins;
  final ColorScheme scheme;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = scheme.surfaceContainerLow;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(16),
      ),
      bg,
    );

    // Outer ancestor frame
    final Rect outer = Rect.fromLTWH(
      size.width * 0.05,
      size.height * 0.08,
      size.width * 0.9,
      size.height * 0.84,
    );
    final Color outerColor = innerWins
        ? scheme.outline.withValues(alpha: 0.5)
        : scheme.primary;
    final Paint outerBorder = Paint()
      ..color = outerColor
      ..strokeWidth = innerWins ? 1.6 : 3
      ..style = PaintingStyle.stroke;
    canvas.drawRRect(
      RRect.fromRectAndRadius(outer, const Radius.circular(14)),
      outerBorder,
    );
    _text(
      canvas,
      Offset(outer.left + 10, outer.top + 8),
      'Outer AutomaticKeepAlive',
      outerColor,
    );

    // Inner ancestor
    final Rect inner = Rect.fromLTWH(
      outer.left + outer.width * 0.12,
      outer.top + outer.height * 0.28,
      outer.width * 0.76,
      outer.height * 0.48,
    );
    final Color innerColor = innerWins ? scheme.primary : scheme.outline.withValues(alpha: 0.6);
    final Paint innerBorder = Paint()
      ..color = innerColor
      ..strokeWidth = innerWins ? 3 : 1.6
      ..style = PaintingStyle.stroke;
    canvas.drawRRect(
      RRect.fromRectAndRadius(inner, const Radius.circular(12)),
      innerBorder,
    );
    _text(
      canvas,
      Offset(inner.left + 10, inner.top + 8),
      'Inner AutomaticKeepAlive',
      innerColor,
    );

    // Descendant node at bottom of inner
    final Rect child = Rect.fromLTWH(
      inner.left + inner.width * 0.30,
      inner.top + inner.height * 0.58,
      inner.width * 0.40,
      inner.height * 0.32,
    );
    final Paint childFill = Paint()..color = scheme.tertiary.withValues(alpha: 0.85);
    canvas.drawRRect(
      RRect.fromRectAndRadius(child, const Radius.circular(10)),
      childFill,
    );
    _text(
      canvas,
      Offset(child.left + 10, child.center.dy - 8),
      'Descendant (dispatch)',
      Colors.white,
      bold: true,
    );

    // Arrow up stopping at winner
    final Offset from = Offset(child.center.dx, child.top);
    final Offset target = innerWins
        ? Offset(inner.center.dx, inner.top + 22)
        : Offset(outer.center.dx, outer.top + 22);
    final Paint arrow = Paint()
      ..color = innerWins ? scheme.primary : scheme.error
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(from, target, arrow);
    final Path head = Path()
      ..moveTo(target.dx, target.dy)
      ..lineTo(target.dx - 7, target.dy + 10)
      ..lineTo(target.dx + 7, target.dy + 10)
      ..close();
    canvas.drawPath(head, Paint()..color = arrow.color);
  }

  void _text(Canvas c, Offset o, String s, Color color, {bool bold = false}) {
    final TextPainter tp = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: s,
        style: TextStyle(
          color: color,
          fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
          fontSize: 12,
        ),
      ),
    )..layout();
    tp.paint(c, o);
  }

  @override
  bool shouldRepaint(covariant _NestedPainter oldDelegate) =>
      oldDelegate.innerWins != innerWins || oldDelegate.scheme != scheme;
}

// ══════════════════════════════════════════════════════════════════════════
//  Tab 6 — Payload view
// ══════════════════════════════════════════════════════════════════════════
class _PayloadTab extends StatelessWidget {
  const _PayloadTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionCard(
          title: 'KeepAliveNotification payload',
          subtitle: 'The value object that carries the handle',
          icon: Icons.receipt_long,
          accent: scheme.primary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _MonoBlock(
                text:
                  'class KeepAliveNotification extends Notification {\n'
                  '  const KeepAliveNotification(this.handle);\n\n'
                  '  /// A listenable whose notifyListeners() indicates the\n'
                  '  /// descendant no longer needs to be kept alive.\n'
                  '  final KeepAliveHandle handle;\n'
                  '}\n',
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: scheme.primaryContainer.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _BulletedLine(
                      text: 'Payload is immutable; only the handle\'s state changes.',
                      icon: Icons.lock,
                      color: Color(0xFF2563EB),
                    ),
                    _BulletedLine(
                      text: 'Reference equality identifies the request at the sliver.',
                      icon: Icons.compare,
                      color: Color(0xFF059669),
                    ),
                    _BulletedLine(
                      text: 'Dispatching a second notification with a new handle replaces the lease.',
                      icon: Icons.swap_horiz,
                      color: Color(0xFF9333EA),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _SectionCard(
          title: 'KeepAliveHandle surface',
          subtitle: 'Minimal methods, all delegating to Listenable',
          icon: Icons.interests,
          accent: scheme.tertiary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _MonoBlock(
                text:
                  'class KeepAliveHandle extends ChangeNotifier implements Listenable {\n'
                  '  /// Mark the descendant as no longer needing keep-alive.\n'
                  '  void release() => notifyListeners();\n\n'
                  '  // Inherited:\n'
                  '  void addListener(VoidCallback listener);\n'
                  '  void removeListener(VoidCallback listener);\n'
                  '  @protected void notifyListeners();\n'
                  '}\n',
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 8,
                children: <Widget>[
                  _InlinePill(
                    label: 'extends Listenable',
                    background: scheme.primary.withValues(alpha: 0.12),
                    foreground: scheme.primary,
                    icon: Icons.hub,
                  ),
                  _InlinePill(
                    label: 'single-use',
                    background: scheme.secondary.withValues(alpha: 0.15),
                    foreground: scheme.secondary,
                    icon: Icons.looks_one,
                  ),
                  _InlinePill(
                    label: 'no arguments',
                    background: scheme.tertiary.withValues(alpha: 0.18),
                    foreground: scheme.tertiary,
                    icon: Icons.vertical_align_center,
                  ),
                  _InlinePill(
                    label: 'thread-safe on main isolate',
                    background: scheme.error.withValues(alpha: 0.12),
                    foreground: scheme.error,
                    icon: Icons.flash_on,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _SectionCard(
          title: 'Payload timeline',
          subtitle: 'From construction to garbage collection',
          icon: Icons.stacked_line_chart,
          accent: scheme.secondary,
          child: _PayloadTimelineDiagram(scheme: scheme),
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}

class _PayloadTimelineDiagram extends StatelessWidget {
  const _PayloadTimelineDiagram({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final List<_PayloadStage> stages = <_PayloadStage>[
      _PayloadStage('new KeepAliveHandle()', scheme.primary, Icons.add_circle),
      _PayloadStage('wrap in KeepAliveNotification', scheme.secondary, Icons.inventory),
      _PayloadStage('dispatch(context)', scheme.tertiary, Icons.send),
      _PayloadStage('ancestor.addListener(handle)', scheme.primary, Icons.hearing),
      _PayloadStage('subtree kept alive', Colors.green, Icons.eco),
      _PayloadStage('handle.release()', Colors.red, Icons.cut),
      _PayloadStage('ancestor.removeListener', scheme.outline, Icons.hearing_disabled),
      _PayloadStage('handle eligible for GC', scheme.onSurfaceVariant, Icons.delete_sweep),
    ];
    return Column(
      children: <Widget>[
        for (int i = 0; i < stages.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: <Widget>[
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: stages[i].color,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(stages[i].icon, color: stages[i].color, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    stages[i].label,
                    style: const TextStyle(fontSize: 12.5, fontFamily: 'monospace'),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _PayloadStage {
  const _PayloadStage(this.label, this.color, this.icon);
  final String label;
  final Color color;
  final IconData icon;
}

// ══════════════════════════════════════════════════════════════════════════
//  Tab 7 — Contrast with AutomaticKeepAliveClientMixin
// ══════════════════════════════════════════════════════════════════════════
class _ContrastTab extends StatelessWidget {
  const _ContrastTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionCard(
          title: 'Two paths to the same lease',
          subtitle: 'Mixin convenience vs raw notification + handle',
          icon: Icons.compare_arrows,
          accent: scheme.primary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: _PathCard(
                      title: 'A. AutomaticKeepAliveClientMixin',
                      badgeText: 'convenience',
                      color: scheme.primary,
                      icon: Icons.extension,
                      bullets: const <String>[
                        'Mixin on State<T>.',
                        'Override wantKeepAlive getter.',
                        'Call super.build(context) inside build.',
                        'Mixin manages handle internally.',
                      ],
                      snippet:
                          'class _PageState extends State<Page>\n'
                          '    with AutomaticKeepAliveClientMixin {\n'
                          '  @override bool get wantKeepAlive => true;\n\n'
                          '  @override Widget build(BuildContext context) {\n'
                          '    super.build(context); // required\n'
                          '    return ...;\n'
                          '  }\n'
                          '}',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _PathCard(
                      title: 'B. Raw KeepAliveNotification',
                      badgeText: 'manual',
                      color: scheme.tertiary,
                      icon: Icons.build,
                      bullets: const <String>[
                        'Own a KeepAliveHandle instance.',
                        'Dispatch KeepAliveNotification from any leaf.',
                        'Call handle.release() when finished.',
                        'Useful when you are not a State object.',
                      ],
                      snippet:
                          'final KeepAliveHandle h = KeepAliveHandle();\n\n'
                          'void request(BuildContext context) {\n'
                          '  KeepAliveNotification(h).dispatch(context);\n'
                          '}\n\n'
                          'void stop() {\n'
                          '  h.release(); // ChangeNotifier notify\n'
                          '}',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              AspectRatio(
                aspectRatio: 2.2,
                child: CustomPaint(
                  painter: _ContrastPainter(scheme: scheme),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _SectionCard(
          title: 'When to pick which',
          subtitle: 'Decision matrix',
          icon: Icons.balance,
          accent: scheme.secondary,
          child: const _DecisionTable(),
        ),
        const SizedBox(height: 14),
        _SectionCard(
          title: 'Under the hood',
          subtitle: 'The mixin is syntactic sugar around the handle',
          icon: Icons.lightbulb,
          accent: scheme.tertiary,
          child: const _MonoBlock(
            text:
              'mixin AutomaticKeepAliveClientMixin<T extends StatefulWidget> on State<T> {\n'
              '  KeepAliveHandle? _keepAliveHandle;\n\n'
              '  @mustCallSuper\n'
              '  void build(BuildContext context) {\n'
              '    if (wantKeepAlive) {\n'
              '      _keepAliveHandle ??= KeepAliveHandle();\n'
              '      KeepAliveNotification(_keepAliveHandle!).dispatch(context);\n'
              '    } else {\n'
              '      _releaseKeepAlive();\n'
              '    }\n'
              '  }\n'
              '}\n',
          ),
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}

class _PathCard extends StatelessWidget {
  const _PathCard({
    required this.title,
    required this.badgeText,
    required this.color,
    required this.icon,
    required this.bullets,
    required this.snippet,
  });

  final String title;
  final String badgeText;
  final Color color;
  final IconData icon;
  final List<String> bullets;
  final String snippet;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          _InlinePill(
            label: badgeText,
            background: color.withValues(alpha: 0.15),
            foreground: color,
          ),
          const SizedBox(height: 10),
          for (final String b in bullets)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.arrow_right, size: 16, color: color),
                  Expanded(
                    child: Text(b, style: const TextStyle(fontSize: 12.5, height: 1.35)),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 10),
          _MonoBlock(text: snippet, accent: const Color(0xFF1E293B)),
        ],
      ),
    );
  }
}

class _ContrastPainter extends CustomPainter {
  _ContrastPainter({required this.scheme});
  final ColorScheme scheme;

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final Paint bg = Paint()..color = scheme.surfaceContainerLow;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, w, h),
        const Radius.circular(14),
      ),
      bg,
    );

    // Path A: top row
    _drawRow(
      canvas,
      Offset(0, h * 0.25),
      w,
      scheme.primary,
      'State.build → super.build → KeepAliveNotification(handle)',
    );
    // Path B: bottom row
    _drawRow(
      canvas,
      Offset(0, h * 0.72),
      w,
      scheme.tertiary,
      'your code → dispatch(KeepAliveNotification(handle)) → release()',
    );
  }

  void _drawRow(Canvas canvas, Offset start, double width, Color color, String label) {
    final Paint line = Paint()
      ..color = color
      ..strokeWidth = 2.4;
    canvas.drawLine(
      Offset(start.dx + 20, start.dy),
      Offset(start.dx + width - 20, start.dy),
      line,
    );
    for (double x = start.dx + 30; x < start.dx + width - 30; x += 62) {
      canvas.drawCircle(Offset(x, start.dy), 4, Paint()..color = color);
    }
    final TextPainter tp = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: color,
          fontFamily: 'monospace',
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    )..layout(maxWidth: width - 40);
    tp.paint(canvas, Offset(start.dx + 20, start.dy + 8));
  }

  @override
  bool shouldRepaint(covariant _ContrastPainter oldDelegate) =>
      oldDelegate.scheme != scheme;
}

class _DecisionTable extends StatelessWidget {
  const _DecisionTable();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final List<List<String>> rows = <List<String>>[
      <String>['You are a State<T>', 'Mixin', 'Easier and conventional'],
      <String>['You are a StatelessWidget', 'Handle', 'No State, no mixin'],
      <String>['You want dynamic want/don\'t want', 'Mixin', 'Toggle wantKeepAlive'],
      <String>['You need the lease only briefly', 'Handle', 'Control exact release()'],
      <String>['Multiple independent leases', 'Handle', 'One per request'],
      <String>['Cross-tree signalling', 'Handle', 'Mixin is element-local'],
    ];
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: 0.12),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          ),
          child: Row(
            children: const <Widget>[
              Expanded(flex: 4, child: Text('Situation', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
              Expanded(flex: 2, child: Text('Pick', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
              Expanded(flex: 4, child: Text('Why', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
            ],
          ),
        ),
        for (int i = 0; i < rows.length; i++)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: i.isEven
                  ? scheme.surfaceContainerHigh
                  : scheme.surfaceContainerLow,
              border: Border(
                bottom: BorderSide(color: scheme.outlineVariant, width: 0.5),
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(flex: 4, child: Text(rows[i][0], style: const TextStyle(fontSize: 12))),
                Expanded(flex: 2, child: Text(rows[i][1], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700))),
                Expanded(flex: 4, child: Text(rows[i][2], style: const TextStyle(fontSize: 12))),
              ],
            ),
          ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
//  Tab 8 — Use cases (6 cards)
// ══════════════════════════════════════════════════════════════════════════
class _UseCaseTab extends StatelessWidget {
  const _UseCaseTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final List<_UseCase> cases = <_UseCase>[
      const _UseCase(
        title: 'Expensive video player',
        icon: Icons.ondemand_video,
        color: Color(0xFF2563EB),
        blurb:
            'Re-initializing a video decoder costs frames. Hold a handle while the tab is in the carousel so playback survives tab swipes.',
        sample:
            'final handle = KeepAliveHandle();\n'
            'KeepAliveNotification(handle).dispatch(ctx);\n'
            '// ...on tab dispose:\n'
            'handle.release();',
      ),
      const _UseCase(
        title: 'WebView tab',
        icon: Icons.public,
        color: Color(0xFF059669),
        blurb:
            'Keep the WebView element alive so its navigation history, cookies, and scroll state persist across container swipes.',
        sample:
            '// AutomaticKeepAliveClientMixin version\n'
            'bool get wantKeepAlive => widget.persistent;\n'
            '@override Widget build(BuildContext c) {\n'
            '  super.build(c);\n'
            '  return WebViewWidget(controller: _controller);\n'
            '}',
      ),
      const _UseCase(
        title: 'Long-running stream subscription',
        icon: Icons.stream,
        color: Color(0xFFCA8A04),
        blurb:
            'A subscription that you want to outlive scroll recycling. Manual handle pattern avoids rebuilding State just to hold one listener.',
        sample:
            'final handle = KeepAliveHandle();\n'
            'final sub = stream.listen(_onEvent);\n'
            'KeepAliveNotification(handle).dispatch(ctx);\n'
            '// later:\n'
            'sub.cancel();\n'
            'handle.release();',
      ),
      const _UseCase(
        title: 'Local state preservation',
        icon: Icons.memory,
        color: Color(0xFFDB2777),
        blurb:
            'Complex expanded panels, selection states, and animation controllers that users expect to resume where they left off.',
        sample:
            '// Tap the expand chevron, swipe away, come back.\n'
            '// The expansion state is still there because the\n'
            '// AutomaticKeepAlive captured the handle.',
      ),
      const _UseCase(
        title: 'Form in progress',
        icon: Icons.edit_note,
        color: Color(0xFF9333EA),
        blurb:
            'Never lose a partially filled multi-tab form. Dispatch a handle whenever any field has unsaved text.',
        sample:
            'if (_controller.text.isNotEmpty) {\n'
            '  _handle ??= KeepAliveHandle();\n'
            '  KeepAliveNotification(_handle!).dispatch(ctx);\n'
            '} else {\n'
            '  _handle?.release();\n'
            '  _handle = null;\n'
            '}',
      ),
      const _UseCase(
        title: 'Filter state',
        icon: Icons.filter_alt,
        color: Color(0xFF0891B2),
        blurb:
            'Heavy filter UIs with chips, sliders, and search inputs: cheaper to keep the subtree mounted than to rebuild it on every recycle.',
        sample:
            'return KeepAliveWrapper(\n'
            '  active: widget.hasActiveFilter,\n'
            '  child: FilterPanel(...),\n'
            ');',
      ),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionCard(
          title: 'Where KeepAliveHandle earns its keep',
          subtitle: 'Six realistic UI scenarios',
          icon: Icons.collections_bookmark,
          accent: scheme.primary,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints cc) {
              final int cols = cc.maxWidth > 720 ? 3 : 2;
              final double gap = 12;
              final double w = (cc.maxWidth - gap * (cols - 1)) / cols;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: <Widget>[
                  for (final _UseCase c in cases)
                    SizedBox(
                      width: w,
                      child: _UseCaseCard(useCase: c),
                    ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 14),
        _SectionCard(
          title: 'Performance angle',
          subtitle: 'Keep-alive is a targeted mutation budget tool',
          icon: Icons.speed,
          accent: scheme.tertiary,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _BulletedLine(
                text: 'Better than caching data in a global: also keeps widget identity.',
                icon: Icons.bolt,
                color: Color(0xFFCA8A04),
              ),
              _BulletedLine(
                text: 'Lighter than Offstage: elements are retained, not hidden-then-rebuilt.',
                icon: Icons.eco,
                color: Color(0xFF16A34A),
              ),
              _BulletedLine(
                text: 'Pairs with const constructors for best recycling behaviour.',
                icon: Icons.tune,
                color: Color(0xFF2563EB),
              ),
              _BulletedLine(
                text: 'Measure: keep-alive should be a scalpel, not a blanket.',
                icon: Icons.monitor_heart,
                color: Color(0xFFE11D48),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}

class _UseCase {
  const _UseCase({
    required this.title,
    required this.icon,
    required this.color,
    required this.blurb,
    required this.sample,
  });
  final String title;
  final IconData icon;
  final Color color;
  final String blurb;
  final String sample;
}

class _UseCaseCard extends StatelessWidget {
  const _UseCaseCard({required this.useCase});
  final _UseCase useCase;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: scheme.surfaceContainerHigh,
        border: Border.all(color: useCase.color.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: useCase.color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(useCase.icon, color: useCase.color, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  useCase.title,
                  style: TextStyle(
                    color: useCase.color,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            useCase.blurb,
            style: const TextStyle(fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 10),
          _MonoBlock(text: useCase.sample, accent: const Color(0xFF111827)),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
//  Tab 9 — Cheat sheet + pitfalls
// ══════════════════════════════════════════════════════════════════════════
class _CheatSheetTab extends StatelessWidget {
  const _CheatSheetTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _SectionCard(
          title: 'Pitfalls',
          subtitle: 'Common mistakes with KeepAliveHandle',
          icon: Icons.warning_amber,
          accent: scheme.error,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _PitfallRow(
                icon: Icons.memory,
                color: const Color(0xFFE11D48),
                title: 'Forgetting release()',
                detail:
                    'The ancestor holds a listener on the handle; forgetting to release() means the subtree is kept alive forever, retaining State, controllers, and subscriptions.',
              ),
              const SizedBox(height: 10),
              _PitfallRow(
                icon: Icons.pie_chart,
                color: const Color(0xFFCA8A04),
                title: 'Memory leaks via captured closures',
                detail:
                    'Listeners closing over large objects can extend their lifetime to match the handle\'s. Keep closures tight; prefer method tear-offs.',
              ),
              const SizedBox(height: 10),
              _PitfallRow(
                icon: Icons.my_location,
                color: const Color(0xFF9333EA),
                title: 'Dispatching from the wrong context',
                detail:
                    'Dispatch is scoped by context. Using a context that is an ancestor of the intended AutomaticKeepAlive will miss the listener.',
              ),
              const SizedBox(height: 10),
              _PitfallRow(
                icon: Icons.layers,
                color: const Color(0xFF0891B2),
                title: 'Nested scopes swallow your request',
                detail:
                    'Inner AutomaticKeepAlive absorbs the notification and returns true. The outer scope will not see it unless you re-dispatch.',
              ),
              const SizedBox(height: 10),
              _PitfallRow(
                icon: Icons.merge,
                color: const Color(0xFF2563EB),
                title: 'Mutating during notifyListeners',
                detail:
                    'Listeners must not create/destroy the same handle while it is notifying. Prefer scheduling the follow-up with microtasks.',
              ),
              const SizedBox(height: 10),
              _PitfallRow(
                icon: Icons.timeline,
                color: const Color(0xFF059669),
                title: 'Re-using a handle after release',
                detail:
                    'Once release() has been called the handle has fulfilled its purpose. Create a new handle for a new keep-alive request.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _SectionCard(
          title: 'API cheat sheet',
          subtitle: 'What you need on the handle and its friends',
          icon: Icons.list_alt,
          accent: scheme.primary,
          child: const _ApiCheatTable(),
        ),
        const SizedBox(height: 14),
        _SectionCard(
          title: 'Related types',
          subtitle: 'Names you will see together',
          icon: Icons.link,
          accent: scheme.secondary,
          child: const _RelatedTypesBlock(),
        ),
        const SizedBox(height: 14),
        _SectionCard(
          title: 'Mental checklist before shipping',
          subtitle: 'Six questions to ask',
          icon: Icons.checklist,
          accent: scheme.tertiary,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _BulletedLine(
                text: '1. Does the subtree actually have state worth preserving?',
                icon: Icons.help_outline,
                color: Color(0xFF2563EB),
              ),
              _BulletedLine(
                text: '2. Does release() always fire on dispose or inactive path?',
                icon: Icons.help_outline,
                color: Color(0xFF059669),
              ),
              _BulletedLine(
                text: '3. Have we measured rebuild cost before adding a lease?',
                icon: Icons.help_outline,
                color: Color(0xFF9333EA),
              ),
              _BulletedLine(
                text: '4. Could AutomaticKeepAliveClientMixin fit instead?',
                icon: Icons.help_outline,
                color: Color(0xFFCA8A04),
              ),
              _BulletedLine(
                text: '5. Is there exactly one lease per logical reason to stay alive?',
                icon: Icons.help_outline,
                color: Color(0xFFDB2777),
              ),
              _BulletedLine(
                text: '6. Is the handle reference kept private to its owner?',
                icon: Icons.help_outline,
                color: Color(0xFF0891B2),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}

class _PitfallRow extends StatelessWidget {
  const _PitfallRow({
    required this.icon,
    required this.color,
    required this.title,
    required this.detail,
  });
  final IconData icon;
  final Color color;
  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  detail,
                  style: const TextStyle(fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ApiCheatTable extends StatelessWidget {
  const _ApiCheatTable();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final List<List<String>> rows = <List<String>>[
      <String>[
        'KeepAliveHandle()',
        'Constructor. Creates a fresh lease object. Typically one per descendant request.',
      ],
      <String>[
        'void release()',
        'Signals that keep-alive is no longer needed. Internally calls notifyListeners.',
      ],
      <String>[
        'void addListener(VoidCallback l)',
        'Inherited from Listenable via ChangeNotifier. Used by AutomaticKeepAlive.',
      ],
      <String>[
        'void removeListener(VoidCallback l)',
        'Inherited. Typically called in the listener to avoid re-entrancy.',
      ],
      <String>[
        '@protected notifyListeners',
        'Inherited. release() uses this; you typically do not call it directly.',
      ],
      <String>[
        'KeepAliveNotification(handle)',
        'Notification payload carrying a single handle up the tree.',
      ],
      <String>[
        'AutomaticKeepAlive',
        'Widget that wraps children, receives the notification, and tracks leases.',
      ],
      <String>[
        'AutomaticKeepAliveClientMixin',
        'Convenience mixin on State that owns a private handle.',
      ],
    ];

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            color: scheme.primary,
            child: Row(
              children: const <Widget>[
                Expanded(
                  flex: 5,
                  child: Text(
                    'Symbol',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Text(
                    'Meaning',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          for (int i = 0; i < rows.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              color: i.isEven
                  ? scheme.surfaceContainerHigh
                  : scheme.surfaceContainerLow,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Text(
                      rows[i][0],
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Text(
                      rows[i][1],
                      style: const TextStyle(fontSize: 12, height: 1.4),
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

class _RelatedTypesBlock extends StatelessWidget {
  const _RelatedTypesBlock();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: <Widget>[
        _InlinePill(
          label: 'KeepAliveNotification',
          background: scheme.primary.withValues(alpha: 0.12),
          foreground: scheme.primary,
          icon: Icons.notifications_active,
        ),
        _InlinePill(
          label: 'AutomaticKeepAlive',
          background: scheme.secondary.withValues(alpha: 0.15),
          foreground: scheme.secondary,
          icon: Icons.extension,
        ),
        _InlinePill(
          label: 'AutomaticKeepAliveClientMixin',
          background: scheme.tertiary.withValues(alpha: 0.15),
          foreground: scheme.tertiary,
          icon: Icons.layers,
        ),
        _InlinePill(
          label: 'SliverMultiBoxAdaptor',
          background: scheme.primaryContainer,
          foreground: scheme.onPrimaryContainer,
          icon: Icons.view_list,
        ),
        _InlinePill(
          label: 'Listenable',
          background: scheme.outlineVariant,
          foreground: scheme.onSurface,
          icon: Icons.hearing,
        ),
        _InlinePill(
          label: 'ChangeNotifier',
          background: scheme.errorContainer,
          foreground: scheme.onErrorContainer,
          icon: Icons.campaign,
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════
//  Bottom hint bar (reacts to _tabHint for extra visual motion)
// ══════════════════════════════════════════════════════════════════════════
class _BottomHintBar extends StatelessWidget {
  const _BottomHintBar();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _tabHint,
      builder: (BuildContext context, int v, Widget? _) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          color: Theme.of(context).colorScheme.primary,
          child: Row(
            children: <Widget>[
              const Icon(Icons.info_outline, color: Colors.white, size: 16),
              const SizedBox(width: 8),
              Text(
                'Tab navigation events: $v',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }
}

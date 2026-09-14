// Deep visual demo for Flutter's declarative Router 2.0 API:
// Router, RouterDelegate, RouteInformationParser, RouteInformationProvider,
// BackButtonDispatcher, RouteInformation, Navigator(pages:).
// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, deprecated_member_use, prefer_interpolation_to_compose_strings, avoid_redundant_argument_values, unnecessary_import

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// =====================================================================
// PALETTE
// =====================================================================
const Color _kInk = Color(0xFF0B1230);
const Color _kInkSoft = Color(0xFF1F284E);
const Color _kInkMuted = Color(0xFF566090);
const Color _kPaper = Color(0xFFF5F6FB);
const Color _kPaperWarm = Color(0xFFFBF7EE);
const Color _kCard = Color(0xFFFFFFFF);
const Color _kLine = Color(0xFFE2E5F1);
const Color _kAccent = Color(0xFF3F51B5);
const Color _kAccent2 = Color(0xFF00897B);
const Color _kAccent3 = Color(0xFFD81B60);
const Color _kAccent4 = Color(0xFFFB8C00);
const Color _kAccent5 = Color(0xFF7E57C2);
const Color _kSuccess = Color(0xFF2E7D32);
const Color _kDanger = Color(0xFFC62828);
const Color _kInfo = Color(0xFF1565C0);
const Color _kWarn = Color(0xFFEF6C00);
const Color _kCode = Color(0xFF0E1A35);
const Color _kCodeFg = Color(0xFFE6EAF7);
const Color _kCodeKw = Color(0xFFC678DD);
const Color _kCodeStr = Color(0xFF98C379);
const Color _kCodeNum = Color(0xFFD19A66);
const Color _kCodeCmt = Color(0xFF6F7693);
const Color _kCodeId = Color(0xFF61AFEF);

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Router 2.0 Atlas',
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _kAccent,
      scaffoldBackgroundColor: _kPaper,
      fontFamily: 'Roboto',
    ),
    home: Scaffold(
      backgroundColor: _kPaper,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeroSection(),
              _IntroSection(),
              _PipelineAnatomySection(),
              _RouteInformationCardsSection(),
              _DelegateStateMachineSection(),
              _MockAppGallerySection(),
              _ComparisonTableSection(),
              _CodeBlockCardsSection(),
              _BackButtonDispatcherSection(),
              _NestedRoutersSection(),
              _PitfallsSection(),
              _FooterCheatSheetSection(),
            ],
          ),
        ),
      ),
    ),
  );
}

// =====================================================================
// HERO SECTION
// =====================================================================
class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 38, 32, 38),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0B1230),
            Color(0xFF1B2150),
            Color(0xFF3F51B5),
          ],
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HeroBadge(),
                SizedBox(height: 18),
                Text(
                  'Router 2.0: Declarative Navigation',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.6,
                    height: 1.05,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'A pure-framework atlas of Router, RouterDelegate, '
                  'RouteInformationParser, RouteInformationProvider, '
                  'BackButtonDispatcher and Navigator(pages:).',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.82),
                    fontSize: 15,
                    height: 1.45,
                  ),
                ),
                SizedBox(height: 22),
                Row(
                  children: [
                    _HeroChip(icon: Icons.alt_route, label: '11 sections'),
                    SizedBox(width: 10),
                    _HeroChip(icon: Icons.dashboard_customize, label: 'Pure API'),
                    SizedBox(width: 10),
                    _HeroChip(icon: Icons.snippet_folder, label: 'Snapshot only'),
                  ],
                ),
                SizedBox(height: 14),
                Row(
                  children: [
                    _HeroChip(icon: Icons.public, label: 'Deep links'),
                    SizedBox(width: 10),
                    _HeroChip(icon: Icons.arrow_back, label: 'Back-button safe'),
                    SizedBox(width: 10),
                    _HeroChip(icon: Icons.account_tree, label: 'Nested routers'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 24),
          Expanded(
            flex: 2,
            child: _HeroPreviewCard(),
          ),
        ],
      ),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  const _HeroBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.28),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.fork_right, color: Colors.amberAccent, size: 14),
          SizedBox(width: 6),
          Text(
            'NAVIGATOR 2.0 / ROUTER API',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 14),
          SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroPreviewCard extends StatelessWidget {
  const _HeroPreviewCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.terminal, color: Colors.amberAccent, size: 14),
              SizedBox(width: 6),
              Text(
                'MaterialApp.router signature',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          _HeroCodeLine(text: 'MaterialApp.router(', color: Colors.white),
          _HeroCodeLine(text: '  routerDelegate: appDelegate,', color: Color(0xFFFFD180)),
          _HeroCodeLine(text: '  routeInformationParser: appParser,', color: Color(0xFFB39DDB)),
          _HeroCodeLine(text: '  routeInformationProvider: provider,', color: Color(0xFF80CBC4)),
          _HeroCodeLine(text: '  backButtonDispatcher: rootDispatcher,', color: Color(0xFFFFAB91)),
          _HeroCodeLine(text: ');', color: Colors.white),
          SizedBox(height: 14),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.lightBlueAccent, size: 14),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'All four pieces cooperate: provider listens, parser '
                    'translates, delegate decides, dispatcher cancels.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.78),
                      fontSize: 11,
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

class _HeroCodeLine extends StatelessWidget {
  const _HeroCodeLine({required this.text, required this.color});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'monospace',
          color: color,
          fontSize: 12,
          height: 1.4,
        ),
      ),
    );
  }
}

// =====================================================================
// INTRO SECTION
// =====================================================================
class _IntroSection extends StatelessWidget {
  const _IntroSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 32, 32, 32),
      color: _kPaper,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            kicker: 'WHAT & WHY',
            title: 'What is Router 2.0?',
            subtitle: 'A declarative API where the navigation stack is a '
                'function of app state — not a sequence of imperative calls.',
            accent: _kAccent,
          ),
          SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _IntroCard(
                icon: Icons.account_tree_outlined,
                color: _kAccent,
                title: 'Stack as data',
                body: 'You describe which pages exist as a List<Page>. The '
                    'Navigator diffs the list, animating in new pages and '
                    'popping removed ones automatically.',
              )),
              SizedBox(width: 16),
              Expanded(child: _IntroCard(
                icon: Icons.link,
                color: _kAccent2,
                title: 'URLs first',
                body: 'A RouteInformationParser translates URLs into typed '
                    'configuration objects. Deep links and the browser back '
                    'button work for free on web.',
              )),
              SizedBox(width: 16),
              Expanded(child: _IntroCard(
                icon: Icons.swap_calls,
                color: _kAccent3,
                title: 'Two-way sync',
                body: 'The delegate exposes currentConfiguration so the '
                    'engine can sync the address bar back to your state — '
                    'closing the loop with the platform.',
              )),
            ],
          ),
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _IntroCard(
                icon: Icons.architecture,
                color: _kAccent4,
                title: 'When to use it',
                body: 'Reach for Router 2.0 when you need deep links, web '
                    'history, nested routers, conditional auth gates, or a '
                    'single source of navigation truth.',
              )),
              SizedBox(width: 16),
              Expanded(child: _IntroCard(
                icon: Icons.do_not_disturb_on,
                color: _kAccent5,
                title: 'When NOT to',
                body: 'For simple stacks (login, list, detail) the imperative '
                    'Navigator.push/pop API is shorter, less abstract and '
                    'easier to debug.',
              )),
              SizedBox(width: 16),
              Expanded(child: _IntroCard(
                icon: Icons.shield_moon_outlined,
                color: _kInfo,
                title: 'Sandbox note',
                body: 'This file renders snapshot cards only. Real Router, '
                    'RouterDelegate and parser implementations require a '
                    'TickerProvider and async wiring.',
              )),
            ],
          ),
        ],
      ),
    );
  }
}

class _IntroCard extends StatelessWidget {
  const _IntroCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kLine),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: _kInk,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6),
          Text(
            body,
            style: TextStyle(
              color: _kInkMuted,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.kicker,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  final String kicker;
  final String title;
  final String subtitle;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 6, height: 22, decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(3),
            )),
            SizedBox(width: 10),
            Text(
              kicker,
              style: TextStyle(
                color: accent,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.6,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: _kInk,
            fontSize: 26,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
            height: 1.1,
          ),
        ),
        SizedBox(height: 6),
        Container(
          constraints: BoxConstraints(maxWidth: 720),
          child: Text(
            subtitle,
            style: TextStyle(
              color: _kInkMuted,
              fontSize: 13.5,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// PIPELINE ANATOMY (CustomPainter)
// =====================================================================
class _PipelineAnatomySection extends StatelessWidget {
  const _PipelineAnatomySection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 32, 32, 32),
      color: _kPaperWarm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            kicker: 'PIPELINE',
            title: 'Anatomy of a Router build',
            subtitle: 'URL / back-button / system events flow through the '
                'provider, parser, delegate and finally a Navigator. The '
                'delegate also reports back outward.',
            accent: _kAccent2,
          ),
          SizedBox(height: 22),
          Container(
            height: 340,
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: _kLine),
            ),
            child: CustomPaint(
              painter: _PipelinePainter(),
              child: SizedBox.expand(),
            ),
          ),
          SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _PipelineLegend(
                color: _kAccent4,
                icon: Icons.public,
                title: 'Inputs',
                items: const [
                  'Browser URL / Activity intent',
                  'System back-button press',
                  'App-level setNewRoutePath call',
                ],
              )),
              SizedBox(width: 16),
              Expanded(child: _PipelineLegend(
                color: _kAccent,
                icon: Icons.swap_horiz,
                title: 'Pipeline',
                items: const [
                  'RouteInformationProvider',
                  'RouteInformationParser',
                  'RouterDelegate',
                ],
              )),
              SizedBox(width: 16),
              Expanded(child: _PipelineLegend(
                color: _kAccent3,
                icon: Icons.widgets_outlined,
                title: 'Output',
                items: const [
                  'Navigator(pages: [...])',
                  'currentConfiguration → URL',
                  'popRoute → back gesture',
                ],
              )),
            ],
          ),
        ],
      ),
    );
  }
}

class _PipelineLegend extends StatelessWidget {
  const _PipelineLegend({
    required this.color,
    required this.icon,
    required this.title,
    required this.items,
  });

  final Color color;
  final IconData icon;
  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kLine),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16),
              SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  color: _kInk,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          for (final String it in items)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 6),
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      it,
                      style: TextStyle(
                        color: _kInkMuted,
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
    );
  }
}

class _PipelinePainter extends CustomPainter {
  const _PipelinePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final double midY = h * 0.45;

    // Background grid
    final Paint gridPaint = Paint()
      ..color = _kLine.withValues(alpha: 0.45)
      ..strokeWidth = 1.0;
    for (int i = 0; i <= 10; i++) {
      final double y = h * (i / 10.0);
      canvas.drawLine(Offset(0, y), Offset(w, y), gridPaint);
    }
    for (int i = 0; i <= 16; i++) {
      final double x = w * (i / 16.0);
      canvas.drawLine(Offset(x, 0), Offset(x, h), gridPaint);
    }

    // Stage boxes
    final List<_PipelineStage> stages = <_PipelineStage>[
      _PipelineStage('URL\n/back', _kAccent4),
      _PipelineStage('RouteInformation\nProvider', _kAccent),
      _PipelineStage('RouteInformation\nParser', _kAccent5),
      _PipelineStage('RouterDelegate', _kAccent2),
      _PipelineStage('Navigator\n(pages:)', _kAccent3),
    ];

    final double pad = 24;
    final double stageW = (w - pad * 2) / stages.length - 18;
    final double stageH = 80;
    final double startX = pad;

    for (int i = 0; i < stages.length; i++) {
      final double cx = startX + i * (stageW + 22);
      final Rect r = Rect.fromLTWH(cx, midY - stageH / 2, stageW, stageH);
      final RRect rr = RRect.fromRectAndRadius(r, Radius.circular(14));
      final Paint fill = Paint()..color = stages[i].color.withValues(alpha: 0.12);
      final Paint stroke = Paint()
        ..color = stages[i].color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawRRect(rr, fill);
      canvas.drawRRect(rr, stroke);

      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: stages[i].label,
          style: TextStyle(
            color: _kInk,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      tp.layout(maxWidth: stageW - 8);
      tp.paint(
        canvas,
        Offset(cx + (stageW - tp.width) / 2, midY - tp.height / 2),
      );

      // Arrow to next stage
      if (i < stages.length - 1) {
        final double ax1 = cx + stageW + 2;
        final double ax2 = cx + stageW + 20;
        final Paint arrow = Paint()
          ..color = _kInkMuted
          ..strokeWidth = 2.0
          ..strokeCap = StrokeCap.round;
        canvas.drawLine(Offset(ax1, midY), Offset(ax2, midY), arrow);
        final Path head = Path()
          ..moveTo(ax2, midY)
          ..lineTo(ax2 - 6, midY - 4)
          ..lineTo(ax2 - 6, midY + 4)
          ..close();
        canvas.drawPath(head, Paint()..color = _kInkMuted);
      }
    }

    // Feedback loop (currentConfiguration back to URL)
    final Paint loopPaint = Paint()
      ..color = _kAccent3.withValues(alpha: 0.7)
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;
    final Path loop = Path()
      ..moveTo(w - pad - stageW * 0.5, midY + stageH / 2 + 4)
      ..quadraticBezierTo(
        w * 0.5, h * 0.85,
        pad + stageW * 0.5, midY + stageH / 2 + 4,
      );
    canvas.drawPath(loop, loopPaint);

    final TextPainter loopLabel = TextPainter(
      text: TextSpan(
        text: 'currentConfiguration  ↺  reportRouteInformation',
        style: TextStyle(
          color: _kAccent3,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    loopLabel.paint(
      canvas,
      Offset((w - loopLabel.width) / 2, h * 0.88),
    );

    // Top banner
    final TextPainter topLabel = TextPainter(
      text: TextSpan(
        text: 'Inputs flow right  →  Navigator renders  •  outputs flow back ←',
        style: TextStyle(
          color: _kInkSoft,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    topLabel.paint(canvas, Offset((w - topLabel.width) / 2, 18));
  }

  @override
  bool shouldRepaint(covariant _PipelinePainter old) => false;
}

class _PipelineStage {
  const _PipelineStage(this.label, this.color);
  final String label;
  final Color color;
}

// =====================================================================
// ROUTE INFORMATION CARDS
// =====================================================================
class _RouteInformationCardsSection extends StatelessWidget {
  const _RouteInformationCardsSection();

  @override
  Widget build(BuildContext context) {
    final List<_RouteInfoSample> samples = <_RouteInfoSample>[
      _RouteInfoSample(
        uri: '/home',
        state: const <String, Object>{
          'tab': 'feed',
          'scrollY': 0,
        },
        color: _kAccent,
        icon: Icons.home_outlined,
      ),
      _RouteInfoSample(
        uri: '/products/42?ref=email',
        state: const <String, Object>{
          'productId': 42,
          'cameFrom': 'email',
          'preview': false,
        },
        color: _kAccent2,
        icon: Icons.shopping_bag_outlined,
      ),
      _RouteInfoSample(
        uri: '/cart',
        state: const <String, Object>{
          'items': 3,
          'subtotal': 5499,
          'currency': 'EUR',
        },
        color: _kAccent4,
        icon: Icons.shopping_cart_outlined,
      ),
      _RouteInfoSample(
        uri: '/profile/settings?theme=dark',
        state: const <String, Object>{
          'tab': 'settings',
          'theme': 'dark',
          'pristine': true,
        },
        color: _kAccent5,
        icon: Icons.tune,
      ),
      _RouteInfoSample(
        uri: '/search?q=router+2.0&page=2',
        state: const <String, Object>{
          'query': 'router 2.0',
          'page': 2,
          'sort': 'relevance',
        },
        color: _kAccent3,
        icon: Icons.search,
      ),
      _RouteInfoSample(
        uri: '/checkout/payment',
        state: const <String, Object>{
          'step': 'payment',
          'cartHash': 'a7c91',
        },
        color: _kInfo,
        icon: Icons.credit_card,
      ),
      _RouteInfoSample(
        uri: '/admin/users/14/permissions',
        state: const <String, Object>{
          'userId': 14,
          'view': 'permissions',
          'editable': true,
        },
        color: _kDanger,
        icon: Icons.admin_panel_settings_outlined,
      ),
      _RouteInfoSample(
        uri: '/auth/login?redirect=%2Fcart',
        state: const <String, Object>{
          'redirect': '/cart',
          'method': 'oauth',
        },
        color: _kSuccess,
        icon: Icons.lock_outline,
      ),
    ];

    return Container(
      padding: EdgeInsets.fromLTRB(32, 32, 32, 32),
      color: _kPaper,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            kicker: 'PAYLOADS',
            title: 'RouteInformation — the unit of routing',
            subtitle: 'Every navigation event becomes a RouteInformation: a '
                'Uri plus an opaque state map (also restored from the '
                'platform on web/Android).',
            accent: _kAccent5,
          ),
          SizedBox(height: 22),
          _RouteInformationGrid(samples: samples),
        ],
      ),
    );
  }
}

class _RouteInformationGrid extends StatelessWidget {
  const _RouteInformationGrid({required this.samples});

  final List<_RouteInfoSample> samples;

  @override
  Widget build(BuildContext context) {
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < samples.length; i += 4) {
      final List<Widget> cells = <Widget>[];
      for (int j = 0; j < 4; j++) {
        final int idx = i + j;
        if (idx >= samples.length) {
          cells.add(Expanded(child: SizedBox()));
        } else {
          cells.add(Expanded(child: _RouteInfoCard(sample: samples[idx])));
        }
        if (j < 3) cells.add(SizedBox(width: 14));
      }
      rows.add(Row(crossAxisAlignment: CrossAxisAlignment.start, children: cells));
      rows.add(SizedBox(height: 14));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    );
  }
}

class _RouteInfoSample {
  const _RouteInfoSample({
    required this.uri,
    required this.state,
    required this.color,
    required this.icon,
  });

  final String uri;
  final Map<String, Object> state;
  final Color color;
  final IconData icon;
}

class _RouteInfoCard extends StatelessWidget {
  const _RouteInfoCard({required this.sample});

  final _RouteInfoSample sample;

  @override
  Widget build(BuildContext context) {
    // Construct an actual RouteInformation to demonstrate the type.
    final RouteInformation info = RouteInformation(uri: Uri.parse(sample.uri));
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kLine),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: sample.color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(sample.icon, size: 16, color: sample.color),
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: sample.color.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'RouteInformation',
                  style: TextStyle(
                    color: sample.color,
                    fontSize: 9.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: _kCode,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              info.uri.toString(),
              style: TextStyle(
                fontFamily: 'monospace',
                color: _kCodeFg,
                fontSize: 11.5,
                height: 1.3,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'state',
            style: TextStyle(
              color: _kInkMuted,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
          SizedBox(height: 4),
          for (final MapEntry<String, Object> kv in sample.state.entries)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 78,
                    child: Text(
                      kv.key,
                      style: TextStyle(
                        color: _kInkSoft,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      _formatStateValue(kv.value),
                      style: TextStyle(
                        color: sample.color,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 8),
          Row(
            children: [
              _RouteInfoChip(
                label: 'path: ${info.uri.path}',
                color: sample.color,
              ),
              SizedBox(width: 6),
              _RouteInfoChip(
                label: 'q: ${info.uri.queryParameters.length}',
                color: _kInkMuted,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String _formatStateValue(Object v) {
  if (v is String) return "'" + v + "'";
  if (v is bool) return v ? 'true' : 'false';
  return v.toString();
}

class _RouteInfoChip extends StatelessWidget {
  const _RouteInfoChip({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

// =====================================================================
// DELEGATE STATE MACHINE
// =====================================================================
class _DelegateStateMachineSection extends StatelessWidget {
  const _DelegateStateMachineSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 32, 32, 32),
      color: _kPaperWarm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            kicker: 'STATE MACHINE',
            title: 'RouterDelegate lifecycle',
            subtitle: 'Idle → receive configuration → expose '
                'currentConfiguration → build → notify listeners → return to '
                'idle. popRoute can short-circuit the loop.',
            accent: _kAccent4,
          ),
          SizedBox(height: 22),
          Container(
            height: 280,
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: _kLine),
            ),
            child: CustomPaint(
              painter: _DelegateStateMachinePainter(),
              child: SizedBox.expand(),
            ),
          ),
          SizedBox(height: 18),
          _DelegateStateLegend(),
        ],
      ),
    );
  }
}

class _DelegateStateLegend extends StatelessWidget {
  const _DelegateStateLegend();

  @override
  Widget build(BuildContext context) {
    final List<_LegendItem> items = const <_LegendItem>[
      _LegendItem(
        color: _kAccent,
        title: 'idle',
        body: 'Delegate waits for inbound platform events or app-level '
            'navigation commands.',
      ),
      _LegendItem(
        color: _kAccent5,
        title: 'setNewRoutePath',
        body: 'Async hook called by the parser. Mutates internal state, '
            'returns a Future when ready.',
      ),
      _LegendItem(
        color: _kAccent2,
        title: 'build',
        body: 'Returns a Navigator(pages: [...]) whose pages mirror the '
            'current configuration.',
      ),
      _LegendItem(
        color: _kAccent3,
        title: 'notifyListeners',
        body: 'Marks the delegate dirty so the host Router rebuilds and '
            'reports a new configuration upward.',
      ),
    ];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < items.length; i++) ...[
          Expanded(child: _LegendCard(item: items[i])),
          if (i < items.length - 1) SizedBox(width: 14),
        ],
      ],
    );
  }
}

class _LegendItem {
  const _LegendItem({
    required this.color,
    required this.title,
    required this.body,
  });
  final Color color;
  final String title;
  final String body;
}

class _LegendCard extends StatelessWidget {
  const _LegendCard({required this.item});
  final _LegendItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kLine),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              item.title,
              style: TextStyle(
                color: item.color,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            item.body,
            style: TextStyle(
              color: _kInkMuted,
              fontSize: 11.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _DelegateStateMachinePainter extends CustomPainter {
  const _DelegateStateMachinePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // Background dots
    final Paint dot = Paint()..color = _kLine.withValues(alpha: 0.7);
    for (int x = 0; x < 30; x++) {
      for (int y = 0; y < 12; y++) {
        canvas.drawCircle(
          Offset(w * x / 30, h * y / 12),
          0.7,
          dot,
        );
      }
    }

    final List<_StateNode> nodes = <_StateNode>[
      _StateNode('idle', _kAccent, Offset(w * 0.12, h * 0.5)),
      _StateNode('setNewRoutePath', _kAccent5, Offset(w * 0.34, h * 0.5)),
      _StateNode('build', _kAccent2, Offset(w * 0.56, h * 0.5)),
      _StateNode('notifyListeners', _kAccent3, Offset(w * 0.80, h * 0.5)),
    ];

    // Draw arrows
    for (int i = 0; i < nodes.length - 1; i++) {
      _drawArrow(canvas, nodes[i].center, nodes[i + 1].center,
          color: _kInkMuted, dx: 60);
    }
    // Loop arrow back to idle
    _drawCurvedArrow(canvas, nodes.last.center, nodes.first.center, _kAccent3);

    // popRoute shortcut
    final Paint pop = Paint()
      ..color = _kDanger
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;
    final Path popPath = Path()
      ..moveTo(nodes[2].center.dx, nodes[2].center.dy - 40)
      ..quadraticBezierTo(
        (nodes[2].center.dx + nodes[0].center.dx) / 2, h * 0.12,
        nodes[0].center.dx, nodes[0].center.dy - 40,
      );
    canvas.drawPath(popPath, pop);
    final TextPainter popLabel = TextPainter(
      text: TextSpan(
        text: 'popRoute() → handled',
        style: TextStyle(
          color: _kDanger,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    popLabel.paint(
      canvas,
      Offset(
        (nodes[0].center.dx + nodes[2].center.dx) / 2 - popLabel.width / 2,
        h * 0.05,
      ),
    );

    // Draw nodes on top
    for (final _StateNode n in nodes) {
      _drawStateNode(canvas, n);
    }
  }

  void _drawStateNode(Canvas canvas, _StateNode n) {
    final double r = 46;
    final Rect rect = Rect.fromCircle(center: n.center, radius: r);
    final Paint fill = Paint()..color = n.color.withValues(alpha: 0.14);
    final Paint stroke = Paint()
      ..color = n.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawOval(rect, fill);
    canvas.drawOval(rect, stroke);

    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: n.label,
        style: TextStyle(
          color: _kInk,
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: r * 1.8);
    tp.paint(
      canvas,
      Offset(n.center.dx - tp.width / 2, n.center.dy - tp.height / 2),
    );
  }

  void _drawArrow(Canvas canvas, Offset a, Offset b,
      {required Color color, double dx = 50}) {
    final Paint p = Paint()
      ..color = color
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;
    final Offset aShift = Offset(a.dx + dx * 0.5, a.dy);
    final Offset bShift = Offset(b.dx - dx * 0.5, b.dy);
    canvas.drawLine(aShift, bShift, p);
    final Path head = Path()
      ..moveTo(bShift.dx, bShift.dy)
      ..lineTo(bShift.dx - 6, bShift.dy - 4)
      ..lineTo(bShift.dx - 6, bShift.dy + 4)
      ..close();
    canvas.drawPath(head, Paint()..color = color);
  }

  void _drawCurvedArrow(Canvas canvas, Offset a, Offset b, Color color) {
    final Paint p = Paint()
      ..color = color
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke;
    final Path path = Path()
      ..moveTo(a.dx, a.dy + 46)
      ..quadraticBezierTo(
        (a.dx + b.dx) / 2, a.dy + 110,
        b.dx, b.dy + 46,
      );
    canvas.drawPath(path, p);
    final Path head = Path()
      ..moveTo(b.dx, b.dy + 46)
      ..lineTo(b.dx + 6, b.dy + 42)
      ..lineTo(b.dx + 6, b.dy + 50)
      ..close();
    canvas.drawPath(head, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _DelegateStateMachinePainter old) => false;
}

class _StateNode {
  const _StateNode(this.label, this.color, this.center);
  final String label;
  final Color color;
  final Offset center;
}

// =====================================================================
// MOCK APP GALLERY (phone bezels)
// =====================================================================
class _MockAppGallerySection extends StatelessWidget {
  const _MockAppGallerySection();

  @override
  Widget build(BuildContext context) {
    final List<_MockScreen> screens = <_MockScreen>[
      _MockScreen(
        uri: '/home',
        title: 'Home',
        accent: _kAccent,
        bodyBuilder: _homeBody,
      ),
      _MockScreen(
        uri: '/products/42',
        title: 'Product · 42',
        accent: _kAccent2,
        bodyBuilder: _productBody,
      ),
      _MockScreen(
        uri: '/cart',
        title: 'Cart',
        accent: _kAccent4,
        bodyBuilder: _cartBody,
      ),
      _MockScreen(
        uri: '/profile/settings',
        title: 'Profile · Settings',
        accent: _kAccent5,
        bodyBuilder: _settingsBody,
      ),
      _MockScreen(
        uri: '/search',
        title: 'Search results',
        accent: _kAccent3,
        bodyBuilder: _searchBody,
      ),
      _MockScreen(
        uri: '/checkout/payment',
        title: 'Checkout · Payment',
        accent: _kInfo,
        bodyBuilder: _checkoutBody,
      ),
    ];
    return Container(
      padding: EdgeInsets.fromLTRB(32, 32, 32, 32),
      color: _kPaper,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            kicker: 'GALLERY',
            title: 'Pages declared by configuration',
            subtitle: 'Each phone bezel below is one Page emitted by the '
                'delegate. The URI on top is what currentConfiguration would '
                'report up the stack.',
            accent: _kAccent3,
          ),
          SizedBox(height: 22),
          _MockGalleryGrid(screens: screens),
        ],
      ),
    );
  }
}

class _MockGalleryGrid extends StatelessWidget {
  const _MockGalleryGrid({required this.screens});
  final List<_MockScreen> screens;

  @override
  Widget build(BuildContext context) {
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < screens.length; i += 3) {
      final List<Widget> cells = <Widget>[];
      for (int j = 0; j < 3; j++) {
        final int idx = i + j;
        if (idx >= screens.length) {
          cells.add(Expanded(child: SizedBox()));
        } else {
          cells.add(Expanded(child: _PhoneBezel(screen: screens[idx])));
        }
        if (j < 2) cells.add(SizedBox(width: 18));
      }
      rows.add(Row(crossAxisAlignment: CrossAxisAlignment.start, children: cells));
      rows.add(SizedBox(height: 20));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    );
  }
}

typedef _MockBodyBuilder = Widget Function(Color accent);

class _MockScreen {
  const _MockScreen({
    required this.uri,
    required this.title,
    required this.accent,
    required this.bodyBuilder,
  });

  final String uri;
  final String title;
  final Color accent;
  final _MockBodyBuilder bodyBuilder;
}

class _PhoneBezel extends StatelessWidget {
  const _PhoneBezel({required this.screen});
  final _MockScreen screen;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: _kCode,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.link, color: _kCodeFg, size: 12),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  screen.uri,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    color: _kCodeFg,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFF1A1F35),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Color(0xFF0B1230), width: 2),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: _kPaper,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                // Status bar
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Row(
                    children: [
                      Text(
                        '9:41',
                        style: TextStyle(
                          color: _kInk,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Icon(Icons.wifi, size: 10, color: _kInkSoft),
                      SizedBox(width: 4),
                      Icon(Icons.battery_full, size: 10, color: _kInkSoft),
                    ],
                  ),
                ),
                // App bar
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: screen.accent.withValues(alpha: 0.10),
                    border: Border(
                      bottom: BorderSide(
                        color: screen.accent.withValues(alpha: 0.30),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.menu, size: 14, color: screen.accent),
                      SizedBox(width: 8),
                      Text(
                        screen.title,
                        style: TextStyle(
                          color: _kInk,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Icon(Icons.more_horiz, size: 14, color: screen.accent),
                    ],
                  ),
                ),
                // Body
                // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #127, P2):
                // The phone body region is a bounded Container(height: 180,
                // padding: 10) i.e. an inner 160 px box that hosts the body-
                // builder Columns. The product/checkout mocks intrinsically
                // size ~182 / ~165 px, producing two RenderFlex bottom
                // overflows (22 px and 5.0 px). The page-root is already
                // SCV(NeverScrollableScrollPhysics) so the canonical page-
                // root P2 doesn't apply — this is the P2 nested-Column
                // variant (cf. items 108, 113, 123). Wrap the body builder
                // in a NeverScrollable SCV: the bounded Container still
                // sizes the body to 180 px, the SCV viewport gives its
                // inner Column unbounded vertical space (no assertion),
                // and RenderViewport's default Clip.hardEdge keeps the
                // visual phone-screen aesthetic intact.
                Container(
                  height: 180,
                  padding: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: screen.bodyBuilder(screen.accent),
                  ),
                ),
                // Bottom bar / indicator
                Container(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Center(
                    child: Container(
                      width: 60,
                      height: 4,
                      decoration: BoxDecoration(
                        color: _kInkMuted,
                        borderRadius: BorderRadius.circular(2),
                      ),
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
}

Widget _homeBody(Color accent) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _MockTile(accent: accent, leading: Icons.local_fire_department, title: 'Trending', sub: '12 new today'),
      SizedBox(height: 6),
      _MockTile(accent: accent, leading: Icons.recommend, title: 'For you', sub: 'Personalised picks'),
      SizedBox(height: 6),
      _MockTile(accent: accent, leading: Icons.feed_outlined, title: 'Feed', sub: 'Latest posts'),
      SizedBox(height: 6),
      _MockTile(accent: accent, leading: Icons.bookmark_outline, title: 'Saved', sub: '7 items'),
    ],
  );
}

Widget _productBody(Color accent) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 70,
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(child: Icon(Icons.image, color: accent, size: 28)),
      ),
      SizedBox(height: 8),
      Text('Aurora Notebook', style: TextStyle(color: _kInk, fontWeight: FontWeight.w800, fontSize: 11)),
      Text('€54.99 · ★ 4.7', style: TextStyle(color: accent, fontSize: 10, fontWeight: FontWeight.w700)),
      SizedBox(height: 8),
      Row(
        children: [
          _MockChip(label: 'A4', color: accent),
          SizedBox(width: 4),
          _MockChip(label: 'Dotted', color: accent),
          SizedBox(width: 4),
          _MockChip(label: 'Hardback', color: accent),
        ],
      ),
    ],
  );
}

Widget _cartBody(Color accent) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _MockCartRow(accent: accent, name: 'Notebook', qty: 2, price: '€21.98'),
      _MockCartRow(accent: accent, name: 'Pen set',  qty: 1, price: '€12.40'),
      _MockCartRow(accent: accent, name: 'Sticker',  qty: 4, price: '€20.61'),
      SizedBox(height: 4),
      Divider(height: 1, color: _kLine),
      SizedBox(height: 6),
      Row(
        children: [
          Expanded(child: Text('Subtotal', style: TextStyle(color: _kInkMuted, fontSize: 10))),
          Text('€54.99', style: TextStyle(color: _kInk, fontWeight: FontWeight.w800, fontSize: 11)),
        ],
      ),
    ],
  );
}

Widget _settingsBody(Color accent) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _MockSettingRow(accent: accent, icon: Icons.dark_mode, label: 'Theme', value: 'Dark'),
      _MockSettingRow(accent: accent, icon: Icons.language, label: 'Language', value: 'English'),
      _MockSettingRow(accent: accent, icon: Icons.notifications_active_outlined, label: 'Push', value: 'On'),
      _MockSettingRow(accent: accent, icon: Icons.lock_outline, label: 'Privacy', value: 'Strict'),
      _MockSettingRow(accent: accent, icon: Icons.logout, label: 'Sign out', value: ''),
    ],
  );
}

Widget _searchBody(Color accent) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.search, size: 12, color: accent),
            SizedBox(width: 6),
            Text('router 2.0', style: TextStyle(color: _kInk, fontSize: 11, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
      SizedBox(height: 6),
      _MockTile(accent: accent, leading: Icons.article_outlined, title: 'Router atlas', sub: 'docs.example'),
      SizedBox(height: 4),
      _MockTile(accent: accent, leading: Icons.code, title: 'Sample delegate', sub: 'github.com'),
      SizedBox(height: 4),
      _MockTile(accent: accent, leading: Icons.video_library_outlined, title: 'Talk', sub: 'youtube.com'),
    ],
  );
}

Widget _checkoutBody(Color accent) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _MockStepper(accent: accent, current: 2),
      SizedBox(height: 8),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _kLine),
        ),
        child: Row(
          children: [
            Icon(Icons.credit_card, color: accent, size: 14),
            SizedBox(width: 6),
            Text('•••• 4242', style: TextStyle(color: _kInk, fontSize: 11, fontWeight: FontWeight.w700)),
            Expanded(child: SizedBox()),
            Text('VISA', style: TextStyle(color: accent, fontSize: 10, fontWeight: FontWeight.w800)),
          ],
        ),
      ),
      SizedBox(height: 8),
      Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: accent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text('Pay €54.99', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)),
        ),
      ),
    ],
  );
}

class _MockTile extends StatelessWidget {
  const _MockTile({required this.accent, required this.leading, required this.title, required this.sub});
  final Color accent;
  final IconData leading;
  final String title;
  final String sub;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _kLine),
      ),
      child: Row(
        children: [
          Container(
            width: 22, height: 22,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Icon(leading, size: 13, color: accent),
          ),
          SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: _kInk, fontSize: 10, fontWeight: FontWeight.w700)),
                Text(sub, style: TextStyle(color: _kInkMuted, fontSize: 9)),
              ],
            ),
          ),
          Icon(Icons.chevron_right, size: 12, color: _kInkMuted),
        ],
      ),
    );
  }
}

class _MockChip extends StatelessWidget {
  const _MockChip({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.w700)),
    );
  }
}

class _MockCartRow extends StatelessWidget {
  const _MockCartRow({required this.accent, required this.name, required this.qty, required this.price});
  final Color accent;
  final String name;
  final int qty;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text('x$qty', style: TextStyle(color: accent, fontSize: 9, fontWeight: FontWeight.w800)),
          ),
          SizedBox(width: 6),
          Expanded(child: Text(name, style: TextStyle(color: _kInk, fontSize: 10, fontWeight: FontWeight.w600))),
          Text(price, style: TextStyle(color: _kInkSoft, fontSize: 10, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _MockSettingRow extends StatelessWidget {
  const _MockSettingRow({required this.accent, required this.icon, required this.label, required this.value});
  final Color accent;
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(icon, size: 12, color: accent),
          SizedBox(width: 6),
          Expanded(child: Text(label, style: TextStyle(color: _kInk, fontSize: 10, fontWeight: FontWeight.w600))),
          Text(value, style: TextStyle(color: _kInkMuted, fontSize: 10)),
        ],
      ),
    );
  }
}

class _MockStepper extends StatelessWidget {
  const _MockStepper({required this.accent, required this.current});
  final Color accent;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List<Widget>.generate(3, (int i) {
        final bool done = i < current;
        final bool active = i == current;
        final Color c = done ? _kSuccess : (active ? accent : _kInkMuted);
        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Column(
              children: [
                Container(
                  width: 18, height: 18,
                  decoration: BoxDecoration(
                    color: c.withValues(alpha: 0.16),
                    border: Border.all(color: c, width: 1.4),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text('${i + 1}', style: TextStyle(color: c, fontSize: 9, fontWeight: FontWeight.w800)),
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  ['Cart', 'Address', 'Pay'][i],
                  style: TextStyle(color: c, fontSize: 9, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

// =====================================================================
// COMPARISON TABLE
// =====================================================================
class _ComparisonTableSection extends StatelessWidget {
  const _ComparisonTableSection();

  @override
  Widget build(BuildContext context) {
    final List<_ComparisonRow> rows = const <_ComparisonRow>[
      _ComparisonRow(
        topic: 'Mental model',
        declarative: 'Stack = f(state). The Navigator diffs page list.',
        imperative: 'Procedural push/pop calls on a NavigatorState.',
      ),
      _ComparisonRow(
        topic: 'Deep links / URL',
        declarative: 'First-class — parser turns URI into config.',
        imperative: 'Manual: parse URI, then push the right route.',
      ),
      _ComparisonRow(
        topic: 'Web back button',
        declarative: 'Handled via reportRouteInformation + popRoute.',
        imperative: 'Requires careful pushNamed/popUntil bookkeeping.',
      ),
      _ComparisonRow(
        topic: 'Nested navigators',
        declarative: 'Inner Router can own a sub-path easily.',
        imperative: 'Workable but you maintain keys and observers.',
      ),
      _ComparisonRow(
        topic: 'Boilerplate',
        declarative: 'High: delegate + parser + Page subclasses.',
        imperative: 'Low: a couple of named routes is enough.',
      ),
      _ComparisonRow(
        topic: 'Debuggability',
        declarative: 'State is observable; navigation is pure data.',
        imperative: 'Stepping through Navigator.push stacks is direct.',
      ),
      _ComparisonRow(
        topic: 'Testing',
        declarative: 'Unit-test the delegate/parser without widgets.',
        imperative: 'Widget tests pump and pop the Navigator state.',
      ),
      _ComparisonRow(
        topic: 'Pre-built solutions',
        declarative: 'go_router, beamer, auto_route wrap this layer.',
        imperative: 'Built-in via MaterialApp(routes:, onGenerateRoute:).',
      ),
      _ComparisonRow(
        topic: 'Best for',
        declarative: 'Web apps, deep linkable mobile, role-aware shells.',
        imperative: 'Small to medium mobile flows, prototypes.',
      ),
    ];

    return Container(
      padding: EdgeInsets.fromLTRB(32, 32, 32, 32),
      color: _kPaperWarm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            kicker: 'COMPARE',
            title: 'Declarative vs Imperative',
            subtitle: 'Both approaches stay in the framework. Pick by use '
                'case — not by hype.',
            accent: _kInfo,
          ),
          SizedBox(height: 22),
          Container(
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _kLine),
            ),
            child: Column(
              children: [
                _ComparisonHeaderRow(),
                for (int i = 0; i < rows.length; i++)
                  _ComparisonDataRow(row: rows[i], zebra: i.isOdd),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ComparisonRow {
  const _ComparisonRow({
    required this.topic,
    required this.declarative,
    required this.imperative,
  });
  final String topic;
  final String declarative;
  final String imperative;
}

class _ComparisonHeaderRow extends StatelessWidget {
  const _ComparisonHeaderRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: _kInk,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
      ),
      child: Row(
        children: [
          Expanded(flex: 2, child: _hdr('Aspect')),
          Expanded(flex: 4, child: _hdr('Router 2.0  (declarative)')),
          Expanded(flex: 4, child: _hdr('Navigator.push / pop  (imperative)')),
        ],
      ),
    );
  }

  Widget _hdr(String s) => Text(
        s,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
        ),
      );
}

class _ComparisonDataRow extends StatelessWidget {
  const _ComparisonDataRow({required this.row, required this.zebra});
  final _ComparisonRow row;
  final bool zebra;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: zebra ? _kPaper : _kCard,
        border: Border(bottom: BorderSide(color: _kLine)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              row.topic,
              style: TextStyle(
                color: _kInk,
                fontWeight: FontWeight.w700,
                fontSize: 12.5,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              row.declarative,
              style: TextStyle(
                color: _kInkSoft,
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              row.imperative,
              style: TextStyle(
                color: _kInkSoft,
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// CODE BLOCK CARDS
// =====================================================================
class _CodeBlockCardsSection extends StatelessWidget {
  const _CodeBlockCardsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 32, 32, 32),
      color: _kPaper,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            kicker: 'CODE',
            title: 'Three minimum-viable snippets',
            subtitle: 'A RouterDelegate, a RouteInformationParser parsing '
                '/products/:id, and the MaterialApp.router wiring.',
            accent: _kAccent2,
          ),
          SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _CodeCard(
                title: 'AppRouterDelegate',
                subtitle: 'RouterDelegate + ChangeNotifier + '
                    'PopNavigatorRouterDelegateMixin',
                accent: _kAccent,
                lines: const <_CodeLine>[
                  _CodeLine(kind: _Tok.kw, text: 'class '),
                  _CodeLine(kind: _Tok.id, text: 'AppRouterDelegate '),
                  _CodeLine(kind: _Tok.kw, text: 'extends '),
                  _CodeLine(kind: _Tok.id, text: 'RouterDelegate<AppConfig>'),
                  _CodeLine(kind: _Tok.plain, text: ' {'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.kw, text: '  AppConfig '),
                  _CodeLine(kind: _Tok.plain, text: '_config = '),
                  _CodeLine(kind: _Tok.id, text: 'AppConfig.home();'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.kw, text: '  @override'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.id, text: '  AppConfig '),
                  _CodeLine(kind: _Tok.plain, text: 'get currentConfiguration => _config;'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.kw, text: '  @override'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.id, text: '  Future<void> '),
                  _CodeLine(kind: _Tok.plain, text: 'setNewRoutePath(AppConfig c) async {'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.plain, text: '    _config = c;'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.plain, text: '    notifyListeners();'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.plain, text: '  }'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.kw, text: '  @override'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.id, text: '  Widget '),
                  _CodeLine(kind: _Tok.plain, text: 'build(ctx) => Navigator('),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.plain, text: '    pages: _pagesFor(_config),'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.plain, text: '    onDidRemovePage: _onPop,'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.plain, text: '  );'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.plain, text: '}'),
                ],
              )),
              SizedBox(width: 14),
              Expanded(child: _CodeCard(
                title: 'AppRouteInformationParser',
                subtitle: 'Translates /products/:id ⇄ AppConfig',
                accent: _kAccent5,
                lines: const <_CodeLine>[
                  _CodeLine(kind: _Tok.kw, text: 'class '),
                  _CodeLine(kind: _Tok.id, text: 'AppParser '),
                  _CodeLine(kind: _Tok.kw, text: 'extends '),
                  _CodeLine(kind: _Tok.id, text: 'RouteInformationParser<AppConfig>'),
                  _CodeLine(kind: _Tok.plain, text: ' {'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.kw, text: '  @override'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.id, text: '  Future<AppConfig> '),
                  _CodeLine(kind: _Tok.plain, text: 'parseRouteInformation('),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.plain, text: '    RouteInformation info,'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.plain, text: '  ) async {'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.kw, text: '    final '),
                  _CodeLine(kind: _Tok.plain, text: 'segs = info.uri.pathSegments;'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.kw, text: '    if '),
                  _CodeLine(kind: _Tok.plain, text: '(segs.isEmpty) return '),
                  _CodeLine(kind: _Tok.id, text: 'AppConfig.home();'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.kw, text: '    if '),
                  _CodeLine(kind: _Tok.plain, text: '(segs.first == '),
                  _CodeLine(kind: _Tok.str, text: "'products'"),
                  _CodeLine(kind: _Tok.plain, text: ' && segs.length == 2) {'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.kw, text: '      final '),
                  _CodeLine(kind: _Tok.plain, text: 'id = '),
                  _CodeLine(kind: _Tok.id, text: 'int.tryParse'),
                  _CodeLine(kind: _Tok.plain, text: '(segs[1]);'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.plain, text: '      return '),
                  _CodeLine(kind: _Tok.id, text: 'AppConfig.product'),
                  _CodeLine(kind: _Tok.plain, text: '(id ?? 0);'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.plain, text: '    }'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.plain, text: '    return '),
                  _CodeLine(kind: _Tok.id, text: 'AppConfig.unknown();'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.plain, text: '  }'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.plain, text: '}'),
                ],
              )),
              SizedBox(width: 14),
              Expanded(child: _CodeCard(
                title: 'MaterialApp.router wiring',
                subtitle: 'Compose all four collaborators in one place',
                accent: _kAccent3,
                lines: const <_CodeLine>[
                  _CodeLine(kind: _Tok.id, text: 'MaterialApp'),
                  _CodeLine(kind: _Tok.plain, text: '.router('),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.plain, text: '  routerDelegate: '),
                  _CodeLine(kind: _Tok.id, text: 'AppRouterDelegate'),
                  _CodeLine(kind: _Tok.plain, text: '(),'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.plain, text: '  routeInformationParser: '),
                  _CodeLine(kind: _Tok.id, text: 'AppParser'),
                  _CodeLine(kind: _Tok.plain, text: '(),'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.plain, text: '  routeInformationProvider: '),
                  _CodeLine(kind: _Tok.id, text: 'PlatformRouteInformationProvider'),
                  _CodeLine(kind: _Tok.plain, text: '('),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.plain, text: '    initialRouteInformation: '),
                  _CodeLine(kind: _Tok.id, text: 'RouteInformation'),
                  _CodeLine(kind: _Tok.plain, text: '('),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.plain, text: '      uri: '),
                  _CodeLine(kind: _Tok.id, text: 'Uri'),
                  _CodeLine(kind: _Tok.plain, text: '.parse('),
                  _CodeLine(kind: _Tok.str, text: "'/home'"),
                  _CodeLine(kind: _Tok.plain, text: '),'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.plain, text: '    ),'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.plain, text: '  ),'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.plain, text: '  backButtonDispatcher: '),
                  _CodeLine(kind: _Tok.id, text: 'RootBackButtonDispatcher'),
                  _CodeLine(kind: _Tok.plain, text: '(),'),
                  _CodeLine(kind: _Tok.newline),
                  _CodeLine(kind: _Tok.plain, text: ')'),
                ],
              )),
            ],
          ),
        ],
      ),
    );
  }
}

enum _Tok { kw, id, str, num_, cmt, plain, newline }

class _CodeLine {
  const _CodeLine({required this.kind, this.text = ''});
  final _Tok kind;
  final String text;
}

class _CodeCard extends StatelessWidget {
  const _CodeCard({
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.lines,
  });

  final String title;
  final String subtitle;
  final Color accent;
  final List<_CodeLine> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kLine),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(14, 12, 14, 10),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.10),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
              border: Border(
                bottom: BorderSide(color: accent.withValues(alpha: 0.30)),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: _kInk,
                    fontWeight: FontWeight.w800,
                    fontSize: 13.5,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: accent,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _kCode,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(14),
              ),
            ),
            child: _CodeBody(lines: lines),
          ),
        ],
      ),
    );
  }
}

class _CodeBody extends StatelessWidget {
  const _CodeBody({required this.lines});
  final List<_CodeLine> lines;

  @override
  Widget build(BuildContext context) {
    final List<List<_CodeLine>> rows = <List<_CodeLine>>[];
    List<_CodeLine> current = <_CodeLine>[];
    for (final _CodeLine l in lines) {
      if (l.kind == _Tok.newline) {
        rows.add(current);
        current = <_CodeLine>[];
      } else {
        current.add(l);
      }
    }
    if (current.isNotEmpty) rows.add(current);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (int i = 0; i < rows.length; i++)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 24,
                  child: Text(
                    (i + 1).toString().padLeft(2, ' '),
                    style: TextStyle(
                      color: _kCodeCmt,
                      fontSize: 10.5,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        for (final _CodeLine seg in rows[i])
                          TextSpan(
                            text: seg.text,
                            style: TextStyle(
                              color: _tokenColor(seg.kind),
                              fontSize: 11,
                              height: 1.4,
                              fontFamily: 'monospace',
                              fontWeight: seg.kind == _Tok.kw
                                  ? FontWeight.w700
                                  : FontWeight.w400,
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

  Color _tokenColor(_Tok t) {
    switch (t) {
      case _Tok.kw:
        return _kCodeKw;
      case _Tok.id:
        return _kCodeId;
      case _Tok.str:
        return _kCodeStr;
      case _Tok.num_:
        return _kCodeNum;
      case _Tok.cmt:
        return _kCodeCmt;
      case _Tok.plain:
      case _Tok.newline:
        return _kCodeFg;
    }
  }
}

// =====================================================================
// BACK BUTTON DISPATCHER CHAIN
// =====================================================================
class _BackButtonDispatcherSection extends StatelessWidget {
  const _BackButtonDispatcherSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 32, 32, 32),
      color: _kPaperWarm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            kicker: 'BACK BUTTON',
            title: 'Dispatcher chain explained',
            subtitle: 'Android, web and shortcut events all land on the '
                'RootBackButtonDispatcher. Inner Routers register children '
                'to take priority.',
            accent: _kAccent4,
          ),
          SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: _BackChainDiagram(),
              ),
              SizedBox(width: 18),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _DispatcherCard(
                      color: _kAccent,
                      icon: Icons.public,
                      name: 'RootBackButtonDispatcher',
                      desc: 'Singleton attached to the WidgetsBinding. '
                          'Receives raw platform events.',
                    ),
                    SizedBox(height: 12),
                    _DispatcherCard(
                      color: _kAccent2,
                      icon: Icons.account_tree,
                      name: 'ChildBackButtonDispatcher',
                      desc: 'Wraps a child router. Takes priority when '
                          'takePriority() is called.',
                    ),
                    SizedBox(height: 12),
                    _DispatcherCard(
                      color: _kAccent3,
                      icon: Icons.swap_calls_outlined,
                      name: 'BackButtonDispatcher (abstract)',
                      desc: 'Override invokeCallback to handle a pop and '
                          'return false to bubble up.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BackChainDiagram extends StatelessWidget {
  const _BackChainDiagram();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kLine),
      ),
      child: CustomPaint(
        painter: _BackChainPainter(),
        child: SizedBox.expand(),
      ),
    );
  }
}

class _BackChainPainter extends CustomPainter {
  const _BackChainPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // Top: Android/Web event glyph
    final TextPainter src = TextPainter(
      text: TextSpan(
        text: 'Android  •  Web  •  Esc key  →  invokeCallback()',
        style: TextStyle(
          color: _kInkMuted,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    src.paint(canvas, Offset((w - src.width) / 2, 4));

    // Three concentric stacks
    final List<_BackStage> stages = <_BackStage>[
      _BackStage('RootBackButtonDispatcher', _kAccent, 0.18),
      _BackStage('ChildBackButtonDispatcher', _kAccent2, 0.45),
      _BackStage('RouterDelegate.popRoute()', _kAccent3, 0.72),
    ];

    final double boxH = 50;
    for (int i = 0; i < stages.length; i++) {
      final double y = h * (0.18 + 0.22 * i);
      final Rect r = Rect.fromLTWH(w * 0.10, y, w * 0.80, boxH);
      final RRect rr = RRect.fromRectAndRadius(r, Radius.circular(12));
      final Paint fill = Paint()..color = stages[i].color.withValues(alpha: 0.12);
      final Paint stroke = Paint()
        ..color = stages[i].color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawRRect(rr, fill);
      canvas.drawRRect(rr, stroke);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: stages[i].label,
          style: TextStyle(
            color: _kInk,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(
        canvas,
        Offset(r.left + 18, r.top + (boxH - tp.height) / 2),
      );

      // Sequence number
      final Paint seqFill = Paint()..color = stages[i].color;
      canvas.drawCircle(Offset(r.right - 26, r.top + boxH / 2), 13, seqFill);
      final TextPainter seq = TextPainter(
        text: TextSpan(
          text: '${i + 1}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      seq.paint(
        canvas,
        Offset(r.right - 26 - seq.width / 2, r.top + boxH / 2 - seq.height / 2),
      );

      // Arrow to next
      if (i < stages.length - 1) {
        final Paint arrow = Paint()
          ..color = _kInkMuted
          ..strokeWidth = 1.8;
        canvas.drawLine(
          Offset(w / 2, r.bottom + 4),
          Offset(w / 2, r.bottom + 20),
          arrow,
        );
        final Path head = Path()
          ..moveTo(w / 2, r.bottom + 22)
          ..lineTo(w / 2 - 5, r.bottom + 17)
          ..lineTo(w / 2 + 5, r.bottom + 17)
          ..close();
        canvas.drawPath(head, Paint()..color = _kInkMuted);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _BackChainPainter old) => false;
}

class _BackStage {
  const _BackStage(this.label, this.color, this.yFrac);
  final String label;
  final Color color;
  final double yFrac;
}

class _DispatcherCard extends StatelessWidget {
  const _DispatcherCard({
    required this.color,
    required this.icon,
    required this.name,
    required this.desc,
  });

  final Color color;
  final IconData icon;
  final String name;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kLine),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: _kInk,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  desc,
                  style: TextStyle(
                    color: _kInkMuted,
                    fontSize: 11.5,
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

// =====================================================================
// NESTED ROUTERS
// =====================================================================
class _NestedRoutersSection extends StatelessWidget {
  const _NestedRoutersSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 32, 32, 32),
      color: _kPaper,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            kicker: 'NESTED',
            title: 'Routers inside routers',
            subtitle: 'A common pattern: a shell with a bottom navigation '
                'bar where each tab owns its own inner Router that handles '
                'a sub-path.',
            accent: _kAccent5,
          ),
          SizedBox(height: 22),
          Container(
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _kLine),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: _NestedShellPreview(),
                ),
                SizedBox(width: 22),
                Expanded(
                  flex: 4,
                  child: _NestedExplanation(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NestedShellPreview extends StatelessWidget {
  const _NestedShellPreview();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kPaperWarm,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Outer router URL strip
          _UrlStrip(label: 'outer Router', uri: '/shop/products/42'),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kAccent, width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    _ScopeLabel(color: _kAccent, text: 'OUTER ROUTER · /shop'),
                  ],
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _kPaper,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _kAccent3, width: 1.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _ScopeLabel(color: _kAccent3, text: 'INNER ROUTER · /products'),
                      SizedBox(height: 6),
                      _MiniPage(accent: _kAccent3, title: '/products', sub: 'list'),
                      SizedBox(height: 4),
                      _MiniPage(accent: _kAccent3, title: '/products/42', sub: 'detail (top)'),
                    ],
                  ),
                ),
                SizedBox(height: 6),
                _BottomTabBarMock(),
              ],
            ),
          ),
          SizedBox(height: 8),
          _UrlStrip(label: 'inner Router', uri: '/products/42'),
        ],
      ),
    );
  }
}

class _UrlStrip extends StatelessWidget {
  const _UrlStrip({required this.label, required this.uri});
  final String label;
  final String uri;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: _kInkSoft,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _kCode,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              uri,
              style: TextStyle(
                color: _kCodeFg,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ScopeLabel extends StatelessWidget {
  const _ScopeLabel({required this.color, required this.text});
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _MiniPage extends StatelessWidget {
  const _MiniPage({required this.accent, required this.title, required this.sub});
  final Color accent;
  final String title;
  final String sub;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kLine),
      ),
      child: Row(
        children: [
          Container(
            width: 6, height: 22,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: _kInk, fontSize: 10.5, fontWeight: FontWeight.w800, fontFamily: 'monospace')),
                Text(sub,   style: TextStyle(color: _kInkMuted, fontSize: 9.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomTabBarMock extends StatelessWidget {
  const _BottomTabBarMock();

  @override
  Widget build(BuildContext context) {
    final List<_TabSpec> tabs = const <_TabSpec>[
      _TabSpec(icon: Icons.storefront_outlined, label: 'Shop', active: true),
      _TabSpec(icon: Icons.search, label: 'Search'),
      _TabSpec(icon: Icons.shopping_cart_outlined, label: 'Cart'),
      _TabSpec(icon: Icons.person_outline, label: 'Me'),
    ];
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kLine),
      ),
      child: Row(
        children: <Widget>[
          for (final _TabSpec t in tabs)
            Expanded(
              child: Column(
                children: [
                  Icon(t.icon, size: 14, color: t.active ? _kAccent : _kInkMuted),
                  Text(
                    t.label,
                    style: TextStyle(
                      color: t.active ? _kAccent : _kInkMuted,
                      fontSize: 9,
                      fontWeight: t.active ? FontWeight.w800 : FontWeight.w500,
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

class _TabSpec {
  const _TabSpec({required this.icon, required this.label, this.active = false});
  final IconData icon;
  final String label;
  final bool active;
}

class _NestedExplanation extends StatelessWidget {
  const _NestedExplanation();

  @override
  Widget build(BuildContext context) {
    final List<_NestedNote> notes = const <_NestedNote>[
      _NestedNote(
        icon: Icons.layers,
        color: _kAccent,
        title: 'Outer owns the shell',
        body: 'The top-level RouterDelegate routes by first segment '
            '(/shop, /search, /cart, /me) and renders the appropriate '
            'inner Router widget inside its Page.',
      ),
      _NestedNote(
        icon: Icons.filter_center_focus,
        color: _kAccent3,
        title: 'Inner owns the sub-path',
        body: 'The inner Router has its own delegate and parser that only '
            'understand /products, /products/:id, /products/:id/reviews. '
            'They never see /shop.',
      ),
      _NestedNote(
        icon: Icons.arrow_back,
        color: _kAccent4,
        title: 'Back button priority',
        body: 'Each inner Router installs a ChildBackButtonDispatcher and '
            'calls takePriority() in didChangeDependencies. The first '
            'visible router consumes the press.',
      ),
      _NestedNote(
        icon: Icons.link,
        color: _kAccent2,
        title: 'URL composition',
        body: 'The outer reports /shop, the inner reports /products/42 — '
            'Flutter concatenates them into the browser bar as '
            '/shop/products/42.',
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final _NestedNote n in notes) ...[
          _NestedNoteCard(note: n),
          SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _NestedNote {
  const _NestedNote({
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

class _NestedNoteCard extends StatelessWidget {
  const _NestedNoteCard({required this.note});
  final _NestedNote note;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kLine),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(
              color: note.color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(note.icon, color: note.color, size: 18),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  style: TextStyle(
                    color: _kInk,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  note.body,
                  style: TextStyle(
                    color: _kInkMuted,
                    fontSize: 12,
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

// =====================================================================
// PITFALLS
// =====================================================================
class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    final List<_Pitfall> items = const <_Pitfall>[
      _Pitfall(
        icon: Icons.warning_amber_rounded,
        color: _kDanger,
        title: 'Forgetting MaterialApp.router',
        body: 'Using a normal MaterialApp(home:) silently ignores delegate '
            'and parser — wiring compiles but URLs never reach you.',
      ),
      _Pitfall(
        icon: Icons.history_edu,
        color: _kWarn,
        title: 'Mutable RouteInformation',
        body: 'Treat RouteInformation as immutable. Mutating fields after '
            'reporting confuses the engine\'s history snapshots on web.',
      ),
      _Pitfall(
        icon: Icons.power_settings_new,
        color: _kAccent3,
        title: 'notifyListeners after dispose',
        body: 'Stream subscriptions in delegates must be cancelled in '
            'dispose() — otherwise hot reload or sign-out leaks notifies.',
      ),
      _Pitfall(
        icon: Icons.link_off,
        color: _kAccent5,
        title: 'Deep link parsing gaps',
        body: 'Forgetting a fallback in parseRouteInformation drops users '
            'on a blank Navigator. Always return a "not-found" config.',
      ),
      _Pitfall(
        icon: Icons.report_gmailerrorred,
        color: _kInfo,
        title: 'Missing reportRouteInformation',
        body: 'Without it, the URL bar never updates after in-app navigation '
            '— users cannot share or bookmark the current page.',
      ),
      _Pitfall(
        icon: Icons.sync_problem,
        color: _kAccent2,
        title: 'Web back-button races',
        body: 'Async setNewRoutePath calls can race fast back/forward '
            'clicks. Guard with a generation counter or last-call wins.',
      ),
    ];

    return Container(
      padding: EdgeInsets.fromLTRB(32, 32, 32, 32),
      color: _kPaperWarm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            kicker: 'PITFALLS',
            title: 'Six gotchas, sharply explained',
            subtitle: 'Most Router 2.0 bugs are about lifecycle, not syntax. '
                'Keep these on a checklist.',
            accent: _kDanger,
          ),
          SizedBox(height: 22),
          _PitfallsGrid(items: items),
        ],
      ),
    );
  }
}

class _Pitfall {
  const _Pitfall({
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

class _PitfallsGrid extends StatelessWidget {
  const _PitfallsGrid({required this.items});
  final List<_Pitfall> items;

  @override
  Widget build(BuildContext context) {
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < items.length; i += 3) {
      final List<Widget> cells = <Widget>[];
      for (int j = 0; j < 3; j++) {
        final int idx = i + j;
        if (idx >= items.length) {
          cells.add(Expanded(child: SizedBox()));
        } else {
          cells.add(Expanded(child: _PitfallCard(item: items[idx])));
        }
        if (j < 2) cells.add(SizedBox(width: 14));
      }
      rows.add(Row(crossAxisAlignment: CrossAxisAlignment.start, children: cells));
      rows.add(SizedBox(height: 14));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    );
  }
}

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({required this.item});
  final _Pitfall item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kLine),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32, height: 32,
                decoration: BoxDecoration(
                  color: item.color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(item.icon, color: item.color, size: 18),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  item.title,
                  style: TextStyle(
                    color: _kInk,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    height: 1.25,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            item.body,
            style: TextStyle(
              color: _kInkMuted,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// FOOTER CHEAT SHEET
// =====================================================================
class _FooterCheatSheetSection extends StatelessWidget {
  const _FooterCheatSheetSection();

  @override
  Widget build(BuildContext context) {
    final List<_TypeChip> chips = const <_TypeChip>[
      _TypeChip(name: 'Router', role: 'widget', color: _kAccent),
      _TypeChip(name: 'RouterDelegate', role: 'abstract', color: _kAccent2),
      _TypeChip(name: 'RouteInformationParser', role: 'abstract', color: _kAccent3),
      _TypeChip(name: 'RouteInformationProvider', role: 'abstract', color: _kAccent4),
      _TypeChip(name: 'PlatformRouteInformationProvider', role: 'concrete', color: _kAccent5),
      _TypeChip(name: 'RouteInformation', role: 'data', color: _kInfo),
      _TypeChip(name: 'BackButtonDispatcher', role: 'abstract', color: _kWarn),
      _TypeChip(name: 'RootBackButtonDispatcher', role: 'concrete', color: _kDanger),
      _TypeChip(name: 'ChildBackButtonDispatcher', role: 'concrete', color: _kSuccess),
      _TypeChip(name: 'PopNavigatorRouterDelegateMixin', role: 'mixin', color: _kAccent),
      _TypeChip(name: 'Navigator', role: 'widget', color: _kAccent2),
      _TypeChip(name: 'Page', role: 'abstract', color: _kAccent3),
      _TypeChip(name: 'MaterialPage / CupertinoPage', role: 'concrete', color: _kAccent4),
      _TypeChip(name: 'MaterialApp.router', role: 'constructor', color: _kAccent5),
      _TypeChip(name: 'WidgetsApp.router', role: 'constructor', color: _kInfo),
      _TypeChip(name: 'TransitionDelegate', role: 'abstract', color: _kWarn),
    ];

    // Also build a real RouteInformation to demonstrate live API surface.
    final RouteInformation demo = RouteInformation(
      uri: Uri.parse('/footer/demo?showcase=1'),
    );

    return Container(
      padding: EdgeInsets.fromLTRB(32, 32, 32, 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF101938),
            Color(0xFF0A1230),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 6, height: 22, decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              SizedBox(width: 10),
              Text(
                'CHEAT SHEET',
                style: TextStyle(
                  color: Colors.amberAccent,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.6,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Every type that participates in Router 2.0',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Print this and pin it above the desk. The framework only asks '
            'these collaborators to talk; the rest is your domain model.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.72),
              fontSize: 13,
              height: 1.5,
            ),
          ),
          SizedBox(height: 22),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              for (final _TypeChip c in chips) _ChipPill(chip: c),
            ],
          ),
          SizedBox(height: 22),
          Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.bookmark, color: Colors.amberAccent, size: 18),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quick demo: built at build()-time',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'RouteInformation(uri: ${demo.uri})',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 12,
                          fontFamily: 'monospace',
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'path  = ${demo.uri.path}    queryParameters = ${demo.uri.queryParameters}',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.75),
                          fontSize: 11,
                          fontFamily: 'monospace',
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 18),
          Row(
            children: [
              Icon(Icons.copyright, color: Colors.white.withValues(alpha: 0.5), size: 12),
              SizedBox(width: 4),
              Text(
                'Router 2.0 Atlas · pure framework · snapshot demo',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.55),
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(child: SizedBox()),
              Icon(Icons.bolt, color: Colors.amberAccent, size: 12),
              SizedBox(width: 4),
              Text(
                'd4rt sandbox · single build() entrypoint',
                style: TextStyle(
                  color: Colors.amberAccent.withValues(alpha: 0.85),
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TypeChip {
  const _TypeChip({required this.name, required this.role, required this.color});
  final String name;
  final String role;
  final Color color;
}

class _ChipPill extends StatelessWidget {
  const _ChipPill({required this.chip});
  final _TypeChip chip;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: chip.color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: chip.color.withValues(alpha: 0.55)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            chip.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
          SizedBox(width: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              chip.role,
              style: TextStyle(
                color: Colors.white,
                fontSize: 9.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// UTILITY — keeps imports referenced (math, ui, foundation, services)
// =====================================================================
final double _kRouterGoldenAngle = math.pi / 6.0;
final ui.Color _kRouterUiColorAccent = const ui.Color(0xFF3F51B5);

class _RouterImportsAnchor {
  const _RouterImportsAnchor();

  // Reference foundation: DiagnosticableTreeMixin via ChangeNotifier-style fact.
  static final ValueListenable<int> _zero = ValueNotifier<int>(0);

  // Reference services: a no-op LogicalKeyboardKey reference (compile-only).
  static final LogicalKeyboardKey _backKey = LogicalKeyboardKey.escape;

  // Reference dart:math
  static final double _piOver4 = math.pi / 4.0;

  // Reference dart:ui
  static final ui.Offset _origin = ui.Offset.zero;
}

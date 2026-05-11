// Deep visual demo for Flutter AppBar / SliverAppBar / BottomAppBar pattern catalog.
// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, deprecated_member_use, prefer_interpolation_to_compose_strings

import "package:flutter/material.dart";

const Color _kInk = Color(0xFF0E1430);
const Color _kInkSoft = Color(0xFF2A3358);
const Color _kInkMuted = Color(0xFF5F6A95);
const Color _kPaper = Color(0xFFF6F7FB);
const Color _kPaperWarm = Color(0xFFFDF8F1);
const Color _kAccent = Color(0xFF6750A4);
const Color _kAccent2 = Color(0xFF00897B);
const Color _kAccent3 = Color(0xFFE91E63);
const Color _kAccent4 = Color(0xFFFB8C00);
const Color _kSuccess = Color(0xFF2E7D32);
const Color _kDanger = Color(0xFFC62828);
const Color _kInfo = Color(0xFF1565C0);
const Color _kWarn = Color(0xFFEF6C00);

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "AppBar Pattern Catalog",
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _kAccent,
      scaffoldBackgroundColor: _kPaper,
      fontFamily: "Roboto",
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
              _VariantGallerySection(),
              _ActionSlotPatternsSection(),
              _TitleStylingSection(),
              _LeadingPatternsSection(),
              _FlexibleSpaceGallerySection(),
              _BottomAppBarShowcaseSection(),
              _SliverAppBarShowcaseSection(),
              _ToolbarHeightSection(),
              _ElevationComparisonSection(),
              _AccessibilitySection(),
              _AnatomyDiagramSection(),
              _FooterSection(),
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
      padding: EdgeInsets.fromLTRB(32, 36, 32, 36),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0E1430),
            Color(0xFF2C2256),
            Color(0xFF6750A4),
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
                Container(
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
                      Icon(Icons.auto_awesome, color: Colors.amberAccent, size: 14),
                      SizedBox(width: 6),
                      Text(
                        "AppBar Pattern Catalog",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Mobile App Navigation Deck",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.6,
                    height: 1.05,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "A visual atlas of AppBar, SliverAppBar and BottomAppBar variants.",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.78),
                    fontSize: 15,
                    height: 1.45,
                  ),
                ),
                SizedBox(height: 22),
                Row(
                  children: [
                    _HeroChip(icon: Icons.layers, label: "12 sections"),
                    SizedBox(width: 10),
                    _HeroChip(icon: Icons.widgets, label: "30+ variants"),
                    SizedBox(width: 10),
                    _HeroChip(icon: Icons.bolt, label: "Static snapshot"),
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
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.22),
        ),
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
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.18),
        ),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Color(0xFFFF5F57),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 6),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Color(0xFFFEBC2E),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 6),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Color(0xFF28C840),
                  shape: BoxShape.circle,
                ),
              ),
              Spacer(),
              Text(
                "preview.dart",
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 11,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          SizedBox(height: 14),
          _MiniAppBarMock(
            color: Color(0xFF6750A4),
            title: "Inbox",
            leading: Icons.menu,
            actions: [Icons.search, Icons.more_vert],
          ),
          SizedBox(height: 10),
          _MiniAppBarMock(
            color: Color(0xFF00897B),
            title: "Today",
            leading: Icons.arrow_back,
            actions: [Icons.filter_list],
          ),
          SizedBox(height: 10),
          _MiniAppBarMock(
            color: Color(0xFFE91E63),
            title: "Profile",
            leading: Icons.close,
            actions: [Icons.share, Icons.bookmark_outline],
          ),
        ],
      ),
    );
  }
}

class _MiniAppBarMock extends StatelessWidget {
  const _MiniAppBarMock({
    required this.color,
    required this.title,
    required this.leading,
    required this.actions,
  });
  final Color color;
  final String title;
  final IconData leading;
  final List<IconData> actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [color, color.withValues(alpha: 0.75)],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(leading, color: Colors.white, size: 18),
          SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          for (final a in actions) ...[
            Icon(a, color: Colors.white.withValues(alpha: 0.92), size: 18),
            SizedBox(width: 10),
          ],
        ],
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
      padding: EdgeInsets.fromLTRB(32, 36, 32, 24),
      color: _kPaper,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(
            kicker: "01 · INTRODUCTION",
            title: "Why a catalog of AppBars?",
            subtitle:
                "AppBar drives perception of every Flutter screen. Small variations in title alignment, leading icon, action density or flexibleSpace materially change the feeling of a product.",
          ),
          SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _IntroCard(
                icon: Icons.menu_book,
                color: _kAccent,
                title: "Reference",
                body: "A side-by-side reference of common AppBar shapes you would build in a production app.",
              )),
              SizedBox(width: 16),
              Expanded(child: _IntroCard(
                icon: Icons.dashboard_customize,
                color: _kAccent2,
                title: "Composability",
                body: "Each AppBar is a regular Widget; combine actions, leading, titles, and flexibleSpace.",
              )),
              SizedBox(width: 16),
              Expanded(child: _IntroCard(
                icon: Icons.brush,
                color: _kAccent3,
                title: "Theming",
                body: "Material 3 surfaces respond to seed colors, tints, scrolledUnder states and elevation.",
              )),
              SizedBox(width: 16),
              Expanded(child: _IntroCard(
                icon: Icons.checklist,
                color: _kAccent4,
                title: "Checklist",
                body: "Use this deck to audit nav clarity, action priority, and accessibility on each screen.",
              )),
            ],
          ),
          SizedBox(height: 26),
          _LegendRow(),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({
    required this.kicker,
    required this.title,
    required this.subtitle,
  });
  final String kicker;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          kicker,
          style: TextStyle(
            color: _kAccent,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 2.0,
          ),
        ),
        SizedBox(height: 6),
        Text(
          title,
          style: TextStyle(
            color: _kInk,
            fontSize: 26,
            fontWeight: FontWeight.w800,
            height: 1.1,
            letterSpacing: -0.4,
          ),
        ),
        SizedBox(height: 8),
        Container(
          constraints: BoxConstraints(maxWidth: 780),
          child: Text(
            subtitle,
            style: TextStyle(
              color: _kInkMuted,
              fontSize: 14.5,
              height: 1.5,
            ),
          ),
        ),
      ],
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kInk.withValues(alpha: 0.06)),
        boxShadow: [
          BoxShadow(
            color: _kInk.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color, color.withValues(alpha: 0.65)],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          SizedBox(height: 14),
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
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendRow extends StatelessWidget {
  const _LegendRow();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kInk.withValues(alpha: 0.06)),
      ),
      child: Row(
        children: [
          _LegendDot(color: _kAccent, label: "Primary surface"),
          SizedBox(width: 18),
          _LegendDot(color: _kAccent2, label: "Secondary surface"),
          SizedBox(width: 18),
          _LegendDot(color: _kAccent3, label: "Highlight"),
          SizedBox(width: 18),
          _LegendDot(color: _kInfo, label: "Info"),
          SizedBox(width: 18),
          _LegendDot(color: _kWarn, label: "Warning"),
          Spacer(),
          Icon(Icons.info_outline, size: 14, color: _kInkMuted),
          SizedBox(width: 6),
          Text(
            "All variants are statically rendered for catalog purposes.",
            style: TextStyle(
              color: _kInkMuted,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});
  final Color color;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 6,
              ),
            ],
          ),
        ),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: _kInkSoft,
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// VARIANT GALLERY SECTION
// =====================================================================
class _VariantGallerySection extends StatelessWidget {
  const _VariantGallerySection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 24, 32, 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_kPaper, Color(0xFFEFE9F7)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(
            kicker: "02 · VARIANT GALLERY",
            title: "Six core AppBar shapes",
            subtitle:
                "From the standard small AppBar to medium and large M3 variants, each shape implies a different posture for content below it.",
          ),
          SizedBox(height: 22),
          _VariantRow(
            label: "Small · standard",
            tag: "AppBar",
            description:
                "The default Material AppBar. 56 dp toolbar height. Reads as the canonical mobile chrome.",
            child: _StandardAppBarPreview(),
          ),
          SizedBox(height: 18),
          _VariantRow(
            label: "Small · centered title",
            tag: "centerTitle: true",
            description:
                "Centered titles work best for single-screen experiences or destinations with no back action.",
            child: _CenteredAppBarPreview(),
          ),
          SizedBox(height: 18),
          _VariantRow(
            label: "Medium · M3 collapsed",
            tag: "AppBar (toolbarHeight: 96)",
            description:
                "Medium AppBars give a stronger sense of context — useful for top-level sections.",
            child: _MediumAppBarPreview(),
          ),
          SizedBox(height: 18),
          _VariantRow(
            label: "Large · M3 hero",
            tag: "AppBar (toolbarHeight: 128)",
            description:
                "Large AppBars create cinematic page intros. Pair with a single primary action and a clear back arrow.",
            child: _LargeAppBarPreview(),
          ),
          SizedBox(height: 18),
          _VariantRow(
            label: "Translucent · gradient",
            tag: "flexibleSpace + gradient",
            description:
                "Translucent AppBars with a gradient flexibleSpace bring a hero header look without leaving Material.",
            child: _TranslucentAppBarPreview(),
          ),
          SizedBox(height: 18),
          _VariantRow(
            label: "Dense · compact",
            tag: "toolbarHeight: 44",
            description:
                "Useful for utility surfaces — search overlays, file pickers, in-app browsers.",
            child: _DenseAppBarPreview(),
          ),
        ],
      ),
    );
  }
}

class _VariantRow extends StatelessWidget {
  const _VariantRow({
    required this.label,
    required this.tag,
    required this.description,
    required this.child,
  });
  final String label;
  final String tag;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kInk.withValues(alpha: 0.06)),
        boxShadow: [
          BoxShadow(
            color: _kInk.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: EdgeInsets.all(18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 240,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: _kAccent.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      color: _kAccent,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      fontFamily: "monospace",
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  label,
                  style: TextStyle(
                    color: _kInk,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    color: _kInkMuted,
                    fontSize: 12.5,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 24),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

class _StandardAppBarPreview extends StatelessWidget {
  const _StandardAppBarPreview();
  @override
  Widget build(BuildContext context) {
    return _DevicePreview(
      height: 180,
      appBar: AppBar(
        backgroundColor: _kAccent,
        foregroundColor: Colors.white,
        title: Text("Inbox"),
        leading: Icon(Icons.menu),
        actions: [
          Icon(Icons.search),
          SizedBox(width: 14),
          Icon(Icons.more_vert),
          SizedBox(width: 12),
        ],
      ),
    );
  }
}

class _CenteredAppBarPreview extends StatelessWidget {
  const _CenteredAppBarPreview();
  @override
  Widget build(BuildContext context) {
    return _DevicePreview(
      height: 180,
      appBar: AppBar(
        backgroundColor: _kAccent2,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text("Today"),
        leading: Icon(Icons.arrow_back),
        actions: [
          Icon(Icons.tune),
          SizedBox(width: 12),
        ],
      ),
    );
  }
}

class _MediumAppBarPreview extends StatelessWidget {
  const _MediumAppBarPreview();
  @override
  Widget build(BuildContext context) {
    return _DevicePreview(
      height: 220,
      appBar: AppBar(
        toolbarHeight: 96,
        backgroundColor: _kAccent3,
        foregroundColor: Colors.white,
        leading: Icon(Icons.arrow_back),
        title: Padding(
          padding: EdgeInsets.only(top: 18),
          child: Text(
            "Library",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ),
        actions: [
          Icon(Icons.search),
          SizedBox(width: 14),
          Icon(Icons.more_vert),
          SizedBox(width: 12),
        ],
      ),
    );
  }
}

class _LargeAppBarPreview extends StatelessWidget {
  const _LargeAppBarPreview();
  @override
  Widget build(BuildContext context) {
    return _DevicePreview(
      height: 260,
      appBar: AppBar(
        toolbarHeight: 128,
        backgroundColor: _kAccent4,
        foregroundColor: Colors.white,
        leading: Icon(Icons.arrow_back),
        title: Padding(
          padding: EdgeInsets.only(top: 48, bottom: 14),
          child: Text(
            "Settings",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
          ),
        ),
        actions: [
          Icon(Icons.help_outline),
          SizedBox(width: 14),
        ],
      ),
    );
  }
}

class _TranslucentAppBarPreview extends StatelessWidget {
  const _TranslucentAppBarPreview();
  @override
  Widget build(BuildContext context) {
    return _DevicePreview(
      height: 200,
      backgroundChild: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A237E), Color(0xFF6A1B9A), Color(0xFFE91E63)],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text("Discover"),
        leading: Icon(Icons.arrow_back),
        actions: [
          Icon(Icons.favorite_outline),
          SizedBox(width: 14),
          Icon(Icons.share),
          SizedBox(width: 12),
        ],
      ),
    );
  }
}

class _DenseAppBarPreview extends StatelessWidget {
  const _DenseAppBarPreview();
  @override
  Widget build(BuildContext context) {
    return _DevicePreview(
      height: 160,
      appBar: AppBar(
        toolbarHeight: 44,
        backgroundColor: _kInk,
        foregroundColor: Colors.white,
        title: Text("file://docs/spec.md", style: TextStyle(fontSize: 13)),
        leading: Icon(Icons.close, size: 18),
        actions: [
          Icon(Icons.open_in_new, size: 16),
          SizedBox(width: 14),
        ],
      ),
    );
  }
}

class _DevicePreview extends StatelessWidget {
  const _DevicePreview({
    required this.height,
    required this.appBar,
    this.backgroundChild,
  });
  final double height;
  final PreferredSizeWidget appBar;
  final Widget? backgroundChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Color(0xFFF1ECF7),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kInk.withValues(alpha: 0.08)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9),
        child: Stack(
          children: [
            if (backgroundChild != null) Positioned.fill(child: backgroundChild!),
            Column(
              children: [
                appBar,
                Expanded(
                  child: Container(
                    color: backgroundChild != null
                        ? Colors.transparent
                        : Colors.white,
                    padding: EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _MockListTile(title: "Daily standup", subtitle: "9:30 AM · Eng team"),
                        SizedBox(height: 8),
                        _MockListTile(title: "Design sync", subtitle: "11:00 AM · Atelier"),
                        SizedBox(height: 8),
                        _MockListTile(title: "Lunch", subtitle: "12:30 PM · Cafe Verde"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MockListTile extends StatelessWidget {
  const _MockListTile({required this.title, required this.subtitle});
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: _kAccent.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.event, size: 14, color: _kAccent),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: _kInk, fontSize: 13, fontWeight: FontWeight.w600)),
              SizedBox(height: 2),
              Text(subtitle, style: TextStyle(color: _kInkMuted, fontSize: 11)),
            ],
          ),
        ),
        Icon(Icons.chevron_right, size: 16, color: _kInkMuted),
      ],
    );
  }
}

// =====================================================================
// ACTION SLOT PATTERNS
// =====================================================================
class _ActionSlotPatternsSection extends StatelessWidget {
  const _ActionSlotPatternsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 32, 32, 32),
      color: _kPaper,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(
            kicker: "03 · ACTION SLOTS",
            title: "What lives on the right side?",
            subtitle:
                "AppBar `actions` are the strongest secondary surface in the chrome. Use them for high-frequency, low-friction operations.",
          ),
          SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _ActionSlotCard(
                title: "Single primary",
                blurb: "One icon — usually search or filter.",
                preview: _ActionBarMock(
                  color: _kAccent,
                  title: "Notes",
                  actions: [Icons.search],
                ),
              )),
              SizedBox(width: 14),
              Expanded(child: _ActionSlotCard(
                title: "Primary + overflow",
                blurb: "Hero action plus three-dot menu.",
                preview: _ActionBarMock(
                  color: _kAccent2,
                  title: "Photos",
                  actions: [Icons.add_a_photo, Icons.more_vert],
                ),
              )),
              SizedBox(width: 14),
              Expanded(child: _ActionSlotCard(
                title: "Three-icon",
                blurb: "Avoid more than 3 unless icons are very recognizable.",
                preview: _ActionBarMock(
                  color: _kAccent3,
                  title: "Mail",
                  actions: [Icons.search, Icons.refresh, Icons.more_vert],
                ),
              )),
              SizedBox(width: 14),
              Expanded(child: _ActionSlotCard(
                title: "Labelled action",
                blurb: "TextButton actions read as commands, not toggles.",
                preview: _ActionBarMock(
                  color: _kAccent4,
                  title: "Draft",
                  labelAction: "Send",
                ),
              )),
            ],
          ),
          SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _ActionSlotCard(
                title: "Filled button",
                blurb: "For destructive submit, use FilledButton tonal.",
                preview: _ActionBarMock(
                  color: _kInk,
                  title: "New issue",
                  filledLabel: "Publish",
                ),
              )),
              SizedBox(width: 14),
              Expanded(child: _ActionSlotCard(
                title: "Avatar tail",
                blurb: "Account chip as the last action.",
                preview: _ActionBarMock(
                  color: _kInfo,
                  title: "Dashboard",
                  trailingAvatar: true,
                  actions: [Icons.notifications_none],
                ),
              )),
              SizedBox(width: 14),
              Expanded(child: _ActionSlotCard(
                title: "Toggle group",
                blurb: "View-mode switcher inline in the AppBar.",
                preview: _ActionBarMock(
                  color: _kSuccess,
                  title: "Calendar",
                  toggleGroup: true,
                ),
              )),
              SizedBox(width: 14),
              Expanded(child: _ActionSlotCard(
                title: "Badged",
                blurb: "Notification dot indicates unseen state.",
                preview: _ActionBarMock(
                  color: _kDanger,
                  title: "Alerts",
                  badged: true,
                  actions: [Icons.tune],
                ),
              )),
            ],
          ),
          SizedBox(height: 22),
          _ActionPriorityTable(),
        ],
      ),
    );
  }
}

class _ActionSlotCard extends StatelessWidget {
  const _ActionSlotCard({
    required this.title,
    required this.blurb,
    required this.preview,
  });
  final String title;
  final String blurb;
  final Widget preview;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kInk.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: _kInk, fontSize: 14, fontWeight: FontWeight.w700)),
          SizedBox(height: 4),
          Text(blurb, style: TextStyle(color: _kInkMuted, fontSize: 11.5, height: 1.4)),
          SizedBox(height: 12),
          preview,
        ],
      ),
    );
  }
}

class _ActionBarMock extends StatelessWidget {
  const _ActionBarMock({
    required this.color,
    required this.title,
    this.actions = const [],
    this.labelAction,
    this.filledLabel,
    this.trailingAvatar = false,
    this.toggleGroup = false,
    this.badged = false,
  });
  final Color color;
  final String title;
  final List<IconData> actions;
  final String? labelAction;
  final String? filledLabel;
  final bool trailingAvatar;
  final bool toggleGroup;
  final bool badged;

  @override
  Widget build(BuildContext context) {
    final tail = <Widget>[];
    for (int i = 0; i < actions.length; i++) {
      final a = actions[i];
      tail.add(badged && i == 0
          ? Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(a, color: Colors.white, size: 18),
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.amberAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            )
          : Icon(a, color: Colors.white, size: 18));
      tail.add(SizedBox(width: 12));
    }
    if (labelAction != null) {
      tail.add(Text(
        labelAction!,
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ));
      tail.add(SizedBox(width: 8));
    }
    if (filledLabel != null) {
      tail.add(Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          filledLabel!,
          style: TextStyle(
            color: color,
            fontSize: 11.5,
            fontWeight: FontWeight.w800,
          ),
        ),
      ));
      tail.add(SizedBox(width: 8));
    }
    if (toggleGroup) {
      tail.add(Container(
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text("D", style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w800)),
            ),
            SizedBox(width: 4),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              child: Text("W", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              child: Text("M", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ));
      tail.add(SizedBox(width: 8));
    }
    if (trailingAvatar) {
      tail.add(Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 2),
        ),
        child: Center(
          child: Text("A",
              style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w800)),
        ),
      ));
      tail.add(SizedBox(width: 8));
    }
    return Container(
      height: 48,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.menu, color: Colors.white, size: 18),
          SizedBox(width: 12),
          Text(title,
              style: TextStyle(
                  color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700)),
          Spacer(),
          ...tail,
        ],
      ),
    );
  }
}

class _ActionPriorityTable extends StatelessWidget {
  const _ActionPriorityTable();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFF8EC), Color(0xFFFFE2C2)],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.priority_high, color: _kWarn, size: 18),
              SizedBox(width: 8),
              Text("Action priority cheat sheet",
                  style: TextStyle(
                      color: _kInk, fontSize: 15, fontWeight: FontWeight.w800)),
            ],
          ),
          SizedBox(height: 12),
          _PriorityRow(level: "P0", label: "Primary screen action", example: "Search · Add"),
          _PriorityRow(level: "P1", label: "Frequent secondary", example: "Filter · Refresh"),
          _PriorityRow(level: "P2", label: "Overflow / contextual", example: "Sort · Settings"),
          _PriorityRow(level: "P3", label: "Tertiary / discoverable", example: "Help · About"),
        ],
      ),
    );
  }
}

class _PriorityRow extends StatelessWidget {
  const _PriorityRow({required this.level, required this.label, required this.example});
  final String level;
  final String label;
  final String example;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 32,
            padding: EdgeInsets.symmetric(vertical: 3),
            decoration: BoxDecoration(
              color: _kWarn,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(level,
                  style: TextStyle(
                      color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)),
            ),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 180,
            child: Text(label,
                style: TextStyle(color: _kInk, fontSize: 13, fontWeight: FontWeight.w600)),
          ),
          Text(example, style: TextStyle(color: _kInkMuted, fontSize: 12.5)),
        ],
      ),
    );
  }
}

// =====================================================================
// TITLE STYLING SECTION
// =====================================================================
class _TitleStylingSection extends StatelessWidget {
  const _TitleStylingSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 8, 32, 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_kPaper, _kPaperWarm],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(
            kicker: "04 · TITLE STYLING",
            title: "Title types and density",
            subtitle:
                "Titles carry the page identity. They can be plain text, a label-and-subtitle pair, a breadcrumb, a search field, or a brand mark.",
          ),
          SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _TitleStyleCard(
                label: "Plain title",
                appBar: AppBar(
                  backgroundColor: _kAccent,
                  foregroundColor: Colors.white,
                  title: Text("Plain"),
                  leading: Icon(Icons.menu),
                ),
              )),
              SizedBox(width: 14),
              Expanded(child: _TitleStyleCard(
                label: "Title + subtitle",
                appBar: AppBar(
                  backgroundColor: _kAccent2,
                  foregroundColor: Colors.white,
                  leading: Icon(Icons.menu),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Project Atlas",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                      Text("12 open tasks",
                          style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w400,
                              color: Colors.white70)),
                    ],
                  ),
                ),
              )),
              SizedBox(width: 14),
              Expanded(child: _TitleStyleCard(
                label: "Breadcrumb",
                appBar: AppBar(
                  backgroundColor: _kAccent3,
                  foregroundColor: Colors.white,
                  leading: Icon(Icons.arrow_back),
                  title: Row(
                    children: [
                      Text("Workspaces",
                          style: TextStyle(
                              fontSize: 13.5,
                              color: Colors.white.withValues(alpha: 0.7))),
                      Icon(Icons.chevron_right, size: 16, color: Colors.white70),
                      Text("Atlas",
                          style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              )),
            ],
          ),
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _TitleStyleCard(
                label: "Search field title",
                appBar: AppBar(
                  backgroundColor: _kInfo,
                  foregroundColor: Colors.white,
                  leading: Icon(Icons.arrow_back),
                  title: Container(
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Icon(Icons.search, size: 18, color: Colors.white70),
                        SizedBox(width: 8),
                        Text("Search packages...",
                            style: TextStyle(
                                color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                  ),
                ),
              )),
              SizedBox(width: 14),
              Expanded(child: _TitleStyleCard(
                label: "Brand mark",
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  foregroundColor: _kInk,
                  elevation: 0,
                  leading: Icon(Icons.menu, color: _kInk),
                  title: Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [_kAccent, _kAccent3],
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text("atlas",
                          style: TextStyle(
                              color: _kInk,
                              fontSize: 17,
                              fontWeight: FontWeight.w800)),
                      Text(".dev",
                          style: TextStyle(
                              color: _kAccent,
                              fontSize: 17,
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                  actions: [
                    Icon(Icons.notifications_none, color: _kInk),
                    SizedBox(width: 14),
                  ],
                ),
              )),
              SizedBox(width: 14),
              Expanded(child: _TitleStyleCard(
                label: "Status pill title",
                appBar: AppBar(
                  backgroundColor: _kInk,
                  foregroundColor: Colors.white,
                  leading: Icon(Icons.arrow_back),
                  title: Row(
                    children: [
                      Text("Build #1284",
                          style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700)),
                      SizedBox(width: 10),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: _kSuccess,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text("PASSED",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                letterSpacing: 0.7,
                                fontWeight: FontWeight.w800)),
                      ),
                    ],
                  ),
                ),
              )),
            ],
          ),
          SizedBox(height: 22),
          _TitleDosAndDonts(),
        ],
      ),
    );
  }
}

class _TitleStyleCard extends StatelessWidget {
  const _TitleStyleCard({required this.label, required this.appBar});
  final String label;
  final PreferredSizeWidget appBar;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kInk.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  color: _kInk, fontSize: 13, fontWeight: FontWeight.w700)),
          SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 56,
              child: appBar,
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleDosAndDonts extends StatelessWidget {
  const _TitleDosAndDonts();
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFE7F6EC), Color(0xFFBFE6CC)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.check_circle, color: _kSuccess, size: 18),
                    SizedBox(width: 6),
                    Text("Do",
                        style: TextStyle(
                            color: _kSuccess,
                            fontSize: 14,
                            fontWeight: FontWeight.w800)),
                  ],
                ),
                SizedBox(height: 8),
                _Bullet(text: "Match title to the page heading the user expects."),
                _Bullet(text: "Keep titles to 1-3 words, sentence case."),
                _Bullet(text: "Use a subtitle for contextual numbers (counts, states)."),
                _Bullet(text: "Truncate with ellipsis at word boundaries."),
              ],
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFDECEC), Color(0xFFF7BDBD)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.cancel, color: _kDanger, size: 18),
                    SizedBox(width: 6),
                    Text("Don\u2019t",
                        style: TextStyle(
                            color: _kDanger,
                            fontSize: 14,
                            fontWeight: FontWeight.w800)),
                  ],
                ),
                SizedBox(height: 8),
                _Bullet(text: "Repeat the brand name on every screen."),
                _Bullet(text: "Stuff long sentences into the title slot."),
                _Bullet(text: "Use ALL CAPS unless it is a strict brand token."),
                _Bullet(text: "Hide the only back action behind an overflow menu."),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6),
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: _kInk.withValues(alpha: 0.55),
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: _kInk, fontSize: 12.5, height: 1.45),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// LEADING PATTERNS SECTION
// =====================================================================
class _LeadingPatternsSection extends StatelessWidget {
  const _LeadingPatternsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 8, 32, 32),
      color: _kPaperWarm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(
            kicker: "05 · LEADING SLOT",
            title: "What the leading icon implies",
            subtitle:
                "The leading slot tells the user what happens when they press the upper-left of the screen. Be consistent across routes.",
          ),
          SizedBox(height: 22),
          _LeadingMatrix(),
        ],
      ),
    );
  }
}

class _LeadingMatrix extends StatelessWidget {
  const _LeadingMatrix();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _LeadingMatrixRow(items: [
          _LeadingCellData(icon: Icons.menu, label: "Drawer toggle", color: _kAccent,
              note: "Top-level destinations only."),
          _LeadingCellData(icon: Icons.arrow_back, label: "Back", color: _kAccent2,
              note: "Pops the route stack."),
          _LeadingCellData(icon: Icons.close, label: "Dismiss", color: _kAccent3,
              note: "Closes modal or full-screen sheet."),
          _LeadingCellData(icon: Icons.arrow_back_ios_new, label: "iOS back", color: _kAccent4,
              note: "When you mimic iOS visual language."),
        ]),
        SizedBox(height: 16),
        _LeadingMatrixRow(items: [
          _LeadingCellData(icon: Icons.home_outlined, label: "Home", color: _kInfo,
              note: "Special — jumps to root, not pop."),
          _LeadingCellData(icon: Icons.chevron_left, label: "Step back", color: _kSuccess,
              note: "Used in wizards / setup flows."),
          _LeadingCellData(icon: Icons.location_pin, label: "Context", color: _kWarn,
              note: "Indicates location/scope, not navigation."),
          _LeadingCellData(icon: Icons.image, label: "Avatar/logo", color: _kDanger,
              note: "Use for branded destinations."),
        ]),
        SizedBox(height: 18),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kInk.withValues(alpha: 0.06)),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: _kWarn, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Tip: never make leading do something other than navigate. If you need a non-navigational glyph, put it inside the title or actions slot.",
                  style: TextStyle(
                      color: _kInkSoft, fontSize: 12.5, height: 1.45),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LeadingCellData {
  const _LeadingCellData({
    required this.icon,
    required this.label,
    required this.color,
    required this.note,
  });
  final IconData icon;
  final String label;
  final Color color;
  final String note;
}

class _LeadingMatrixRow extends StatelessWidget {
  const _LeadingMatrixRow({required this.items});
  final List<_LeadingCellData> items;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < items.length; i++) ...[
          Expanded(child: _LeadingCell(data: items[i])),
          if (i < items.length - 1) SizedBox(width: 14),
        ],
      ],
    );
  }
}

class _LeadingCell extends StatelessWidget {
  const _LeadingCell({required this.data});
  final _LeadingCellData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kInk.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 52,
              child: AppBar(
                backgroundColor: data.color,
                foregroundColor: Colors.white,
                leading: Icon(data.icon),
                title: Text(data.label, style: TextStyle(fontSize: 14)),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(data.label,
              style: TextStyle(
                  color: _kInk, fontSize: 13.5, fontWeight: FontWeight.w700)),
          SizedBox(height: 4),
          Text(data.note,
              style: TextStyle(color: _kInkMuted, fontSize: 11.5, height: 1.4)),
        ],
      ),
    );
  }
}

// =====================================================================
// FLEXIBLE SPACE GALLERY
// =====================================================================
class _FlexibleSpaceGallerySection extends StatelessWidget {
  const _FlexibleSpaceGallerySection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 8, 32, 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_kPaperWarm, _kPaper],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(
            kicker: "06 · FLEXIBLE SPACE",
            title: "flexibleSpace — the artistic layer",
            subtitle:
                "Behind the toolbar lies the flexibleSpace, the canvas for gradients, photos and identity moments. Use it to brand the route.",
          ),
          SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _FlexCard(
                label: "Linear gradient",
                appBar: _gradientAppBar(
                  [Color(0xFF1A237E), Color(0xFF6A1B9A), Color(0xFFE91E63)],
                  "Discover",
                ),
              )),
              SizedBox(width: 14),
              Expanded(child: _FlexCard(
                label: "Sunset",
                appBar: _gradientAppBar(
                  [Color(0xFFFF6B6B), Color(0xFFFF8E53), Color(0xFFFFD166)],
                  "Sunset Mix",
                ),
              )),
              SizedBox(width: 14),
              Expanded(child: _FlexCard(
                label: "Aurora",
                appBar: _gradientAppBar(
                  [Color(0xFF00C9A7), Color(0xFF2E86DE), Color(0xFF8E44AD)],
                  "Aurora",
                ),
              )),
            ],
          ),
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _FlexCard(
                label: "Pattern overlay",
                appBar: _patternAppBar(),
              )),
              SizedBox(width: 14),
              Expanded(child: _FlexCard(
                label: "Photo blur",
                appBar: _photoAppBar(),
              )),
              SizedBox(width: 14),
              Expanded(child: _FlexCard(
                label: "Subtle wash",
                appBar: _washAppBar(),
              )),
            ],
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _gradientAppBar(List<Color> colors, String title) {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 110,
      leading: Icon(Icons.arrow_back),
      title: Padding(
        padding: EdgeInsets.only(top: 30),
        child: Text(title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
      ),
      actions: [Icon(Icons.share), SizedBox(width: 14)],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colors,
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _patternAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 110,
      leading: Icon(Icons.menu),
      title: Padding(
        padding: EdgeInsets.only(top: 30),
        child: Text("Studio",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF111827), Color(0xFF374151)],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              top: -10,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.06),
                ),
              ),
            ),
            Positioned(
              right: 40,
              top: 40,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.04),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _photoAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 110,
      leading: Icon(Icons.arrow_back),
      title: Padding(
        padding: EdgeInsets.only(top: 30),
        child: Text("Field Notes",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
      ),
      actions: [Icon(Icons.bookmark_outline), SizedBox(width: 14)],
      flexibleSpace: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF4E342E), Color(0xFF8D6E63), Color(0xFFD7CCC8)],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Colors.black.withValues(alpha: 0.45),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _washAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: _kInk,
      elevation: 0,
      toolbarHeight: 110,
      leading: Icon(Icons.menu),
      title: Padding(
        padding: EdgeInsets.only(top: 30),
        child: Text("Library",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: _kInk)),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFDFCFF), Color(0xFFEDE7F6)],
          ),
        ),
      ),
    );
  }
}

class _FlexCard extends StatelessWidget {
  const _FlexCard({required this.label, required this.appBar});
  final String label;
  final PreferredSizeWidget appBar;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kInk.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  color: _kInk, fontSize: 13, fontWeight: FontWeight.w700)),
          SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 110,
              child: appBar,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// BOTTOM APP BAR SHOWCASE
// =====================================================================
class _BottomAppBarShowcaseSection extends StatelessWidget {
  const _BottomAppBarShowcaseSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 8, 32, 32),
      color: _kPaper,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(
            kicker: "07 · BOTTOM APP BAR",
            title: "BottomAppBar with FAB notch",
            subtitle:
                "BottomAppBars host secondary actions for one-handed reach. Pair with a docked FloatingActionButton for primary intent.",
          ),
          SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _BottomBarCard(
                label: "Centered notch",
                child: _BottomBarMock(
                  color: Colors.white,
                  iconColor: _kAccent,
                  fab: _FabMock(color: _kAccent, icon: Icons.add),
                  fabLocation: FloatingActionButtonLocation.centerDocked,
                  notchedShape: true,
                ),
              )),
              SizedBox(width: 14),
              Expanded(child: _BottomBarCard(
                label: "End-docked",
                child: _BottomBarMock(
                  color: Colors.white,
                  iconColor: _kAccent2,
                  fab: _FabMock(color: _kAccent2, icon: Icons.edit),
                  fabLocation: FloatingActionButtonLocation.endDocked,
                  notchedShape: true,
                ),
              )),
              SizedBox(width: 14),
              Expanded(child: _BottomBarCard(
                label: "No notch",
                child: _BottomBarMock(
                  color: _kInk,
                  iconColor: Colors.white,
                  fab: null,
                  fabLocation: FloatingActionButtonLocation.centerDocked,
                  notchedShape: false,
                ),
              )),
            ],
          ),
          SizedBox(height: 18),
          _BottomAppBarPropTable(),
        ],
      ),
    );
  }
}

class _BottomBarCard extends StatelessWidget {
  const _BottomBarCard({required this.label, required this.child});
  final String label;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kInk.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  color: _kInk, fontSize: 13, fontWeight: FontWeight.w700)),
          SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _BottomBarMock extends StatelessWidget {
  const _BottomBarMock({
    required this.color,
    required this.iconColor,
    required this.fab,
    required this.fabLocation,
    required this.notchedShape,
  });
  final Color color;
  final Color iconColor;
  final Widget? fab;
  final FloatingActionButtonLocation fabLocation;
  final bool notchedShape;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Scaffold(
        backgroundColor: Color(0xFFF1ECF7),
        body: Padding(
          padding: EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 12,
                width: 110,
                decoration: BoxDecoration(
                  color: _kInk.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 8,
                width: 80,
                decoration: BoxDecoration(
                  color: _kInk.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: fab,
        floatingActionButtonLocation: fabLocation,
        bottomNavigationBar: BottomAppBar(
          color: color,
          height: 56,
          padding: EdgeInsets.symmetric(horizontal: 8),
          shape: notchedShape ? CircularNotchedRectangle() : null,
          notchMargin: 6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.menu, color: iconColor, size: 22),
                  SizedBox(width: 16),
                  Icon(Icons.search, color: iconColor, size: 22),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.favorite_border, color: iconColor, size: 22),
                  SizedBox(width: 16),
                  Icon(Icons.more_vert, color: iconColor, size: 22),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FabMock extends StatelessWidget {
  const _FabMock({required this.color, required this.icon});
  final Color color;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: null,
      backgroundColor: color,
      elevation: 0,
      child: Icon(icon, color: Colors.white),
    );
  }
}

class _BottomAppBarPropTable extends StatelessWidget {
  const _BottomAppBarPropTable();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("BottomAppBar properties at a glance",
              style: TextStyle(
                  color: _kInk, fontSize: 14, fontWeight: FontWeight.w800)),
          SizedBox(height: 10),
          _PropRow(name: "shape", value: "CircularNotchedRectangle() · AutomaticNotchedShape"),
          _PropRow(name: "notchMargin", value: "Spacing between FAB and bar"),
          _PropRow(name: "color", value: "Surface color of the bar"),
          _PropRow(name: "elevation", value: "Material elevation (Z)"),
          _PropRow(name: "padding", value: "EdgeInsetsGeometry around children"),
          _PropRow(name: "height", value: "Total bar height (default 80 in M3)"),
        ],
      ),
    );
  }
}

class _PropRow extends StatelessWidget {
  const _PropRow({required this.name, required this.value});
  final String name;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(name,
                style: TextStyle(
                    color: _kSuccess,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    fontFamily: "monospace")),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(color: _kInk, fontSize: 12.5, height: 1.4)),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SLIVER APP BAR SHOWCASE
// =====================================================================
class _SliverAppBarShowcaseSection extends StatelessWidget {
  const _SliverAppBarShowcaseSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 8, 32, 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_kPaper, Color(0xFFEEF2FB)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(
            kicker: "08 · SLIVER APP BAR",
            title: "SliverAppBar in three postures",
            subtitle:
                "SliverAppBar is the workhorse of scroll-aware headers. Below: pinned, floating-with-snap, and expanded states — all statically rendered.",
          ),
          SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _SliverCard(
                label: "Pinned · collapsed",
                blurb: "Stays at the top of the viewport while content scrolls.",
                child: _SliverPreview(expandedHeight: 64, kind: _SliverKind.pinnedCollapsed),
              )),
              SizedBox(width: 14),
              Expanded(child: _SliverCard(
                label: "Expanded · hero",
                blurb: "Initial scroll position shows the flexibleSpace at full height.",
                child: _SliverPreview(expandedHeight: 200, kind: _SliverKind.expanded),
              )),
              SizedBox(width: 14),
              Expanded(child: _SliverCard(
                label: "Floating · with TabBar bottom",
                blurb: "Floating reappears on upward scroll, with TabBar as bottom.",
                child: _SliverPreview(expandedHeight: 140, kind: _SliverKind.floatingTabs),
              )),
            ],
          ),
        ],
      ),
    );
  }
}

enum _SliverKind { pinnedCollapsed, expanded, floatingTabs }

class _SliverCard extends StatelessWidget {
  const _SliverCard({required this.label, required this.blurb, required this.child});
  final String label;
  final String blurb;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kInk.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  color: _kInk, fontSize: 13, fontWeight: FontWeight.w700)),
          SizedBox(height: 4),
          Text(blurb,
              style: TextStyle(color: _kInkMuted, fontSize: 11.5, height: 1.4)),
          SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _SliverPreview extends StatelessWidget {
  const _SliverPreview({required this.expandedHeight, required this.kind});
  final double expandedHeight;
  final _SliverKind kind;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF1ECF7),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kInk.withValues(alpha: 0.06)),
      ),
      height: 260,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9),
        child: CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: [
            _buildSliver(),
            SliverPadding(
              padding: EdgeInsets.all(12),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _ScrollListItem(idx: 1, color: _kAccent),
                  SizedBox(height: 8),
                  _ScrollListItem(idx: 2, color: _kAccent2),
                  SizedBox(height: 8),
                  _ScrollListItem(idx: 3, color: _kAccent3),
                  SizedBox(height: 8),
                  _ScrollListItem(idx: 4, color: _kAccent4),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliver() {
    switch (kind) {
      case _SliverKind.pinnedCollapsed:
        return SliverAppBar(
          pinned: true,
          backgroundColor: _kAccent,
          foregroundColor: Colors.white,
          title: Text("Pinned"),
          leading: Icon(Icons.menu),
          actions: [Icon(Icons.search), SizedBox(width: 14)],
        );
      case _SliverKind.expanded:
        return SliverAppBar(
          pinned: true,
          expandedHeight: 130,
          backgroundColor: _kAccent2,
          foregroundColor: Colors.white,
          leading: Icon(Icons.arrow_back),
          flexibleSpace: FlexibleSpaceBar(
            title: Text("Expanded", style: TextStyle(fontSize: 16)),
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [_kAccent2, Color(0xFF004D40)],
                ),
              ),
            ),
          ),
        );
      case _SliverKind.floatingTabs:
        return SliverAppBar(
          floating: true,
          backgroundColor: _kAccent3,
          foregroundColor: Colors.white,
          title: Text("Tabs"),
          leading: Icon(Icons.menu),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(36),
            child: SizedBox(
              height: 36,
              child: Row(
                children: [
                  SizedBox(width: 14),
                  _TabMock(label: "All", active: true),
                  _TabMock(label: "Unread", active: false),
                  _TabMock(label: "Mentions", active: false),
                  _TabMock(label: "Saved", active: false),
                ],
              ),
            ),
          ),
        );
    }
  }
}

class _TabMock extends StatelessWidget {
  const _TabMock({required this.label, required this.active});
  final String label;
  final bool active;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700)),
          SizedBox(height: 6),
          Container(
            width: 22,
            height: 2.5,
            color: active ? Colors.white : Colors.transparent,
          ),
        ],
      ),
    );
  }
}

class _ScrollListItem extends StatelessWidget {
  const _ScrollListItem({required this.idx, required this.color});
  final int idx;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kInk.withValues(alpha: 0.06)),
      ),
      child: Row(
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.16),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(idx.toString(),
                  style: TextStyle(
                      color: color, fontSize: 11, fontWeight: FontWeight.w800)),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Item " + idx.toString(),
                    style: TextStyle(
                        color: _kInk, fontSize: 12.5, fontWeight: FontWeight.w700)),
                SizedBox(height: 2),
                Text("Subtitle below the row",
                    style: TextStyle(color: _kInkMuted, fontSize: 11)),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: _kInkMuted, size: 16),
        ],
      ),
    );
  }
}

// =====================================================================
// TOOLBAR HEIGHT SECTION
// =====================================================================
class _ToolbarHeightSection extends StatelessWidget {
  const _ToolbarHeightSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 8, 32, 32),
      color: _kPaper,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(
            kicker: "09 · TOOLBAR HEIGHT",
            title: "Density and rhythm",
            subtitle:
                "Toolbar height is the most under-appreciated AppBar property. Below are four densities — pick deliberately and stay consistent across routes.",
          ),
          SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _HeightCard(label: "Compact · 44 dp", height: 44)),
              SizedBox(width: 14),
              Expanded(child: _HeightCard(label: "Default · 56 dp", height: 56)),
              SizedBox(width: 14),
              Expanded(child: _HeightCard(label: "Medium · 80 dp", height: 80)),
              SizedBox(width: 14),
              Expanded(child: _HeightCard(label: "Tall · 112 dp", height: 112)),
            ],
          ),
          SizedBox(height: 22),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.straighten, color: _kInfo),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Compact bars suit utility surfaces (search overlays, browsers). Tall bars belong to hero / settings / detail routes where context outweighs density.",
                    style: TextStyle(
                        color: _kInk, fontSize: 12.5, height: 1.45),
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

class _HeightCard extends StatelessWidget {
  const _HeightCard({required this.label, required this.height});
  final String label;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kInk.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  color: _kInk, fontSize: 13, fontWeight: FontWeight.w700)),
          SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 130,
              child: Column(
                children: [
                  SizedBox(
                    height: height,
                    child: AppBar(
                      backgroundColor: _kAccent,
                      foregroundColor: Colors.white,
                      toolbarHeight: height,
                      leading: Icon(Icons.menu),
                      title: Text(label.split(" · ").first,
                          style: TextStyle(fontSize: 14)),
                      actions: [Icon(Icons.search), SizedBox(width: 14)],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Color(0xFFF1ECF7),
                      child: Center(
                        child: Text(
                          height.toStringAsFixed(0) + " dp",
                          style: TextStyle(
                              color: _kInkMuted,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// ELEVATION COMPARISON
// =====================================================================
class _ElevationComparisonSection extends StatelessWidget {
  const _ElevationComparisonSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 8, 32, 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_kPaper, Color(0xFFF3EFFB)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(
            kicker: "10 · ELEVATION",
            title: "Elevation and scrolledUnder tint",
            subtitle:
                "Material 3 lets the AppBar adapt as content scrolls. Below: four discrete elevations and their visual personality.",
          ),
          SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _ElevationCard(label: "0 — flat", elevation: 0, tint: 0)),
              SizedBox(width: 14),
              Expanded(child: _ElevationCard(label: "1 — resting", elevation: 1, tint: 0.04)),
              SizedBox(width: 14),
              Expanded(child: _ElevationCard(label: "4 — scrolled", elevation: 4, tint: 0.10)),
              SizedBox(width: 14),
              Expanded(child: _ElevationCard(label: "12 — modal", elevation: 12, tint: 0.16)),
            ],
          ),
        ],
      ),
    );
  }
}

class _ElevationCard extends StatelessWidget {
  const _ElevationCard({
    required this.label,
    required this.elevation,
    required this.tint,
  });
  final String label;
  final double elevation;
  final double tint;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kInk.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  color: _kInk, fontSize: 13, fontWeight: FontWeight.w700)),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: _kInk.withValues(alpha: 0.05 * elevation.clamp(0, 12)),
                  blurRadius: 6 + elevation * 1.2,
                  offset: Offset(0, 2 + elevation * 0.4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 100,
                child: Column(
                  children: [
                    AppBar(
                      backgroundColor: Color.lerp(_kAccent, _kInk, tint) ?? _kAccent,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      title: Text("Surface", style: TextStyle(fontSize: 14)),
                      leading: Icon(Icons.menu),
                    ),
                    Expanded(
                      child: Container(
                        color: Color(0xFFF1ECF7),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Icon(Icons.layers, size: 14, color: _kInkMuted),
                            SizedBox(width: 6),
                            Text(
                              "z = " + elevation.toStringAsFixed(0),
                              style: TextStyle(
                                  color: _kInkMuted,
                                  fontSize: 11,
                                  fontFamily: "monospace"),
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
        ],
      ),
    );
  }
}

// =====================================================================
// ACCESSIBILITY SECTION
// =====================================================================
class _AccessibilitySection extends StatelessWidget {
  const _AccessibilitySection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 8, 32, 32),
      color: _kPaper,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(
            kicker: "11 · ACCESSIBILITY",
            title: "Accessible AppBars",
            subtitle:
                "Color contrast, tap target size, semantic labels for icon buttons, and reliable focus order make the chrome usable for everyone.",
          ),
          SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _A11yCard(
                icon: Icons.contrast,
                title: "Contrast",
                color: _kInfo,
                tips: [
                  "Title vs background must reach 4.5:1 (WCAG AA).",
                  "Icons against background should reach 3:1.",
                  "Test on real OLED and reflective screens.",
                ],
              )),
              SizedBox(width: 14),
              Expanded(child: _A11yCard(
                icon: Icons.touch_app,
                title: "Tap targets",
                color: _kSuccess,
                tips: [
                  "Min 48 x 48 dp per interactive icon.",
                  "Use IconButton (not bare Icon) for actions.",
                  "Avoid stacking targets within 8 dp of each other.",
                ],
              )),
              SizedBox(width: 14),
              Expanded(child: _A11yCard(
                icon: Icons.record_voice_over,
                title: "Semantics",
                color: _kAccent3,
                tips: [
                  "Provide tooltip / semantic label for every action.",
                  "Title is read first; subtitle becomes its hint.",
                  "Avoid duplicating leading and title meanings.",
                ],
              )),
              SizedBox(width: 14),
              Expanded(child: _A11yCard(
                icon: Icons.text_fields,
                title: "Type & scale",
                color: _kAccent4,
                tips: [
                  "Title size scales with the user's textScale factor.",
                  "Avoid hard-coded heights below 56 dp.",
                  "Allow titles to wrap two lines on tall AppBars.",
                ],
              )),
            ],
          ),
        ],
      ),
    );
  }
}

class _A11yCard extends StatelessWidget {
  const _A11yCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.tips,
  });
  final IconData icon;
  final String title;
  final Color color;
  final List<String> tips;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withValues(alpha: 0.10), color.withValues(alpha: 0.22)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 16),
          ),
          SizedBox(height: 12),
          Text(title,
              style: TextStyle(
                  color: _kInk, fontSize: 14, fontWeight: FontWeight.w800)),
          SizedBox(height: 8),
          for (final t in tips)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(t,
                        style: TextStyle(
                            color: _kInk, fontSize: 11.5, height: 1.45)),
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
// ANATOMY DIAGRAM
// =====================================================================
class _AnatomyDiagramSection extends StatelessWidget {
  const _AnatomyDiagramSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 8, 32, 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFEFE9F7), Color(0xFFFDFCFF)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(
            kicker: "12 · ANATOMY",
            title: "AppBar anatomy at a glance",
            subtitle:
                "Five slots make an AppBar: leading, title, actions, bottom, and flexibleSpace. Each carries a specific responsibility.",
          ),
          SizedBox(height: 22),
          Container(
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _kInk.withValues(alpha: 0.06)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: 130,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [_kAccent, Color(0xFF311B92)],
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 90,
                              child: Row(
                                children: [
                                  SizedBox(width: 12),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.18),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(Icons.arrow_back,
                                        color: Colors.white, size: 18),
                                  ),
                                  SizedBox(width: 14),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Project Atlas",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800)),
                                      Text("12 open tasks",
                                          style: TextStyle(
                                              color: Colors.white.withValues(alpha: 0.75),
                                              fontSize: 12)),
                                    ],
                                  ),
                                  Spacer(),
                                  Icon(Icons.search, color: Colors.white),
                                  SizedBox(width: 14),
                                  Icon(Icons.more_vert, color: Colors.white),
                                  SizedBox(width: 14),
                                ],
                              ),
                            ),
                            Container(
                              height: 40,
                              padding: EdgeInsets.symmetric(horizontal: 14),
                              child: Row(
                                children: [
                                  _TabMock(label: "Overview", active: true),
                                  _TabMock(label: "Tasks", active: false),
                                  _TabMock(label: "Activity", active: false),
                                  _TabMock(label: "Files", active: false),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _AnatomyTag(color: _kAccent, label: "leading", note: "Icon · BackButton · DrawerButton"),
                    _AnatomyTag(color: _kAccent2, label: "title", note: "Text · widget · Row"),
                    _AnatomyTag(color: _kAccent3, label: "actions", note: "List<Widget>"),
                    _AnatomyTag(color: _kAccent4, label: "bottom", note: "PreferredSizeWidget (e.g. TabBar)"),
                    _AnatomyTag(color: _kInfo, label: "flexibleSpace", note: "Background canvas"),
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

class _AnatomyTag extends StatelessWidget {
  const _AnatomyTag({required this.color, required this.label, required this.note});
  final Color color;
  final String label;
  final String note;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.30)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 8),
          Text(label,
              style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  fontFamily: "monospace")),
          SizedBox(width: 8),
          Text(note,
              style: TextStyle(
                  color: _kInkMuted, fontSize: 11.5, height: 1.3)),
        ],
      ),
    );
  }
}

// =====================================================================
// FOOTER SECTION
// =====================================================================
class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 30, 32, 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0E1430), Color(0xFF2C2256)],
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
                Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [_kAccent, _kAccent3],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.auto_awesome,
                          color: Colors.white, size: 16),
                    ),
                    SizedBox(width: 10),
                    Text("Mobile App Navigation Deck",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w800)),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "End of catalog. Use these patterns as a reference; remix freely.",
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 13,
                      height: 1.5),
                ),
              ],
            ),
          ),
          SizedBox(width: 24),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sections",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.4)),
                SizedBox(height: 10),
                _FooterLink(label: "Hero & intro"),
                _FooterLink(label: "Variant gallery"),
                _FooterLink(label: "Action slots"),
                _FooterLink(label: "Title styling"),
                _FooterLink(label: "Leading patterns"),
                _FooterLink(label: "flexibleSpace gallery"),
                _FooterLink(label: "BottomAppBar showcase"),
                _FooterLink(label: "SliverAppBar"),
                _FooterLink(label: "Toolbar height"),
                _FooterLink(label: "Elevation"),
                _FooterLink(label: "Accessibility"),
                _FooterLink(label: "Anatomy"),
              ],
            ),
          ),
          SizedBox(width: 24),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Reference",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.4)),
                SizedBox(height: 10),
                _FooterLink(label: "AppBar API"),
                _FooterLink(label: "SliverAppBar API"),
                _FooterLink(label: "BottomAppBar API"),
                _FooterLink(label: "Material 3 guidance"),
                _FooterLink(label: "Accessibility checklist"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.arrow_outward,
              color: Colors.white.withValues(alpha: 0.55), size: 12),
          SizedBox(width: 6),
          Text(label,
              style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 12.5,
                  height: 1.4)),
        ],
      ),
    );
  }
}

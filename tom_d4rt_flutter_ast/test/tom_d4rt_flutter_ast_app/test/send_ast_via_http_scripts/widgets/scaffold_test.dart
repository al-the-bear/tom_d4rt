// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, unused_element_parameter, unused_field, unnecessary_import

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

import "dart:math" as math;

// ---------------------------------------------------------------------------
// SCAFFOLD VISUAL DEEP DEMO
// ---------------------------------------------------------------------------
// A hand-authored, single-screen catalog that explores the Material Scaffold
// widget. Scaffold is the structural backbone of nearly every Material screen,
// hosting an AppBar, body, drawer, end drawer, bottom navigation, bottom
// sheet, persistent footer buttons, floating action button, and the global
// ScaffoldMessenger for snack bars. Because nesting many real Scaffolds in a
// scrollable inevitably collides with Hero, MediaQuery, and Material
// inheritance, this demo composes most regions with Container / Column / Row
// arrangements that VISUALLY mimic each slot, and embeds a real Scaffold only
// where it is safe (small fixed-size mounted islands).
// ---------------------------------------------------------------------------

const Color _kInk = Color(0xFF0E1430);
const Color _kInkSoft = Color(0xFF2A3358);
const Color _kInkMuted = Color(0xFF5F6A95);
const Color _kInkFaint = Color(0xFFB7BED5);
const Color _kPaper = Color(0xFFF6F7FB);
const Color _kPaperWarm = Color(0xFFFDF8F1);
const Color _kPaperCool = Color(0xFFEEF3FA);
const Color _kCard = Color(0xFFFFFFFF);
const Color _kBorder = Color(0xFFE2E6F0);
const Color _kBorderStrong = Color(0xFFCFD5E4);
const Color _kAccent = Color(0xFF6750A4);
const Color _kAccent2 = Color(0xFF00897B);
const Color _kAccent3 = Color(0xFFE91E63);
const Color _kAccent4 = Color(0xFFFB8C00);
const Color _kAccent5 = Color(0xFF3949AB);
const Color _kAccent6 = Color(0xFF00838F);
const Color _kSuccess = Color(0xFF2E7D32);
const Color _kDanger = Color(0xFFC62828);
const Color _kWarn = Color(0xFFEF6C00);
const Color _kInfo = Color(0xFF1565C0);

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Scaffold Visual Deep Demo",
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
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              _PageHero(),
              _Section1Dossier(),
              _Section2Anatomy(),
              _Section3LoginRecipe(),
              _Section4DashboardRecipe(),
              _Section5ChatRecipe(),
              _Section6SettingsRecipe(),
              _Section7FabLocations(),
              _Section8Comparison(),
              _Section9Glossary(),
              _Section10Recap(),
              _PageFoot(),
            ],
          ),
        ),
      ),
    ),
  );
}

// ===========================================================================
// SHARED PRIMITIVES
// ===========================================================================

class _SectionShell extends StatelessWidget {
  const _SectionShell({
    required this.label,
    required this.title,
    required this.subtitle,
    required this.tone,
    required this.children,
  });

  final String label;
  final String title;
  final String subtitle;
  final Color tone;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 28),
      decoration: BoxDecoration(
        color: _kPaper,
        border: Border(
          bottom: BorderSide(color: _kBorder, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 10,
                height: 36,
                decoration: BoxDecoration(
                  color: tone,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: tone.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: tone.withOpacity(0.30)),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    color: tone,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: _kInk,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              color: _kInkMuted,
              fontSize: 13.5,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18),
          ...children,
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(0.32)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _Caption extends StatelessWidget {
  const _Caption({required this.text, this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? _kInkMuted,
        fontSize: 11.5,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    );
  }
}

class _SlotLabel extends StatelessWidget {
  const _SlotLabel({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

// ===========================================================================
// HERO + FOOT
// ===========================================================================

class _PageHero extends StatelessWidget {
  const _PageHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(28, 40, 28, 36),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF1A1F44),
            Color(0xFF35306E),
            Color(0xFF6750A4),
          ],
        ),
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
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.32)),
                ),
                child: const Icon(Icons.view_quilt_outlined,
                    color: Colors.white, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      "Material Scaffold",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.6,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "The structural backbone of every Material screen.",
                      style: TextStyle(
                        color: Color(0xFFE6E3F4),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const <Widget>[
              _HeroChip(text: "appBar"),
              _HeroChip(text: "body"),
              _HeroChip(text: "drawer"),
              _HeroChip(text: "endDrawer"),
              _HeroChip(text: "bottomNavigationBar"),
              _HeroChip(text: "bottomSheet"),
              _HeroChip(text: "floatingActionButton"),
              _HeroChip(text: "persistentFooterButtons"),
              _HeroChip(text: "ScaffoldMessenger"),
            ],
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.18)),
            ),
            child: const Text(
              "Scaffold orchestrates fixed regions around a scrollable body. "
              "It exposes a global ScaffoldMessenger for snack bars, manages "
              "drawer edge gestures, docks the FAB into the bottom bar, and "
              "supplies a Material surface ancestor so Ink-based widgets paint "
              "correctly. This catalogue tours every slot in turn.",
              style: TextStyle(
                color: Color(0xFFDDD9EE),
                fontSize: 13,
                height: 1.55,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.30)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
          fontFamily: "monospace",
        ),
      ),
    );
  }
}

class _PageFoot extends StatelessWidget {
  const _PageFoot();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
      decoration: const BoxDecoration(color: _kInk),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.flag_outlined,
                  color: _kInkFaint, size: 18),
              const SizedBox(width: 8),
              const Text(
                "End of Scaffold deep demo",
                style: TextStyle(
                  color: _kInkFaint,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "10 sections / 9 slots / many recipes",
            style: TextStyle(
              color: Color(0xFF9DA4C2),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 1 — DOSSIER
// ===========================================================================

class _Section1Dossier extends StatelessWidget {
  const _Section1Dossier();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      label: "SECTION 01 — DOSSIER",
      title: "What problem does Scaffold solve?",
      subtitle:
          "Before Scaffold, every Material screen had to manually wire an "
          "AppBar, body, and bottom bar with consistent insets and overlay "
          "behaviour. Scaffold standardizes that arrangement, supplies the "
          "ScaffoldMessenger inheritance point for snack bars, and manages "
          "drawer / FAB animations.",
      tone: _kAccent,
      children: const <Widget>[
        _DossierRow(
          slot: "appBar",
          purpose:
              "Top fixed bar holding title, leading, actions, and a "
              "PreferredSize so Scaffold can reserve vertical space.",
          tone: _kAccent5,
        ),
        _DossierRow(
          slot: "body",
          purpose:
              "Primary scrollable region. Receives MediaQuery padding minus "
              "the AppBar and bottom bar heights.",
          tone: _kAccent2,
        ),
        _DossierRow(
          slot: "floatingActionButton",
          purpose:
              "Pinned action button positioned by FloatingActionButtonLocation. "
              "Can dock into a BottomAppBar notch.",
          tone: _kAccent3,
        ),
        _DossierRow(
          slot: "drawer",
          purpose:
              "Edge-swipe panel from the leading edge. Hosts navigation "
              "destinations or context filters.",
          tone: _kAccent4,
        ),
        _DossierRow(
          slot: "endDrawer",
          purpose:
              "Symmetric drawer from the trailing edge. Often used for "
              "filters, details, or secondary destinations.",
          tone: _kAccent6,
        ),
        _DossierRow(
          slot: "bottomNavigationBar",
          purpose:
              "Fixed bottom bar reserved for top-level destinations. The "
              "Scaffold subtracts its height from the body region.",
          tone: _kAccent5,
        ),
        _DossierRow(
          slot: "bottomSheet",
          purpose:
              "Persistent surface above the bottomNavigationBar — great for "
              "now-playing controls, in-progress flows, contextual tools.",
          tone: _kAccent3,
        ),
        _DossierRow(
          slot: "persistentFooterButtons",
          purpose:
              "A row of buttons mounted ABOVE the bottomNavigationBar. Use "
              "for global commit/cancel actions on long forms.",
          tone: _kWarn,
        ),
        _DossierRow(
          slot: "ScaffoldMessenger",
          purpose:
              "Inherited widget that owns the snack bar queue. Persists "
              "snack bars across route changes when scoped above MaterialApp.",
          tone: _kSuccess,
        ),
      ],
    );
  }
}

class _DossierRow extends StatelessWidget {
  const _DossierRow({
    required this.slot,
    required this.purpose,
    required this.tone,
  });

  final String slot;
  final String purpose;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 100,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: tone.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: tone.withOpacity(0.35)),
            ),
            child: Text(
              slot,
              style: TextStyle(
                color: tone,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                fontFamily: "monospace",
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              purpose,
              style: const TextStyle(
                color: _kInkSoft,
                fontSize: 12.5,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 2 — ANATOMY
// ===========================================================================

class _Section2Anatomy extends StatelessWidget {
  const _Section2Anatomy();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      label: "SECTION 02 — ANATOMY",
      title: "All named regions, on one diagram",
      subtitle:
          "Every Scaffold slot rendered as a labelled rectangle. The body is "
          "the only flexible region; everything else has a fixed height "
          "negotiated through PreferredSize or BottomSheet metrics.",
      tone: _kAccent2,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _kBorder),
          ),
          child: Column(
            children: <Widget>[
              _anatomyBar(
                  "appBar (PreferredSize 56dp)", _kAccent5, 38),
              _anatomyGap(),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: _anatomyBlock(
                      "drawer\n(edge swipe)",
                      _kAccent4,
                      164,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: <Widget>[
                        _anatomyBlock("body (flex)", _kAccent2, 110),
                        const SizedBox(height: 6),
                        _anatomyBar("bottomSheet", _kAccent3, 28),
                        const SizedBox(height: 6),
                        _anatomyBar(
                            "persistentFooterButtons", _kWarn, 22),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    flex: 2,
                    child: _anatomyBlock(
                      "endDrawer\n(edge swipe)",
                      _kAccent6,
                      164,
                    ),
                  ),
                ],
              ),
              _anatomyGap(),
              _anatomyBar(
                  "bottomNavigationBar (56dp)", _kAccent5, 30),
              _anatomyGap(),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.centerRight,
                children: <Widget>[
                  _anatomyBar(
                      "floatingActionButton (centerFloat / endDocked …)",
                      _kAccent3,
                      18),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        _AnatomyLegend(),
      ],
    );
  }

  Widget _anatomyBar(String label, Color tone, double h) {
    return Container(
      width: double.infinity,
      height: h,
      decoration: BoxDecoration(
        color: tone.withOpacity(0.16),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withOpacity(0.45)),
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        label,
        style: TextStyle(
          color: tone,
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.4,
        ),
      ),
    );
  }

  Widget _anatomyBlock(String label, Color tone, double h) {
    return Container(
      height: h,
      decoration: BoxDecoration(
        color: tone.withOpacity(0.14),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withOpacity(0.40)),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: tone,
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.4,
        ),
      ),
    );
  }

  Widget _anatomyGap() => const SizedBox(height: 6);
}

class _AnatomyLegend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: const <Widget>[
        _Pill(text: "appBar", color: _kAccent5),
        _Pill(text: "drawer", color: _kAccent4),
        _Pill(text: "body", color: _kAccent2),
        _Pill(text: "endDrawer", color: _kAccent6),
        _Pill(text: "bottomSheet", color: _kAccent3),
        _Pill(text: "persistentFooterButtons", color: _kWarn),
        _Pill(text: "bottomNavigationBar", color: _kAccent5),
        _Pill(text: "floatingActionButton", color: _kAccent3),
      ],
    );
  }
}

// ===========================================================================
// SECTION 3 — LOGIN RECIPE
// ===========================================================================

class _Section3LoginRecipe extends StatelessWidget {
  const _Section3LoginRecipe();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      label: "SECTION 03 — RECIPE: LOGIN",
      title: "Auth screen with appBar + body form + primaryAction",
      subtitle:
          "A login Scaffold typically renders a slim AppBar, a centred form, "
          "and a primary action floating just above the keyboard. Persistent "
          "footer buttons can host \"Forgot password\" / \"Create account\".",
      tone: _kAccent3,
      children: <Widget>[
        Container(
          height: 460,
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _kBorder),
          ),
          clipBehavior: Clip.antiAlias,
          child: const Scaffold(
            backgroundColor: _kPaperWarm,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(48),
              child: _MockAppBar(
                title: "Sign in",
                bg: _kAccent3,
                leading: Icons.arrow_back_rounded,
              ),
            ),
            body: _LoginBody(),
            persistentFooterButtons: <Widget>[
              _GhostButton(text: "Forgot?", tone: _kAccent3),
              _GhostButton(text: "Sign up", tone: _kAccent5),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const _Caption(
          text:
              "PERSISTENT FOOTER BUTTONS pin a button row ABOVE any bottom "
              "navigation bar, but never below the keyboard.",
        ),
      ],
    );
  }
}

class _MockAppBar extends StatelessWidget {
  const _MockAppBar({
    required this.title,
    required this.bg,
    this.leading,
    this.actions = const <IconData>[],
  });

  final String title;
  final Color bg;
  final IconData? leading;
  final List<IconData> actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bg,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: <Widget>[
          if (leading != null)
            IconButton(
              onPressed: null,
              icon: Icon(leading, color: Colors.white),
            ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          for (final IconData a in actions)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Icon(a, color: Colors.white, size: 20),
            ),
        ],
      ),
    );
  }
}

class _LoginBody extends StatelessWidget {
  const _LoginBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          _LoginLogo(),
          SizedBox(height: 22),
          _MockField(label: "Email", hint: "you@example.com"),
          SizedBox(height: 12),
          _MockField(label: "Password", hint: "•••••••••", obscure: true),
          SizedBox(height: 22),
          _SolidButton(text: "Sign in", tone: _kAccent3),
          SizedBox(height: 12),
          _OutlineButton(text: "Continue with Passkey"),
          SizedBox(height: 18),
          Center(
            child: Text(
              "By signing in you accept the Terms of Service.",
              style: TextStyle(color: _kInkMuted, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginLogo extends StatelessWidget {
  const _LoginLogo();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: _kAccent3.withOpacity(0.12),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _kAccent3.withOpacity(0.35)),
        ),
        child: const Icon(Icons.lock_outline_rounded,
            color: _kAccent3, size: 32),
      ),
    );
  }
}

class _MockField extends StatelessWidget {
  const _MockField({
    required this.label,
    required this.hint,
    this.obscure = false,
  });

  final String label;
  final String hint;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            color: _kInkSoft,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kBorderStrong),
          ),
          child: Text(
            obscure ? "•••••••••" : hint,
            style: const TextStyle(
              color: _kInkMuted,
              fontSize: 13,
              fontFamily: "monospace",
            ),
          ),
        ),
      ],
    );
  }
}

class _SolidButton extends StatelessWidget {
  const _SolidButton({required this.text, required this.tone});
  final String text;
  final Color tone;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: tone,
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: tone.withOpacity(0.30),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13.5,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  const _OutlineButton({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kBorderStrong),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: _kInkSoft,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _GhostButton extends StatelessWidget {
  const _GhostButton({required this.text, required this.tone});
  final String text;
  final Color tone;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: tone.withOpacity(0.10),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withOpacity(0.35)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: tone,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

// ===========================================================================
// SECTION 4 — DASHBOARD RECIPE
// ===========================================================================

class _Section4DashboardRecipe extends StatelessWidget {
  const _Section4DashboardRecipe();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      label: "SECTION 04 — RECIPE: DASHBOARD",
      title: "appBar + drawer + body + bottomNavigationBar",
      subtitle:
          "The classic Material navigation pattern. The Scaffold wires the "
          "drawer scrim, locks the bottom bar to the safe area, and exposes "
          "the FAB at endDocked so it sits inside a notched bottom app bar.",
      tone: _kAccent4,
      children: <Widget>[
        Container(
          height: 520,
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _kBorder),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  const _MockAppBar(
                    title: "Workspace",
                    bg: _kAccent4,
                    leading: Icons.menu_rounded,
                    actions: <IconData>[
                      Icons.search_rounded,
                      Icons.notifications_none_rounded,
                      Icons.account_circle_outlined,
                    ],
                  ),
                  Expanded(child: _DashboardBody()),
                  const _MockBottomNav(
                    items: <_BNavItem>[
                      _BNavItem(icon: Icons.home_rounded, label: "Home"),
                      _BNavItem(icon: Icons.layers_rounded, label: "Projects"),
                      _BNavItem(
                          icon: Icons.bar_chart_rounded, label: "Reports"),
                      _BNavItem(icon: Icons.person_outline, label: "Me"),
                    ],
                    selected: 0,
                    tone: _kAccent4,
                  ),
                ],
              ),
              const Positioned(
                left: 0,
                top: 48,
                bottom: 56,
                child: _MockDrawer(),
              ),
              Positioned(
                right: 18,
                bottom: 70,
                child: _MockFab(tone: _kAccent4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Wrap(spacing: 8, runSpacing: 8, children: const <Widget>[
          _Pill(text: "Scaffold.drawer", color: _kAccent4),
          _Pill(text: "Scaffold.bottomNavigationBar", color: _kAccent5),
          _Pill(text: "Scaffold.floatingActionButton", color: _kAccent3),
        ]),
      ],
    );
  }
}

class _DashboardBody extends StatelessWidget {
  const _DashboardBody();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kPaperCool,
      padding: const EdgeInsets.fromLTRB(96, 14, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: _DashCard(
                  title: "Active",
                  value: "12",
                  tone: _kAccent4,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _DashCard(
                  title: "Pending",
                  value: "3",
                  tone: _kWarn,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _DashCard(
                  title: "Closed",
                  value: "48",
                  tone: _kSuccess,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _kBorder),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const <Widget>[
                  Text(
                    "Recent activity",
                    style: TextStyle(
                      color: _kInk,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 8),
                  _ActivityRow(
                      icon: Icons.task_alt,
                      text: "QA-128 closed by Maria",
                      tone: _kSuccess),
                  _ActivityRow(
                      icon: Icons.hourglass_bottom,
                      text: "QA-129 waiting on review",
                      tone: _kWarn),
                  _ActivityRow(
                      icon: Icons.flag_outlined,
                      text: "QA-130 blocked",
                      tone: _kDanger),
                  _ActivityRow(
                      icon: Icons.edit_note,
                      text: "QA-131 drafted by Otto",
                      tone: _kInfo),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashCard extends StatelessWidget {
  const _DashCard({
    required this.title,
    required this.value,
    required this.tone,
  });
  final String title;
  final String value;
  final Color tone;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: _kInkMuted,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: tone,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  const _ActivityRow({
    required this.icon,
    required this.text,
    required this.tone,
  });
  final IconData icon;
  final String text;
  final Color tone;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tone.withOpacity(0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, color: tone, size: 14),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: _kInkSoft,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MockDrawer extends StatelessWidget {
  const _MockDrawer();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84,
      decoration: BoxDecoration(
        color: _kCard,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 12,
            offset: const Offset(3, 0),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _kAccent4.withOpacity(0.16),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.workspaces_outline,
                color: _kAccent4, size: 22),
          ),
          const SizedBox(height: 18),
          _DrawerTile(icon: Icons.home_rounded, label: "Home", selected: true),
          _DrawerTile(icon: Icons.folder_outlined, label: "Files"),
          _DrawerTile(icon: Icons.timeline_rounded, label: "Trend"),
          _DrawerTile(icon: Icons.bolt_outlined, label: "Flows"),
          _DrawerTile(icon: Icons.settings_outlined, label: "Setup"),
        ],
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({
    required this.icon,
    required this.label,
    this.selected = false,
  });
  final IconData icon;
  final String label;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: selected
            ? _kAccent4.withOpacity(0.12)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          Icon(icon,
              color: selected ? _kAccent4 : _kInkMuted, size: 18),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: selected ? _kAccent4 : _kInkMuted,
              fontSize: 9,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _BNavItem {
  const _BNavItem({required this.icon, required this.label});
  final IconData icon;
  final String label;
}

class _MockBottomNav extends StatelessWidget {
  const _MockBottomNav({
    required this.items,
    required this.selected,
    required this.tone,
  });
  final List<_BNavItem> items;
  final int selected;
  final Color tone;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: _kCard,
        border: Border(
          top: BorderSide(color: _kBorder),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          for (int i = 0; i < items.length; i++)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    items[i].icon,
                    color: i == selected ? tone : _kInkMuted,
                    size: 20,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    items[i].label,
                    style: TextStyle(
                      color: i == selected ? tone : _kInkMuted,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
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

class _MockFab extends StatelessWidget {
  const _MockFab({required this.tone, this.icon = Icons.add_rounded});
  final Color tone;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: tone,
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: tone.withOpacity(0.40),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }
}

// ===========================================================================
// SECTION 5 — CHAT RECIPE
// ===========================================================================

class _Section5ChatRecipe extends StatelessWidget {
  const _Section5ChatRecipe();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      label: "SECTION 05 — RECIPE: CHAT",
      title: "appBar + body + bottomSheet input bar",
      subtitle:
          "Chat layouts often pin the compose bar to the bottom via "
          "Scaffold.bottomSheet. Because it lives outside the body, the "
          "scrollable above resizes safely above the keyboard.",
      tone: _kAccent6,
      children: <Widget>[
        Container(
          height: 540,
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _kBorder),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: const <Widget>[
              _MockAppBar(
                title: "Maria — online",
                bg: _kAccent6,
                leading: Icons.arrow_back_rounded,
                actions: <IconData>[
                  Icons.videocam_outlined,
                  Icons.call_outlined,
                  Icons.more_vert_rounded,
                ],
              ),
              Expanded(child: _ChatBody()),
              _ChatComposer(),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const _Caption(
          text:
              "BottomSheet vs bottomNavigationBar: a bottomSheet is "
              "contextual and animates in/out, the nav bar is always there.",
        ),
      ],
    );
  }
}

class _ChatBody extends StatelessWidget {
  const _ChatBody();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kPaperCool,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _ChatBubble(
              text: "Hey! Did you finish the Scaffold demo?",
              mine: false,
              tone: _kAccent6),
          _ChatBubble(
              text: "Almost — ten sections to go.",
              mine: true,
              tone: _kAccent),
          _ChatBubble(
              text:
                  "Don't forget the persistentFooterButtons recipe — easy "
                  "to miss it.",
              mine: false,
              tone: _kAccent6),
          _ChatBubble(
              text: "Already drafted. Pushing soon.",
              mine: true,
              tone: _kAccent),
          _ChatBubble(
              text: "Beautiful. Talk later!",
              mine: false,
              tone: _kAccent6),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({
    required this.text,
    required this.mine,
    required this.tone,
  });
  final String text;
  final bool mine;
  final Color tone;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        constraints: const BoxConstraints(maxWidth: 240),
        decoration: BoxDecoration(
          color: mine ? tone : _kCard,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(14),
            topRight: const Radius.circular(14),
            bottomLeft: Radius.circular(mine ? 14 : 2),
            bottomRight: Radius.circular(mine ? 2 : 14),
          ),
          border: Border.all(
            color: mine ? tone : _kBorder,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: mine ? Colors.white : _kInkSoft,
            fontSize: 12.5,
            height: 1.35,
          ),
        ),
      ),
    );
  }
}

class _ChatComposer extends StatelessWidget {
  const _ChatComposer();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: _kCard,
        border: Border(top: BorderSide(color: _kBorder)),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.attach_file_rounded,
              color: _kInkMuted, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: _kPaperCool,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: _kBorder),
              ),
              child: const Text(
                "Type a message…",
                style: TextStyle(color: _kInkMuted, fontSize: 12),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: _kAccent6,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.send_rounded,
                color: Colors.white, size: 18),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 6 — SETTINGS RECIPE
// ===========================================================================

class _Section6SettingsRecipe extends StatelessWidget {
  const _Section6SettingsRecipe();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      label: "SECTION 06 — RECIPE: SETTINGS",
      title: "appBar + ListView body",
      subtitle:
          "Settings pages keep it simple: an AppBar and a ListView body. No "
          "FAB, no bottom bar — just clean, well-grouped rows. The Scaffold "
          "still adds Material elevation under each ink-based tile.",
      tone: _kAccent5,
      children: <Widget>[
        Container(
          height: 520,
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _kBorder),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: const <Widget>[
              _MockAppBar(
                title: "Settings",
                bg: _kAccent5,
                leading: Icons.arrow_back_rounded,
                actions: <IconData>[Icons.search_rounded],
              ),
              Expanded(child: _SettingsList()),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingsList extends StatelessWidget {
  const _SettingsList();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kPaper,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: const <Widget>[
          _SectionLabel(text: "ACCOUNT"),
          _SettingsRow(
              icon: Icons.person_outline,
              title: "Profile",
              subtitle: "Name, email, photo",
              tone: _kAccent5),
          _SettingsRow(
              icon: Icons.lock_outline,
              title: "Security",
              subtitle: "Password, passkeys, 2FA",
              tone: _kAccent4),
          _SettingsRow(
              icon: Icons.devices_other_outlined,
              title: "Devices",
              subtitle: "3 active sessions",
              tone: _kAccent2),
          _SectionLabel(text: "PREFERENCES"),
          _SettingsRow(
              icon: Icons.palette_outlined,
              title: "Appearance",
              subtitle: "Light · Dark · System",
              tone: _kAccent3),
          _SettingsRow(
              icon: Icons.language_outlined,
              title: "Language",
              subtitle: "English (US)",
              tone: _kAccent6),
          _SettingsRow(
              icon: Icons.notifications_none_rounded,
              title: "Notifications",
              subtitle: "On for mentions",
              tone: _kWarn),
          _SectionLabel(text: "ABOUT"),
          _SettingsRow(
              icon: Icons.info_outline,
              title: "About this app",
              subtitle: "Version 4.2.0",
              tone: _kInkMuted),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 6),
      child: Text(
        text,
        style: const TextStyle(
          color: _kInkMuted,
          fontSize: 10.5,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.tone,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final Color tone;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tone.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: tone, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: _kInk,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: _kInkMuted,
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded,
              color: _kInkFaint, size: 18),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 7 — FAB LOCATIONS
// ===========================================================================

class _Section7FabLocations extends StatelessWidget {
  const _Section7FabLocations();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      label: "SECTION 07 — FAB LOCATIONS",
      title: "FloatingActionButtonLocation variants",
      subtitle:
          "FloatingActionButtonLocation determines where the FAB sits. The "
          "Scaffold also offers \"docked\" variants that integrate with a "
          "BottomAppBar notch. Static thumbnails below.",
      tone: _kAccent3,
      children: <Widget>[
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: <Widget>[
            _FabThumb(
                title: "startFloat", align: Alignment.bottomLeft, docked: false),
            _FabThumb(
                title: "centerFloat",
                align: Alignment.bottomCenter,
                docked: false),
            _FabThumb(
                title: "endFloat", align: Alignment.bottomRight, docked: false),
            _FabThumb(
                title: "startDocked", align: Alignment.bottomLeft, docked: true),
            _FabThumb(
                title: "centerDocked",
                align: Alignment.bottomCenter,
                docked: true),
            _FabThumb(
                title: "endDocked", align: Alignment.bottomRight, docked: true),
            _FabThumb(
                title: "miniStartTop",
                align: Alignment.topLeft,
                docked: false,
                mini: true),
            _FabThumb(
                title: "endTop",
                align: Alignment.topRight,
                docked: false),
          ],
        ),
        const SizedBox(height: 14),
        const _Caption(
          text:
              "Docked locations align the FAB vertical centre with the top "
              "edge of a BottomAppBar — use a notched shape on the bar to "
              "make room.",
        ),
      ],
    );
  }
}

class _FabThumb extends StatelessWidget {
  const _FabThumb({
    required this.title,
    required this.align,
    required this.docked,
    this.mini = false,
  });
  final String title;
  final Alignment align;
  final bool docked;
  final bool mini;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 130,
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[
          Container(
            height: 20,
            color: _kAccent3.withOpacity(0.18),
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(
                color: _kAccent3,
                fontSize: 10,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(color: _kPaperCool),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 22,
                    decoration: BoxDecoration(
                      color: _kInkSoft,
                      borderRadius:
                          docked ? BorderRadius.zero : BorderRadius.zero,
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "bottomNavigationBar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: align,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      8,
                      8,
                      8,
                      docked ? 12 : 28,
                    ),
                    child: Container(
                      width: mini ? 22 : 28,
                      height: mini ? 22 : 28,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _kAccent3,
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: _kAccent3.withOpacity(0.45),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.add_rounded,
                          color: Colors.white, size: 14),
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

// ===========================================================================
// SECTION 8 — COMPARISON
// ===========================================================================

class _Section8Comparison extends StatelessWidget {
  const _Section8Comparison();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      label: "SECTION 08 — COMPARISON",
      title: "Scaffold vs CupertinoPageScaffold vs raw Material",
      subtitle:
          "Each app shell has different commitments. Scaffold integrates the "
          "Material system fully. CupertinoPageScaffold matches iOS chrome. "
          "A raw Material widget gives you full control with no chrome.",
      tone: _kInfo,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _CompareCard.scaffold()),
            const SizedBox(width: 10),
            Expanded(child: _CompareCard.cupertino()),
            const SizedBox(width: 10),
            Expanded(child: _CompareCard.raw()),
          ],
        ),
        const SizedBox(height: 14),
        _CompareTable(),
      ],
    );
  }
}

class _CompareCard extends StatelessWidget {
  const _CompareCard({
    required this.title,
    required this.tone,
    required this.summary,
    required this.icon,
  });

  factory _CompareCard.scaffold() => const _CompareCard(
        title: "Scaffold",
        tone: _kAccent,
        icon: Icons.view_quilt_outlined,
        summary:
            "Full Material orchestration. AppBar, drawers, FAB, snack bars, "
            "bottom bar, persistent footer — all wired in.",
      );

  factory _CompareCard.cupertino() => const _CompareCard(
        title: "CupertinoPageScaffold",
        tone: _kAccent5,
        icon: Icons.phone_iphone_rounded,
        summary:
            "iOS-style nav bar at the top, edge swipe back gestures. No "
            "drawer / FAB concepts; bottom controls come from "
            "CupertinoTabScaffold instead.",
      );

  factory _CompareCard.raw() => const _CompareCard(
        title: "Raw Material",
        tone: _kInkSoft,
        icon: Icons.crop_square_rounded,
        summary:
            "A bare Material surface. Use when you want a fully custom shell "
            "but still need ink wells and ancestor Material to paint splash "
            "effects.",
      );

  final String title;
  final Color tone;
  final IconData icon;
  final String summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: tone.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: tone, size: 16),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: tone,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            summary,
            style: const TextStyle(
              color: _kInkSoft,
              fontSize: 11.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _CompareTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        children: const <Widget>[
          _CompareHeaderRow(),
          _CompareRow(
              feature: "AppBar slot",
              scaffold: "yes",
              cupertino: "navigationBar",
              raw: "diy"),
          _CompareRow(
              feature: "Drawer",
              scaffold: "yes",
              cupertino: "no",
              raw: "diy"),
          _CompareRow(
              feature: "FAB",
              scaffold: "yes",
              cupertino: "no",
              raw: "diy"),
          _CompareRow(
              feature: "BottomNav",
              scaffold: "yes",
              cupertino: "via TabScaffold",
              raw: "diy"),
          _CompareRow(
              feature: "SnackBar",
              scaffold: "ScaffoldMessenger",
              cupertino: "diy",
              raw: "diy"),
          _CompareRow(
              feature: "Edge swipe back",
              scaffold: "no",
              cupertino: "yes",
              raw: "no"),
          _CompareRow(
              feature: "Material ink",
              scaffold: "yes",
              cupertino: "limited",
              raw: "yes"),
        ],
      ),
    );
  }
}

class _CompareHeaderRow extends StatelessWidget {
  const _CompareHeaderRow();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: _kPaperCool,
        border: Border(bottom: BorderSide(color: _kBorder)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: const <Widget>[
          Expanded(
              flex: 3,
              child: Text("Feature",
                  style: TextStyle(
                      color: _kInk,
                      fontSize: 11,
                      fontWeight: FontWeight.w800))),
          Expanded(
              flex: 2,
              child: Text("Scaffold",
                  style: TextStyle(
                      color: _kAccent,
                      fontSize: 11,
                      fontWeight: FontWeight.w800))),
          Expanded(
              flex: 3,
              child: Text("Cupertino",
                  style: TextStyle(
                      color: _kAccent5,
                      fontSize: 11,
                      fontWeight: FontWeight.w800))),
          Expanded(
              flex: 2,
              child: Text("Raw Material",
                  style: TextStyle(
                      color: _kInkSoft,
                      fontSize: 11,
                      fontWeight: FontWeight.w800))),
        ],
      ),
    );
  }
}

class _CompareRow extends StatelessWidget {
  const _CompareRow({
    required this.feature,
    required this.scaffold,
    required this.cupertino,
    required this.raw,
  });
  final String feature;
  final String scaffold;
  final String cupertino;
  final String raw;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: _kBorder)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 3,
              child: Text(feature,
                  style: const TextStyle(
                      color: _kInkSoft,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700))),
          Expanded(
              flex: 2,
              child: Text(scaffold,
                  style: const TextStyle(
                      color: _kInk, fontSize: 11, fontWeight: FontWeight.w600))),
          Expanded(
              flex: 3,
              child: Text(cupertino,
                  style: const TextStyle(
                      color: _kInk, fontSize: 11, fontWeight: FontWeight.w600))),
          Expanded(
              flex: 2,
              child: Text(raw,
                  style: const TextStyle(
                      color: _kInk, fontSize: 11, fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 9 — GLOSSARY
// ===========================================================================

class _Section9Glossary extends StatelessWidget {
  const _Section9Glossary();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      label: "SECTION 09 — GLOSSARY",
      title: "Scaffold vocabulary",
      subtitle:
          "Every term you will hit in Flutter docs about Material screen "
          "structure, with a short, opinionated description.",
      tone: _kAccent2,
      children: const <Widget>[
        _GlossEntry(
            term: "Scaffold",
            def:
                "Material widget that implements the basic visual layout "
                "structure: appBar, body, bottom slots, drawers, and "
                "snack bar host."),
        _GlossEntry(
            term: "ScaffoldState",
            def:
                "State accessed via Scaffold.of(context) — used to open "
                "drawers, show snack bars (legacy), or show bottom sheets "
                "programmatically."),
        _GlossEntry(
            term: "ScaffoldMessenger",
            def:
                "Inherited widget that owns the snack bar queue. Survives "
                "route changes when placed above the navigator."),
        _GlossEntry(
            term: "PreferredSizeWidget",
            def:
                "A widget that exposes a preferred size so Scaffold can lay "
                "out the appBar slot. AppBar and TabBar implement this."),
        _GlossEntry(
            term: "FloatingActionButtonLocation",
            def:
                "Strategy class that places the FAB. Built-in options include "
                "startFloat, centerFloat, endFloat, plus docked variants."),
        _GlossEntry(
            term: "FloatingActionButtonAnimator",
            def:
                "Strategy class that animates FAB transitions when the "
                "location, icon, or visibility changes."),
        _GlossEntry(
            term: "Drawer",
            def:
                "Material side panel pushed in from the leading edge. "
                "Endorsed for navigation destinations on mobile."),
        _GlossEntry(
            term: "EndDrawer",
            def:
                "Mirror of Drawer on the trailing edge. Same gestures, "
                "different alignment."),
        _GlossEntry(
            term: "BottomNavigationBar",
            def:
                "Persistent bar of top-level destinations. Replaced in "
                "Material 3 by NavigationBar but still widely used."),
        _GlossEntry(
            term: "BottomSheet",
            def:
                "A surface that slides up above the body. Persistent variants "
                "stay across screens; modal variants block interaction."),
        _GlossEntry(
            term: "persistentFooterButtons",
            def:
                "A horizontal row of buttons just above the bottom bar. "
                "Useful for global commit / cancel actions."),
        _GlossEntry(
            term: "SnackBar",
            def:
                "Brief floating notification displayed by ScaffoldMessenger. "
                "Queued — only one is shown at a time."),
        _GlossEntry(
            term: "extendBody",
            def:
                "When true, the body is laid out behind the bottom bar — "
                "useful for translucent bars."),
        _GlossEntry(
            term: "extendBodyBehindAppBar",
            def:
                "When true, the body extends behind a translucent appBar. "
                "Pair with SafeArea inside the body if needed."),
        _GlossEntry(
            term: "resizeToAvoidBottomInset",
            def:
                "When true (default), Scaffold resizes its body to avoid "
                "the keyboard. Disable for flows that want to pin content."),
      ],
    );
  }
}

class _GlossEntry extends StatelessWidget {
  const _GlossEntry({required this.term, required this.def});
  final String term;
  final String def;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 150,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _kAccent2.withOpacity(0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              term,
              style: const TextStyle(
                color: _kAccent2,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                fontFamily: "monospace",
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              def,
              style: const TextStyle(
                color: _kInkSoft,
                fontSize: 12,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 10 — RECAP
// ===========================================================================

class _Section10Recap extends StatelessWidget {
  const _Section10Recap();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      label: "SECTION 10 — RECAP",
      title: "Putting it together",
      subtitle:
          "Scaffold is rarely the most interesting widget on a screen, but "
          "it is almost always present. The right slot choices set the user's "
          "navigation rhythm for the entire app.",
      tone: _kAccent,
      children: const <Widget>[
        _RecapRow(
            number: "1",
            tone: _kAccent5,
            title: "Pick the right shell",
            text:
                "Use Scaffold for Material apps, CupertinoPageScaffold for "
                "iOS-styled apps, and a raw Material widget only when you "
                "are sure you need to bypass conventions."),
        _RecapRow(
            number: "2",
            tone: _kAccent2,
            title: "Reserve the body for content",
            text:
                "Push chrome to the slots. Anything that should pin or "
                "animate independently belongs in appBar, bottom bar, "
                "bottom sheet, or persistent footer."),
        _RecapRow(
            number: "3",
            tone: _kAccent3,
            title: "Choose a FAB location intentionally",
            text:
                "Docked variants link the FAB to a bottom app bar; floating "
                "variants keep it free. Avoid switching at runtime unless "
                "you opt into the animator."),
        _RecapRow(
            number: "4",
            tone: _kAccent4,
            title: "Use drawers for navigation",
            text:
                "Drawers shine on mobile when there are more destinations "
                "than a bottom bar can fit. EndDrawer is great for filters."),
        _RecapRow(
            number: "5",
            tone: _kSuccess,
            title: "ScaffoldMessenger > Scaffold.of for snack bars",
            text:
                "Always reach for ScaffoldMessenger.of. It survives route "
                "transitions and avoids context-not-found issues."),
        _RecapRow(
            number: "6",
            tone: _kInfo,
            title: "Mind the keyboard",
            text:
                "resizeToAvoidBottomInset defaults to true. Disable it only "
                "when the layout below the keyboard must stay visible."),
        _RecapRow(
            number: "7",
            tone: _kWarn,
            title: "Watch extendBody pitfalls",
            text:
                "extendBody draws content behind the bottom bar. Translucent "
                "bars require manual padding adjustments inside the body."),
        _RecapRow(
            number: "8",
            tone: _kDanger,
            title: "Don't nest Scaffolds",
            text:
                "Nested Scaffolds usually point to a structural problem. "
                "Prefer tabs, pages, or modular bodies instead."),
      ],
    );
  }
}

class _RecapRow extends StatelessWidget {
  const _RecapRow({
    required this.number,
    required this.tone,
    required this.title,
    required this.text,
  });
  final String number;
  final Color tone;
  final String title;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tone.withOpacity(0.14),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              number,
              style: TextStyle(
                color: tone,
                fontSize: 14,
                fontWeight: FontWeight.w900,
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
                    color: _kInk,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: const TextStyle(
                    color: _kInkSoft,
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

// ---------------------------------------------------------------------------
// UTILITY — kept around for the dart:math import to remain meaningful in case
// the demo is later extended with procedurally-laid-out spark-bars or grids.
// Currently unused; flagged via leading ignore_for_file.
// ---------------------------------------------------------------------------

class _UnusedSparkUtil {
  const _UnusedSparkUtil();

  static List<double> sequence(int n, {double seed = 0.42}) {
    final math.Random rng = math.Random((seed * 1000).toInt());
    final List<double> out = <double>[];
    for (int i = 0; i < n; i++) {
      out.add(rng.nextDouble());
    }
    return out;
  }

  static double averaged(List<double> xs) {
    if (xs.isEmpty) return 0;
    double sum = 0;
    for (final double x in xs) {
      sum += x;
    }
    return sum / xs.length;
  }

  static bool isReleaseBuild() => kReleaseMode;
}

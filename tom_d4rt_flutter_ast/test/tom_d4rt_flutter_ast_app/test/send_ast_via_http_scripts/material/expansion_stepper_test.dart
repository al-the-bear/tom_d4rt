// Deep visual demo for Flutter Material ExpansionPanelList and Stepper widgets.
// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';

const _kBgTop = Color(0xFF0B1023);
const _kBgMid = Color(0xFF111733);
const _kBgBot = Color(0xFF1A1F44);
const _kAccent = Color(0xFF7C5CFF);
const _kAccent2 = Color(0xFF36D1DC);
const _kAccent3 = Color(0xFFFF7AB6);
const _kAccent4 = Color(0xFFFFB347);
const _kAccent5 = Color(0xFF4ADE80);
const _kSurface = Color(0xFF1B2244);
const _kSurfaceAlt = Color(0xFF232B55);
const _kBorder = Color(0xFF2F3A6A);
const _kTextMuted = Color(0xFFB7C0E0);
const _kTextDim = Color(0xFF7E8AC0);
const _kDanger = Color(0xFFFF6B6B);
const _kWarn = Color(0xFFFFD166);
const _kOk = Color(0xFF06D6A0);

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Logistics Onboarding Wizard",
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _kBgTop,
      colorScheme: const ColorScheme.dark(
        primary: _kAccent,
        secondary: _kAccent2,
        surface: _kSurface,
      ),
      cardColor: _kSurface,
      dividerColor: _kBorder,
      useMaterial3: true,
    ),
    home: const _DemoHome(),
  );
}

class _DemoHome extends StatelessWidget {
  const _DemoHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBgTop,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_kBgTop, _kBgMid, _kBgBot],
            stops: [0.0, 0.55, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _HeroSection(),
                SizedBox(height: 24),
                _IntroNarrativeSection(),
                SizedBox(height: 24),
                _StepperShowcaseSection(),
                SizedBox(height: 24),
                _ExpansionPanelShowcaseSection(),
                SizedBox(height: 24),
                _StateMatrixSection(),
                SizedBox(height: 24),
                _MetricsSummarySection(),
                SizedBox(height: 24),
                _AccessibilityNotesSection(),
                SizedBox(height: 24),
                _VariantGallerySection(),
                SizedBox(height: 24),
                _DesignRationaleSection(),
                SizedBox(height: 24),
                _ChecklistFooterSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _kAccent.withValues(alpha: 0.85),
            _kAccent2.withValues(alpha: 0.65),
            _kAccent3.withValues(alpha: 0.55),
          ],
          stops: const [0.0, 0.55, 1.0],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: _kAccent.withValues(alpha: 0.35),
            blurRadius: 28,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.45),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.local_shipping_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Atlas Logistics Cloud",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.92),
                        fontSize: 14,
                        letterSpacing: 2.4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Operator Onboarding Wizard",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(99),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.35),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: _kOk,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "DEMO BUILD 4.21",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        letterSpacing: 1.6,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            "A statically-rendered showcase of Material ExpansionPanelList and Stepper widgets, "
            "wrapped around a believable multi-stage operator onboarding flow for a regional "
            "fleet of 142 vehicles, 17 depots and 9 active corridors.",
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.92),
              fontSize: 15,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              _HeroPill(label: "Stepper", value: "6 stages"),
              SizedBox(width: 12),
              _HeroPill(label: "ExpansionPanel", value: "7 sections"),
              SizedBox(width: 12),
              _HeroPill(label: "Static", value: "no async"),
              SizedBox(width: 12),
              _HeroPill(label: "Theme", value: "Aurora"),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroPill extends StatelessWidget {
  final String label;
  final String value;
  const _HeroPill({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 10,
              letterSpacing: 1.6,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 1,
            height: 12,
            color: Colors.white.withValues(alpha: 0.4),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(
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

class _SectionShell extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String? subtitle;
  final Widget child;
  final List<Color> gradient;
  final IconData icon;

  const _SectionShell({
    required this.eyebrow,
    required this.title,
    this.subtitle,
    required this.child,
    required this.gradient,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _kBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(24, 22, 24, 22),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: gradient,
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.35),
                    ),
                  ),
                  child: Icon(icon, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eyebrow.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 11,
                          letterSpacing: 2.2,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 6),
                        Text(
                          subtitle!,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.82),
                            fontSize: 13,
                            height: 1.45,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _IntroNarrativeSection extends StatelessWidget {
  const _IntroNarrativeSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: "Narrative",
      title: "Why an onboarding wizard?",
      subtitle:
          "Atlas onboards independent fleet operators in a structured six-stage flow. "
          "Each stage gates a contract clause; collapsing prior context keeps the form short.",
      gradient: const [Color(0xFF3B2E7E), Color(0xFF1F4F8B)],
      icon: Icons.menu_book_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Operator: Northwind Haulage Ltd.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Submitted application #A-9173 on 2026-05-04. Reviewer notes mention a "
                      "partial compliance gap for hazmat transport and a missing W-9 on file. "
                      "The wizard surfaces those gaps as gated steps instead of a flat form.",
                      style: TextStyle(
                        color: _kTextMuted,
                        fontSize: 13.5,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: const [
                        _MiniChip(
                          label: "Region",
                          value: "Pacific NW",
                          color: _kAccent2,
                        ),
                        _MiniChip(
                          label: "Fleet",
                          value: "23 tractors",
                          color: _kAccent4,
                        ),
                        _MiniChip(
                          label: "Hazmat",
                          value: "Class 3 + 8",
                          color: _kAccent3,
                        ),
                        _MiniChip(
                          label: "Insurance",
                          value: "Pending",
                          color: _kWarn,
                        ),
                        _MiniChip(
                          label: "Rating",
                          value: "Tier B",
                          color: _kAccent,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 22),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        _kSurfaceAlt,
                        _kSurfaceAlt.withValues(alpha: 0.4),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: _kBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "QUICK FACTS",
                        style: TextStyle(
                          color: _kTextDim,
                          fontSize: 11,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _FactRow(
                        label: "Application age",
                        value: "7 days",
                      ),
                      const _FactRow(
                        label: "Stages remaining",
                        value: "3 of 6",
                      ),
                      const _FactRow(
                        label: "Reviewer",
                        value: "M. Okafor",
                      ),
                      const _FactRow(
                        label: "Next SLA",
                        value: "16h 22m",
                      ),
                      const _FactRow(
                        label: "Channel",
                        value: "Partner portal",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kAccent.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _kAccent.withValues(alpha: 0.35),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.tips_and_updates_outlined,
                    color: _kAccent, size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Design note: this scene is rendered statically by the D4rt analyzer-free "
                    "Flutter interpreter. We don't drive the Stepper currentStep through gestures; "
                    "instead each demo block hard-codes the index so all visual states are visible "
                    "at once in a single snapshot.",
                    style: TextStyle(
                      color: _kTextMuted,
                      fontSize: 13,
                      height: 1.55,
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

class _MiniChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _MiniChip({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: _kTextDim,
              fontSize: 11,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _FactRow extends StatelessWidget {
  final String label;
  final String value;
  const _FactRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: _kTextDim, fontSize: 12.5),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _StepperShowcaseSection extends StatelessWidget {
  const _StepperShowcaseSection();

  List<Step> _buildVerticalSteps() {
    return [
      Step(
        title: const Text(
          "Business profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          "Legal name, EIN, primary contact",
          style: TextStyle(color: _kTextDim, fontSize: 12),
        ),
        state: StepState.complete,
        isActive: false,
        content: _StepContentCard(
          title: "Captured",
          accent: _kOk,
          rows: const [
            _KeyValue(k: "Legal name", v: "Northwind Haulage Ltd."),
            _KeyValue(k: "EIN", v: "47-1183902"),
            _KeyValue(k: "Founded", v: "2011"),
            _KeyValue(k: "Headcount", v: "47"),
            _KeyValue(k: "Primary contact", v: "Priya Lall, COO"),
          ],
          footer: "Submitted 2026-05-04. Verified against state registry.",
        ),
      ),
      Step(
        title: const Text(
          "Insurance & bonding",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          "Certificate of insurance, surety bond",
          style: TextStyle(color: _kTextDim, fontSize: 12),
        ),
        state: StepState.complete,
        isActive: false,
        content: _StepContentCard(
          title: "Captured",
          accent: _kOk,
          rows: const [
            _KeyValue(k: "Carrier", v: "Sentinel Mutual"),
            _KeyValue(k: "Policy", v: "CMI-882-19077"),
            _KeyValue(k: "Liability", v: "USD 2.0M auto"),
            _KeyValue(k: "Cargo", v: "USD 250k"),
            _KeyValue(k: "Bond", v: "BMC-84 (USD 75k)"),
            _KeyValue(k: "Expires", v: "2027-03-31"),
          ],
          footer: "COI on file; auto-renews if no lapse flag is raised.",
        ),
      ),
      Step(
        title: const Text(
          "Fleet & equipment",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          "Tractors, trailers, telematics provider",
          style: TextStyle(color: _kTextDim, fontSize: 12),
        ),
        state: StepState.indexed,
        isActive: true,
        content: _StepContentCard(
          title: "In progress",
          accent: _kAccent,
          rows: const [
            _KeyValue(k: "Tractors", v: "23 confirmed"),
            _KeyValue(k: "Trailers", v: "31 (18 dry / 13 reefer)"),
            _KeyValue(k: "Telematics", v: "Geotab MyGeotab"),
            _KeyValue(k: "ELD provider", v: "Geotab GO9"),
            _KeyValue(k: "Avg unit age", v: "3.4 years"),
          ],
          footer:
              "Telematics token has been received; awaiting integration test "
              "between Geotab webhook and Atlas dispatcher.",
        ),
      ),
      Step(
        title: const Text(
          "Hazmat endorsement",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          "Class 3 / Class 8 transport authority",
          style: TextStyle(color: _kTextDim, fontSize: 12),
        ),
        state: StepState.error,
        isActive: false,
        content: _StepContentCard(
          title: "Action required",
          accent: _kDanger,
          rows: const [
            _KeyValue(k: "Class 3", v: "Approved"),
            _KeyValue(k: "Class 8", v: "Documentation incomplete"),
            _KeyValue(k: "HM-126F training", v: "8 of 23 drivers"),
            _KeyValue(k: "Tank inspection", v: "2 of 4 trailers"),
          ],
          footer:
              "Reviewer must collect HM-126F training certificates for the "
              "remaining 15 drivers before Class 8 corridor permits can be issued.",
        ),
      ),
      Step(
        title: const Text(
          "Banking & payouts",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          "ACH routing, W-9, factoring opt-in",
          style: TextStyle(color: _kTextDim, fontSize: 12),
        ),
        state: StepState.disabled,
        isActive: false,
        content: _StepContentCard(
          title: "Locked",
          accent: _kTextDim,
          rows: const [
            _KeyValue(k: "Routing", v: "Locked behind hazmat clearance"),
            _KeyValue(k: "ACH", v: "Locked"),
            _KeyValue(k: "W-9", v: "Required, not yet uploaded"),
            _KeyValue(k: "Factoring", v: "Optional, not selected"),
          ],
          footer:
              "Atlas releases this step once hazmat issues are cleared. The "
              "tooltip explains the dependency to the operator on hover.",
        ),
      ),
      Step(
        title: const Text(
          "Go live checklist",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          "Dispatcher seat, dock slots, training video",
          style: TextStyle(color: _kTextDim, fontSize: 12),
        ),
        state: StepState.disabled,
        isActive: false,
        content: _StepContentCard(
          title: "Pending",
          accent: _kTextDim,
          rows: const [
            _KeyValue(k: "Dispatcher seat", v: "Provisioned"),
            _KeyValue(k: "Dock slots", v: "3 reserved"),
            _KeyValue(k: "Training video", v: "Not yet started"),
            _KeyValue(k: "Sandbox load", v: "Not yet scheduled"),
            _KeyValue(k: "Go-live target", v: "2026-05-26"),
          ],
          footer: "Final step; releases the operator into the live dispatch pool.",
        ),
      ),
    ];
  }

  List<Step> _buildHorizontalSteps() {
    return [
      Step(
        title: const Text(
          "Identity",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        state: StepState.complete,
        isActive: false,
        content: const SizedBox.shrink(),
      ),
      Step(
        title: const Text(
          "Compliance",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        state: StepState.complete,
        isActive: false,
        content: const SizedBox.shrink(),
      ),
      Step(
        title: const Text(
          "Fleet",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        state: StepState.editing,
        isActive: true,
        content: const SizedBox.shrink(),
      ),
      Step(
        title: const Text(
          "Hazmat",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        state: StepState.error,
        isActive: false,
        content: const SizedBox.shrink(),
      ),
      Step(
        title: const Text(
          "Payouts",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        state: StepState.disabled,
        isActive: false,
        content: const SizedBox.shrink(),
      ),
      Step(
        title: const Text(
          "Go live",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        state: StepState.disabled,
        isActive: false,
        content: const SizedBox.shrink(),
      ),
    ];
  }

  Widget _buildControls(BuildContext context, ControlsDetails details) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_kAccent, Color(0xFF5C8DFF)],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Continue",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward_rounded,
                    color: Colors.white, size: 16),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kBorder),
            ),
            child: const Text(
              "Save & exit",
              style: TextStyle(
                color: _kTextMuted,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
          const Spacer(),
          Text(
            "Step ${details.stepIndex + 1} / 6",
            style: const TextStyle(color: _kTextDim, fontSize: 12),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: "Stepper",
      title: "Six-stage operator pipeline",
      subtitle:
          "A vertical Stepper renders the canonical flow. Each Step pins a "
          "specific StepState so the snapshot covers complete, indexed, error, "
          "editing and disabled states in one view.",
      gradient: const [Color(0xFF1F4F8B), Color(0xFF2DA8A1)],
      icon: Icons.timeline_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: _kSurfaceAlt,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: _kBorder),
            ),
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
            child: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.transparent,
                colorScheme: Theme.of(context).colorScheme.copyWith(
                      primary: _kAccent,
                      onSurface: Colors.white,
                    ),
              ),
              child: Stepper(
                physics: const NeverScrollableScrollPhysics(),
                currentStep: 2,
                type: StepperType.vertical,
                steps: _buildVerticalSteps(),
                controlsBuilder: _buildControls,
                onStepTapped: null,
              ),
            ),
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  _kSurfaceAlt,
                  _kSurfaceAlt.withValues(alpha: 0.4),
                ],
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: _kBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const Icon(Icons.horizontal_split_rounded,
                        color: _kAccent2, size: 18),
                    const SizedBox(width: 8),
                    const Text(
                      "Horizontal compact variant",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _kAccent2.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(99),
                        border: Border.all(
                            color: _kAccent2.withValues(alpha: 0.5)),
                      ),
                      child: const Text(
                        "StepperType.horizontal",
                        style: TextStyle(
                          color: _kAccent2,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Colors.transparent,
                    colorScheme: Theme.of(context).colorScheme.copyWith(
                          primary: _kAccent2,
                          onSurface: Colors.white,
                        ),
                  ),
                  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #43, P12):
                  // Flutter's Stepper(type: StepperType.horizontal) internally
                  // lays out as `Column(children: [headerRow, Expanded(child: …
                  // content)])`. When that Stepper is placed inside an outer
                  // Column whose vertical extent is unbounded (we live inside a
                  // SingleChildScrollView > Column), the inner Expanded sees
                  // an unbounded incoming height constraint and trips
                  // "RenderFlex children have non-zero flex but incoming height
                  // constraints are unbounded". Wrap the horizontal Stepper in
                  // a SizedBox with a finite height so the inner Expanded gets
                  // a bounded constraint. 220 px is enough for the header row
                  // (≈80 px) plus the shrunk-to-empty content area, with a
                  // breathing margin.
                  child: SizedBox(
                    height: 220,
                    child: Stepper(
                      physics: const NeverScrollableScrollPhysics(),
                      currentStep: 2,
                      type: StepperType.horizontal,
                      steps: _buildHorizontalSteps(),
                      controlsBuilder: (ctx, details) => const SizedBox.shrink(),
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

class _StepContentCard extends StatelessWidget {
  final String title;
  final Color accent;
  final List<_KeyValue> rows;
  final String footer;
  const _StepContentCard({
    required this.title,
    required this.accent,
    required this.rows,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.14),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14),
              ),
              border: Border(
                bottom: BorderSide(color: accent.withValues(alpha: 0.35)),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: accent,
                    fontSize: 12,
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
            child: Column(
              children: rows.map((r) => _kvRow(r)).toList(),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.subdirectory_arrow_right_rounded,
                    color: _kTextDim, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    footer,
                    style: const TextStyle(
                      color: _kTextDim,
                      fontSize: 12.5,
                      height: 1.45,
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

  Widget _kvRow(_KeyValue r) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(
              r.k,
              style: const TextStyle(color: _kTextDim, fontSize: 12.5),
            ),
          ),
          Expanded(
            child: Text(
              r.v,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _KeyValue {
  final String k;
  final String v;
  const _KeyValue({required this.k, required this.v});
}

class _ExpansionPanelShowcaseSection extends StatelessWidget {
  const _ExpansionPanelShowcaseSection();

  List<ExpansionPanel> _buildPanels() {
    return [
      ExpansionPanel(
        canTapOnHeader: true,
        isExpanded: true,
        backgroundColor: _kSurface,
        headerBuilder: (ctx, isExpanded) => _panelHeader(
          icon: Icons.business_center_outlined,
          accent: _kAccent,
          title: "Company information",
          subtitle: "Legal entity, EIN, registered agent",
          status: "verified",
          statusColor: _kOk,
        ),
        body: const _CompanyPanelBody(),
      ),
      ExpansionPanel(
        canTapOnHeader: true,
        isExpanded: false,
        backgroundColor: _kSurface,
        headerBuilder: (ctx, isExpanded) => _panelHeader(
          icon: Icons.shield_outlined,
          accent: _kAccent2,
          title: "Compliance documents",
          subtitle: "MC number, USDOT, IFTA, IRP",
          status: "complete",
          statusColor: _kOk,
        ),
        body: const _CompliancePanelBody(),
      ),
      ExpansionPanel(
        canTapOnHeader: true,
        isExpanded: true,
        backgroundColor: _kSurface,
        headerBuilder: (ctx, isExpanded) => _panelHeader(
          icon: Icons.local_shipping_outlined,
          accent: _kAccent4,
          title: "Fleet roster",
          subtitle: "23 tractors / 31 trailers",
          status: "syncing",
          statusColor: _kAccent4,
        ),
        body: const _FleetPanelBody(),
      ),
      ExpansionPanel(
        canTapOnHeader: true,
        isExpanded: false,
        backgroundColor: _kSurface,
        headerBuilder: (ctx, isExpanded) => _panelHeader(
          icon: Icons.warning_amber_rounded,
          accent: _kDanger,
          title: "Hazmat program",
          subtitle: "Class 3 + Class 8 endorsements",
          status: "action needed",
          statusColor: _kDanger,
        ),
        body: const _HazmatPanelBody(),
      ),
      ExpansionPanel(
        canTapOnHeader: true,
        isExpanded: true,
        backgroundColor: _kSurface,
        headerBuilder: (ctx, isExpanded) => _panelHeader(
          icon: Icons.route_outlined,
          accent: _kAccent3,
          title: "Lane preferences",
          subtitle: "Preferred corridors and dead-head limits",
          status: "draft",
          statusColor: _kAccent3,
        ),
        body: const _LanesPanelBody(),
      ),
      ExpansionPanel(
        canTapOnHeader: true,
        isExpanded: false,
        backgroundColor: _kSurface,
        headerBuilder: (ctx, isExpanded) => _panelHeader(
          icon: Icons.account_balance_outlined,
          accent: _kWarn,
          title: "Banking & payouts",
          subtitle: "ACH, factoring, holdback rules",
          status: "locked",
          statusColor: _kTextDim,
        ),
        body: const _BankingPanelBody(),
      ),
      ExpansionPanel(
        canTapOnHeader: true,
        isExpanded: false,
        backgroundColor: _kSurface,
        headerBuilder: (ctx, isExpanded) => _panelHeader(
          icon: Icons.rocket_launch_outlined,
          accent: _kAccent5,
          title: "Go live checklist",
          subtitle: "Training, dock slots, sandbox load",
          status: "pending",
          statusColor: _kTextDim,
        ),
        body: const _GoLivePanelBody(),
      ),
    ];
  }

  Widget _panelHeader({
    required IconData icon,
    required Color accent,
    required String title,
    required String subtitle,
    required String status,
    required Color statusColor,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  accent.withValues(alpha: 0.55),
                  accent.withValues(alpha: 0.15),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: accent.withValues(alpha: 0.6)),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(color: _kTextDim, fontSize: 12.5),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(99),
              border: Border.all(color: statusColor.withValues(alpha: 0.5)),
            ),
            child: Text(
              status.toUpperCase(),
              style: TextStyle(
                color: statusColor,
                fontSize: 10.5,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: "ExpansionPanelList",
      title: "Operator configuration sections",
      subtitle:
          "Seven configuration sections rendered as ExpansionPanel children. "
          "Three panels are expanded in this static snapshot, four are collapsed.",
      gradient: const [Color(0xFF2DA8A1), Color(0xFFB55F8A)],
      icon: Icons.unfold_more_rounded,
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
          dividerColor: _kBorder,
        ),
        child: ExpansionPanelList(
          elevation: 0,
          expandedHeaderPadding: EdgeInsets.zero,
          dividerColor: _kBorder,
          materialGapSize: 8,
          expansionCallback: (i, e) {},
          children: _buildPanels(),
        ),
      ),
    );
  }
}

class _CompanyPanelBody extends StatelessWidget {
  const _CompanyPanelBody();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_kSurface, _kSurfaceAlt],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _PanelFieldGroup(
                  title: "Legal entity",
                  rows: const [
                    _KeyValue(k: "DBA", v: "Northwind Haulage"),
                    _KeyValue(k: "Legal form", v: "Limited liability"),
                    _KeyValue(k: "Jurisdiction", v: "Oregon, USA"),
                    _KeyValue(k: "Filed", v: "2011-03-18"),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: _PanelFieldGroup(
                  title: "Identifiers",
                  rows: const [
                    _KeyValue(k: "EIN", v: "47-1183902"),
                    _KeyValue(k: "USDOT", v: "3318771"),
                    _KeyValue(k: "MC", v: "1082993"),
                    _KeyValue(k: "SCAC", v: "NWHL"),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: _PanelFieldGroup(
                  title: "Registered agent",
                  rows: const [
                    _KeyValue(k: "Name", v: "Cascadia Agents LLC"),
                    _KeyValue(k: "Phone", v: "+1 503 555 0182"),
                    _KeyValue(k: "Email", v: "agent@cascadia.example"),
                    _KeyValue(k: "City", v: "Salem, OR"),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _kAccent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kAccent.withValues(alpha: 0.35)),
            ),
            child: Row(
              children: const [
                Icon(Icons.verified_outlined, color: _kAccent, size: 18),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Verified against Oregon Secretary of State business "
                    "registry on 2026-05-04. Next automatic recheck on 2027-05-04.",
                    style: TextStyle(
                      color: _kTextMuted,
                      fontSize: 12.5,
                      height: 1.45,
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

class _PanelFieldGroup extends StatelessWidget {
  final String title;
  final List<_KeyValue> rows;
  const _PanelFieldGroup({required this.title, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: _kTextDim,
              fontSize: 11,
              letterSpacing: 1.8,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          ...rows.map((r) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 86,
                    child: Text(
                      r.k,
                      style: const TextStyle(color: _kTextDim, fontSize: 12),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      r.v,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _CompliancePanelBody extends StatelessWidget {
  const _CompliancePanelBody();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
      child: const Text(
        "Collapsed in this snapshot.",
        style: TextStyle(color: _kTextDim),
      ),
    );
  }
}

class _FleetPanelBody extends StatelessWidget {
  const _FleetPanelBody();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_kSurface, _kSurfaceAlt],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _fleetTableHeader(),
          _fleetRow("NWH-101", "Volvo VNL 760", "2022", "OR-78213",
              "Geotab GO9", "Active", _kOk),
          _fleetRow("NWH-102", "Kenworth T680", "2021", "OR-77110",
              "Geotab GO9", "Active", _kOk),
          _fleetRow("NWH-103", "Peterbilt 579", "2020", "OR-76332",
              "Geotab GO9", "Maintenance", _kWarn),
          _fleetRow("NWH-104", "Freightliner Cascadia", "2023", "OR-79921",
              "Geotab GO9", "Active", _kOk),
          _fleetRow("NWH-105", "Volvo VNL 860", "2024", "OR-80014",
              "Geotab GO9", "Pending ELD", _kAccent4),
          _fleetRow("NWH-106", "Kenworth T880", "2019", "OR-74012",
              "Geotab GO9", "Active", _kOk),
          _fleetRow("NWH-107", "Mack Anthem", "2022", "OR-78441",
              "Geotab GO9", "Active", _kOk),
          _fleetRow("NWH-108", "Peterbilt 389", "2018", "OR-71009",
              "Geotab GO9", "Out of service", _kDanger),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(Icons.cloud_sync_outlined,
                  color: _kAccent4, size: 18),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  "Showing 8 of 23 units. Telematics sync runs every 15 minutes "
                  "via the Geotab webhook on the dispatcher gateway.",
                  style: TextStyle(color: _kTextMuted, fontSize: 12.5),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: _kAccent4.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(99),
                  border:
                      Border.all(color: _kAccent4.withValues(alpha: 0.4)),
                ),
                child: const Text(
                  "Last sync 3m ago",
                  style: TextStyle(
                    color: _kAccent4,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _fleetTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _kSurfaceAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        children: const [
          SizedBox(width: 80, child: _Th("Unit")),
          Expanded(flex: 3, child: _Th("Model")),
          SizedBox(width: 60, child: _Th("Year")),
          SizedBox(width: 90, child: _Th("Plate")),
          Expanded(flex: 2, child: _Th("Telematics")),
          SizedBox(width: 120, child: _Th("Status")),
        ],
      ),
    );
  }

  Widget _fleetRow(String unit, String model, String year, String plate,
      String telematics, String status, Color statusColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      margin: const EdgeInsets.only(top: 6),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        children: [
          SizedBox(
              width: 80,
              child: Text(unit,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "monospace",
                      fontWeight: FontWeight.w700))),
          Expanded(
              flex: 3,
              child: Text(model,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 13))),
          SizedBox(
              width: 60,
              child: Text(year,
                  style: const TextStyle(color: _kTextDim, fontSize: 13))),
          SizedBox(
              width: 90,
              child: Text(plate,
                  style: const TextStyle(
                      color: _kTextDim,
                      fontFamily: "monospace",
                      fontSize: 12))),
          Expanded(
              flex: 2,
              child: Text(telematics,
                  style: const TextStyle(color: _kTextDim, fontSize: 12))),
          SizedBox(
            width: 120,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(99),
                  border:
                      Border.all(color: statusColor.withValues(alpha: 0.5)),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Th extends StatelessWidget {
  final String text;
  const _Th(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        color: _kTextDim,
        fontSize: 10.5,
        letterSpacing: 1.6,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _HazmatPanelBody extends StatelessWidget {
  const _HazmatPanelBody();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
      child: const Text(
        "Collapsed in this snapshot.",
        style: TextStyle(color: _kTextDim),
      ),
    );
  }
}

class _LanesPanelBody extends StatelessWidget {
  const _LanesPanelBody();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _kSurface,
            _kAccent3.withValues(alpha: 0.06),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.alt_route_rounded,
                  color: _kAccent3, size: 18),
              const SizedBox(width: 8),
              const Text(
                "Preferred corridors",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                "9 corridors active across 3 regions",
                style: TextStyle(color: _kTextDim, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _laneCard("Portland - Seattle", "I-5 N", "284 mi", "Daily",
              _kOk, "Profitable"),
          _laneCard("Portland - Boise", "I-84 E", "430 mi", "3x weekly",
              _kAccent2, "Even"),
          _laneCard("Seattle - Spokane", "I-90 E", "279 mi", "2x weekly",
              _kAccent2, "Even"),
          _laneCard("Tacoma - Reno", "I-5 / US-395", "634 mi", "Weekly",
              _kAccent4, "Marginal"),
          _laneCard("Portland - Sacramento", "I-5 S", "583 mi", "2x weekly",
              _kOk, "Profitable"),
          _laneCard("Seattle - Vancouver", "I-5 N", "143 mi", "Daily",
              _kAccent4, "Marginal"),
          _laneCard("Boise - Salt Lake City", "I-84 E", "344 mi", "Weekly",
              _kAccent2, "Even"),
          _laneCard("Eugene - Medford", "I-5 S", "166 mi", "3x weekly",
              _kOk, "Profitable"),
          _laneCard("Bend - Boise", "US-20 E", "320 mi", "Bi-weekly",
              _kDanger, "Loss"),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _kAccent3.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: _kAccent3.withValues(alpha: 0.35)),
            ),
            child: Row(
              children: const [
                Icon(Icons.insights_rounded, color: _kAccent3, size: 18),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Atlas recommends pausing the Bend - Boise corridor due "
                    "to negative margin over the last 8 dispatched loads. "
                    "Reassignment proposal is queued for reviewer approval.",
                    style: TextStyle(
                      color: _kTextMuted,
                      fontSize: 12.5,
                      height: 1.5,
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

  Widget _laneCard(String name, String road, String distance, String cadence,
      Color color, String margin) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _kSurfaceAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 36,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  road,
                  style: const TextStyle(color: _kTextDim, fontSize: 11.5),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              distance,
              style: const TextStyle(color: _kTextMuted, fontSize: 12.5),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              cadence,
              style: const TextStyle(color: _kTextMuted, fontSize: 12.5),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(99),
              border: Border.all(color: color.withValues(alpha: 0.5)),
            ),
            child: Text(
              margin,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BankingPanelBody extends StatelessWidget {
  const _BankingPanelBody();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
      child: const Text(
        "Collapsed in this snapshot.",
        style: TextStyle(color: _kTextDim),
      ),
    );
  }
}

class _GoLivePanelBody extends StatelessWidget {
  const _GoLivePanelBody();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
      child: const Text(
        "Collapsed in this snapshot.",
        style: TextStyle(color: _kTextDim),
      ),
    );
  }
}

class _StateMatrixSection extends StatelessWidget {
  const _StateMatrixSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: "Reference",
      title: "Stepper state matrix",
      subtitle:
          "All five StepState values rendered side-by-side so reviewers can "
          "compare iconography, color, and reviewer-facing affordance.",
      gradient: const [Color(0xFFB55F8A), Color(0xFFFF7AB6)],
      icon: Icons.grid_view_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: const [
              Expanded(
                child: _StateMatrixCard(
                  name: "indexed",
                  description:
                      "Default state with a numbered marker. Used for upcoming "
                      "or currently-active steps without further annotation.",
                  example: "Step 3 of 6",
                  marker: "3",
                  color: _kAccent,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _StateMatrixCard(
                  name: "editing",
                  description:
                      "Marker becomes an edit pencil. The reviewer can update "
                      "the captured values without resetting downstream gates.",
                  example: "Fleet roster being edited",
                  marker: "E",
                  color: _kAccent2,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _StateMatrixCard(
                  name: "complete",
                  description:
                      "Marker becomes a checkmark with the success color. The "
                      "step body collapses to a one-line summary.",
                  example: "Insurance verified",
                  marker: "OK",
                  color: _kOk,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(
                child: _StateMatrixCard(
                  name: "error",
                  description:
                      "Marker becomes an alert glyph. Step header gains a red "
                      "border. Downstream steps remain locked until cleared.",
                  example: "Hazmat documentation missing",
                  marker: "!",
                  color: _kDanger,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _StateMatrixCard(
                  name: "disabled",
                  description:
                      "Step header dims. Tapping is allowed but reveals a "
                      "tooltip explaining which gate must clear first.",
                  example: "Payouts (locked)",
                  marker: "-",
                  color: _kTextDim,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _StateMatrixCard(
                  name: "active",
                  description:
                      "Highlight ring on the marker. Indicates which step "
                      "currently owns the reviewer focus.",
                  example: "Fleet & equipment",
                  marker: "*",
                  color: _kAccent3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StateMatrixCard extends StatelessWidget {
  final String name;
  final String description;
  final String example;
  final String marker;
  final Color color;
  const _StateMatrixCard({
    required this.name,
    required this.description,
    required this.example,
    required this.marker,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: 0.18),
            _kSurfaceAlt,
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.35),
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 1.5),
                ),
                alignment: Alignment.center,
                child: Text(
                  marker,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "StepState.$name",
                style: TextStyle(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              color: _kTextMuted,
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "Example: $example",
              style: const TextStyle(color: _kTextDim, fontSize: 11.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricsSummarySection extends StatelessWidget {
  const _MetricsSummarySection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: "Metrics",
      title: "Onboarding funnel snapshot",
      subtitle:
          "Aggregate metrics from the last 30 days of onboarding traffic. "
          "These numbers are mock data; they exist to make the demo dense.",
      gradient: const [Color(0xFF36D1DC), Color(0xFF5B86E5)],
      icon: Icons.query_stats_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: const [
              Expanded(
                child: _MetricTile(
                  label: "Started",
                  value: "412",
                  delta: "+7.2%",
                  positive: true,
                  color: _kAccent,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _MetricTile(
                  label: "Stage 3 reached",
                  value: "289",
                  delta: "+4.1%",
                  positive: true,
                  color: _kAccent2,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _MetricTile(
                  label: "Hazmat block",
                  value: "47",
                  delta: "+12.6%",
                  positive: false,
                  color: _kDanger,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _MetricTile(
                  label: "Activated",
                  value: "183",
                  delta: "+3.8%",
                  positive: true,
                  color: _kOk,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [_kSurfaceAlt, _kSurface],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _kBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: const [
                    Icon(Icons.bar_chart_rounded,
                        color: _kAccent2, size: 18),
                    SizedBox(width: 8),
                    Text(
                      "Per-stage drop-off",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _StageBar(
                    label: "Business profile",
                    started: 412,
                    completed: 405,
                    barColor: _kAccent),
                _StageBar(
                    label: "Insurance & bonding",
                    started: 405,
                    completed: 366,
                    barColor: _kAccent2),
                _StageBar(
                    label: "Fleet & equipment",
                    started: 366,
                    completed: 289,
                    barColor: _kAccent4),
                _StageBar(
                    label: "Hazmat endorsement",
                    started: 289,
                    completed: 242,
                    barColor: _kDanger),
                _StageBar(
                    label: "Banking & payouts",
                    started: 242,
                    completed: 218,
                    barColor: _kWarn),
                _StageBar(
                    label: "Go live checklist",
                    started: 218,
                    completed: 183,
                    barColor: _kOk),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  final String label;
  final String value;
  final String delta;
  final bool positive;
  final Color color;
  const _MetricTile({
    required this.label,
    required this.value,
    required this.delta,
    required this.positive,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: 0.22),
            color.withValues(alpha: 0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: _kTextDim,
              fontSize: 10.5,
              letterSpacing: 1.8,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(
                positive
                    ? Icons.arrow_drop_up_rounded
                    : Icons.arrow_drop_down_rounded,
                color: positive ? _kOk : _kDanger,
                size: 22,
              ),
              Text(
                delta,
                style: TextStyle(
                  color: positive ? _kOk : _kDanger,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                "vs prior 30d",
                style: TextStyle(color: _kTextDim, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StageBar extends StatelessWidget {
  final String label;
  final int started;
  final int completed;
  final Color barColor;
  const _StageBar({
    required this.label,
    required this.started,
    required this.completed,
    required this.barColor,
  });

  @override
  Widget build(BuildContext context) {
    final ratio = completed / started;
    final percent = (ratio * 100).toStringAsFixed(1);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                "$completed / $started ($percent%)",
                style: const TextStyle(color: _kTextDim, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Stack(
              children: [
                Container(
                  height: 8,
                  color: _kBorder,
                ),
                FractionallySizedBox(
                  widthFactor: ratio,
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          barColor,
                          barColor.withValues(alpha: 0.5),
                        ],
                      ),
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

class _AccessibilityNotesSection extends StatelessWidget {
  const _AccessibilityNotesSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: "Accessibility",
      title: "Keyboard, screen reader, and color notes",
      subtitle:
          "Stepper and ExpansionPanelList both ship with sensible defaults; "
          "the notes below capture the operator-facing adjustments Atlas makes.",
      gradient: const [Color(0xFF6E48AA), Color(0xFF36D1DC)],
      icon: Icons.accessibility_new_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _AccessibilityNote(
            icon: Icons.keyboard_alt_outlined,
            color: _kAccent,
            title: "Keyboard navigation",
            body:
                "Tab moves between Stepper markers in horizontal mode and "
                "between ExpansionPanel headers in the panel list. Enter or "
                "Space activates the focused control. Esc collapses the "
                "currently focused expansion panel.",
          ),
          _AccessibilityNote(
            icon: Icons.record_voice_over_outlined,
            color: _kAccent2,
            title: "Screen reader semantics",
            body:
                "Each Step exposes a Semantics label of the form \"Step N, "
                "state\". Each ExpansionPanel header is announced as a button "
                "with an expanded/collapsed state. The body of each panel is "
                "announced as a region.",
          ),
          _AccessibilityNote(
            icon: Icons.contrast_outlined,
            color: _kAccent3,
            title: "Contrast",
            body:
                "Foreground text against the surface gradient is verified at "
                "a minimum 4.5:1 contrast ratio. The error state additionally "
                "uses an icon and a textual label so color is never the only "
                "signal.",
          ),
          _AccessibilityNote(
            icon: Icons.touch_app_outlined,
            color: _kAccent4,
            title: "Touch targets",
            body:
                "Header rows in the ExpansionPanelList expand the full hit "
                "rectangle of the header row. Stepper markers are at least "
                "48 logical pixels wide to satisfy the minimum touch target.",
          ),
          _AccessibilityNote(
            icon: Icons.translate_rounded,
            color: _kAccent5,
            title: "Localization",
            body:
                "Step titles and subtitles route through the Atlas l10n "
                "delegate; the snapshot here is the English baseline used "
                "in design reviews. RTL flips the marker rail to the right edge.",
          ),
        ],
      ),
    );
  }
}

class _AccessibilityNote extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String body;
  const _AccessibilityNote({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kSurfaceAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: color.withValues(alpha: 0.45)),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    color: _kTextMuted,
                    fontSize: 12.5,
                    height: 1.55,
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

class _VariantGallerySection extends StatelessWidget {
  const _VariantGallerySection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: "Variants",
      title: "Visual treatments at a glance",
      subtitle:
          "Atlas ships four header variants and three body densities. The "
          "gallery here captures all twelve permutations as miniatures.",
      gradient: const [Color(0xFFFF7AB6), Color(0xFFFFB347)],
      icon: Icons.palette_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _variantRow(
            "Header: Tonal",
            const [
              _VariantTile(
                  label: "Compact", density: "32 px", color: _kAccent),
              _VariantTile(
                  label: "Regular", density: "44 px", color: _kAccent),
              _VariantTile(
                  label: "Spacious", density: "56 px", color: _kAccent),
            ],
          ),
          _variantRow(
            "Header: Gradient",
            const [
              _VariantTile(
                  label: "Compact", density: "32 px", color: _kAccent2),
              _VariantTile(
                  label: "Regular", density: "44 px", color: _kAccent2),
              _VariantTile(
                  label: "Spacious", density: "56 px", color: _kAccent2),
            ],
          ),
          _variantRow(
            "Header: Outline",
            const [
              _VariantTile(
                  label: "Compact", density: "32 px", color: _kAccent3),
              _VariantTile(
                  label: "Regular", density: "44 px", color: _kAccent3),
              _VariantTile(
                  label: "Spacious", density: "56 px", color: _kAccent3),
            ],
          ),
          _variantRow(
            "Header: Hairline",
            const [
              _VariantTile(
                  label: "Compact", density: "32 px", color: _kAccent5),
              _VariantTile(
                  label: "Regular", density: "44 px", color: _kAccent5),
              _VariantTile(
                  label: "Spacious", density: "56 px", color: _kAccent5),
            ],
          ),
        ],
      ),
    );
  }

  Widget _variantRow(String label, List<Widget> tiles) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 160,
            child: Text(
              label,
              style: const TextStyle(
                color: _kTextMuted,
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          ...tiles.map((t) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: t,
                ),
              )),
        ],
      ),
    );
  }
}

class _VariantTile extends StatelessWidget {
  final String label;
  final String density;
  final Color color;
  const _VariantTile({
    required this.label,
    required this.density,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: 0.32),
            color.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.expand_more,
                    color: Colors.white, size: 16),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 6,
            width: 60,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            density,
            style: TextStyle(color: color, fontSize: 10.5),
          ),
        ],
      ),
    );
  }
}

class _DesignRationaleSection extends StatelessWidget {
  const _DesignRationaleSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: "Rationale",
      title: "Why Stepper + ExpansionPanelList together?",
      subtitle:
          "These two widgets cover different aspects of a long-form review: "
          "Stepper expresses sequence and gating, ExpansionPanelList expresses "
          "the orthogonal sections that don't need to be ordered.",
      gradient: const [Color(0xFFFFB347), Color(0xFFFF7AB6)],
      icon: Icons.lightbulb_outline,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _RationaleCard(
                  title: "Stepper",
                  caption: "Sequence with gates",
                  color: _kAccent,
                  bullets: const [
                    "Encodes ordered progress with clear state.",
                    "Naturally communicates blocked-by relationships.",
                    "Reviewer-facing controls live in controlsBuilder.",
                    "Compact horizontal variant works as a status bar.",
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _RationaleCard(
                  title: "ExpansionPanelList",
                  caption: "Orthogonal sections",
                  color: _kAccent2,
                  bullets: const [
                    "Sections are independent; no ordering implied.",
                    "Heavy dense bodies stay collapsed by default.",
                    "Header rows expose status pills for at-a-glance scans.",
                    "Works well alongside a Stepper without competing.",
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _RationaleCard(
                  title: "Combined",
                  caption: "Long-form review",
                  color: _kAccent3,
                  bullets: const [
                    "Stepper drives the conversation.",
                    "Panels surface supporting context on demand.",
                    "Reviewer never loses orientation in a 30-field form.",
                    "Snapshot here captures both at once.",
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _kSurfaceAlt,
                  _kAccent.withValues(alpha: 0.18),
                ],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _kBorder),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.architecture_outlined,
                    color: _kAccent, size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Implementation guidelines",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "1. Keep Stepper steps below 8; anything more becomes "
                        "hostile to scanning. 2. Prefer canTapOnHeader: true "
                        "for ExpansionPanel so the entire header is clickable. "
                        "3. Avoid mixing Stepper.continue with ExpansionPanel "
                        "expansion in the same gesture; let each widget own "
                        "its own input model. 4. When the snapshot is static "
                        "(like this demo), pin all states explicitly so "
                        "reviewers see every variant in one render.",
                        style: TextStyle(
                          color: _kTextMuted,
                          fontSize: 12.5,
                          height: 1.55,
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
    );
  }
}

class _RationaleCard extends StatelessWidget {
  final String title;
  final String caption;
  final Color color;
  final List<String> bullets;
  const _RationaleCard({
    required this.title,
    required this.caption,
    required this.color,
    required this.bullets,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: 0.22),
            _kSurface,
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            caption.toUpperCase(),
            style: TextStyle(
              color: color,
              fontSize: 10.5,
              letterSpacing: 1.8,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          ...bullets.map((b) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        b,
                        style: const TextStyle(
                          color: _kTextMuted,
                          fontSize: 12.5,
                          height: 1.5,
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

class _ChecklistFooterSection extends StatelessWidget {
  const _ChecklistFooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_kBgMid, _kSurface, _kBgBot],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _kOk.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                  border:
                      Border.all(color: _kOk.withValues(alpha: 0.5)),
                ),
                child: const Icon(Icons.fact_check_outlined,
                    color: _kOk, size: 22),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "REVIEW HANDOFF",
                      style: TextStyle(
                        color: _kTextDim,
                        fontSize: 11,
                        letterSpacing: 2.2,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Outstanding items before activation",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: _kAccent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(99),
                  border: Border.all(
                      color: _kAccent.withValues(alpha: 0.45)),
                ),
                child: const Text(
                  "Owner: M. Okafor",
                  style: TextStyle(
                    color: _kAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _checklistRow("Collect HM-126F training certificates",
              "Hazmat / Class 8", true, _kDanger),
          _checklistRow("Schedule tank inspection for trailers 207, 209",
              "Hazmat / Class 8", true, _kDanger),
          _checklistRow("Upload W-9 for Northwind Haulage Ltd.",
              "Banking & payouts", true, _kWarn),
          _checklistRow("Confirm dispatcher seat: Priya Lall",
              "Go live checklist", false, _kOk),
          _checklistRow("Reserve dock slots at Portland depot",
              "Go live checklist", false, _kOk),
          _checklistRow("Send training video link to operator",
              "Go live checklist", true, _kAccent),
          _checklistRow("Run sandbox load #4421",
              "Go live checklist", true, _kAccent),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _kAccent.withValues(alpha: 0.15),
                  _kAccent2.withValues(alpha: 0.15),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kAccent.withValues(alpha: 0.35)),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline_rounded,
                    color: _kAccent, size: 18),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    "When all blockers clear, Atlas auto-advances the operator "
                    "to the Go live stage and notifies the dispatcher pool. "
                    "Reviewer can override at any time from the actions menu.",
                    style: TextStyle(
                      color: _kTextMuted,
                      fontSize: 12.5,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [_kAccent, _kAccent2],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Open ticket",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.open_in_new_rounded,
                          color: Colors.white, size: 14),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                "Generated by Atlas reviewer console",
                style: TextStyle(
                  color: _kTextDim,
                  fontSize: 11.5,
                ),
              ),
              const Spacer(),
              Text(
                "Snapshot taken 2026-05-11 at 10:42 PDT",
                style: TextStyle(
                  color: _kTextDim,
                  fontSize: 11.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _checklistRow(
      String label, String section, bool open, Color color) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: _kSurfaceAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: open
                  ? Colors.transparent
                  : color.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: color, width: 1.4),
            ),
            child: open
                ? null
                : const Icon(Icons.check, color: Colors.white, size: 14),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: open ? Colors.white : _kTextDim,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    decoration: open ? null : TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  section,
                  style: const TextStyle(
                    color: _kTextDim,
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(99),
              border: Border.all(color: color.withValues(alpha: 0.45)),
            ),
            child: Text(
              open ? "OPEN" : "DONE",
              style: TextStyle(
                color: color,
                fontSize: 10.5,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

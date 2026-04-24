// ---------------------------------------------------------------------------
// StandardComponentType — Component Library Catalogue
// ---------------------------------------------------------------------------
//
// StandardComponentType is an enum exported from package:flutter/widgets.dart.
// It identifies standard UI components (backButton, closeButton, moreButton,
// drawerButton) for the testing infrastructure (CommonFinders.backButton, etc.)
// and for design-system component lookup utilities such as ComponentTypeLookup
// and GetStandardComponent.
//
// Each enum value exposes a `ValueKey<StandardComponentType>` via `.key` which
// can be attached to a widget so that `find.backButton()` and friends can find
// it without resorting to fragile icon or tooltip matchers.
//
// This demo is styled as an INDUSTRIAL DESIGN CATALOGUE in navy, mustard and
// stone. Specimen cards, part numbers, index tabs — the aesthetic of a
// component library binder on an architect's desk.
// ---------------------------------------------------------------------------

import 'dart:math' as math;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Catalogue palette — navy / mustard / stone.
// ---------------------------------------------------------------------------

const Color _kNavy = Color(0xFF0F2A44);
const Color _kNavyDeep = Color(0xFF081A2B);
const Color _kNavySoft = Color(0xFF1E3F5F);
const Color _kMustard = Color(0xFFD4A935);
const Color _kMustardDeep = Color(0xFFA87F1C);
const Color _kMustardPale = Color(0xFFF1D988);
const Color _kStone = Color(0xFFE5DDD0);
const Color _kStoneLight = Color(0xFFF4EFE4);
const Color _kStoneDark = Color(0xFFC7BCA8);
const Color _kInk = Color(0xFF1C1A14);
const Color _kPaper = Color(0xFFFBF7EE);
const Color _kRust = Color(0xFF8B3A1F);

// ---------------------------------------------------------------------------
// d4rt AST entrypoint — must return MaterialApp(home: ...). No main/runApp.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'StandardComponentType — Component Library Catalogue',
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: _kPaper,
      colorScheme: const ColorScheme.light(
        primary: _kNavy,
        onPrimary: _kPaper,
        secondary: _kMustard,
        onSecondary: _kInk,
        surface: _kStoneLight,
        onSurface: _kInk,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _kInk, fontSize: 14, height: 1.38),
      ),
    ),
    home: const _SctCataloguePage(),
  );
}

// ---------------------------------------------------------------------------
// Catalogue model — one record per enum value. Hand-authored descriptions.
// ---------------------------------------------------------------------------

class _SctSpecimen {
  const _SctSpecimen({
    required this.type,
    required this.partNumber,
    required this.humanName,
    required this.tagline,
    required this.useWhen,
    required this.alternatives,
    required this.accent,
    required this.glyph,
    required this.category,
  });

  final StandardComponentType type;
  final String partNumber;
  final String humanName;
  final String tagline;
  final String useWhen;
  final List<String> alternatives;
  final Color accent;
  final IconData glyph;
  final String category;

  String get enumName => type.name;
}

const List<_SctSpecimen> _kSpecimens = <_SctSpecimen>[
  _SctSpecimen(
    type: StandardComponentType.backButton,
    partNumber: 'SCT-001',
    humanName: 'Back Button',
    tagline: 'Navigate one step backward through the route stack.',
    useWhen:
        'Use when a pushed route (detail screen, edit form, settings page) '
        'should offer the user a way to return to the previous screen.',
    alternatives: <String>[
      'BackButton (material) — canonical implementation',
      'IconButton(icon: Icon(Icons.arrow_back)) — manual form',
      'CupertinoNavigationBarBackButton — iOS-styled equivalent',
    ],
    accent: _kMustard,
    glyph: Icons.arrow_back_rounded,
    category: 'Navigation',
  ),
  _SctSpecimen(
    type: StandardComponentType.closeButton,
    partNumber: 'SCT-002',
    humanName: 'Close Button',
    tagline: 'Dismiss the current dialog, sheet or modal surface.',
    useWhen:
        'Use on modals, bottom sheets, full-screen dialogs, and anywhere the '
        'user needs an unambiguous exit from a transient surface.',
    alternatives: <String>[
      'CloseButton (material) — canonical implementation',
      'IconButton(icon: Icon(Icons.close)) — manual form',
      'Dismissible — for swipe-away cards',
    ],
    accent: _kRust,
    glyph: Icons.close_rounded,
    category: 'Dismissal',
  ),
  _SctSpecimen(
    type: StandardComponentType.moreButton,
    partNumber: 'SCT-003',
    humanName: 'More Button',
    tagline: 'Reveal an overflow menu of secondary actions.',
    useWhen:
        'Use in toolbars or list rows when several actions exist but only the '
        'primary one or two should be promoted; the rest hide behind "more".',
    alternatives: <String>[
      'PopupMenuButton — opens an anchored menu',
      'MenuAnchor — Material 3 menu surface',
      'IconButton(icon: Icon(Icons.more_vert)) — manual form',
    ],
    accent: _kNavy,
    glyph: Icons.more_vert_rounded,
    category: 'Overflow',
  ),
  _SctSpecimen(
    type: StandardComponentType.drawerButton,
    partNumber: 'SCT-004',
    humanName: 'Drawer Button',
    tagline: 'Open the navigation drawer attached to the nearest Scaffold.',
    useWhen:
        'Use at the leading edge of an AppBar when a navigation drawer is '
        'available, especially on devices where an edge-swipe gesture is not '
        'discoverable.',
    alternatives: <String>[
      'DrawerButton (material) — canonical implementation',
      'Scaffold.of(context).openDrawer() — programmatic form',
      'NavigationRail — compact persistent alternative',
    ],
    accent: _kMustardDeep,
    glyph: Icons.menu_rounded,
    category: 'Navigation',
  ),
];

// ---------------------------------------------------------------------------
// Page shell with animated mustard index-ribbon header.
// ---------------------------------------------------------------------------

class _SctCataloguePage extends StatefulWidget {
  const _SctCataloguePage();

  @override
  State<_SctCataloguePage> createState() => _SctCataloguePageState();
}

class _SctCataloguePageState extends State<_SctCataloguePage>
    with TickerProviderStateMixin {
  late final AnimationController _ribbonController;
  late final AnimationController _pulseController;

  int _selectedIndex = 0;
  bool _useDropdownDial = true;
  bool _showPartNumbers = true;
  double _cardDensity = 1.0;

  @override
  void initState() {
    super.initState();
    _ribbonController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9),
    )..repeat();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ribbonController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _setSelected(int index) {
    if (index < 0 || index >= _kSpecimens.length) {
      return;
    }
    if (index == _selectedIndex) {
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
    debugPrint(
      '[Sct] selected ${_kSpecimens[index].partNumber} '
      '(${_kSpecimens[index].enumName}, index=$index)',
    );
  }

  @override
  Widget build(BuildContext context) {
    final _SctSpecimen selected = _kSpecimens[_selectedIndex];

    return Scaffold(
      backgroundColor: _kPaper,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: _SctHeroHeader(
                    ribbonController: _ribbonController,
                    pulseController: _pulseController,
                    selected: selected,
                    totalCount: _kSpecimens.length,
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 18)),
                SliverToBoxAdapter(
                  child: _SctControlBar(
                    useDropdownDial: _useDropdownDial,
                    onToggleDial: (bool value) {
                      setState(() {
                        _useDropdownDial = value;
                      });
                    },
                    showPartNumbers: _showPartNumbers,
                    onTogglePartNumbers: (bool value) {
                      setState(() {
                        _showPartNumbers = value;
                      });
                    },
                    cardDensity: _cardDensity,
                    onDensityChanged: (double value) {
                      setState(() {
                        _cardDensity = value;
                      });
                    },
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 18)),
                SliverToBoxAdapter(
                  child: _SctDialPanel(
                    useDropdown: _useDropdownDial,
                    selectedIndex: _selectedIndex,
                    onChanged: _setSelected,
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 18)),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverToBoxAdapter(
                    child: _SctSpecimenGrid(
                      selectedIndex: _selectedIndex,
                      density: _cardDensity,
                      showPartNumber: _showPartNumbers,
                      onTap: _setSelected,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 28)),
                const SliverToBoxAdapter(child: _SctLookupTable()),
                const SliverToBoxAdapter(child: SizedBox(height: 28)),
                const SliverToBoxAdapter(child: _SctAccordionSection()),
                const SliverToBoxAdapter(child: SizedBox(height: 28)),
                const SliverToBoxAdapter(child: _SctPitfallCard()),
                const SliverToBoxAdapter(child: SizedBox(height: 28)),
                const SliverToBoxAdapter(child: _SctFootnotes()),
                const SliverToBoxAdapter(child: SizedBox(height: 48)),
              ],
            ),
          ),
          _SctCatalogueIndex(
            selectedIndex: _selectedIndex,
            pulseController: _pulseController,
            onTap: _setSelected,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Hero header with animated mustard index-ribbon.
// ---------------------------------------------------------------------------

class _SctHeroHeader extends StatelessWidget {
  const _SctHeroHeader({
    required this.ribbonController,
    required this.pulseController,
    required this.selected,
    required this.totalCount,
  });

  final AnimationController ribbonController;
  final AnimationController pulseController;
  final _SctSpecimen selected;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_kNavyDeep, _kNavy, _kNavySoft],
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: AnimatedBuilder(
              animation: ribbonController,
              builder: (BuildContext context, Widget? child) {
                return CustomPaint(
                  painter: _SctRibbonPainter(
                    progress: ribbonController.value,
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: 24,
            top: 24,
            child: _SctCatalogueSeal(pulseController: pulseController),
          ),
          Positioned(
            left: 130,
            top: 28,
            right: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _kMustard,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: const Text(
                        'VOLUME IV',
                        style: TextStyle(
                          color: _kNavyDeep,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2.2,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'STANDARD COMPONENT TYPE',
                      style: TextStyle(
                        color: _kStoneLight,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 3.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'Component Library Catalogue',
                  style: TextStyle(
                    color: _kPaper,
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.6,
                    height: 1.05,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'A specimen index of the four values defined by '
                  'package:flutter/widgets.dart — cross-referenced with their '
                  'canonical Material widgets, finder aliases and design-system '
                  'lookup keys.',
                  style: TextStyle(
                    color: _kStone.withValues(alpha: 0.85),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: <Widget>[
                    _SctHeaderMeta(
                      label: 'SPECIMENS',
                      value: totalCount.toString().padLeft(3, '0'),
                    ),
                    const SizedBox(width: 22),
                    _SctHeaderMeta(
                      label: 'CURRENT',
                      value: selected.partNumber,
                    ),
                    const SizedBox(width: 22),
                    _SctHeaderMeta(
                      label: 'CATEGORY',
                      value: selected.category.toUpperCase(),
                    ),
                    const SizedBox(width: 22),
                    _SctHeaderMeta(
                      label: 'REVISION',
                      value: '2026.04',
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 24,
            bottom: 18,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: _kMustard, width: 1),
                borderRadius: BorderRadius.circular(3),
              ),
              child: const Text(
                'FLUTTER 3.41 — enum of 4',
                style: TextStyle(
                  color: _kMustard,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.2,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SctHeaderMeta extends StatelessWidget {
  const _SctHeaderMeta({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            color: _kMustard.withValues(alpha: 0.9),
            fontSize: 9,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.2,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            color: _kPaper,
            fontSize: 15,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }
}

class _SctCatalogueSeal extends StatelessWidget {
  const _SctCatalogueSeal({required this.pulseController});

  final AnimationController pulseController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pulseController,
      builder: (BuildContext context, Widget? child) {
        final double t = pulseController.value;
        return Container(
          width: 92,
          height: 92,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _kPaper,
            border: Border.all(
              color: Color.lerp(_kMustard, _kMustardPale, t) ?? _kMustard,
              width: 3,
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: _kMustard.withValues(alpha: 0.35 + 0.15 * t),
                blurRadius: 14 + 4 * t,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                'SCT',
                style: TextStyle(
                  color: _kNavy,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3.0,
                  fontFamily: 'monospace',
                ),
              ),
              SizedBox(height: 2),
              Text(
                'vol·IV',
                style: TextStyle(
                  color: _kMustardDeep,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.8,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Index-ribbon painter — three mustard ribbons sliding diagonally with
// stitched edges and part-number tick marks.
// ---------------------------------------------------------------------------

class _SctRibbonPainter extends CustomPainter {
  _SctRibbonPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    // Background stitch pattern.
    final Paint stitchPaint = Paint()
      ..color = _kMustard.withValues(alpha: 0.08)
      ..strokeWidth = 1;
    for (double y = -20; y < size.height + 20; y += 14) {
      canvas.drawLine(
        Offset(0, y + (progress * 18)),
        Offset(size.width, y + (progress * 18) - 24),
        stitchPaint,
      );
    }

    // Three moving ribbons.
    _paintRibbon(
      canvas,
      size,
      offset: progress,
      y: size.height * 0.35,
      height: 22,
      color: _kMustard.withValues(alpha: 0.85),
    );
    _paintRibbon(
      canvas,
      size,
      offset: (progress + 0.4) % 1.0,
      y: size.height * 0.62,
      height: 10,
      color: _kMustardPale.withValues(alpha: 0.55),
    );
    _paintRibbon(
      canvas,
      size,
      offset: (progress + 0.72) % 1.0,
      y: size.height * 0.82,
      height: 6,
      color: _kMustardDeep.withValues(alpha: 0.7),
    );
  }

  void _paintRibbon(
    Canvas canvas,
    Size size, {
    required double offset,
    required double y,
    required double height,
    required Color color,
  }) {
    final double width = size.width * 0.55;
    final double x = -width + (size.width + width) * offset;
    final Rect rect = Rect.fromLTWH(x, y, width, height);
    final Paint ribbonPaint = Paint()..color = color;
    canvas.drawRect(rect, ribbonPaint);

    // Edge stitching.
    final Paint edgePaint = Paint()
      ..color = _kNavyDeep.withValues(alpha: 0.35)
      ..strokeWidth = 1;
    for (double tx = x; tx < x + width; tx += 10) {
      canvas.drawLine(
        Offset(tx, y),
        Offset(tx + 4, y),
        edgePaint,
      );
      canvas.drawLine(
        Offset(tx, y + height),
        Offset(tx + 4, y + height),
        edgePaint,
      );
    }

    // Part-number ticks riding the ribbon.
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    for (int i = 0; i < 6; i++) {
      final double tickX = x + i * (width / 6) + 8;
      if (tickX < 0 || tickX > size.width) {
        continue;
      }
      textPainter.text = TextSpan(
        text: 'SCT-${(i + 1).toString().padLeft(3, '0')}',
        style: TextStyle(
          color: _kNavyDeep.withValues(alpha: 0.85),
          fontSize: 8,
          fontWeight: FontWeight.w800,
          fontFamily: 'monospace',
          letterSpacing: 1.2,
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(tickX, y + (height - 8) / 2));
    }
  }

  @override
  bool shouldRepaint(covariant _SctRibbonPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

// ---------------------------------------------------------------------------
// Control bar — catalogue settings (dial type, part numbers, density).
// ---------------------------------------------------------------------------

class _SctControlBar extends StatelessWidget {
  const _SctControlBar({
    required this.useDropdownDial,
    required this.onToggleDial,
    required this.showPartNumbers,
    required this.onTogglePartNumbers,
    required this.cardDensity,
    required this.onDensityChanged,
  });

  final bool useDropdownDial;
  final ValueChanged<bool> onToggleDial;
  final bool showPartNumbers;
  final ValueChanged<bool> onTogglePartNumbers;
  final double cardDensity;
  final ValueChanged<double> onDensityChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
      decoration: BoxDecoration(
        color: _kStoneLight,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _kStoneDark, width: 1),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.settings_rounded, color: _kNavy, size: 18),
          const SizedBox(width: 8),
          const Text(
            'CATALOGUE CONTROLS',
            style: TextStyle(
              color: _kNavy,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.2,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(width: 22),
          _SctToggleChip(
            label: 'Dropdown Dial',
            value: useDropdownDial,
            onChanged: onToggleDial,
            activeColor: _kMustard,
          ),
          const SizedBox(width: 10),
          _SctToggleChip(
            label: 'Slider Dial',
            value: !useDropdownDial,
            onChanged: (bool v) => onToggleDial(!v),
            activeColor: _kNavy,
          ),
          const SizedBox(width: 18),
          _SctToggleChip(
            label: 'Part Numbers',
            value: showPartNumbers,
            onChanged: onTogglePartNumbers,
            activeColor: _kMustardDeep,
          ),
          const SizedBox(width: 18),
          const Text(
            'DENSITY',
            style: TextStyle(
              color: _kNavySoft,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.8,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 140,
            child: SliderTheme(
              data: const SliderThemeData(
                activeTrackColor: _kMustard,
                inactiveTrackColor: _kStoneDark,
                thumbColor: _kNavy,
                overlayColor: Color(0x22D4A935),
                trackHeight: 3,
              ),
              child: Slider(
                value: cardDensity,
                min: 0.85,
                max: 1.25,
                onChanged: onDensityChanged,
              ),
            ),
          ),
          Text(
            '${(cardDensity * 100).toStringAsFixed(0)}%',
            style: const TextStyle(
              color: _kNavy,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class _SctToggleChip extends StatelessWidget {
  const _SctToggleChip({
    required this.label,
    required this.value,
    required this.onChanged,
    required this.activeColor,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(3),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: value ? activeColor : _kPaper,
          border: Border.all(
            color: value ? activeColor : _kStoneDark,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              value
                  ? Icons.check_box_rounded
                  : Icons.check_box_outline_blank_rounded,
              size: 14,
              color: value ? _kPaper : _kNavySoft,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: value ? _kPaper : _kNavy,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Dial panel — dropdown or slider cycling through enum values; status below.
// ---------------------------------------------------------------------------

class _SctDialPanel extends StatelessWidget {
  const _SctDialPanel({
    required this.useDropdown,
    required this.selectedIndex,
    required this.onChanged,
  });

  final bool useDropdown;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final _SctSpecimen selected = _kSpecimens[selectedIndex];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _kNavy,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _kMustard, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: _kMustard,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.tune_rounded,
                    color: _kNavyDeep, size: 18),
              ),
              const SizedBox(width: 12),
              const Text(
                'INTERACTIVE DIAL',
                style: TextStyle(
                  color: _kMustard,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3.0,
                  fontFamily: 'monospace',
                ),
              ),
              const Spacer(),
              Text(
                useDropdown ? 'mode: DROPDOWN' : 'mode: SLIDER',
                style: TextStyle(
                  color: _kStone.withValues(alpha: 0.75),
                  fontSize: 11,
                  fontFamily: 'monospace',
                  letterSpacing: 1.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: <Widget>[
              Expanded(
                child: useDropdown
                    ? _SctDropdownDial(
                        selectedIndex: selectedIndex,
                        onChanged: onChanged,
                      )
                    : _SctSliderDial(
                        selectedIndex: selectedIndex,
                        onChanged: onChanged,
                      ),
              ),
              const SizedBox(width: 18),
              _SctDialStatus(selected: selected, index: selectedIndex),
            ],
          ),
        ],
      ),
    );
  }
}

class _SctDropdownDial extends StatelessWidget {
  const _SctDropdownDial({
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _kPaper,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: _kMustard, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: selectedIndex,
          isExpanded: true,
          icon: const Icon(Icons.unfold_more_rounded, color: _kNavy),
          style: const TextStyle(
            color: _kNavy,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace',
          ),
          dropdownColor: _kPaper,
          items: <DropdownMenuItem<int>>[
            for (int i = 0; i < _kSpecimens.length; i++)
              DropdownMenuItem<int>(
                value: i,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _kSpecimens[i].accent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${_kSpecimens[i].partNumber}  ·  StandardComponentType.${_kSpecimens[i].enumName}',
                      style: const TextStyle(
                        color: _kNavy,
                        fontSize: 13,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
          ],
          onChanged: (int? value) {
            if (value != null) {
              onChanged(value);
            }
          },
        ),
      ),
    );
  }
}

class _SctSliderDial extends StatelessWidget {
  const _SctSliderDial({
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SliderTheme(
          data: const SliderThemeData(
            activeTrackColor: _kMustard,
            inactiveTrackColor: Color(0xFF2D4A6A),
            thumbColor: _kPaper,
            overlayColor: Color(0x33D4A935),
            valueIndicatorColor: _kMustardDeep,
            trackHeight: 4,
          ),
          child: Slider(
            min: 0,
            max: (_kSpecimens.length - 1).toDouble(),
            divisions: _kSpecimens.length - 1,
            value: selectedIndex.toDouble(),
            label: _kSpecimens[selectedIndex].partNumber,
            onChanged: (double value) => onChanged(value.round()),
          ),
        ),
        const SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            for (final _SctSpecimen s in _kSpecimens)
              Text(
                s.partNumber,
                style: TextStyle(
                  color: _kStone.withValues(alpha: 0.75),
                  fontSize: 9,
                  fontFamily: 'monospace',
                  letterSpacing: 1.2,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _SctDialStatus extends StatelessWidget {
  const _SctDialStatus({required this.selected, required this.index});

  final _SctSpecimen selected;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kNavyDeep,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: selected.accent, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: selected.accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'STATUS — index $index',
                style: const TextStyle(
                  color: _kStone,
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.0,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            selected.partNumber,
            style: const TextStyle(
              color: _kMustard,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              fontFamily: 'monospace',
            ),
          ),
          Text(
            selected.enumName,
            style: const TextStyle(
              color: _kPaper,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            selected.humanName,
            style: TextStyle(
              color: _kStone.withValues(alpha: 0.8),
              fontSize: 11,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Specimen grid — one card per enum value, laid out via Wrap.
// ---------------------------------------------------------------------------

class _SctSpecimenGrid extends StatelessWidget {
  const _SctSpecimenGrid({
    required this.selectedIndex,
    required this.density,
    required this.showPartNumber,
    required this.onTap,
  });

  final int selectedIndex;
  final double density;
  final bool showPartNumber;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final double width = 320 * density;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _SctSectionHeader(
          number: '§ 01',
          title: 'SPECIMEN INDEX',
          subtitle:
              'Each card presents the enum value, its canonical Material '
              'widget rendered live, and a short usage note.',
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 18,
          runSpacing: 18,
          children: <Widget>[
            for (int i = 0; i < _kSpecimens.length; i++)
              SizedBox(
                width: width,
                child: _SctSpecimenCard(
                  specimen: _kSpecimens[i],
                  index: i,
                  selected: i == selectedIndex,
                  density: density,
                  showPartNumber: showPartNumber,
                  onTap: () => onTap(i),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _SctSectionHeader extends StatelessWidget {
  const _SctSectionHeader({
    required this.number,
    required this.title,
    required this.subtitle,
  });

  final String number;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(color: _kMustard, width: 4),
          bottom: BorderSide(color: _kStoneDark, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                number,
                style: const TextStyle(
                  color: _kMustardDeep,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.4,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(width: 8),
              Container(width: 14, height: 1, color: _kStoneDark),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: _kNavy,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              color: _kInk.withValues(alpha: 0.68),
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _SctSpecimenCard extends StatelessWidget {
  const _SctSpecimenCard({
    required this.specimen,
    required this.index,
    required this.selected,
    required this.density,
    required this.showPartNumber,
    required this.onTap,
  });

  final _SctSpecimen specimen;
  final int index;
  final bool selected;
  final double density;
  final bool showPartNumber;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: _kStoneLight,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: selected ? specimen.accent : _kStoneDark,
            width: selected ? 2.4 : 1,
          ),
          boxShadow: selected
              ? <BoxShadow>[
                  BoxShadow(
                    color: specimen.accent.withValues(alpha: 0.35),
                    blurRadius: 18,
                    spreadRadius: 1,
                  ),
                ]
              : const <BoxShadow>[],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _SctSpecimenHeader(
              specimen: specimen,
              index: index,
              showPartNumber: showPartNumber,
              selected: selected,
            ),
            _SctSpecimenStage(specimen: specimen, density: density),
            _SctSpecimenFooter(specimen: specimen),
          ],
        ),
      ),
    );
  }
}

class _SctSpecimenHeader extends StatelessWidget {
  const _SctSpecimenHeader({
    required this.specimen,
    required this.index,
    required this.showPartNumber,
    required this.selected,
  });

  final _SctSpecimen specimen;
  final int index;
  final bool showPartNumber;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
      decoration: BoxDecoration(
        color: _kNavy,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
        border: Border(
          bottom: BorderSide(color: specimen.accent, width: 2),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: specimen.accent,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(specimen.glyph, size: 16, color: _kNavyDeep),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (showPartNumber)
                  Text(
                    '${specimen.partNumber}  ·  IDX-${index.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      color: specimen.accent,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.8,
                      fontFamily: 'monospace',
                    ),
                  ),
                Text(
                  'StandardComponentType.${specimen.enumName}',
                  style: const TextStyle(
                    color: _kPaper,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          if (selected)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: _kMustard,
                borderRadius: BorderRadius.circular(2),
              ),
              child: const Text(
                'SEL',
                style: TextStyle(
                  color: _kNavyDeep,
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.6,
                  fontFamily: 'monospace',
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// The live working Material widget for each specimen, plus tagline.
class _SctSpecimenStage extends StatelessWidget {
  const _SctSpecimenStage({required this.specimen, required this.density});

  final _SctSpecimen specimen;
  final double density;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(color: _kPaper),
      foregroundDecoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Color(0x00000000), Color(0x10000000)],
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 96,
            height: 122,
            decoration: BoxDecoration(
              color: _kStoneLight,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: _kStoneDark, width: 1),
            ),
            alignment: Alignment.center,
            child: _SctLiveWidgetFor(specimen: specimen),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  specimen.tagline,
                  style: const TextStyle(
                    color: _kInk,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: specimen.accent.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Text(
                    'category · ${specimen.category}',
                    style: TextStyle(
                      color: specimen.accent,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.4,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  specimen.useWhen,
                  style: TextStyle(
                    color: _kInk.withValues(alpha: 0.75),
                    fontSize: 11,
                    height: 1.35,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Per-specimen live rendering. Each widget is hand-styled differently so the
// catalogue reads as a curated set rather than a mechanical grid.
class _SctLiveWidgetFor extends StatelessWidget {
  const _SctLiveWidgetFor({required this.specimen});

  final _SctSpecimen specimen;

  @override
  Widget build(BuildContext context) {
    switch (specimen.type) {
      case StandardComponentType.backButton:
        return _SctStageBackButton();
      case StandardComponentType.closeButton:
        return _SctStageCloseButton();
      case StandardComponentType.moreButton:
        return _SctStageMoreButton();
      case StandardComponentType.drawerButton:
        return _SctStageDrawerButton();
    }
  }
}

class _SctStageBackButton extends StatelessWidget {
  const _SctStageBackButton();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 72,
          height: 36,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: _kNavy,
            borderRadius: BorderRadius.circular(4),
          ),
          child: BackButton(
            color: _kMustard,
            key: StandardComponentType.backButton.key,
            onPressed: () => debugPrint('[Sct] BackButton pressed'),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'BackButton',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
            color: _kNavy,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}

class _SctStageCloseButton extends StatelessWidget {
  const _SctStageCloseButton();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 72,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _kPaper,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: _kRust, width: 1),
          ),
          child: CloseButton(
            color: _kRust,
            key: StandardComponentType.closeButton.key,
            onPressed: () => debugPrint('[Sct] CloseButton pressed'),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'CloseButton',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
            color: _kRust,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}

class _SctStageMoreButton extends StatelessWidget {
  const _SctStageMoreButton();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 72,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _kStoneLight,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: _kNavy, width: 1),
          ),
          child: PopupMenuButton<String>(
            key: StandardComponentType.moreButton.key,
            icon: const Icon(Icons.more_vert_rounded, color: _kNavy),
            itemBuilder: (BuildContext context) => const <PopupMenuEntry<String>>[
              PopupMenuItem<String>(value: 'rename', child: Text('Rename')),
              PopupMenuItem<String>(value: 'duplicate', child: Text('Duplicate')),
              PopupMenuItem<String>(value: 'delete', child: Text('Delete')),
            ],
            onSelected: (String v) => debugPrint('[Sct] MoreButton -> $v'),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'PopupMenuButton',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
            color: _kNavy,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}

class _SctStageDrawerButton extends StatelessWidget {
  const _SctStageDrawerButton();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 72,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _kNavyDeep,
            borderRadius: BorderRadius.circular(4),
          ),
          child: IconButton(
            key: StandardComponentType.drawerButton.key,
            icon: const Icon(Icons.menu_rounded),
            color: _kMustardDeep,
            tooltip: 'Open navigation drawer',
            onPressed: () => debugPrint('[Sct] DrawerButton pressed'),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'DrawerButton',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
            color: _kMustardDeep,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}

class _SctSpecimenFooter extends StatelessWidget {
  const _SctSpecimenFooter({required this.specimen});

  final _SctSpecimen specimen;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 10),
      decoration: const BoxDecoration(
        color: _kStoneLight,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
        border: Border(top: BorderSide(color: _kStoneDark, width: 1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            'KEY',
            style: TextStyle(
              color: _kNavySoft,
              fontSize: 9,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.6,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              'ValueKey(${specimen.type})',
              style: const TextStyle(
                color: _kNavy,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Icon(Icons.key_rounded, color: specimen.accent, size: 14),
        ],
      ),
    );
  }
}

// (grid-paper background is drawn via foregroundDecoration on the stage)

// ---------------------------------------------------------------------------
// Lookup table panel — quoted code showing how design-system helpers map
// enum values to widget factories.
// ---------------------------------------------------------------------------

class _SctLookupTable extends StatelessWidget {
  const _SctLookupTable();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SctSectionHeader(
            number: '§ 02',
            title: 'LOOKUP TABLE',
            subtitle:
                'How ComponentTypeLookup / GetStandardComponent map each '
                'enum value to its canonical widget factory. The key '
                'machinery is the ValueKey exposed by '
                'StandardComponentType.key.',
          ),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              color: _kNavyDeep,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _kMustard, width: 1.4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                  decoration: const BoxDecoration(
                    color: _kNavy,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: _kMustard,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'lib/design_system/component_type_lookup.dart',
                        style: TextStyle(
                          color: _kStone,
                          fontSize: 12,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'DART · read-only',
                        style: TextStyle(
                          color: _kMustard,
                          fontSize: 10,
                          fontFamily: 'monospace',
                          letterSpacing: 1.6,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(14, 12, 14, 14),
                  child: _SctCodeBlock(
                    lines: <_SctCodeLine>[
                      _SctCodeLine(' 1', 'typedef WidgetBuilder0 = '
                          'Widget Function();', _SctTone.keyword),
                      _SctCodeLine(' 2', '', _SctTone.plain),
                      _SctCodeLine(' 3',
                          'class ComponentTypeLookup {', _SctTone.keyword),
                      _SctCodeLine(' 4',
                          '  static final Map<StandardComponentType, '
                              'WidgetBuilder0> _factories =', _SctTone.plain),
                      _SctCodeLine(' 5',
                          '      <StandardComponentType, WidgetBuilder0>{',
                          _SctTone.plain),
                      _SctCodeLine(' 6',
                          '        StandardComponentType.backButton: '
                              '() => const BackButton(),', _SctTone.entry),
                      _SctCodeLine(' 7',
                          '        StandardComponentType.closeButton: '
                              '() => const CloseButton(),', _SctTone.entry),
                      _SctCodeLine(' 8',
                          '        StandardComponentType.moreButton: '
                              '() => _defaultMoreButton(),', _SctTone.entry),
                      _SctCodeLine(' 9',
                          '        StandardComponentType.drawerButton: '
                              '() => const DrawerButton(),', _SctTone.entry),
                      _SctCodeLine('10',
                          '      };', _SctTone.plain),
                      _SctCodeLine('11', '', _SctTone.plain),
                      _SctCodeLine('12',
                          '  static Widget getStandardComponent(',
                          _SctTone.keyword),
                      _SctCodeLine('13',
                          '      StandardComponentType type, {', _SctTone.plain),
                      _SctCodeLine('14',
                          '      WidgetBuilder0? override,', _SctTone.plain),
                      _SctCodeLine('15',
                          '    }) {', _SctTone.plain),
                      _SctCodeLine('16',
                          '    final WidgetBuilder0 builder =', _SctTone.plain),
                      _SctCodeLine('17',
                          '        override ?? _factories[type]!;',
                          _SctTone.plain),
                      _SctCodeLine('18',
                          '    return KeyedSubtree(', _SctTone.plain),
                      _SctCodeLine('19',
                          '      key: type.key, // ValueKey<StandardComponentType>',
                          _SctTone.entry),
                      _SctCodeLine('20',
                          '      child: builder(),', _SctTone.plain),
                      _SctCodeLine('21',
                          '    );', _SctTone.plain),
                      _SctCodeLine('22', '  }', _SctTone.plain),
                      _SctCodeLine('23', '}', _SctTone.keyword),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kStoneLight,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: _kStoneDark, width: 1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Icon(Icons.lightbulb_outline_rounded,
                    color: _kMustardDeep, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'The entry `type.key` is what lets find.backButton() in '
                    'widget tests locate an instance reliably — regardless of '
                    'whether the concrete widget is BackButton, an IconButton '
                    'with a custom icon, or a brand-specific override '
                    'registered through the design system.',
                    style: TextStyle(
                      color: _kInk.withValues(alpha: 0.78),
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

enum _SctTone { plain, keyword, entry }

class _SctCodeLine {
  const _SctCodeLine(this.ln, this.code, this.tone);
  final String ln;
  final String code;
  final _SctTone tone;
}

class _SctCodeBlock extends StatelessWidget {
  const _SctCodeBlock({required this.lines});

  final List<_SctCodeLine> lines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (final _SctCodeLine l in lines)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 30,
                  child: Text(
                    l.ln,
                    style: TextStyle(
                      color: _kMustard.withValues(alpha: 0.55),
                      fontSize: 11,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l.code,
                    style: TextStyle(
                      color: _toneColor(l.tone),
                      fontSize: 12,
                      fontFamily: 'monospace',
                      height: 1.35,
                      fontWeight: l.tone == _SctTone.keyword
                          ? FontWeight.w800
                          : FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Color _toneColor(_SctTone tone) {
    switch (tone) {
      case _SctTone.plain:
        return _kStone;
      case _SctTone.keyword:
        return _kMustardPale;
      case _SctTone.entry:
        return _kMustard;
    }
  }
}

// ---------------------------------------------------------------------------
// Accordion section — one ExpansionTile per enum value with deeper detail.
// ---------------------------------------------------------------------------

class _SctAccordionSection extends StatelessWidget {
  const _SctAccordionSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SctSectionHeader(
            number: '§ 03',
            title: 'DETAIL SHEETS',
            subtitle:
                'Fold-out description, alternatives, and long-form examples '
                'for each value. Anchored to its part number for easy '
                'cross-reference.',
          ),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              color: _kStoneLight,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _kStoneDark, width: 1),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: _kStoneDark,
                unselectedWidgetColor: _kNavySoft,
                iconTheme: const IconThemeData(color: _kNavy),
                listTileTheme: const ListTileThemeData(
                  iconColor: _kNavy,
                  textColor: _kInk,
                ),
              ),
              child: Column(
                children: <Widget>[
                  for (int i = 0; i < _kSpecimens.length; i++)
                    _SctDetailTile(
                      specimen: _kSpecimens[i],
                      index: i,
                      isLast: i == _kSpecimens.length - 1,
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

class _SctDetailTile extends StatelessWidget {
  const _SctDetailTile({
    required this.specimen,
    required this.index,
    required this.isLast,
  });

  final _SctSpecimen specimen;
  final int index;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isLast ? Colors.transparent : _kStoneDark,
            width: 1,
          ),
        ),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
        collapsedIconColor: specimen.accent,
        iconColor: specimen.accent,
        initiallyExpanded: index == 0,
        title: Row(
          children: <Widget>[
            Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: specimen.accent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(specimen.glyph, size: 18, color: _kNavyDeep),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '${specimen.partNumber}  ·  ${specimen.humanName}',
                  style: const TextStyle(
                    color: _kNavy,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'StandardComponentType.${specimen.enumName}',
                  style: TextStyle(
                    color: specimen.accent,
                    fontSize: 11,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            specimen.tagline,
            style: TextStyle(
              color: _kInk.withValues(alpha: 0.62),
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        children: <Widget>[
          _SctDetailField(
            label: 'DESCRIPTION',
            value:
                '${specimen.humanName} is the canonical representation of '
                'StandardComponentType.${specimen.enumName}. It carries the '
                'ValueKey returned by .key, which makes it individually '
                'locatable by the Flutter testing infrastructure and by '
                'any design-system lookup table that maps enum values to '
                'widgets.',
          ),
          _SctDetailField(label: 'WHEN TO USE', value: specimen.useWhen),
          _SctDetailField(
            label: 'ALTERNATIVE WIDGETS',
            valueWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (final String alt in specimen.alternatives)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 5,
                          height: 5,
                          margin: const EdgeInsets.only(top: 6, right: 8),
                          decoration: BoxDecoration(
                            color: specimen.accent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            alt,
                            style: const TextStyle(
                              color: _kInk,
                              fontSize: 12,
                              height: 1.35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          _SctDetailField(
            label: 'ANCHOR',
            valueWidget: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _kNavyDeep,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Icon(Icons.anchor_rounded,
                      size: 12, color: _kMustard),
                  const SizedBox(width: 6),
                  Text(
                    '#${specimen.partNumber.toLowerCase()}-example',
                    style: const TextStyle(
                      color: _kMustardPale,
                      fontSize: 11,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          _SctLongExample(specimen: specimen),
        ],
      ),
    );
  }
}

class _SctDetailField extends StatelessWidget {
  const _SctDetailField({required this.label, this.value, this.valueWidget});

  final String label;
  final String? value;
  final Widget? valueWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                color: _kNavySoft,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.8,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: valueWidget ??
                Text(
                  value ?? '',
                  style: const TextStyle(
                    color: _kInk,
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

class _SctLongExample extends StatelessWidget {
  const _SctLongExample({required this.specimen});

  final _SctSpecimen specimen;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: _kPaper,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: specimen.accent, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.code_rounded, size: 14, color: specimen.accent),
              const SizedBox(width: 6),
              Text(
                'LONG-FORM EXAMPLE · ${specimen.partNumber}',
                style: TextStyle(
                  color: specimen.accent,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.8,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _SctExampleBodyFor(specimen: specimen),
        ],
      ),
    );
  }
}

class _SctExampleBodyFor extends StatelessWidget {
  const _SctExampleBodyFor({required this.specimen});

  final _SctSpecimen specimen;

  @override
  Widget build(BuildContext context) {
    switch (specimen.type) {
      case StandardComponentType.backButton:
        return const _SctExampleBack();
      case StandardComponentType.closeButton:
        return const _SctExampleClose();
      case StandardComponentType.moreButton:
        return const _SctExampleMore();
      case StandardComponentType.drawerButton:
        return const _SctExampleDrawer();
    }
  }
}

class _SctExampleBack extends StatelessWidget {
  const _SctExampleBack();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'AppBar(\n'
      '  leading: BackButton(\n'
      '    key: StandardComponentType.backButton.key, // ValueKey\n'
      '    onPressed: () => Navigator.of(context).maybePop(),\n'
      '  ),\n'
      '  title: Text(\'Detail\'),\n'
      ')',
      style: TextStyle(
        color: _kInk,
        fontSize: 12,
        fontFamily: 'monospace',
        height: 1.45,
      ),
    );
  }
}

class _SctExampleClose extends StatelessWidget {
  const _SctExampleClose();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'showDialog<void>(\n'
      '  context: context,\n'
      '  builder: (_) => AlertDialog(\n'
      '    actions: [\n'
      '      CloseButton(\n'
      '        key: StandardComponentType.closeButton.key,\n'
      '      ),\n'
      '    ],\n'
      '  ),\n'
      ');',
      style: TextStyle(
        color: _kInk,
        fontSize: 12,
        fontFamily: 'monospace',
        height: 1.45,
      ),
    );
  }
}

class _SctExampleMore extends StatelessWidget {
  const _SctExampleMore();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'AppBar(\n'
      '  actions: [\n'
      '    PopupMenuButton<String>(\n'
      '      key: StandardComponentType.moreButton.key,\n'
      '      itemBuilder: (_) => [\n'
      '        PopupMenuItem(value: \'rename\', child: Text(\'Rename\')),\n'
      '        PopupMenuItem(value: \'delete\', child: Text(\'Delete\')),\n'
      '      ],\n'
      '    ),\n'
      '  ],\n'
      ')',
      style: TextStyle(
        color: _kInk,
        fontSize: 12,
        fontFamily: 'monospace',
        height: 1.45,
      ),
    );
  }
}

class _SctExampleDrawer extends StatelessWidget {
  const _SctExampleDrawer();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Scaffold(\n'
      '  appBar: AppBar(\n'
      '    leading: DrawerButton(\n'
      '      key: StandardComponentType.drawerButton.key,\n'
      '    ),\n'
      '  ),\n'
      '  drawer: const Drawer(child: SizedBox.shrink()),\n'
      ')',
      style: TextStyle(
        color: _kInk,
        fontSize: 12,
        fontFamily: 'monospace',
        height: 1.45,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Pitfall card — clarifies the intended scope of StandardComponentType.
// ---------------------------------------------------------------------------

class _SctPitfallCard extends StatelessWidget {
  const _SctPitfallCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: _kRust.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: _kRust, width: 1.4),
        ),
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: _kRust,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.report_gmailerrorred_rounded,
                color: _kPaper,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'PITFALL · don\'t over-apply',
                    style: TextStyle(
                      color: _kRust,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2.4,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'StandardComponentType is for design-system overrides '
                    '— not for app-level widget selection.',
                    style: TextStyle(
                      color: _kInk,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'The enum exists so a design system can publish one '
                    'swap-point per standard component — and so widget '
                    'tests can find those components reliably. In ordinary '
                    'app code you should just use the widget directly '
                    '(BackButton, CloseButton, PopupMenuButton, '
                    'DrawerButton) rather than routing every construction '
                    'through ComponentTypeLookup.',
                    style: TextStyle(
                      color: _kInk.withValues(alpha: 0.78),
                      fontSize: 12.5,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: const <Widget>[
                      _SctPitfallChip(
                        label: 'DO · attach .key on design-system widgets',
                        positive: true,
                      ),
                      _SctPitfallChip(
                        label: 'DO · use in widget tests via find.*',
                        positive: true,
                      ),
                      _SctPitfallChip(
                        label: 'DON\'T · select arbitrary app widgets',
                        positive: false,
                      ),
                      _SctPitfallChip(
                        label: 'DON\'T · use as a runtime DI container',
                        positive: false,
                      ),
                    ],
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

class _SctPitfallChip extends StatelessWidget {
  const _SctPitfallChip({required this.label, required this.positive});

  final String label;
  final bool positive;

  @override
  Widget build(BuildContext context) {
    final Color color = positive ? _kNavy : _kRust;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: color, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            positive ? Icons.check_rounded : Icons.close_rounded,
            size: 13,
            color: color,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Footnotes — colophon-style trailing rows.
// ---------------------------------------------------------------------------

class _SctFootnotes extends StatelessWidget {
  const _SctFootnotes();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(height: 1, color: _kStoneDark),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'COLOPHON',
                      style: TextStyle(
                        color: _kMustardDeep,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.4,
                        fontFamily: 'monospace',
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Set in Navy #0F2A44 and Mustard #D4A935 on Paper #FBF7EE. '
                      'All specimens are live Material widgets — click them. '
                      'This catalogue is generated from the enum declaration '
                      'in package:flutter/widgets/standard_component_type.dart.',
                      style: TextStyle(color: _kInk, fontSize: 12, height: 1.4),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    const Text(
                      'VOL · IV · 2026',
                      style: TextStyle(
                        color: _kNavy,
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.0,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'StandardComponentType · ${_kSpecimens.length} entries',
                      style: TextStyle(
                        color: _kInk.withValues(alpha: 0.7),
                        fontSize: 11,
                        fontFamily: 'monospace',
                      ),
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

// ---------------------------------------------------------------------------
// Catalogue index — fixed right-edge column with CustomPainter chips for
// each enum value. The currently selected chip is highlighted mustard.
// ---------------------------------------------------------------------------

class _SctCatalogueIndex extends StatelessWidget {
  const _SctCatalogueIndex({
    required this.selectedIndex,
    required this.pulseController,
    required this.onTap,
  });

  final int selectedIndex;
  final AnimationController pulseController;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      decoration: const BoxDecoration(
        color: _kNavyDeep,
        border: Border(
          left: BorderSide(color: _kMustard, width: 2),
        ),
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 18),
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: _kMustard,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.menu_book_rounded,
              color: _kNavyDeep,
              size: 22,
            ),
          ),
          const SizedBox(height: 10),
          const RotatedBox(
            quarterTurns: 3,
            child: Text(
              'CATALOGUE INDEX',
              style: TextStyle(
                color: _kMustard,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 3.2,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: AnimatedBuilder(
              animation: pulseController,
              builder: (BuildContext context, Widget? child) {
                return SizedBox.expand(
                  child: CustomPaint(
                    painter: _SctIndexPainter(
                      selectedIndex: selectedIndex,
                      pulse: pulseController.value,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        for (int i = 0; i < _kSpecimens.length; i++)
                          Expanded(
                            child: InkWell(
                              onTap: () => onTap(i),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      _kSpecimens[i].partNumber,
                                      style: TextStyle(
                                        color: i == selectedIndex
                                            ? _kNavyDeep
                                            : _kStone,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'monospace',
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      _kSpecimens[i].enumName,
                                      style: TextStyle(
                                        color: i == selectedIndex
                                            ? _kNavyDeep
                                            : _kMustardPale
                                                .withValues(alpha: 0.8),
                                        fontSize: 9,
                                        fontFamily: 'monospace',
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 14),
          Text(
            math.min(selectedIndex + 1, _kSpecimens.length)
                .toString()
                .padLeft(2, '0'),
            style: const TextStyle(
              color: _kMustard,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              fontFamily: 'monospace',
            ),
          ),
          Text(
            '/ ${_kSpecimens.length.toString().padLeft(2, '0')}',
            style: TextStyle(
              color: _kStone.withValues(alpha: 0.7),
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _SctIndexPainter extends CustomPainter {
  _SctIndexPainter({required this.selectedIndex, required this.pulse});

  final int selectedIndex;
  final double pulse;

  @override
  void paint(Canvas canvas, Size size) {
    final int count = _kSpecimens.length;
    final double cellHeight = size.height / count;
    for (int i = 0; i < count; i++) {
      final bool selected = i == selectedIndex;
      final Rect rect = Rect.fromLTWH(
        6,
        i * cellHeight + 4,
        size.width - 12,
        cellHeight - 8,
      );
      final RRect rrect = RRect.fromRectAndRadius(
        rect,
        const Radius.circular(3),
      );
      final Paint fill = Paint()
        ..color = selected
            ? _kMustard
            : _kNavy.withValues(alpha: 0.55);
      canvas.drawRRect(rrect, fill);
      if (selected) {
        final Paint glow = Paint()
          ..color = _kMustardPale.withValues(alpha: 0.35 + 0.25 * pulse)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
        canvas.drawRRect(
          rrect.inflate(2 + 2 * pulse),
          glow,
        );
      }
      // Left accent bar.
      final Paint accent = Paint()..color = _kSpecimens[i].accent;
      canvas.drawRect(
        Rect.fromLTWH(rect.left, rect.top, 3, rect.height),
        accent,
      );
      // Tick marks along the right edge to make it look like a binder.
      final Paint tick = Paint()
        ..color = _kStone.withValues(alpha: selected ? 0.8 : 0.25)
        ..strokeWidth = 1;
      for (double y = rect.top + 4; y < rect.bottom - 2; y += 5) {
        canvas.drawLine(
          Offset(rect.right - 4, y),
          Offset(rect.right - 1, y),
          tick,
        );
      }
    }

    // Vertical spine down the middle.
    final Paint spine = Paint()
      ..color = _kMustard.withValues(alpha: 0.3)
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(size.width - 2, 0),
      Offset(size.width - 2, size.height),
      spine,
    );
  }

  @override
  bool shouldRepaint(covariant _SctIndexPainter oldDelegate) =>
      oldDelegate.selectedIndex != selectedIndex ||
      oldDelegate.pulse != pulse;
}

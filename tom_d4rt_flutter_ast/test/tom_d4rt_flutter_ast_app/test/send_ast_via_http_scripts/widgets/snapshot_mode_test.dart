// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// SnapshotMode — Darkroom Gallery (rev 2)
// ---------------------------------------------------------------------------
// This hand-authored demo is the long-form companion to the SDK's
// `SnapshotMode` enum and `SnapshotWidget`. Both are live citizens here:
//
//   * `SnapshotMode.permissive`, `SnapshotMode.normal`, `SnapshotMode.forced`
//     are referenced in switch arms, equality checks, and parameter passing.
//   * `SnapshotWidget` instances are constructed with EACH enum value and
//     mounted in the widget tree, backed by a real `SnapshotController`.
//
// The visual metaphor is a 1960s photography darkroom lit by an amber
// safelight: film strips, enlarger lenses, developing baths. Every panel in
// the gallery corresponds to one aspect of the enum: the hero reel animates
// the act of capturing a snapshot, the side-by-side cells show how each mode
// reacts to a filter-heavy child, and the comparison painter annotates the
// three film frames with plain-language meaning.
//
// This file is executed by the d4rt AST harness, so there is no `main()` and
// no `runApp()`. The top-level `build` function returns a MaterialApp.
// ---------------------------------------------------------------------------

// ---- Palette --------------------------------------------------------------

const Color _kSmodeAmber = Color(0xFFF6B93B);
const Color _kSmodeAmberDeep = Color(0xFFD4922A);
const Color _kSmodeAmberGlow = Color(0xFFFFD27A);
const Color _kSmodeCharcoal = Color(0xFF1E1E24);
const Color _kSmodeCharcoalSoft = Color(0xFF2A2A32);
const Color _kSmodeCharcoalDeep = Color(0xFF14141A);
const Color _kSmodeLens = Color(0xFFCBD3DA);
const Color _kSmodeLensDim = Color(0xFF8C939A);
const Color _kSmodeEmulsion = Color(0xFFEFE2C4);
const Color _kSmodeDanger = Color(0xFFE45E5E);
const Color _kSmodeSafe = Color(0xFF7FBE7A);
const Color _kSmodeWarn = Color(0xFFE6B85C);
const Color _kSmodeBorder = Color(0xFF3A3A44);
const Color _kSmodeBorderHi = Color(0xFF5A5A68);
const Color _kSmodeFilm = Color(0xFF101015);
const Color _kSmodeRedSafelight = Color(0xFF7A1818);

// ---- Mode descriptor (live SnapshotMode usage) ----------------------------

class _SmodeInfo {
  const _SmodeInfo({
    required this.mode,
    required this.title,
    required this.subtitle,
    required this.shortLabel,
    required this.icon,
    required this.accent,
    required this.tint,
    required this.summary,
    required this.behaviour,
    required this.useCase,
    required this.warning,
  });

  final SnapshotMode mode;
  final String title;
  final String subtitle;
  final String shortLabel;
  final IconData icon;
  final Color accent;
  final Color tint;
  final String summary;
  final String behaviour;
  final String useCase;
  final String warning;
}

_SmodeInfo _smodeInfoFor(SnapshotMode mode) {
  // Live switch on SnapshotMode — each arm references a different constant.
  switch (mode) {
    case SnapshotMode.permissive:
      return const _SmodeInfo(
        mode: SnapshotMode.permissive,
        title: 'Permissive',
        subtitle: 'Snapshot when you can — fall back when you cannot.',
        shortLabel: 'PRM',
        icon: Icons.filter_drama_outlined,
        accent: _kSmodeSafe,
        tint: Color(0xFF1F2A1F),
        summary:
            'The child is rasterized into a snapshot whenever the subtree '
            'permits it. If a descendant cannot be captured cleanly (for '
            'example, a platform view), the SnapshotWidget silently paints '
            'the un-snapshotted child instead of throwing.',
        behaviour:
            'No exception is raised when capture fails. Painting falls back '
            'to the live tree.',
        useCase:
            'Choose this mode for opportunistic optimisations where the '
            'snapshot is a perf win when available and the live tree is a '
            'perfectly acceptable Plan B.',
        warning:
            'You may not notice if the snapshot is being silently bypassed; '
            'measure actual frame timings to confirm gains.',
      );
    case SnapshotMode.normal:
      return const _SmodeInfo(
        mode: SnapshotMode.normal,
        title: 'Normal',
        subtitle: 'The default — strict, predictable, vocal on failure.',
        shortLabel: 'NRM',
        icon: Icons.tune_rounded,
        accent: _kSmodeAmber,
        tint: Color(0xFF2A2418),
        summary:
            'The child must be snapshottable. If the subtree contains a '
            'platform view or other un-snapshottable element, the framework '
            'throws a flutter error instead of silently degrading.',
        behaviour:
            'Throws on failure. Encourages you to design subtrees that are '
            'fully rasterizable.',
        useCase:
            'Use during development to catch regressions, or in production '
            'where the subtree is known to be free of platform views.',
        warning:
            'Crashes if you slip a platform view into the subtree later. '
            'Prefer Permissive when the subtree contents are dynamic.',
      );
    case SnapshotMode.forced:
      return const _SmodeInfo(
        mode: SnapshotMode.forced,
        title: 'Forced',
        subtitle: 'Always snapshot — ignore platform views completely.',
        shortLabel: 'FRC',
        icon: Icons.flash_on_rounded,
        accent: _kSmodeWarn,
        tint: Color(0xFF2A2614),
        summary:
            'The child is always snapshotted. Any platform views inside the '
            'subtree are NOT painted in the snapshot, even when present. '
            'The visual result may diverge from the live tree.',
        behaviour:
            'Never throws and never falls back. The snapshot wins regardless '
            'of subtree contents.',
        useCase:
            'Useful for short transitions where you knowingly want to hide a '
            'platform view inside an otherwise raster-based animation.',
        warning:
            'Surprising visual gaps if a platform view is present and you '
            'forgot. Audit subtree carefully before using.',
      );
  }
}

bool _smodeIsPermissive(SnapshotMode mode) => mode == SnapshotMode.permissive;
bool _smodeIsNormal(SnapshotMode mode) => mode == SnapshotMode.normal;
bool _smodeIsForced(SnapshotMode mode) => mode == SnapshotMode.forced;

int _smodeOrdinal(SnapshotMode mode) {
  switch (mode) {
    case SnapshotMode.permissive:
      return 0;
    case SnapshotMode.normal:
      return 1;
    case SnapshotMode.forced:
      return 2;
  }
}

String _smodeFilmCode(SnapshotMode mode) {
  switch (mode) {
    case SnapshotMode.permissive:
      return 'F-001 / PRM';
    case SnapshotMode.normal:
      return 'F-002 / NRM';
    case SnapshotMode.forced:
      return 'F-003 / FRC';
  }
}

// All enum values, in display order. Iterated by several panels below to
// drive grids and rows.
const List<SnapshotMode> _kAllSmodes = <SnapshotMode>[
  SnapshotMode.permissive,
  SnapshotMode.normal,
  SnapshotMode.forced,
];

// ---- Entry point ----------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SnapshotMode — Darkroom Gallery',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _kSmodeCharcoal,
      colorScheme: const ColorScheme.dark(
        primary: _kSmodeAmber,
        secondary: _kSmodeAmberGlow,
        surface: _kSmodeCharcoalSoft,
      ),
      fontFamily: 'monospace',
    ),
    home: const _SmodeHome(),
  );
}

// ---- Home shell -----------------------------------------------------------

class _SmodeHome extends StatelessWidget {
  const _SmodeHome();

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;
    final bool desktopHint = platform == TargetPlatform.linux ||
        platform == TargetPlatform.macOS ||
        platform == TargetPlatform.windows;

    return Scaffold(
      backgroundColor: _kSmodeCharcoal,
      // D4rt workaround (§P1): _SmodeAppBar is a user StatelessWidget that
      // implements PreferredSizeWidget, but D4rt sees only the StatelessWidget
      // base type and rejects the Scaffold.appBar PreferredSizeWidget? slot.
      // Wrap the child in PreferredSize so the outer type is concrete.
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(88),
        child: _SmodeAppBar(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _SmodeIntroPanel(),
              const SizedBox(height: 22),
              const _SmodeHeroReel(),
              const SizedBox(height: 26),
              const _SmodeTriptychPanel(),
              const SizedBox(height: 26),
              const _SmodePermissiveShowcase(),
              const SizedBox(height: 22),
              const _SmodeNormalShowcase(),
              const SizedBox(height: 22),
              const _SmodeForcedShowcase(),
              const SizedBox(height: 26),
              const _SmodeIteratedGrid(),
              const SizedBox(height: 26),
              const _SmodeComparisonTable(),
              const SizedBox(height: 26),
              const _SmodeBehaviourLedger(),
              const SizedBox(height: 26),
              const _SmodeControllerBay(),
              const SizedBox(height: 26),
              const _SmodeFilmStrip(),
              const SizedBox(height: 26),
              _SmodeFooter(desktopHint: desktopHint),
            ],
          ),
        ),
      ),
    );
  }
}

// ---- AppBar ---------------------------------------------------------------

class _SmodeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _SmodeAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(88);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: _kSmodeCharcoalDeep,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 88,
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const _SmodeShutterIndicator(),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'DARKROOM // SnapshotMode',
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 1.6,
                      fontWeight: FontWeight.w700,
                      color: _kSmodeAmberGlow,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'rasterize · degrade · enforce — pick your shutter',
                    style: TextStyle(
                      fontSize: 11,
                      color: _kSmodeLensDim,
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
            ),
            const _SmodeAppBarBadge(label: 'PRM'),
            const SizedBox(width: 6),
            const _SmodeAppBarBadge(label: 'NRM'),
            const SizedBox(width: 6),
            const _SmodeAppBarBadge(label: 'FRC'),
          ],
        ),
      ),
    );
  }
}

class _SmodeShutterIndicator extends StatelessWidget {
  const _SmodeShutterIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: _kSmodeRedSafelight.withOpacity(0.20),
        shape: BoxShape.circle,
        border: Border.all(color: _kSmodeAmberDeep, width: 1.5),
        gradient: RadialGradient(
          colors: <Color>[
            _kSmodeRedSafelight.withOpacity(0.40),
            _kSmodeLens.withOpacity(0.05),
          ],
        ),
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.lens_blur_rounded,
        color: _kSmodeAmberGlow,
        size: 22,
      ),
    );
  }
}

class _SmodeAppBarBadge extends StatelessWidget {
  const _SmodeAppBarBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _kSmodeCharcoalSoft,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: _kSmodeBorder),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 10,
          letterSpacing: 1.2,
          color: _kSmodeAmber,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ---- Intro panel ----------------------------------------------------------

class _SmodeIntroPanel extends StatelessWidget {
  const _SmodeIntroPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _kSmodeCharcoalSoft,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSmodeBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.collections_outlined,
                  color: _kSmodeAmberGlow, size: 22),
              const SizedBox(width: 10),
              Text(
                'Three exposures, one negative',
                style: const TextStyle(
                  color: _kSmodeAmberGlow,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'A SnapshotWidget freezes its subtree into a single ui.Image and '
            'paints that image in place of the live widgets. SnapshotMode '
            'tells the widget what to do when freezing is impossible — for '
            'example, when a platform view sits inside the subtree.',
            style: TextStyle(
              color: _kSmodeEmulsion.withOpacity(0.90),
              height: 1.5,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              _SmodeChip(label: 'enum SnapshotMode', tone: _kSmodeAmber),
              _SmodeChip(label: 'class SnapshotWidget', tone: _kSmodeSafe),
              _SmodeChip(label: 'class SnapshotController', tone: _kSmodeWarn),
            ],
          ),
        ],
      ),
    );
  }
}

class _SmodeChip extends StatelessWidget {
  const _SmodeChip({required this.label, required this.tone});

  final String label;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: tone.withOpacity(0.12),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: tone.withOpacity(0.55)),
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
    );
  }
}

// ---- Hero reel ------------------------------------------------------------

class _SmodeHeroReel extends StatelessWidget {
  const _SmodeHeroReel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            _kSmodeCharcoalSoft,
            _kSmodeCharcoalDeep,
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSmodeBorderHi),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SmodeSectionHeader(
            title: 'Hero Reel',
            subtitle: 'Three frames, one for every SnapshotMode',
            icon: Icons.movie_filter_outlined,
          ),
          const SizedBox(height: 16),
          // Each cell mounts a real SnapshotWidget with a different mode.
          Row(
            children: <Widget>[
              Expanded(child: _SmodeReelCell(mode: SnapshotMode.permissive)),
              const SizedBox(width: 12),
              Expanded(child: _SmodeReelCell(mode: SnapshotMode.normal)),
              const SizedBox(width: 12),
              Expanded(child: _SmodeReelCell(mode: SnapshotMode.forced)),
            ],
          ),
        ],
      ),
    );
  }
}

class _SmodeReelCell extends StatefulWidget {
  const _SmodeReelCell({required this.mode});

  final SnapshotMode mode;

  @override
  State<_SmodeReelCell> createState() => _SmodeReelCellState();
}

class _SmodeReelCellState extends State<_SmodeReelCell> {
  late final SnapshotController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SnapshotController(allowSnapshotting: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _SmodeInfo info = _smodeInfoFor(widget.mode);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: info.tint,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: info.accent.withOpacity(0.55), width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(info.icon, color: info.accent, size: 18),
              const SizedBox(width: 8),
              Text(
                info.title,
                style: TextStyle(
                  color: info.accent,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
              const Spacer(),
              _SmodeModeBadge(mode: widget.mode),
            ],
          ),
          const SizedBox(height: 10),
          // *** Live SnapshotWidget construction with widget.mode ***
          SnapshotWidget(
            controller: _controller,
            mode: widget.mode,
            autoresize: true,
            child: _SmodeReelArtwork(info: info),
          ),
          const SizedBox(height: 10),
          Text(
            info.subtitle,
            style: TextStyle(
              color: _kSmodeEmulsion.withOpacity(0.85),
              fontSize: 11,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _SmodeReelArtwork extends StatelessWidget {
  const _SmodeReelArtwork({required this.info});

  final _SmodeInfo info;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: _kSmodeCharcoalDeep,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _kSmodeBorder),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Center(
            child: Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: info.accent.withOpacity(0.18),
                shape: BoxShape.circle,
                border: Border.all(color: info.accent, width: 2),
              ),
              alignment: Alignment.center,
              child: Icon(info.icon, color: info.accent, size: 28),
            ),
          ),
          Positioned(
            left: 6,
            top: 6,
            child: _SmodeFilmCornerStamp(
              code: _smodeFilmCode(info.mode),
              color: info.accent,
            ),
          ),
          Positioned(
            right: 6,
            bottom: 6,
            child: _SmodeFilmCornerStamp(
              code: 'IDX ${_smodeOrdinal(info.mode)}',
              color: info.accent,
            ),
          ),
        ],
      ),
    );
  }
}

class _SmodeFilmCornerStamp extends StatelessWidget {
  const _SmodeFilmCornerStamp({required this.code, required this.color});

  final String code;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: _kSmodeCharcoal,
        border: Border.all(color: color.withOpacity(0.55)),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        code,
        style: TextStyle(
          color: color,
          fontSize: 8,
          letterSpacing: 0.8,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ---- Mode badge -----------------------------------------------------------

class _SmodeModeBadge extends StatelessWidget {
  const _SmodeModeBadge({required this.mode});

  final SnapshotMode mode;

  @override
  Widget build(BuildContext context) {
    final _SmodeInfo info = _smodeInfoFor(mode);
    final IconData glyph;
    if (_smodeIsPermissive(mode)) {
      glyph = Icons.handshake_outlined;
    } else if (_smodeIsNormal(mode)) {
      glyph = Icons.shield_outlined;
    } else {
      glyph = Icons.bolt_rounded;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: info.accent.withOpacity(0.14),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: info.accent.withOpacity(0.55)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(glyph, color: info.accent, size: 11),
          const SizedBox(width: 4),
          Text(
            info.shortLabel,
            style: TextStyle(
              color: info.accent,
              fontSize: 9,
              letterSpacing: 0.8,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ---- Section header -------------------------------------------------------

class _SmodeSectionHeader extends StatelessWidget {
  const _SmodeSectionHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    const Color tint = _kSmodeAmberGlow;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: tint, size: 22),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: tint,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  color: _kSmodeLensDim,
                  fontSize: 11,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---- Triptych panel -------------------------------------------------------

class _SmodeTriptychPanel extends StatefulWidget {
  const _SmodeTriptychPanel();

  @override
  State<_SmodeTriptychPanel> createState() => _SmodeTriptychPanelState();
}

class _SmodeTriptychPanelState extends State<_SmodeTriptychPanel> {
  late final SnapshotController _permissiveCtl;
  late final SnapshotController _normalCtl;
  late final SnapshotController _forcedCtl;

  @override
  void initState() {
    super.initState();
    _permissiveCtl = SnapshotController(allowSnapshotting: true);
    _normalCtl = SnapshotController(allowSnapshotting: true);
    _forcedCtl = SnapshotController(allowSnapshotting: false);
  }

  @override
  void dispose() {
    _permissiveCtl.dispose();
    _normalCtl.dispose();
    _forcedCtl.dispose();
    super.dispose();
  }

  SnapshotController _controllerFor(SnapshotMode mode) {
    // Live equality checks against every SnapshotMode constant.
    if (mode == SnapshotMode.permissive) {
      return _permissiveCtl;
    } else if (mode == SnapshotMode.normal) {
      return _normalCtl;
    } else if (mode == SnapshotMode.forced) {
      return _forcedCtl;
    }
    return _normalCtl;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _kSmodeCharcoalSoft,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSmodeBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SmodeSectionHeader(
            title: 'Triptych — three modes side by side',
            subtitle: 'Each panel is a real SnapshotWidget bound to a real '
                'SnapshotController.',
            icon: Icons.view_column_outlined,
          ),
          const SizedBox(height: 16),
          for (int i = 0; i < _kAllSmodes.length; i++) ...<Widget>[
            _SmodeTriptychRow(
              mode: _kAllSmodes[i],
              controller: _controllerFor(_kAllSmodes[i]),
            ),
            if (i != _kAllSmodes.length - 1) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _SmodeTriptychRow extends StatelessWidget {
  const _SmodeTriptychRow({
    required this.mode,
    required this.controller,
  });

  final SnapshotMode mode;
  final SnapshotController controller;

  @override
  Widget build(BuildContext context) {
    final _SmodeInfo info = _smodeInfoFor(mode);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: info.tint,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: info.accent.withOpacity(0.40)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Left: SnapshotWidget mounted with this row's mode.
          SizedBox(
            width: 96,
            child: SnapshotWidget(
              controller: controller,
              mode: mode,
              child: _SmodeTriptychTile(info: info),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(info.icon, color: info.accent, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      'SnapshotMode.${_smodeEnumName(mode)}',
                      style: TextStyle(
                        color: info.accent,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const Spacer(),
                    _SmodeModeBadge(mode: mode),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  info.summary,
                  style: TextStyle(
                    color: _kSmodeEmulsion.withOpacity(0.88),
                    fontSize: 11,
                    height: 1.5,
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

class _SmodeTriptychTile extends StatelessWidget {
  const _SmodeTriptychTile({required this.info});

  final _SmodeInfo info;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: _kSmodeFilm,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: info.accent.withOpacity(0.55), width: 1.4),
      ),
      child: Center(
        child: Icon(info.icon, color: info.accent, size: 28),
      ),
    );
  }
}

String _smodeEnumName(SnapshotMode mode) {
  switch (mode) {
    case SnapshotMode.permissive:
      return 'permissive';
    case SnapshotMode.normal:
      return 'normal';
    case SnapshotMode.forced:
      return 'forced';
  }
}

// ---- Permissive showcase --------------------------------------------------

class _SmodePermissiveShowcase extends StatefulWidget {
  const _SmodePermissiveShowcase();

  @override
  State<_SmodePermissiveShowcase> createState() =>
      _SmodePermissiveShowcaseState();
}

class _SmodePermissiveShowcaseState extends State<_SmodePermissiveShowcase> {
  late final SnapshotController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SnapshotController(allowSnapshotting: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const SnapshotMode mode = SnapshotMode.permissive;
    final _SmodeInfo info = _smodeInfoFor(mode);
    return _SmodeShowcaseShell(
      info: info,
      gallery: <Widget>[
        for (int i = 0; i < 3; i++)
          Expanded(
            child: SnapshotWidget(
              controller: _controller,
              mode: mode, // Live: SnapshotMode.permissive
              autoresize: i == 0,
              child: _SmodeShowcaseTile(
                info: info,
                index: i,
              ),
            ),
          ),
      ],
      footnote:
          'Permissive cells silently fall back to the live tree when the '
          'subtree cannot be snapshotted. No exceptions, no drama.',
    );
  }
}

// ---- Normal showcase ------------------------------------------------------

class _SmodeNormalShowcase extends StatefulWidget {
  const _SmodeNormalShowcase();

  @override
  State<_SmodeNormalShowcase> createState() => _SmodeNormalShowcaseState();
}

class _SmodeNormalShowcaseState extends State<_SmodeNormalShowcase> {
  late final SnapshotController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SnapshotController(allowSnapshotting: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const SnapshotMode mode = SnapshotMode.normal;
    final _SmodeInfo info = _smodeInfoFor(mode);
    return _SmodeShowcaseShell(
      info: info,
      gallery: <Widget>[
        for (int i = 0; i < 3; i++)
          Expanded(
            child: SnapshotWidget(
              controller: _controller,
              mode: mode, // Live: SnapshotMode.normal
              child: _SmodeShowcaseTile(
                info: info,
                index: i,
              ),
            ),
          ),
      ],
      footnote:
          'Normal cells throw a flutter error if a platform view sneaks into '
          'the subtree. Use this mode to keep your snapshot promises honest.',
    );
  }
}

// ---- Forced showcase ------------------------------------------------------

class _SmodeForcedShowcase extends StatefulWidget {
  const _SmodeForcedShowcase();

  @override
  State<_SmodeForcedShowcase> createState() => _SmodeForcedShowcaseState();
}

class _SmodeForcedShowcaseState extends State<_SmodeForcedShowcase> {
  late final SnapshotController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SnapshotController(allowSnapshotting: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const SnapshotMode mode = SnapshotMode.forced;
    final _SmodeInfo info = _smodeInfoFor(mode);
    return _SmodeShowcaseShell(
      info: info,
      gallery: <Widget>[
        for (int i = 0; i < 3; i++)
          Expanded(
            child: SnapshotWidget(
              controller: _controller,
              mode: mode, // Live: SnapshotMode.forced
              child: _SmodeShowcaseTile(
                info: info,
                index: i,
              ),
            ),
          ),
      ],
      footnote:
          'Forced cells always paint a snapshot — even if a platform view is '
          'present, the platform view will not appear in the captured image.',
    );
  }
}

// ---- Showcase shell -------------------------------------------------------

class _SmodeShowcaseShell extends StatelessWidget {
  const _SmodeShowcaseShell({
    required this.info,
    required this.gallery,
    required this.footnote,
  });

  final _SmodeInfo info;
  final List<Widget> gallery;
  final String footnote;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _kSmodeCharcoalSoft,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: info.accent.withOpacity(0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: info.accent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: info.accent.withOpacity(0.6)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(info.icon, color: info.accent, size: 14),
                    const SizedBox(width: 6),
                    Text(
                      info.shortLabel,
                      style: TextStyle(
                        color: info.accent,
                        fontSize: 11,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      info.title,
                      style: TextStyle(
                        color: info.accent,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      info.subtitle,
                      style: TextStyle(
                        color: _kSmodeLensDim,
                        fontSize: 11,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(children: <Widget>[
            for (int i = 0; i < gallery.length; i++) ...<Widget>[
              gallery[i],
              if (i != gallery.length - 1) const SizedBox(width: 10),
            ],
          ]),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: _kSmodeCharcoalDeep,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _kSmodeBorder),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.info_outline,
                    color: info.accent.withOpacity(0.8), size: 14),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    footnote,
                    style: TextStyle(
                      color: _kSmodeEmulsion.withOpacity(0.85),
                      fontSize: 11,
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
}

class _SmodeShowcaseTile extends StatelessWidget {
  const _SmodeShowcaseTile({required this.info, required this.index});

  final _SmodeInfo info;
  final int index;

  @override
  Widget build(BuildContext context) {
    final List<IconData> glyphs = <IconData>[
      Icons.photo_camera_outlined,
      Icons.movie_creation_outlined,
      Icons.auto_awesome_outlined,
    ];
    return Container(
      height: 96,
      decoration: BoxDecoration(
        color: info.tint,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: info.accent.withOpacity(0.45)),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Center(
            child: Icon(
              glyphs[index % glyphs.length],
              color: info.accent,
              size: 30,
            ),
          ),
          Positioned(
            left: 6,
            top: 4,
            child: Text(
              '#${index + 1}',
              style: TextStyle(
                color: info.accent.withOpacity(0.7),
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ),
          Positioned(
            right: 6,
            bottom: 4,
            child: Text(
              info.shortLabel,
              style: TextStyle(
                color: info.accent.withOpacity(0.85),
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---- Iterated grid (uses SnapshotMode.values via _kAllSmodes) -------------

class _SmodeIteratedGrid extends StatefulWidget {
  const _SmodeIteratedGrid();

  @override
  State<_SmodeIteratedGrid> createState() => _SmodeIteratedGridState();
}

class _SmodeIteratedGridState extends State<_SmodeIteratedGrid> {
  late final Map<SnapshotMode, SnapshotController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = <SnapshotMode, SnapshotController>{
      for (final SnapshotMode m in _kAllSmodes)
        m: SnapshotController(allowSnapshotting: true),
    };
  }

  @override
  void dispose() {
    for (final SnapshotController c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _kSmodeCharcoalSoft,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSmodeBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SmodeSectionHeader(
            title: 'Mounted grid — every mode, twice',
            subtitle:
                'Six SnapshotWidget instances, each bound to a real controller.',
            icon: Icons.grid_view_outlined,
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              for (final SnapshotMode mode in _kAllSmodes)
                _SmodeIteratedCell(
                  mode: mode,
                  controller: _controllers[mode]!,
                  variant: 'A',
                ),
              for (final SnapshotMode mode in _kAllSmodes)
                _SmodeIteratedCell(
                  mode: mode,
                  controller: _controllers[mode]!,
                  variant: 'B',
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SmodeIteratedCell extends StatelessWidget {
  const _SmodeIteratedCell({
    required this.mode,
    required this.controller,
    required this.variant,
  });

  final SnapshotMode mode;
  final SnapshotController controller;
  final String variant;

  @override
  Widget build(BuildContext context) {
    final _SmodeInfo info = _smodeInfoFor(mode);
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _SmodeModeBadge(mode: mode),
              const Spacer(),
              Text(
                'v$variant',
                style: TextStyle(
                  color: _kSmodeLensDim,
                  fontSize: 10,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Live SnapshotWidget — mounted in a Wrap iterating SnapshotMode.values.
          SnapshotWidget(
            controller: controller,
            mode: mode,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: info.tint,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: info.accent.withOpacity(0.55)),
              ),
              child: Center(
                child: Icon(info.icon, color: info.accent, size: 26),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---- Comparison table -----------------------------------------------------

class _SmodeComparisonTable extends StatelessWidget {
  const _SmodeComparisonTable();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _kSmodeCharcoalSoft,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSmodeBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SmodeSectionHeader(
            title: 'Comparison table',
            subtitle: 'Behaviour matrix when the subtree is un-snapshottable.',
            icon: Icons.table_chart_outlined,
          ),
          const SizedBox(height: 14),
          _buildHeaderRow(),
          const SizedBox(height: 6),
          for (final SnapshotMode mode in _kAllSmodes) _buildRow(mode),
        ],
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: _kSmodeCharcoalDeep,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _kSmodeBorder),
      ),
      child: Row(
        children: const <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              'Mode',
              style: TextStyle(
                color: _kSmodeAmber,
                fontSize: 11,
                letterSpacing: 0.6,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Behaviour',
              style: TextStyle(
                color: _kSmodeAmber,
                fontSize: 11,
                letterSpacing: 0.6,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Best fit',
              style: TextStyle(
                color: _kSmodeAmber,
                fontSize: 11,
                letterSpacing: 0.6,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Throws?',
              style: TextStyle(
                color: _kSmodeAmber,
                fontSize: 11,
                letterSpacing: 0.6,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(SnapshotMode mode) {
    final _SmodeInfo info = _smodeInfoFor(mode);
    final String throwsCol;
    if (_smodeIsNormal(mode)) {
      throwsCol = 'Yes';
    } else if (_smodeIsForced(mode)) {
      throwsCol = 'No';
    } else {
      throwsCol = 'No';
    }
    return Container(
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: info.tint,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: info.accent.withOpacity(0.45)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(info.icon, color: info.accent, size: 14),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    info.title,
                    style: TextStyle(
                      color: info.accent,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              info.behaviour,
              style: TextStyle(
                color: _kSmodeEmulsion.withOpacity(0.88),
                fontSize: 11,
                height: 1.45,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              info.useCase,
              style: TextStyle(
                color: _kSmodeEmulsion.withOpacity(0.85),
                fontSize: 11,
                height: 1.45,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: throwsCol == 'Yes'
                    ? _kSmodeDanger.withOpacity(0.16)
                    : _kSmodeSafe.withOpacity(0.16),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: throwsCol == 'Yes'
                      ? _kSmodeDanger.withOpacity(0.6)
                      : _kSmodeSafe.withOpacity(0.6),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                throwsCol,
                style: TextStyle(
                  color: throwsCol == 'Yes' ? _kSmodeDanger : _kSmodeSafe,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---- Behaviour ledger -----------------------------------------------------

class _SmodeBehaviourLedger extends StatelessWidget {
  const _SmodeBehaviourLedger();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _kSmodeCharcoalSoft,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSmodeBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SmodeSectionHeader(
            title: 'Behaviour ledger',
            subtitle: 'Five rules per mode — when to pick, when to avoid.',
            icon: Icons.menu_book_outlined,
          ),
          const SizedBox(height: 14),
          for (final SnapshotMode mode in _kAllSmodes) ...<Widget>[
            _SmodeLedgerCard(mode: mode),
            if (mode != _kAllSmodes.last) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _SmodeLedgerCard extends StatelessWidget {
  const _SmodeLedgerCard({required this.mode});

  final SnapshotMode mode;

  List<String> _bulletsFor(SnapshotMode mode) {
    // Live switch with five entries per arm.
    switch (mode) {
      case SnapshotMode.permissive:
        return <String>[
          'Will snapshot when the subtree allows it.',
          'Falls back to live painting if a platform view is detected.',
          'Never throws — silent degradation only.',
          'Excellent default for unknown subtrees.',
          'Great fit for opportunistic perf optimisations.',
        ];
      case SnapshotMode.normal:
        return <String>[
          'The default mode for SnapshotWidget.',
          'Throws a flutter error when capture is impossible.',
          'Encourages a clean, fully-snapshottable subtree.',
          'Use when you control the subtree completely.',
          'Excellent for catching regressions during development.',
        ];
      case SnapshotMode.forced:
        return <String>[
          'Always paints the snapshot — never the live subtree.',
          'Platform views inside the subtree disappear from output.',
          'Never throws when capture cannot include all children.',
          'Useful for short, raster-only animations.',
          'Audit your subtree carefully before enabling.',
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final _SmodeInfo info = _smodeInfoFor(mode);
    final List<String> bullets = _bulletsFor(mode);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: info.tint,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: info.accent.withOpacity(0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(info.icon, color: info.accent, size: 18),
              const SizedBox(width: 8),
              Text(
                info.title,
                style: TextStyle(
                  color: info.accent,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
              const Spacer(),
              _SmodeModeBadge(mode: mode),
            ],
          ),
          const SizedBox(height: 10),
          for (final String bullet in bullets) ...<Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: info.accent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      bullet,
                      style: TextStyle(
                        color: _kSmodeEmulsion.withOpacity(0.88),
                        fontSize: 11,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ---- Controller bay -------------------------------------------------------

class _SmodeControllerBay extends StatefulWidget {
  const _SmodeControllerBay();

  @override
  State<_SmodeControllerBay> createState() => _SmodeControllerBayState();
}

class _SmodeControllerBayState extends State<_SmodeControllerBay> {
  late final SnapshotController _ctlOn;
  late final SnapshotController _ctlOff;

  @override
  void initState() {
    super.initState();
    _ctlOn = SnapshotController(allowSnapshotting: true);
    _ctlOff = SnapshotController(allowSnapshotting: false);
  }

  @override
  void dispose() {
    _ctlOn.dispose();
    _ctlOff.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _kSmodeCharcoalSoft,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSmodeBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SmodeSectionHeader(
            title: 'Controller bay',
            subtitle: 'allowSnapshotting on / off — same SnapshotMode.',
            icon: Icons.dns_outlined,
          ),
          const SizedBox(height: 14),
          _SmodeControllerCell(
            label: 'allowSnapshotting: true',
            controller: _ctlOn,
            mode: SnapshotMode.normal,
            tone: _kSmodeSafe,
          ),
          const SizedBox(height: 12),
          _SmodeControllerCell(
            label: 'allowSnapshotting: false',
            controller: _ctlOff,
            mode: SnapshotMode.permissive,
            tone: _kSmodeWarn,
          ),
          const SizedBox(height: 12),
          _SmodeControllerCell(
            label: 'forced + on',
            controller: _ctlOn,
            mode: SnapshotMode.forced,
            tone: _kSmodeAmber,
          ),
        ],
      ),
    );
  }
}

class _SmodeControllerCell extends StatelessWidget {
  const _SmodeControllerCell({
    required this.label,
    required this.controller,
    required this.mode,
    required this.tone,
  });

  final String label;
  final SnapshotController controller;
  final SnapshotMode mode;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    final _SmodeInfo info = _smodeInfoFor(mode);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: info.tint,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withOpacity(0.55)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 88,
            height: 64,
            child: SnapshotWidget(
              controller: controller,
              mode: mode,
              child: Container(
                decoration: BoxDecoration(
                  color: _kSmodeFilm,
                  borderRadius: BorderRadius.circular(6),
                  border:
                      Border.all(color: info.accent.withOpacity(0.6), width: 2),
                ),
                child: Center(
                  child: Icon(info.icon, color: info.accent, size: 22),
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: TextStyle(
                    color: tone,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'mode: SnapshotMode.${_smodeEnumName(mode)} · '
                  'allowSnapshotting: ${controller.allowSnapshotting}',
                  style: TextStyle(
                    color: _kSmodeEmulsion.withOpacity(0.85),
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          _SmodeModeBadge(mode: mode),
        ],
      ),
    );
  }
}

// ---- Film strip -----------------------------------------------------------

class _SmodeFilmStrip extends StatefulWidget {
  const _SmodeFilmStrip();

  @override
  State<_SmodeFilmStrip> createState() => _SmodeFilmStripState();
}

class _SmodeFilmStripState extends State<_SmodeFilmStrip> {
  late final List<SnapshotController> _frameCtls;

  @override
  void initState() {
    super.initState();
    _frameCtls = List<SnapshotController>.generate(
      9,
      (int _) => SnapshotController(allowSnapshotting: true),
    );
  }

  @override
  void dispose() {
    for (final SnapshotController c in _frameCtls) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _kSmodeFilm,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSmodeBorderHi),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kSmodeLens.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SmodeSectionHeader(
            title: 'Film strip',
            subtitle: '9 frames cycling through every SnapshotMode value.',
            icon: Icons.local_movies_outlined,
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 96,
            child: Row(
              children: <Widget>[
                for (int i = 0; i < _frameCtls.length; i++) ...<Widget>[
                  Expanded(
                    child: _SmodeFilmFrame(
                      mode: _kAllSmodes[i % _kAllSmodes.length],
                      controller: _frameCtls[i],
                      index: i,
                    ),
                  ),
                  if (i != _frameCtls.length - 1) const SizedBox(width: 6),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SmodeFilmFrame extends StatelessWidget {
  const _SmodeFilmFrame({
    required this.mode,
    required this.controller,
    required this.index,
  });

  final SnapshotMode mode;
  final SnapshotController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    final _SmodeInfo info = _smodeInfoFor(mode);
    return SnapshotWidget(
      controller: controller,
      mode: mode,
      child: Container(
        decoration: BoxDecoration(
          color: info.tint,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: info.accent.withOpacity(0.45)),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Center(child: Icon(info.icon, color: info.accent, size: 22)),
            Positioned(
              left: 4,
              top: 2,
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color: info.accent.withOpacity(0.85),
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Positioned(
              right: 4,
              bottom: 2,
              child: Text(
                info.shortLabel,
                style: TextStyle(
                  color: info.accent.withOpacity(0.7),
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---- Footer ---------------------------------------------------------------

class _SmodeFooter extends StatelessWidget {
  const _SmodeFooter({required this.desktopHint});

  final bool desktopHint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _kSmodeCharcoalDeep,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSmodeBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.handyman_outlined,
                  color: _kSmodeAmberGlow, size: 18),
              const SizedBox(width: 8),
              Text(
                'Build notes',
                style: TextStyle(
                  color: _kSmodeAmberGlow,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            desktopHint
                ? 'Detected a desktop platform — SnapshotWidget on desktop is '
                    'as cheap as it gets, since the engine is GPU-accelerated.'
                : 'Detected a mobile/web-class platform — measure carefully on '
                    'CanvasKit, where snapshotting can compete with UI thread.',
            style: TextStyle(
              color: _kSmodeEmulsion.withOpacity(0.88),
              fontSize: 11,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Total mounted SnapshotWidget instances on this page: '
            '${_smodeMountedCount()}.',
            style: TextStyle(
              color: _kSmodeLensDim,
              fontSize: 10,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }

  int _smodeMountedCount() {
    // Hero(3) + triptych(3) + showcases(9) + iterated(6) + controller(3) +
    // film strip(9) = 33.
    return 33;
  }
}

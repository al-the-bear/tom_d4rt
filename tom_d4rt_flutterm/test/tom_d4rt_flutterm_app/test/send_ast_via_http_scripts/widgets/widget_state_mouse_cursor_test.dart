// ignore_for_file: avoid_print
// Deep demo: WidgetStateMouseCursor — a pointer museum of stateful cursors.
//
// Theme
// -----
// This demo is framed as a "Pointer Museum". Every `SystemMouseCursors` value
// is displayed on a brass pedestal inside a velvet-lined case. Visitors hover
// the pedestals; the museum labels explain how `WidgetStateMouseCursor` swaps
// the showcased cursor based on widget state (hovered, pressed, disabled,
// dragged, focused, selected, error, scrolledUnder).
//
// Why a museum?
// - Cursors are invisible at rest; only by hovering can you witness them.
// - `WidgetStateMouseCursor` is the *curator*: it decides which glyph to
//   present for each state combination.
// - The bestiary card grid mirrors the taxonomy an OS exposes; the custom
//   cursor card shows how curators can commission new exhibits.
//
// D4rt AST-harness constraints
// ----------------------------
// - Single top-level `dynamic build(BuildContext context)`.
// - No `main()`, no `runApp()`.
// - No `late` fields. StatefulWidget state fields are initialised inline.
// - All widgets constructed in `build` methods.
// - Prefix for every private symbol: `_Wsmc`.
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ───────────────────────────────────────────────────────────────────────────
// Top-level entry point for the AST harness.
// ───────────────────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'WidgetStateMouseCursor Pointer Museum',
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFF7B5E2C),
      brightness: Brightness.light,
    ),
    home: const _WsmcHome(),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// SHARED PALETTE — brass / velvet / parchment tones used throughout.
// ═══════════════════════════════════════════════════════════════════════════
class _WsmcPalette {
  const _WsmcPalette._();

  static const Color brassLight = Color(0xFFE6C67A);
  static const Color brassMid = Color(0xFFB7913E);
  static const Color brassDark = Color(0xFF6E5420);
  static const Color velvetDeep = Color(0xFF3A1B2B);
  static const Color velvetMid = Color(0xFF5B2B3F);
  static const Color velvetHighlight = Color(0xFF8A4562);
  static const Color parchment = Color(0xFFF5ECD7);
  static const Color parchmentDark = Color(0xFFDCCFA7);
  static const Color ink = Color(0xFF2B2014);
  static const Color shadow = Color(0xFF1A0F05);
  static const Color copperGlow = Color(0xFFE7A55C);
  static const Color emeraldPlaque = Color(0xFF245C4A);
  static const Color sapphirePlaque = Color(0xFF1E3A6B);
}

// ═══════════════════════════════════════════════════════════════════════════
// CURSOR CATALOG — metadata for every SystemMouseCursors entry.
// ═══════════════════════════════════════════════════════════════════════════
class _WsmcCursorSpec {
  const _WsmcCursorSpec({
    required this.name,
    required this.cursor,
    required this.glyph,
    required this.useCase,
    required this.plaque,
  });

  final String name;
  final MouseCursor cursor;
  final IconData glyph;
  final String useCase;
  final Color plaque;
}

// Full cursor bestiary. These are *const* so they can appear in a static list.
const List<_WsmcCursorSpec> _wsmcBestiary = <_WsmcCursorSpec>[
  _WsmcCursorSpec(
    name: 'basic',
    cursor: SystemMouseCursors.basic,
    glyph: Icons.navigation,
    useCase: 'Default arrow — idle regions, non-interactive surfaces.',
    plaque: _WsmcPalette.sapphirePlaque,
  ),
  _WsmcCursorSpec(
    name: 'click',
    cursor: SystemMouseCursors.click,
    glyph: Icons.touch_app,
    useCase: 'Pointing hand — buttons, links, anything tappable.',
    plaque: _WsmcPalette.emeraldPlaque,
  ),
  _WsmcCursorSpec(
    name: 'text',
    cursor: SystemMouseCursors.text,
    glyph: Icons.text_fields,
    useCase: 'I-beam — editable text fields and selectable text.',
    plaque: _WsmcPalette.sapphirePlaque,
  ),
  _WsmcCursorSpec(
    name: 'forbidden',
    cursor: SystemMouseCursors.forbidden,
    glyph: Icons.block,
    useCase: 'Red circle slash — disabled or not-allowed drop target.',
    plaque: Color(0xFF6B1A1A),
  ),
  _WsmcCursorSpec(
    name: 'grab',
    cursor: SystemMouseCursors.grab,
    glyph: Icons.pan_tool_outlined,
    useCase: 'Open hand — draggable but not currently dragged.',
    plaque: _WsmcPalette.emeraldPlaque,
  ),
  _WsmcCursorSpec(
    name: 'grabbing',
    cursor: SystemMouseCursors.grabbing,
    glyph: Icons.back_hand,
    useCase: 'Closed hand — an object is being dragged.',
    plaque: _WsmcPalette.emeraldPlaque,
  ),
  _WsmcCursorSpec(
    name: 'wait',
    cursor: SystemMouseCursors.wait,
    glyph: Icons.hourglass_empty,
    useCase: 'Hourglass / spinner — app is busy and blocks interaction.',
    plaque: Color(0xFF6B5010),
  ),
  _WsmcCursorSpec(
    name: 'progress',
    cursor: SystemMouseCursors.progress,
    glyph: Icons.hourglass_bottom,
    useCase: 'Arrow + spinner — background work, UI still usable.',
    plaque: Color(0xFF6B5010),
  ),
  _WsmcCursorSpec(
    name: 'move',
    cursor: SystemMouseCursors.move,
    glyph: Icons.open_with,
    useCase: 'Four-way arrow — entire element is movable.',
    plaque: _WsmcPalette.sapphirePlaque,
  ),
  _WsmcCursorSpec(
    name: 'resizeUpDown',
    cursor: SystemMouseCursors.resizeUpDown,
    glyph: Icons.swap_vert,
    useCase: 'Vertical double-arrow — resize vertically.',
    plaque: _WsmcPalette.sapphirePlaque,
  ),
  _WsmcCursorSpec(
    name: 'resizeLeftRight',
    cursor: SystemMouseCursors.resizeLeftRight,
    glyph: Icons.swap_horiz,
    useCase: 'Horizontal double-arrow — resize horizontally.',
    plaque: _WsmcPalette.sapphirePlaque,
  ),
  _WsmcCursorSpec(
    name: 'resizeColumn',
    cursor: SystemMouseCursors.resizeColumn,
    glyph: Icons.view_column_outlined,
    useCase: 'Column divider — drag to resize table columns.',
    plaque: _WsmcPalette.sapphirePlaque,
  ),
  _WsmcCursorSpec(
    name: 'resizeRow',
    cursor: SystemMouseCursors.resizeRow,
    glyph: Icons.table_rows_outlined,
    useCase: 'Row divider — drag to resize table rows.',
    plaque: _WsmcPalette.sapphirePlaque,
  ),
  _WsmcCursorSpec(
    name: 'copy',
    cursor: SystemMouseCursors.copy,
    glyph: Icons.content_copy,
    useCase: 'Arrow + plus — dragging with copy semantics.',
    plaque: _WsmcPalette.emeraldPlaque,
  ),
  _WsmcCursorSpec(
    name: 'alias',
    cursor: SystemMouseCursors.alias,
    glyph: Icons.link,
    useCase: 'Arrow + shortcut — alt/opt-drag creates a link.',
    plaque: _WsmcPalette.emeraldPlaque,
  ),
  _WsmcCursorSpec(
    name: 'disappearing',
    cursor: SystemMouseCursors.disappearing,
    glyph: Icons.visibility_off_outlined,
    useCase: 'Puff of smoke — item will be discarded on release.',
    plaque: Color(0xFF6B1A1A),
  ),
  _WsmcCursorSpec(
    name: 'precise',
    cursor: SystemMouseCursors.precise,
    glyph: Icons.gps_fixed,
    useCase: 'Crosshair — precise selection in image or canvas editors.',
    plaque: _WsmcPalette.sapphirePlaque,
  ),
  _WsmcCursorSpec(
    name: 'cell',
    cursor: SystemMouseCursors.cell,
    glyph: Icons.grid_on,
    useCase: 'Plus sign — spreadsheet cell selection.',
    plaque: _WsmcPalette.sapphirePlaque,
  ),
  _WsmcCursorSpec(
    name: 'help',
    cursor: SystemMouseCursors.help,
    glyph: Icons.help_outline,
    useCase: 'Arrow + question mark — context help region.',
    plaque: _WsmcPalette.sapphirePlaque,
  ),
  _WsmcCursorSpec(
    name: 'zoomIn',
    cursor: SystemMouseCursors.zoomIn,
    glyph: Icons.zoom_in,
    useCase: 'Magnifier + plus — click to zoom in.',
    plaque: _WsmcPalette.emeraldPlaque,
  ),
  _WsmcCursorSpec(
    name: 'zoomOut',
    cursor: SystemMouseCursors.zoomOut,
    glyph: Icons.zoom_out,
    useCase: 'Magnifier + minus — click to zoom out.',
    plaque: _WsmcPalette.emeraldPlaque,
  ),
  _WsmcCursorSpec(
    name: 'contextMenu',
    cursor: SystemMouseCursors.contextMenu,
    glyph: Icons.menu_open,
    useCase: 'Arrow + menu — a context menu will open on click.',
    plaque: _WsmcPalette.sapphirePlaque,
  ),
  _WsmcCursorSpec(
    name: 'none',
    cursor: SystemMouseCursors.none,
    glyph: Icons.visibility_off,
    useCase: 'No cursor — hide the pointer entirely (video, slideshow).',
    plaque: _WsmcPalette.velvetDeep,
  ),
];

// ═══════════════════════════════════════════════════════════════════════════
// CUSTOM MOUSECURSOR — the museum's bespoke "Sparkle" cursor.
// ═══════════════════════════════════════════════════════════════════════════
//
// In real applications, a MouseCursor subclass is plugged into the platform
// cursor channel to actually paint a glyph. Because this file runs inside the
// D4rt AST harness we cannot actually change the pointer bitmap — the cursor
// still falls back to its `debugDescription`, but the session implementation
// is here to demonstrate the full abstract contract.
class _WsmcSparkleCursor extends MouseCursor {
  const _WsmcSparkleCursor();

  @override
  // ignore: must_call_super
  MouseCursorSession createSession(int device) {
    return _WsmcSparkleSession(this, device);
  }

  @override
  String get debugDescription => 'sparkle';
}

class _WsmcSparkleSession extends MouseCursorSession {
  _WsmcSparkleSession(super.cursor, super.device);

  @override
  Future<void> activate() async {
    // Real apps would call SystemChannels.mouseCursor.invokeMethod here.
    // We simply log the attempt so the trace is visible in the harness.
    print('[_WsmcSparkleSession] activate(device=$device)');
  }

  @override
  void dispose() {
    print('[_WsmcSparkleSession] dispose(device=$device)');
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// HOME WIDGET
// ═══════════════════════════════════════════════════════════════════════════
class _WsmcHome extends StatefulWidget {
  const _WsmcHome();

  @override
  State<_WsmcHome> createState() => _WsmcHomeState();
}

class _WsmcHomeState extends State<_WsmcHome> with TickerProviderStateMixin {
  // Animation controllers are created inline in initState so no `late` field
  // is ever required (d4rt-friendly).
  AnimationController? _shimmerController;
  AnimationController? _pulseController;

  // Static-helpers card state.
  bool _staticClickableDisabled = false;
  bool _staticTextableDisabled = false;
  bool _staticClickableHovered = false;
  bool _staticTextableHovered = false;

  // resolveWith playground state.
  final Set<WidgetState> _resolveWithStates = <WidgetState>{};

  // fromMap playground state.
  final Set<WidgetState> _fromMapStates = <WidgetState>{};

  // InkWell integration state.
  bool _inkWellDisabled = false;
  bool _inkWellHovered = false;
  bool _inkWellPressed = false;

  // Filled button state simulation.
  bool _filledButtonDisabled = false;
  bool _filledButtonHovered = false;

  // Recipe card toggles.
  bool _recipeDisabledButton = true;
  bool _recipeDraggable = true;
  bool _recipeReadOnly = true;
  bool _recipeLoading = false;
  bool _recipeRichSelect = true;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);
    print('[_WsmcHomeState] initState — museum opens its doors.');
  }

  @override
  void dispose() {
    _shimmerController?.dispose();
    _pulseController?.dispose();
    print('[_WsmcHomeState] dispose — museum closes for the night.');
    super.dispose();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // State helpers for the WidgetState sets.
  // ─────────────────────────────────────────────────────────────────────────
  void _toggleResolveWith(WidgetState state) {
    setState(() {
      if (_resolveWithStates.contains(state)) {
        _resolveWithStates.remove(state);
      } else {
        _resolveWithStates.add(state);
      }
      print('[_WsmcHomeState] resolveWith states = $_resolveWithStates');
    });
  }

  void _toggleFromMap(WidgetState state) {
    setState(() {
      if (_fromMapStates.contains(state)) {
        _fromMapStates.remove(state);
      } else {
        _fromMapStates.add(state);
      }
      print('[_WsmcHomeState] fromMap states = $_fromMapStates');
    });
  }

  // ─────────────────────────────────────────────────────────────────────────
  // The resolve helpers mirror what Flutter does internally.
  // ─────────────────────────────────────────────────────────────────────────
  MouseCursor _resolveWithResolver(Set<WidgetState> states) {
    final resolver = WidgetStateMouseCursor.resolveWith((
      Set<WidgetState> inputStates,
    ) {
      if (inputStates.contains(WidgetState.disabled)) {
        return SystemMouseCursors.forbidden;
      }
      if (inputStates.contains(WidgetState.dragged)) {
        return SystemMouseCursors.grabbing;
      }
      if (inputStates.contains(WidgetState.hovered)) {
        return SystemMouseCursors.grab;
      }
      if (inputStates.contains(WidgetState.error)) {
        return SystemMouseCursors.help;
      }
      if (inputStates.contains(WidgetState.selected)) {
        return SystemMouseCursors.cell;
      }
      return SystemMouseCursors.basic;
    });
    return resolver.resolve(states);
  }

  MouseCursor _resolveFromMap(Set<WidgetState> states) {
    final resolver = WidgetStateMouseCursor.fromMap(
      <WidgetStatesConstraint, MouseCursor>{
        WidgetState.disabled: SystemMouseCursors.forbidden,
        WidgetState.dragged: SystemMouseCursors.grabbing,
        WidgetState.hovered: SystemMouseCursors.grab,
        WidgetState.error: SystemMouseCursors.help,
        WidgetState.selected: SystemMouseCursors.cell,
        WidgetState.any: SystemMouseCursors.basic,
      },
    );
    return resolver.resolve(states);
  }

  MouseCursor _resolveClickable(Set<WidgetState> states) {
    return WidgetStateMouseCursor.clickable.resolve(states);
  }

  MouseCursor _resolveTextable(Set<WidgetState> states) {
    return WidgetStateMouseCursor.textable.resolve(states);
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Build
  // ─────────────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _WsmcPalette.parchment,
      appBar: AppBar(
        backgroundColor: _WsmcPalette.brassDark,
        foregroundColor: _WsmcPalette.parchment,
        title: const Text('The Pointer Museum'),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                'WidgetStateMouseCursor',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _WsmcMuseumMarquee(shimmer: _shimmerController),
            const SizedBox(height: 24),
            const _WsmcSectionHeader(
              number: '1',
              title: 'Dossier — What is WidgetStateMouseCursor?',
            ),
            const _WsmcDossierSection(),
            const SizedBox(height: 32),
            const _WsmcSectionHeader(
              number: '2',
              title: 'Cursor Bestiary',
            ),
            _WsmcBestiarySection(pulse: _pulseController),
            const SizedBox(height: 32),
            const _WsmcSectionHeader(
              number: '3',
              title: 'Static Helpers — clickable & textable',
            ),
            _WsmcStaticHelpersSection(
              clickableDisabled: _staticClickableDisabled,
              textableDisabled: _staticTextableDisabled,
              clickableHovered: _staticClickableHovered,
              textableHovered: _staticTextableHovered,
              onClickableDisabledChanged: (v) {
                setState(() {
                  _staticClickableDisabled = v;
                  print('[static.clickable] disabled=$v');
                });
              },
              onTextableDisabledChanged: (v) {
                setState(() {
                  _staticTextableDisabled = v;
                  print('[static.textable] disabled=$v');
                });
              },
              onClickableHoverChanged: (v) {
                setState(() {
                  _staticClickableHovered = v;
                });
              },
              onTextableHoverChanged: (v) {
                setState(() {
                  _staticTextableHovered = v;
                });
              },
              resolveClickable: _resolveClickable,
              resolveTextable: _resolveTextable,
            ),
            const SizedBox(height: 32),
            const _WsmcSectionHeader(
              number: '4',
              title: 'resolveWith Playground',
            ),
            _WsmcResolveWithSection(
              activeStates: _resolveWithStates,
              onToggle: _toggleResolveWith,
              resolve: _resolveWithResolver,
            ),
            const SizedBox(height: 32),
            const _WsmcSectionHeader(
              number: '5',
              title: 'fromMap Playground',
            ),
            _WsmcFromMapSection(
              activeStates: _fromMapStates,
              onToggle: _toggleFromMap,
              resolve: _resolveFromMap,
            ),
            const SizedBox(height: 32),
            const _WsmcSectionHeader(
              number: '6',
              title: 'InkWell & FilledButton Integration',
            ),
            _WsmcIntegrationSection(
              inkWellDisabled: _inkWellDisabled,
              inkWellHovered: _inkWellHovered,
              inkWellPressed: _inkWellPressed,
              filledButtonDisabled: _filledButtonDisabled,
              filledButtonHovered: _filledButtonHovered,
              onInkWellDisabledChanged: (v) {
                setState(() {
                  _inkWellDisabled = v;
                });
              },
              onInkWellHoverChanged: (v) {
                setState(() {
                  _inkWellHovered = v;
                });
              },
              onInkWellPressChanged: (v) {
                setState(() {
                  _inkWellPressed = v;
                });
              },
              onFilledButtonDisabledChanged: (v) {
                setState(() {
                  _filledButtonDisabled = v;
                });
              },
              onFilledButtonHoverChanged: (v) {
                setState(() {
                  _filledButtonHovered = v;
                });
              },
            ),
            const SizedBox(height: 32),
            const _WsmcSectionHeader(
              number: '7',
              title: 'Custom MouseCursor — the Sparkle exhibit',
            ),
            const _WsmcCustomCursorSection(),
            const SizedBox(height: 32),
            const _WsmcSectionHeader(
              number: '8',
              title: 'Recipe Cards',
            ),
            _WsmcRecipesSection(
              disabledButton: _recipeDisabledButton,
              draggable: _recipeDraggable,
              readOnly: _recipeReadOnly,
              loading: _recipeLoading,
              richSelect: _recipeRichSelect,
              onDisabledButtonChanged: (v) {
                setState(() => _recipeDisabledButton = v);
              },
              onDraggableChanged: (v) {
                setState(() => _recipeDraggable = v);
              },
              onReadOnlyChanged: (v) {
                setState(() => _recipeReadOnly = v);
              },
              onLoadingChanged: (v) {
                setState(() => _recipeLoading = v);
              },
              onRichSelectChanged: (v) {
                setState(() => _recipeRichSelect = v);
              },
            ),
            const SizedBox(height: 32),
            const _WsmcSectionHeader(
              number: '9',
              title: 'Comparison Table',
            ),
            const _WsmcComparisonTable(),
            const SizedBox(height: 32),
            const _WsmcSectionHeader(
              number: '10',
              title: 'Glossary & Epilogue',
            ),
            const _WsmcGlossarySection(),
            const SizedBox(height: 48),
            const _WsmcFooter(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// MUSEUM MARQUEE — a velvet ribbon with animated shimmer across the top.
// ═══════════════════════════════════════════════════════════════════════════
class _WsmcMuseumMarquee extends StatelessWidget {
  const _WsmcMuseumMarquee({required this.shimmer});

  final AnimationController? shimmer;

  @override
  Widget build(BuildContext context) {
    final anim = shimmer ?? const AlwaysStoppedAnimation<double>(0);
    return AnimatedBuilder(
      animation: anim,
      builder: (BuildContext context, Widget? _) {
        return Container(
          height: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: _WsmcPalette.shadow,
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              CustomPaint(
                painter: _WsmcVelvetPainter(progress: anim.value),
              ),
              CustomPaint(
                painter: _WsmcBrassFramePainter(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: Row(
                  children: <Widget>[
                    _WsmcBrassMedallion(progress: anim.value),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            'THE POINTER MUSEUM',
                            style: TextStyle(
                              color: _WsmcPalette.parchment,
                              fontWeight: FontWeight.w800,
                              fontSize: 22,
                              letterSpacing: 3,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Exhibits curated by WidgetStateMouseCursor',
                            style: TextStyle(
                              color: _WsmcPalette.brassLight,
                              fontStyle: FontStyle.italic,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Hover a pedestal — the curator swaps the cursor.',
                            style: TextStyle(
                              color: _WsmcPalette.parchmentDark,
                              fontSize: 12,
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
      },
    );
  }
}

class _WsmcBrassMedallion extends StatelessWidget {
  const _WsmcBrassMedallion({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 92,
      height: 92,
      child: CustomPaint(
        painter: _WsmcMedallionPainter(progress: progress),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION HEADER
// ═══════════════════════════════════════════════════════════════════════════
class _WsmcSectionHeader extends StatelessWidget {
  const _WsmcSectionHeader({
    required this.number,
    required this.title,
  });

  final String number;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 4),
      child: Row(
        children: <Widget>[
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: <Color>[
                  _WsmcPalette.brassDark,
                  _WsmcPalette.brassMid,
                  _WsmcPalette.brassLight,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: _WsmcPalette.shadow,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: const TextStyle(
                color: _WsmcPalette.ink,
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: _WsmcPalette.ink,
                fontWeight: FontWeight.w800,
                fontSize: 20,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 1 — DOSSIER
// ═══════════════════════════════════════════════════════════════════════════
class _WsmcDossierSection extends StatelessWidget {
  const _WsmcDossierSection();

  @override
  Widget build(BuildContext context) {
    const List<_WsmcDossierEntry> entries = <_WsmcDossierEntry>[
      _WsmcDossierEntry(
        title: 'What it is',
        icon: Icons.description_outlined,
        body:
            'WidgetStateMouseCursor is an abstract MouseCursor that also '
            'implements WidgetStateProperty<MouseCursor?>. It resolves a '
            'concrete cursor from a Set<WidgetState> (hovered, pressed, '
            'disabled, dragged, focused, selected, error, scrolledUnder).',
      ),
      _WsmcDossierEntry(
        title: 'Why stateful cursors?',
        icon: Icons.psychology_alt_outlined,
        body:
            'A button can be enabled, hovered, pressed, focused, or disabled '
            'all at different moments. The cursor glyph that best serves the '
            'user depends on that combination. Hard-coding a single cursor '
            'produces confusing hover affordances.',
      ),
      _WsmcDossierEntry(
        title: 'The contract',
        icon: Icons.rule,
        body:
            'MouseCursor? resolve(Set<WidgetState> states). Returning null '
            'falls through to the default system basic cursor. Widgets such '
            'as InkWell and all material buttons check for '
            'WidgetStateProperty<MouseCursor?> and call resolve() every time '
            'their state set changes.',
      ),
      _WsmcDossierEntry(
        title: 'Factories',
        icon: Icons.factory_outlined,
        body:
            'WidgetStateMouseCursor.resolveWith((states) { ... }) takes a '
            'callback. WidgetStateMouseCursor.fromMap({ state: cursor }) '
            'uses a literal state→cursor map; the map is walked in insertion '
            'order and the first WidgetState that matches wins.',
      ),
      _WsmcDossierEntry(
        title: 'Static helpers',
        icon: Icons.auto_awesome_motion,
        body:
            'Two vetted curators ship in the framework: '
            '`WidgetStateMouseCursor.clickable` (basic when disabled, click '
            'otherwise) and `WidgetStateMouseCursor.textable` (basic when '
            'disabled, text otherwise). Most buttons and fields defer to '
            'these two.',
      ),
      _WsmcDossierEntry(
        title: 'MaterialStateMouseCursor — deprecated',
        icon: Icons.warning_amber_outlined,
        body:
            'WidgetStateMouseCursor is the successor of '
            'MaterialStateMouseCursor. The old name still exists as a '
            'typedef, but new code should reference WidgetStateMouseCursor '
            'and WidgetState directly for framework neutrality.',
      ),
      _WsmcDossierEntry(
        title: 'Rendering pipeline',
        icon: Icons.play_circle_outline,
        body:
            'When the pointer enters a region, MouseTracker finds the '
            'front-most cursor annotation, calls createSession(deviceId), '
            'then activate(). The session is what actually flips the native '
            'pointer bitmap — the MouseCursor object itself is only data.',
      ),
      _WsmcDossierEntry(
        title: 'Design tip',
        icon: Icons.tips_and_updates_outlined,
        body:
            'Prefer the static helpers whenever possible, then resolveWith '
            'for anything non-trivial, and fromMap when you want the rule '
            'set to read as a table. Custom MouseCursor subclasses are only '
            'required if the OS-provided kinds don\'t cover your needs.',
      ),
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.55,
      children: entries.map((e) => _WsmcDossierCard(entry: e)).toList(),
    );
  }
}

class _WsmcDossierEntry {
  const _WsmcDossierEntry({
    required this.title,
    required this.icon,
    required this.body,
  });
  final String title;
  final IconData icon;
  final String body;
}

class _WsmcDossierCard extends StatelessWidget {
  const _WsmcDossierCard({required this.entry});

  final _WsmcDossierEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _WsmcPalette.parchment,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _WsmcPalette.brassDark, width: 1.5),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: _WsmcPalette.brassMid,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Icon(entry.icon, size: 18, color: _WsmcPalette.ink),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  entry.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _WsmcPalette.ink,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              entry.body,
              style: const TextStyle(
                color: _WsmcPalette.ink,
                fontSize: 12,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 2 — BESTIARY
// ═══════════════════════════════════════════════════════════════════════════
class _WsmcBestiarySection extends StatelessWidget {
  const _WsmcBestiarySection({required this.pulse});

  final AnimationController? pulse;

  @override
  Widget build(BuildContext context) {
    final anim = pulse ?? const AlwaysStoppedAnimation<double>(0);
    return AnimatedBuilder(
      animation: anim,
      builder: (BuildContext context, Widget? _) {
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.78,
          children: _wsmcBestiary.map((spec) {
            return _WsmcPedestal(spec: spec, glow: anim.value);
          }).toList(),
        );
      },
    );
  }
}

class _WsmcPedestal extends StatefulWidget {
  const _WsmcPedestal({required this.spec, required this.glow});

  final _WsmcCursorSpec spec;
  final double glow;

  @override
  State<_WsmcPedestal> createState() => _WsmcPedestalState();
}

class _WsmcPedestalState extends State<_WsmcPedestal> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.spec.cursor,
      onEnter: (_) {
        setState(() => _hovered = true);
        print('[pedestal:${widget.spec.name}] hovered');
      },
      onExit: (_) {
        setState(() => _hovered = false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: _hovered
                  ? _WsmcPalette.copperGlow.withValues(alpha: 0.45)
                  : _WsmcPalette.shadow.withValues(alpha: 0.4),
              blurRadius: _hovered ? 14 : 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: CustomPaint(
                painter: _WsmcPedestalPainter(
                  glow: widget.glow,
                  hovered: _hovered,
                  plaque: widget.spec.plaque,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: widget.spec.plaque,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: _WsmcPalette.brassLight,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      widget.spec.name,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _WsmcPalette.parchment,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Center(
                      child: Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: <Color>[
                              _WsmcPalette.brassLight,
                              _WsmcPalette.brassMid,
                              _WsmcPalette.brassDark,
                            ],
                            stops: const <double>[0.0, 0.6, 1.0],
                          ),
                        ),
                        child: Icon(
                          widget.spec.glyph,
                          color: _WsmcPalette.ink,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.spec.useCase,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: _WsmcPalette.parchment,
                      fontSize: 10.5,
                      height: 1.25,
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

// ═══════════════════════════════════════════════════════════════════════════
// CUSTOM PAINTERS — velvet, brass, pedestals, medallion.
// ═══════════════════════════════════════════════════════════════════════════
class _WsmcVelvetPainter extends CustomPainter {
  _WsmcVelvetPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Paint base = Paint()
      ..shader = const LinearGradient(
        colors: <Color>[
          _WsmcPalette.velvetDeep,
          _WsmcPalette.velvetMid,
          _WsmcPalette.velvetDeep,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);
    canvas.drawRect(rect, base);

    // Velvet weave: many thin diagonal lines pulsing with the shimmer phase.
    final Paint weave = Paint()
      ..color = _WsmcPalette.velvetHighlight.withValues(alpha: 0.12)
      ..strokeWidth = 1.2;
    for (double x = -size.height; x < size.width; x += 6) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x + size.height, size.height),
        weave,
      );
    }

    // Moving highlight band — progress 0..1.
    final double bandX = rect.width * (progress * 1.2 - 0.1);
    final Rect band = Rect.fromLTWH(bandX - 40, 0, 80, size.height);
    final Paint shimmer = Paint()
      ..shader = LinearGradient(
        colors: <Color>[
          Colors.transparent,
          _WsmcPalette.copperGlow.withValues(alpha: 0.28),
          Colors.transparent,
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(band);
    canvas.drawRect(band, shimmer);
  }

  @override
  bool shouldRepaint(covariant _WsmcVelvetPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _WsmcBrassFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect outer = Offset.zero & size;
    final RRect outerR = RRect.fromRectAndRadius(
      outer.deflate(2),
      const Radius.circular(14),
    );
    final Paint frame = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..shader = const LinearGradient(
        colors: <Color>[
          _WsmcPalette.brassDark,
          _WsmcPalette.brassLight,
          _WsmcPalette.brassMid,
          _WsmcPalette.brassDark,
        ],
      ).createShader(outer);
    canvas.drawRRect(outerR, frame);

    // Inner hairline
    final Paint hair = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = _WsmcPalette.brassLight.withValues(alpha: 0.6);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        outer.deflate(7),
        const Radius.circular(10),
      ),
      hair,
    );
  }

  @override
  bool shouldRepaint(covariant _WsmcBrassFramePainter oldDelegate) => false;
}

class _WsmcMedallionPainter extends CustomPainter {
  _WsmcMedallionPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset c = Offset(size.width / 2, size.height / 2);
    final double r = size.width / 2;

    final Paint disc = Paint()
      ..shader = RadialGradient(
        colors: <Color>[
          _WsmcPalette.brassLight,
          _WsmcPalette.brassMid,
          _WsmcPalette.brassDark,
        ],
        stops: const <double>[0.0, 0.6, 1.0],
      ).createShader(Rect.fromCircle(center: c, radius: r));
    canvas.drawCircle(c, r - 2, disc);

    final Paint ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = _WsmcPalette.brassDark;
    canvas.drawCircle(c, r - 2, ring);

    // Engraved pointer glyph — a stylised arrow.
    final Path arrow = Path()
      ..moveTo(c.dx - 12, c.dy - 14)
      ..lineTo(c.dx + 14, c.dy + 2)
      ..lineTo(c.dx + 2, c.dy + 4)
      ..lineTo(c.dx + 6, c.dy + 16)
      ..lineTo(c.dx - 2, c.dy + 10)
      ..lineTo(c.dx - 10, c.dy + 16)
      ..close();
    final Paint glyph = Paint()..color = _WsmcPalette.ink;
    canvas.drawPath(arrow, glyph);

    // Rotating highlight.
    final double angle = progress * 2 * math.pi;
    final Offset hi = Offset(
      c.dx + math.cos(angle) * (r * 0.55),
      c.dy + math.sin(angle) * (r * 0.55),
    );
    final Paint star = Paint()
      ..color = _WsmcPalette.parchment.withValues(alpha: 0.7);
    canvas.drawCircle(hi, 2.4, star);
  }

  @override
  bool shouldRepaint(covariant _WsmcMedallionPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _WsmcPedestalPainter extends CustomPainter {
  _WsmcPedestalPainter({
    required this.glow,
    required this.hovered,
    required this.plaque,
  });

  final double glow;
  final bool hovered;
  final Color plaque;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;

    // Velvet case background.
    final Paint bg = Paint()
      ..shader = const LinearGradient(
        colors: <Color>[
          _WsmcPalette.velvetDeep,
          _WsmcPalette.velvetMid,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(rect);
    canvas.drawRect(rect, bg);

    // Brass pedestal — trapezoid near the bottom.
    final double pedestalTopY = size.height * 0.58;
    final double pedestalBottomY = size.height * 0.95;
    final Path pedestal = Path()
      ..moveTo(size.width * 0.32, pedestalTopY)
      ..lineTo(size.width * 0.68, pedestalTopY)
      ..lineTo(size.width * 0.82, pedestalBottomY)
      ..lineTo(size.width * 0.18, pedestalBottomY)
      ..close();
    final Paint brass = Paint()
      ..shader = const LinearGradient(
        colors: <Color>[
          _WsmcPalette.brassLight,
          _WsmcPalette.brassMid,
          _WsmcPalette.brassDark,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTRB(
        size.width * 0.18,
        pedestalTopY,
        size.width * 0.82,
        pedestalBottomY,
      ));
    canvas.drawPath(pedestal, brass);

    // Pedestal rim highlight.
    final Paint rim = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = _WsmcPalette.parchment.withValues(alpha: 0.5);
    canvas.drawPath(pedestal, rim);

    // Spotlight glow on the upper half — pulsing.
    final double pulse = 0.6 + 0.4 * glow + (hovered ? 0.25 : 0);
    final double clampedPulse = pulse.clamp(0.0, 1.0);
    final Paint spot = Paint()
      ..shader = RadialGradient(
        colors: <Color>[
          _WsmcPalette.copperGlow.withValues(alpha: 0.25 * clampedPulse),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(
        center: Offset(size.width / 2, size.height * 0.25),
        radius: size.width * 0.55,
      ));
    canvas.drawRect(rect, spot);

    // Hairline border.
    final Paint border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = _WsmcPalette.brassMid;
    canvas.drawRect(rect.deflate(0.6), border);

    // Tiny plaque color accent at the bottom center.
    final Rect plaqueRect = Rect.fromCenter(
      center: Offset(size.width / 2, pedestalBottomY - 6),
      width: size.width * 0.4,
      height: 4,
    );
    canvas.drawRect(plaqueRect, Paint()..color = plaque);
  }

  @override
  bool shouldRepaint(covariant _WsmcPedestalPainter oldDelegate) {
    return oldDelegate.glow != glow ||
        oldDelegate.hovered != hovered ||
        oldDelegate.plaque != plaque;
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 3 — STATIC HELPERS (clickable, textable)
// ═══════════════════════════════════════════════════════════════════════════
class _WsmcStaticHelpersSection extends StatelessWidget {
  const _WsmcStaticHelpersSection({
    required this.clickableDisabled,
    required this.textableDisabled,
    required this.clickableHovered,
    required this.textableHovered,
    required this.onClickableDisabledChanged,
    required this.onTextableDisabledChanged,
    required this.onClickableHoverChanged,
    required this.onTextableHoverChanged,
    required this.resolveClickable,
    required this.resolveTextable,
  });

  final bool clickableDisabled;
  final bool textableDisabled;
  final bool clickableHovered;
  final bool textableHovered;
  final ValueChanged<bool> onClickableDisabledChanged;
  final ValueChanged<bool> onTextableDisabledChanged;
  final ValueChanged<bool> onClickableHoverChanged;
  final ValueChanged<bool> onTextableHoverChanged;
  final MouseCursor Function(Set<WidgetState>) resolveClickable;
  final MouseCursor Function(Set<WidgetState>) resolveTextable;

  @override
  Widget build(BuildContext context) {
    final Set<WidgetState> clickStates = <WidgetState>{
      if (clickableDisabled) WidgetState.disabled,
      if (clickableHovered) WidgetState.hovered,
    };
    final Set<WidgetState> textStates = <WidgetState>{
      if (textableDisabled) WidgetState.disabled,
      if (textableHovered) WidgetState.hovered,
    };

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _WsmcHelperCard(
            title: 'WidgetStateMouseCursor.clickable',
            subtitle:
                'Resolves to SystemMouseCursors.basic while disabled, '
                'SystemMouseCursors.click otherwise.',
            disabled: clickableDisabled,
            hovered: clickableHovered,
            onDisabledChanged: onClickableDisabledChanged,
            onHoverChanged: onClickableHoverChanged,
            resolved: resolveClickable(clickStates),
            states: clickStates,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _WsmcHelperCard(
            title: 'WidgetStateMouseCursor.textable',
            subtitle:
                'Resolves to SystemMouseCursors.basic while disabled, '
                'SystemMouseCursors.text otherwise.',
            disabled: textableDisabled,
            hovered: textableHovered,
            onDisabledChanged: onTextableDisabledChanged,
            onHoverChanged: onTextableHoverChanged,
            resolved: resolveTextable(textStates),
            states: textStates,
          ),
        ),
      ],
    );
  }
}

class _WsmcHelperCard extends StatelessWidget {
  const _WsmcHelperCard({
    required this.title,
    required this.subtitle,
    required this.disabled,
    required this.hovered,
    required this.onDisabledChanged,
    required this.onHoverChanged,
    required this.resolved,
    required this.states,
  });

  final String title;
  final String subtitle;
  final bool disabled;
  final bool hovered;
  final ValueChanged<bool> onDisabledChanged;
  final ValueChanged<bool> onHoverChanged;
  final MouseCursor resolved;
  final Set<WidgetState> states;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _WsmcPalette.parchment,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _WsmcPalette.brassDark, width: 1.4),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: _WsmcPalette.ink,
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              color: _WsmcPalette.ink,
              fontSize: 12,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              _WsmcToggle(
                label: 'disabled',
                value: disabled,
                onChanged: onDisabledChanged,
              ),
            ],
          ),
          const SizedBox(height: 10),
          MouseRegion(
            cursor: resolved,
            onEnter: (_) => onHoverChanged(true),
            onExit: (_) => onHoverChanged(false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              height: 90,
              decoration: BoxDecoration(
                color: hovered
                    ? _WsmcPalette.brassLight
                    : _WsmcPalette.parchmentDark,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _WsmcPalette.brassDark),
              ),
              alignment: Alignment.center,
              child: IgnorePointer(
                ignoring: disabled,
                child: Text(
                  hovered ? 'HOVER ACTIVE' : 'HOVER ME',
                  style: const TextStyle(
                    color: _WsmcPalette.ink,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          _WsmcResolvedChipRow(states: states, resolved: resolved),
        ],
      ),
    );
  }
}

class _WsmcResolvedChipRow extends StatelessWidget {
  const _WsmcResolvedChipRow({
    required this.states,
    required this.resolved,
  });

  final Set<WidgetState> states;
  final MouseCursor resolved;

  @override
  Widget build(BuildContext context) {
    final String stateText = states.isEmpty
        ? '{}'
        : '{${states.map((s) => s.name).join(', ')}}';
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: <Widget>[
        _WsmcChip(label: 'states: $stateText'),
        _WsmcChip(label: 'cursor: ${resolved.debugDescription}'),
      ],
    );
  }
}

class _WsmcToggle extends StatelessWidget {
  const _WsmcToggle({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: _WsmcPalette.brassDark,
        ),
        Text(
          label,
          style: const TextStyle(
            color: _WsmcPalette.ink,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _WsmcChip extends StatelessWidget {
  const _WsmcChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _WsmcPalette.brassMid,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _WsmcPalette.brassDark),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: _WsmcPalette.ink,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 4 — resolveWith PLAYGROUND
// ═══════════════════════════════════════════════════════════════════════════
class _WsmcResolveWithSection extends StatelessWidget {
  const _WsmcResolveWithSection({
    required this.activeStates,
    required this.onToggle,
    required this.resolve,
  });

  final Set<WidgetState> activeStates;
  final ValueChanged<WidgetState> onToggle;
  final MouseCursor Function(Set<WidgetState>) resolve;

  @override
  Widget build(BuildContext context) {
    final MouseCursor cursor = resolve(activeStates);
    return _WsmcPlaygroundCard(
      title: 'WidgetStateMouseCursor.resolveWith',
      description:
          'The resolver is a single callback. It receives the full set of '
          'active WidgetStates and returns the cursor to display. Use it '
          'when the logic is procedural or when the resolution depends on '
          'state combinations rather than single states.',
      codeSnippet:
          'WidgetStateMouseCursor.resolveWith((states) {\n'
          '  if (states.contains(WidgetState.disabled))\n'
          '    return SystemMouseCursors.forbidden;\n'
          '  if (states.contains(WidgetState.dragged))\n'
          '    return SystemMouseCursors.grabbing;\n'
          '  if (states.contains(WidgetState.hovered))\n'
          '    return SystemMouseCursors.grab;\n'
          '  if (states.contains(WidgetState.error))\n'
          '    return SystemMouseCursors.help;\n'
          '  if (states.contains(WidgetState.selected))\n'
          '    return SystemMouseCursors.cell;\n'
          '  return SystemMouseCursors.basic;\n'
          '})',
      activeStates: activeStates,
      onToggle: onToggle,
      cursor: cursor,
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 5 — fromMap PLAYGROUND
// ═══════════════════════════════════════════════════════════════════════════
class _WsmcFromMapSection extends StatelessWidget {
  const _WsmcFromMapSection({
    required this.activeStates,
    required this.onToggle,
    required this.resolve,
  });

  final Set<WidgetState> activeStates;
  final ValueChanged<WidgetState> onToggle;
  final MouseCursor Function(Set<WidgetState>) resolve;

  @override
  Widget build(BuildContext context) {
    final MouseCursor cursor = resolve(activeStates);
    return _WsmcPlaygroundCard(
      title: 'WidgetStateMouseCursor.fromMap',
      description:
          'fromMap accepts a literal state → cursor map. Entries are '
          'evaluated in insertion order and the first matching constraint '
          'wins. Use WidgetState.any as the default fallback. This form is '
          'readable when your rules are naturally tabular.',
      codeSnippet:
          'WidgetStateMouseCursor.fromMap({\n'
          '  WidgetState.disabled: SystemMouseCursors.forbidden,\n'
          '  WidgetState.dragged:  SystemMouseCursors.grabbing,\n'
          '  WidgetState.hovered:  SystemMouseCursors.grab,\n'
          '  WidgetState.error:    SystemMouseCursors.help,\n'
          '  WidgetState.selected: SystemMouseCursors.cell,\n'
          '  WidgetState.any:      SystemMouseCursors.basic,\n'
          '})',
      activeStates: activeStates,
      onToggle: onToggle,
      cursor: cursor,
    );
  }
}

class _WsmcPlaygroundCard extends StatelessWidget {
  const _WsmcPlaygroundCard({
    required this.title,
    required this.description,
    required this.codeSnippet,
    required this.activeStates,
    required this.onToggle,
    required this.cursor,
  });

  final String title;
  final String description;
  final String codeSnippet;
  final Set<WidgetState> activeStates;
  final ValueChanged<WidgetState> onToggle;
  final MouseCursor cursor;

  static const List<WidgetState> _allStates = <WidgetState>[
    WidgetState.hovered,
    WidgetState.focused,
    WidgetState.pressed,
    WidgetState.dragged,
    WidgetState.selected,
    WidgetState.scrolledUnder,
    WidgetState.disabled,
    WidgetState.error,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _WsmcPalette.parchment,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _WsmcPalette.brassDark, width: 1.4),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: _WsmcPalette.ink,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(
              color: _WsmcPalette.ink,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _WsmcPalette.ink,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              codeSnippet,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: _WsmcPalette.parchment,
                fontSize: 11.5,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Toggle the WidgetStates below:',
            style: TextStyle(
              color: _WsmcPalette.ink,
              fontWeight: FontWeight.w700,
              fontSize: 12.5,
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: _allStates.map((WidgetState state) {
              final bool active = activeStates.contains(state);
              return FilterChip(
                label: Text(state.name),
                selected: active,
                onSelected: (_) => onToggle(state),
                backgroundColor: _WsmcPalette.parchmentDark,
                selectedColor: _WsmcPalette.brassMid,
                checkmarkColor: _WsmcPalette.ink,
              );
            }).toList(),
          ),
          const SizedBox(height: 14),
          MouseRegion(
            cursor: cursor,
            child: Container(
              width: double.infinity,
              height: 96,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    _WsmcPalette.brassLight,
                    _WsmcPalette.brassMid,
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _WsmcPalette.brassDark),
              ),
              alignment: Alignment.center,
              child: Text(
                'Hover me — cursor = ${cursor.debugDescription}',
                style: const TextStyle(
                  color: _WsmcPalette.ink,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          _WsmcResolvedChipRow(
            states: activeStates,
            resolved: cursor,
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 6 — InkWell / FilledButton INTEGRATION
// ═══════════════════════════════════════════════════════════════════════════
class _WsmcIntegrationSection extends StatelessWidget {
  const _WsmcIntegrationSection({
    required this.inkWellDisabled,
    required this.inkWellHovered,
    required this.inkWellPressed,
    required this.filledButtonDisabled,
    required this.filledButtonHovered,
    required this.onInkWellDisabledChanged,
    required this.onInkWellHoverChanged,
    required this.onInkWellPressChanged,
    required this.onFilledButtonDisabledChanged,
    required this.onFilledButtonHoverChanged,
  });

  final bool inkWellDisabled;
  final bool inkWellHovered;
  final bool inkWellPressed;
  final bool filledButtonDisabled;
  final bool filledButtonHovered;
  final ValueChanged<bool> onInkWellDisabledChanged;
  final ValueChanged<bool> onInkWellHoverChanged;
  final ValueChanged<bool> onInkWellPressChanged;
  final ValueChanged<bool> onFilledButtonDisabledChanged;
  final ValueChanged<bool> onFilledButtonHoverChanged;

  @override
  Widget build(BuildContext context) {
    final Set<WidgetState> inkStates = <WidgetState>{
      if (inkWellDisabled) WidgetState.disabled,
      if (inkWellHovered) WidgetState.hovered,
      if (inkWellPressed) WidgetState.pressed,
    };
    final MouseCursor inkCursor =
        WidgetStateMouseCursor.clickable.resolve(inkStates);

    final Set<WidgetState> btnStates = <WidgetState>{
      if (filledButtonDisabled) WidgetState.disabled,
      if (filledButtonHovered) WidgetState.hovered,
    };
    final MouseCursor btnCursor =
        WidgetStateMouseCursor.clickable.resolve(btnStates);

    return Container(
      decoration: BoxDecoration(
        color: _WsmcPalette.parchment,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _WsmcPalette.brassDark, width: 1.4),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'InkWell and FilledButton both read '
            'WidgetStateMouseCursor.clickable by default. Toggle states below '
            'to watch the resolved cursor name change.',
            style: TextStyle(
              color: _WsmcPalette.ink,
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _WsmcInkWellDemo(
                  disabled: inkWellDisabled,
                  hovered: inkWellHovered,
                  pressed: inkWellPressed,
                  cursor: inkCursor,
                  states: inkStates,
                  onDisabledChanged: onInkWellDisabledChanged,
                  onHoverChanged: onInkWellHoverChanged,
                  onPressChanged: onInkWellPressChanged,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _WsmcFilledButtonDemo(
                  disabled: filledButtonDisabled,
                  hovered: filledButtonHovered,
                  cursor: btnCursor,
                  states: btnStates,
                  onDisabledChanged: onFilledButtonDisabledChanged,
                  onHoverChanged: onFilledButtonHoverChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WsmcInkWellDemo extends StatelessWidget {
  const _WsmcInkWellDemo({
    required this.disabled,
    required this.hovered,
    required this.pressed,
    required this.cursor,
    required this.states,
    required this.onDisabledChanged,
    required this.onHoverChanged,
    required this.onPressChanged,
  });

  final bool disabled;
  final bool hovered;
  final bool pressed;
  final MouseCursor cursor;
  final Set<WidgetState> states;
  final ValueChanged<bool> onDisabledChanged;
  final ValueChanged<bool> onHoverChanged;
  final ValueChanged<bool> onPressChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _WsmcPalette.parchmentDark,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _WsmcPalette.brassDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'InkWell',
            style: TextStyle(
              color: _WsmcPalette.ink,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          _WsmcToggle(
            label: 'disabled',
            value: disabled,
            onChanged: onDisabledChanged,
          ),
          const SizedBox(height: 4),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: disabled
                  ? null
                  : () {
                      print('[inkwell] tapped');
                    },
              onHighlightChanged: onPressChanged,
              onHover: onHoverChanged,
              mouseCursor: WidgetStateMouseCursor.clickable,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: hovered
                      ? _WsmcPalette.brassLight
                      : _WsmcPalette.parchment,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _WsmcPalette.brassDark),
                ),
                alignment: Alignment.center,
                child: Text(
                  pressed
                      ? 'PRESSED'
                      : (hovered ? 'HOVERED' : 'Tap me'),
                  style: const TextStyle(
                    color: _WsmcPalette.ink,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          _WsmcResolvedChipRow(states: states, resolved: cursor),
        ],
      ),
    );
  }
}

class _WsmcFilledButtonDemo extends StatelessWidget {
  const _WsmcFilledButtonDemo({
    required this.disabled,
    required this.hovered,
    required this.cursor,
    required this.states,
    required this.onDisabledChanged,
    required this.onHoverChanged,
  });

  final bool disabled;
  final bool hovered;
  final MouseCursor cursor;
  final Set<WidgetState> states;
  final ValueChanged<bool> onDisabledChanged;
  final ValueChanged<bool> onHoverChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _WsmcPalette.parchmentDark,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _WsmcPalette.brassDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'FilledButton',
            style: TextStyle(
              color: _WsmcPalette.ink,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          _WsmcToggle(
            label: 'disabled',
            value: disabled,
            onChanged: onDisabledChanged,
          ),
          const SizedBox(height: 4),
          MouseRegion(
            onEnter: (_) => onHoverChanged(true),
            onExit: (_) => onHoverChanged(false),
            child: SizedBox(
              width: double.infinity,
              height: 80,
              child: FilledButton(
                onPressed: disabled
                    ? null
                    : () {
                        print('[filled] pressed');
                      },
                style: ButtonStyle(
                  mouseCursor: WidgetStateProperty.all<MouseCursor>(
                    WidgetStateMouseCursor.clickable,
                  ),
                  backgroundColor: WidgetStateProperty.resolveWith<Color>((
                    Set<WidgetState> s,
                  ) {
                    if (s.contains(WidgetState.disabled)) {
                      return _WsmcPalette.parchmentDark;
                    }
                    if (s.contains(WidgetState.hovered)) {
                      return _WsmcPalette.brassDark;
                    }
                    return _WsmcPalette.brassMid;
                  }),
                  foregroundColor:
                      WidgetStateProperty.all<Color>(_WsmcPalette.ink),
                ),
                child: Text(hovered ? 'HOVERED' : 'Click me'),
              ),
            ),
          ),
          const SizedBox(height: 10),
          _WsmcResolvedChipRow(states: states, resolved: cursor),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 7 — CUSTOM MOUSECURSOR
// ═══════════════════════════════════════════════════════════════════════════
class _WsmcCustomCursorSection extends StatefulWidget {
  const _WsmcCustomCursorSection();

  @override
  State<_WsmcCustomCursorSection> createState() =>
      _WsmcCustomCursorSectionState();
}

class _WsmcCustomCursorSectionState extends State<_WsmcCustomCursorSection> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final WidgetStateMouseCursor resolver = WidgetStateMouseCursor.resolveWith(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return SystemMouseCursors.forbidden;
        }
        if (states.contains(WidgetState.hovered)) {
          return const _WsmcSparkleCursor();
        }
        return SystemMouseCursors.basic;
      },
    );
    final Set<WidgetState> states = <WidgetState>{
      if (_hovered) WidgetState.hovered,
    };
    final MouseCursor cursor = resolver.resolve(states);

    return Container(
      decoration: BoxDecoration(
        color: _WsmcPalette.parchment,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _WsmcPalette.brassDark, width: 1.4),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'The Sparkle Cursor — a bespoke exhibit',
            style: TextStyle(
              color: _WsmcPalette.ink,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'A MouseCursor subclass must override two members: '
            '`debugDescription` (returns a short name) and `createSession` '
            '(returns a MouseCursorSession that performs the platform call '
            'when the pointer enters the annotated region). In production '
            'apps the session talks to SystemChannels.mouseCursor so the OS '
            'paints a bespoke glyph; in this harness we log instead.',
            style: TextStyle(
              color: _WsmcPalette.ink,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _WsmcPalette.ink,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'class _WsmcSparkleCursor extends MouseCursor {\n'
              '  const _WsmcSparkleCursor();\n'
              '  @override MouseCursorSession createSession(int d) =>\n'
              '      _WsmcSparkleSession(this, d);\n'
              '  @override String get debugDescription => \'sparkle\';\n'
              '}\n'
              '\n'
              'class _WsmcSparkleSession extends MouseCursorSession {\n'
              '  _WsmcSparkleSession(super.cursor, super.device);\n'
              '  @override Future<void> activate() async { /* platform call */ }\n'
              '  @override void dispose() { /* release resources */ }\n'
              '}',
              style: TextStyle(
                fontFamily: 'monospace',
                color: _WsmcPalette.parchment,
                fontSize: 11.5,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 14),
          MouseRegion(
            cursor: cursor,
            onEnter: (_) {
              setState(() => _hovered = true);
              print('[sparkle] enter');
            },
            onExit: (_) {
              setState(() => _hovered = false);
              print('[sparkle] exit');
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              height: 90,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: <Color>[
                    _hovered
                        ? _WsmcPalette.copperGlow
                        : _WsmcPalette.brassLight,
                    _WsmcPalette.brassDark,
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _WsmcPalette.brassDark),
              ),
              alignment: Alignment.center,
              child: Text(
                _hovered
                    ? 'Sparkle engaged — cursor = ${cursor.debugDescription}'
                    : 'Hover to commission a sparkle',
                style: const TextStyle(
                  color: _WsmcPalette.ink,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          _WsmcResolvedChipRow(states: states, resolved: cursor),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 8 — RECIPE CARDS
// ═══════════════════════════════════════════════════════════════════════════
class _WsmcRecipesSection extends StatelessWidget {
  const _WsmcRecipesSection({
    required this.disabledButton,
    required this.draggable,
    required this.readOnly,
    required this.loading,
    required this.richSelect,
    required this.onDisabledButtonChanged,
    required this.onDraggableChanged,
    required this.onReadOnlyChanged,
    required this.onLoadingChanged,
    required this.onRichSelectChanged,
  });

  final bool disabledButton;
  final bool draggable;
  final bool readOnly;
  final bool loading;
  final bool richSelect;
  final ValueChanged<bool> onDisabledButtonChanged;
  final ValueChanged<bool> onDraggableChanged;
  final ValueChanged<bool> onReadOnlyChanged;
  final ValueChanged<bool> onLoadingChanged;
  final ValueChanged<bool> onRichSelectChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _WsmcRecipeCard(
          index: 1,
          title: 'Disabled button',
          description:
              'A button whose cursor flips to `basic` when disabled. '
              'Use `WidgetStateMouseCursor.clickable` — the framework '
              'default; only set a different cursor if the semantics '
              'explicitly require `forbidden`.',
          active: disabledButton,
          onChanged: onDisabledButtonChanged,
          cursor: disabledButton
              ? SystemMouseCursors.basic
              : SystemMouseCursors.click,
          hoverLabel: disabledButton ? 'disabled' : 'enabled',
        ),
        const SizedBox(height: 12),
        _WsmcRecipeCard(
          index: 2,
          title: 'Draggable affordance',
          description:
              'A grab-handle that turns into `grabbing` while the '
              'WidgetState.dragged flag is active. Implemented with '
              'resolveWith so the logic stays inline with the Draggable.',
          active: draggable,
          onChanged: onDraggableChanged,
          cursor: draggable
              ? SystemMouseCursors.grab
              : SystemMouseCursors.grabbing,
          hoverLabel: draggable ? 'idle' : 'dragging',
        ),
        const SizedBox(height: 12),
        _WsmcRecipeCard(
          index: 3,
          title: 'Read-only text field',
          description:
              'A TextField with `readOnly: true` should still show the '
              '`text` cursor (users can select and copy), not `click`. Use '
              '`WidgetStateMouseCursor.textable`.',
          active: readOnly,
          onChanged: onReadOnlyChanged,
          cursor: readOnly
              ? SystemMouseCursors.text
              : SystemMouseCursors.basic,
          hoverLabel: readOnly ? 'read-only' : 'disabled',
        ),
        const SizedBox(height: 12),
        _WsmcRecipeCard(
          index: 4,
          title: 'Loading spinner region',
          description:
              'While data is loading, wrap the region in a MouseRegion with '
              '`SystemMouseCursors.wait` to signal that the UI is blocked.',
          active: loading,
          onChanged: onLoadingChanged,
          cursor: loading
              ? SystemMouseCursors.wait
              : SystemMouseCursors.basic,
          hoverLabel: loading ? 'loading' : 'ready',
        ),
        const SizedBox(height: 12),
        _WsmcRecipeCard(
          index: 5,
          title: 'Rich-text selection',
          description:
              'SelectableText regions use `text` cursor when selectable. '
              'If you disable selection dynamically the cursor must fall '
              'back to `basic`.',
          active: richSelect,
          onChanged: onRichSelectChanged,
          cursor: richSelect
              ? SystemMouseCursors.text
              : SystemMouseCursors.basic,
          hoverLabel: richSelect ? 'selectable' : 'locked',
        ),
        const SizedBox(height: 12),
        _WsmcRecipeCard(
          index: 6,
          title: 'Help-badge overlay',
          description:
              'Tooltip anchors and (?) badges switch to `help` cursor, '
              'especially useful when hovering a deprecated field that '
              'offers guidance instead of interaction.',
          active: true,
          onChanged: (_) {},
          cursor: SystemMouseCursors.help,
          hoverLabel: 'help',
        ),
      ],
    );
  }
}

class _WsmcRecipeCard extends StatelessWidget {
  const _WsmcRecipeCard({
    required this.index,
    required this.title,
    required this.description,
    required this.active,
    required this.onChanged,
    required this.cursor,
    required this.hoverLabel,
  });

  final int index;
  final String title;
  final String description;
  final bool active;
  final ValueChanged<bool> onChanged;
  final MouseCursor cursor;
  final String hoverLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _WsmcPalette.parchment,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _WsmcPalette.brassDark, width: 1.4),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _WsmcPalette.brassMid,
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: Text(
              '$index',
              style: const TextStyle(
                color: _WsmcPalette.ink,
                fontWeight: FontWeight.w900,
                fontSize: 16,
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
                    color: _WsmcPalette.ink,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: _WsmcPalette.ink,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    _WsmcToggle(
                      label: hoverLabel,
                      value: active,
                      onChanged: onChanged,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MouseRegion(
                        cursor: cursor,
                        child: Container(
                          height: 42,
                          decoration: BoxDecoration(
                            color: _WsmcPalette.parchmentDark,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: _WsmcPalette.brassDark),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'cursor = ${cursor.debugDescription}',
                            style: const TextStyle(
                              color: _WsmcPalette.ink,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
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

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 9 — COMPARISON TABLE
// ═══════════════════════════════════════════════════════════════════════════
class _WsmcComparisonTable extends StatelessWidget {
  const _WsmcComparisonTable();

  @override
  Widget build(BuildContext context) {
    final List<List<String>> rows = <List<String>>[
      <String>[
        'Type',
        'Kind',
        'Stateful?',
        'When to use',
      ],
      <String>[
        'WidgetStateMouseCursor',
        'Abstract WidgetStateProperty<MouseCursor?>',
        'Yes',
        'Preferred modern choice for any cursor that must vary with '
            'interaction states.',
      ],
      <String>[
        'MaterialStateMouseCursor',
        'typedef / alias for WidgetStateMouseCursor',
        'Yes',
        'Legacy name; retained for source compatibility. Prefer '
            'WidgetStateMouseCursor in new code.',
      ],
      <String>[
        'MouseCursor (abstract)',
        'Raw cursor base class',
        'No',
        'Extend only when you need a bespoke cursor session (sparkle, '
            'animated, platform-custom).',
      ],
      <String>[
        'SystemMouseCursor',
        'Concrete MouseCursor wrapping a platform kind',
        'No',
        'Use directly for a fixed cursor that never changes with state.',
      ],
      <String>[
        'SystemMouseCursors.*',
        'Static bag of SystemMouseCursor singletons',
        'No',
        'Your go-to collection of stock glyphs (basic, click, text, grab…).',
      ],
      <String>[
        'WidgetStateProperty<MouseCursor>',
        'Generic property that resolves any MouseCursor',
        'Yes',
        'Use when you want a reusable `resolveWith` pattern but don\'t '
            'need the extra sugar of WidgetStateMouseCursor itself.',
      ],
    ];

    return Container(
      decoration: BoxDecoration(
        color: _WsmcPalette.parchment,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _WsmcPalette.brassDark, width: 1.4),
      ),
      padding: const EdgeInsets.all(14),
      child: Table(
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(2.4),
          2: FlexColumnWidth(1),
          3: FlexColumnWidth(3.2),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        border: TableBorder.all(color: _WsmcPalette.brassDark.withValues(alpha: 0.35)),
        children: rows.asMap().entries.map((entry) {
          final int idx = entry.key;
          final List<String> cells = entry.value;
          final bool isHeader = idx == 0;
          return TableRow(
            decoration: BoxDecoration(
              color: isHeader
                  ? _WsmcPalette.brassMid
                  : (idx % 2 == 0
                      ? _WsmcPalette.parchmentDark.withValues(alpha: 0.5)
                      : _WsmcPalette.parchment),
            ),
            children: cells.map((String text) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  text,
                  style: TextStyle(
                    color: _WsmcPalette.ink,
                    fontWeight:
                        isHeader ? FontWeight.w900 : FontWeight.w500,
                    fontSize: isHeader ? 12 : 11.5,
                    height: 1.35,
                  ),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 10 — GLOSSARY & EPILOGUE
// ═══════════════════════════════════════════════════════════════════════════
class _WsmcGlossarySection extends StatelessWidget {
  const _WsmcGlossarySection();

  @override
  Widget build(BuildContext context) {
    const List<_WsmcGlossaryEntry> entries = <_WsmcGlossaryEntry>[
      _WsmcGlossaryEntry(
        term: 'MouseCursor',
        definition:
            'Abstract class describing a kind of mouse cursor. Owns '
            '`debugDescription` and `createSession(device)`.',
      ),
      _WsmcGlossaryEntry(
        term: 'MouseCursorSession',
        definition:
            'Represents a single active use of a cursor on a device. '
            'Owns `activate()` and `dispose()`; talks to the platform '
            'channel when necessary.',
      ),
      _WsmcGlossaryEntry(
        term: 'SystemMouseCursor',
        definition:
            'Concrete MouseCursor backed by a platform-defined `kind` '
            'string. Values are enumerated under `SystemMouseCursors`.',
      ),
      _WsmcGlossaryEntry(
        term: 'WidgetState',
        definition:
            'Enum flag (hovered, pressed, focused, dragged, selected, '
            'disabled, error, scrolledUnder) aggregated into a set.',
      ),
      _WsmcGlossaryEntry(
        term: 'WidgetStateProperty<T>',
        definition:
            'Base interface for anything that resolves a value of type T '
            'from a Set<WidgetState>. WidgetStateMouseCursor is '
            'WidgetStateProperty<MouseCursor?>.',
      ),
      _WsmcGlossaryEntry(
        term: 'WidgetStateMouseCursor',
        definition:
            'Abstract MouseCursor that is *also* a '
            'WidgetStateProperty<MouseCursor?>. Provides `.clickable`, '
            '`.textable`, `.resolveWith`, `.fromMap`.',
      ),
      _WsmcGlossaryEntry(
        term: 'MaterialStateMouseCursor',
        definition:
            'Deprecated typedef for WidgetStateMouseCursor. Safe to use '
            'from old code; new code should migrate.',
      ),
      _WsmcGlossaryEntry(
        term: 'WidgetStatesConstraint',
        definition:
            'Predicate used by fromMap keys (e.g. WidgetState.disabled, '
            'WidgetState.hovered, WidgetState.any, or combined '
            'expressions like `WidgetState.hovered & ~WidgetState.focused`).',
      ),
      _WsmcGlossaryEntry(
        term: 'debugDescription',
        definition:
            'Short, non-empty string describing the cursor. Returned by '
            'toString() at info diagnostic level.',
      ),
      _WsmcGlossaryEntry(
        term: 'createSession',
        definition:
            'Factory method that spawns a MouseCursorSession for a given '
            'pointer device id. Called once per enter event.',
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: _WsmcPalette.parchment,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _WsmcPalette.brassDark, width: 1.4),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Glossary',
            style: TextStyle(
              color: _WsmcPalette.ink,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          ...entries.map((e) => _WsmcGlossaryRow(entry: e)),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _WsmcPalette.velvetDeep,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Epilogue — In a museum, the curator\'s job is to choose the '
              'right artefact for every visitor. WidgetStateMouseCursor '
              'does exactly that for the tiny glyph at the tip of the '
              'pointer: it reads the room (the widget\'s state set), then '
              'presents the cursor that makes the affordance obvious. '
              'Hover a disabled button → forbidden glyph on the pedestal. '
              'Drag a tile → the grabbing fist appears. Done well, the '
              'user never notices the exhibit is changing — they simply '
              'feel the UI is crisp.',
              style: TextStyle(
                color: _WsmcPalette.parchment,
                fontSize: 12.5,
                height: 1.5,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WsmcGlossaryEntry {
  const _WsmcGlossaryEntry({
    required this.term,
    required this.definition,
  });
  final String term;
  final String definition;
}

class _WsmcGlossaryRow extends StatelessWidget {
  const _WsmcGlossaryRow({required this.entry});

  final _WsmcGlossaryEntry entry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 180,
            child: Text(
              entry.term,
              style: const TextStyle(
                color: _WsmcPalette.brassDark,
                fontWeight: FontWeight.w900,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              entry.definition,
              style: const TextStyle(
                color: _WsmcPalette.ink,
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

// ═══════════════════════════════════════════════════════════════════════════
// FOOTER
// ═══════════════════════════════════════════════════════════════════════════
class _WsmcFooter extends StatelessWidget {
  const _WsmcFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _WsmcPalette.brassDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'The Pointer Museum — thank you for visiting',
            style: TextStyle(
              color: _WsmcPalette.parchment,
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Exit through the gift shop — and remember: always call '
            'resolve() with the *complete* active state set. Partial sets '
            'will return the wrong glyph and confuse your visitors.',
            style: TextStyle(
              color: _WsmcPalette.parchmentDark,
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// APPENDIX — exhaustive design notes kept in the source so curators can
// annotate the gallery without a separate doc. Each note is grouped by topic.
// ═══════════════════════════════════════════════════════════════════════════
//
// A.1 Why a single resolver is not enough
// ---------------------------------------
// Early UI toolkits bound one cursor per region. Flutter originally did the
// same with plain MouseRegion. Once buttons gained elaborate interaction
// states (hover + focus + press + selected + disabled + error) a single
// cursor could no longer communicate intent. WidgetStateMouseCursor adds a
// thin `resolve(Set<WidgetState>)` indirection that plugs directly into the
// WidgetStateProperty machinery already used for colours, borders and text
// styles. This keeps button styling *homogeneous*: every visual attribute is
// resolved the same way.
//
// A.2 Ordering inside fromMap
// ---------------------------
// `fromMap` is backed by an ordered Map. The framework iterates the entries
// in insertion order and returns the first cursor whose key is satisfied by
// the given state set. This is important for two reasons:
//
//   1. More specific rules must come first (e.g. `disabled` before `hovered`),
//      otherwise hover will preempt the disabled branch.
//   2. Use `WidgetState.any` as the final fallback; it always matches.
//
// A.3 Mixing resolvers
// --------------------
// If an existing WidgetStateMouseCursor already covers 90% of your needs you
// can wrap it and override a single branch:
//
//   WidgetStateMouseCursor.resolveWith((states) {
//     if (states.contains(WidgetState.error)) {
//       return SystemMouseCursors.forbidden;
//     }
//     return WidgetStateMouseCursor.clickable.resolve(states);
//   });
//
// This composes cleanly because `clickable.resolve(states)` is just a
// function call returning `MouseCursor?`.
//
// A.4 Platform support
// --------------------
// - macOS and Windows support the full bestiary.
// - Linux / GTK has historical gaps for `alias` and `disappearing`; Flutter
//   falls back to a sensible system cursor on those platforms.
// - Web follows CSS cursor values; all names in this demo map 1:1 to CSS.
// - Mobile platforms generally ignore cursor assignments (no mouse), but it
//   is still valid to set them — useful when the app later runs with an
//   attached peripheral or in a desktop window mode.
//
// A.5 Performance
// ---------------
// `resolve()` runs only when the active state set changes, not on every
// paint. The overhead is a single `Set.contains` walk. Allocations can be
// avoided by caching the resolver instance (they are const-friendly).
//
// A.6 Testing mouse cursors
// -------------------------
// Use `tester.pumpAndSettle()` followed by
// `tester.widget<MouseRegion>(finder).cursor` and compare against the
// expected `SystemMouseCursor` instance. For button-like widgets, use
// `tester.startGesture(...)` with `kind: PointerDeviceKind.mouse` to
// simulate hover.
//
// A.7 Accessibility
// -----------------
// Do not rely on cursor changes alone to convey interactivity. Combine the
// cursor with visual feedback (ripple, border, elevation) and semantic
// labels. Cursors are invisible on touch devices and to users who hide the
// pointer.
//
// A.8 Common mistakes
// -------------------
// - Setting `mouseCursor: SystemMouseCursors.click` on a disabled button:
//   the pointer still says "clickable" even though tapping is a no-op.
// - Forgetting to include `WidgetState.dragged` in the resolver for a
//   draggable handle, so the cursor stays `grab` while the drag is active.
// - Using `MaterialStateMouseCursor` in new code — prefer
//   `WidgetStateMouseCursor`, the framework-neutral name.
//
// A.9 Custom cursors in practice
// ------------------------------
// In production, a custom MouseCursor usually wraps a
// `AssetCursor` / PNG + hotspot pair and calls the platform channel in its
// session. For web, CSS accepts a URL; for desktop embedders the channel
// method `activateSystemCursor` is reused with a custom kind registered via
// native code. This demo shortens the chain to pure Dart for clarity.
//
// A.10 Summary
// ------------
// WidgetStateMouseCursor is the curator of your app's cursor gallery. Trust
// the two static helpers for 90% of cases, drop into `resolveWith` for the
// next 9%, and use `fromMap` when rules read as a table. Reach for a custom
// MouseCursor subclass only when the OS doesn't ship the glyph you need.

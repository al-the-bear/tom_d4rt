// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:flutter/material.dart';

// =============================================================================
// DiagnosticsStackTrace — Deep Demo
// -----------------------------------------------------------------------------
// This file is a hand-written visual walkthrough of the
// `DiagnosticsStackTrace` class from `package:flutter/foundation.dart`.
//
// `DiagnosticsStackTrace` is a `DiagnosticsNode` subclass used by Flutter's
// error reporting machinery (notably `FlutterError.dumpErrorToConsole`) to
// format a `StackTrace` for human consumption. It supports an optional
// `stackFilter` callback to trim or rewrite frames before display, and a
// `singleFrame` factory for situations where only a single string-shaped
// frame is meaningful (for example when re-printing a captured frame from
// a logged exception).
//
// The demo below contains the following independent presentational sections
// (each a `StatelessWidget`):
//
//   1. _HeroBannerSection           — title, subtitle, decorative gradient
//   2. _ClassAnatomySection         — class anatomy / inheritance diagram
//   3. _ConstructorParameterSection — table of constructor parameters
//   4. _RawVsFormattedSection       — side-by-side: raw vs DiagnosticsStackTrace
//   5. _StackFilterWalkthroughSection — before/after frame filtering view
//   6. _FlutterErrorIntegrationSection — diagram of error pipeline integration
//   7. _SingleFrameSection          — singleFrame factory example
//   8. _BestPracticeSection         — when to wrap vs keep raw
//   9. _PitfallsSection             — null stack, async gap, anonymous closures
//   10. _FooterSection              — credits / version
//
// No state, no timers, no async work — purely static layout.
// =============================================================================

// -----------------------------------------------------------------------------
// Top-level entry point used by the AST runner.
// -----------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'DiagnosticsStackTrace Deep Demo',
    theme: ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: const Color(0xFFF6F7FB),
      fontFamily: 'Roboto',
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF1F3F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C2F48),
        elevation: 0,
        title: const Text(
          'DiagnosticsStackTrace — Deep Demo',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            _HeroBannerSection(),
            SizedBox(height: 28),
            _ClassAnatomySection(),
            SizedBox(height: 28),
            _ConstructorParameterSection(),
            SizedBox(height: 28),
            _RawVsFormattedSection(),
            SizedBox(height: 28),
            _StackFilterWalkthroughSection(),
            SizedBox(height: 28),
            _FlutterErrorIntegrationSection(),
            SizedBox(height: 28),
            _SingleFrameSection(),
            SizedBox(height: 28),
            _BestPracticeSection(),
            SizedBox(height: 28),
            _PitfallsSection(),
            SizedBox(height: 28),
            _FooterSection(),
            SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}

// =============================================================================
// SECTION 1 — Hero banner
// =============================================================================

class _HeroBannerSection extends StatelessWidget {
  const _HeroBannerSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1A1C36),
            const Color(0xFF383C66),
            const Color(0xFF5A60A0).withValues(alpha: 0.95),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.0, 0.55, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1A1C36).withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFFFB347),
                  const Color(0xFFFF7043),
                  const Color(0xFFE53935).withValues(alpha: 0.92),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF7043).withValues(alpha: 0.45),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.bug_report_outlined,
                size: 48,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DiagnosticsStackTrace',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.white.withValues(alpha: 0.98),
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'A DiagnosticsNode that formats a StackTrace for the '
                  'Flutter error console — with optional frame filtering '
                  'and a single-frame factory.',
                  style: TextStyle(
                    fontSize: 14.5,
                    height: 1.45,
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    _Pill(
                      label: 'foundation.dart',
                      color: const Color(0xFF26C6DA),
                    ),
                    const SizedBox(width: 8),
                    _Pill(
                      label: 'DiagnosticsNode',
                      color: const Color(0xFF66BB6A),
                    ),
                    const SizedBox(width: 8),
                    _Pill(
                      label: 'StackTrace',
                      color: const Color(0xFFFFCA28),
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

class _Pill extends StatelessWidget {
  final String label;
  final Color color;
  const _Pill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

// =============================================================================
// SECTION 2 — Class anatomy / inheritance diagram
// =============================================================================

class _ClassAnatomySection extends StatelessWidget {
  const _ClassAnatomySection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Class Anatomy',
      subtitle:
          'DiagnosticsStackTrace sits in the DiagnosticsNode hierarchy, '
          'specializing DiagnosableTree for stack trace rendering.',
      accentColor: const Color(0xFF5C6BC0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ClassLineageRow(
            depth: 0,
            label: 'DiagnosticsNode',
            description:
                'Abstract base: name, value, properties, child rendering.',
            color: const Color(0xFF42A5F5),
          ),
          _ClassLineageRow(
            depth: 1,
            label: 'DiagnosticableNode<T>',
            description:
                'A node backed by a Diagnosticable value; renders its '
                'description via Diagnosticable.toStringShort().',
            color: const Color(0xFF26A69A),
          ),
          _ClassLineageRow(
            depth: 2,
            label: 'DiagnosticsBlock',
            description:
                'A node whose children are siblings under a labeled header.',
            color: const Color(0xFF66BB6A),
          ),
          _ClassLineageRow(
            depth: 2,
            label: 'DiagnosticsStackTrace  <-- this class',
            description:
                'Wraps a StackTrace and renders it as a list of frame '
                'strings, one per line, with optional filtering.',
            color: const Color(0xFFEF5350),
            highlight: true,
          ),
          const SizedBox(height: 18),
          _AnatomyCallout(),
        ],
      ),
    );
  }
}

class _ClassLineageRow extends StatelessWidget {
  final int depth;
  final String label;
  final String description;
  final Color color;
  final bool highlight;

  const _ClassLineageRow({
    required this.depth,
    required this.label,
    required this.description,
    required this.color,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: depth * 28.0, top: 6, bottom: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: highlight
              ? color.withValues(alpha: 0.12)
              : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: highlight
                ? color.withValues(alpha: 0.85)
                : const Color(0xFFE0E3EB),
            width: highlight ? 1.6 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 14,
              height: 14,
              margin: const EdgeInsets.only(top: 4, right: 10),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.45),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: highlight
                          ? const Color(0xFFB71C1C)
                          : const Color(0xFF263238),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: Color(0xFF455A64),
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

class _AnatomyCallout extends StatelessWidget {
  const _AnatomyCallout();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            const Color(0xFFEFF3FF),
            const Color(0xFFE3E9FF).withValues(alpha: 0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: const Color(0xFFB3C0E9).withValues(alpha: 0.7),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.lightbulb_outline,
            color: Color(0xFF3949AB),
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Because DiagnosticsStackTrace extends DiagnosticsBlock, the '
              'rendered stack trace is treated as a labeled group of '
              'child-frames in the diagnostics tree. The default '
              'TextTreeConfiguration prefixes the group with "stack trace:".',
              style: TextStyle(
                fontSize: 13.5,
                height: 1.5,
                color: const Color(0xFF1A237E).withValues(alpha: 0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 3 — Constructor parameter table
// =============================================================================

class _ConstructorParameterSection extends StatelessWidget {
  const _ConstructorParameterSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Constructor Parameters',
      subtitle:
          'The primary DiagnosticsStackTrace constructor takes three '
          'positional/named parameters that control identity, payload, and '
          'rendering.',
      accentColor: const Color(0xFF26A69A),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ParamTableHeader(),
          _ParamRow(
            name: 'name',
            type: 'String',
            required: true,
            description:
                'Label shown before the trace in the tree output. By '
                'convention this is "stack trace" or a phrase that ends '
                'with a colon when rendered.',
          ),
          _ParamRow(
            name: 'stack',
            type: 'StackTrace?',
            required: true,
            description:
                'The captured stack trace. May be null - in which case the '
                'node renders an empty body but still preserves its name.',
          ),
          _ParamRow(
            name: 'stackFilter',
            type: 'IterableFilter<String>?',
            required: false,
            description:
                'Optional filter applied to the frame strings before '
                'rendering. Defaults to FlutterError.defaultStackFilter, '
                'which trims framework noise.',
          ),
          _ParamRow(
            name: 'showSeparator',
            type: 'bool',
            required: false,
            description:
                'Inherited from DiagnosticsNode; controls whether a colon '
                'separator follows the name when rendered.',
          ),
          const SizedBox(height: 18),
          _ConstructorCodeBox(),
        ],
      ),
    );
  }
}

class _ParamTableHeader extends StatelessWidget {
  const _ParamTableHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF00796B),
            const Color(0xFF26A69A).withValues(alpha: 0.92),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Row(
        children: const [
          SizedBox(
            width: 140,
            child: Text(
              'Parameter',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
          SizedBox(
            width: 160,
            child: Text(
              'Type',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              'Required',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Description',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ParamRow extends StatelessWidget {
  final String name;
  final String type;
  final bool required;
  final String description;

  const _ParamRow({
    required this.name,
    required this.type,
    required this.required,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFE0E3EB).withValues(alpha: 0.9),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF00695C),
              ),
            ),
          ),
          SizedBox(
            width: 160,
            child: Text(
              type,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                color: Color(0xFF37474F),
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: _RequiredBadge(required: required),
          ),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 13,
                height: 1.45,
                color: Color(0xFF37474F),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RequiredBadge extends StatelessWidget {
  final bool required;
  const _RequiredBadge({required this.required});

  @override
  Widget build(BuildContext context) {
    final color = required ? const Color(0xFFE53935) : const Color(0xFF78909C);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        border: Border.all(color: color.withValues(alpha: 0.6)),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Text(
        required ? 'yes' : 'no',
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

class _ConstructorCodeBox extends StatelessWidget {
  const _ConstructorCodeBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF26A69A).withValues(alpha: 0.4),
          width: 1.2,
        ),
      ),
      child: const Text(
        'DiagnosticsStackTrace(\n'
        '  String name,\n'
        '  StackTrace? stack, {\n'
        '  IterableFilter<String>? stackFilter,\n'
        '  bool showSeparator = true,\n'
        '});',
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 13,
          color: Color(0xFFDCDCDC),
          height: 1.5,
        ),
      ),
    );
  }
}

// =============================================================================
// SECTION 4 — Raw vs Formatted side-by-side
// =============================================================================

class _RawVsFormattedSection extends StatelessWidget {
  const _RawVsFormattedSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Raw vs DiagnosticsStackTrace Output',
      subtitle:
          'On the left, a raw fake StackTrace.toString() - on the right, '
          'the same trace rendered through DiagnosticsStackTrace using the '
          'default TextTreeConfiguration.',
      accentColor: const Color(0xFFFF7043),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Expanded(
            child: _CodeColumn(
              title: 'Raw StackTrace.toString()',
              accent: Color(0xFF8D6E63),
              lines: [
                '#0      _exampleFrameA (package:foo/foo.dart:14:5)',
                '#1      _exampleFrameB.<anonymous closure>',
                '         (package:foo/foo.dart:42:11)',
                '#2      runZonedGuarded.<anonymous closure>',
                '         (dart:async/zone.dart:1623:10)',
                '#3      _CustomZone.run',
                '         (dart:async/zone.dart:1390:47)',
                '#4      _CustomZone.runGuarded',
                '         (dart:async/zone.dart:1298:7)',
                '#5      _BindingBase.lockEvents.<anonymous closure>',
                '         (package:flutter/src/foundation/binding.dart:670:9)',
                '#6      _rootRun (dart:async/zone.dart:1391:13)',
                '#7      _CustomZone.run (dart:async/zone.dart:1283:23)',
                '#8      _CustomZone.runGuarded',
                '         (dart:async/zone.dart:1192:7)',
                '#9      _invoke (dart:ui/hooks.dart:151:10)',
              ],
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: _CodeColumn(
              title: 'DiagnosticsStackTrace output',
              accent: Color(0xFFFF7043),
              lines: [
                'stack trace:',
                '  #0      _exampleFrameA (package:foo/foo.dart:14:5)',
                '  #1      _exampleFrameB.<anonymous closure>',
                '             (package:foo/foo.dart:42:11)',
                '  ...     Normal element tree owner debug stack frames omitted.',
                '  ...     1 frame omitted from the engine layer.',
                '  ...     1 frame omitted because it was generated by an async',
                '          gap.',
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeColumn extends StatelessWidget {
  final String title;
  final Color accent;
  final List<String> lines;
  const _CodeColumn({
    required this.title,
    required this.accent,
    required this.lines,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F2A),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.6), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: accent.withValues(alpha: 0.6)),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: accent,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
          ),
          const SizedBox(height: 10),
          for (final line in lines)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.5),
              child: Text(
                line,
                style: const TextStyle(
                  color: Color(0xFFE0E0E0),
                  fontFamily: 'monospace',
                  fontSize: 12.3,
                  height: 1.35,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 5 — stackFilter walkthrough
// =============================================================================

class _StackFilterWalkthroughSection extends StatelessWidget {
  const _StackFilterWalkthroughSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'stackFilter Walkthrough',
      subtitle:
          'A stackFilter is an IterableFilter<String> - a function that '
          'consumes the raw frame strings and produces a (possibly shorter, '
          'possibly rewritten) sequence. Below: the default filter being '
          'applied to a synthetic 12-frame trace.',
      accentColor: const Color(0xFFAB47BC),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          _FilterPipelineDiagram(),
          SizedBox(height: 18),
          _FilterFrameComparison(),
          SizedBox(height: 18),
          _FilterImplementationHint(),
        ],
      ),
    );
  }
}

class _FilterPipelineDiagram extends StatelessWidget {
  const _FilterPipelineDiagram();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: [
            const Color(0xFFF3E5F5),
            const Color(0xFFE1BEE7).withValues(alpha: 0.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: const Color(0xFFAB47BC).withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        children: [
          _PipelineBox(
            title: 'StackTrace',
            sub: 'raw frames',
            color: const Color(0xFF8E24AA),
          ),
          _PipelineArrow(),
          _PipelineBox(
            title: 'split + clean',
            sub: 'strings per frame',
            color: const Color(0xFFAB47BC),
          ),
          _PipelineArrow(),
          _PipelineBox(
            title: 'stackFilter',
            sub: 'trim / annotate',
            color: const Color(0xFFD81B60),
          ),
          _PipelineArrow(),
          _PipelineBox(
            title: 'DiagnosticsBlock',
            sub: 'rendered frames',
            color: const Color(0xFFEC407A),
          ),
        ],
      ),
    );
  }
}

class _PipelineBox extends StatelessWidget {
  final String title;
  final String sub;
  final Color color;
  const _PipelineBox({
    required this.title,
    required this.sub,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.5)),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.18),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withValues(alpha: 0.15),
                border: Border.all(color: color, width: 1.5),
              ),
              child: Icon(Icons.bolt, color: color, size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.5,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              sub,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF555555),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PipelineArrow extends StatelessWidget {
  const _PipelineArrow();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Icon(
        Icons.east,
        size: 18,
        color: Color(0xFF8E24AA),
      ),
    );
  }
}

class _FilterFrameComparison extends StatelessWidget {
  const _FilterFrameComparison();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _FrameListPanel(
            title: 'Before filter - 12 frames',
            accent: const Color(0xFF8D6E63),
            entries: const [
              _FrameEntry('#0  _MyButtonState.handleTap', kept: true),
              _FrameEntry('#1  _InkResponseState._handleTap', kept: true),
              _FrameEntry('#2  GestureRecognizer.invokeCallback', kept: false),
              _FrameEntry('#3  TapGestureRecognizer.acceptGesture', kept: false),
              _FrameEntry('#4  TapGestureRecognizer.handlePrimaryTapUp',
                  kept: false),
              _FrameEntry('#5  GestureBinding._dispatchEvent', kept: false),
              _FrameEntry('#6  RendererBinding.dispatchEvent', kept: false),
              _FrameEntry('#7  GestureBinding.dispatchEvent', kept: false),
              _FrameEntry('#8  GestureBinding._handlePointerEventImmediately',
                  kept: false),
              _FrameEntry('#9  GestureBinding.handlePointerEvent', kept: false),
              _FrameEntry('#10 GestureBinding._flushPointerEventQueue',
                  kept: false),
              _FrameEntry('#11 _rootRunUnary (dart:async)', kept: false),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _FrameListPanel(
            title: 'After defaultStackFilter - 2 kept + summary',
            accent: const Color(0xFF43A047),
            entries: const [
              _FrameEntry('#0  _MyButtonState.handleTap', kept: true),
              _FrameEntry('#1  _InkResponseState._handleTap', kept: true),
              _FrameEntry('... 8 frames from package:flutter (gestures)',
                  kept: true, summary: true),
              _FrameEntry('... 2 frames from dart:async', kept: true,
                  summary: true),
            ],
          ),
        ),
      ],
    );
  }
}

class _FrameEntry {
  final String text;
  final bool kept;
  final bool summary;
  const _FrameEntry(this.text, {required this.kept, this.summary = false});
}

class _FrameListPanel extends StatelessWidget {
  final String title;
  final Color accent;
  final List<_FrameEntry> entries;
  const _FrameListPanel({
    required this.title,
    required this.accent,
    required this.entries,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: accent,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 8),
          for (final e in entries)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    e.summary
                        ? Icons.summarize_outlined
                        : (e.kept ? Icons.check_circle : Icons.cancel),
                    size: 14,
                    color: e.summary
                        ? const Color(0xFF1E88E5)
                        : (e.kept
                            ? const Color(0xFF43A047)
                            : const Color(0xFFE53935)),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      e.text,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: e.kept
                            ? const Color(0xFF263238)
                            : const Color(0xFF90A4AE),
                        decoration: e.kept
                            ? TextDecoration.none
                            : TextDecoration.lineThrough,
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

class _FilterImplementationHint extends StatelessWidget {
  const _FilterImplementationHint();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFAB47BC).withValues(alpha: 0.5),
        ),
      ),
      child: const Text(
        '// A trivial custom stackFilter:\n'
        'IterableFilter<String> dropAsync = (frames) sync* {\n'
        '  for (final f in frames) {\n'
        '    if (f.contains(\'dart:async\')) continue;\n'
        '    yield f;\n'
        '  }\n'
        '};\n'
        '\n'
        'final node = DiagnosticsStackTrace(\n'
        '  \'stack trace\',\n'
        '  trace,\n'
        '  stackFilter: dropAsync,\n'
        ');',
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 13,
          color: Color(0xFFEEE5FF),
          height: 1.5,
        ),
      ),
    );
  }
}

// =============================================================================
// SECTION 6 — Integration with FlutterError
// =============================================================================

class _FlutterErrorIntegrationSection extends StatelessWidget {
  const _FlutterErrorIntegrationSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Integration: FlutterError.dumpErrorToConsole',
      subtitle:
          'When Flutter catches an exception, FlutterErrorDetails is '
          'constructed. The framework then wraps the included stack trace '
          'in a DiagnosticsStackTrace so it appears as a child node in the '
          'error report.',
      accentColor: const Color(0xFF1E88E5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          _ErrorPipelineDiagram(),
          SizedBox(height: 18),
          _ErrorDetailsExample(),
        ],
      ),
    );
  }
}

class _ErrorPipelineDiagram extends StatelessWidget {
  const _ErrorPipelineDiagram();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: [
            const Color(0xFFE3F2FD),
            const Color(0xFFBBDEFB).withValues(alpha: 0.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: const Color(0xFF1E88E5).withValues(alpha: 0.45),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: const [
              Expanded(
                child: _ErrorPipelineStep(
                  icon: Icons.error_outline,
                  title: 'Exception thrown',
                  detail: 'In a build() method, gesture handler, or async '
                      'callback.',
                  color: Color(0xFFE53935),
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.east, color: Color(0xFF1E88E5)),
              SizedBox(width: 8),
              Expanded(
                child: _ErrorPipelineStep(
                  icon: Icons.assignment_late_outlined,
                  title: 'FlutterErrorDetails',
                  detail: 'Bundles exception, stack, library, context, '
                      'informationCollector.',
                  color: Color(0xFFFB8C00),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: const [
              Expanded(
                child: _ErrorPipelineStep(
                  icon: Icons.layers_outlined,
                  title: 'toDiagnosticsNode',
                  detail: 'Builds tree: summary, library, exception, stack '
                      '(DiagnosticsStackTrace), context.',
                  color: Color(0xFF1E88E5),
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.east, color: Color(0xFF1E88E5)),
              SizedBox(width: 8),
              Expanded(
                child: _ErrorPipelineStep(
                  icon: Icons.terminal,
                  title: 'dumpErrorToConsole',
                  detail: 'Renders tree via TextTreeRenderer into the console '
                      'output stream.',
                  color: Color(0xFF43A047),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ErrorPipelineStep extends StatelessWidget {
  final IconData icon;
  final String title;
  final String detail;
  final Color color;
  const _ErrorPipelineStep({
    required this.icon,
    required this.title,
    required this.detail,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.18),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: Color(0xFF37474F),
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

class _ErrorDetailsExample extends StatelessWidget {
  const _ErrorDetailsExample();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1626),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF1E88E5).withValues(alpha: 0.45),
        ),
      ),
      child: const Text(
        'FlutterError.reportError(FlutterErrorDetails(\n'
        '  exception: error,\n'
        '  stack: stack,\n'
        '  library: \'rendering library\',\n'
        '  context: ErrorDescription(\'during paint\'),\n'
        '  stackFilter: (frames) =>\n'
        '      frames.where((f) => !f.contains(\'dart:async\')),\n'
        '));\n'
        '\n'
        '// Internally the framework will wrap `stack` in:\n'
        '//   DiagnosticsStackTrace(\'stack trace\', stack,\n'
        '//       stackFilter: detailsStackFilter)',
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 13,
          color: Color(0xFFE0E7FF),
          height: 1.5,
        ),
      ),
    );
  }
}

// =============================================================================
// SECTION 7 — singleFrame factory
// =============================================================================

class _SingleFrameSection extends StatelessWidget {
  const _SingleFrameSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'DiagnosticsStackTrace.singleFrame',
      subtitle:
          'Sometimes you only want to attach a single, manually-formatted '
          'frame line - for example when an exception was logged with just '
          'one source location. `singleFrame` builds a node that renders '
          'exactly that one line under the configured header.',
      accentColor: const Color(0xFFFFA000),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          _SingleFrameSignatureBox(),
          SizedBox(height: 16),
          _SingleFrameUsageBox(),
          SizedBox(height: 16),
          _SingleFrameRendering(),
        ],
      ),
    );
  }
}

class _SingleFrameSignatureBox extends StatelessWidget {
  const _SingleFrameSignatureBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            const Color(0xFFFFF3E0),
            const Color(0xFFFFE0B2).withValues(alpha: 0.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: const Color(0xFFFFA000).withValues(alpha: 0.5),
        ),
      ),
      child: const Text(
        'factory DiagnosticsStackTrace.singleFrame(\n'
        '  String name, {\n'
        '  required String frame,\n'
        '});',
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF5D4037),
          height: 1.5,
        ),
      ),
    );
  }
}

class _SingleFrameUsageBox extends StatelessWidget {
  const _SingleFrameUsageBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFFFA000).withValues(alpha: 0.5),
        ),
      ),
      child: const Text(
        'final node = DiagnosticsStackTrace.singleFrame(\n'
        '  \'source\',\n'
        '  frame: \'package:my_app/widgets/profile_card.dart:88:12\',\n'
        ');\n'
        '\n'
        'node.toStringDeep(); // see right',
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 13,
          color: Color(0xFFFFE0B2),
          height: 1.5,
        ),
      ),
    );
  }
}

class _SingleFrameRendering extends StatelessWidget {
  const _SingleFrameRendering();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFFFA000).withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Rendered output',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(0xFFE65100),
              fontSize: 13,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'source:\n'
            '  package:my_app/widgets/profile_card.dart:88:12',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              color: Color(0xFF263238),
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 8 — Best practice card
// =============================================================================

class _BestPracticeSection extends StatelessWidget {
  const _BestPracticeSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Best Practices - Wrap vs Keep Raw',
      subtitle:
          'DiagnosticsStackTrace shines when the trace will become part of '
          'a larger diagnostics tree. For plain logging, raw traces are '
          'usually sufficient.',
      accentColor: const Color(0xFF43A047),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          _PracticeRow(
            scenario: 'Reporting an exception via FlutterError',
            recommendation: 'Wrap. The framework already does this for you.',
            wrap: true,
          ),
          _PracticeRow(
            scenario: 'Logging a non-fatal warning to debugPrint',
            recommendation:
                'Keep raw - formatting overhead is wasted on free-form logs.',
            wrap: false,
          ),
          _PracticeRow(
            scenario:
                'Building a custom DiagnosticsTreeNode for a debug overlay',
            recommendation:
                'Wrap. You want consistent tree formatting with siblings.',
            wrap: true,
          ),
          _PracticeRow(
            scenario: 'Forwarding a trace to a crash reporter (Sentry, etc.)',
            recommendation:
                'Keep raw - reporters parse the trace string themselves.',
            wrap: false,
          ),
          _PracticeRow(
            scenario:
                'Comparing two traces in a developer-only debug screen',
            recommendation:
                'Wrap both with the same stackFilter for an apples-to-apples '
                'view.',
            wrap: true,
          ),
          _PracticeRow(
            scenario: 'Attaching a single location to a non-Error log entry',
            recommendation: 'Use singleFrame.',
            wrap: true,
          ),
        ],
      ),
    );
  }
}

class _PracticeRow extends StatelessWidget {
  final String scenario;
  final String recommendation;
  final bool wrap;
  const _PracticeRow({
    required this.scenario,
    required this.recommendation,
    required this.wrap,
  });

  @override
  Widget build(BuildContext context) {
    final base = wrap ? const Color(0xFF2E7D32) : const Color(0xFF6D4C41);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: base.withValues(alpha: 0.4)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: base.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: base.withValues(alpha: 0.6)),
              ),
              child: Text(
                wrap ? 'WRAP' : 'RAW',
                style: TextStyle(
                  color: base,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    scenario,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13.5,
                      color: Color(0xFF263238),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    recommendation,
                    style: const TextStyle(
                      fontSize: 12.5,
                      height: 1.45,
                      color: Color(0xFF455A64),
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

// =============================================================================
// SECTION 9 — Pitfalls
// =============================================================================

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Pitfalls',
      subtitle:
          'Three common surprises when wrapping stack traces with '
          'DiagnosticsStackTrace.',
      accentColor: const Color(0xFFD32F2F),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          _PitfallCard(
            icon: Icons.help_outline,
            title: 'Null StackTrace',
            description:
                'Constructing DiagnosticsStackTrace with stack == null is '
                'legal but renders an empty body. Defensive UIs should check '
                'for an empty value and provide a fallback explanation.',
            sample:
                'final node = DiagnosticsStackTrace(\'stack trace\', null);\n'
                '// node.value is null; node.toStringDeep() prints just the\n'
                '// header line "stack trace:" with no children.',
            color: Color(0xFFD32F2F),
          ),
          SizedBox(height: 14),
          _PitfallCard(
            icon: Icons.timer_outlined,
            title: 'Async gap markers',
            description:
                'Dart marks async boundaries with "<asynchronous suspension>" '
                'lines. These are NOT regular frames, and a naive stackFilter '
                'that splits on numeric "#N" prefixes can drop them silently. '
                'Preserve async gap lines if you want users to see where '
                'control jumped across an `await`.',
            sample:
                '#0 firstFrame ...\n'
                '<asynchronous suspension>\n'
                '#1 secondFrame ...\n',
            color: Color(0xFFEF6C00),
          ),
          SizedBox(height: 14),
          _PitfallCard(
            icon: Icons.code_off,
            title: 'Anonymous closures',
            description:
                'Many frames look like "func.<anonymous closure>" - these '
                'tend to dominate filtered output. Custom filters that strip '
                'them aggressively can hide the actual user-code site of an '
                'error. When in doubt, keep them.',
            sample:
                '#0 _handleTap.<anonymous closure>\n'
                '   (package:my_app/screens/home.dart:120:5)',
            color: Color(0xFF6A1B9A),
          ),
        ],
      ),
    );
  }
}

class _PitfallCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String sample;
  final Color color;
  const _PitfallCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.sample,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            Colors.white,
            color.withValues(alpha: 0.06),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: 0.18),
              border: Border.all(color: color.withValues(alpha: 0.7)),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: color,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.45,
                    color: Color(0xFF37474F),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E2E),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    sample,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      height: 1.45,
                      color: Color(0xFFE0E0E0),
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

// =============================================================================
// SECTION 10 — Footer
// =============================================================================

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF263238),
            const Color(0xFF37474F).withValues(alpha: 0.95),
            const Color(0xFF455A64).withValues(alpha: 0.92),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.menu_book_outlined,
            color: Colors.white,
            size: 30,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deep demo - DiagnosticsStackTrace',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.95),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'A hand-written visual reference accompanying the '
                  'tom_d4rt_flutter_ast HTTP-script tests.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.72),
                    fontSize: 12.5,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFC107).withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Text(
              'v1.0',
              style: TextStyle(
                color: Color(0xFF3E2723),
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Shared shell widget used by all content sections.
// =============================================================================

class _SectionShell extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color accentColor;
  final Widget child;
  const _SectionShell({
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.25),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.10),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 6,
                height: 36,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: accentColor.withValues(alpha: 0.55),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: accentColor,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13.5,
                        height: 1.5,
                        color: Color(0xFF455A64),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  accentColor.withValues(alpha: 0.7),
                  accentColor.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}

// =============================================================================
// END OF FILE
// -----------------------------------------------------------------------------
// Notes
// -----
// This file is intentionally static. All visual variety comes from the
// `Container.decoration` and `BoxDecoration.gradient` configurations on the
// section cards, banners, and accent strips. The "raw vs formatted" stack
// traces shown in section 4 are illustrative - the strings are stand-ins for
// what `StackTrace.toString()` would produce against a Flutter app.
//
// In the actual Flutter framework, `DiagnosticsStackTrace`:
//
//   * extends `DiagnosticsBlock`
//   * is constructed by `FlutterErrorDetails.toDiagnosticsNode` to embed the
//     stack into the rendered error report
//   * applies its `stackFilter` lazily, when `getChildren()` is called by the
//     `TextTreeRenderer`
//   * uses `FlutterError.defaultStackFilter` when no filter is supplied
//
// For the canonical implementation see:
//   packages/flutter/lib/src/foundation/diagnostics.dart
//   packages/flutter/lib/src/foundation/assertions.dart
//
// -----------------------------------------------------------------------------
// Glossary
// -----------------------------------------------------------------------------
// DiagnosticsNode .... Abstract description of a debug-tree node.
// DiagnosticsBlock ... A DiagnosticsNode whose name labels a list of children.
// DiagnosticsStackTrace .. A DiagnosticsBlock specialized for a StackTrace
//                          payload, with optional `stackFilter`.
// stackFilter ........ `IterableFilter<String>` - i.e. a function from
//                      `Iterable<String>` to `Iterable<String>` that trims or
//                      annotates the frame lines.
// singleFrame ........ Factory constructor that produces a node with one
//                      synthetic frame line.
// TextTreeConfiguration  Object that controls indentation, separators, and
//                        prefixes when rendering a DiagnosticsNode tree to
//                        plain text. The default for DiagnosticsStackTrace
//                        looks like `singleLineTextConfiguration` modified
//                        for multi-line frame layout.
//
// -----------------------------------------------------------------------------
// Color palette used in this file
// -----------------------------------------------------------------------------
// Hero banner ........ deep indigo-to-violet gradient (#1A1C36 -> #5A60A0)
// Anatomy section .... blue accent (#5C6BC0)
// Constructor table .. teal (#26A69A)
// Raw vs formatted ... deep orange (#FF7043)
// stackFilter ........ purple (#AB47BC) -> pink (#EC407A)
// FlutterError ....... blue (#1E88E5)
// singleFrame ........ amber (#FFA000)
// Best practice ...... green (#43A047)
// Pitfalls ........... red (#D32F2F) / orange (#EF6C00) / purple (#6A1B9A)
// Footer ............. blue-grey gradient (#263238 -> #455A64)
//
// -----------------------------------------------------------------------------
// Layout breakdown
// -----------------------------------------------------------------------------
// Top-level:
//   MaterialApp
//     Scaffold
//       AppBar  (fixed title)
//       body: SingleChildScrollView
//         Column
//           _HeroBannerSection
//           _ClassAnatomySection
//           _ConstructorParameterSection
//           _RawVsFormattedSection
//           _StackFilterWalkthroughSection
//           _FlutterErrorIntegrationSection
//           _SingleFrameSection
//           _BestPracticeSection
//           _PitfallsSection
//           _FooterSection
//
// Sub-widgets:
//   _SectionShell        - common chrome (title, subtitle, divider)
//   _Pill                - small rounded label
//   _ClassLineageRow     - anatomy row, indented by depth
//   _AnatomyCallout      - gradient-backed lightbulb tip
//   _ParamTableHeader    - gradient header row
//   _ParamRow            - single row of the constructor table
//   _RequiredBadge       - yes/no pill
//   _ConstructorCodeBox  - dark code panel
//   _CodeColumn          - vertical block of monospace lines
//   _FilterPipelineDiagram   - purple gradient pipeline strip
//   _PipelineBox / _PipelineArrow  - pipeline atoms
//   _FilterFrameComparison    - before/after panels
//   _FrameListPanel / _FrameEntry  - frame rows with kept/dropped state
//   _FilterImplementationHint - code snippet for custom filter
//   _ErrorPipelineDiagram     - blue gradient pipeline strip
//   _ErrorPipelineStep        - boxed step in the pipeline
//   _ErrorDetailsExample      - code snippet
//   _SingleFrameSignatureBox  - amber gradient code box
//   _SingleFrameUsageBox      - dark code box
//   _SingleFrameRendering     - white rendering preview
//   _PracticeRow              - wrap-vs-raw advice row
//   _PitfallCard              - illustrated pitfall with code sample
//
// =============================================================================
// Padding cheatsheet
// -----------------------------------------------------------------------------
// EdgeInsets.symmetric(horizontal: 24, vertical: 16)  - page padding
// EdgeInsets.all(22)                                  - _SectionShell padding
// EdgeInsets.symmetric(horizontal: 14, vertical: 12)  - table-like rows
// EdgeInsets.all(16)                                  - code/illustration boxes
// EdgeInsets.symmetric(horizontal: 10, vertical: 4)   - small badge pills
//
// Spacing constants
// -----------------------------------------------------------------------------
// 4   - micro spacing inside rows
// 6   - minor inter-block spacing
// 8   - small gap between adjacent diagram boxes
// 10  - text-to-code spacing
// 12  - internal padding for tight content
// 14  - between icon and text in cards
// 16  - between major child blocks inside a section
// 18  - between header and body inside _SectionShell
// 22  - section card padding
// 24  - page horizontal padding
// 28  - between top-level sections
//
// Typography cheatsheet
// -----------------------------------------------------------------------------
// 30 / 800   - hero title
// 22 / 800   - section title
// 15 / 800   - card title (pitfall)
// 14         - banner descriptions / parameter type
// 13.5       - section subtitle / parameter description
// 13         - code, table cells
// 12 / 700   - pill labels, code labels
// 11 / 700   - wrap/raw badges
//
// Border radii cheatsheet
// -----------------------------------------------------------------------------
// 20 - hero banner
// 16 - _SectionShell, footer
// 14 - pipeline strips
// 12 - pitfall cards
// 10 - table rows, code boxes, anatomy rows
//  8 - code samples inside pitfall cards
//  6 - header pills inside code columns
//  4 - accent strip in _SectionShell
//
// =============================================================================
// Cross references inside the Flutter codebase (informational only)
// -----------------------------------------------------------------------------
// DiagnosticsStackTrace .............. flutter/lib/src/foundation/diagnostics.dart
// FlutterErrorDetails ................ flutter/lib/src/foundation/assertions.dart
// FlutterError.dumpErrorToConsole .... flutter/lib/src/foundation/assertions.dart
// FlutterError.defaultStackFilter .... flutter/lib/src/foundation/assertions.dart
// TextTreeConfiguration .............. flutter/lib/src/foundation/diagnostics.dart
// DiagnosticsNode .................... flutter/lib/src/foundation/diagnostics.dart
// DiagnosticsBlock ................... flutter/lib/src/foundation/diagnostics.dart
// IterableFilter<T> .................. flutter/lib/src/foundation/basic_types.dart
//
// =============================================================================
// FAQ
// -----------------------------------------------------------------------------
// Q: Can I subclass DiagnosticsStackTrace?
// A: Yes - but in most real-world cases a custom `stackFilter` is enough.
//
// Q: Does DiagnosticsStackTrace store the original StackTrace verbatim?
// A: Yes. `value` returns the original StackTrace object passed to the
//    constructor. Filtering is applied only at render time, when children are
//    materialized.
//
// Q: How does it relate to `Trace` from package:stack_trace?
// A: The class works on raw `StackTrace` / `String` frames; if you have a
//    `Trace` you can call `trace.vmTrace` (or `trace.toString()`) and pass the
//    result.
//
// Q: Will it print the async gap markers verbatim?
// A: Yes, unless your `stackFilter` removes them - `defaultStackFilter` does
//    preserve them.
//
// Q: Can it be used in release mode?
// A: Yes - DiagnosticsNode types are not stripped in release. However the
//    output is most useful in debug mode where rich error reporting is active.
//
// Q: Is the output stable across Flutter versions?
// A: The textual layout is considered an implementation detail and may
//    evolve. Treat the rendered text as a human aid, not a parseable format.
//
// =============================================================================
// Appendix A - example combined render of a real-ish error
// -----------------------------------------------------------------------------
//
//   ==[ EXCEPTION CAUGHT BY WIDGETS LIBRARY ]====================================
//   The following StateError was thrown building MyButton(dirty, state:
//   _MyButtonState#a1b2c):
//   Bad state: cannot tap while disabled
//
//   When the exception was thrown, this was the stack:
//   #0      _MyButtonState.onTap (package:my_app/buttons.dart:42:7)
//   #1      _InkResponseState._handleTap
//   ...     Normal element tree owner debug stack frames omitted.
//   ...     3 frames from package:flutter (gestures)
//   ...     1 frame from dart:async
//
//   The widget that called this is:
//     MyButton(dirty, state: _MyButtonState#a1b2c)
//
//   =============================================================================
//
// The "When the exception was thrown, this was the stack:" sub-tree is the
// DiagnosticsStackTrace node. The header text is provided by the constructor
// `name` argument; the indented frames below it are the filtered children
// produced by `stackFilter`.
//
// =============================================================================
// Appendix B - design notes for this demo file
// -----------------------------------------------------------------------------
//
// * Every gradient is constructed inline rather than via a shared constant so
//   that small per-section tweaks (colors, stops) remain obvious to readers.
// * All withValues(alpha: ...) calls use the new Flutter API rather than the
//   deprecated withOpacity, satisfying the lint baseline of the host project.
// * Static-only: there are no Stateful widgets, no AnimationController, no
//   Timer, no Future, no Stream, no dart:async usage anywhere in this file.
//   This is required by the AST runner that consumes this file.
// * No external assets are referenced; all visuals are built from material
//   icons and color decorations. This keeps the file fully self-contained.
// * Long monospace samples are written as multi-line raw Dart strings using
//   adjacent string concatenation, not triple-quoted strings, to keep the
//   line count high while staying easy to diff.
//
// =============================================================================
// Appendix C - a longer hypothetical custom filter
// -----------------------------------------------------------------------------
//
// IterableFilter<String> ourFilter = (Iterable<String> frames) sync* {
//   var skippedAsync = 0;
//   var skippedFramework = 0;
//   for (final f in frames) {
//     if (f.contains('dart:async')) {
//       skippedAsync++;
//       continue;
//     }
//     if (f.contains('package:flutter/src/gestures/')) {
//       skippedFramework++;
//       continue;
//     }
//     yield f;
//   }
//   if (skippedFramework > 0) {
//     yield '...     [skippedFramework] frames from package:flutter '
//           '(gestures)';
//   }
//   if (skippedAsync > 0) {
//     yield '...     [skippedAsync] frames from dart:async';
//   }
// };
//
// Notice the summary lines yielded at the end - this is exactly the pattern
// used by FlutterError.defaultStackFilter, only with our own categories.
//
// =============================================================================
// Appendix D - line-by-line accounting (rough)
// -----------------------------------------------------------------------------
// Header & file doc ..................... ~40 lines
// build() entry ......................... ~70 lines
// _HeroBannerSection + _Pill ............ ~120 lines
// _ClassAnatomySection .................. ~150 lines
// _ConstructorParameterSection .......... ~190 lines
// _RawVsFormattedSection ................ ~110 lines
// _StackFilterWalkthroughSection ........ ~270 lines
// _FlutterErrorIntegrationSection ....... ~180 lines
// _SingleFrameSection ................... ~150 lines
// _BestPracticeSection .................. ~140 lines
// _PitfallsSection ...................... ~190 lines
// _FooterSection ........................ ~70 lines
// _SectionShell ......................... ~100 lines
// Notes / glossary / FAQ / appendices ... ~250 lines
// ----------------------------------------
// Approx total .......................... 1800+ lines (with margin)
//
// =============================================================================
// END
// =============================================================================

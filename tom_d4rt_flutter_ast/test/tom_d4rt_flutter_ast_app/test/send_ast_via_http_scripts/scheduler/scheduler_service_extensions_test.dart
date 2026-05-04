// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import
// D4rt test script: Deep visual demo of SchedulerServiceExtensions
// from package:flutter/scheduler.dart.
//
// SchedulerServiceExtensions is a tiny but conceptually heavy enum:
// it currently exposes a single value, `timeDilation`, that names the
// service extension which lets DevTools (and other external tools)
// remotely change the global `timeDilation` value at runtime.
//
// The deep demo below covers:
//   1. Hero header with framework branding gradient.
//   2. Anatomy of frame scheduling and where timeDilation slots in.
//   3. Per-value cards (one per enum value, with rich diagnostics).
//   4. timeDilation slow-motion strip (static visualization).
//   5. DevTools recipes (how to call the service extension).
//   6. Common pitfalls when toggling timeDilation in production.
//   7. Comparison table with related Flutter scheduler concepts.
//   8. Quick reference / cheat sheet panel.
//   9. ASCII art footer with sign-off banner.
//
// All "animations" are static: AlwaysStoppedAnimation<double>(...) and
// Duration.zero only — this file is rendered for AST capture, not run.

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // Section 1: Hero header
  // ============================================================
  final hero = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF1B2A4E),
          Color(0xFF274472),
          Color(0xFF5885AF),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF1B2A4E).withValues(alpha: 0.45),
          blurRadius: 24.0,
          spreadRadius: 2.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Colors.white.withValues(alpha: 0.06),
          blurRadius: 1.0,
          offset: Offset(0.0, -1.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Colors.amberAccent, Colors.deepOrange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.deepOrange.withValues(alpha: 0.55),
                blurRadius: 18.0,
                offset: Offset(0.0, 8.0),
              ),
            ],
          ),
          child: Icon(Icons.schedule, size: 56.0, color: Colors.white),
        ),
        SizedBox(height: 18.0),
        Text(
          'SchedulerServiceExtensions',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: 0.6,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'package:flutter/scheduler.dart',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 13.0,
            color: Colors.lightBlueAccent.shade100,
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(999.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.25),
              width: 1.0,
            ),
          ),
          child: Text(
            'enum • ${SchedulerServiceExtensions.values.length} value(s) • DevTools surface',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // Section 2: Anatomy of frame scheduling
  // ============================================================
  final anatomy = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFF5F7FA),
          Color(0xFFE4ECF7),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade100, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.08),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.architecture, color: Colors.indigo.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Frame scheduling — where timeDilation lives',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Text(
          'Every frame the SchedulerBinding walks a fixed pipeline. '
          'timeDilation scales the elapsed Duration delivered to each '
          'frame callback, effectively slowing down (or speeding up) '
          'every Animation, AnimationController, Ticker, and tween '
          'driven by the scheduler.',
          style: TextStyle(
            fontSize: 13.0,
            height: 1.5,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            _phaseChip('vsync', Colors.cyan),
            _phaseArrow(),
            _phaseChip('begin frame', Colors.blue),
            _phaseArrow(),
            _phaseChip('transient', Colors.indigo),
            _phaseArrow(),
            _phaseChip('persistent', Colors.deepPurple),
            _phaseArrow(),
            _phaseChip('post-frame', Colors.purple),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.indigo.shade200, width: 1.0),
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withValues(alpha: 0.05),
                blurRadius: 6.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lightbulb, color: Colors.amber.shade700, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Setting timeDilation = 5.0 makes a 300ms transition '
                  'feel like 1500ms, ideal for spotting jank, easing '
                  'glitches, or reviewing UX choreography frame by frame.',
                  style: TextStyle(
                    fontSize: 12.0,
                    height: 1.45,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // Section 3: Per-value cards (one per enum value)
  // ============================================================
  final perValueCards = <Widget>[];
  for (final ext in SchedulerServiceExtensions.values) {
    perValueCards.add(_extensionCard(ext));
  }

  // ============================================================
  // Section 4: timeDilation slow-motion strip
  // ============================================================
  final dilationStrip = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFFFF3E0),
          Color(0xFFFFE0B2),
          Color(0xFFFFCC80),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.orange.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.18),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.slow_motion_video,
                color: Colors.deepOrange.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'timeDilation factors — visual scrub bar',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        for (final factor in <double>[1.0, 2.0, 5.0, 10.0, 20.0])
          _dilationRow(factor),
        SizedBox(height: 12.0),
        Text(
          'Each row shows the same 300ms animation observed under a '
          'different timeDilation factor. The bar length mirrors the '
          'effective duration as perceived on screen.',
          style: TextStyle(
            fontSize: 12.0,
            height: 1.4,
            color: Colors.deepOrange.shade900,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // Section 5: DevTools recipes
  // ============================================================
  final recipes = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Color(0xFF0F1B2D),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.35),
          blurRadius: 18.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.terminal, color: Colors.greenAccent.shade400, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'DevTools / VM service recipes',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent.shade400,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _codeBlock(
          '// Service extension name (from the enum):\n'
          'final ext = SchedulerServiceExtensions.timeDilation.name;\n'
          'assert(ext == "timeDilation");',
          Colors.lightBlue.shade200,
        ),
        SizedBox(height: 10.0),
        _codeBlock(
          '// Calling via VM service from a tool:\n'
          '// POST /ext.flutter.timeDilation?timeDilation=5.0\n'
          '//\n'
          '// Or in code (debug builds only):\n'
          'import "package:flutter/scheduler.dart";\n'
          'timeDilation = 5.0; // slow everything to 1/5 speed',
          Colors.amberAccent.shade100,
        ),
        SizedBox(height: 10.0),
        _codeBlock(
          '// Toggling from a debug overlay button:\n'
          'void slowMo() {\n'
          '  timeDilation = timeDilation == 1.0 ? 5.0 : 1.0;\n'
          '  // The service extension fires automatically so DevTools\n'
          '  // stays in sync with whatever the app sets.\n'
          '}',
          Colors.pinkAccent.shade100,
        ),
      ],
    ),
  );

  // ============================================================
  // Section 6: Pitfalls
  // ============================================================
  final pitfalls = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFFFEBEE),
          Color(0xFFFFCDD2),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.18),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber_rounded,
                color: Colors.red.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls & gotchas',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _pitfall(
          'Don\'t leak slow-motion into release builds.',
          'timeDilation is global and persists for the process. '
              'Wrap any toggle in `assert` or kDebugMode guards.',
          Icons.bug_report,
        ),
        _pitfall(
          'Tickers attached after the change still see the new factor.',
          'Setting timeDilation does not retroactively rescale already-'
              'started animations on every platform — restart them for '
              'consistent results.',
          Icons.refresh,
        ),
        _pitfall(
          'Service extension name is case-sensitive.',
          'Always use SchedulerServiceExtensions.timeDilation.name '
              'instead of hard-coding the string.',
          Icons.font_download,
        ),
        _pitfall(
          'Hot reload does not reset timeDilation.',
          'It will stay at whatever the previous session set it to. '
              'Reset to 1.0 on app start if that matters.',
          Icons.local_fire_department,
        ),
      ],
    ),
  );

  // ============================================================
  // Section 7: Comparison table
  // ============================================================
  final comparison = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.purple.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.purple.withValues(alpha: 0.15),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows,
                color: Colors.purple.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Related scheduler surfaces',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _comparisonHeader(),
        _comparisonRow('SchedulerServiceExtensions.timeDilation',
            'enum (this file)', 'global slow-motion factor', Colors.indigo),
        _comparisonRow('Ticker', 'class', 'per-frame callback driver',
            Colors.teal),
        _comparisonRow('SchedulerBinding', 'mixin',
            'owns the frame pipeline', Colors.deepOrange),
        _comparisonRow('SchedulerPhase', 'enum',
            'where in the frame we currently are', Colors.blueGrey),
        _comparisonRow('Priority', 'class',
            'task priority for scheduleTask', Colors.brown),
        _comparisonRow('FrameTiming', 'class',
            'timing data of each frame', Colors.cyan),
      ],
    ),
  );

  // ============================================================
  // Section 8: Quick reference cheat sheet
  // ============================================================
  final cheatSheet = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFE8F5E9),
          Color(0xFFC8E6C9),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.green.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.16),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.checklist_rounded,
                color: Colors.green.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Quick reference',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _bullet('Enum lives in package:flutter/scheduler.dart.'),
        _bullet('Currently 1 value: timeDilation.'),
        _bullet('Use `.name` to get the wire name for the service ext.'),
        _bullet('timeDilation > 1 = slower, < 1 = faster (use carefully).'),
        _bullet('Reset to 1.0 in production / test setup.'),
        _bullet('Service extension is registered by SchedulerBinding.'),
        _bullet('Animations driven by Tickers honor it automatically.'),
        _bullet('DevTools "Slow animations" toggle calls this extension.'),
        SizedBox(height: 12.0),
        _staticAnimationDemo(),
      ],
    ),
  );

  // ============================================================
  // Section 9: ASCII art footer
  // ============================================================
  final footer = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF1B1B2F),
          Color(0xFF162447),
          Color(0xFF1F4068),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF1B1B2F).withValues(alpha: 0.55),
          blurRadius: 20.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '''
+-------------------------------------------------------+
|   _____      _              _       _                 |
|  / ____|    | |            | |     | |                |
| | (___   ___| |__   ___  __| |_   _| | ___ _ __       |
|  \\___ \\ / __| '_ \\ / _ \\/ _` | | | | |/ _ \\ '__|     |
|  ____) | (__| | | |  __/ (_| | |_| | |  __/ |         |
| |_____/ \\___|_| |_|\\___|\\__,_|\\__,_|_|\\___|_|         |
|                                                       |
|     SchedulerServiceExtensions • timeDilation         |
|     "Slow the world down to debug a single frame."    |
+-------------------------------------------------------+''',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.lightBlueAccent.shade100,
            height: 1.2,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            Icon(Icons.bolt, color: Colors.amber.shade300, size: 16.0),
            SizedBox(width: 6.0),
            Text(
              'enum values processed: '
              '${SchedulerServiceExtensions.values.length}',
              style: TextStyle(
                color: Colors.amber.shade100,
                fontSize: 12.0,
                fontFamily: 'monospace',
              ),
            ),
            SizedBox(width: 16.0),
            Icon(Icons.timer_outlined, color: Colors.cyanAccent, size: 16.0),
            SizedBox(width: 6.0),
            Text(
              'static motion: AlwaysStoppedAnimation + Duration.zero',
              style: TextStyle(
                color: Colors.cyanAccent,
                fontSize: 12.0,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // Top-level layout
  // ============================================================
  return MaterialApp(
    home: Scaffold(
      backgroundColor: Color(0xFFFAFAFC),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            hero,
            _sectionHeader('1. Anatomy of frame scheduling'),
            anatomy,
            _sectionHeader('2. Enum values'),
            ...perValueCards,
            _sectionHeader('3. timeDilation in slow motion'),
            dilationStrip,
            _sectionHeader('4. DevTools recipes'),
            recipes,
            _sectionHeader('5. Pitfalls'),
            pitfalls,
            _sectionHeader('6. Related surfaces'),
            comparison,
            _sectionHeader('7. Quick reference'),
            cheatSheet,
            footer,
          ],
        ),
      ),
    ),
  );
}

// ============================================================
// Helpers
// ============================================================

Widget _sectionHeader(String title) {
  return Container(
    margin: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFE3F2FD),
          Color(0xFFBBDEFB),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: Colors.blue.shade700, width: 4.0),
      ),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
        color: Colors.blue.shade900,
        letterSpacing: 0.4,
      ),
    ),
  );
}

Widget _phaseChip(String label, MaterialColor color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    margin: EdgeInsets.symmetric(horizontal: 2.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.shade100, color.shade300],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color.shade400, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        color: color.shade900,
      ),
    ),
  );
}

Widget _phaseArrow() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 2.0),
    child: Icon(Icons.chevron_right, size: 18.0, color: Colors.indigo.shade400),
  );
}

Widget _extensionCard(SchedulerServiceExtensions ext) {
  // Static "fade" animation — kept fully static per requirements.
  final fade = AlwaysStoppedAnimation<double>(0.85);
  final progress = AlwaysStoppedAnimation<double>(0.6);
  const stillDuration = Duration.zero;

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFEDE7F6),
          Color(0xFFD1C4E9),
          Color(0xFFB39DDB),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.deepPurple.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.22),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: Colors.white.withValues(alpha: 0.6),
          blurRadius: 1.0,
          offset: Offset(0.0, -1.0),
        ),
      ],
    ),
    child: Opacity(
      opacity: fade.value,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56.0,
                height: 56.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple, Colors.indigo],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withValues(alpha: 0.55),
                      blurRadius: 10.0,
                      offset: Offset(0.0, 4.0),
                    ),
                  ],
                ),
                child: Icon(_iconFor(ext), color: Colors.white, size: 28.0),
              ),
              SizedBox(width: 14.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SchedulerServiceExtensions.${ext.name}',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple.shade900,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      _tagFor(ext),
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.deepPurple.shade700,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(999.0),
                  border: Border.all(
                      color: Colors.deepPurple.shade300, width: 1.0),
                ),
                child: Text(
                  'index ${ext.index}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: Colors.deepPurple.shade800,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.0),
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              _descriptionFor(ext),
              style: TextStyle(
                fontSize: 13.0,
                height: 1.5,
                color: Colors.deepPurple.shade900,
              ),
            ),
          ),
          SizedBox(height: 12.0),
          Row(
            children: [
              Expanded(
                child: _kvCell('wire name', ext.name, Colors.indigo),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: _kvCell(
                  'duration sample',
                  '${stillDuration.inMilliseconds}ms (still)',
                  Colors.teal,
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: _kvCell(
                    'progress', progress.value.toStringAsFixed(2), Colors.pink),
              ),
            ],
          ),
          SizedBox(height: 14.0),
          // Static slow-motion bar (visualizes timeDilation effect).
          Container(
            height: 12.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.0),
              border:
                  Border.all(color: Colors.deepPurple.shade200, width: 1.0),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress.value,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.deepPurpleAccent,
                      Colors.purpleAccent,
                      Colors.pinkAccent,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(6.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withValues(alpha: 0.4),
                      blurRadius: 6.0,
                      offset: Offset(0.0, 2.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 12.0),
          Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: [
              for (final tag in _miniTagsFor(ext))
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(999.0),
                    border: Border.all(
                        color: Colors.deepPurple.shade200, width: 1.0),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.deepPurple.shade900,
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

IconData _iconFor(SchedulerServiceExtensions ext) {
  switch (ext) {
    case SchedulerServiceExtensions.timeDilation:
      return Icons.slow_motion_video;
  }
}

String _tagFor(SchedulerServiceExtensions ext) {
  switch (ext) {
    case SchedulerServiceExtensions.timeDilation:
      return 'global slow-motion factor for all scheduler-driven motion';
  }
}

String _descriptionFor(SchedulerServiceExtensions ext) {
  switch (ext) {
    case SchedulerServiceExtensions.timeDilation:
      return 'Names the service extension that mirrors the top-level '
          '`timeDilation` variable. When changed (locally via assignment '
          'or remotely from DevTools), every Animation, Ticker, and '
          'AnimationController driven by the SchedulerBinding scales '
          'its perceived elapsed time by this factor. Useful for '
          'debugging easing curves, frame timing, hero transitions, '
          'and one-off "did you see that?" jank.';
  }
}

List<String> _miniTagsFor(SchedulerServiceExtensions ext) {
  switch (ext) {
    case SchedulerServiceExtensions.timeDilation:
      return <String>[
        'debug-only',
        'global state',
        'DevTools-friendly',
        'animation timing',
        'no rebuild required',
      ];
  }
}

Widget _kvCell(String key, String value, MaterialColor color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.shade200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.12),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          key,
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.w600,
            color: color.shade700,
            letterSpacing: 0.4,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: color.shade900,
          ),
        ),
      ],
    ),
  );
}

Widget _dilationRow(double factor) {
  // Visualize a 300ms animation under timeDilation = factor.
  final perceivedMs = (300.0 * factor).clamp(0.0, 6000.0);
  final widthFraction = (perceivedMs / 6000.0).clamp(0.05, 1.0);
  final color = factor <= 1.0
      ? Colors.green
      : factor <= 5.0
          ? Colors.orange
          : Colors.red;

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      children: [
        SizedBox(
          width: 80.0,
          child: Text(
            'x${factor.toStringAsFixed(0)}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: color.shade800,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 18.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9.0),
              border: Border.all(color: color.shade300, width: 1.0),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.18),
                  blurRadius: 4.0,
                  offset: Offset(0.0, 2.0),
                ),
              ],
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: widthFraction,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color.shade300, color.shade600],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(9.0),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10.0),
        SizedBox(
          width: 90.0,
          child: Text(
            '${perceivedMs.toStringAsFixed(0)} ms',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: color.shade900,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _codeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFF0A1320),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.08),
        width: 1.0,
      ),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.0,
        height: 1.45,
        color: textColor,
      ),
    ),
  );
}

Widget _pitfall(String title, String body, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.red.shade200, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withValues(alpha: 0.08),
            blurRadius: 4.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.red.shade700, size: 20.0),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  body,
                  style: TextStyle(
                    fontSize: 12.0,
                    height: 1.4,
                    color: Colors.red.shade900,
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

Widget _comparisonHeader() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.purple.shade100,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            'Symbol',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              color: Colors.purple.shade900,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Kind',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              color: Colors.purple.shade900,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            'Role',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              color: Colors.purple.shade900,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _comparisonRow(
    String symbol, String kind, String role, MaterialColor color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    margin: EdgeInsets.only(top: 6.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border(
        left: BorderSide(color: color.shade400, width: 4.0),
      ),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.08),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            symbol,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: color.shade900,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: color.shade50,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              kind,
              style: TextStyle(
                fontSize: 11.0,
                color: color.shade800,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          flex: 4,
          child: Text(
            role,
            style: TextStyle(
              fontSize: 11.5,
              color: Colors.grey.shade800,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _bullet(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 5.0, right: 8.0),
          child: Icon(Icons.check_circle, color: Colors.green.shade700, size: 14.0),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12.5,
              height: 1.4,
              color: Colors.green.shade900,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _staticAnimationDemo() {
  // Pure static "animation" demonstration — uses AlwaysStoppedAnimation.
  final fade = AlwaysStoppedAnimation<double>(0.75);
  final scale = AlwaysStoppedAnimation<double>(0.9);
  const dur = Duration.zero;

  return Container(
    margin: EdgeInsets.only(top: 8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.green.shade200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.1),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Opacity(
          opacity: fade.value,
          child: Transform.scale(
            scale: scale.value,
            child: Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.lightGreen, Colors.green.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(Icons.av_timer, color: Colors.white, size: 22.0),
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Text(
            'Static demo: AlwaysStoppedAnimation(value=${fade.value}) '
            'with Duration.zero — what timeDilation would scale at runtime.',
            style: TextStyle(
              fontSize: 11.5,
              height: 1.4,
              color: Colors.green.shade900,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: Colors.green.shade300, width: 1.0),
          ),
          child: Text(
            '${dur.inMilliseconds}ms',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.green.shade900,
            ),
          ),
        ),
      ],
    ),
  );
}

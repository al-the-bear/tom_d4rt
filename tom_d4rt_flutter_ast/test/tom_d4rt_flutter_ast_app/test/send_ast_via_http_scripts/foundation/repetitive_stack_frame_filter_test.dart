// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps
// D4rt test script: Deep Demo - RepetitiveStackFrameFilter from foundation
// Comprehensive demonstration of how repeated stack frame patterns can be
// collapsed into a compact replacement string via the StackFilter contract.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ==========================================================================
  // SECTION 1: DOSSIER - WHAT REPETITIVESTACKFRAMEFILTER IS
  // ==========================================================================

  final dossierEntries = <Map<String, String>>[
    {
      'field': 'Library',
      'value': 'package:flutter/foundation.dart',
    },
    {
      'field': 'Type',
      'value': 'class RepetitiveStackFrameFilter extends StackFilter',
    },
    {
      'field': 'Purpose',
      'value':
          'Collapses contiguous repetitions of a stack-frame pattern into a single replacement line.',
    },
    {
      'field': 'Constructor',
      'value':
          'RepetitiveStackFrameFilter({required List<PartialStackFrame> frames, required String replacement})',
    },
    {
      'field': 'Required - frames',
      'value':
          'Ordered list of PartialStackFrame entries; each entry matches a single StackFrame slot.',
    },
    {
      'field': 'Required - replacement',
      'value':
          'Text inserted in place of each fully matched repetition block.',
    },
    {
      'field': 'Method - filter()',
      'value':
          'void filter(List<StackFrame> stackFrames, List<String?> reasons)',
    },
    {
      'field': 'When useful',
      'value':
          'Recursive flutter/dart framework loops, event-pump churn, scheduled-task ping-pong, instrumentation noise.',
    },
    {
      'field': 'Why it matters',
      'value':
          'Repeated frames hide the real signal; collapsing them surfaces the failing user code higher up the trace.',
    },
    {
      'field': 'Trade-off',
      'value':
          'Information density vs. fidelity - the precise call count is preserved only when the replacement string encodes it.',
    },
    {
      'field': 'Companion - PartialStackFrame',
      'value':
          'Matcher with packageScheme, package, className, method fields - any can be sentinel "*" for wildcard.',
    },
    {
      'field': 'Companion - StackFilter',
      'value':
          'Abstract base; subclasses implement filter() and mutate the reasons[] list parallel to stackFrames.',
    },
  ];

  // ==========================================================================
  // SECTION 2: ANATOMY - CONSTRUCTOR AND METHOD SIGNATURES
  // ==========================================================================

  final anatomyRows = <Map<String, String>>[
    {
      'piece': 'PartialStackFrame.packageScheme',
      'shape': 'String',
      'role': 'Scheme like "package", "dart", "file", or "*" wildcard.',
    },
    {
      'piece': 'PartialStackFrame.package',
      'shape': 'String',
      'role': 'Library/package name; "flutter" for framework frames.',
    },
    {
      'piece': 'PartialStackFrame.className',
      'shape': 'String',
      'role': 'Owning class; empty string for top-level functions.',
    },
    {
      'piece': 'PartialStackFrame.method',
      'shape': 'String',
      'role': 'Method or function name being matched against.',
    },
    {
      'piece': 'RepetitiveStackFrameFilter.frames',
      'shape': 'List<PartialStackFrame>',
      'role':
          'The ordered repetition unit; one or more frames that must match in sequence.',
    },
    {
      'piece': 'RepetitiveStackFrameFilter.replacement',
      'shape': 'String',
      'role': 'Inserted into reasons[] at the head of every collapsed block.',
    },
    {
      'piece': 'StackFilter.filter(...)',
      'shape': 'void',
      'role':
          'Inspect stackFrames in order; write replacement strings into reasons; null means keep original.',
    },
  ];

  // ==========================================================================
  // SECTION 3: HAND-CRAFTED STACKFRAME SAMPLES
  // ==========================================================================

  // Sample A: simple repeated framework dispatch loop.
  final sampleAFrames = <_FrameSpec>[
    _FrameSpec(package: 'app', cls: 'HomePage', method: 'build'),
    _FrameSpec(package: 'flutter', cls: 'WidgetsBinding', method: 'drawFrame'),
    _FrameSpec(package: 'flutter', cls: 'WidgetsBinding', method: 'drawFrame'),
    _FrameSpec(package: 'flutter', cls: 'WidgetsBinding', method: 'drawFrame'),
    _FrameSpec(package: 'flutter', cls: 'WidgetsBinding', method: 'drawFrame'),
    _FrameSpec(package: 'flutter', cls: 'WidgetsBinding', method: 'drawFrame'),
    _FrameSpec(package: 'app', cls: 'main', method: '<async>'),
  ];

  // Sample B: two-frame repetition (handler + dispatcher loop).
  final sampleBFrames = <_FrameSpec>[
    _FrameSpec(package: 'app', cls: 'CounterStore', method: 'increment'),
    _FrameSpec(package: 'flutter', cls: 'Element', method: 'rebuild'),
    _FrameSpec(package: 'flutter', cls: 'BuildOwner', method: 'buildScope'),
    _FrameSpec(package: 'flutter', cls: 'Element', method: 'rebuild'),
    _FrameSpec(package: 'flutter', cls: 'BuildOwner', method: 'buildScope'),
    _FrameSpec(package: 'flutter', cls: 'Element', method: 'rebuild'),
    _FrameSpec(package: 'flutter', cls: 'BuildOwner', method: 'buildScope'),
    _FrameSpec(package: 'app', cls: 'main', method: '<async>'),
  ];

  // Sample C: overlapping patterns - layout vs paint.
  final sampleCFrames = <_FrameSpec>[
    _FrameSpec(package: 'app', cls: 'Gallery', method: 'build'),
    _FrameSpec(package: 'flutter', cls: 'RenderObject', method: 'layout'),
    _FrameSpec(package: 'flutter', cls: 'RenderObject', method: 'layout'),
    _FrameSpec(package: 'flutter', cls: 'RenderObject', method: 'layout'),
    _FrameSpec(package: 'flutter', cls: 'RenderObject', method: 'paint'),
    _FrameSpec(package: 'flutter', cls: 'RenderObject', method: 'paint'),
    _FrameSpec(package: 'flutter', cls: 'RenderObject', method: 'paint'),
    _FrameSpec(package: 'app', cls: 'main', method: '<async>'),
  ];

  // Sample D: scheduler ping-pong micro-task churn.
  final sampleDFrames = <_FrameSpec>[
    _FrameSpec(package: 'app', cls: 'PollService', method: 'tick'),
    _FrameSpec(package: 'dart', cls: '_Timer', method: '_runTimers'),
    _FrameSpec(package: 'dart', cls: '_Timer', method: '_runTimers'),
    _FrameSpec(package: 'dart', cls: '_Timer', method: '_runTimers'),
    _FrameSpec(package: 'dart', cls: '_Timer', method: '_runTimers'),
    _FrameSpec(package: 'flutter', cls: 'SchedulerBinding', method: 'handle'),
  ];

  // ==========================================================================
  // SECTION 4: APPLY FILTERS - BEFORE / AFTER COMPUTATION
  // ==========================================================================

  // Filter 1: collapse repeated WidgetsBinding.drawFrame.
  final drawFrameFilter = RepetitiveStackFrameFilter(
    frames: const <PartialStackFrame>[
      PartialStackFrame(
        package: 'flutter',
        className: 'WidgetsBinding',
        method: 'drawFrame',
      ),
    ],
    replacement: '... drawFrame loop collapsed ...',
  );

  // Filter 2: collapse repeated (Element.rebuild, BuildOwner.buildScope) pair.
  final rebuildPairFilter = RepetitiveStackFrameFilter(
    frames: const <PartialStackFrame>[
      PartialStackFrame(
        package: 'flutter',
        className: 'Element',
        method: 'rebuild',
      ),
      PartialStackFrame(
        package: 'flutter',
        className: 'BuildOwner',
        method: 'buildScope',
      ),
    ],
    replacement: '... rebuild/buildScope pair collapsed ...',
  );

  // Filter 3: collapse RenderObject.layout sequence.
  final layoutFilter = RepetitiveStackFrameFilter(
    frames: const <PartialStackFrame>[
      PartialStackFrame(
        package: 'flutter',
        className: 'RenderObject',
        method: 'layout',
      ),
    ],
    replacement: '... layout cascade ...',
  );

  // Filter 4: collapse RenderObject.paint sequence.
  final paintFilter = RepetitiveStackFrameFilter(
    frames: const <PartialStackFrame>[
      PartialStackFrame(
        package: 'flutter',
        className: 'RenderObject',
        method: 'paint',
      ),
    ],
    replacement: '... paint cascade ...',
  );

  // Filter 5: collapse dart _Timer._runTimers churn.
  final timerFilter = RepetitiveStackFrameFilter(
    frames: const <PartialStackFrame>[
      PartialStackFrame(
        package: 'dart',
        className: '_Timer',
        method: '_runTimers',
      ),
    ],
    replacement: '... timer pump squashed ...',
  );

  // Compute synthetic "after" views without actually running the filter
  // (since StackFrame parsing depends on a real VM trace). The collapse
  // rules below mirror what filter() would emit at runtime.
  final sampleAAfter = _collapse(
    sampleAFrames,
    pattern: <_FrameSpec>[
      _FrameSpec(package: 'flutter', cls: 'WidgetsBinding', method: 'drawFrame'),
    ],
    replacement: drawFrameFilter.replacement,
  );
  final sampleBAfter = _collapse(
    sampleBFrames,
    pattern: <_FrameSpec>[
      _FrameSpec(package: 'flutter', cls: 'Element', method: 'rebuild'),
      _FrameSpec(package: 'flutter', cls: 'BuildOwner', method: 'buildScope'),
    ],
    replacement: rebuildPairFilter.replacement,
  );
  final sampleCAfterLayout = _collapse(
    sampleCFrames,
    pattern: <_FrameSpec>[
      _FrameSpec(package: 'flutter', cls: 'RenderObject', method: 'layout'),
    ],
    replacement: layoutFilter.replacement,
  );
  final sampleCAfterBoth = _collapse(
    sampleCAfterLayout,
    pattern: <_FrameSpec>[
      _FrameSpec(package: 'flutter', cls: 'RenderObject', method: 'paint'),
    ],
    replacement: paintFilter.replacement,
  );
  final sampleDAfter = _collapse(
    sampleDFrames,
    pattern: <_FrameSpec>[
      _FrameSpec(package: 'dart', cls: '_Timer', method: '_runTimers'),
    ],
    replacement: timerFilter.replacement,
  );

  // ==========================================================================
  // SECTION 5: PATTERN MATCHING SHOWCASE
  // ==========================================================================

  final patternShowcase = <Map<String, String>>[
    {
      'kind': 'Single-frame',
      'pattern': 'WidgetsBinding.drawFrame',
      'minLength': '1',
      'matchesIn': 'Sample A',
      'gain': 'Collapses 5 frames into 1 marker line.',
    },
    {
      'kind': 'Multi-frame (pair)',
      'pattern': 'Element.rebuild + BuildOwner.buildScope',
      'minLength': '2',
      'matchesIn': 'Sample B',
      'gain':
          'Collapses 3 pairs = 6 frames into 1 marker; preserves intent of "build storm".',
    },
    {
      'kind': 'Overlapping',
      'pattern': 'RenderObject.layout / RenderObject.paint',
      'minLength': '1',
      'matchesIn': 'Sample C',
      'gain':
          'Two filters applied sequentially - each collapses its own run independently.',
    },
    {
      'kind': 'Cross-package',
      'pattern': 'dart:_Timer._runTimers',
      'minLength': '1',
      'matchesIn': 'Sample D',
      'gain': 'Repetitive dart-vm churn is hidden, framework signal remains.',
    },
    {
      'kind': 'Wildcard slot',
      'pattern': 'PartialStackFrame(method: "*")',
      'minLength': 'varies',
      'matchesIn': 'Synthetic',
      'gain':
          'Any method on a given class - useful for catching dispatch helpers regardless of overload.',
    },
  ];

  // ==========================================================================
  // SECTION 6: REPLACEMENTSTRING FORMATTING STRATEGIES
  // ==========================================================================

  final replacementStrategies = <Map<String, String>>[
    {
      'name': 'Plain marker',
      'example': '... collapsed ...',
      'use':
          'Quick triage; minimal noise, no count info.',
    },
    {
      'name': 'Named loop',
      'example': '... drawFrame loop collapsed ...',
      'use': 'Self-documenting; helpful when reading the trace later.',
    },
    {
      'name': 'Bracketed tag',
      'example': '[repeating: rebuild/buildScope]',
      'use': 'Easy to grep; pairs well with tooling that highlights brackets.',
    },
    {
      'name': 'Arrow-stylized',
      'example': '==> repeating layout cascade <==',
      'use': 'Visually pops on console output, plain text safe.',
    },
    {
      'name': 'Multilingual hint',
      'example': '... (repeated pattern omitted) ...',
      'use':
          'User-facing crash dialogs where developer slang is undesirable.',
    },
    {
      'name': 'Domain-specific',
      'example': '... timer pump squashed ...',
      'use': 'Communicates root cause to the on-call engineer at a glance.',
    },
    {
      'name': 'Empty marker (anti-pattern)',
      'example': '',
      'use':
          'Avoid - the consumer cannot tell that a collapse happened at all.',
    },
  ];

  // ==========================================================================
  // SECTION 7: COMPOSE MULTIPLE FILTERS IN SEQUENCE
  // ==========================================================================

  final composition = <Map<String, String>>[
    {
      'step': '1',
      'filter': 'drawFrameFilter',
      'targets': 'WidgetsBinding.drawFrame x5',
      'note': 'First pass cuts the framework dispatch loop.',
    },
    {
      'step': '2',
      'filter': 'rebuildPairFilter',
      'targets': 'Element.rebuild + BuildOwner.buildScope x3',
      'note':
          'Second pass cuts the build storm pair; runs after step 1 already simplified the trace.',
    },
    {
      'step': '3',
      'filter': 'layoutFilter',
      'targets': 'RenderObject.layout x3',
      'note': 'Independent collapse of layout cascade.',
    },
    {
      'step': '4',
      'filter': 'paintFilter',
      'targets': 'RenderObject.paint x3',
      'note': 'Paint cascade collapsed after layout.',
    },
    {
      'step': '5',
      'filter': 'timerFilter',
      'targets': 'dart._Timer._runTimers x4',
      'note': 'Final cleanup of scheduler churn.',
    },
  ];

  // ==========================================================================
  // SECTION 8: RECIPE CARDS - HOW TO USE
  // ==========================================================================

  final recipes = <Map<String, String>>[
    {
      'title': 'Recipe 1: Silence framework dispatch noise',
      'body':
          'Register a RepetitiveStackFrameFilter whose frames list contains the framework method called every tick. Use a friendly replacementString so triage engineers know what was omitted.',
    },
    {
      'title': 'Recipe 2: Collapse paired rebuild storms',
      'body':
          'When you see Element.rebuild followed by BuildOwner.buildScope in a loop, register a two-frame PartialStackFrame list to fold the pair.',
    },
    {
      'title': 'Recipe 3: Wildcard a noisy class',
      'body':
          'Use PartialStackFrame.method = "*" to match any method on a class. Helpful when the class internally bounces between sibling helpers.',
    },
    {
      'title': 'Recipe 4: Chain multiple filters',
      'body':
          'FlutterError.addDefaultStackFilter accepts as many filters as you need; each operates on the same reasons[] slot independently.',
    },
    {
      'title': 'Recipe 5: Preserve real user code',
      'body':
          'Never include "app" or your domain package in a PartialStackFrame - that risks hiding the real failing call.',
    },
    {
      'title': 'Recipe 6: Encode the count',
      'body':
          'If you want the collapsed line to reveal how many frames were eaten, do not use RepetitiveStackFrameFilter alone - layer a custom StackFilter that counts and rewrites.',
    },
    {
      'title': 'Recipe 7: Test your filter',
      'body':
          'Build a synthetic List<StackFrame>, pass a List<String?> of null reasons, run filter(), and assert which slots got the replacementString.',
    },
    {
      'title': 'Recipe 8: Ship the filter with the package',
      'body':
          'Library authors should register their own RepetitiveStackFrameFilter once at startup so consumers see clean traces by default.',
    },
  ];

  // ==========================================================================
  // SECTION 9: COMPARISON TABLE - FILTER STRATEGIES
  // ==========================================================================

  final comparisonRows = <Map<String, String>>[
    {
      'strategy': 'No filter',
      'frames': '7',
      'readable': 'Low - noise dominates.',
      'speed': 'Trivially fastest.',
      'verdict': 'Bad default for framework-heavy traces.',
    },
    {
      'strategy': 'Single-pattern filter',
      'frames': '3',
      'readable': 'Medium - one loop hidden.',
      'speed': 'O(n) over the stack frames.',
      'verdict': 'Good for one well-known offender.',
    },
    {
      'strategy': 'Multi-pattern filter',
      'frames': '2',
      'readable': 'High - paired loops collapsed.',
      'speed': 'O(n * patternLength).',
      'verdict': 'Best when offenders are tightly correlated.',
    },
    {
      'strategy': 'Chained filters',
      'frames': '2',
      'readable': 'Highest - all known noise removed.',
      'speed': 'O(filters * n).',
      'verdict': 'Production-grade default.',
    },
  ];

  // ==========================================================================
  // SECTION 10: GLOSSARY
  // ==========================================================================

  final glossary = <Map<String, String>>[
    {
      'term': 'StackFilter',
      'meaning':
          'Abstract base class - subclasses mutate the parallel reasons[] list to annotate or collapse frames.',
    },
    {
      'term': 'RepetitiveStackFrameFilter',
      'meaning':
          'Concrete StackFilter that collapses contiguous repetitions of a frames pattern into replacementString.',
    },
    {
      'term': 'PartialStackFrame',
      'meaning':
          'Matcher describing one frame slot - packageScheme, package, className, method. "*" is a wildcard.',
    },
    {
      'term': 'StackFrame',
      'meaning':
          'Parsed individual stack-trace line - exposes line, column, packageScheme, package, className, method, source.',
    },
    {
      'term': 'reasons[]',
      'meaning':
          'List parallel to stackFrames; filter writes non-null entries to mark collapsed slots.',
    },
    {
      'term': 'replacementString',
      'meaning':
          'Text that appears in the rendered stack trace instead of the eaten frames.',
    },
    {
      'term': 'frames',
      'meaning':
          'Ordered repetition unit of the filter; one or more PartialStackFrame entries.',
    },
    {
      'term': 'Contiguous repetition',
      'meaning':
          'Two or more back-to-back matches of the frames pattern - prerequisite for any collapse.',
    },
    {
      'term': 'Wildcard slot',
      'meaning':
          'PartialStackFrame field set to "*" - matches any value in that position.',
    },
    {
      'term': 'Trace fidelity',
      'meaning':
          'Whether the rendered stack preserves enough information to reconstruct the call chain - filters reduce fidelity in exchange for clarity.',
    },
  ];

  // ==========================================================================
  // SECTION 11: ASSEMBLE THE VISUAL WIDGET TREE
  // ==========================================================================

  return Scaffold(
    appBar: AppBar(
      title: const Text('RepetitiveStackFrameFilter - Deep Demo'),
      backgroundColor: Colors.indigo.shade700,
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _Header(
            number: '1',
            title: 'Dossier',
            subtitle:
                'A StackFilter that collapses repeated stack-frame patterns.',
          ),
          _DossierTable(rows: dossierEntries),
          const SizedBox(height: 24),
          const _Header(
            number: '2',
            title: 'Anatomy',
            subtitle:
                'Constructor parameters and the StackFilter.filter() contract.',
          ),
          _AnatomyTable(rows: anatomyRows),
          const SizedBox(height: 24),
          const _Header(
            number: '3',
            title: 'Hand-crafted StackFrame Samples',
            subtitle:
                'Synthetic traces representing common noisy repetition shapes.',
          ),
          _SampleTriptych(
            label: 'Sample A - drawFrame loop',
            frames: sampleAFrames,
          ),
          _SampleTriptych(
            label: 'Sample B - rebuild/buildScope pair',
            frames: sampleBFrames,
          ),
          _SampleTriptych(
            label: 'Sample C - layout then paint cascade',
            frames: sampleCFrames,
          ),
          _SampleTriptych(
            label: 'Sample D - timer pump churn',
            frames: sampleDFrames,
          ),
          const SizedBox(height: 24),
          const _Header(
            number: '4',
            title: 'Apply Filters - Before / After Panes',
            subtitle:
                'Red pane is the raw trace; green pane shows the collapsed view.',
          ),
          _BeforeAfter(
            title: 'drawFrameFilter on Sample A',
            replacement: drawFrameFilter.replacement,
            before: sampleAFrames,
            after: sampleAAfter,
          ),
          _BeforeAfter(
            title: 'rebuildPairFilter on Sample B',
            replacement: rebuildPairFilter.replacement,
            before: sampleBFrames,
            after: sampleBAfter,
          ),
          _BeforeAfter(
            title: 'layoutFilter then paintFilter on Sample C',
            replacement:
                '${layoutFilter.replacement} + ${paintFilter.replacement}',
            before: sampleCFrames,
            after: sampleCAfterBoth,
          ),
          _BeforeAfter(
            title: 'timerFilter on Sample D',
            replacement: timerFilter.replacement,
            before: sampleDFrames,
            after: sampleDAfter,
          ),
          const SizedBox(height: 24),
          const _Header(
            number: '5',
            title: 'Pattern Matching Showcase',
            subtitle: 'Single, multi, and overlapping patterns side by side.',
          ),
          _PatternMatchingTable(rows: patternShowcase),
          const SizedBox(height: 24),
          const _Header(
            number: '6',
            title: 'replacementString Formatting Strategies',
            subtitle:
                'Tone and shape of the marker line that replaces the eaten frames.',
          ),
          _ReplacementStrategiesList(rows: replacementStrategies),
          const SizedBox(height: 24),
          const _Header(
            number: '7',
            title: 'Compose Multiple Filters in Sequence',
            subtitle: 'Each filter runs independently on the same trace.',
          ),
          _CompositionList(rows: composition),
          const SizedBox(height: 24),
          const _Header(
            number: '8',
            title: 'Recipe Cards',
            subtitle: 'Eight practical recipes for daily use.',
          ),
          _RecipeGrid(rows: recipes),
          const SizedBox(height: 24),
          const _Header(
            number: '9',
            title: 'Comparison Table',
            subtitle: 'No filter vs. single, multi, and chained filters.',
          ),
          _ComparisonTable(rows: comparisonRows),
          const SizedBox(height: 24),
          const _Header(
            number: '10',
            title: 'Glossary',
            subtitle: 'Vocabulary for talking about stack-frame filtering.',
          ),
          _GlossaryList(rows: glossary),
          const SizedBox(height: 24),
          const _Header(
            number: '11',
            title: 'Final Notes',
            subtitle: 'A condensed cheat-sheet for the road.',
          ),
          const _ClosingNotes(),
          const SizedBox(height: 64),
        ],
      ),
    ),
  );
}

// ============================================================================
// HELPER MODELS
// ============================================================================

class _FrameSpec {
  final String package;
  final String cls;
  final String method;
  final bool isReplacement;
  const _FrameSpec({
    required this.package,
    required this.cls,
    required this.method,
    this.isReplacement = false,
  });

  factory _FrameSpec.replacement(String text) =>
      _FrameSpec(package: '', cls: '', method: text, isReplacement: true);

  @override
  String toString() {
    if (isReplacement) return method;
    return 'package:$package  $cls.$method';
  }

  bool matches(_FrameSpec pattern) {
    return package == pattern.package &&
        cls == pattern.cls &&
        method == pattern.method;
  }
}

// Mirror of RepetitiveStackFrameFilter.filter() at the synthetic-trace level.
List<_FrameSpec> _collapse(
  List<_FrameSpec> input, {
  required List<_FrameSpec> pattern,
  required String replacement,
}) {
  final result = <_FrameSpec>[];
  int index = 0;
  while (index < input.length) {
    if (_matchAt(input, index, pattern)) {
      // Count repetitions.
      int repeats = 0;
      while (_matchAt(input, index + repeats * pattern.length, pattern)) {
        repeats++;
      }
      if (repeats >= 2) {
        result.add(_FrameSpec.replacement(replacement));
        index += repeats * pattern.length;
      } else {
        // Single occurrence - keep the frames as-is.
        for (final frame in pattern) {
          result.add(frame);
        }
        index += pattern.length;
      }
    } else {
      result.add(input[index]);
      index++;
    }
  }
  return result;
}

bool _matchAt(List<_FrameSpec> input, int start, List<_FrameSpec> pattern) {
  if (start + pattern.length > input.length) return false;
  for (int i = 0; i < pattern.length; i++) {
    final candidate = input[start + i];
    if (candidate.isReplacement) return false;
    if (!candidate.matches(pattern[i])) return false;
  }
  return true;
}

// ============================================================================
// PRESENTATION WIDGETS
// ============================================================================

class _Header extends StatelessWidget {
  final String number;
  final String title;
  final String subtitle;
  const _Header({
    required this.number,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.indigo.shade700,
              shape: BoxShape.circle,
            ),
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
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

class _DossierTable extends StatelessWidget {
  final List<Map<String, String>> rows;
  const _DossierTable({required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.indigo.shade100),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: <Widget>[
          for (int i = 0; i < rows.length; i++)
            Container(
              color: i.isEven ? Colors.indigo.shade50 : Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 180,
                    child: Text(
                      rows[i]['field']!,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      rows[i]['value']!,
                      style: const TextStyle(fontSize: 13),
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

class _AnatomyTable extends StatelessWidget {
  final List<Map<String, String>> rows;
  const _AnatomyTable({required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              SizedBox(
                width: 240,
                child: Text(
                  'Piece',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 120,
                child: Text(
                  'Shape',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Text(
                  'Role',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const Divider(),
          for (final row in rows)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 240,
                    child: Text(
                      row['piece']!,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: Text(
                      row['shape']!,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      row['role']!,
                      style: const TextStyle(fontSize: 12),
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

class _SampleTriptych extends StatelessWidget {
  final String label;
  final List<_FrameSpec> frames;
  const _SampleTriptych({required this.label, required this.frames});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.amber.shade50,
          border: Border.all(color: Colors.amber.shade200),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            for (int i = 0; i < frames.length; i++)
              _FrameLine(
                index: i,
                spec: frames[i],
                emphasized: false,
              ),
          ],
        ),
      ),
    );
  }
}

class _BeforeAfter extends StatelessWidget {
  final String title;
  final String replacement;
  final List<_FrameSpec> before;
  final List<_FrameSpec> after;
  const _BeforeAfter({
    required this.title,
    required this.replacement,
    required this.before,
    required this.after,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'replacementString = "$replacement"',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Colors.indigo,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _StackPane(
                  caption: 'BEFORE',
                  paneColor: Colors.red.shade50,
                  borderColor: Colors.red.shade200,
                  frames: before,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StackPane(
                  caption: 'AFTER',
                  paneColor: Colors.green.shade50,
                  borderColor: Colors.green.shade300,
                  frames: after,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StackPane extends StatelessWidget {
  final String caption;
  final Color paneColor;
  final Color borderColor;
  final List<_FrameSpec> frames;
  const _StackPane({
    required this.caption,
    required this.paneColor,
    required this.borderColor,
    required this.frames,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: paneColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            caption,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: borderColor,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),
          for (int i = 0; i < frames.length; i++)
            _FrameLine(
              index: i,
              spec: frames[i],
              emphasized: frames[i].isReplacement,
            ),
        ],
      ),
    );
  }
}

class _FrameLine extends StatelessWidget {
  final int index;
  final _FrameSpec spec;
  final bool emphasized;
  const _FrameLine({
    required this.index,
    required this.spec,
    required this.emphasized,
  });

  @override
  Widget build(BuildContext context) {
    if (spec.isReplacement) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green.shade200,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            spec.method,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.5),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 22,
            child: Text(
              '#$index',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              spec.toString(),
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PatternMatchingTable extends StatelessWidget {
  final List<Map<String, String>> rows;
  const _PatternMatchingTable({required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.teal.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.teal.shade100,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            child: Row(
              children: const <Widget>[
                SizedBox(
                  width: 140,
                  child: Text(
                    'Kind',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Pattern',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: Text(
                    'Min Len',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 110,
                  child: Text(
                    'Matches',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          for (int i = 0; i < rows.length; i++)
            Container(
              color: i.isEven ? Colors.teal.shade50 : Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 140,
                        child: Text(rows[i]['kind']!),
                      ),
                      Expanded(
                        child: Text(
                          rows[i]['pattern']!,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: Text(rows[i]['minLength']!),
                      ),
                      SizedBox(
                        width: 110,
                        child: Text(rows[i]['matchesIn']!),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    rows[i]['gain']!,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade700,
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

class _ReplacementStrategiesList extends StatelessWidget {
  final List<Map<String, String>> rows;
  const _ReplacementStrategiesList({required this.rows});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (final row in rows)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.deepPurple.shade100),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  row['name']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    row['example']!,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  row['use']!,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _CompositionList extends StatelessWidget {
  final List<Map<String, String>> rows;
  const _CompositionList({required this.rows});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (final row in rows)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              border: Border.all(color: Colors.blueGrey.shade200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade400,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    row['step']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        row['filter']!,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'targets: ${row['targets']!}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                        ),
                      ),
                      Text(
                        row['note']!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _RecipeGrid extends StatelessWidget {
  final List<Map<String, String>> rows;
  const _RecipeGrid({required this.rows});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: <Widget>[
        for (final row in rows)
          SizedBox(
            width: 320,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                border: Border.all(color: Colors.orange.shade200),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    row['title']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    row['body']!,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _ComparisonTable extends StatelessWidget {
  final List<Map<String, String>> rows;
  const _ComparisonTable({required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.brown.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.brown.shade100,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            child: Row(
              children: const <Widget>[
                SizedBox(
                  width: 140,
                  child: Text(
                    'Strategy',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 60,
                  child: Text(
                    'Frames',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Readable',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Speed',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Verdict',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          for (int i = 0; i < rows.length; i++)
            Container(
              color: i.isEven ? Colors.brown.shade50 : Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 140,
                    child: Text(
                      rows[i]['strategy']!,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: Text(rows[i]['frames']!),
                  ),
                  Expanded(
                    child: Text(
                      rows[i]['readable']!,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      rows[i]['speed']!,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      rows[i]['verdict']!,
                      style: const TextStyle(fontSize: 12),
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

class _GlossaryList extends StatelessWidget {
  final List<Map<String, String>> rows;
  const _GlossaryList({required this.rows});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (final row in rows)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 180,
                  child: Text(
                    row['term']!,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    row['meaning']!,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _ClosingNotes extends StatelessWidget {
  const _ClosingNotes();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        border: Border.all(color: Colors.indigo.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'Cheat-sheet',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6),
          Text(
            '- Construct: RepetitiveStackFrameFilter(frames: [...], replacementString: "...")',
            style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
          ),
          Text(
            '- Register: FlutterError.addDefaultStackFilter(myFilter)',
            style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
          ),
          Text(
            '- Test: pass synthetic List<StackFrame> + reasons[] to filter() and assert.',
            style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
          ),
          Text(
            '- Compose: many filters > one giant filter; each runs in O(n).',
            style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
          ),
          Text(
            '- Avoid app-package frames in the pattern - never hide your own bugs.',
            style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — CrossFadeState
// Demonstrates CrossFadeState, the enum used by AnimatedCrossFade to
// determine which of two children is currently visible. Covers the
// two values (showFirst, showSecond), how AnimatedCrossFade uses them,
// transition mechanics, sizing behavior, and real-world patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('CrossFadeState Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — What is CrossFadeState?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.swap_horiz,
      'title': 'The Cross-Fade Pattern',
      'body': 'A cross-fade is a transition where one element fades '
          'out while another simultaneously fades in. In Flutter, '
          'AnimatedCrossFade implements this pattern for two child '
          'widgets. CrossFadeState is the enum that tells '
          'AnimatedCrossFade which child to show.',
      'accent': Colors.pink[700]!,
    },
    {
      'icon': Icons.toggle_on,
      'title': 'Two Values, Two States',
      'body': 'CrossFadeState has exactly two values: showFirst and '
          'showSecond. These correspond to the firstChild and '
          'secondChild properties of AnimatedCrossFade. When the '
          'crossFadeState property changes, the widget animates '
          'between the two children automatically.',
      'accent': Colors.pink[800]!,
    },
    {
      'icon': Icons.animation,
      'title': 'Implicit Animation',
      'body': 'AnimatedCrossFade is an implicit animation widget — '
          'you just change the crossFadeState value and it handles '
          'the transition. No AnimationController needed. The '
          'duration property controls how long the fade takes. '
          'State changes mid-animation are handled gracefully.',
      'accent': Colors.pinkAccent[400]!,
    },
    {
      'icon': Icons.height,
      'title': 'Size Transition',
      'body': 'CrossFadeState doesn\'t just control opacity — it '
          'also drives a size transition. If the two children have '
          'different sizes, AnimatedCrossFade smoothly animates '
          'the container size between them using a '
          'layoutBuilder. This prevents jarring layout jumps.',
      'accent': Colors.pink[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  final conceptWidgets = conceptCards.map<Widget>((card) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: (card['accent'] as Color).withOpacity(0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (card['accent'] as Color).withOpacity(0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(card['icon'] as IconData,
              color: card['accent'] as Color, size: 32),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card['title'] as String,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: card['accent'] as Color,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  card['body'] as String,
                  style: const TextStyle(fontSize: 13, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 2: The Two Enum Values
  // ============================================================
  print('=== Section 2: Enum Values ===');

  final enumValues = <Map<String, dynamic>>[
    {
      'value': 'CrossFadeState.showFirst',
      'index': 0,
      'meaning': 'The firstChild of AnimatedCrossFade is visible. '
          'The secondChild is hidden (opacity 0). When transitioning '
          'TO showFirst, firstChild fades in and secondChild fades out.',
      'icon': Icons.looks_one,
      'color': Colors.pink[700]!,
    },
    {
      'value': 'CrossFadeState.showSecond',
      'index': 1,
      'meaning': 'The secondChild of AnimatedCrossFade is visible. '
          'The firstChild is hidden (opacity 0). When transitioning '
          'TO showSecond, secondChild fades in and firstChild fades out.',
      'icon': Icons.looks_two,
      'color': Colors.pink[800]!,
    },
  ];

  final enumWidgets = enumValues.map<Widget>((ev) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: (ev['color'] as Color).withOpacity(0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (ev['color'] as Color).withOpacity(0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(ev['icon'] as IconData,
              color: ev['color'] as Color, size: 36),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      ev['value'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ev['color'] as Color,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: (ev['color'] as Color).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'index: ${ev['index']}',
                        style: TextStyle(
                          fontSize: 10,
                          color: ev['color'] as Color,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  ev['meaning'] as String,
                  style: const TextStyle(fontSize: 13, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  print('  Prepared ${enumValues.length} enum value descriptions');

  // ============================================================
  // SECTION 3: AnimatedCrossFade API Context
  // ============================================================
  print('=== Section 3: AnimatedCrossFade API Context ===');

  final acfProperties = <Map<String, dynamic>>[
    {
      'name': 'crossFadeState',
      'type': 'CrossFadeState',
      'desc': 'The enum value that determines which child is visible. '
          'Changing this triggers the cross-fade animation.',
      'icon': Icons.swap_horiz,
    },
    {
      'name': 'firstChild',
      'type': 'Widget',
      'desc': 'The widget shown when crossFadeState is showFirst. '
          'Typically the "default" or "idle" state of the UI.',
      'icon': Icons.looks_one,
    },
    {
      'name': 'secondChild',
      'type': 'Widget',
      'desc': 'The widget shown when crossFadeState is showSecond. '
          'Typically the "active", "loading", or "alternate" state.',
      'icon': Icons.looks_two,
    },
    {
      'name': 'duration',
      'type': 'Duration',
      'desc': 'How long the cross-fade animation takes. Applies to '
          'both the opacity fade and the size transition.',
      'icon': Icons.timer,
    },
    {
      'name': 'reverseDuration',
      'type': 'Duration?',
      'desc': 'Optional separate duration for the reverse transition. '
          'If null, duration is used for both directions.',
      'icon': Icons.timer_off,
    },
    {
      'name': 'firstCurve / secondCurve',
      'type': 'Curve',
      'desc': 'The animation curves for the first and second child '
          'opacity transitions. Defaults to Curves.linear.',
      'icon': Icons.show_chart,
    },
    {
      'name': 'sizeCurve',
      'type': 'Curve',
      'desc': 'The curve for the size animation between the two '
          'children\'s dimensions. Defaults to Curves.linear.',
      'icon': Icons.aspect_ratio,
    },
    {
      'name': 'alignment',
      'type': 'AlignmentGeometry',
      'desc': 'How both children are aligned within the animated '
          'container. Defaults to Alignment.topCenter.',
      'icon': Icons.format_align_center,
    },
    {
      'name': 'layoutBuilder',
      'type': 'AnimatedCrossFadeBuilder',
      'desc': 'Custom builder for laying out the two children '
          'during the transition. Defaults to a Stack layout. '
          'Override for custom transition geometry.',
      'icon': Icons.view_module,
    },
  ];

  print('  Prepared ${acfProperties.length} AnimatedCrossFade properties');

  final acfWidgets = acfProperties.map<Widget>((m) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.pink[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.pink[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(m['icon'] as IconData, color: Colors.pink[700], size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        m['name'] as String,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink[900],
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.pink[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        m['type'] as String,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.pink[800],
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  m['desc'] as String,
                  style: const TextStyle(fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 4: Transition Mechanics
  // ============================================================
  print('=== Section 4: Transition Mechanics ===');

  final mechanics = <Map<String, dynamic>>[
    {
      'step': '1',
      'title': 'State Change Detected',
      'detail': 'When crossFadeState changes (e.g., showFirst → '
          'showSecond), AnimatedCrossFade starts its internal '
          'AnimationController in the forward or reverse direction.',
      'icon': Icons.play_arrow,
    },
    {
      'step': '2',
      'title': 'Opacity Animation',
      'detail': 'The outgoing child\'s opacity animates from 1.0 to '
          '0.0 using its curve. The incoming child\'s opacity '
          'animates from 0.0 to 1.0 using its curve. Both happen '
          'simultaneously over the duration.',
      'icon': Icons.opacity,
    },
    {
      'step': '3',
      'title': 'Size Animation',
      'detail': 'If the two children have different sizes, the '
          'container smoothly interpolates between them using '
          'sizeCurve. This is done via the layoutBuilder which '
          'positions a Stack of both children.',
      'icon': Icons.aspect_ratio,
    },
    {
      'step': '4',
      'title': 'Layout During Transition',
      'detail': 'The default layoutBuilder places both children in '
          'a Stack, using Positioned to keep the outgoing child '
          'from affecting layout. The Stack\'s size transitions '
          'to match the incoming child.',
      'icon': Icons.layers,
    },
    {
      'step': '5',
      'title': 'Transition Complete',
      'detail': 'When the animation finishes, the outgoing child is '
          'fully transparent (opacity 0) and the incoming child '
          'is fully opaque. Both remain in the tree for instant '
          'reverse if the state changes again.',
      'icon': Icons.check_circle,
    },
  ];

  print('  Prepared ${mechanics.length} transition steps');

  final mechanicWidgets = mechanics.map<Widget>((m) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.pink[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.pink[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.pink[700],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                m['step'] as String,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  m['title'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[800],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  m['detail'] as String,
                  style: const TextStyle(fontSize: 12, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 5: Visual State Diagram
  // ============================================================
  print('=== Section 5: State Diagram ===');

  // Show the two states visually with opacity indicators
  final stateScenarios = <Map<String, dynamic>>[
    {
      'label': 'showFirst (idle)',
      'first': 1.0,
      'second': 0.0,
      'color': Colors.pink[600]!,
    },
    {
      'label': 'Transitioning (t=0.25)',
      'first': 0.75,
      'second': 0.25,
      'color': Colors.pink[500]!,
    },
    {
      'label': 'Transitioning (t=0.50)',
      'first': 0.50,
      'second': 0.50,
      'color': Colors.pink[400]!,
    },
    {
      'label': 'Transitioning (t=0.75)',
      'first': 0.25,
      'second': 0.75,
      'color': Colors.pink[500]!,
    },
    {
      'label': 'showSecond (idle)',
      'first': 0.0,
      'second': 1.0,
      'color': Colors.pink[700]!,
    },
  ];

  final stateViz = stateScenarios.map<Widget>((s) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: (s['color'] as Color).withOpacity(0.06),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              s['label'] as String,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: s['color'] as Color,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.pink[300]!.withOpacity(s['first'] as double),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.pink[200]!),
                  ),
                  child: Center(
                    child: Text('1',
                        style:
                            TextStyle(fontSize: 10, color: Colors.pink[900])),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'α=${(s['first'] as double).toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color:
                        Colors.pink[700]!.withOpacity(s['second'] as double),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.pink[200]!),
                  ),
                  child: Center(
                    child: Text('2',
                        style:
                            TextStyle(fontSize: 10, color: Colors.pink[900])),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'α=${(s['second'] as double).toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  print('  Generated ${stateScenarios.length} state visualizations');

  // ============================================================
  // SECTION 6: Real-World Patterns
  // ============================================================
  print('=== Section 6: Real-World Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Loading / Content Toggle',
      'icon': Icons.hourglass_bottom,
      'scenario': 'Show a CircularProgressIndicator as firstChild '
          'while data loads, then cross-fade to the actual content '
          'widget as secondChild. CrossFadeState transitions from '
          'showFirst to showSecond when loading completes.',
      'color': Colors.pink[600]!,
    },
    {
      'title': 'Empty State / List',
      'icon': Icons.inbox,
      'scenario': 'Show an "empty inbox" illustration when there are '
          'no items, and cross-fade to the item list when data '
          'arrives. Smoother than an abrupt swap.',
      'color': Colors.pink[700]!,
    },
    {
      'title': 'Icon Toggle Animation',
      'icon': Icons.favorite_border,
      'scenario': 'Toggle between a heart outline and a filled heart '
          'icon with a cross-fade. The transition is subtle and '
          'polished compared to an instant swap.',
      'color': Colors.red[600]!,
    },
    {
      'title': 'Form Validation Feedback',
      'icon': Icons.assignment_turned_in,
      'scenario': 'Show a "Submit" button as firstChild and a '
          '"Processing..." indicator as secondChild. Cross-fade '
          'between them when the user submits the form.',
      'color': Colors.pink[800]!,
    },
    {
      'title': 'Expanded / Collapsed Content',
      'icon': Icons.unfold_more,
      'scenario': 'Show a summary text as firstChild and detailed '
          'content as secondChild. The size transition in '
          'AnimatedCrossFade smoothly grows the container '
          'to fit the expanded content.',
      'color': Colors.pinkAccent[400]!,
    },
  ];

  print('  Prepared ${patterns.length} real-world patterns');

  final patternWidgets = patterns.map<Widget>((p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            (p['color'] as Color).withOpacity(0.08),
            (p['color'] as Color).withOpacity(0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (p['color'] as Color).withOpacity(0.25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(p['icon'] as IconData,
              color: p['color'] as Color, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p['title'] as String,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: p['color'] as Color,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  p['scenario'] as String,
                  style: const TextStyle(fontSize: 13, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 7: Alternatives & Comparison
  // ============================================================
  print('=== Section 7: Alternatives ===');

  final alternatives = <Map<String, dynamic>>[
    {
      'name': 'AnimatedCrossFade + CrossFadeState',
      'use': 'Fade between exactly 2 children with size animation',
      'pros': 'Simple API, handles size difference, implicit animation',
      'cons': 'Limited to 2 children, both stay in widget tree',
      'color': Colors.pink[700]!,
    },
    {
      'name': 'AnimatedSwitcher',
      'use': 'Fade between N children (any number)',
      'pros': 'Works with any child swap, customizable transitions',
      'cons': 'No built-in size animation, requires key management',
      'color': Colors.purple[600]!,
    },
    {
      'name': 'FadeTransition + explicit control',
      'use': 'Full control over fade timing and coordination',
      'pros': 'Maximum flexibility, composable with other transitions',
      'cons': 'Requires AnimationController, more boilerplate',
      'color': Colors.indigo[600]!,
    },
    {
      'name': 'Visibility + AnimatedOpacity',
      'use': 'Show/hide a single widget with fade',
      'pros': 'Simpler for single-widget visibility',
      'cons': 'No cross-fade, shows/hides rather than swaps',
      'color': Colors.teal[600]!,
    },
  ];

  print('  Prepared ${alternatives.length} alternatives');

  final altWidgets = alternatives.map<Widget>((a) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (a['color'] as Color).withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (a['color'] as Color).withOpacity(0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            a['name'] as String,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: a['color'] as Color,
              fontFamily: 'monospace',
            ),
          ),
          Text(
            a['use'] as String,
            style: TextStyle(
              fontSize: 11,
              color: (a['color'] as Color).withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pros',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                      Text(
                        a['pros'] as String,
                        style: const TextStyle(fontSize: 11, height: 1.3),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cons',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[700],
                        ),
                      ),
                      Text(
                        a['cons'] as String,
                        style: const TextStyle(fontSize: 11, height: 1.3),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 8: Tips & Gotchas
  // ============================================================
  print('=== Section 8: Tips & Gotchas ===');

  final tips = <Map<String, dynamic>>[
    {
      'tip': 'Both Children Are Always in the Tree',
      'body': 'AnimatedCrossFade keeps both firstChild and '
          'secondChild in the widget tree at all times (one at '
          'opacity 0). If a child has side effects (network calls, '
          'timers), they run regardless of CrossFadeState. Use '
          'Offstage or conditional logic if you need to truly '
          'remove the hidden child.',
      'warning': true,
    },
    {
      'tip': 'Size Transitions Can Clip',
      'body': 'If the two children have very different sizes, the '
          'container animates between those sizes. During the '
          'transition, the larger child may be clipped. Use '
          'clipBehavior or a custom layoutBuilder to control '
          'clipping behavior.',
      'warning': true,
    },
    {
      'tip': 'Use reverseDuration for Asymmetric Transitions',
      'body': 'Setting reverseDuration to a different value than '
          'duration creates an asymmetric feel. For example, '
          'a quick fade-in (200ms) but slower fade-out (400ms) '
          'can feel more polished for loading states.',
      'warning': false,
    },
    {
      'tip': 'Curve Selection Matters',
      'body': 'The default Curves.linear feels mechanical. Try '
          'Curves.easeInOut or Curves.easeOut for more natural '
          'transitions. The firstCurve and secondCurve can be '
          'different so the incoming child has a different feel '
          'than the outgoing one.',
      'warning': false,
    },
    {
      'tip': 'Consider AnimatedSwitcher for >2 States',
      'body': 'CrossFadeState only supports two states. If you '
          'have three or more possible views (e.g., loading, '
          'error, success), use AnimatedSwitcher instead. It '
          'accepts any child and cross-fades between changes.',
      'warning': false,
    },
  ];

  print('  Prepared ${tips.length} tips');

  final tipWidgets = tips.map<Widget>((t) {
    final isWarning = t['warning'] as bool;
    final color = isWarning ? Colors.orange[700]! : Colors.pink[700]!;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isWarning ? Icons.warning_amber : Icons.lightbulb_outline,
            color: color,
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        t['tip'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                    if (isWarning)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'GOTCHA',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[800],
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  t['body'] as String,
                  style: const TextStyle(fontSize: 12, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // ASSEMBLE FINAL LAYOUT
  // ============================================================
  print('Assembling final layout...');

  Widget sectionHeader(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink[700]!, Colors.pink[500]!],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 22),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  print('CrossFadeState Deep Demo complete — returning widget');

  return Scaffold(
    appBar: AppBar(
      title: const Text('CrossFadeState Deep Demo'),
      backgroundColor: Colors.pink[700],
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink[800]!, Colors.pink[500]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                const Icon(Icons.swap_horiz,
                    color: Colors.white, size: 44),
                const SizedBox(height: 10),
                const Text(
                  'CrossFadeState',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'The enum (showFirst / showSecond) that controls '
                  'which child is visible in AnimatedCrossFade — '
                  'driving smooth cross-fade transitions between '
                  'two widgets.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.pink[100],
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Section 1: Concept
          sectionHeader('Concept', Icons.school),
          ...conceptWidgets,

          // Section 2: Enum Values
          sectionHeader('Enum Values', Icons.list),
          ...enumWidgets,

          // Section 3: AnimatedCrossFade Context
          sectionHeader('AnimatedCrossFade API', Icons.api),
          ...acfWidgets,

          // Section 4: Transition Mechanics
          sectionHeader('Transition Mechanics', Icons.settings),
          ...mechanicWidgets,

          // Section 5: State Diagram
          sectionHeader('Opacity During Transition', Icons.gradient),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.pink[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.pink[200]!),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(flex: 3, child: SizedBox()),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'First Child',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Second Child',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink[800],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ...stateViz,
              ],
            ),
          ),

          // Section 6: Real-World Patterns
          sectionHeader('Real-World Patterns', Icons.apps),
          ...patternWidgets,

          // Section 7: Alternatives
          sectionHeader('Alternatives & Comparison', Icons.compare),
          ...altWidgets,

          // Section 8: Tips & Gotchas
          sectionHeader('Tips & Gotchas', Icons.tips_and_updates),
          ...tipWidgets,

          const SizedBox(height: 30),
        ],
      ),
    ),
  );
}

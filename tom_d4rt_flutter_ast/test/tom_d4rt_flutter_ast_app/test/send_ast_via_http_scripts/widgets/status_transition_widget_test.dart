// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — StatusTransitionWidget
// Demonstrates StatusTransitionWidget, an abstract base class for widgets
// that rebuild whenever an Animation changes status. Subclasses override
// build to react to AnimationStatus (forward, reverse, completed, dismissed).
// This is the foundation for widgets like FadeTransition, ScaleTransition, etc.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('StatusTransitionWidget Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.sync,
      'title': 'What is StatusTransitionWidget?',
      'body': 'StatusTransitionWidget is an abstract StatefulWidget that '
          'listens to an Animation\'s status changes and triggers a rebuild '
          'whenever the status transitions (forward, reverse, completed, '
          'dismissed). Subclasses only need to implement build().',
      'accent': Colors.amber,
    },
    {
      'icon': Icons.architecture,
      'title': 'Why It Exists',
      'body': 'Flutter\'s built-in transition widgets (FadeTransition, '
          'ScaleTransition, etc.) extend this class. It extracts the '
          'boilerplate of subscribing to animation status changes so '
          'each transition only defines its visual logic.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.compare_arrows,
      'title': 'Status vs Value Listening',
      'body': 'AnimatedWidget rebuilds on every value change (each frame). '
          'StatusTransitionWidget rebuilds only on status changes — '
          'typically 4 events per animation cycle. Use it when you '
          'only care about animation phases, not per-frame values.',
      'accent': Colors.green,
    },
    {
      'icon': Icons.extension,
      'title': 'How to Subclass',
      'body': 'Extend StatusTransitionWidget, pass an animation to super, '
          'and implement build(). Your build method can inspect '
          'animation.status to show different UI for each phase.',
      'accent': Colors.deepOrange,
    },
  ];

  final conceptCards = <Widget>[];
  for (var idx = 0; idx < conceptItems.length; idx++) {
    final e = conceptItems[idx];
    final accent = e['accent'] as Color;
    print('Concept ${idx + 1}: ${e['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accent.withOpacity(0.12), accent.withOpacity(0.03)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: accent.withOpacity(0.3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(e['icon'] as IconData, color: accent, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      e['body'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade800,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 2: AnimationStatus Lifecycle
  // ============================================================
  print('=== Section 2: Lifecycle ===');

  final statuses = <Map<String, dynamic>>[
    {
      'status': 'dismissed',
      'desc': 'Animation is at value 0.0. The initial resting state '
          'before forward() is called or after reverse() completes.',
      'value': '0.0',
      'icon': Icons.stop_circle_outlined,
      'color': Colors.grey,
    },
    {
      'status': 'forward',
      'desc': 'Animation is running from dismissed toward completed. '
          'Value is increasing from 0.0 toward 1.0.',
      'value': '0.0 → 1.0',
      'icon': Icons.play_arrow,
      'color': Colors.green,
    },
    {
      'status': 'completed',
      'desc': 'Animation has reached value 1.0. The animation is at rest '
          'until reverse() is called or the controller is reset.',
      'value': '1.0',
      'icon': Icons.check_circle_outline,
      'color': Colors.blue,
    },
    {
      'status': 'reverse',
      'desc': 'Animation is running from completed back toward dismissed. '
          'Value is decreasing from 1.0 toward 0.0.',
      'value': '1.0 → 0.0',
      'icon': Icons.replay,
      'color': Colors.orange,
    },
  ];

  final statusWidgets = <Widget>[];
  for (var i = 0; i < statuses.length; i++) {
    final s = statuses[i];
    final sColor = s['color'] as Color;
    print('Status ${i + 1}: ${s['status']}');
    statusWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Row(
          children: [
            // Step number + connector
            Column(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: sColor.withOpacity(0.15),
                    shape: BoxShape.circle,
                    border: Border.all(color: sColor, width: 2),
                  ),
                  child: Icon(s['icon'] as IconData, color: sColor, size: 20),
                ),
                if (i < statuses.length - 1)
                  Container(
                    width: 2,
                    height: 20,
                    color: Colors.grey.withOpacity(0.3),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: sColor.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: sColor.withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'AnimationStatus.${s['status']}',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: sColor,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: sColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'value: ${s['value']}',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 10,
                              color: sColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      s['desc'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade700,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: Common Subclasses
  // ============================================================
  print('=== Section 3: Subclasses ===');

  final subclasses = <Map<String, dynamic>>[
    {
      'name': 'FadeTransition',
      'property': 'opacity',
      'desc': 'Animates child widget opacity from 0.0 to 1.0 based '
          'on the animation value.',
      'icon': Icons.opacity,
      'color': Colors.amber,
    },
    {
      'name': 'ScaleTransition',
      'property': 'scale',
      'desc': 'Scales the child up or down based on the animation value. '
          'Optionally around a custom alignment.',
      'icon': Icons.zoom_in,
      'color': Colors.blue,
    },
    {
      'name': 'RotationTransition',
      'property': 'turns',
      'desc': 'Rotates the child by the animation value expressed in turns '
          '(1.0 = 360 degrees).',
      'icon': Icons.rotate_right,
      'color': Colors.purple,
    },
    {
      'name': 'SlideTransition',
      'property': 'position',
      'desc': 'Slides the child by an Offset animation. The offset is '
          'relative to the child\'s normal position.',
      'icon': Icons.open_with,
      'color': Colors.green,
    },
    {
      'name': 'SizeTransition',
      'property': 'sizeFactor',
      'desc': 'Animates the clip size of the child along one axis. '
          'Creates a reveal or collapse effect.',
      'icon': Icons.height,
      'color': Colors.red,
    },
    {
      'name': 'DecoratedBoxTransition',
      'property': 'decoration',
      'desc': 'Animates the decoration of a DecoratedBox, interpolating '
          'between two DecorationTween values.',
      'icon': Icons.format_paint,
      'color': Colors.teal,
    },
  ];

  final subclassWidgets = <Widget>[];
  for (var i = 0; i < subclasses.length; i++) {
    final sc = subclasses[i];
    final scColor = sc['color'] as Color;
    print('Subclass ${i + 1}: ${sc['name']}');
    subclassWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: scColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: scColor.withOpacity(0.15)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: scColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(sc['icon'] as IconData, color: scColor, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        sc['name'] as String,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: scColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: scColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          sc['property'] as String,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 10,
                            color: scColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    sc['desc'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade700,
                      height: 1.3,
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

  // ============================================================
  // SECTION 4: Status-Based UI Pattern
  // ============================================================
  print('=== Section 4: Status UI ===');

  final statusUI = <Map<String, dynamic>>[
    {
      'status': 'dismissed',
      'title': 'Show Entry Button',
      'desc': 'Before animation starts, display the trigger UI (e.g., '
          'a "Show Details" button). The content is fully hidden.',
      'color': Colors.grey,
      'uiPreview': 'button',
    },
    {
      'status': 'forward',
      'title': 'Show Loading / Transition',
      'desc': 'While animating forward, optionally show a progress '
          'indicator or transition element.',
      'color': Colors.green,
      'uiPreview': 'loading',
    },
    {
      'status': 'completed',
      'title': 'Show Full Content',
      'desc': 'Animation complete — display the target content. '
          'Add a "Dismiss" action if the user can reverse.',
      'color': Colors.blue,
      'uiPreview': 'content',
    },
    {
      'status': 'reverse',
      'title': 'Show Exit Transition',
      'desc': 'While animating in reverse, the content is leaving. '
          'Optionally show a fade-out effect.',
      'color': Colors.orange,
      'uiPreview': 'fading',
    },
  ];

  final statusUIWidgets = <Widget>[];
  for (var i = 0; i < statusUI.length; i++) {
    final su = statusUI[i];
    final suColor = su['color'] as Color;
    print('Status UI ${i + 1}: ${su['title']}');

    // Create a small UI preview for each status
    Widget preview;
    switch (su['uiPreview']) {
      case 'button':
        preview = Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.15),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Text(
            'Show Details',
            style: TextStyle(fontSize: 11, color: Colors.amber, fontWeight: FontWeight.bold),
          ),
        );
        break;
      case 'loading':
        preview = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(suColor),
              ),
            ),
            const SizedBox(width: 8),
            Text('Loading...', style: TextStyle(fontSize: 11, color: suColor)),
          ],
        );
        break;
      case 'content':
        preview = Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: suColor.withOpacity(0.08),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Text(
            'Full content visible',
            style: TextStyle(fontSize: 11),
          ),
        );
        break;
      default:
        preview = Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: suColor.withOpacity(0.06),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'Fading out...',
            style: TextStyle(
              fontSize: 11,
              color: suColor.withOpacity(0.5),
              fontStyle: FontStyle.italic,
            ),
          ),
        );
    }

    statusUIWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: suColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: suColor.withOpacity(0.2)),
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
                    color: suColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: suColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        su['title'] as String,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: suColor,
                        ),
                      ),
                      Text(
                        'status: ${su['status']}',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          color: suColor.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              su['desc'] as String,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade700,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.04),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.withOpacity(0.1)),
              ),
              child: Center(child: preview),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Class Hierarchy
  // ============================================================
  print('=== Section 5: Hierarchy ===');

  final hierarchy = <Map<String, dynamic>>[
    {
      'level': 0,
      'name': 'Widget',
      'desc': 'Base class for all widgets.',
      'color': Colors.grey,
    },
    {
      'level': 1,
      'name': 'StatefulWidget',
      'desc': 'Widget with mutable state.',
      'color': Colors.grey,
    },
    {
      'level': 2,
      'name': 'StatusTransitionWidget',
      'desc': 'Rebuilds on animation status changes. Abstract.',
      'color': Colors.amber,
    },
    {
      'level': 3,
      'name': 'FadeTransition',
      'desc': 'Applies animated opacity via the animation value.',
      'color': Colors.blue,
    },
    {
      'level': 3,
      'name': 'ScaleTransition',
      'desc': 'Applies animated scale transform.',
      'color': Colors.green,
    },
    {
      'level': 3,
      'name': 'RotationTransition',
      'desc': 'Applies animated rotation in turns.',
      'color': Colors.purple,
    },
    {
      'level': 3,
      'name': 'SlideTransition',
      'desc': 'Applies animated positional offset.',
      'color': Colors.orange,
    },
    {
      'level': 3,
      'name': 'Custom Subclass',
      'desc': 'Your own status-aware transition widget.',
      'color': Colors.red,
    },
  ];

  final hierarchyWidgets = <Widget>[];
  for (var i = 0; i < hierarchy.length; i++) {
    final h = hierarchy[i];
    final hColor = h['color'] as Color;
    final indent = (h['level'] as int) * 24.0;
    print('Hierarchy ${i + 1}: ${h['name']}');
    hierarchyWidgets.add(
      Container(
        margin: EdgeInsets.only(left: 16 + indent, right: 16, top: 3, bottom: 3),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: hColor.withOpacity(h['level'] == 2 ? 0.1 : 0.04),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: hColor.withOpacity(h['level'] == 2 ? 0.4 : 0.15),
            width: h['level'] == 2 ? 2.0 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Text(
              h['name'] as String,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: h['level'] == 2
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: hColor,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                h['desc'] as String,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 6: Implementation Pattern
  // ============================================================
  print('=== Section 6: Implementation ===');

  final implSteps = <Map<String, dynamic>>[
    {
      'step': 'Extend StatusTransitionWidget',
      'code': 'class MyTransition extends StatusTransitionWidget {\n'
          '  const MyTransition({\n'
          '    required Animation<double> animation,\n'
          '  }) : super(animation: animation);\n'
          '}',
      'note': 'Pass the animation to the super constructor. The base '
          'class handles listener registration.',
      'color': Colors.amber,
    },
    {
      'step': 'Implement build',
      'code': 'Widget build(BuildContext context) {\n'
          '  final status = animation.status;\n'
          '  if (status == AnimationStatus.dismissed) {\n'
          '    return const SizedBox.shrink();\n'
          '  }\n'
          '  return Opacity(\n'
          '    opacity: animation.value,\n'
          '    child: child,\n'
          '  );\n'
          '}',
      'note': 'Inspect animation.status and animation.value. Return '
          'different widgets per status if needed.',
      'color': Colors.blue,
    },
    {
      'step': 'Use the widget',
      'code': 'MyTransition(\n'
          '  animation: _controller,\n'
          '  child: const Text(\'Hello\'),\n'
          ')',
      'note': 'Pass an AnimationController (or any Animation). The widget '
          'rebuilds on status changes automatically.',
      'color': Colors.green,
    },
  ];

  final implWidgets = <Widget>[];
  for (var i = 0; i < implSteps.length; i++) {
    final imp = implSteps[i];
    final impColor = imp['color'] as Color;
    print('Impl ${i + 1}: ${imp['step']}');
    implWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: impColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: impColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: impColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: impColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    imp['step'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: impColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: impColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  imp['code'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: impColor,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                imp['note'] as String,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 7: Comparison
  // ============================================================
  print('=== Section 7: Comparison ===');

  final comparisons = <Map<String, dynamic>>[
    {
      'widget': 'StatusTransitionWidget',
      'rebuilds': 'On status change (4 per cycle)',
      'extends': 'StatefulWidget',
      'bestFor': 'Phase-dependent UI',
      'icon': Icons.sync,
      'color': Colors.amber,
    },
    {
      'widget': 'AnimatedWidget',
      'rebuilds': 'On every value change (60 per second)',
      'extends': 'StatefulWidget',
      'bestFor': 'Per-frame visual updates',
      'icon': Icons.animation,
      'color': Colors.blue,
    },
    {
      'widget': 'AnimatedBuilder',
      'rebuilds': 'On every value change (with child)',
      'extends': 'StatefulWidget',
      'bestFor': 'Inline transitions with const child',
      'icon': Icons.build,
      'color': Colors.green,
    },
    {
      'widget': 'ImplicitlyAnimatedWidget',
      'rebuilds': 'When target value changes',
      'extends': 'StatefulWidget',
      'bestFor': 'Declarative animations (AnimatedContainer)',
      'icon': Icons.auto_fix_high,
      'color': Colors.purple,
    },
  ];

  final compWidgets = <Widget>[];
  for (var i = 0; i < comparisons.length; i++) {
    final c = comparisons[i];
    final cColor = c['color'] as Color;
    print('Compare ${i + 1}: ${c['widget']}');
    compWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cColor.withOpacity(i == 0 ? 0.1 : 0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: cColor.withOpacity(i == 0 ? 0.4 : 0.2),
            width: i == 0 ? 2.0 : 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: cColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(c['icon'] as IconData, color: cColor, size: 20),
                ),
                const SizedBox(width: 10),
                Text(
                  c['widget'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: cColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _compRow('Rebuilds', c['rebuilds'] as String, cColor),
            const SizedBox(height: 4),
            _compRow('Extends', c['extends'] as String, cColor),
            const SizedBox(height: 4),
            _compRow('Best for', c['bestFor'] as String, cColor),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.sync,
      'text': 'StatusTransitionWidget is an abstract StatefulWidget that '
          'rebuilds its subtree when an Animation\'s status changes.',
    },
    {
      'icon': Icons.compare_arrows,
      'text': 'Unlike AnimatedWidget (rebuilds per frame), it only '
          'rebuilds on status transitions: dismissed, forward, '
          'completed, and reverse.',
    },
    {
      'icon': Icons.architecture,
      'text': 'FadeTransition, ScaleTransition, RotationTransition, '
          'SlideTransition, and more all extend this base class.',
    },
    {
      'icon': Icons.extension,
      'text': 'To create a custom status-aware transition: extend '
          'StatusTransitionWidget, pass animation to super, and '
          'implement build().',
    },
    {
      'icon': Icons.speed,
      'text': 'More efficient than AnimatedWidget when visual updates '
          'only need to happen at phase boundaries, not every frame.',
    },
    {
      'icon': Icons.layers,
      'text': 'Subclasses can inspect animation.status to show different '
          'UI for each phase — e.g., skeleton loading while forward, '
          'full content when completed.',
    },
  ];

  final summaryWidgets = <Widget>[];
  for (var i = 0; i < summaryPoints.length; i++) {
    final sp = summaryPoints[i];
    print('Summary ${i + 1}: ${(sp['text'] as String).substring(0, 40)}...');
    summaryWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.amber.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.amber.withOpacity(0.15)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.amber.shade800,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                sp['text'] as String,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade800,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ASSEMBLE TABBED LAYOUT
  // ============================================================
  print('Assembling tabbed layout');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('StatusTransitionWidget'),
        backgroundColor: Colors.amber.shade800,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.sync), text: 'Lifecycle'),
            Tab(icon: Icon(Icons.extension), text: 'Subclasses'),
            Tab(icon: Icon(Icons.widgets), text: 'Status UI'),
            Tab(icon: Icon(Icons.account_tree), text: 'Hierarchy'),
            Tab(icon: Icon(Icons.code), text: 'Implement'),
            Tab(icon: Icon(Icons.compare), text: 'Compare'),
            Tab(icon: Icon(Icons.summarize), text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1: Concept
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'StatusTransitionWidget: an abstract base for widgets '
                  'that rebuild when animation status changes.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),

          // Tab 2: Lifecycle
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'The four animation statuses form a cycle: '
                  'dismissed → forward → completed → reverse → dismissed.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...statusWidgets,
            ],
          ),

          // Tab 3: Subclasses
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Flutter provides several built-in subclasses of '
                  'StatusTransitionWidget for common transitions.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...subclassWidgets,
            ],
          ),

          // Tab 4: Status UI
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Different UI for each animation phase — a common '
                  'pattern with StatusTransitionWidget subclasses.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...statusUIWidgets,
            ],
          ),

          // Tab 5: Hierarchy
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Class hierarchy showing how StatusTransitionWidget '
                  'sits between StatefulWidget and concrete transitions.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...hierarchyWidgets,
            ],
          ),

          // Tab 6: Implement
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Three steps to create a custom StatusTransitionWidget '
                  'subclass.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...implWidgets,
            ],
          ),

          // Tab 7: Compare
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How StatusTransitionWidget compares to other animation '
                  'base classes in Flutter.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...compWidgets,
            ],
          ),

          // Tab 8: Summary
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.amber.withOpacity(0.12),
                      Colors.orange.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about StatusTransitionWidget.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ...summaryWidgets,
            ],
          ),
        ],
      ),
    ),
  );
}

/// Helper that creates a label-value row for comparison cards.
Widget _compRow(String label, String value, Color color) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 70,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: color.withOpacity(0.7),
          ),
        ),
      ),
      Expanded(
        child: Text(
          value,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade700,
          ),
        ),
      ),
    ],
  );
}

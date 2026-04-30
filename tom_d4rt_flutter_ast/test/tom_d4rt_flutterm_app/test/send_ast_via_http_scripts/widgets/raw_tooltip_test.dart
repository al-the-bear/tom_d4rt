// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — RawTooltip
// Demonstrates RawTooltip — a low-level, customizable tooltip widget that
// displays overlay content in response to hover, tap, long-press, or manual
// trigger. Provides full control over tooltip appearance and animation.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawTooltip Deep Demo executing');

  // ============================================================
  // SECTION 1: What RawTooltip Is — Concept
  // ============================================================
  print('=== Section 1: RawTooltip Concept ===');

  // RawTooltip is the low-level building block for all tooltip
  // functionality in Flutter. Unlike the Material Tooltip widget,
  // RawTooltip gives full control over:
  //   - Tooltip appearance (via tooltipBuilder callback)
  //   - Animation curves and durations
  //   - Trigger behavior (hover, tap, longPress, manual)
  //   - Positioning (via positionDelegate)
  //   - Timing (hover delay, touch delay, dismiss delay)
  //   - Feedback (haptic/acoustic)
  //
  // The Material Tooltip widget is built on top of RawTooltip,
  // adding Material-specific decoration and theme integration.

  final conceptCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF006064), Color(0xFF00838F)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.3),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.chat_bubble_outline, color: Colors.white, size: 30.0),
            SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RawTooltip',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'extends StatefulWidget',
                  style: TextStyle(
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'A low-level tooltip widget that displays an overlay in '
            'response to user interactions. Provides full control over '
            'tooltip building, animation, positioning, and trigger '
            'behavior. The Material Tooltip widget wraps RawTooltip '
            'with theme-aware decoration.',
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white.withValues(alpha: 0.9),
              height: 1.5,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildConceptChip('Overlay', Icons.layers, Color(0xFF4DD0E1)),
            _buildConceptChip('Animation', Icons.animation, Color(0xFFA5D6A7)),
            _buildConceptChip('Positioning', Icons.open_with, Color(0xFFFFCC80)),
          ],
        ),
      ],
    ),
  );

  print('  Concept card built');

  // ============================================================
  // SECTION 2: Required Constructor Parameters
  // ============================================================
  print('=== Section 2: Required Parameters ===');

  // RawTooltip has three required parameters:
  // 1. semanticsTooltip (String?) — Text for screen readers
  // 2. tooltipBuilder (TooltipComponentBuilder) — Builds overlay content
  // 3. child (Widget) — The widget that triggers the tooltip

  final requiredParamsSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Required Constructor Parameters', Icons.star),
        SizedBox(height: 12.0),
        _buildParamCard(
          'semanticsTooltip',
          'String?',
          'required',
          'Text read by screen readers (TalkBack, VoiceOver). '
          'Set to a descriptive string for accessibility, or '
          'explicitly null if no semantic description is needed.',
          Color(0xFFE65100),
          Icons.accessibility,
          'semanticsTooltip: \'Copy to clipboard\'',
        ),
        SizedBox(height: 10.0),
        _buildParamCard(
          'tooltipBuilder',
          'TooltipComponentBuilder',
          'required',
          'Callback that builds the tooltip overlay widget. '
          'Receives BuildContext and Animation<double>. '
          'The animation goes 0→1 when showing, 1→0 when hiding. '
          'Used to create FadeTransition, ScaleTransition, etc.',
          Color(0xFF1565C0),
          Icons.build,
          'tooltipBuilder: (ctx, animation) {\n'
          '  return FadeTransition(\n'
          '    opacity: animation,\n'
          '    child: Container(\n'
          '      padding: EdgeInsets.all(8),\n'
          '      color: Colors.grey,\n'
          '      child: Text(\'Tooltip!\'),\n'
          '    ),\n'
          '  );\n'
          '}',
        ),
        SizedBox(height: 10.0),
        _buildParamCard(
          'child',
          'Widget',
          'required',
          'The widget that the user interacts with to trigger '
          'the tooltip. Commonly an Icon, Text, or Button.',
          Color(0xFF2E7D32),
          Icons.child_care,
          'child: Icon(Icons.info)',
        ),
      ],
    ),
  );

  print('  Required params section built');

  // ============================================================
  // SECTION 3: TooltipTriggerMode — Trigger Behavior
  // ============================================================
  print('=== Section 3: Trigger Modes ===');

  // TooltipTriggerMode enum controls how TOUCH events trigger:
  //   - manual: Only via ensureTooltipVisible()
  //   - longPress: After long press (default)
  //   - tap: After single tap
  //
  // IMPORTANT: Mouse hover ALWAYS shows tooltip regardless of triggerMode

  final triggerSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('TooltipTriggerMode — Touch Trigger Behavior', Icons.touch_app),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFFE0F2F1),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFF80CBC4)),
          ),
          child: Row(
            children: [
              Icon(Icons.mouse, color: Color(0xFF00695C), size: 20.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Mouse hover always triggers tooltip, regardless of triggerMode.',
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: Color(0xFF00695C)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildTriggerCard(
                'manual',
                'Only programmatic trigger via\nensureTooltipVisible()',
                Icons.code,
                Color(0xFF6A1B9A),
                'TooltipTriggerMode.manual',
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _buildTriggerCard(
                'longPress',
                'Touch and hold to show.\nDefault trigger mode.',
                Icons.touch_app,
                Color(0xFF1565C0),
                'TooltipTriggerMode.longPress',
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _buildTriggerCard(
                'tap',
                'Single tap to show.\nDismiss after touchDelay.',
                Icons.ads_click,
                Color(0xFF2E7D32),
                'TooltipTriggerMode.tap',
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildCodeSnippetCard(
          '// Touch trigger modes:\n'
          'RawTooltip(\n'
          '  triggerMode: TooltipTriggerMode.longPress, // default\n'
          '  // OR\n'
          '  triggerMode: TooltipTriggerMode.tap,\n'
          '  // OR\n'
          '  triggerMode: TooltipTriggerMode.manual,\n'
          '  ...\n'
          ')',
        ),
      ],
    ),
  );

  print('  Trigger modes section built');

  // ============================================================
  // SECTION 4: Timing Parameters
  // ============================================================
  print('=== Section 4: Timing Parameters ===');

  // RawTooltip has three timing parameters:
  // - hoverDelay: time pointer must hover before tooltip shows
  // - touchDelay: time tooltip stays visible after touch release
  // - dismissDelay: time after hover stops before tooltip hides

  final timingSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Timing Parameters', Icons.timer),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Color(0xFFCE93D8)),
          ),
          child: Column(
            children: [
              _buildTimingRow(
                'hoverDelay',
                'Duration.zero',
                'How long pointer must hover before tooltip appears. '
                'Set to Duration.zero for instant show on hover.',
                Color(0xFF6A1B9A),
                '0ms',
              ),
              Divider(height: 16.0, color: Color(0xFFCE93D8)),
              _buildTimingRow(
                'touchDelay',
                '1500ms',
                'How long tooltip stays visible after touch release '
                '(longPress or tap). Does not affect mouse hover.',
                Color(0xFF1565C0),
                '1.5s',
              ),
              Divider(height: 16.0, color: Color(0xFFCE93D8)),
              _buildTimingRow(
                'dismissDelay',
                '100ms',
                'How long after hover stops before tooltip hides. '
                'Small delay prevents flicker during micro-movements.',
                Color(0xFFE65100),
                '100ms',
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        // Timeline visualization
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xFFE0E0E0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mouse Hover Timeline',
                style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Color(0xFF212121)),
              ),
              SizedBox(height: 10.0),
              _buildTimelineStep('Mouse enters widget', 'hoverDelay begins', Color(0xFF6A1B9A)),
              _buildTimelineStep('hoverDelay expires', 'Tooltip SHOWS (animation 0→1)', Color(0xFF2E7D32)),
              _buildTimelineStep('Mouse leaves widget', 'dismissDelay begins', Color(0xFFE65100)),
              _buildTimelineStep('dismissDelay expires', 'Tooltip HIDES (animation 1→0)', Color(0xFFC62828)),
              SizedBox(height: 12.0),
              Text(
                'Touch Timeline (longPress mode)',
                style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Color(0xFF212121)),
              ),
              SizedBox(height: 10.0),
              _buildTimelineStep('User long-presses', 'Tooltip SHOWS immediately', Color(0xFF1565C0)),
              _buildTimelineStep('User releases', 'touchDelay begins', Color(0xFF6A1B9A)),
              _buildTimelineStep('touchDelay expires', 'Tooltip HIDES (animation 1→0)', Color(0xFFC62828)),
            ],
          ),
        ),
      ],
    ),
  );

  print('  Timing section built');

  // ============================================================
  // SECTION 5: tooltipBuilder — Animation Integration
  // ============================================================
  print('=== Section 5: tooltipBuilder Animation ===');

  // The tooltipBuilder receives an Animation<double> that goes
  // 0.0→1.0 when showing and 1.0→0.0 when hiding.
  // This allows driving FadeTransition, ScaleTransition,
  // SlideTransition, or custom animated content.

  final builderSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('tooltipBuilder — Animation Integration', Icons.animation),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xFF90CAF9)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'typedef TooltipComponentBuilder =\n'
                '  Widget Function(BuildContext, Animation<double>);',
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: Color(0xFF1565C0),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'The animation parameter lets you create smooth '
                'entrance/exit transitions for the tooltip content. '
                'Wrap your tooltip widget in a Transition widget '
                'that uses this animation.',
                style: TextStyle(fontSize: 12.0, color: Color(0xFF0D47A1), height: 1.4),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        // Examples of different animation patterns
        Text(
          'Common Animation Patterns:',
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Color(0xFF212121)),
        ),
        SizedBox(height: 8.0),
        _buildAnimationPatternCard(
          'Fade Transition',
          'FadeTransition(\n'
          '  opacity: animation,\n'
          '  child: tooltipContent,\n'
          ')',
          Color(0xFF1565C0),
          'Smoothly fades the tooltip in and out. Most common pattern.',
        ),
        SizedBox(height: 8.0),
        _buildAnimationPatternCard(
          'Scale Transition',
          'ScaleTransition(\n'
          '  scale: animation,\n'
          '  child: tooltipContent,\n'
          ')',
          Color(0xFF2E7D32),
          'Tooltip grows from zero to full size. Playful effect.',
        ),
        SizedBox(height: 8.0),
        _buildAnimationPatternCard(
          'Combined Fade + Scale',
          'FadeTransition(\n'
          '  opacity: animation,\n'
          '  child: ScaleTransition(\n'
          '    scale: animation,\n'
          '    child: tooltipContent,\n'
          '  ),\n'
          ')',
          Color(0xFFE65100),
          'Tooltip fades in while scaling up — rich transition.',
        ),
        SizedBox(height: 8.0),
        _buildAnimationPatternCard(
          'Slide + Fade',
          'SlideTransition(\n'
          '  position: Tween<Offset>(\n'
          '    begin: Offset(0, 0.2),\n'
          '    end: Offset.zero,\n'
          '  ).animate(animation),\n'
          '  child: FadeTransition(\n'
          '    opacity: animation,\n'
          '    child: tooltipContent,\n'
          '  ),\n'
          ')',
          Color(0xFF6A1B9A),
          'Tooltip slides in from below while fading in.',
        ),
      ],
    ),
  );

  print('  Builder animation section built');

  // ============================================================
  // SECTION 6: AnimationStyle Configuration
  // ============================================================
  print('=== Section 6: AnimationStyle ===');

  // The animationStyle parameter controls the animation curves
  // and durations for both show and hide transitions.

  final animStyleSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('AnimationStyle — Timing & Curves', Icons.speed),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xFFFFB74D)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Default AnimationStyle:',
                style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Color(0xFFE65100)),
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xFF263238),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'AnimationStyle(\n'
                  '  curve: Curves.fastOutSlowIn,\n'
                  '  duration: Duration(milliseconds: 150),\n'
                  '  reverseDuration: Duration(milliseconds: 75),\n'
                  ')',
                  style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: Color(0xFF80CBC4)),
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: _buildAnimConfigItem(
                      'duration',
                      '150ms',
                      'Show animation duration',
                      Color(0xFF2E7D32),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: _buildAnimConfigItem(
                      'reverseDuration',
                      '75ms',
                      'Hide animation duration',
                      Color(0xFFC62828),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child: _buildAnimConfigItem(
                      'curve',
                      'fastOutSlowIn',
                      'Show curve',
                      Color(0xFF1565C0),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: _buildAnimConfigItem(
                      'reverseCurve',
                      'same as curve',
                      'Hide curve (if null)',
                      Color(0xFF6A1B9A),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xFFFFECB3),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Row(
                  children: [
                    Icon(Icons.lightbulb_outline, size: 16.0, color: Color(0xFFF57F17)),
                    SizedBox(width: 6.0),
                    Expanded(
                      child: Text(
                        'Use AnimationStyle.noAnimation to disable animation entirely.',
                        style: TextStyle(fontSize: 11.0, color: Color(0xFFF57F17)),
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

  print('  AnimationStyle section built');

  // ============================================================
  // SECTION 7: Live RawTooltip Examples
  // ============================================================
  print('=== Section 7: Live Examples ===');

  // Live demonstrations of RawTooltip with different configurations.

  final liveSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Live RawTooltip Examples', Icons.play_circle_outline),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Hover over or interact with the widgets below to see '
            'tooltips in action. Each uses a different configuration.',
            style: TextStyle(fontSize: 12.0, color: Color(0xFF2E7D32)),
          ),
        ),
        SizedBox(height: 12.0),
        // Example 1: Simple fade tooltip with longPress trigger
        _buildLiveExampleWrapper(
          'Fade Tooltip (longPress)',
          'Long-press the icon to show a fading tooltip overlay.',
          RawTooltip(
            semanticsTooltip: 'Information about this item',
            triggerMode: TooltipTriggerMode.longPress,
            tooltipBuilder: (context, animation) {
              return FadeTransition(
                opacity: animation,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF37474F),
                    borderRadius: BorderRadius.circular(6.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6.0,
                        offset: Offset(0.0, 2.0),
                      ),
                    ],
                  ),
                  child: Text(
                    'This is a fading tooltip!',
                    style: TextStyle(color: Colors.white, fontSize: 12.0),
                  ),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Color(0xFF90CAF9)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.info_outline, color: Color(0xFF1565C0)),
                  SizedBox(width: 8.0),
                  Text(
                    'Long-press me',
                    style: TextStyle(color: Color(0xFF1565C0), fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 12.0),
        // Example 2: Scale tooltip with tap trigger
        _buildLiveExampleWrapper(
          'Scale Tooltip (tap)',
          'Tap the button to show a scaling tooltip.',
          RawTooltip(
            semanticsTooltip: 'Favorite this item',
            triggerMode: TooltipTriggerMode.tap,
            touchDelay: Duration(milliseconds: 2000),
            tooltipBuilder: (context, animation) {
              return ScaleTransition(
                scale: animation,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFD32F2F),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.favorite, color: Colors.white, size: 14.0),
                      SizedBox(width: 4.0),
                      Text(
                        'Added to favorites!',
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Color(0xFFFCE4EC),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Color(0xFFEF9A9A)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.favorite_border, color: Color(0xFFC62828)),
                  SizedBox(width: 8.0),
                  Text(
                    'Tap me',
                    style: TextStyle(color: Color(0xFFC62828), fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 12.0),
        // Example 3: Combined fade+slide with custom delays
        _buildLiveExampleWrapper(
          'Slide+Fade with Custom Delays',
          'Hover delay: 500ms, dismiss delay: 300ms. The tooltip slides in from below.',
          RawTooltip(
            semanticsTooltip: 'Network settings',
            triggerMode: TooltipTriggerMode.tap,
            hoverDelay: Duration(milliseconds: 500),
            dismissDelay: Duration(milliseconds: 300),
            animationStyle: AnimationStyle(
              duration: Duration(milliseconds: 250),
              reverseDuration: Duration(milliseconds: 150),
              curve: Curves.easeOutBack,
            ),
            tooltipBuilder: (context, animation) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0.0, 0.3),
                  end: Offset.zero,
                ).animate(animation),
                child: FadeTransition(
                  opacity: animation,
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF2E7D32), Color(0xFF43A047)],
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withValues(alpha: 0.3),
                          blurRadius: 8.0,
                          offset: Offset(0.0, 3.0),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Network Status',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8.0,
                              height: 8.0,
                              decoration: BoxDecoration(
                                color: Color(0xFF76FF03),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 6.0),
                            Text(
                              'Connected • 42ms latency',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 11.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Color(0xFFA5D6A7)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.wifi, color: Color(0xFF2E7D32)),
                  SizedBox(width: 8.0),
                  Text(
                    'Tap for status',
                    style: TextStyle(color: Color(0xFF2E7D32), fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );

  print('  Live examples section built');

  // ============================================================
  // SECTION 8: positionDelegate — Custom Positioning
  // ============================================================
  print('=== Section 8: Position Delegate ===');

  // The positionDelegate callback receives TooltipPositionContext
  // with target location, sizes, and offset, and returns an Offset
  // for positioning the tooltip in the overlay.

  final positionSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('positionDelegate — Custom Positioning', Icons.open_with),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Color(0xFFEDE7F6),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xFFB39DDB)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TooltipPositionContext properties:',
                style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Color(0xFF4A148C)),
              ),
              SizedBox(height: 10.0),
              _buildPositionProp('target', 'Offset', 'Center of the trigger widget (global coords)'),
              _buildPositionProp('targetSize', 'Size', 'Size of the trigger widget'),
              _buildPositionProp('tooltipSize', 'Size', 'Measured size of the tooltip overlay'),
              _buildPositionProp('verticalOffset', 'double', 'Configured vertical spacing'),
              _buildPositionProp('preferBelow', 'bool', 'Whether tooltip prefers below target'),
              _buildPositionProp('overlaySize', 'Size', 'Size of the overlay container'),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        _buildCodeSnippetCard(
          'positionDelegate: (TooltipPositionContext ctx) {\n'
          '  // Position tooltip to the RIGHT of target\n'
          '  final double x = ctx.target.dx + ctx.targetSize.width / 2 + 8;\n'
          '  final double y = ctx.target.dy - ctx.tooltipSize.height / 2;\n'
          '  return Offset(\n'
          '    x.clamp(0, ctx.overlaySize.width - ctx.tooltipSize.width),\n'
          '    y.clamp(0, ctx.overlaySize.height - ctx.tooltipSize.height),\n'
          '  );\n'
          '}',
        ),
      ],
    ),
  );

  print('  Position delegate section built');

  // ============================================================
  // SECTION 9: Optional Behavior Parameters
  // ============================================================
  print('=== Section 9: Optional Behavior Params ===');

  final behaviorSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Optional Behavior Parameters', Icons.settings),
        SizedBox(height: 12.0),
        _buildBehaviorCard(
          'enableTapToDismiss',
          'bool (default: true)',
          'When true, tapping outside the tooltip dismisses it. '
          'Set to false to keep tooltip visible until timeout or programmatic dismissal.',
          Icons.close,
          Color(0xFF1565C0),
        ),
        SizedBox(height: 8.0),
        _buildBehaviorCard(
          'enableFeedback',
          'bool (default: true)',
          'Enables platform-specific haptic/acoustic feedback when tooltip is triggered. '
          'On Android: click sound on tap, vibration on long press.',
          Icons.vibration,
          Color(0xFF2E7D32),
        ),
        SizedBox(height: 8.0),
        _buildBehaviorCard(
          'onTriggered',
          'TooltipTriggeredCallback?',
          'Called when tooltip is triggered via tap, long-press, or programmatically '
          '(ensureTooltipVisible). NOT called on mouse hover.',
          Icons.notifications_active,
          Color(0xFFE65100),
        ),
      ],
    ),
  );

  print('  Behavior params section built');

  // ============================================================
  // SECTION 10: dismissAllToolTips — Global Control
  // ============================================================
  print('=== Section 10: Global Tooltip Control ===');

  final globalSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Static Method — dismissAllToolTips()', Icons.cancel_outlined),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Color(0xFFFCE4EC),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xFFEF9A9A)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RawTooltip.dismissAllToolTips()',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  color: Color(0xFFC62828),
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Static method that dismisses ALL currently visible tooltips '
                'across the entire application. Returns true if any tooltip '
                'was dismissed, false otherwise. Useful for coordinating '
                'tooltip visibility during navigation or modal display.',
                style: TextStyle(fontSize: 12.0, color: Color(0xFF424242), height: 1.4),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xFF263238),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  '// Dismiss all tooltips before showing a dialog\n'
                  'RawTooltip.dismissAllToolTips();\n'
                  'showDialog(\n'
                  '  context: context,\n'
                  '  builder: (_) => AlertDialog(...),\n'
                  ');',
                  style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: Color(0xFF80CBC4)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('  Global control section built');

  // ============================================================
  // SECTION 11: vs Tooltip Comparison
  // ============================================================
  print('=== Section 11: vs Tooltip ===');

  final comparisonSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('RawTooltip vs Material Tooltip', Icons.compare),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Color(0xFFE0E0E0)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF006064),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Center(
                        child: Text(
                          'RawTooltip',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF1565C0),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Center(
                        child: Text(
                          'Tooltip',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              _buildComparisonFeature('Appearance', 'Custom via tooltipBuilder', 'Material-themed decoration'),
              _buildComparisonFeature('Animation', 'Full AnimationStyle control', 'Default Material transitions'),
              _buildComparisonFeature('Positioning', 'Custom positionDelegate', 'Built-in above/below logic'),
              _buildComparisonFeature('Content', 'Any widget tree', 'Text message (String)'),
              _buildComparisonFeature('Theming', 'No theme integration', 'Uses TooltipThemeData'),
              _buildComparisonFeature('Semantics', 'semanticsTooltip property', 'message property'),
              _buildComparisonFeature('Use case', 'Custom tooltip UIs', 'Standard Material tooltips'),
            ],
          ),
        ),
      ],
    ),
  );

  print('  Comparison section built');

  // ============================================================
  // SECTION 12: API Property Reference
  // ============================================================
  print('=== Section 12: API Reference ===');

  final apiSection = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'API Reference — RawTooltip',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF212121),
          ),
        ),
        Divider(height: 16.0),
        Text(
          'Required Parameters',
          style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: Color(0xFF424242)),
        ),
        SizedBox(height: 6.0),
        _buildApiRow('semanticsTooltip', 'String?', 'Accessibility text for screen readers'),
        _buildApiRow('tooltipBuilder', 'TooltipComponentBuilder', 'Builds tooltip overlay content'),
        _buildApiRow('child', 'Widget', 'Trigger widget'),
        Divider(height: 16.0),
        Text(
          'Optional Timing',
          style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: Color(0xFF424242)),
        ),
        SizedBox(height: 6.0),
        _buildApiRow('hoverDelay', 'Duration', 'Delay before hover shows tooltip (0ms)'),
        _buildApiRow('touchDelay', 'Duration', 'Tooltip visible after touch release (1500ms)'),
        _buildApiRow('dismissDelay', 'Duration', 'Delay before hover dismisses tooltip (100ms)'),
        Divider(height: 16.0),
        Text(
          'Optional Behavior',
          style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: Color(0xFF424242)),
        ),
        SizedBox(height: 6.0),
        _buildApiRow('triggerMode', 'TooltipTriggerMode', 'manual / longPress / tap'),
        _buildApiRow('enableTapToDismiss', 'bool', 'Dismiss on outside tap (true)'),
        _buildApiRow('enableFeedback', 'bool', 'Haptic/acoustic feedback (true)'),
        _buildApiRow('onTriggered', 'VoidCallback?', 'Called when tooltip triggers'),
        Divider(height: 16.0),
        Text(
          'Animation & Positioning',
          style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: Color(0xFF424242)),
        ),
        SizedBox(height: 6.0),
        _buildApiRow('animationStyle', 'AnimationStyle', 'Curve/duration for show/hide'),
        _buildApiRow('positionDelegate', 'TooltipPositionDelegate?', 'Custom positioning callback'),
        Divider(height: 16.0),
        Text(
          'Static Methods',
          style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: Color(0xFF424242)),
        ),
        SizedBox(height: 6.0),
        _buildApiRow('dismissAllToolTips()', 'bool', 'Dismiss all visible tooltips'),
      ],
    ),
  );

  print('  API reference section built');

  // ============================================================
  // Assemble
  // ============================================================
  print('Assembling RawTooltip demo...');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        conceptCard,
        SizedBox(height: 12.0),
        requiredParamsSection,
        SizedBox(height: 20.0),
        triggerSection,
        SizedBox(height: 20.0),
        timingSection,
        SizedBox(height: 20.0),
        builderSection,
        SizedBox(height: 20.0),
        animStyleSection,
        SizedBox(height: 20.0),
        liveSection,
        SizedBox(height: 20.0),
        positionSection,
        SizedBox(height: 20.0),
        behaviorSection,
        SizedBox(height: 20.0),
        globalSection,
        SizedBox(height: 20.0),
        comparisonSection,
        SizedBox(height: 20.0),
        apiSection,
        SizedBox(height: 32.0),
      ],
    ),
  );
}

// ============================================================
// Helper Widgets
// ============================================================

Widget _buildSectionTitle(String title, IconData icon) {
  return Row(
    children: [
      Icon(icon, color: Color(0xFF006064), size: 22.0),
      SizedBox(width: 8.0),
      Expanded(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF212121),
          ),
        ),
      ),
    ],
  );
}

Widget _buildConceptChip(String label, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.0, color: color),
        SizedBox(width: 4.0),
        Text(
          label,
          style: TextStyle(fontSize: 11.0, color: color, fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}

Widget _buildParamCard(
  String name,
  String type,
  String requirement,
  String description,
  Color color,
  IconData icon,
  String code,
) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 18.0),
            SizedBox(width: 8.0),
            Text(
              name,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
                color: color,
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                requirement,
                style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: color),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          type,
          style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: Color(0xFF757575)),
        ),
        SizedBox(height: 8.0),
        Text(
          description,
          style: TextStyle(fontSize: 12.0, color: Color(0xFF424242), height: 1.4),
        ),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            code,
            style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Color(0xFF80CBC4)),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTriggerCard(
  String mode,
  String description,
  IconData icon,
  Color color,
  String enumValue,
) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.25)),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 24.0),
        SizedBox(height: 6.0),
        Text(
          mode,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10.0, color: Color(0xFF616161), height: 1.3),
        ),
        SizedBox(height: 6.0),
        Text(
          enumValue,
          style: TextStyle(fontSize: 8.0, fontFamily: 'monospace', color: color.withValues(alpha: 0.6)),
        ),
      ],
    ),
  );
}

Widget _buildTimingRow(
  String param,
  String defaultValue,
  String description,
  Color color,
  String shortValue,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          shortValue,
          style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      SizedBox(width: 10.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: param,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                      color: color,
                    ),
                  ),
                  TextSpan(
                    text: ' (default: $defaultValue)',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: 'monospace',
                      color: Color(0xFF9E9E9E),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              description,
              style: TextStyle(fontSize: 11.0, color: Color(0xFF424242), height: 1.3),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildTimelineStep(String event, String result, Color color) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.only(top: 4.0),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: event,
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF212121),
                  ),
                ),
                TextSpan(
                  text: ' → ',
                  style: TextStyle(fontSize: 11.0, color: Color(0xFF9E9E9E)),
                ),
                TextSpan(
                  text: result,
                  style: TextStyle(fontSize: 11.0, color: color),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildAnimationPatternCard(
  String title,
  String code,
  Color color,
  String description,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: color),
        ),
        SizedBox(height: 4.0),
        Text(
          description,
          style: TextStyle(fontSize: 11.0, color: Color(0xFF616161)),
        ),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            code,
            style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Color(0xFF80CBC4)),
          ),
        ),
      ],
    ),
  );
}

Widget _buildAnimConfigItem(String label, String value, String description, Color color) {
  return Container(
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
            color: color,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          value,
          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Color(0xFF212121)),
        ),
        SizedBox(height: 2.0),
        Text(
          description,
          style: TextStyle(fontSize: 9.0, color: Color(0xFF757575)),
        ),
      ],
    ),
  );
}

Widget _buildLiveExampleWrapper(String title, String description, Widget example) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Color(0xFF212121)),
        ),
        SizedBox(height: 4.0),
        Text(
          description,
          style: TextStyle(fontSize: 11.0, color: Color(0xFF757575)),
        ),
        SizedBox(height: 10.0),
        Center(child: example),
      ],
    ),
  );
}

Widget _buildPositionProp(String name, String type, String description) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100.0,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              color: Color(0xFF4A148C),
            ),
          ),
        ),
        SizedBox(
          width: 50.0,
          child: Text(
            type,
            style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Color(0xFF757575)),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 11.0, color: Color(0xFF424242)),
          ),
        ),
      ],
    ),
  );
}

Widget _buildBehaviorCard(String name, String type, String description, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 20.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  color: color,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                type,
                style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Color(0xFF757575)),
              ),
              SizedBox(height: 6.0),
              Text(
                description,
                style: TextStyle(fontSize: 11.0, color: Color(0xFF424242), height: 1.3),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeSnippetCard(String code) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontSize: 11.0,
        fontFamily: 'monospace',
        color: Color(0xFF80CBC4),
        height: 1.4,
      ),
    ),
  );
}

Widget _buildComparisonFeature(String feature, String rawTooltip, String tooltip) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6.0),
    child: Row(
      children: [
        SizedBox(
          width: 80.0,
          child: Text(
            feature,
            style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Color(0xFF424242)),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: Color(0xFFE0F2F1),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(rawTooltip, style: TextStyle(fontSize: 10.0, color: Color(0xFF006064))),
          ),
        ),
        SizedBox(width: 4.0),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(tooltip, style: TextStyle(fontSize: 10.0, color: Color(0xFF0D47A1))),
          ),
        ),
      ],
    ),
  );
}

Widget _buildApiRow(String param, String type, String description) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110.0,
          child: Text(
            param,
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              color: Color(0xFF006064),
            ),
          ),
        ),
        SizedBox(
          width: 80.0,
          child: Text(
            type,
            style: TextStyle(fontSize: 9.0, fontFamily: 'monospace', color: Color(0xFF757575)),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 10.0, color: Color(0xFF616161)),
          ),
        ),
      ],
    ),
  );
}

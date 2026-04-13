// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — RawDialogRoute
// Demonstrates RawDialogRoute: a low-level ModalRoute that displays
// content over a modal barrier. Unlike DialogRoute (Material), this gives
// full control over the barrier, transition, and content presentation.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawDialogRoute Deep Demo executing');

  // ============================================================
  // SECTION 1: What RawDialogRoute Is — Concept
  // ============================================================
  print('=== Section 1: RawDialogRoute Concept ===');

  // RawDialogRoute is a ModalRoute subclass from the widgets library.
  // It creates a dialog-style overlay with:
  //   - A modal barrier (semi-transparent background that blocks input)
  //   - A page builder (creates the dialog content widget)
  //   - A transition builder (controls how the content animates in/out)
  //
  // Key difference from showDialog/DialogRoute:
  //   - RawDialogRoute does NOT add Material styling
  //   - No Material InkWell, no Material elevation, no Material text theme
  //   - You control everything: barrier color, barrier behavior,
  //     transition duration, transition animation, content layout
  //
  // It's pushed onto the Navigator like any Route:
  //   Navigator.of(context).push(RawDialogRoute(...))

  final conceptCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withValues(alpha: 0.3),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.open_in_new, color: Colors.white, size: 30.0),
            SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RawDialogRoute',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Low-level modal overlay route',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'A ModalRoute subclass',
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'RawDialogRoute displays content as a modal overlay with a '
                'barrier that blocks interaction with the underlying page. '
                'Unlike DialogRoute, it applies no Material styling — you '
                'design the content, barrier, and transitions from scratch.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 13.0,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildConceptTag('Modal Barrier', Icons.block),
            _buildConceptTag('Custom Transition', Icons.animation),
            _buildConceptTag('No Material', Icons.layers_clear),
          ],
        ),
      ],
    ),
  );

  print('  conceptCard built');

  // ============================================================
  // SECTION 2: Anatomy — Barrier + Content Layers
  // ============================================================
  print('=== Section 2: Anatomy Diagram ===');

  // The RawDialogRoute creates a stack of layers:
  //   Bottom: the existing page (still rendered but non-interactive)
  //   Middle: the modal barrier (colored overlay, absorbs taps)
  //   Top: the dialog content (your pageBuilder widget)

  final anatomyDiagram = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.blueGrey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 2: Route Anatomy',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Three layers compose a RawDialogRoute on screen.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 20.0),

        // Layer 3: Dialog content (top)
        _buildLayerBlock(
          'Layer 3: Dialog Content',
          'Your pageBuilder widget — the actual dialog UI',
          Color(0xFF43A047),
          Colors.white,
          Icons.dashboard,
          'TOP — receives user interaction',
        ),
        SizedBox(height: 8.0),

        // Layer 2: Modal barrier (middle)
        _buildLayerBlock(
          'Layer 2: Modal Barrier',
          'Semi-transparent overlay that absorbs taps on the background',
          Color(0xFF333333).withValues(alpha: 0.8),
          Colors.white,
          Icons.block,
          'MIDDLE — blocks input to underlying page',
        ),
        SizedBox(height: 8.0),

        // Layer 1: Previous page (bottom)
        _buildLayerBlock(
          'Layer 1: Previous Page',
          'The page that pushed the dialog — still rendered but non-interactive',
          Colors.grey.shade300,
          Colors.grey.shade800,
          Icons.web,
          'BOTTOM — visible but disabled',
        ),

        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade50,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Icon(Icons.layers, color: Colors.blueGrey, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'The barrier and content are created by RawDialogRoute. '
                  'You only provide the pageBuilder (content) and configure '
                  'the barrier properties.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.blueGrey.shade700,
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

  print('  anatomyDiagram built');

  // ============================================================
  // SECTION 3: Barrier Customization — Colors & Dismissibility
  // ============================================================
  print('=== Section 3: Barrier Customization ===');

  // The barrier can be configured with:
  //   - barrierColor: any Color (default is transparent)
  //   - barrierDismissible: whether tapping the barrier closes the route
  //   - barrierLabel: accessibility label for the barrier

  final barrierCustomization = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.deepPurple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 3: Barrier Customization',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Different barrier colors and dismissibility modes.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 20.0),

        // Row of barrier color samples
        Text(
          'Barrier Color Examples',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.deepPurple.shade700,
          ),
        ),
        SizedBox(height: 12.0),

        Row(
          children: [
            Expanded(
              child: _buildBarrierSample(
                'Default',
                'Colors.transparent',
                Colors.transparent,
                Colors.grey.shade300,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _buildBarrierSample(
                'Standard',
                'Black 54%',
                Colors.black54,
                Colors.white70,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _buildBarrierSample(
                'Tinted',
                'Blue 40%',
                Colors.blue.withValues(alpha: 0.4),
                Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: _buildBarrierSample(
                'Dark',
                'Black 80%',
                Colors.black.withValues(alpha: 0.8),
                Colors.white,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _buildBarrierSample(
                'Frosted',
                'White 60%',
                Colors.white.withValues(alpha: 0.6),
                Colors.grey.shade800,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _buildBarrierSample(
                'Custom',
                'Red 30%',
                Colors.red.withValues(alpha: 0.3),
                Colors.red.shade900,
              ),
            ),
          ],
        ),

        SizedBox(height: 24.0),

        // Dismissibility
        Text(
          'Barrier Dismissibility',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.deepPurple.shade700,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.green.shade300),
                ),
                child: Column(
                  children: [
                    Icon(Icons.touch_app, color: Colors.green, size: 28.0),
                    SizedBox(height: 8.0),
                    Text(
                      'barrierDismissible: true',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Tap outside to close the dialog',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.green.shade700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.red.shade300),
                ),
                child: Column(
                  children: [
                    Icon(Icons.do_not_touch, color: Colors.red, size: 28.0),
                    SizedBox(height: 8.0),
                    Text(
                      'barrierDismissible: false',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.red.shade800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Must use Navigator.pop() or a button to close',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.red.shade700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Use barrierDismissible: false for critical dialogs (unsaved changes, '
            'payment confirmations) where accidental dismissal would be problematic.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.deepPurple.shade700,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  print('  barrierCustomization built');

  // ============================================================
  // SECTION 4: Transition Animation
  // ============================================================
  print('=== Section 4: Transition Animation ===');

  // The transitionBuilder controls how the dialog content appears
  // and disappears. It receives the child (pageBuilder result) and
  // an Animation<double> that goes from 0.0 (invisible) to 1.0 (visible).

  final transitionSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.orange.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 4: Transition Animation',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.orange.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'transitionBuilder controls how the dialog animates on screen.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 20.0),

        // Animation timeline
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.orange.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Animation Lifecycle',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange.shade900,
                ),
              ),
              SizedBox(height: 12.0),
              _buildTimelineStep(
                'Route Pushed',
                'Navigator.push(RawDialogRoute(...))',
                0.0,
                Colors.orange,
              ),
              _buildTimelineConnector(),
              _buildTimelineStep(
                'Animation Forward',
                'Value goes 0.0 -> 1.0 over transitionDuration',
                0.5,
                Colors.amber,
              ),
              _buildTimelineConnector(),
              _buildTimelineStep(
                'Fully Visible',
                'Animation value = 1.0, dialog interactive',
                1.0,
                Colors.green,
              ),
              _buildTimelineConnector(),
              _buildTimelineStep(
                'Route Popped',
                'Animation reverses 1.0 -> 0.0',
                0.0,
                Colors.red,
              ),
            ],
          ),
        ),

        SizedBox(height: 16.0),

        // Transition types
        Text(
          'Common Transition Patterns',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.orange.shade900,
          ),
        ),
        SizedBox(height: 12.0),

        _buildTransitionExample(
          'Fade',
          'FadeTransition with CurvedAnimation',
          Icons.gradient,
          Colors.blue,
          'Opacity goes 0.0 to 1.0',
        ),
        SizedBox(height: 8.0),
        _buildTransitionExample(
          'Scale',
          'ScaleTransition starting from center',
          Icons.zoom_in,
          Colors.green,
          'Scale goes 0.0 to 1.0',
        ),
        SizedBox(height: 8.0),
        _buildTransitionExample(
          'Slide + Fade',
          'Combined SlideTransition + FadeTransition',
          Icons.swap_horiz,
          Colors.purple,
          'Slides up from bottom while fading in',
        ),
        SizedBox(height: 8.0),
        _buildTransitionExample(
          'None (Instant)',
          'transitionDuration: Duration.zero',
          Icons.flash_on,
          Colors.red,
          'No animation — appears immediately',
        ),

        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'If transitionBuilder is null, RawDialogRoute uses a default '
            'FadeTransition. Set transitionDuration to Duration.zero '
            'for instant appearance with no animation.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.orange.shade800,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  print('  transitionSection built');

  // ============================================================
  // SECTION 5: API Property Reference
  // ============================================================
  print('=== Section 5: API Property Reference ===');

  final apiReference = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.cyan.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 5: API Property Reference',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.cyan.shade800,
          ),
        ),
        SizedBox(height: 16.0),
        _buildApiCard(
          'pageBuilder',
          'RoutePageBuilder',
          'Required. Creates the dialog content widget. Receives '
          'BuildContext, Animation<double>, Animation<double> (secondary). '
          'The widget returned is placed on top of the barrier.',
          Colors.teal,
          Icons.dashboard,
        ),
        SizedBox(height: 10.0),
        _buildApiCard(
          'barrierDismissible',
          'bool',
          'Whether tapping the barrier closes the dialog. Default: true. '
          'Set to false for mandatory dialogs.',
          Colors.green,
          Icons.touch_app,
        ),
        SizedBox(height: 10.0),
        _buildApiCard(
          'barrierColor',
          'Color?',
          'The color of the modal barrier overlay. Use Colors.black54 for '
          'a standard dark overlay or a custom color for branding.',
          Colors.purple,
          Icons.format_color_fill,
        ),
        SizedBox(height: 10.0),
        _buildApiCard(
          'barrierLabel',
          'String?',
          'Accessibility label for the barrier, read by screen readers. '
          'Typically "Dismiss" or "Close dialog".',
          Colors.orange,
          Icons.accessibility,
        ),
        SizedBox(height: 10.0),
        _buildApiCard(
          'transitionDuration',
          'Duration',
          'How long the entrance/exit animation takes. Default: '
          'Duration(milliseconds: 200). Use Duration.zero for instant.',
          Colors.blue,
          Icons.timer,
        ),
        SizedBox(height: 10.0),
        _buildApiCard(
          'transitionBuilder',
          'RouteTransitionsBuilder?',
          'Builds the animated wrapper around the content. Receives the '
          'child plus Animation<double>. Default: FadeTransition.',
          Colors.red,
          Icons.animation,
        ),
        SizedBox(height: 10.0),
        _buildApiCard(
          'settings',
          'RouteSettings?',
          'Route name and arguments for debugging and route tracking. '
          'Inherited from ModalRoute.',
          Colors.grey,
          Icons.settings,
        ),
        SizedBox(height: 10.0),
        _buildApiCard(
          'anchorPoint',
          'Offset?',
          'The anchor point for the dialog positioning when using '
          'multiple display setups. Rarely needed in single-display apps.',
          Colors.brown,
          Icons.anchor,
        ),
      ],
    ),
  );

  print('  apiReference built with 8 properties');

  // ============================================================
  // SECTION 6: Real-World Use Cases
  // ============================================================
  print('=== Section 6: Real-World Use Cases ===');

  final useCaseSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 6: Real-World Use Cases',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade800,
          ),
        ),
        SizedBox(height: 16.0),

        // Use case 1: Confirmation dialog
        _buildUseCaseCard(
          'Confirmation Dialog',
          'barrierDismissible: false, dark barrier',
          'Critical actions like deleting data or submitting payments. '
          'The user must explicitly confirm or cancel — accidental taps '
          'on the barrier do not close the dialog.',
          Icons.warning,
          Colors.red,
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withValues(alpha: 0.2),
                  blurRadius: 8.0,
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(Icons.delete_forever, color: Colors.red, size: 36.0),
                SizedBox(height: 8.0),
                Text(
                  'Delete this item?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'This action cannot be undone.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(fontSize: 12.0),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.0),

        // Use case 2: Loading overlay
        _buildUseCaseCard(
          'Loading Overlay',
          'barrierDismissible: false, transparent barrier',
          'Block interaction while an async operation completes. '
          'The barrier prevents taps while the spinner shows progress.',
          Icons.hourglass_empty,
          Colors.blue,
          Container(
            padding: EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  'Saving changes...',
                  style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.0),

        // Use case 3: Custom modal sheet
        _buildUseCaseCard(
          'Custom Modal Sheet',
          'Custom transition (slide from bottom)',
          'A bottom sheet styled as a full-page modal with SwipeTransition. '
          'Using RawDialogRoute gives control over the transition animation.',
          Icons.view_agenda,
          Colors.teal,
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 40.0,
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  'Sheet Content',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Custom-designed modal sheet',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.0),

        // Use case 4: Image lightbox
        _buildUseCaseCard(
          'Image Lightbox',
          'Dark barrier (90% black), tap to dismiss',
          'Full-screen image previews with a very dark barrier. '
          'barrierDismissible: true so tapping anywhere closes the viewer.',
          Icons.image,
          Colors.amber,
          Container(
            padding: EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              height: 60.0,
              decoration: BoxDecoration(
                color: Colors.amber.shade200,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Center(
                child: Icon(Icons.photo, color: Colors.amber.shade800,
                    size: 30.0),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  print('  useCaseSection built with 4 use cases');

  // ============================================================
  // SECTION 7: RawDialogRoute vs DialogRoute vs showDialog
  // ============================================================
  print('=== Section 7: Comparison Table ===');

  final comparisonSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.pink.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 7: RawDialogRoute vs DialogRoute vs showDialog',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.pink.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Three ways to show dialogs — different abstraction levels.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16.0),

        // Comparison header
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
          decoration: BoxDecoration(
            color: Colors.pink.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Feature',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: Colors.pink.shade900,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'RawDialogRoute',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'DialogRoute',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: Colors.orange.shade700,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'showDialog',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: Colors.green.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
        _buildTripleComparisonRow(
          'Library',
          'widgets',
          'material',
          'material',
        ),
        _buildTripleComparisonRow(
          'Styling',
          'None',
          'Material defaults',
          'Material defaults',
        ),
        _buildTripleComparisonRow(
          'Usage',
          'Navigator.push()',
          'Navigator.push()',
          'showDialog()',
        ),
        _buildTripleComparisonRow(
          'Returns',
          'Route object',
          'Route object',
          'Future<T?>',
        ),
        _buildTripleComparisonRow(
          'Barrier',
          'Fully configurable',
          'Configurable',
          'Configurable',
        ),
        _buildTripleComparisonRow(
          'Transition',
          'Custom builder',
          'Custom builder',
          'Uses DialogRoute internally',
        ),
        _buildTripleComparisonRow(
          'Theme',
          'No theming',
          'Uses Theme.of()',
          'Uses Theme.of()',
        ),

        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink.shade50, Colors.purple.shade50],
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Icon(Icons.tips_and_updates,
                  color: Colors.pink.shade600, size: 20.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'showDialog() is a convenience function that creates a '
                  'DialogRoute internally. DialogRoute extends RawDialogRoute '
                  'with Material styling. For custom design systems, use '
                  'RawDialogRoute directly.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.pink.shade800,
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

  print('  comparisonSection built');

  // ============================================================
  // SECTION 8: Route Lifecycle — Push to Dismiss
  // ============================================================
  print('=== Section 8: Route Lifecycle ===');

  final lifecycleSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.lime.shade400),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 8: Route Lifecycle',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.lime.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'The complete lifecycle from push to pop.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 20.0),

        _buildLifecycleStep(
          1,
          'Navigator.push()',
          'The route is pushed onto the Navigator stack. The previous '
          'route receives a didPush or didPushNext notification.',
          Colors.blue,
          Icons.add_circle,
        ),
        _buildLifecycleArrow(),
        _buildLifecycleStep(
          2,
          'Build Modal Barrier',
          'RawDialogRoute creates the barrier with your specified color '
          'and dismissibility. The barrier absorbs all pointer events '
          'to the underlying page.',
          Colors.purple,
          Icons.block,
        ),
        _buildLifecycleArrow(),
        _buildLifecycleStep(
          3,
          'Build Page Content',
          'pageBuilder is called with the context and animation. Your '
          'dialog widget tree is created and placed above the barrier.',
          Colors.teal,
          Icons.dashboard,
        ),
        _buildLifecycleArrow(),
        _buildLifecycleStep(
          4,
          'Animate Entrance',
          'transitionBuilder wraps the page in an animation. The '
          'animation runs from 0.0 to 1.0 over transitionDuration. '
          'Default: FadeTransition over 200ms.',
          Colors.orange,
          Icons.play_arrow,
        ),
        _buildLifecycleArrow(),
        _buildLifecycleStep(
          5,
          'Interactive State',
          'Animation complete. The dialog receives user interaction. '
          'The route is now the current route on the Navigator.',
          Colors.green,
          Icons.check_circle,
        ),
        _buildLifecycleArrow(),
        _buildLifecycleStep(
          6,
          'Pop / Dismiss',
          'Either Navigator.pop(), barrier tap (if dismissible), or '
          'back button closes the route. Exit animation reverses.',
          Colors.red,
          Icons.close,
        ),

        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.lime.shade50,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, color: Colors.lime.shade700,
                  size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'RawDialogRoute inherits from PopupRoute, which itself '
                  'extends ModalRoute. This means the previous route stays '
                  'in the widget tree (not disposed) while the dialog is '
                  'showing — important for state preservation.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.lime.shade800,
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

  print('  lifecycleSection built');

  // ============================================================
  // SECTION 9: Live RawDialogRoute Instance
  // ============================================================
  print('=== Section 9: Live RawDialogRoute Instance ===');

  // We cannot push routes in a build function, but we can show
  // how the route constructor is called and what it produces.

  final liveInstance = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.teal.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Section 9: Live Route Construction',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'An actual RawDialogRoute instance showing its properties.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16.0),

        // Create a real RawDialogRoute to inspect
        Builder(
          builder: (BuildContext ctx) {
            final route = RawDialogRoute<String>(
              pageBuilder: (
                BuildContext dialogContext,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
              ) {
                return Center(
                  child: Container(
                    width: 280.0,
                    padding: EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text('Dialog Content'),
                  ),
                );
              },
              barrierDismissible: true,
              barrierColor: Colors.black54,
              barrierLabel: 'Dismiss dialog',
              transitionDuration: Duration(milliseconds: 300),
            );

            print('  Route created: ${route.runtimeType}');
            print('  barrierDismissible: ${route.barrierDismissible}');
            print('  barrierColor: ${route.barrierColor}');
            print('  barrierLabel: ${route.barrierLabel}');
            print('  transitionDuration: ${route.transitionDuration}');

            return Column(
              children: [
                _buildPropertyDisplay(
                  'runtimeType',
                  '${route.runtimeType}',
                  Colors.teal,
                ),
                SizedBox(height: 6.0),
                _buildPropertyDisplay(
                  'barrierDismissible',
                  '${route.barrierDismissible}',
                  Colors.green,
                ),
                SizedBox(height: 6.0),
                _buildPropertyDisplay(
                  'barrierColor',
                  '${route.barrierColor}',
                  Colors.purple,
                ),
                SizedBox(height: 6.0),
                _buildPropertyDisplay(
                  'barrierLabel',
                  '${route.barrierLabel}',
                  Colors.orange,
                ),
                SizedBox(height: 6.0),
                _buildPropertyDisplay(
                  'transitionDuration',
                  '${route.transitionDuration}',
                  Colors.blue,
                ),
                SizedBox(height: 12.0),
                Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade50,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'This is a real RawDialogRoute<String> instance created '
                    'in-place. In a real app, you would push it onto the '
                    'Navigator to display it as a modal overlay.',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.teal.shade700,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    ),
  );

  print('  liveInstance built');

  // ============================================================
  // Assemble all sections
  // ============================================================
  print('=== Assembling final layout ===');

  final result = SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        conceptCard,
        anatomyDiagram,
        barrierCustomization,
        transitionSection,
        apiReference,
        useCaseSection,
        comparisonSection,
        lifecycleSection,
        liveInstance,
        SizedBox(height: 32.0),
      ],
    ),
  );

  print('RawDialogRoute Deep Demo complete — 9 sections');
  return result;
}

// ============================================================
// Helper functions
// ============================================================

Widget _buildConceptTag(String label, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.lightBlueAccent.withValues(alpha: 0.5)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.lightBlueAccent, size: 14.0),
        SizedBox(width: 4.0),
        Text(
          label,
          style: TextStyle(
            color: Colors.lightBlueAccent,
            fontSize: 11.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget _buildLayerBlock(
  String title,
  String description,
  Color bgColor,
  Color textColor,
  IconData icon,
  String position,
) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: textColor.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Icon(icon, color: textColor, size: 28.0),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: textColor,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                description,
                style: TextStyle(fontSize: 11.0, color: textColor.withValues(alpha: 0.8)),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: textColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            position,
            style: TextStyle(
              fontSize: 9.0,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildBarrierSample(
  String label,
  String colorDesc,
  Color barrierColor,
  Color textColor,
) {
  return Container(
    height: 90.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Stack(
      children: [
        // "Background page"
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7.0),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.web, color: Colors.grey.shade400, size: 16.0),
                Text(
                  'Page',
                  style: TextStyle(
                    fontSize: 9.0,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Barrier overlay
        Container(
          decoration: BoxDecoration(
            color: barrierColor,
            borderRadius: BorderRadius.circular(7.0),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Text(
                  colorDesc,
                  style: TextStyle(fontSize: 8.0, color: textColor),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTimelineStep(
  String title,
  String description,
  double value,
  MaterialColor color,
) {
  return Row(
    children: [
      Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          color: color.shade100,
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 2.0),
        ),
        child: Center(
          child: Text(
            value.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: color.shade900,
            ),
          ),
        ),
      ),
      SizedBox(width: 12.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13.0,
                color: color.shade900,
              ),
            ),
            Text(
              description,
              style: TextStyle(fontSize: 11.0, color: color.shade700),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildTimelineConnector() {
  return Padding(
    padding: EdgeInsets.only(left: 19.0, top: 2.0, bottom: 2.0),
    child: Container(
      width: 2.0,
      height: 16.0,
      color: Colors.orange.shade200,
    ),
  );
}

Widget _buildTransitionExample(
  String name,
  String technique,
  IconData icon,
  MaterialColor color,
  String effect,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.shade200),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 22.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13.0,
                  color: color.shade900,
                ),
              ),
              Text(
                technique,
                style: TextStyle(fontSize: 11.0, color: color.shade700),
              ),
              Text(
                effect,
                style: TextStyle(
                  fontSize: 10.0,
                  fontStyle: FontStyle.italic,
                  color: color.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildApiCard(
  String name,
  String type,
  String description,
  MaterialColor color,
  IconData icon,
) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.shade200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: color.shade100,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Icon(icon, color: color.shade700, size: 18.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: color.shade900,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    type,
                    style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: 'monospace',
                      color: color.shade600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11.0,
                  color: color.shade800,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildUseCaseCard(
  String title,
  String subtitle,
  String description,
  IconData icon,
  MaterialColor color,
  Widget mockDialog,
) {
  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 24.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: color.shade900,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11.0,
                      fontFamily: 'monospace',
                      color: color.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 12.0,
            color: color.shade800,
            height: 1.3,
          ),
        ),
        SizedBox(height: 12.0),
        Center(child: mockDialog),
      ],
    ),
  );
}

Widget _buildTripleComparisonRow(
  String feature,
  String rawValue,
  String dialogValue,
  String showValue,
) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.pink.shade100, width: 0.5),
      ),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            feature,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 11.0,
              color: Colors.pink.shade900,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            rawValue,
            style: TextStyle(fontSize: 10.0, color: Colors.blue.shade700),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            dialogValue,
            style: TextStyle(fontSize: 10.0, color: Colors.orange.shade700),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            showValue,
            style: TextStyle(fontSize: 10.0, color: Colors.green.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget _buildLifecycleStep(
  int number,
  String title,
  String description,
  MaterialColor color,
  IconData icon,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.shade200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28.0,
          height: 28.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$number',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Icon(icon, color: color.shade700, size: 20.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12.0,
                  color: color.shade900,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                description,
                style: TextStyle(fontSize: 10.0, color: color.shade700,
                    height: 1.3),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildLifecycleArrow() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Center(
      child: Icon(Icons.arrow_downward, color: Colors.grey.shade400, size: 18.0),
    ),
  );
}

Widget _buildPropertyDisplay(
  String name,
  String value,
  MaterialColor color,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color.shade200),
    ),
    child: Row(
      children: [
        Container(
          width: 6.0,
          height: 6.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.0),
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12.0,
            color: color.shade900,
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: color.shade700,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    ),
  );
}

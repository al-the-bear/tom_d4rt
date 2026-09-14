// ignore_for_file: avoid_print
// Deep demo: AppKitViewController
// Demonstrates AppKitViewController — the macOS platform class
// for embedding and controlling an AppKit NSView within a
// Flutter application's view hierarchy.
import 'package:flutter/material.dart';

// ─── palette: Burgundy / Blush ────────────────────────────────────
const Color _akBurgundy = Color(0xFF880E4F);
const Color _akBlush = Color(0xFFFCE4EC);
const Color _akAccent = Color(0xFFAD1457);
const Color _akDark = Color(0xFF1B1B1B);
const Color _akBlue = Color(0xFF0277BD);
const Color _akGreen = Color(0xFF2E7D32);
const Color _akOrange = Color(0xFFE65100);
const Color _akPurple = Color(0xFF6A1B9A);
const Color _akTeal = Color(0xFF00695C);

// ─── text helpers ─────────────────────────────────────────────────
Widget _akTitle(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(t,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: _akBurgundy,
              letterSpacing: 0.3)),
    );

Widget _akSubtitle(String t) => Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Text(t,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: _akAccent)),
    );

Widget _akBody(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(t,
          style: const TextStyle(
              fontSize: 13.5, color: Colors.black87, height: 1.45)),
    );

Widget _akCode(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _akDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(t,
          style: const TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Color(0xFFF8BBD0),
              height: 1.5)),
    );

Widget _akNote(String t) => Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _akBlush,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _akBurgundy.withValues(alpha: 0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8, top: 1),
            child: Icon(Icons.laptop_mac, size: 16, color: _akBurgundy),
          ),
          Expanded(
            child: Text(t,
                style: const TextStyle(
                    fontSize: 12.5, color: _akBurgundy, height: 1.4)),
          ),
        ],
      ),
    );

Widget _akDivider() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child:
          Container(height: 1, color: _akBurgundy.withValues(alpha: 0.1)),
    );

Widget _akBullet(String label, String desc) => Padding(
      padding: const EdgeInsets.only(left: 12, top: 3, bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration: const BoxDecoration(
                color: _akAccent, shape: BoxShape.circle),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label: ',
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87)),
                TextSpan(
                    text: desc,
                    style: const TextStyle(
                        fontSize: 13, color: Colors.black87)),
              ]),
            ),
          ),
        ],
      ),
    );

Widget _akTag(String t, Color bg, [Color fg = Colors.white]) => Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(t,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w700, color: fg)),
    );

Widget _akLabel(String t) => Text(t,
    style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: _akBurgundy,
        letterSpacing: 0.2));

// ─── §1 Title banner ──────────────────────────────────────────────
Widget _akBanner() => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_akBurgundy, Color(0xFFAD1457)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x40000000),
              blurRadius: 12,
              offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.desktop_mac_outlined, size: 48, color: _akBlush),
          const SizedBox(height: 10),
          const Text('AppKitViewController',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5)),
          const SizedBox(height: 6),
          Text('macOS AppKit view embedding for Flutter',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.85))),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              _akTag('services', _akAccent),
              _akTag('macOS', _akBlue),
              _akTag('platform', _akPurple),
            ],
          ),
        ],
      ),
    );

// ─── §2 What is it? ──────────────────────────────────────────────
List<Widget> _akWhatIs() => [
      _akTitle('§2  What Is AppKitViewController?'),
      _akBody(
          'AppKitViewController is a macOS-specific class from the '
          'Flutter services layer that manages a native AppKit NSView '
          'embedded within a Flutter widget tree. It parallels '
          'UIViewController on iOS, providing a bridge between '
          'Flutter\'s rendering pipeline and macOS native views.'),
      _akCode(
          '// The controller manages a native NSView lifecycle\n'
          'abstract class AppKitViewController {\n'
          '  /// The unique identifier for the native view.\n'
          '  int get id;\n'
          '\n'
          '  /// Disposes of the native view resources.\n'
          '  Future<void> dispose();\n'
          '}'),
      _akNote(
          'AppKitViewController is only available on macOS. On other '
          'platforms, the equivalent classes are UIViewController (iOS), '
          'AndroidViewController (Android), etc.'),
    ];

// ─── §3 Platform view architecture ──────────────────────────────
List<Widget> _akArchitecture() => [
      _akDivider(),
      _akTitle('§3  Platform View Architecture'),
      _akBody(
          'Flutter embeds native views using a layered architecture. '
          'On macOS, this involves several cooperating components:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _akBlush,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _akArchLayer('Flutter Widget Layer',
                'AppKitView widget in the tree', _akBurgundy, 0),
            _akArchArrow(),
            _akArchLayer('Controller Layer',
                'AppKitViewController manages lifecycle', _akAccent, 1),
            _akArchArrow(),
            _akArchLayer('Platform Channel',
                'SystemChannels.platform_views', _akBlue, 2),
            _akArchArrow(),
            _akArchLayer('macOS Embedder',
                'FlutterViewController hosts NSView', _akGreen, 3),
            _akArchArrow(),
            _akArchLayer('Native AppKit',
                'NSView receives events and renders', _akOrange, 4),
          ],
        ),
      ),
      _akBullet('Widget layer', 'Declares where the native view sits'),
      _akBullet('Controller', 'Creates, connects, and disposes the view'),
      _akBullet('Channel', 'Sends creation/disposal messages to platform'),
      _akBullet('Embedder', 'Integrates the NSView into the layer tree'),
    ];

Widget _akArchLayer(String title, String desc, Color c, int depth) =>
    Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: depth * 6.0),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: c.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: c, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: c)),
                Text(desc,
                    style: const TextStyle(
                        fontSize: 10.5, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );

Widget _akArchArrow() => const Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Center(
        child: Icon(Icons.keyboard_arrow_down,
            size: 18, color: Colors.black26),
      ),
    );

// ─── §4 Lifecycle ────────────────────────────────────────────────
List<Widget> _akLifecycle() => [
      _akDivider(),
      _akTitle('§4  Lifecycle'),
      _akBody(
          'The controller follows a well-defined lifecycle from '
          'creation to disposal:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _akBlush,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _akLifeStep(1, 'Create', 'Platform creates NSView with viewId',
                _akBurgundy, Icons.add_circle_outline),
            _akLifeStep(2, 'Connect', 'Controller receives viewId handle',
                _akBlue, Icons.link),
            _akLifeStep(3, 'Resize', 'View resizes with Flutter layout',
                _akGreen, Icons.aspect_ratio),
            _akLifeStep(4, 'Re-position',
                'Offset updates as view scrolls or moves', _akOrange,
                Icons.open_with),
            _akLifeStep(5, 'Accept touch',
                'Hit testing routes gestures to NSView', _akPurple,
                Icons.touch_app),
            _akLifeStep(6, 'Dispose', 'Controller tears down the NSView',
                _akAccent, Icons.delete_outline),
          ],
        ),
      ),
      _akCode(
          '// Typical lifecycle in code\n'
          'final controller = await PlatformViewsService\n'
          '    .initAppKitView(\n'
          '  id: viewId,\n'
          '  viewType: \'native-text-view\',\n'
          '  layoutDirection: TextDirection.ltr,\n'
          ');\n'
          '\n'
          '// ... view is active ...\n'
          '\n'
          'await controller.dispose();'),
    ];

Widget _akLifeStep(
    int step, String name, String desc, Color c, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Text('$step',
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
          ),
        ),
        const SizedBox(width: 10),
        Icon(icon, size: 18, color: c),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: c)),
              Text(desc,
                  style: const TextStyle(
                      fontSize: 10.5, color: Colors.black54)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ─── §5 Rendering modes ──────────────────────────────────────────
List<Widget> _akRenderModes() => [
      _akDivider(),
      _akTitle('§5  Rendering Modes'),
      _akBody(
          'On macOS, Flutter can embed AppKit views using different '
          'composition strategies:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _akBlush,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _akModeCard(
                  'Hybrid Composition',
                  'NSView sits in the native layer tree alongside '
                      'Flutter layers. Preserves NSView visual fidelity.',
                  _akBlue,
                  Icons.layers),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _akModeCard(
                  'Virtual Display',
                  'NSView renders to an off-screen buffer, then '
                      'Flutter composites the pixels into its layer tree.',
                  _akGreen,
                  Icons.monitor),
            ),
          ],
        ),
      ),
      _akSubtitle('Hybrid composition trade-offs'),
      _akBullet('Pros', 'Full native rendering quality, correct z-ordering'),
      _akBullet('Cons',
          'More expensive compositing, potential thread contention'),
      _akSubtitle('Virtual display trade-offs'),
      _akBullet('Pros', 'Simpler compositing, fewer platform thread issues'),
      _akBullet('Cons',
          'Loss of some native rendering features, possible latency'),
    ];

Widget _akModeCard(String title, String desc, Color c, IconData icon) =>
    Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: c.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 28, color: c),
          const SizedBox(height: 6),
          Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: c)),
          const SizedBox(height: 4),
          Text(desc,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 10.5, color: Colors.black54, height: 1.4)),
        ],
      ),
    );

// ─── §6 Method reference ─────────────────────────────────────────
List<Widget> _akMethods() => [
      _akDivider(),
      _akTitle('§6  Method Reference'),
      _akBody(
          'Key methods and properties of the AppKitViewController:'),
      _akMethodCard('id', 'int', 'get',
          'Unique numeric identifier for this platform view instance',
          _akBurgundy),
      _akMethodCard('dispose()', 'Future<void>', 'method',
          'Releases all native resources held by this controller',
          _akAccent),
      _akMethodCard('setSize(Size)', 'Future<void>', 'method',
          'Updates the native view size to match Flutter layout',
          _akBlue),
      _akMethodCard('setOffset(Offset)', 'Future<void>', 'method',
          'Re-positions the native view within the Flutter surface',
          _akGreen),
      _akMethodCard('acceptGesture()', 'void', 'method',
          'Claims a gesture so the native view handles it',
          _akOrange),
      _akMethodCard('rejectGesture()', 'void', 'method',
          'Passes gesture back to the Flutter gesture arena',
          _akPurple),
    ];

Widget _akMethodCard(
    String name, String ret, String kind, String desc, Color c) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: c.withValues(alpha: 0.15)),
      boxShadow: [
        BoxShadow(
            color: c.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2)),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 4,
          height: 40,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(name,
                      style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: c,
                          fontFamily: 'monospace')),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 1),
                    decoration: BoxDecoration(
                      color: c.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(kind,
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: c)),
                  ),
                  const Spacer(),
                  Text(ret,
                      style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black45,
                          fontFamily: 'monospace')),
                ],
              ),
              const SizedBox(height: 3),
              Text(desc,
                  style: const TextStyle(
                      fontSize: 11, color: Colors.black54)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ─── §7 Gesture handling ─────────────────────────────────────────
List<Widget> _akGestures() => [
      _akDivider(),
      _akTitle('§7  Gesture Handling'),
      _akBody(
          'When a user touches or clicks the area occupied by the '
          'native view, Flutter must decide whether the gesture is '
          'handled by the native view or by Flutter widgets:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _akBlush,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _akLabel('Gesture arbitration flow'),
            const SizedBox(height: 10),
            _akGestureStep('User clicks in view area', _akBurgundy),
            _akGestureStep('Flutter hit-tests the location', _akBlue),
            _akGestureStep('Gesture arena receives the pointer', _akGreen),
            _akGestureStep('Native view competes with Flutter '
                'recognizers', _akOrange),
            _akGestureStep('Winner calls acceptGesture() or '
                'rejectGesture()', _akPurple),
            _akGestureStep('Events dispatched to winner only', _akTeal),
          ],
        ),
      ),
      _akCode(
          '// The AppKitView widget configures gesture handling:\n'
          'AppKitView(\n'
          '  viewType: \'native-text-view\',\n'
          '  // Options:\n'
          '  //   PlatformViewHitTestBehavior.opaque\n'
          '  //   PlatformViewHitTestBehavior.translucent\n'
          '  //   PlatformViewHitTestBehavior.transparent\n'
          '  hitTestBehavior:\n'
          '      PlatformViewHitTestBehavior.opaque,\n'
          '  gestureRecognizers: <Factory<\n'
          '      OneSequenceGestureRecognizer>>{},\n'
          ')'),
    ];

Widget _akGestureStep(String text, Color c) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(Icons.chevron_right, size: 16, color: c),
          const SizedBox(width: 6),
          Expanded(
            child: Text(text,
                style: TextStyle(
                    fontSize: 11.5,
                    color: c,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );

// ─── §8 Platform comparison ──────────────────────────────────────
List<Widget> _akComparison() => [
      _akDivider(),
      _akTitle('§8  Platform View Controllers Compared'),
      _akBody(
          'Flutter provides platform-specific view controllers for '
          'each supported desktop and mobile platform:'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _akBlush,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _akCompHeader(),
            _akCompEntry('macOS', 'AppKitViewController', 'NSView',
                _akBurgundy),
            _akCompEntry(
                'iOS', 'UiKitViewController', 'UIView', _akBlue),
            _akCompEntry(
                'Android', 'AndroidViewController', 'View', _akGreen),
            _akCompEntry(
                'Windows', 'WindowsViewController', 'HWND', _akOrange),
            _akCompEntry(
                'Linux', 'GtkViewController', 'GtkWidget', _akPurple),
            _akCompEntry('Web', 'HtmlElementController',
                'HTMLElement', _akTeal),
          ],
        ),
      ),
      _akNote(
          'All controllers share the same lifecycle pattern (create, '
          'resize, reposition, dispose) but differ in native API details.'),
    ];

Widget _akCompHeader() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: _akBurgundy.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Row(
        children: [
          Expanded(
              flex: 2,
              child: Text('Platform',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.black54))),
          Expanded(
              flex: 4,
              child: Text('Controller',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.black54))),
          Expanded(
              flex: 3,
              child: Text('Native View',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.black54))),
        ],
      ),
    );

Widget _akCompEntry(
        String platform, String controller, String view, Color c) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration:
                      BoxDecoration(color: c, shape: BoxShape.circle),
                ),
                const SizedBox(width: 6),
                Text(platform,
                    style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87)),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(controller,
                style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: c,
                    fontFamily: 'monospace')),
          ),
          Expanded(
            flex: 3,
            child: Text(view,
                style: const TextStyle(
                    fontSize: 10.5,
                    color: Colors.black54,
                    fontFamily: 'monospace')),
          ),
        ],
      ),
    );

// ─── §9 Common use cases ─────────────────────────────────────────
List<Widget> _akUseCases() => [
      _akDivider(),
      _akTitle('§9  Common Use Cases'),
      _akBody(
          'Scenarios where embedding native AppKit views is valuable:'),
      _akUseCaseCard(Icons.text_fields, 'Rich text editing',
          'Embed NSTextView for spell-check, dictation, and '
              'platform-native text services', _akBurgundy),
      _akUseCaseCard(Icons.map_outlined, 'Map views',
          'Embed MKMapView for Apple Maps with native gestures '
              'and satellite imagery', _akBlue),
      _akUseCaseCard(Icons.web, 'Web content',
          'Embed WKWebView for in-app browsing with full '
              'Safari rendering engine', _akGreen),
      _akUseCaseCard(Icons.videocam_outlined, 'Media players',
          'Embed AVPlayerView for hardware-decoded video with '
              'macOS media controls', _akOrange),
      _akUseCaseCard(Icons.draw_outlined, 'Drawing surfaces',
          'Embed custom NSOpenGLView or MTKView for native '
              'GPU-accelerated rendering', _akPurple),
    ];

Widget _akUseCaseCard(
    IconData icon, String title, String desc, Color c) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: c.withValues(alpha: 0.15)),
    ),
    child: Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: c.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: c),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: c)),
              const SizedBox(height: 2),
              Text(desc,
                  style: const TextStyle(
                      fontSize: 10.5,
                      color: Colors.black54,
                      height: 1.4)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ─── §10 Summary ─────────────────────────────────────────────────
List<Widget> _akSummary() => [
      _akDivider(),
      _akTitle('§10  Summary'),
      _akBody(
          'AppKitViewController is the macOS pillar of Flutter\'s '
          'platform view embedding, managing native NSView instances '
          'within the Flutter layer tree.'),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_akBurgundy.withValues(alpha: 0.07), _akBlush],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _akBurgundy.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Key takeaways',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _akBurgundy)),
            const SizedBox(height: 10),
            _akSumPt('macOS only',
                'Manages NSView instances for macOS integration'),
            _akSumPt('Lifecycle',
                'Create → connect → resize → reposition → dispose'),
            _akSumPt('Rendering',
                'Hybrid composition or virtual display modes'),
            _akSumPt('Gestures',
                'acceptGesture/rejectGesture for event arbitration'),
            _akSumPt('Platform channel',
                'Communicates via SystemChannels.platform_views'),
            _akSumPt('Common uses',
                'Maps, web views, text editors, media players'),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Center(
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _akBurgundy,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text('End of AppKitViewController Deep Demo',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3)),
        ),
      ),
      const SizedBox(height: 24),
    ];

Widget _akSumPt(String label, String desc) => Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4, right: 8),
            child:
                Icon(Icons.check_circle, size: 14, color: _akAccent),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$label — ',
                    style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: _akBurgundy)),
                TextSpan(
                    text: desc,
                    style: const TextStyle(
                        fontSize: 12.5, color: Colors.black87)),
              ]),
            ),
          ),
        ],
      ),
    );

// ═══════════════════════════════════════════════════════════════════
// ENTRY POINT
// ═══════════════════════════════════════════════════════════════════
dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _akBanner(),
        const SizedBox(height: 20),
        ..._akWhatIs(),
        ..._akArchitecture(),
        ..._akLifecycle(),
        ..._akRenderModes(),
        ..._akMethods(),
        ..._akGestures(),
        ..._akComparison(),
        ..._akUseCases(),
        ..._akSummary(),
      ],
    ),
  );
}

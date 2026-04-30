// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — Texture
// Demonstrates the Texture widget, which displays external texture data
// (video frames, camera feeds, platform views) by referencing a texture
// ID registered with the Flutter engine. Covers concept, API, platform
// integration, video playback, camera feeds, performance, and lifecycle.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Texture Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.video_library,
      'title': 'What is Texture?',
      'body': 'Texture is a widget that displays pixel data produced by '
          'a native platform texture. The texture is registered with '
          'the Flutter engine via a unique integer ID. The widget '
          'simply renders whatever the native side writes.',
      'accent': Colors.deepPurple,
    },
    {
      'icon': Icons.memory,
      'title': 'GPU-Backed Rendering',
      'body': 'Textures bypass Dart-side pixel copying. The native '
          'platform writes directly to a GPU texture buffer, and '
          'Flutter composites it into the scene graph. This is '
          'essential for high-throughput data like video.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.devices,
      'title': 'Platform Channels',
      'body': 'The native side creates a SurfaceTexture (Android) or '
          'CVPixelBuffer (iOS) and registers it with the Flutter '
          'engine. The engine returns a textureId that Dart passes '
          'to the Texture widget.',
      'accent': Colors.teal,
    },
    {
      'icon': Icons.play_circle_outline,
      'title': 'Common Use Cases',
      'body': 'Video players, camera previews, AR overlays, native '
          'map views, game engines, and any scenario where pixel '
          'data originates from platform-specific code.',
      'accent': Colors.orange,
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptItems.length; i++) {
    final e = conceptItems[i];
    final accent = e['accent'] as Color;
    print('Concept ${i + 1}: ${e['title']}');
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
  // SECTION 2: API
  // ============================================================
  print('=== Section 2: API ===');

  final apiEntries = <Map<String, String>>[
    {
      'name': 'textureId',
      'type': 'int',
      'desc': 'The unique identifier for the platform texture registered '
          'with the Flutter engine. This ID is obtained from the '
          'platform channel when creating the texture.',
    },
    {
      'name': 'filterQuality',
      'type': 'FilterQuality',
      'desc': 'Controls the sampling quality when the texture is scaled. '
          'FilterQuality.low for performance, .medium or .high for '
          'visual quality. Default is low.',
    },
    {
      'name': 'freeze',
      'type': 'bool',
      'desc': 'When true, the texture stops updating from the native '
          'source. Useful for pausing video or camera preview without '
          'releasing the texture. Default is false.',
    },
    {
      'name': 'key',
      'type': 'Key?',
      'desc': 'Standard Flutter widget key for identity within the tree. '
          'Use a ValueKey with the textureId to help the framework '
          'track texture widgets correctly.',
    },
  ];

  final apiWidgets = <Widget>[];
  for (var i = 0; i < apiEntries.length; i++) {
    final ae = apiEntries[i];
    print('API ${i + 1}: ${ae['name']}');
    apiWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.deepPurple.withOpacity(0.06)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.deepPurple.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    ae['name']!,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    ae['type']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              ae['desc']!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: Platform Integration
  // ============================================================
  print('=== Section 3: Platform ===');

  final platforms = <Map<String, dynamic>>[
    {
      'platform': 'Android',
      'desc': 'Uses SurfaceTexture. The native code creates a Surface, '
          'renders video/camera frames to it, and registers it via '
          'TextureRegistry.createSurfaceTexture(). The engine '
          'composites the SurfaceTexture into Flutter\'s scene.',
      'icon': Icons.android,
      'steps': [
        'Get TextureRegistry from FlutterEngine',
        'Call registry.createSurfaceTexture()',
        'Get the Surface from SurfaceTextureEntry',
        'Write pixel data to the Surface',
        'Pass textureId to Dart via MethodChannel',
      ],
      'color': Colors.green,
    },
    {
      'platform': 'iOS',
      'desc': 'Uses CVPixelBuffer. The native code creates a pixel '
          'buffer, copies video/camera frames into it, and registers '
          'via TextureRegistry.register(). Metal or OpenGL textures '
          'can also be used.',
      'icon': Icons.apple,
      'steps': [
        'Conform to FlutterTexture protocol',
        'Implement copyPixelBuffer method',
        'Register texture with FlutterEngine',
        'Call textureFrameAvailable on update',
        'Return textureId to Dart',
      ],
      'color': Colors.blue,
    },
    {
      'platform': 'Web',
      'desc': 'Uses HtmlElementView or CanvasElement. Web textures are '
          'handled differently — typically via platform views rather '
          'than the Texture widget itself. Video uses HTML5 video.',
      'icon': Icons.web,
      'steps': [
        'Register a view factory with platformViewRegistry',
        'Create an HTML VideoElement or CanvasElement',
        'Use HtmlElementView widget in Flutter',
        'Texture widget is not used directly on web',
        'Performance depends on browser compositing',
      ],
      'color': Colors.orange,
    },
    {
      'platform': 'Desktop (Windows/macOS/Linux)',
      'desc': 'Uses platform-specific GPU texture sharing. Each desktop '
          'platform has its own TextureRegistrar API for registering '
          'GPU buffers with the Flutter embedder.',
      'icon': Icons.desktop_windows,
      'steps': [
        'Get TextureRegistrar from Flutter engine',
        'Create a GPU texture buffer',
        'Register with TextureRegistrar',
        'Update buffer contents as needed',
        'Mark frames available for compositing',
      ],
      'color': Colors.deepPurple,
    },
  ];

  final platformWidgets = <Widget>[];
  for (var i = 0; i < platforms.length; i++) {
    final p = platforms[i];
    final pColor = p['color'] as Color;
    final steps = p['steps'] as List<String>;
    print('Platform ${i + 1}: ${p['platform']}');

    final stepWidgets = <Widget>[];
    for (var j = 0; j < steps.length; j++) {
      stepWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 18,
                height: 18,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: pColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${j + 1}',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: pColor,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  steps[j],
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade700,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    platformWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: pColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: pColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(p['icon'] as IconData, color: pColor, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    p['platform'] as String,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: pColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                p['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: pColor.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: pColor.withOpacity(0.1)),
                ),
                child: Column(children: stepWidgets),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: Video Playback
  // ============================================================
  print('=== Section 4: Video ===');

  final videoTopics = <Map<String, dynamic>>[
    {
      'title': 'VideoPlayerController',
      'desc': 'The video_player package creates a platform texture for '
          'video frames. Once initialized, the controller exposes a '
          'textureId that is passed to the Texture widget. The '
          'controller manages play, pause, seek, and buffering.',
      'icon': Icons.play_arrow,
      'color': Colors.deepPurple,
    },
    {
      'title': 'Aspect Ratio',
      'desc': 'Video textures have an intrinsic aspect ratio determined '
          'by the source resolution. Use AspectRatio or FittedBox '
          'around the Texture widget to preserve the source ratio '
          'and prevent stretching.',
      'icon': Icons.aspect_ratio,
      'color': Colors.blue,
    },
    {
      'title': 'Buffering States',
      'desc': 'Before the first frame arrives, the texture may be blank. '
          'Show a placeholder (loading spinner, poster image) until '
          'the controller reports isInitialized. Handle buffering '
          'events for network streams.',
      'icon': Icons.hourglass_empty,
      'color': Colors.orange,
    },
    {
      'title': 'Disposal',
      'desc': 'Always dispose the VideoPlayerController when done. This '
          'releases the native texture and platform resources. '
          'Failure to dispose causes memory leaks and orphaned '
          'platform textures.',
      'icon': Icons.delete_outline,
      'color': Colors.red,
    },
  ];

  final videoWidgets = <Widget>[];
  for (var i = 0; i < videoTopics.length; i++) {
    final vt = videoTopics[i];
    final vtColor = vt['color'] as Color;
    print('Video ${i + 1}: ${vt['title']}');
    videoWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: vtColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: vtColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: vtColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(vt['icon'] as IconData, color: vtColor, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vt['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: vtColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      vt['desc'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        height: 1.35,
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

  // Video flow diagram
  final videoFlowSteps = [
    'Create Controller',
    'Initialize (async)',
    'Get textureId',
    'Build Texture(textureId: id)',
    'Play / Pause / Seek',
    'Dispose Controller',
  ];

  final videoFlow = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.deepPurple.withOpacity(0.04),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.deepPurple.withOpacity(0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Video Playback Flow',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(height: 8),
        ...List.generate(videoFlowSteps.length, (idx) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                Container(
                  width: 22,
                  height: 22,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${idx + 1}',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  videoFlowSteps[idx],
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
                if (idx < videoFlowSteps.length - 1)
                  const Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Icon(Icons.arrow_forward, size: 12, color: Colors.deepPurple),
                  ),
              ],
            ),
          );
        }),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Camera Feed
  // ============================================================
  print('=== Section 5: Camera ===');

  final cameraTopics = <Map<String, dynamic>>[
    {
      'title': 'CameraController',
      'desc': 'The camera package creates a texture for the live camera '
          'preview. CameraController.initialize() sets up the camera '
          'hardware and registers a texture with the engine.',
      'icon': Icons.camera_alt,
      'color': Colors.deepPurple,
    },
    {
      'title': 'Resolution Presets',
      'desc': 'Camera textures come in preset resolutions: low (352x288), '
          'medium (640x480), high (1280x720), veryHigh (1920x1080), '
          'ultraHigh (3840x2160), max (device maximum).',
      'icon': Icons.high_quality,
      'color': Colors.blue,
    },
    {
      'title': 'Rotation & Orientation',
      'desc': 'Camera texture orientation may not match device orientation. '
          'Use CameraController.value.description.sensorOrientation '
          'and RotatedBox to correct the preview angle.',
      'icon': Icons.rotate_right,
      'color': Colors.teal,
    },
    {
      'title': 'Permissions',
      'desc': 'Camera access requires runtime permissions. The app must '
          'request camera permission (and microphone if recording '
          'video) before initializing the controller.',
      'icon': Icons.security,
      'color': Colors.red,
    },
  ];

  final cameraWidgets = <Widget>[];
  for (var i = 0; i < cameraTopics.length; i++) {
    final ct = cameraTopics[i];
    final ctColor = ct['color'] as Color;
    print('Camera ${i + 1}: ${ct['title']}');
    cameraWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: ctColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ctColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ctColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(ct['icon'] as IconData, color: ctColor, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ct['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ctColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      ct['desc'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        height: 1.35,
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
  // SECTION 6: Performance
  // ============================================================
  print('=== Section 6: Performance ===');

  final perfTopics = <Map<String, dynamic>>[
    {
      'title': 'Zero-Copy Compositing',
      'desc': 'The Texture widget avoids copying pixels from native to '
          'Dart. The GPU texture is composited directly into the '
          'Flutter scene graph. This is critical for 60fps video.',
      'metric': 'Zero pixel copy overhead',
      'color': Colors.deepPurple,
    },
    {
      'title': 'FilterQuality Trade-off',
      'desc': 'FilterQuality.low uses nearest-neighbor sampling (fastest). '
          'FilterQuality.high uses bilinear + mipmap (best quality). '
          'Choose based on whether the texture is scaled.',
      'metric': 'low: 0ms, high: ~1ms per frame',
      'color': Colors.blue,
    },
    {
      'title': 'Frame Rate Matching',
      'desc': 'If the native source produces frames faster than the '
          'Flutter vsync rate, frames are dropped. If slower, the '
          'last frame is held. No explicit sync is needed.',
      'metric': 'Automatic vsync alignment',
      'color': Colors.teal,
    },
    {
      'title': 'Freeze for Pause',
      'desc': 'Setting freeze=true stops the engine from requesting new '
          'frames from the native texture. More efficient than '
          'continuously compositing the same frame.',
      'metric': 'Eliminates idle compositing cost',
      'color': Colors.orange,
    },
    {
      'title': 'Multiple Textures',
      'desc': 'Each Texture widget has its own textureId and native '
          'buffer. Running many textures simultaneously increases '
          'GPU memory usage. Profile with DevTools.',
      'metric': 'Memory scales with resolution x count',
      'color': Colors.red,
    },
  ];

  final perfWidgets = <Widget>[];
  for (var i = 0; i < perfTopics.length; i++) {
    final pt = perfTopics[i];
    final ptColor = pt['color'] as Color;
    print('Perf ${i + 1}: ${pt['title']}');
    perfWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: ptColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ptColor.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  pt['title'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ptColor,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: ptColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    pt['metric'] as String,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: ptColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              pt['desc'] as String,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 7: Lifecycle
  // ============================================================
  print('=== Section 7: Lifecycle ===');

  final lifecycleSteps = <Map<String, dynamic>>[
    {
      'step': '1. Register Texture',
      'desc': 'Native platform creates a texture buffer and registers '
          'it with the Flutter engine. The engine returns a unique '
          'textureId for identification.',
      'icon': Icons.add_circle,
      'color': Colors.deepPurple,
    },
    {
      'step': '2. Pass ID to Dart',
      'desc': 'The textureId is sent to the Dart side via a platform '
          'channel. The Dart code stores it and uses it to construct '
          'the Texture widget.',
      'icon': Icons.swap_horiz,
      'color': Colors.blue,
    },
    {
      'step': '3. Build Texture Widget',
      'desc': 'The Texture widget with the given textureId is inserted '
          'into the widget tree. The engine maps it to the native '
          'texture buffer for compositing.',
      'icon': Icons.widgets,
      'color': Colors.teal,
    },
    {
      'step': '4. Frame Updates',
      'desc': 'The native side writes new frame data and marks it '
          'available. The engine composites the latest frame during '
          'the next vsync cycle.',
      'icon': Icons.refresh,
      'color': Colors.green,
    },
    {
      'step': '5. Freeze (Optional)',
      'desc': 'Set freeze=true to pause updates while keeping the '
          'texture allocated. Useful for pausing video or background '
          'tab optimization.',
      'icon': Icons.pause,
      'color': Colors.orange,
    },
    {
      'step': '6. Dispose',
      'desc': 'Unregister the texture from the engine and release the '
          'native buffer. The Texture widget should be removed from '
          'the tree before or at disposal time.',
      'icon': Icons.delete_outline,
      'color': Colors.red,
    },
  ];

  final lifecycleWidgets = <Widget>[];
  for (var i = 0; i < lifecycleSteps.length; i++) {
    final ls = lifecycleSteps[i];
    final lsColor = ls['color'] as Color;
    print('Lifecycle ${i + 1}: ${ls['step']}');
    lifecycleWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: lsColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    ls['icon'] as IconData,
                    color: lsColor,
                    size: 20,
                  ),
                ),
                if (i < lifecycleSteps.length - 1)
                  Container(
                    width: 2,
                    height: 30,
                    color: lsColor.withOpacity(0.2),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: lsColor.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: lsColor.withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ls['step'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: lsColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ls['desc'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        height: 1.35,
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
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.video_library,
      'text': 'Texture displays external native pixel data using a GPU '
          'texture registered with the Flutter engine.',
    },
    {
      'icon': Icons.memory,
      'text': 'Zero-copy compositing avoids Dart-side pixel transfer, '
          'enabling smooth 60fps video and camera rendering.',
    },
    {
      'icon': Icons.devices,
      'text': 'Each platform (Android, iOS, Web, Desktop) has its own '
          'texture registration mechanism.',
    },
    {
      'icon': Icons.play_circle_outline,
      'text': 'Common patterns: video_player package, camera package, '
          'AR overlays, and native map views.',
    },
    {
      'icon': Icons.speed,
      'text': 'FilterQuality controls scaling quality. freeze=true pauses '
          'updates efficiently.',
    },
    {
      'icon': Icons.delete_outline,
      'text': 'Always dispose controllers and unregister textures to '
          'prevent GPU memory leaks.',
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
          color: Colors.deepPurple.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.deepPurple.withOpacity(0.12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.deepPurple,
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
        title: const Text('Texture'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.devices), text: 'Platform'),
            Tab(icon: Icon(Icons.play_arrow), text: 'Video'),
            Tab(icon: Icon(Icons.camera_alt), text: 'Camera'),
            Tab(icon: Icon(Icons.speed), text: 'Performance'),
            Tab(icon: Icon(Icons.loop), text: 'Lifecycle'),
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
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Texture: renders native pixel data (video, camera) via '
                  'GPU texture compositing.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),
          // Tab 2: API
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Simple API: textureId, filterQuality, and freeze.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
            ],
          ),
          // Tab 3: Platform
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Platform-specific texture registration mechanisms.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...platformWidgets,
            ],
          ),
          // Tab 4: Video
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Video playback integration using Texture widget.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...videoWidgets,
              videoFlow,
            ],
          ),
          // Tab 5: Camera
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Camera preview integration with Texture.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...cameraWidgets,
            ],
          ),
          // Tab 6: Performance
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Performance characteristics and optimization tips.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...perfWidgets,
            ],
          ),
          // Tab 7: Lifecycle
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Texture lifecycle: register, build, update, dispose.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...lifecycleWidgets,
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
                      Colors.deepPurple.withOpacity(0.12),
                      Colors.purple.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about Texture.',
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

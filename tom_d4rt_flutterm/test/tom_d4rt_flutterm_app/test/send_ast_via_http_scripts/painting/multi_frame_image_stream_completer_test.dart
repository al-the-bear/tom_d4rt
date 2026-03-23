// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep demo of MultiFrameImageStreamCompleter from painting
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.deepPurple.shade700,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget buildInfoCard(String label, String value) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildPropertyRow(String property, String type, String description) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            property,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.deepPurple.shade800,
            ),
          ),
        ),
        SizedBox(
          width: 100,
          child: Text(
            type,
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue.shade700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildFrameCard(int frameIndex, Duration duration, String status) {
  Color statusColor = Colors.grey;
  if (status == 'Current') {
    statusColor = Colors.green;
  } else if (status == 'Loaded') {
    statusColor = Colors.blue;
  } else if (status == 'Pending') {
    statusColor = Colors.orange;
  }

  return Container(
    width: 100,
    margin: EdgeInsets.all(4),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: statusColor.withAlpha(30),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: statusColor, width: 2),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Frame $frameIndex',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        SizedBox(height: 4),
        Text(
          '${duration.inMilliseconds}ms',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
        SizedBox(height: 4),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            status,
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        ),
      ],
    ),
  );
}

Widget buildChunkProgressBar(double progress, String label) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            Spacer(),
            Text(
              '${(progress * 100).toInt()}%',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
        SizedBox(height: 4),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildTimelineEvent(String time, String event, IconData icon) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 60,
          child: Text(
            time,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade100,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 16, color: Colors.deepPurple.shade700),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            event,
            style: TextStyle(fontSize: 13),
          ),
        ),
      ],
    ),
  );
}

Widget buildCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: Colors.green.shade300,
      ),
    ),
  );
}

Widget buildComparisonTable() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Feature',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'MultiFrame',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'OneFrame',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        _buildComparisonRow('Frame Count', 'Multiple', 'Single'),
        _buildComparisonRow('Animation', 'Yes (timing)', 'No'),
        _buildComparisonRow('Codec Source', 'Stream<Codec>', 'Future<ImageInfo>'),
        _buildComparisonRow('Use Case', 'GIF, APNG, WebP', 'PNG, JPEG, BMP'),
        _buildComparisonRow('Memory', 'Higher (frames)', 'Lower'),
        _buildComparisonRow('Complexity', 'Higher', 'Simple'),
      ],
    ),
  );
}

Widget _buildComparisonRow(String feature, String multi, String one) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      border: Border(top: BorderSide(color: Colors.grey.shade200)),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(feature, style: TextStyle(fontSize: 12)),
        ),
        Expanded(
          flex: 2,
          child: Text(
            multi,
            style: TextStyle(fontSize: 12, color: Colors.deepPurple.shade700),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            one,
            style: TextStyle(fontSize: 12, color: Colors.blue.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildAnimationSimulator() {
  List<Map<String, dynamic>> frames = [
    {'index': 0, 'duration': Duration(milliseconds: 100), 'status': 'Loaded'},
    {'index': 1, 'duration': Duration(milliseconds: 100), 'status': 'Current'},
    {'index': 2, 'duration': Duration(milliseconds: 150), 'status': 'Pending'},
    {'index': 3, 'duration': Duration(milliseconds: 100), 'status': 'Pending'},
    {'index': 4, 'duration': Duration(milliseconds: 200), 'status': 'Pending'},
  ];

  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Animation Frame Sequence',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: frames.map((f) {
              return buildFrameCard(
                f['index'] as int,
                f['duration'] as Duration,
                f['status'] as String,
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            _buildLegendItem(Colors.green, 'Current'),
            SizedBox(width: 16),
            _buildLegendItem(Colors.blue, 'Loaded'),
            SizedBox(width: 16),
            _buildLegendItem(Colors.orange, 'Pending'),
          ],
        ),
      ],
    ),
  );
}

Widget _buildLegendItem(Color color, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      SizedBox(width: 4),
      Text(label, style: TextStyle(fontSize: 11)),
    ],
  );
}

dynamic build(BuildContext context) {
  print('=== MultiFrameImageStreamCompleter Deep Demo ===\n');

  print('Section 1: MultiFrameImageStreamCompleter Constructor');
  print('Purpose: Manages decoding and timing of animated image frames');
  print('Constructor signature:');
  print('  MultiFrameImageStreamCompleter({');
  print('    required Future<ui.Codec> codec,');
  print('    required double scale,');
  print('    String? debugLabel,');
  print('    Stream<ImageChunkEvent>? chunkEvents,');
  print('    InformationCollector? informationCollector,');
  print('  })');

  print('\nSection 2: Codec Parameter');
  print('The codec parameter is a Future<ui.Codec> that provides:');
  print('  - Frame count: Number of frames in animation');
  print('  - Frame info: Width, height, duration per frame');
  print('  - Decoding: Ability to decode individual frames');
  print('  - Repetition: How many times to loop (-1 = forever)');

  print('\nSection 3: Scale Parameter');
  print('Scale affects the final ImageInfo:');
  print('  - scale: 1.0 -> Full resolution');
  print('  - scale: 2.0 -> Half display size (2x density)');
  print('  - scale: 3.0 -> Third display size (3x density)');
  print('Used for device pixel ratio handling');

  print('\nSection 4: DebugLabel Parameter');
  print('Optional string for debugging:');
  print('  - Appears in error messages');
  print('  - Helps identify image source');
  print('  - Example: "NetworkImage(https://example.com/anim.gif)"');

  print('\nSection 5: ChunkEvents Parameter');
  print('Stream<ImageChunkEvent> for loading progress:');
  print('  - cumulativeBytesLoaded: Bytes downloaded so far');
  print('  - expectedTotalBytes: Total size (if known)');
  print('  - Enables progress indicators');
  print('  - Can be null if progress tracking not needed');

  print('\nSection 6: Multiple Frames Simulation');
  List<Map<String, dynamic>> simulatedFrames = [
    {'index': 0, 'durationMs': 100, 'width': 256, 'height': 256},
    {'index': 1, 'durationMs': 100, 'width': 256, 'height': 256},
    {'index': 2, 'durationMs': 150, 'width': 256, 'height': 256},
    {'index': 3, 'durationMs': 100, 'width': 256, 'height': 256},
    {'index': 4, 'durationMs': 200, 'width': 256, 'height': 256},
    {'index': 5, 'durationMs': 100, 'width': 256, 'height': 256},
  ];

  int totalDuration = 0;
  for (var frame in simulatedFrames) {
    int duration = frame['durationMs'] as int;
    totalDuration += duration;
    print('  Frame ${frame['index']}: ${duration}ms, ${frame['width']}x${frame['height']}');
  }
  print('  Total animation duration: ${totalDuration}ms');
  print('  Frames per second: ${(1000 / (totalDuration / simulatedFrames.length)).toStringAsFixed(1)}');

  print('\nSection 7: Frame Timing');
  print('Frame timing controls animation playback:');
  print('  - Duration from codec frame info');
  print('  - Timer schedules next frame');
  print('  - vsync alignment for smooth playback');
  print('  - Handles variable frame durations');

  print('\nLifecycle Events:');
  List<Map<String, String>> lifecycleEvents = [
    {'time': '0ms', 'event': 'Completer created'},
    {'time': '50ms', 'event': 'Codec future completes'},
    {'time': '51ms', 'event': 'First frame decoded'},
    {'time': '52ms', 'event': 'Listeners notified'},
    {'time': '152ms', 'event': 'Frame 1 displayed (100ms delay)'},
    {'time': '252ms', 'event': 'Frame 2 displayed (100ms delay)'},
    {'time': '402ms', 'event': 'Frame 3 displayed (150ms delay)'},
  ];
  for (var event in lifecycleEvents) {
    print('  ${event['time']}: ${event['event']}');
  }

  print('\nError Handling:');
  print('  - Codec loading failure -> reportError()');
  print('  - Frame decoding failure -> reportError()');
  print('  - Uses informationCollector for debug info');
  print('  - Errors propagate to all listeners');

  print('\nMemory Management:');
  print('  - Frames decoded on demand');
  print('  - Current frame held in memory');
  print('  - Previous frames may be released');
  print('  - Codec disposed when completer disposed');

  print('\n=== MultiFrameImageStreamCompleter Demo Complete ===');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade700, Colors.purple.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.animation, size: 48, color: Colors.white),
              SizedBox(height: 8),
              Text(
                'MultiFrameImageStreamCompleter',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Animated Image Frame Manager',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),

        buildSectionHeader('1. Constructor Overview'),
        buildInfoCard('Class', 'MultiFrameImageStreamCompleter'),
        buildInfoCard('Extends', 'ImageStreamCompleter'),
        buildInfoCard('Purpose', 'Manages decoding and timing of animated image frames'),
        buildInfoCard('Use Case', 'GIF, APNG, animated WebP images'),

        SizedBox(height: 8),
        Text(
          'Constructor Parameters:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 4),
        buildPropertyRow('codec', 'Future<ui.Codec>', 'Required. Decoded image codec with frame data'),
        buildPropertyRow('scale', 'double', 'Required. Display scale factor (1.0, 2.0, 3.0)'),
        buildPropertyRow('debugLabel', 'String?', 'Optional label for debugging'),
        buildPropertyRow('chunkEvents', 'Stream<ImageChunkEvent>?', 'Optional loading progress stream'),
        buildPropertyRow('informationCollector', 'InformationCollector?', 'Debug information collector'),

        buildSectionHeader('2. Codec Parameter Details'),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ui.Codec provides:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 8),
              _buildCodecProperty('frameCount', 'int', 'Number of frames in animation'),
              _buildCodecProperty('repetitionCount', 'int', 'Loop count (-1 = infinite)'),
              _buildCodecProperty('getNextFrame()', 'Future<FrameInfo>', 'Decodes next frame'),
              _buildCodecProperty('dispose()', 'void', 'Releases native resources'),
            ],
          ),
        ),

        SizedBox(height: 12),
        buildCodeBlock(
          'Future<ui.Codec> loadCodec() async {\n'
          '  final data = await fetchImageBytes();\n'
          '  return await ui.instantiateImageCodec(data);\n'
          '}\n\n'
          'final completer = MultiFrameImageStreamCompleter(\n'
          '  codec: loadCodec(),\n'
          '  scale: 1.0,\n'
          ');',
        ),

        buildSectionHeader('3. Scale Parameter'),
        buildInfoCard('Purpose', 'Determines final display size of image'),
        buildInfoCard('Default', '1.0 (no scaling)'),
        SizedBox(height: 8),

        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Scale Examples:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _buildScaleExample('1.0', '256x256 image -> 256x256 display'),
              _buildScaleExample('2.0', '256x256 image -> 128x128 display (2x density)'),
              _buildScaleExample('3.0', '256x256 image -> 85x85 display (3x density)'),
              _buildScaleExample('0.5', '256x256 image -> 512x512 display'),
            ],
          ),
        ),

        buildSectionHeader('4. DebugLabel Parameter'),
        buildInfoCard('Type', 'String? (optional)'),
        buildInfoCard('Purpose', 'Identifies image source in error messages'),

        buildCodeBlock(
          'MultiFrameImageStreamCompleter(\n'
          '  codec: loadCodec(),\n'
          '  scale: 1.0,\n'
          '  debugLabel: "AnimatedGif(assets/loading.gif)",\n'
          ');',
        ),

        Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.amber.shade700),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'DebugLabel appears in Flutter DevTools and error stack traces to help identify which image caused an issue.',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),

        buildSectionHeader('5. ChunkEvents Parameter'),
        buildInfoCard('Type', 'Stream<ImageChunkEvent>?'),
        buildInfoCard('Purpose', 'Reports download progress for network images'),

        SizedBox(height: 8),
        Text(
          'ImageChunkEvent Properties:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        buildPropertyRow('cumulativeBytesLoaded', 'int', 'Bytes downloaded so far'),
        buildPropertyRow('expectedTotalBytes', 'int?', 'Total size if known from headers'),

        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Simulated Download Progress:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 12),
              buildChunkProgressBar(0.25, 'Frame 1 chunk'),
              buildChunkProgressBar(0.50, 'Frame 2 chunk'),
              buildChunkProgressBar(0.75, 'Frame 3 chunk'),
              buildChunkProgressBar(1.0, 'Frame 4 chunk'),
            ],
          ),
        ),

        buildCodeBlock(
          'Stream<ImageChunkEvent> createChunkStream() async* {\n'
          '  final response = await httpClient.get(url);\n'
          '  int loaded = 0;\n'
          '  final total = response.contentLength;\n'
          '  \n'
          '  await for (final chunk in response.chunks) {\n'
          '    loaded += chunk.length;\n'
          '    yield ImageChunkEvent(\n'
          '      cumulativeBytesLoaded: loaded,\n'
          '      expectedTotalBytes: total,\n'
          '    );\n'
          '  }\n'
          '}',
        ),

        buildSectionHeader('6. Multiple Frames Simulation'),
        buildAnimationSimulator(),

        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.deepPurple.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Frame Statistics:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 8),
              _buildStatRow('Total Frames', '5'),
              _buildStatRow('Average Duration', '130ms'),
              _buildStatRow('Total Animation', '650ms'),
              _buildStatRow('Effective FPS', '7.7'),
              _buildStatRow('Repetition Count', '-1 (infinite)'),
            ],
          ),
        ),

        SizedBox(height: 12),
        Text(
          'Frame Decoding Process:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(height: 8),
        buildTimelineEvent('0ms', 'Completer instantiated with codec Future', Icons.start),
        buildTimelineEvent('45ms', 'Codec Future resolves, UI.Codec ready', Icons.check_circle),
        buildTimelineEvent('46ms', 'getNextFrame() called for Frame 0', Icons.download),
        buildTimelineEvent('52ms', 'Frame 0 decoded, ImageInfo created', Icons.image),
        buildTimelineEvent('53ms', 'setImage() notifies all listeners', Icons.notifications_active),
        buildTimelineEvent('153ms', 'Timer fires, decode Frame 1 (100ms later)', Icons.timer),
        buildTimelineEvent('160ms', 'Frame 1 ready, listeners notified', Icons.notifications),
        buildTimelineEvent('310ms', 'Frame 2 ready (150ms duration)', Icons.notifications),

        buildSectionHeader('7. Frame Timing'),
        buildInfoCard('Timing Source', 'FrameInfo.duration from codec'),
        buildInfoCard('Scheduler', 'Timer-based with vsync alignment'),
        buildInfoCard('Variable Timing', 'Each frame can have different duration'),

        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Timing Diagram:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 8),
              _buildTimingBar('Frame 0', 0.0, 0.15, Colors.red),
              _buildTimingBar('Frame 1', 0.15, 0.30, Colors.orange),
              _buildTimingBar('Frame 2', 0.30, 0.53, Colors.yellow.shade700),
              _buildTimingBar('Frame 3', 0.53, 0.68, Colors.green),
              _buildTimingBar('Frame 4', 0.68, 1.0, Colors.blue),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('0ms', style: TextStyle(fontSize: 10)),
                  Text('Time', style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic)),
                  Text('650ms', style: TextStyle(fontSize: 10)),
                ],
              ),
            ],
          ),
        ),

        buildCodeBlock(
          'void _handleCodecReady(ui.Codec codec) {\n'
          '  _codec = codec;\n'
          '  _frameCount = codec.frameCount;\n'
          '  _decodeNextFrame();\n'
          '}\n\n'
          'void _decodeNextFrame() async {\n'
          '  final frameInfo = await _codec.getNextFrame();\n'
          '  final duration = frameInfo.duration;\n'
          '  \n'
          '  setImage(ImageInfo(\n'
          '    image: frameInfo.image,\n'
          '    scale: _scale,\n'
          '  ));\n'
          '  \n'
          '  _timer = Timer(duration, _decodeNextFrame);\n'
          '}',
        ),

        buildSectionHeader('Comparison: MultiFrame vs OneFrame'),
        buildComparisonTable(),

        buildSectionHeader('Error Handling'),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.red.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.red.shade700),
                  SizedBox(width: 8),
                  Text(
                    'Error Scenarios:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.red.shade700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              _buildErrorItem('Network failure during codec load'),
              _buildErrorItem('Corrupted image data'),
              _buildErrorItem('Unsupported codec format'),
              _buildErrorItem('Frame decoding failure'),
              _buildErrorItem('Out of memory during decode'),
            ],
          ),
        ),

        buildCodeBlock(
          'try {\n'
          '  final codec = await loadCodec();\n'
          '  _handleCodecReady(codec);\n'
          '} catch (error, stack) {\n'
          '  reportError(\n'
          '    exception: error,\n'
          '    stack: stack,\n'
          '    informationCollector: _informationCollector,\n'
          '    context: ErrorDescription("Loading image"),\n'
          '  );\n'
          '}',
        ),

        buildSectionHeader('Memory Management'),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.cyan.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.cyan.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Memory Lifecycle:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 8),
              _buildMemoryItem(Icons.memory, 'Codec loaded into memory'),
              _buildMemoryItem(Icons.image, 'Frame decoded on demand'),
              _buildMemoryItem(Icons.cached, 'Current frame cached'),
              _buildMemoryItem(Icons.delete_outline, 'Previous frames released'),
              _buildMemoryItem(Icons.cleaning_services, 'Codec disposed on removeListener'),
            ],
          ),
        ),

        SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Icon(Icons.check_circle, size: 40, color: Colors.green),
              SizedBox(height: 8),
              Text(
                'MultiFrameImageStreamCompleter Demo Complete',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'All sections demonstrated: Constructor, Codec, Scale, DebugLabel, ChunkEvents, Frames, Timing',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    ),
  );
}

Widget _buildCodecProperty(String name, String type, String desc) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(width: 8, height: 8, margin: EdgeInsets.only(top: 4, right: 8),
          decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle)),
        Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        Text(' -> ', style: TextStyle(fontSize: 12)),
        Text(type, style: TextStyle(fontSize: 12, color: Colors.blue.shade700)),
        Text(': ', style: TextStyle(fontSize: 12)),
        Expanded(child: Text(desc, style: TextStyle(fontSize: 12))),
      ],
    ),
  );
}

Widget _buildScaleExample(String scale, String result) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 50,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(scale, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
        ),
        SizedBox(width: 12),
        Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
        SizedBox(width: 12),
        Text(result, style: TextStyle(fontSize: 12)),
      ],
    ),
  );
}

Widget _buildStatRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 12)),
        Text(value, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

Widget _buildTimingBar(String label, double start, double end, Color color) {
  return Container(
    height: 24,
    margin: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(label, style: TextStyle(fontSize: 10)),
        ),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Positioned(
                left: start * 200,
                child: Container(
                  width: (end - start) * 200,
                  height: 16,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(2),
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

Widget _buildErrorItem(String error) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Icon(Icons.warning_amber, size: 14, color: Colors.red.shade400),
        SizedBox(width: 8),
        Text(error, style: TextStyle(fontSize: 12)),
      ],
    ),
  );
}

Widget _buildMemoryItem(IconData icon, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: Colors.cyan.shade700),
        SizedBox(width: 8),
        Text(description, style: TextStyle(fontSize: 12)),
      ],
    ),
  );
}

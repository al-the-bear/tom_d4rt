// ignore_for_file: avoid_print
// D4rt test script: Tests ImageCacheStatus from painting
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.teal.shade700,
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

Widget buildStatusIndicator(String statusName, bool isActive, Color color, String description) {
  print('Building status indicator: $statusName = $isActive');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: isActive ? color.withAlpha(30) : Colors.grey.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: isActive ? color : Colors.grey.shade300,
        width: isActive ? 2 : 1,
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: isActive ? color : Colors.grey.shade400,
            shape: BoxShape.circle,
          ),
          child: Icon(
            isActive ? Icons.check : Icons.close,
            color: Colors.white,
            size: 16,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                statusName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isActive ? color.withAlpha(230) : Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isActive ? color : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            isActive ? 'ACTIVE' : 'INACTIVE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildCacheStateCard(
  String title,
  bool pending,
  bool keepAlive,
  bool live,
  String scenario,
  Color themeColor,
) {
  print('Building cache state card: $title');
  bool tracking = pending || keepAlive || live;
  bool untracked = !tracking;
  
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: themeColor.withAlpha(100)),
      boxShadow: [
        BoxShadow(
          color: themeColor.withAlpha(20),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: themeColor.withAlpha(30),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.memory,
                color: themeColor,
                size: 24,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    scenario,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Divider(color: Colors.grey.shade200),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: buildMiniStatusChip('pending', pending, Colors.orange),
            ),
            SizedBox(width: 8),
            Expanded(
              child: buildMiniStatusChip('keepAlive', keepAlive, Colors.blue),
            ),
            SizedBox(width: 8),
            Expanded(
              child: buildMiniStatusChip('live', live, Colors.green),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: buildMiniStatusChip('tracking', tracking, Colors.purple),
            ),
            SizedBox(width: 8),
            Expanded(
              child: buildMiniStatusChip('untracked', untracked, Colors.grey),
            ),
            SizedBox(width: 8),
            Expanded(child: SizedBox()),
          ],
        ),
      ],
    ),
  );
}

Widget buildMiniStatusChip(String label, bool active, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(
      color: active ? color.withAlpha(30) : Colors.grey.shade100,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(
        color: active ? color : Colors.grey.shade300,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: active ? color : Colors.grey.shade400,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 6),
        Flexible(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: active ? color.withAlpha(230) : Colors.grey.shade500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

Widget buildPropertyExplanationCard(
  String property,
  String explanation,
  String whenTrue,
  String whenFalse,
  IconData icon,
  Color color,
) {
  print('Building property explanation: $property');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withAlpha(30),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            SizedBox(width: 12),
            Text(
              property,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          explanation,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green.shade600, size: 16),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'When true: $whenTrue',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green.shade800,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.cancel, color: Colors.red.shade600, size: 16),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'When false: $whenFalse',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red.shade800,
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

Widget buildTrackingVisualization(bool tracking, bool untracked) {
  print('Building tracking visualization: tracking=$tracking, untracked=$untracked');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: tracking
            ? [Colors.purple.shade100, Colors.purple.shade50]
            : [Colors.grey.shade200, Colors.grey.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: tracking ? Colors.purple.shade300 : Colors.grey.shade400,
      ),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              tracking ? Icons.visibility : Icons.visibility_off,
              color: tracking ? Colors.purple.shade700 : Colors.grey.shade600,
              size: 32,
            ),
            SizedBox(width: 12),
            Text(
              tracking ? 'IMAGE IS TRACKED' : 'IMAGE IS UNTRACKED',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: tracking ? Colors.purple.shade700 : Colors.grey.shade700,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(180),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            tracking
                ? 'The ImageCache is actively managing this image entry. At least one of pending, keepAlive, or live is true.'
                : 'The image is not being managed by the cache. It may have been evicted or was never cached.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildCacheLifecycleFlow() {
  print('Building cache lifecycle flow');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Image Cache Lifecycle',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 16),
        buildLifecycleStep(1, 'Request Image', 'ImageProvider resolves key', Colors.blue, true),
        buildLifecycleArrow(),
        buildLifecycleStep(2, 'Pending', 'Codec decoding in progress', Colors.orange, true),
        buildLifecycleArrow(),
        buildLifecycleStep(3, 'Live', 'Active listeners present', Colors.green, true),
        buildLifecycleArrow(),
        buildLifecycleStep(4, 'KeepAlive', 'No listeners, cached for reuse', Colors.blue, true),
        buildLifecycleArrow(),
        buildLifecycleStep(5, 'Evicted', 'Memory pressure or cache full', Colors.red, false),
      ],
    ),
  );
}

Widget buildLifecycleStep(int step, String title, String description, Color color, bool isTracked) {
  return Row(
    children: [
      Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '$step',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
      SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.grey.shade800,
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: isTracked ? Colors.green.shade100 : Colors.red.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    isTracked ? 'tracked' : 'untracked',
                    style: TextStyle(
                      fontSize: 10,
                      color: isTracked ? Colors.green.shade700 : Colors.red.shade700,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildLifecycleArrow() {
  return Padding(
    padding: EdgeInsets.only(left: 16),
    child: Column(
      children: [
        Container(
          width: 2,
          height: 16,
          color: Colors.grey.shade400,
        ),
        Icon(Icons.arrow_downward, size: 16, color: Colors.grey.shade400),
      ],
    ),
  );
}

Widget buildSimulatedCacheStatePanel(String scenario, Map<String, bool> states, Color color) {
  print('Building simulated cache state: $scenario');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(100)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.science, color: color, size: 20),
            SizedBox(width: 8),
            Text(
              scenario,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: states.entries.map((entry) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: entry.value ? color.withAlpha(30) : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: entry.value ? color : Colors.grey.shade300,
                ),
              ),
              child: Text(
                '${entry.key}: ${entry.value}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: entry.value ? color : Colors.grey.shade600,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('ImageCacheStatus deep demo executing');
  print('==========================================');
  
  print('\n--- Section: ImageCacheStatus Overview ---');
  print('ImageCacheStatus provides status information about an image in ImageCache');
  print('Returned by imageCache.statusForKey(provider)');
  
  print('\n--- Section: Property Details ---');
  print('pending: Image codec is currently being decoded');
  print('keepAlive: Image is in keepAlive list (no active listeners)');
  print('live: Image is in live list (has active listeners)');
  print('tracking: Any of pending, keepAlive, or live is true');
  print('untracked: Not in cache (tracking is false)');
  
  print('\n--- Section: Tracking Property ---');
  bool simulatedPending = false;
  bool simulatedKeepAlive = true;
  bool simulatedLive = false;
  List<bool> trackingInputs = [simulatedPending, simulatedKeepAlive, simulatedLive];
  bool calculatedTracking = trackingInputs.any((b) => b);
  print('tracking = pending || keepAlive || live');
  print('Current simulation: tracking = $calculatedTracking');
  
  print('\n--- Section: Untracked Property ---');
  bool calculatedUntracked = !calculatedTracking;
  print('untracked = !tracking');
  print('Current simulation: untracked = $calculatedUntracked');
  
  print('\n--- Section: Simulated Cache States ---');
  print('State 1: Image loading (pending=true, keepAlive=false, live=false)');
  print('State 2: Image with listeners (pending=false, keepAlive=false, live=true)');
  print('State 3: Image cached no listeners (pending=false, keepAlive=true, live=false)');
  print('State 4: Image evicted (pending=false, keepAlive=false, live=false)');
  
  print('\nImageCacheStatus deep demo completed');

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
              colors: [Colors.teal.shade600, Colors.teal.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ImageCacheStatus',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Status information about an image in the image cache',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withAlpha(220),
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(40),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Obtained via PaintingBinding.instance.imageCache.statusForKey()',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        buildSectionHeader('ImageCacheStatus Properties'),
        buildInfoCard('Class', 'ImageCacheStatus'),
        buildInfoCard('Library', 'painting (dart:ui dependent)'),
        buildInfoCard('Purpose', 'Report cache state of a specific image'),
        buildInfoCard('Immutable', 'Yes - represents a snapshot of cache state'),
        
        SizedBox(height: 8),
        buildPropertyExplanationCard(
          'pending',
          'Indicates whether the requested image is currently being decoded by a codec. The image data is being processed but not yet available for display.',
          'Image is actively loading',
          'Image is not in decoding process',
          Icons.hourglass_empty,
          Colors.orange,
        ),
        buildPropertyExplanationCard(
          'keepAlive',
          'Indicates whether the image is stored in the keepAlive cache. These are loaded images with no active listeners that are kept for quick reuse.',
          'Image cached for potential reuse',
          'Image not in keepAlive cache',
          Icons.save,
          Colors.blue,
        ),
        buildPropertyExplanationCard(
          'live',
          'Indicates whether the image is in the live cache with active listeners. These images are currently being displayed somewhere.',
          'Image has active listeners',
          'No widgets are using this image',
          Icons.visibility,
          Colors.green,
        ),
        
        buildSectionHeader('Tracking Property'),
        buildInfoCard('Definition', 'tracking = pending || keepAlive || live'),
        buildInfoCard('Purpose', 'Quickly check if cache knows about the image'),
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.purple.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Understanding "tracking"',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'The tracking property is a convenience getter that returns true if the image cache is actively managing this image in any capacity. It combines all three primary states into a single boolean check.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.purple.shade800,
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: buildMiniStatusChip('pending', true, Colors.orange),
                  ),
                  SizedBox(width: 4),
                  Text('||', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 4),
                  Expanded(
                    child: buildMiniStatusChip('keepAlive', true, Colors.blue),
                  ),
                  SizedBox(width: 4),
                  Text('||', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 4),
                  Expanded(
                    child: buildMiniStatusChip('live', true, Colors.green),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Center(
                child: Icon(Icons.arrow_downward, color: Colors.purple.shade400),
              ),
              SizedBox(height: 8),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'tracking = true',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        buildTrackingVisualization(true, false),
        
        buildSectionHeader('Untracked Property'),
        buildInfoCard('Definition', 'untracked = !tracking'),
        buildInfoCard('Purpose', 'Check if image is NOT in cache'),
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Understanding "untracked"',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'An untracked image is one that the ImageCache has no record of. This can happen when the image was never loaded through the cache, has been evicted due to memory pressure, or was explicitly removed.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber, color: Colors.amber.shade700, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'When untracked is true, loading the image will start fresh from the image provider.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.amber.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        buildTrackingVisualization(false, true),
        
        buildSectionHeader('Status Visualization'),
        buildCacheLifecycleFlow(),
        
        buildSectionHeader('Simulated Cache States'),
        buildCacheStateCard(
          'Loading Image',
          true,
          false,
          false,
          'Image requested, codec decoding in progress',
          Colors.orange,
        ),
        buildCacheStateCard(
          'Active Image',
          false,
          false,
          true,
          'Image displayed in one or more widgets',
          Colors.green,
        ),
        buildCacheStateCard(
          'Cached Image',
          false,
          true,
          false,
          'Image loaded but no active listeners',
          Colors.blue,
        ),
        buildCacheStateCard(
          'Evicted Image',
          false,
          false,
          false,
          'Image removed from cache',
          Colors.red,
        ),
        buildCacheStateCard(
          'Loading with Listener',
          true,
          false,
          true,
          'Image loading while widget waits',
          Colors.purple,
        ),
        
        buildSimulatedCacheStatePanel(
          'Scenario: Fresh App Start',
          {
            'pending': false,
            'keepAlive': false,
            'live': false,
            'tracking': false,
            'untracked': true,
          },
          Colors.grey,
        ),
        buildSimulatedCacheStatePanel(
          'Scenario: Image Widget Mounted',
          {
            'pending': true,
            'keepAlive': false,
            'live': false,
            'tracking': true,
            'untracked': false,
          },
          Colors.orange,
        ),
        buildSimulatedCacheStatePanel(
          'Scenario: Image Decoded, Widget Visible',
          {
            'pending': false,
            'keepAlive': false,
            'live': true,
            'tracking': true,
            'untracked': false,
          },
          Colors.green,
        ),
        buildSimulatedCacheStatePanel(
          'Scenario: Widget Scrolled Off Screen',
          {
            'pending': false,
            'keepAlive': true,
            'live': false,
            'tracking': true,
            'untracked': false,
          },
          Colors.blue,
        ),
        buildSimulatedCacheStatePanel(
          'Scenario: Memory Pressure Eviction',
          {
            'pending': false,
            'keepAlive': false,
            'live': false,
            'tracking': false,
            'untracked': true,
          },
          Colors.red,
        ),
        
        buildSectionHeader('Practical Usage'),
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blueGrey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Checking Cache Status',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey.shade700,
                ),
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'final imageCache = PaintingBinding.instance.imageCache;',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: Colors.green.shade300,
                      ),
                    ),
                    Text(
                      'final provider = NetworkImage(url);',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: Colors.green.shade300,
                      ),
                    ),
                    Text(
                      'final status = imageCache.statusForKey(provider);',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: Colors.green.shade300,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'if (status.live) {',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: Colors.blue.shade300,
                      ),
                    ),
                    Text(
                      '  print("Image is being displayed");',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: Colors.amber.shade300,
                      ),
                    ),
                    Text(
                      '}',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: Colors.blue.shade300,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.indigo.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Debugging Cache Issues',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade700,
                ),
              ),
              SizedBox(height: 8),
              buildDebugTipRow(Icons.pending, 'pending is always true', 'Check for decode errors'),
              buildDebugTipRow(Icons.storage, 'keepAlive fills quickly', 'Review maximumSize setting'),
              buildDebugTipRow(Icons.sync_problem, 'Image reloads constantly', 'Key might be changing'),
              buildDebugTipRow(Icons.memory, 'Memory pressure frequent', 'Consider lower resolution images'),
            ],
          ),
        ),
        
        buildStatusComparisonTable(),
        
        SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.teal.shade200),
          ),
          child: Column(
            children: [
              Icon(Icons.check_circle, color: Colors.teal.shade600, size: 40),
              SizedBox(height: 8),
              Text(
                'ImageCacheStatus Demo Complete',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'All properties and states demonstrated',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.teal.shade600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    ),
  );
}

Widget buildDebugTipRow(IconData icon, String symptom, String suggestion) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: Colors.indigo.shade400),
        SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: symptom,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Colors.indigo.shade700,
                  ),
                ),
                TextSpan(
                  text: ' → $suggestion',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.indigo.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildStatusComparisonTable() {
  print('Building status comparison table');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.table_chart, color: Colors.grey.shade700),
              SizedBox(width: 8),
              Text(
                'Status Property Comparison',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
        buildTableHeaderRow(),
        buildTableDataRow('Loading', true, false, false, true, false),
        buildTableDataRow('Active', false, false, true, true, false),
        buildTableDataRow('Cached', false, true, false, true, false),
        buildTableDataRow('Evicted', false, false, false, false, true),
        buildTableDataRow('Re-loading', true, true, false, true, false),
      ],
    ),
  );
}

Widget buildTableHeaderRow() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    decoration: BoxDecoration(
      color: Colors.teal.shade50,
    ),
    child: Row(
      children: [
        Expanded(flex: 2, child: Text('State', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
        Expanded(child: Center(child: Text('pending', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)))),
        Expanded(child: Center(child: Text('keepAlive', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)))),
        Expanded(child: Center(child: Text('live', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)))),
        Expanded(child: Center(child: Text('tracking', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)))),
        Expanded(child: Center(child: Text('untracked', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)))),
      ],
    ),
  );
}

Widget buildTableDataRow(String state, bool pending, bool keepAlive, bool live, bool tracking, bool untracked) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
    ),
    child: Row(
      children: [
        Expanded(flex: 2, child: Text(state, style: TextStyle(fontSize: 13))),
        Expanded(child: Center(child: buildBoolIcon(pending))),
        Expanded(child: Center(child: buildBoolIcon(keepAlive))),
        Expanded(child: Center(child: buildBoolIcon(live))),
        Expanded(child: Center(child: buildBoolIcon(tracking))),
        Expanded(child: Center(child: buildBoolIcon(untracked))),
      ],
    ),
  );
}

Widget buildBoolIcon(bool value) {
  return Container(
    width: 20,
    height: 20,
    decoration: BoxDecoration(
      color: value ? Colors.green.shade100 : Colors.red.shade50,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Icon(
      value ? Icons.check : Icons.close,
      size: 14,
      color: value ? Colors.green.shade700 : Colors.red.shade400,
    ),
  );
}

// ignore_for_file: avoid_print
// D4rt test script: Tests ImageStreamCompleter from painting
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

Widget buildCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 6),
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

Widget buildImageStreamCompleterBaseClassSection() {
  print('Building ImageStreamCompleter base class section');
  print('ImageStreamCompleter is abstract base for streaming images');

  List<Map<String, String>> baseClassInfo = [
    {
      'name': 'Class Type',
      'value': 'Abstract Base Class',
      'icon': 'class',
    },
    {
      'name': 'Package',
      'value': 'flutter/painting.dart',
      'icon': 'package',
    },
    {
      'name': 'Purpose',
      'value': 'Manages async image loading and notification',
      'icon': 'purpose',
    },
    {
      'name': 'Pattern',
      'value': 'Observer/Listener Pattern',
      'icon': 'pattern',
    },
  ];

  List<Widget> infoCards = [];
  int i = 0;
  for (i = 0; i < baseClassInfo.length; i = i + 1) {
    Map<String, String> info = baseClassInfo[i];
    infoCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.deepPurple.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.info_outline,
                color: Colors.deepPurple.shade700,
                size: 22,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    info['name'] ?? '',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    info['value'] ?? '',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple.shade800,
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

  print('Base class info cards built');

  List<String> subclasses = [
    'OneFrameImageStreamCompleter',
    'MultiFrameImageStreamCompleter',
  ];

  List<String> subclassDescriptions = [
    'For static single-frame images (PNG, JPEG)',
    'For animated multi-frame images (GIF, APNG, WebP)',
  ];

  List<Widget> subclassCards = [];
  int s = 0;
  for (s = 0; s < subclasses.length; s = s + 1) {
    subclassCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.deepPurple.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withAlpha(20),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple.shade400, Colors.purple.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                s == 0 ? Icons.image : Icons.gif_box,
                color: Colors.white,
                size: 26,
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subclasses[s],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple.shade800,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subclassDescriptions[s],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.deepPurple.shade400,
            ),
          ],
        ),
      ),
    );
  }

  print('Subclass cards built');

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
            Icon(Icons.account_tree, color: Colors.deepPurple, size: 28),
            SizedBox(width: 10),
            Text(
              'ImageStreamCompleter Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        Column(children: infoCards),
        SizedBox(height: 16),
        Text(
          'Concrete Subclasses',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade700,
          ),
        ),
        SizedBox(height: 8),
        Column(children: subclassCards),
      ],
    ),
  );
}

Widget buildAddRemoveListenerSection() {
  print('Building addListener/removeListener section');
  print('Listeners receive image frames and error notifications');

  List<Map<String, dynamic>> listenerMethods = [
    {
      'method': 'addListener(ImageStreamListener listener)',
      'description': 'Registers a listener to receive image notifications',
      'color': Colors.green,
      'icon': Icons.add_circle,
    },
    {
      'method': 'removeListener(ImageStreamListener listener)',
      'description': 'Unregisters a listener from receiving notifications',
      'color': Colors.red,
      'icon': Icons.remove_circle,
    },
  ];

  List<Widget> methodCards = [];
  int m = 0;
  for (m = 0; m < listenerMethods.length; m = m + 1) {
    Map<String, dynamic> method = listenerMethods[m];
    Color methodColor = method['color'] as Color;
    methodCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: methodColor.withAlpha(15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: methodColor.withAlpha(100)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  method['icon'] as IconData,
                  color: methodColor,
                  size: 24,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    method['method'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                      color: methodColor.withAlpha(200),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              method['description'] as String,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }

  print('Listener method cards built');

  List<String> listenerCallbacks = [
    'onImage: (ImageInfo info, bool sync) => ...',
    'onChunk: (ImageChunkEvent event) => ...',
    'onError: (Object error, StackTrace? stack) => ...',
  ];

  List<String> callbackDescriptions = [
    'Called when an image frame is ready',
    'Called during image download with progress',
    'Called when an error occurs during loading',
  ];

  List<Color> callbackColors = [
    Colors.blue,
    Colors.orange,
    Colors.red,
  ];

  List<IconData> callbackIcons = [
    Icons.image,
    Icons.downloading,
    Icons.error_outline,
  ];

  List<Widget> callbackCards = [];
  int c = 0;
  for (c = 0; c < listenerCallbacks.length; c = c + 1) {
    callbackCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: callbackColors[c].withAlpha(100)),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: callbackColors[c].withAlpha(30),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                callbackIcons[c],
                color: callbackColors[c],
                size: 20,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listenerCallbacks[c],
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'monospace',
                      color: callbackColors[c],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    callbackDescriptions[c],
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('Callback cards built');

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
            Icon(Icons.hearing, color: Colors.teal, size: 28),
            SizedBox(width: 10),
            Text(
              'Listener Management',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        Column(children: methodCards),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ImageStreamListener Callbacks',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade700,
                ),
              ),
              SizedBox(height: 10),
              Column(children: callbackCards),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildSetImageSection() {
  print('Building setImage section');
  print('setImage reports image frames to all registered listeners');

  List<Map<String, String>> setImageFlow = [
    {
      'step': '1',
      'title': 'Image Decoded',
      'description': 'Codec decodes image data into pixels',
    },
    {
      'step': '2',
      'title': 'ImageInfo Created',
      'description': 'ImageInfo wraps decoded image with scale',
    },
    {
      'step': '3',
      'title': 'setImage Called',
      'description': 'Completer receives the image frame',
    },
    {
      'step': '4',
      'title': 'Listeners Notified',
      'description': 'All onImage callbacks invoked',
    },
  ];

  List<Widget> flowSteps = [];
  int f = 0;
  for (f = 0; f < setImageFlow.length; f = f + 1) {
    Map<String, String> step = setImageFlow[f];
    bool isLast = f == setImageFlow.length - 1;
    flowSteps.add(
      Container(
        margin: EdgeInsets.only(bottom: isLast ? 0 : 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade400, Colors.blue.shade700],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      step['step'] ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 30,
                    color: Colors.blue.shade200,
                  ),
              ],
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
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
                      step['title'] ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      step['description'] ?? '',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
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

  print('Flow steps built');

  List<Map<String, String>> imageInfoProperties = [
    {'property': 'image', 'type': 'ui.Image', 'desc': 'Decoded pixel data'},
    {'property': 'scale', 'type': 'double', 'desc': 'Device pixel scale'},
    {'property': 'debugLabel', 'type': 'String?', 'desc': 'Debug identifier'},
    {'property': 'sizeBytes', 'type': 'int?', 'desc': 'Memory size in bytes'},
  ];

  List<Widget> propertyRows = [];
  int p = 0;
  for (p = 0; p < imageInfoProperties.length; p = p + 1) {
    Map<String, String> prop = imageInfoProperties[p];
    propertyRows.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: p % 2 == 0 ? Colors.grey.shade50 : Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                prop['property'] ?? '',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                prop['type'] ?? '',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: Colors.purple.shade600,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                prop['desc'] ?? '',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('Property rows built');

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
            Icon(Icons.image_search, color: Colors.blue, size: 28),
            SizedBox(width: 10),
            Text(
              'setImage Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'Reports a decoded image frame to all listeners',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Text(
          'Image Loading Flow',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade700,
          ),
        ),
        SizedBox(height: 10),
        Column(children: flowSteps),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7),
                    topRight: Radius.circular(7),
                  ),
                ),
                child: Text(
                  'ImageInfo Properties',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
              ),
              Column(children: propertyRows),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildReportErrorSection() {
  print('Building reportError section');
  print('reportError notifies listeners of loading failures');

  List<Map<String, dynamic>> errorTypes = [
    {
      'type': 'NetworkImageLoadException',
      'description': 'HTTP request failed or returned error status',
      'example': '404 Not Found, 500 Server Error',
      'color': Colors.red,
    },
    {
      'type': 'FormatException',
      'description': 'Image data is corrupt or unsupported format',
      'example': 'Invalid PNG header, Unknown codec',
      'color': Colors.orange,
    },
    {
      'type': 'SocketException',
      'description': 'Network connection failed',
      'example': 'No internet, Host unreachable',
      'color': Colors.deepOrange,
    },
    {
      'type': 'TimeoutException',
      'description': 'Request took too long to complete',
      'example': 'Connection timeout, Read timeout',
      'color': Colors.amber,
    },
  ];

  List<Widget> errorCards = [];
  int e = 0;
  for (e = 0; e < errorTypes.length; e = e + 1) {
    Map<String, dynamic> errorInfo = errorTypes[e];
    Color errorColor = errorInfo['color'] as Color;
    errorCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: errorColor.withAlpha(15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: errorColor.withAlpha(80)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: errorColor.withAlpha(40),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.error_outline,
                color: errorColor,
                size: 26,
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    errorInfo['type'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                      color: errorColor,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    errorInfo['description'] as String,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                  ),
                  SizedBox(height: 6),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      errorInfo['example'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey.shade600,
                      ),
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

  print('Error cards built');

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
            Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
            SizedBox(width: 10),
            Text(
              'reportError Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'Notifies all listeners when image loading fails',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'void reportError({\n'
            '  DiagnosticsNode? context,\n'
            '  Object? exception,\n'
            '  StackTrace? stack,\n'
            '  InformationCollector? informationCollector,\n'
            '  bool silent = false,\n'
            '})',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Colors.green.shade300,
            ),
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Common Error Types',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.red.shade700,
          ),
        ),
        SizedBox(height: 10),
        Column(children: errorCards),
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
              Icon(Icons.lightbulb_outline, color: Colors.amber.shade700),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Always handle errors in ImageStreamListener.onError '
                  'to prevent unhandled exceptions and show fallback UI',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.amber.shade900,
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

Widget buildReportImageChunkEventSection() {
  print('Building reportImageChunkEvent section');
  print('reportImageChunkEvent reports download progress');

  List<Map<String, dynamic>> chunkEventStages = [
    {
      'stage': 'Request Started',
      'progress': 0,
      'cumulative': 0,
      'expected': 102400,
    },
    {
      'stage': 'First Chunk',
      'progress': 15,
      'cumulative': 15360,
      'expected': 102400,
    },
    {
      'stage': 'Downloading',
      'progress': 45,
      'cumulative': 46080,
      'expected': 102400,
    },
    {
      'stage': 'Almost Done',
      'progress': 85,
      'cumulative': 87040,
      'expected': 102400,
    },
    {
      'stage': 'Complete',
      'progress': 100,
      'cumulative': 102400,
      'expected': 102400,
    },
  ];

  List<Widget> stageCards = [];
  int s = 0;
  for (s = 0; s < chunkEventStages.length; s = s + 1) {
    Map<String, dynamic> stage = chunkEventStages[s];
    int progress = stage['progress'] as int;
    double progressFraction = progress / 100.0;
    Color progressColor = progress < 30
        ? Colors.orange
        : progress < 70
            ? Colors.blue
            : Colors.green;

    stageCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  stage['stage'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: progressColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$progress%',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: progressColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progressFraction,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                minHeight: 8,
              ),
            ),
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bytes: ${stage['cumulative']}',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                ),
                Text(
                  'Total: ${stage['expected']}',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  print('Stage cards built');

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
            Icon(Icons.download_rounded, color: Colors.indigo, size: 28),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'reportImageChunkEvent',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'Reports download progress during image loading',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.indigo.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ImageChunkEvent Properties',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade700,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'cumulativeBytesLoaded',
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Bytes received',
                            style: TextStyle(
                                fontSize: 11, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'expectedTotalBytes',
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Total size (nullable)',
                            style: TextStyle(
                                fontSize: 11, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Download Progress Simulation',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade700,
          ),
        ),
        SizedBox(height: 10),
        Column(children: stageCards),
      ],
    ),
  );
}

Widget buildKeepAliveObtainKeySection() {
  print('Building keepAlive/obtainKey section');
  print('keepAlive and obtainKey manage image caching lifecycle');

  List<Map<String, dynamic>> lifecycleMethods = [
    {
      'method': 'keepAlive()',
      'purpose': 'Keeps completer alive in cache even without listeners',
      'returnType': 'ImageStreamCompleterHandle',
      'details': 'Prevents disposal when image may be needed again soon',
      'color': Colors.green,
      'icon': Icons.lock_outline,
    },
    {
      'method': 'obtainKey()',
      'purpose': 'Gets unique cache key for this image configuration',
      'returnType': 'Future<ImageCacheKey>',
      'details': 'Used by ImageCache to identify cached images',
      'color': Colors.blue,
      'icon': Icons.key,
    },
    {
      'method': 'dispose()',
      'purpose': 'Releases resources when no longer needed',
      'returnType': 'void',
      'details': 'Called automatically when last listener removed',
      'color': Colors.red,
      'icon': Icons.delete_outline,
    },
  ];

  List<Widget> methodCards = [];
  int m = 0;
  for (m = 0; m < lifecycleMethods.length; m = m + 1) {
    Map<String, dynamic> method = lifecycleMethods[m];
    Color methodColor = method['color'] as Color;
    methodCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: methodColor.withAlpha(12),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: methodColor.withAlpha(60)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: methodColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    method['icon'] as IconData,
                    color: methodColor,
                    size: 22,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        method['method'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                          color: methodColor,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Returns: ${method['returnType']}',
                        style: TextStyle(
                          fontSize: 11,
                          fontFamily: 'monospace',
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              method['purpose'] as String,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade800,
              ),
            ),
            SizedBox(height: 4),
            Text(
              method['details'] as String,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  print('Lifecycle method cards built');

  List<Map<String, String>> cacheFlowSteps = [
    {'step': '1', 'action': 'Image Requested', 'state': 'Check cache'},
    {'step': '2', 'action': 'Cache Miss', 'state': 'Create completer'},
    {'step': '3', 'action': 'Load Started', 'state': 'Fetch data'},
    {'step': '4', 'action': 'Image Ready', 'state': 'Store in cache'},
    {'step': '5', 'action': 'Listeners Gone', 'state': 'Start dispose timer'},
    {'step': '6', 'action': 'keepAlive()', 'state': 'Cancel dispose'},
  ];

  List<Widget> cacheFlowCards = [];
  int c = 0;
  for (c = 0; c < cacheFlowSteps.length; c = c + 1) {
    Map<String, String> step = cacheFlowSteps[c];
    cacheFlowCards.add(
      Container(
        width: 140,
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade100, Colors.teal.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.teal.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.teal.shade600,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  step['step'] ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              step['action'] ?? '',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
            SizedBox(height: 4),
            Text(
              step['state'] ?? '',
              style: TextStyle(
                fontSize: 11,
                color: Colors.teal.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('Cache flow cards built');

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
            Icon(Icons.cached, color: Colors.teal, size: 28),
            SizedBox(width: 10),
            Text(
              'Lifecycle Management',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'keepAlive and obtainKey for cache management',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Column(children: methodCards),
        SizedBox(height: 16),
        Text(
          'Cache Lifecycle Flow',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade700,
          ),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: cacheFlowCards),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.teal.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ImageStreamCompleterHandle Usage',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade700,
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '// Keep image alive for potential reuse\n'
                  'final handle = completer.keepAlive();\n\n'
                  '// Later, when done with the image\n'
                  'handle.dispose();',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: Colors.green.shade300,
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

Widget buildUsageExamplesSection() {
  print('Building usage examples section');
  print('Demonstrating practical ImageStreamCompleter patterns');

  List<Map<String, String>> usageExamples = [
    {
      'title': 'Basic Image Loading with Listener',
      'code': 'final ImageStream stream = imageProvider.resolve(config);\n'
          'stream.addListener(\n'
          '  ImageStreamListener(\n'
          '    (ImageInfo info, bool sync) {\n'
          '      setState(() => _image = info.image);\n'
          '    },\n'
          '    onError: (error, stack) {\n'
          '      print("Failed to load: \$error");\n'
          '    },\n'
          '  ),\n'
          ');',
    },
    {
      'title': 'Progress Tracking During Download',
      'code': 'stream.addListener(\n'
          '  ImageStreamListener(\n'
          '    (info, sync) => handleImage(info),\n'
          '    onChunk: (ImageChunkEvent event) {\n'
          '      final progress = event.cumulativeBytesLoaded /\n'
          '          (event.expectedTotalBytes ?? 1);\n'
          '      setState(() => _progress = progress);\n'
          '    },\n'
          '  ),\n'
          ');',
    },
    {
      'title': 'Custom ImageProvider with Completer',
      'code': 'class MyImageProvider extends ImageProvider<MyKey> {\n'
          '  ImageStreamCompleter loadImage(MyKey key, decode) {\n'
          '    return OneFrameImageStreamCompleter(\n'
          '      loadBytes().then((bytes) {\n'
          '        return decode(bytes);\n'
          '      }),\n'
          '    );\n'
          '  }\n'
          '}',
    },
  ];

  List<Widget> exampleCards = [];
  int e = 0;
  for (e = 0; e < usageExamples.length; e = e + 1) {
    Map<String, String> example = usageExamples[e];
    exampleCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.purple.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.purple.shade100,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9),
                  topRight: Radius.circular(9),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.code, color: Colors.purple.shade700, size: 20),
                  SizedBox(width: 8),
                  Text(
                    example['title'] ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple.shade800,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(9),
                  bottomRight: Radius.circular(9),
                ),
              ),
              child: Text(
                example['code'] ?? '',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Colors.green.shade300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('Example cards built');

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
            Icon(Icons.integration_instructions, color: Colors.purple, size: 28),
            SizedBox(width: 10),
            Text(
              'Usage Examples',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'Practical patterns for working with ImageStreamCompleter',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: exampleCards),
      ],
    ),
  );
}

Widget buildBestPracticesSection() {
  print('Building best practices section');
  print('Guidelines for effective ImageStreamCompleter usage');

  List<Map<String, dynamic>> practices = [
    {
      'icon': Icons.check_circle,
      'color': Colors.green,
      'title': 'Always Remove Listeners',
      'details': 'Remove listeners in dispose() to prevent memory leaks',
    },
    {
      'icon': Icons.check_circle,
      'color': Colors.green,
      'title': 'Handle All Callbacks',
      'details': 'Implement onImage, onError, and optionally onChunk',
    },
    {
      'icon': Icons.check_circle,
      'color': Colors.green,
      'title': 'Use keepAlive Strategically',
      'details': 'Keep frequently accessed images alive to reduce loading',
    },
    {
      'icon': Icons.warning,
      'color': Colors.orange,
      'title': 'Check Mounted State',
      'details': 'Verify widget is mounted before setState in callbacks',
    },
    {
      'icon': Icons.warning,
      'color': Colors.orange,
      'title': 'Handle Synchronous Delivery',
      'details': 'onImage sync parameter indicates cached image delivery',
    },
    {
      'icon': Icons.cancel,
      'color': Colors.red,
      'title': 'Avoid Listener Duplicates',
      'details': 'Same listener added twice receives duplicate notifications',
    },
  ];

  List<Widget> practiceCards = [];
  int p = 0;
  for (p = 0; p < practices.length; p = p + 1) {
    Map<String, dynamic> practice = practices[p];
    Color practiceColor = practice['color'] as Color;
    practiceCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: practiceColor.withAlpha(12),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: practiceColor.withAlpha(60)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              practice['icon'] as IconData,
              color: practiceColor,
              size: 22,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    practice['title'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: practiceColor,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    practice['details'] as String,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('Practice cards built');

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
            Icon(Icons.tips_and_updates, color: Colors.amber, size: 28),
            SizedBox(width: 10),
            Text(
              'Best Practices',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        Column(children: practiceCards),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('=== ImageStreamCompleter Deep Demo ===');
  print('Testing ImageStreamCompleter base class from painting library');
  print('');

  print('Section 1: ImageStreamCompleter Base Class');
  Widget baseClassSection = buildImageStreamCompleterBaseClassSection();

  print('');
  print('Section 2: addListener/removeListener');
  Widget listenerSection = buildAddRemoveListenerSection();

  print('');
  print('Section 3: setImage');
  Widget setImageSection = buildSetImageSection();

  print('');
  print('Section 4: reportError');
  Widget reportErrorSection = buildReportErrorSection();

  print('');
  print('Section 5: reportImageChunkEvent');
  Widget chunkEventSection = buildReportImageChunkEventSection();

  print('');
  print('Section 6: keepAlive/obtainKey');
  Widget keepAliveSection = buildKeepAliveObtainKeySection();

  print('');
  print('Section 7: Usage Examples');
  Widget usageSection = buildUsageExamplesSection();

  print('');
  print('Section 8: Best Practices');
  Widget practicesSection = buildBestPracticesSection();

  print('');
  print('=== ImageStreamCompleter Deep Demo Complete ===');

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
              colors: [Colors.deepPurple.shade600, Colors.purple.shade800],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.stream, color: Colors.white, size: 36),
                  SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'ImageStreamCompleter',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                'Base class for completers that stream images asynchronously. '
                'Manages listeners, delivers image frames, handles errors, '
                'and reports download progress.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withAlpha(220),
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(40),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'painting.dart',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(40),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Abstract Class',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        buildSectionHeader('1. ImageStreamCompleter Base Class'),
        baseClassSection,
        buildSectionHeader('2. addListener / removeListener'),
        listenerSection,
        buildSectionHeader('3. setImage'),
        setImageSection,
        buildSectionHeader('4. reportError'),
        reportErrorSection,
        buildSectionHeader('5. reportImageChunkEvent'),
        chunkEventSection,
        buildSectionHeader('6. keepAlive / obtainKey'),
        keepAliveSection,
        buildSectionHeader('7. Usage Examples'),
        usageSection,
        buildSectionHeader('8. Best Practices'),
        practicesSection,
        SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 48),
              SizedBox(height: 8),
              Text(
                'ImageStreamCompleter Deep Demo Complete',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Explored base class, listeners, image delivery, errors, progress, and caching',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

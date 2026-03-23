// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ImageStreamCompleterHandle from painting
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
      crossAxisAlignment: CrossAxisAlignment.start,
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

Widget buildHandleCreationSection() {
  print('Building handle creation section');

  List<String> stepTitles = [
    'Step 1: Create ImageStreamCompleter',
    'Step 2: Obtain Handle via keepAlive()',
    'Step 3: Store Handle Reference',
    'Step 4: Use Completer via Handle',
  ];

  List<String> stepDescriptions = [
    'First create an ImageStreamCompleter (or subclass like OneFrameImageStreamCompleter or MultiFrameImageStreamCompleter)',
    'Call keepAlive() on the completer to get an ImageStreamCompleterHandle that maintains a reference',
    'Store the handle in your state to keep the completer alive as long as needed',
    'Access the underlying completer via the handle.completer property',
  ];

  List<String> codeExamples = [
    'OneFrameImageStreamCompleter completer = OneFrameImageStreamCompleter(imageFuture);',
    'ImageStreamCompleterHandle handle = completer.keepAlive();',
    'this._handle = completer.keepAlive();',
    'ImageStreamCompleter c = handle.completer;',
  ];

  List<IconData> stepIcons = [
    Icons.create_new_folder,
    Icons.link,
    Icons.save,
    Icons.touch_app,
  ];

  List<Widget> stepWidgets = [];
  int idx = 0;
  for (idx = 0; idx < stepTitles.length; idx = idx + 1) {
    stepWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.deepPurple.shade200),
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
                    color: Colors.deepPurple.shade600,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(stepIcons[idx], color: Colors.white, size: 22),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    stepTitles[idx],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple.shade800,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              stepDescriptions[idx],
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
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
                codeExamples[idx],
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Colors.amber.shade300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
          'Handle Creation from ImageStreamCompleter',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'How to create and obtain an ImageStreamCompleterHandle',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: stepWidgets),
      ],
    ),
  );
}

Widget buildDisposeMethodSection() {
  print('Building dispose method section');

  List<String> disposeRules = [
    'Always call dispose() when the handle is no longer needed',
    'dispose() decrements the internal reference count',
    'When ref count reaches zero, completer may be garbage collected',
    'Never use the handle after calling dispose()',
    'Failing to dispose causes memory leaks',
    'dispose() is idempotent - safe to call multiple times',
  ];

  List<IconData> ruleIcons = [
    Icons.rule,
    Icons.remove_circle,
    Icons.delete_sweep,
    Icons.block,
    Icons.warning,
    Icons.repeat_one,
  ];

  List<Color> ruleColors = [
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.red,
    Colors.amber,
    Colors.teal,
  ];

  List<Widget> ruleWidgets = [];
  int r = 0;
  for (r = 0; r < disposeRules.length; r = r + 1) {
    ruleWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ruleColors[r].withAlpha(20),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ruleColors[r].withAlpha(100)),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: ruleColors[r],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(ruleIcons[r], color: Colors.white, size: 20),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                disposeRules[r],
                style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
            Icon(Icons.cleaning_services, color: Colors.deepPurple, size: 24),
            SizedBox(width: 8),
            Text(
              'The dispose() Method',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        buildCodeBlock(
          'void dispose() {\n  // Release the reference to completer\n  handle.dispose();\n}',
        ),
        SizedBox(height: 12),
        Text(
          'Key Rules for dispose()',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade700,
          ),
        ),
        SizedBox(height: 8),
        Column(children: ruleWidgets),
      ],
    ),
  );
}

Widget buildDisposePatternExample() {
  print('Building dispose pattern example');

  String correctPattern = '''
class MyImageWidget extends StatefulWidget {
  @override
  State createState() => _MyImageWidgetState();
}

class _MyImageWidgetState extends State<MyImageWidget> {
  ImageStreamCompleterHandle? _handle;
  
  void loadImage(ImageProvider provider) {
    ImageStream stream = provider.resolve(ImageConfiguration());
    _handle = stream.completer?.keepAlive();
  }
  
  @override
  void dispose() {
    _handle?.dispose();
    _handle = null;
    super.dispose();
  }
}''';

  String incorrectPattern = '''
// BAD: Never disposing the handle
class BadWidget extends StatefulWidget {
  ImageStreamCompleterHandle? _handle;
  
  void loadImage() {
    _handle = completer.keepAlive();
    // Memory leak! Handle never disposed
  }
}''';

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
          'Dispose Pattern Examples',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Correct Pattern',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                ],
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
                  correctPattern,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: Colors.green.shade300,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.red.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.cancel, color: Colors.red, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Incorrect Pattern (Memory Leak)',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade800,
                    ),
                  ),
                ],
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
                  incorrectPattern,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: Colors.red.shade300,
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

Widget buildCompleterPropertySection() {
  print('Building completer property section');

  List<String> propertyFacts = [
    'Property name: completer',
    'Return type: ImageStreamCompleter',
    'Access: Read-only getter',
    'Throws if accessed after dispose()',
    'Returns the underlying completer instance',
    'Safe to use for adding listeners',
  ];

  List<Widget> factWidgets = [];
  int f = 0;
  for (f = 0; f < propertyFacts.length; f = f + 1) {
    Color factColor = (f % 2 == 0) ? Colors.deepPurple.shade50 : Colors.white;
    factWidgets.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: factColor,
          border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade600,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${f + 1}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                propertyFacts[f],
                style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
          width: double.infinity,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.settings, color: Colors.deepPurple.shade700, size: 22),
              SizedBox(width: 10),
              Text(
                'The completer Property',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.shade800,
                ),
              ),
            ],
          ),
        ),
        buildCodeBlock('ImageStreamCompleter get completer => _completer;'),
        Column(children: factWidgets),
      ],
    ),
  );
}

Widget buildCompleterUsageExamples() {
  print('Building completer usage examples');

  List<String> usageTitles = [
    'Adding Image Listener',
    'Adding Error Listener',
    'Getting Current Image',
    'Checking Loading Status',
  ];

  List<String> usageCodes = [
    'handle.completer.addListener(\n  ImageStreamListener((ImageInfo info, bool sync) {\n    setState(() { _image = info.image; });\n  })\n);',
    'handle.completer.addOnLastListenerRemovedCallback(() {\n  print("No more listeners");\n});',
    'ImageInfo? current = handle.completer.currentImage;',
    'bool hasListeners = handle.completer.hasListeners;',
  ];

  List<Widget> usageWidgets = [];
  int u = 0;
  for (u = 0; u < usageTitles.length; u = u + 1) {
    usageWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
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
              usageTitles[u],
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade800,
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
                usageCodes[u],
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Colors.cyan.shade300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
          'Using the completer Property',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Examples of accessing the underlying ImageStreamCompleter',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: usageWidgets),
      ],
    ),
  );
}

Widget buildLifecycleDiagram() {
  print('Building lifecycle diagram');

  List<String> lifecycleStages = [
    'Creation',
    'Active',
    'Disposed',
    'Garbage Collected',
  ];

  List<String> stageDescriptions = [
    'keepAlive() called on completer',
    'Handle in use, completer kept alive',
    'dispose() called, reference released',
    'No references remain, memory freed',
  ];

  List<Color> stageColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.grey,
  ];

  List<IconData> stageIcons = [
    Icons.add_circle,
    Icons.play_circle,
    Icons.pause_circle,
    Icons.delete_forever,
  ];

  List<Widget> stageWidgets = [];
  int s = 0;
  for (s = 0; s < lifecycleStages.length; s = s + 1) {
    stageWidgets.add(
      Row(
        children: [
          Column(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: stageColors[s],
                  shape: BoxShape.circle,
                ),
                child: Icon(stageIcons[s], color: Colors.white, size: 28),
              ),
              if (s < lifecycleStages.length - 1)
                Container(
                  width: 4,
                  height: 30,
                  color: stageColors[s].withAlpha(100),
                ),
            ],
          ),
          SizedBox(width: 16),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                bottom: s < lifecycleStages.length - 1 ? 20 : 0,
              ),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: stageColors[s].withAlpha(30),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: stageColors[s].withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lifecycleStages[s],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: stageColors[s],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    stageDescriptions[s],
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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
          'Handle Lifecycle',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'The four stages of an ImageStreamCompleterHandle',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Column(children: stageWidgets),
      ],
    ),
  );
}

Widget buildLifecycleScenarios() {
  print('Building lifecycle scenarios');

  List<String> scenarioTitles = [
    'Short-lived Image Loading',
    'Cached Image Reference',
    'Multiple Handles on Same Completer',
    'Handle in Widget State',
  ];

  List<String> scenarioDescriptions = [
    'Load image, display it, dispose handle immediately after image received',
    'Keep handle alive for duration of cache entry existence',
    'Multiple widgets can each have their own handle to same completer',
    'Handle stored in State, disposed in State.dispose()',
  ];

  List<String> scenarioTimelines = [
    'Create → Use → Dispose (seconds)',
    'Create → Use → Dispose (minutes/hours)',
    'Create handles → Use concurrently → Dispose independently',
    'initState → build → dispose',
  ];

  List<Color> scenarioColors = [
    Colors.cyan,
    Colors.purple,
    Colors.orange,
    Colors.teal,
  ];

  List<Widget> scenarioWidgets = [];
  int sc = 0;
  for (sc = 0; sc < scenarioTitles.length; sc = sc + 1) {
    scenarioWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: scenarioColors[sc].withAlpha(20),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: scenarioColors[sc].withAlpha(80)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: scenarioColors[sc],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Scenario ${sc + 1}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    scenarioTitles[sc],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: scenarioColors[sc],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              scenarioDescriptions[sc],
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
            ),
            SizedBox(height: 6),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Icon(Icons.timeline, size: 16, color: Colors.grey.shade600),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      scenarioTimelines[sc],
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
          'Lifecycle Scenarios',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Common patterns for handle lifecycle management',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: scenarioWidgets),
      ],
    ),
  );
}

Widget buildHandleVsListenerComparison() {
  print('Building handle vs listener comparison');

  List<String> aspectNames = [
    'Purpose',
    'Keeps Completer Alive',
    'Receives Image Updates',
    'Memory Management',
    'Usage Pattern',
    'Disposal',
    'Multiple Instances',
    'Error Handling',
  ];

  List<String> handleValues = [
    'Reference retention',
    'Yes - primary purpose',
    'No - must add listener separately',
    'dispose() decrements ref count',
    'Store in State for caching',
    'Must call dispose() manually',
    'Each handle increments ref count',
    'Does not handle errors directly',
  ];

  List<String> listenerValues = [
    'Receive image data',
    'Yes - while attached',
    'Yes - receives ImageInfo',
    'removeListener() to detach',
    'Add to completer for updates',
    'removeListener() from completer',
    'Multiple listeners supported',
    'Can have onError callback',
  ];

  List<Widget> comparisonRows = [];
  int a = 0;
  for (a = 0; a < aspectNames.length; a = a + 1) {
    Color rowBg = (a % 2 == 0) ? Colors.grey.shade50 : Colors.white;
    comparisonRows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        color: rowBg,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 90,
              child: Text(
                aspectNames[a],
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withAlpha(20),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  handleValues[a],
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.deepPurple.shade800,
                  ),
                ),
              ),
            ),
            SizedBox(width: 6),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.teal.withAlpha(20),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  listenerValues[a],
                  style: TextStyle(fontSize: 10, color: Colors.teal.shade800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
          width: double.infinity,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Handle vs Listener Comparison',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: SizedBox()),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Handle',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Listener',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Column(children: comparisonRows),
      ],
    ),
  );
}

Widget buildWhenToUseHandle() {
  print('Building when to use handle section');

  List<String> useCases = [
    'Image caching - keep completer alive for cache duration',
    'Preloading images - load before widget needs them',
    'Background loading - load images without displaying immediately',
    'Shared image resources - multiple widgets sharing one completer',
    'Lazy loading galleries - prepare images before scrolling to them',
    'Animation frames - keep frame completers alive during animation',
  ];

  List<IconData> useCaseIcons = [
    Icons.cached,
    Icons.download,
    Icons.cloud_download,
    Icons.share,
    Icons.photo_library,
    Icons.animation,
  ];

  List<Widget> useCaseWidgets = [];
  int uc = 0;
  for (uc = 0; uc < useCases.length; uc = uc + 1) {
    useCaseWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.green.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.green.shade600,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(useCaseIcons[uc], color: Colors.white, size: 20),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                useCases[uc],
                style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
            Icon(Icons.lightbulb, color: Colors.amber, size: 24),
            SizedBox(width: 8),
            Text(
              'When to Use ImageStreamCompleterHandle',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        Column(children: useCaseWidgets),
      ],
    ),
  );
}

Widget buildWhenToUseListener() {
  print('Building when to use listener section');

  List<String> listenerCases = [
    'Displaying images - need to receive and show ImageInfo',
    'Progress monitoring - track loading progress',
    'Error handling - react to loading failures',
    'Widget rebuilds - update UI when image loads',
    'Conditional rendering - show placeholder until loaded',
    'Multi-frame images - receive each frame update',
  ];

  List<IconData> listenerIcons = [
    Icons.image,
    Icons.hourglass_bottom,
    Icons.error_outline,
    Icons.refresh,
    Icons.view_carousel,
    Icons.movie,
  ];

  List<Widget> listenerWidgets = [];
  int lc = 0;
  for (lc = 0; lc < listenerCases.length; lc = lc + 1) {
    listenerWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(listenerIcons[lc], color: Colors.white, size: 20),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                listenerCases[lc],
                style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
            Icon(Icons.hearing, color: Colors.blue, size: 24),
            SizedBox(width: 8),
            Text(
              'When to Use ImageStreamListener',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        Column(children: listenerWidgets),
      ],
    ),
  );
}

Widget buildCombinedUsageExample() {
  print('Building combined usage example');

  String combinedCode = '''
class ImageCacheWidget extends StatefulWidget {
  ImageProvider provider;
  ImageCacheWidget({required this.provider});
  
  @override
  State createState() => _ImageCacheWidgetState();
}

class _ImageCacheWidgetState extends State<ImageCacheWidget> {
  ImageStreamCompleterHandle? _handle;
  ImageInfo? _imageInfo;
  
  @override
  void initState() {
    super.initState();
    _loadImage();
  }
  
  void _loadImage() {
    ImageStream stream = widget.provider.resolve(
      ImageConfiguration()
    );
    
    ImageStreamCompleter? completer = stream.completer;
    if (completer != null) {
      // Keep completer alive with handle
      _handle = completer.keepAlive();
      
      // Also add listener to receive image
      completer.addListener(
        ImageStreamListener((ImageInfo info, bool sync) {
          setState(() {
            _imageInfo = info;
          });
        })
      );
    }
  }
  
  @override
  void dispose() {
    _handle?.dispose();
    super.dispose();
  }
}''';

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
            Icon(Icons.merge_type, color: Colors.purple, size: 24),
            SizedBox(width: 8),
            Text(
              'Using Handle and Listener Together',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Handle keeps completer alive while listener receives updates',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
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
            combinedCode,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: Colors.lightGreen.shade300,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildApiReferenceTable() {
  print('Building API reference table');

  List<String> memberNames = [
    'keepAlive()',
    'dispose()',
    'completer',
    'ImageStreamCompleterHandle()',
  ];

  List<String> memberTypes = [
    'Method on ImageStreamCompleter',
    'Method on Handle',
    'Property on Handle',
    'Internal Constructor',
  ];

  List<String> memberDescriptions = [
    'Creates and returns a new handle for the completer',
    'Releases the reference to the completer',
    'Gets the underlying ImageStreamCompleter',
    'Not callable directly, use keepAlive() instead',
  ];

  List<Widget> tableRows = [];
  int m = 0;
  for (m = 0; m < memberNames.length; m = m + 1) {
    Color rowColor = (m % 2 == 0) ? Colors.deepPurple.shade50 : Colors.white;
    tableRows.add(
      Container(
        padding: EdgeInsets.all(10),
        color: rowColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 130,
              child: Text(
                memberNames[m],
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.shade800,
                ),
              ),
            ),
            SizedBox(width: 8),
            SizedBox(
              width: 100,
              child: Text(
                memberTypes[m],
                style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                memberDescriptions[m],
                style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
          width: double.infinity,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade700,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Text(
            'API Reference',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Column(children: tableRows),
      ],
    ),
  );
}

Widget buildBestPracticesTips() {
  print('Building best practices tips');

  List<String> tips = [
    'Always store handles in State, not local variables',
    'Dispose handles in widget dispose() method',
    'Use handle.completer to add listeners when needed',
    'One handle per widget instance is usually sufficient',
    'Prefer keepAlive() over manual reference counting',
    'Check if completer is null before calling keepAlive()',
    'Consider using handle in cache implementations',
    'Combine with ImageStreamListener for full functionality',
  ];

  List<Widget> tipWidgets = [];
  int t = 0;
  for (t = 0; t < tips.length; t = t + 1) {
    tipWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: (t % 2 == 0) ? Colors.amber.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.amber.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.amber.shade600,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${t + 1}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                tips[t],
                style: TextStyle(fontSize: 12, color: Colors.grey.shade800),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
            Icon(Icons.star, color: Colors.amber, size: 24),
            SizedBox(width: 8),
            Text(
              'Best Practices',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        Column(children: tipWidgets),
      ],
    ),
  );
}

Widget buildCommonMistakesSection() {
  print('Building common mistakes section');

  List<String> mistakeDescriptions = [
    'Forgetting to dispose the handle - causes memory leaks',
    'Using handle after dispose - throws exception',
    'Creating handle in build method - handle recreated every build',
    'Not storing handle reference - cannot dispose later',
    'Assuming listener keeps completer alive - it does not',
    'Disposing handle while listener still expects updates',
  ];

  List<String> solutionDescriptions = [
    'Always dispose in State.dispose() or when done',
    'Set handle to null after dispose, check before use',
    'Create handle in initState or on-demand in State',
    'Always assign keepAlive() result to a field',
    'Use handle to ensure completer survival',
    'Remove listeners before disposing handle',
  ];

  List<Widget> mistakeWidgets = [];
  int mi = 0;
  for (mi = 0; mi < mistakeDescriptions.length; mi = mi + 1) {
    mistakeWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.close, color: Colors.red, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      mistakeDescriptions[mi],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red.shade800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.check, color: Colors.green, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      solutionDescriptions[mi],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green.shade800,
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
            Icon(Icons.warning, color: Colors.orange, size: 24),
            SizedBox(width: 8),
            Text(
              'Common Mistakes and Solutions',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        Column(children: mistakeWidgets),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('ImageStreamCompleterHandle deep demo test executing');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('ImageStreamCompleterHandle Demo'),
        backgroundColor: Colors.deepPurple.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. Overview'),
            buildInfoCard('Class', 'ImageStreamCompleterHandle'),
            buildInfoCard(
              'Purpose',
              'A handle that keeps an ImageStreamCompleter alive',
            ),
            buildInfoCard('Package', 'package:flutter/painting.dart'),
            buildInfoCard(
              'Key Feature',
              'Maintains reference to prevent garbage collection',
            ),
            buildInfoCard(
              'Created Via',
              'ImageStreamCompleter.keepAlive() method',
            ),

            buildSectionHeader('2. Handle Creation'),
            buildHandleCreationSection(),

            buildSectionHeader('3. The dispose() Method'),
            buildDisposeMethodSection(),
            buildDisposePatternExample(),

            buildSectionHeader('4. The completer Property'),
            buildCompleterPropertySection(),
            buildCompleterUsageExamples(),

            buildSectionHeader('5. Lifecycle Demonstration'),
            buildLifecycleDiagram(),
            buildLifecycleScenarios(),

            buildSectionHeader('6. Handle vs Listener Comparison'),
            buildHandleVsListenerComparison(),
            buildWhenToUseHandle(),
            buildWhenToUseListener(),
            buildCombinedUsageExample(),

            buildSectionHeader('7. API Reference'),
            buildApiReferenceTable(),

            buildSectionHeader('8. Best Practices'),
            buildBestPracticesTips(),

            buildSectionHeader('9. Common Mistakes'),
            buildCommonMistakesSection(),

            buildSectionHeader('10. Summary'),
            buildInfoCard(
              'Key Point 1',
              'Use keepAlive() to create handles that keep completers alive',
            ),
            buildInfoCard(
              'Key Point 2',
              'Always call dispose() when the handle is no longer needed',
            ),
            buildInfoCard(
              'Key Point 3',
              'Access completer via handle.completer property',
            ),
            buildInfoCard(
              'Key Point 4',
              'Handle and listener serve different purposes - use both when needed',
            ),
            buildInfoCard(
              'Key Point 5',
              'Store handles in State and dispose in State.dispose()',
            ),
            buildInfoCard(
              'Key Point 6',
              'Handles prevent garbage collection until disposed',
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('ImageStreamCompleterHandle deep demo completed');
  return result;
}

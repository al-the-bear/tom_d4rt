// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DefaultProcessTextService and ProcessTextService
// from package:flutter/services.dart, plus the ProcessTextAction data model.
// Deep Demo theme: Etymologist's annotation workbench — selected words are
// passed across the bench (platform channel) to other scholars (Android apps)
// who translate, define, search, or annotate them.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('DefaultProcessTextService Deep Demo executing');
  print('Theme: Etymologist annotation workbench');

  // ============================================================
  // Construct the central service instance once. The interface
  // type is also captured to demonstrate polymorphism without
  // performing any platform invocations (which D4rt cannot await).
  // ============================================================
  final DefaultProcessTextService service = DefaultProcessTextService();
  final ProcessTextService asInterface = service;
  // Use an Object-typed reference so the runtime type check is meaningful
  // to the analyzer (otherwise the result would be statically known).
  final Object opaqueService = service;
  final bool implementsInterface = opaqueService is ProcessTextService;
  print('Service runtimeType: ${service.runtimeType}');
  print('asInterface runtimeType: ${asInterface.runtimeType}');
  print('implements ProcessTextService: $implementsInterface');

  // A snapshot animation we can hand to gauge widgets without
  // running an AnimationController (forbidden in this bridge).
  final Animation<double> halfMark = AlwaysStoppedAnimation<double>(0.5);
  final Duration noTime = Duration.zero;
  print('halfMark.value: ${halfMark.value}, noTime: $noTime');

  // ============================================================
  // SECTION 1: Workbench header / scholar's desk
  // ============================================================
  print('=== Section 1: Workbench Header ===');

  final Widget workbenchHeader = Container(
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.brown.shade700, Colors.brown.shade300],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: Colors.brown.shade900.withValues(alpha: 0.45),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
        BoxShadow(
          color: Colors.amber.shade700.withValues(alpha: 0.25),
          blurRadius: 22.0,
          offset: Offset(0.0, 0.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, size: 48.0, color: Colors.amber.shade100),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ProcessTextService',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber.shade50,
                    ),
                  ),
                  Text(
                    "The etymologist's annotation workbench",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.amber.shade100,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade50.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'Selected text travels from Flutter, across a platform channel, '
            'to Android apps that have registered for ACTION_PROCESS_TEXT. '
            'Each app reports back a ProcessTextAction (id, label) which '
            'Flutter renders as a context-menu entry such as Translate, '
            'Define, Search, or Highlight.',
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.brown.shade900,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
  print('Built workbench header');

  // ============================================================
  // SECTION 2: ProcessTextAction anatomy
  // ============================================================
  print('=== Section 2: ProcessTextAction anatomy ===');

  // A representative sample action so we can demonstrate
  // immutability, equality, and hashCode without any I/O.
  final ProcessTextAction sample =
      ProcessTextAction('com.deepl.translate', 'Translate');
  final ProcessTextAction sameSample =
      ProcessTextAction('com.deepl.translate', 'Translate');
  final ProcessTextAction differentSample =
      ProcessTextAction('com.google.search', 'Search');

  final bool sampleEqualsSame = sample == sameSample;
  final bool sampleEqualsOther = sample == differentSample;
  final int sampleHash = sample.hashCode;
  final int sameHash = sameSample.hashCode;
  print('sample == sameSample: $sampleEqualsSame');
  print('sample == differentSample: $sampleEqualsOther');
  print('hash(sample): $sampleHash, hash(sameSample): $sameHash');

  final Widget anatomyDiagram = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.indigo.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade300, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.shade200.withValues(alpha: 0.5),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: Colors.indigo.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'ProcessTextAction(id, label) — the data model',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildAnatomyRow(
          'id',
          sample.id,
          'A platform-unique identifier; on Android this is the package + '
              'activity name of the registered ACTION_PROCESS_TEXT receiver.',
          Icons.fingerprint,
          Colors.indigo,
        ),
        SizedBox(height: 8.0),
        _buildAnatomyRow(
          'label',
          sample.label,
          'A localized, human-readable string supplied by the receiving app, '
              'shown in the context menu (e.g. "Translate").',
          Icons.label,
          Colors.teal,
        ),
        SizedBox(height: 8.0),
        _buildAnatomyRow(
          'hashCode',
          sampleHash.toString(),
          'Computed as Object.hash(id, label); equal actions hash equal.',
          Icons.tag,
          Colors.deepPurple,
        ),
        SizedBox(height: 8.0),
        _buildAnatomyRow(
          'operator ==',
          sampleEqualsSame.toString(),
          'Two actions are equal when both id and label match — the class is '
              'marked @immutable and is safe to use in Set/Map keys.',
          Icons.balance,
          Colors.green,
        ),
      ],
    ),
  );
  print('Built anatomy diagram');

  // ============================================================
  // SECTION 3: Action gallery — sample ProcessTextAction renderings
  // ============================================================
  print('=== Section 3: Action gallery ===');

  // Six sample actions chosen to illustrate the breadth of the
  // ACTION_PROCESS_TEXT ecosystem on Android. Built from real
  // ProcessTextAction instances so the bridge exercises both
  // constructor and field access.
  final List<ProcessTextAction> galleryActions = <ProcessTextAction>[
    ProcessTextAction('com.deepl.translate', 'Translate'),
    ProcessTextAction('com.google.search', 'Search'),
    ProcessTextAction('com.merriamwebster.define', 'Define'),
    ProcessTextAction('org.wikipedia.lookup', 'Wikipedia'),
    ProcessTextAction('com.evernote.highlight', 'Highlight'),
    ProcessTextAction('com.android.share', 'Share'),
  ];
  final List<IconData> galleryIcons = <IconData>[
    Icons.translate,
    Icons.search,
    Icons.menu_book,
    Icons.travel_explore,
    Icons.format_color_fill,
    Icons.share,
  ];
  final List<Color> galleryColors = <Color>[
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
  ];
  final List<String> gallerySubtitles = <String>[
    'machine translation',
    'web search',
    'dictionary lookup',
    'encyclopedia entry',
    'inline highlighter',
    'share sheet',
  ];

  final List<Widget> actionCards = <Widget>[];
  for (int i = 0; i < galleryActions.length; i++) {
    final ProcessTextAction action = galleryActions[i];
    final IconData icon = galleryIcons[i];
    final Color color = galleryColors[i];
    final String subtitle = gallerySubtitles[i];
    print(
        'Gallery[$i]: id=${action.id}, label=${action.label}, hint=$subtitle');
    actionCards.add(_buildActionCard(action, icon, color, subtitle));
  }
  print('Built ${actionCards.length} gallery cards');

  // ============================================================
  // SECTION 4: ProcessTextService interface signature
  // ============================================================
  print('=== Section 4: Interface signature ===');

  final Widget interfaceSignature = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade50, Colors.blueGrey.shade100],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blueGrey.shade400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.shade200.withValues(alpha: 0.6),
          blurRadius: 12.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.api,
              color: Colors.blueGrey.shade800,
              size: 24.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'abstract class ProcessTextService',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
                color: Colors.blueGrey.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildSignatureRow(
          'queryTextActions()',
          'Future<List<ProcessTextAction>>',
          'Asks the platform: "which text-processing apps are installed and '
              'available right now?" Returns an empty list when none are '
              'available or when the Android manifest is missing the required '
              '<queries> declaration.',
          Icons.list,
          Colors.blue,
        ),
        SizedBox(height: 10.0),
        _buildSignatureRow(
          'processTextAction(id, text, readOnly)',
          'Future<String?>',
          'Hands the selected text off to the chosen action. Returns the '
              'transformed string when the receiver provides one (e.g. the '
              'translated version), or null when the action only acted as a '
              'side-effect (e.g. open in browser).',
          Icons.send,
          Colors.deepOrange,
        ),
      ],
    ),
  );
  print('Built interface signature panel');

  // ============================================================
  // SECTION 5: Platform-channel call-flow diagram
  // ============================================================
  print('=== Section 5: Platform-channel call flow ===');

  final List<Map<String, Object>> pipelineStages = <Map<String, Object>>[
    <String, Object>{
      'title': 'Flutter widget',
      'detail': 'User long-presses text and the selection toolbar is shown.',
      'icon': Icons.touch_app,
      'color': Colors.cyan,
    },
    <String, Object>{
      'title': 'DefaultProcessTextService',
      'detail': 'queryTextActions() invokes the SystemChannels.processText '
          'MethodChannel with "ProcessText.queryTextActions".',
      'icon': Icons.tune,
      'color': Colors.indigo,
    },
    <String, Object>{
      'title': 'Flutter engine (Java/Kotlin)',
      'detail': 'ProcessTextPlugin queries the PackageManager for activities '
          'matching ACTION_PROCESS_TEXT with mimeType text/plain.',
      'icon': Icons.android,
      'color': Colors.green,
    },
    <String, Object>{
      'title': 'Android system',
      'detail': 'Returns a Map<String, String> of activity ids to localized '
          'labels — one entry per installed text-processing app.',
      'icon': Icons.phone_android,
      'color': Colors.lime,
    },
    <String, Object>{
      'title': 'List<ProcessTextAction>',
      'detail': 'The map is reshaped into immutable ProcessTextAction objects '
          'and resolved as the Future returned to the toolbar.',
      'icon': Icons.list_alt,
      'color': Colors.deepPurple,
    },
  ];

  final List<Widget> pipelineWidgets = <Widget>[];
  for (int i = 0; i < pipelineStages.length; i++) {
    final Map<String, Object> stage = pipelineStages[i];
    final String title = stage['title'] as String;
    final String detail = stage['detail'] as String;
    final IconData icon = stage['icon'] as IconData;
    final Color color = stage['color'] as Color;
    print('Pipeline[$i] $title');
    pipelineWidgets.add(_buildPipelineStage(i + 1, title, detail, icon, color));
    if (i < pipelineStages.length - 1) {
      pipelineWidgets.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: Icon(
            Icons.arrow_downward,
            color: Colors.blueGrey.shade400,
            size: 22.0,
          ),
        ),
      );
    }
  }

  final Widget pipelineDiagram = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade50, Colors.deepPurple.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.cyan.shade300, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.shade100.withValues(alpha: 0.6),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
            Center(
              child: Text(
                'queryTextActions() — call flow',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.shade900,
                ),
              ),
            ),
            SizedBox(height: 14.0),
          ] +
          pipelineWidgets,
    ),
  );
  print('Built pipeline diagram with ${pipelineStages.length} stages');

  // ============================================================
  // SECTION 6: Mock Android selection toolbar
  // ============================================================
  print('=== Section 6: Mock Android selection toolbar ===');

  // Imagine a user has highlighted the word "manuscript" in an app.
  final String selectedSample = 'manuscript';
  final List<ProcessTextAction> menuActions = <ProcessTextAction>[
    galleryActions[0], // Translate
    galleryActions[2], // Define
    galleryActions[1], // Search
    galleryActions[3], // Wikipedia
  ];
  final List<IconData> menuIcons = <IconData>[
    galleryIcons[0],
    galleryIcons[2],
    galleryIcons[1],
    galleryIcons[3],
  ];
  final List<Color> menuColors = <Color>[
    galleryColors[0],
    galleryColors[2],
    galleryColors[1],
    galleryColors[3],
  ];

  final List<Widget> menuItems = <Widget>[];
  for (int i = 0; i < menuActions.length; i++) {
    menuItems.add(
      _buildMenuItem(menuActions[i], menuIcons[i], menuColors[i]),
    );
  }

  final Widget selectionToolbarMock = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade100, Colors.grey.shade300],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.grey.shade500, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.18),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.text_fields,
                color: Colors.grey.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Simulated Android selection toolbar',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        // The "selected" text mock-up.
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blueGrey.shade300, width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14.0,
                height: 1.4,
              ),
              children: <InlineSpan>[
                TextSpan(text: 'The scribe carefully copied the '),
                WidgetSpan(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.0,
                      vertical: 1.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade300,
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    child: Text(
                      selectedSample,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.brown.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TextSpan(text: ' onto the vellum.'),
              ],
            ),
          ),
        ),
        SizedBox(height: 12.0),
        // The toolbar above the selection.
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.22),
                blurRadius: 8.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 6.0,
            runSpacing: 6.0,
            children: <Widget>[
                  _buildBuiltInItem('Copy', Icons.content_copy, Colors.black87),
                  _buildBuiltInItem(
                      'Cut', Icons.content_cut, Colors.black87),
                  Container(
                    width: 1.0,
                    height: 24.0,
                    color: Colors.grey.shade400,
                  ),
                ] +
                menuItems,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'The items right of the divider are dynamic — supplied at runtime '
          'by ProcessTextService.queryTextActions() and resolved through the '
          'platform channel.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade800,
            fontStyle: FontStyle.italic,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
  print('Built selection toolbar mock with ${menuItems.length} dynamic items');

  // ============================================================
  // SECTION 7: Equality, immutability and hashing
  // ============================================================
  print('=== Section 7: Equality and immutability ===');

  // Build a small comparison matrix showcasing how == and hashCode behave.
  final List<List<ProcessTextAction>> equalityPairs = <List<ProcessTextAction>>[
    <ProcessTextAction>[sample, sameSample],
    <ProcessTextAction>[sample, differentSample],
    <ProcessTextAction>[
      ProcessTextAction('id.x', 'Alpha'),
      ProcessTextAction('id.x', 'Beta'),
    ],
    <ProcessTextAction>[
      ProcessTextAction('id.y', 'Same'),
      ProcessTextAction('id.z', 'Same'),
    ],
  ];

  final List<Widget> equalityRows = <Widget>[];
  for (int i = 0; i < equalityPairs.length; i++) {
    final ProcessTextAction left = equalityPairs[i][0];
    final ProcessTextAction right = equalityPairs[i][1];
    final bool eq = left == right;
    final bool hashEq = left.hashCode == right.hashCode;
    print(
        'Pair[$i]: ${left.id}/${left.label} vs ${right.id}/${right.label} '
        '== $eq, hashEq $hashEq');
    equalityRows.add(_buildEqualityRow(left, right, eq, hashEq));
  }

  final Widget equalityPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.green.shade50, Colors.lightGreen.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.green.shade400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.green.shade200.withValues(alpha: 0.55),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
            Row(
              children: [
                Icon(
                  Icons.balance,
                  color: Colors.green.shade800,
                  size: 22.0,
                ),
                SizedBox(width: 8.0),
                Text(
                  'Equality matrix',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade900,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            Text(
              'ProcessTextAction is @immutable. Two instances are equal iff '
              'their id and label match. Storing them in Sets/Maps therefore '
              'deduplicates correctly.',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.green.shade900,
                height: 1.35,
              ),
            ),
            SizedBox(height: 12.0),
          ] +
          equalityRows,
    ),
  );
  print('Built equality panel');

  // ============================================================
  // SECTION 8: readOnly flag — two parallel flows
  // ============================================================
  print('=== Section 8: readOnly flag ===');

  final Widget readOnlyDiagram = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.orange.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.orange.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.shade200.withValues(alpha: 0.6),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.lock_open,
              color: Colors.orange.shade800,
              size: 22.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'processTextAction(id, text, readOnly)',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
                color: Colors.orange.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildReadOnlyColumn(
                heading: 'readOnly: false',
                subheading: 'editable text field',
                description:
                    'The receiver may return a transformed string that '
                    'replaces the selection. Translate and Highlight are '
                    'natural fits.',
                icon: Icons.edit,
                color: Colors.deepOrange,
                outcome: 'Returns Future<String?> — usually non-null.',
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _buildReadOnlyColumn(
                heading: 'readOnly: true',
                subheading: 'rendered / locked text',
                description:
                    'The receiver should treat the text as informational. '
                    'Define and Search make sense here; the original text '
                    'should not be replaced.',
                icon: Icons.lock,
                color: Colors.brown,
                outcome: 'Returns Future<String?> — usually null.',
              ),
            ),
          ],
        ),
      ],
    ),
  );
  print('Built readOnly diagram');

  // ============================================================
  // SECTION 9: Fallback behavior when manifest is missing <queries>
  // ============================================================
  print('=== Section 9: Manifest fallback ===');

  final Widget manifestNote = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.red.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.red.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.red.shade200.withValues(alpha: 0.6),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.warning_amber,
              color: Colors.red.shade700,
              size: 22.0,
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                'Android manifest must declare <queries> for PROCESS_TEXT',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade900,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        _buildCodeBlock(
          '<queries>\n'
          '  <intent>\n'
          '    <action android:name="android.intent.action.PROCESS_TEXT"/>\n'
          '    <data android:mimeType="text/plain"/>\n'
          '  </intent>\n'
          '</queries>',
          Colors.red.shade300,
        ),
        SizedBox(height: 10.0),
        Text(
          'Without this declaration, queryTextActions() returns an empty list '
          'and processTextAction(...) becomes a no-op. The platform protects '
          'package visibility on Android 11+ and apps must opt in.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.red.shade900,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
  print('Built manifest fallback note');

  // ============================================================
  // SECTION 10: Code examples (usage)
  // ============================================================
  print('=== Section 10: Code examples ===');

  final Widget codeExamples = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.5),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade300, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Usage examples',
              style: TextStyle(
                color: Colors.cyan.shade300,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildCodeBlock(
          '// 1. Construct the default service.\n'
          'final ProcessTextService svc = DefaultProcessTextService();\n'
          '\n'
          '// 2. Ask the platform what is available.\n'
          'final List<ProcessTextAction> actions =\n'
          '    await svc.queryTextActions();\n'
          'for (final a in actions) {\n'
          '  print("\${a.id} -> \${a.label}");\n'
          '}',
          Colors.greenAccent.shade200,
        ),
        SizedBox(height: 12.0),
        _buildCodeBlock(
          '// 3. Hand the selected text off to a chosen action.\n'
          'final String? transformed = await svc.processTextAction(\n'
          '  actions.first.id,\n'
          '  selectedText,\n'
          '  /*readOnly=*/ false,\n'
          ');\n'
          'if (transformed != null) {\n'
          '  controller.replaceSelection(transformed);\n'
          '}',
          Colors.lightBlueAccent.shade100,
        ),
        SizedBox(height: 12.0),
        _buildCodeBlock(
          '// 4. Inject a fake channel in tests.\n'
          'final svc = DefaultProcessTextService();\n'
          'svc.setChannel(MethodChannel("test/process_text"));\n'
          '// Then drive it with TestDefaultBinaryMessenger.',
          Colors.amberAccent.shade100,
        ),
      ],
    ),
  );
  print('Built code examples');

  // ============================================================
  // SECTION 11: Type hierarchy summary
  // ============================================================
  print('=== Section 11: Type hierarchy ===');

  final Widget typeHierarchy = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade50, Colors.deepPurple.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepPurple.shade300, width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.account_tree_outlined,
              color: Colors.deepPurple.shade800,
              size: 22.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'Type hierarchy',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildTypeRow(
          'ProcessTextService',
          'abstract',
          'Defines queryTextActions and processTextAction.',
          Colors.deepPurple,
          true,
        ),
        SizedBox(height: 6.0),
        _buildTypeRow(
          '└─ DefaultProcessTextService',
          'concrete',
          'Implements ProcessTextService over SystemChannels.processText.',
          Colors.indigo,
          false,
        ),
        SizedBox(height: 6.0),
        _buildTypeRow(
          'ProcessTextAction',
          '@immutable',
          'Plain data: (String id, String label) plus == and hashCode.',
          Colors.teal,
          false,
        ),
      ],
    ),
  );
  print('Built type hierarchy panel');

  // ============================================================
  // SECTION 12: When to use / fallbacks
  // ============================================================
  print('=== Section 12: Guidance ===');

  final Widget guidancePanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade50, Colors.teal.shade100],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.shade200.withValues(alpha: 0.55),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.lightbulb, color: Colors.teal.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'When to use ProcessTextService',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildBullet(
          'You need an Android selection toolbar that surfaces installed '
          'translator/dictionary apps without hard-coding them.',
          Icons.check_circle,
          Colors.teal,
        ),
        _buildBullet(
          'You want first-class integration with Translate, Search, Define, '
          'Wikipedia, and other ACTION_PROCESS_TEXT receivers.',
          Icons.check_circle,
          Colors.teal,
        ),
        _buildBullet(
          'Skip it on iOS / desktop / web for now — the channel is '
          'unimplemented there and queryTextActions() resolves to []. Provide '
          'fallbacks (your own Translate menu) when running cross-platform.',
          Icons.info,
          Colors.indigo,
        ),
        _buildBullet(
          'Always use the readOnly flag honestly: passing true on a freely '
          'editable field can leave users wondering why text is not replaced.',
          Icons.warning_amber,
          Colors.orange,
        ),
        _buildBullet(
          'Treat ProcessTextAction as opaque data — never parse the id; only '
          'feed it back to processTextAction unchanged.',
          Icons.shield,
          Colors.deepPurple,
        ),
      ],
    ),
  );
  print('Built guidance panel');

  print('DefaultProcessTextService Deep Demo finished assembling sections');

  // ============================================================
  // Final layout
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        workbenchHeader,
        SizedBox(height: 24.0),
        Text(
          '1. ProcessTextAction anatomy',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        anatomyDiagram,
        SizedBox(height: 24.0),
        Text(
          '2. Action gallery',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: actionCards,
        ),
        SizedBox(height: 24.0),
        Text(
          '3. ProcessTextService interface',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        interfaceSignature,
        SizedBox(height: 24.0),
        Text(
          '4. Platform channel call flow',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        pipelineDiagram,
        SizedBox(height: 24.0),
        Text(
          '5. Selection toolbar mock',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        selectionToolbarMock,
        SizedBox(height: 24.0),
        Text(
          '6. Equality and immutability',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        equalityPanel,
        SizedBox(height: 24.0),
        Text(
          '7. The readOnly flag',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        readOnlyDiagram,
        SizedBox(height: 24.0),
        Text(
          '8. Manifest <queries> requirement',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        manifestNote,
        SizedBox(height: 24.0),
        Text(
          '9. Type hierarchy',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        typeHierarchy,
        SizedBox(height: 24.0),
        Text(
          '10. When to use / guidance',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        guidancePanel,
        SizedBox(height: 24.0),
        Text(
          '11. Code examples',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        codeExamples,
        SizedBox(height: 24.0),
        // Compact summary card mirroring the original stub, retained for
        // backward compatibility with tooling that scans the trailing block.
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.brown.shade50,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.brown.shade300, width: 1.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DefaultProcessTextService — summary',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.brown.shade900,
                ),
              ),
              SizedBox(height: 6.0),
              Text('Type: ${service.runtimeType}'),
              Text('Implements ProcessTextService: $implementsInterface'),
              Text('Sample action: ${sample.id} -> ${sample.label}'),
              Text('Gallery actions: ${galleryActions.length}'),
              Text('Pipeline stages: ${pipelineStages.length}'),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: anatomy row for the ProcessTextAction data model
// ============================================================
Widget _buildAnatomyRow(
  String field,
  String value,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
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
              Row(
                children: [
                  Text(
                    field,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      value,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.black87,
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

// ============================================================
// Helper: card representing a single ProcessTextAction in the gallery
// ============================================================
Widget _buildActionCard(
  ProcessTextAction action,
  IconData icon,
  Color color,
  String subtitle,
) {
  return Container(
    width: 168.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.10),
          color.withValues(alpha: 0.25),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.35),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 28.0, color: color),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                action.label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            'id: ${action.id}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: color,
            ),
          ),
        ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            'label: ${action.label}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: signature row for the interface section
// ============================================================
Widget _buildSignatureRow(
  String name,
  String returnType,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
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
                  fontFamily: 'monospace',
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                'returns $returnType',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.black87,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: pipeline stage card
// ============================================================
Widget _buildPipelineStage(
  int index,
  String title,
  String detail,
  IconData icon,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color, width: 1.5),
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
              '$index',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Icon(icon, color: color, size: 22.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: color,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                detail,
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.black87,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: built-in toolbar item (Copy/Cut)
// ============================================================
Widget _buildBuiltInItem(String label, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 16.0),
        SizedBox(width: 4.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: dynamic ProcessTextAction toolbar item
// ============================================================
Widget _buildMenuItem(ProcessTextAction action, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 16.0),
        SizedBox(width: 4.0),
        Text(
          action.label,
          style: TextStyle(
            fontSize: 12.0,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: equality matrix row
// ============================================================
Widget _buildEqualityRow(
  ProcessTextAction left,
  ProcessTextAction right,
  bool eq,
  bool hashEq,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: eq ? Colors.green.shade400 : Colors.red.shade300,
        width: 1.0,
      ),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '(${left.id}, ${left.label})',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                '(${right.id}, ${right.label})',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.0),
        _buildBoolBadge('==', eq),
        SizedBox(width: 6.0),
        _buildBoolBadge('hashEq', hashEq),
      ],
    ),
  );
}

// ============================================================
// Helper: small boolean badge
// ============================================================
Widget _buildBoolBadge(String label, bool value) {
  final Color color = value ? Colors.green : Colors.red;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color, width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          value ? Icons.check : Icons.close,
          color: color,
          size: 13.0,
        ),
        SizedBox(width: 3.0),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: column describing one readOnly mode
// ============================================================
Widget _buildReadOnlyColumn({
  required String heading,
  required String subheading,
  required String description,
  required IconData icon,
  required Color color,
  required String outcome,
}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20.0),
            SizedBox(width: 6.0),
            Text(
              heading,
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          subheading,
          style: TextStyle(
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 11.5,
            color: Colors.black87,
            height: 1.35,
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            outcome,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: code block (monospace on dark background)
// ============================================================
Widget _buildCodeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: textColor,
        height: 1.4,
      ),
    ),
  );
}

// ============================================================
// Helper: type hierarchy row
// ============================================================
Widget _buildTypeRow(
  String name,
  String tag,
  String description,
  Color color,
  bool root,
) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          root ? Icons.account_tree : Icons.subdirectory_arrow_right,
          color: color,
          size: 18.0,
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10.0,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.black87,
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

// ============================================================
// Helper: bullet point with leading icon
// ============================================================
Widget _buildBullet(String text, IconData icon, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 18.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

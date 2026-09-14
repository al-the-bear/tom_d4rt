// ignore_for_file: avoid_print
// D4rt deep demo: LiveText — Apple's Live Text feature for recognizing
// and interacting with text found in images and camera feed.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Coral / Peach palette ───
  const Color coral = Color(0xFFFF6F61);
  const Color peach = Color(0xFFFFAB91);
  const Color deepCoral = Color(0xFFC62828);
  const Color paleCoral = Color(0xFFFFF3F0);
  const Color blush = Color(0xFFFFCDD2);
  const Color salmon = Color(0xFFE57373);
  const Color rose = Color(0xFFEF9A9A);
  const Color cherry = Color(0xFFD32F2F);
  const Color warmWhite = Color(0xFFFFFBFA);
  const Color terracotta = Color(0xFFBF360C);

  print('[lt] ===== LIVE TEXT DEEP DEMO =====');

  // ─── Local helpers ───

  Widget ltBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cherry, deepCoral],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: cherry.withValues(alpha: 0.35),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: coral,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: peach, width: 1.5),
            ),
            child: Center(
              child: Text(number,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3)),
          ),
        ],
      ),
    );
  }

  Widget ltNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paleCoral,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: blush),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: cherry.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget ltCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: blush.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: cherry.withValues(alpha: 0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: coral.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: cherry)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget ltRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? coral.withValues(alpha: 0.06) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: blush.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? cherry : deepCoral)),
          );
        }).toList(),
      ),
    );
  }

  Widget ltFlow(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? cherry : deepCoral,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(steps[i],
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600)),
        ),
      );
      if (i < steps.length - 1) {
        items.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Icon(Icons.arrow_forward, size: 12, color: coral),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  // ━━━━━━ SECTION 1: What is LiveText? ━━━━━━
  print('[lt-01] Section 1: What is LiveText?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ltBanner('01', 'What Is LiveText?'),
      ltNote(
        'LiveText is Apple\'s on-device text recognition feature (VisionKit) '
        'that lets users interact with text found in images and the camera '
        'feed. In Flutter, the LiveText class provides access to this iOS '
        'feature, allowing text fields to include a camera-based text input '
        'option alongside the regular keyboard.',
      ),
      ltCard(
        'LiveText in the Flutter Stack',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ltFlow(['User taps camera icon', 'Camera opens',
                'VisionKit scans', 'Text recognized', 'Inserted in field']),
            const SizedBox(height: 10),
            _ltFeatureItem('On-device OCR', 'Text recognition without network', Icons.smartphone, coral),
            _ltFeatureItem('Camera feed', 'Live camera viewfinder overlay', Icons.camera_alt, salmon),
            _ltFeatureItem('Auto-insert', 'Recognized text goes to focused field', Icons.text_fields, rose),
            _ltFeatureItem('Data detection', 'URLs, emails, phone numbers', Icons.link, cherry),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 2: LiveTextInputStatusNotifier ━━━━━━
  print('[lt-02] Section 2: LiveTextInputStatusNotifier');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ltBanner('02', 'LiveTextInputStatusNotifier'),
      ltNote(
        'LiveTextInputStatusNotifier tracks whether Live Text input is '
        'available on the current device. It is a ValueNotifier<LiveTextInputStatus> '
        'that updates when the system capability changes. Apps check this '
        'before showing the Live Text camera button.',
      ),
      ltCard(
        'Status Notifier Flow',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ltStatusBox('LiveTextInputStatus',
                'value property holds current status', coral, true),
            const SizedBox(height: 6),
            ltRow(['Status', 'Meaning', 'Show Button?'], isHeader: true),
            ltRow(['enabled', 'Feature available + camera OK', 'Yes']),
            ltRow(['disabled', 'Not available on device', 'No']),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: paleCoral,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Listen for changes via addListener() to reactively '
                'show/hide the camera button when status changes.',
                style: TextStyle(fontSize: 10, color: cherry),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: Platform availability ━━━━━━
  print('[lt-03] Section 3: Platform availability');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ltBanner('03', 'Platform Availability'),
      ltNote(
        'Live Text is only available on Apple platforms starting from '
        'iOS 15.0 and macOS 12.0 (Monterey), and only on devices with '
        'A12 Bionic or newer (Neural Engine required). Flutter queries '
        'the platform to determine availability.',
      ),
      ltCard(
        'Availability Matrix',
        Column(
          children: [
            ltRow(['Platform', 'Min Version', 'Hardware Req', 'Available'], isHeader: true),
            ltRow(['iOS', '15.0+', 'A12 Bionic+', 'Yes']),
            ltRow(['iPadOS', '15.0+', 'A12 Bionic+', 'Yes']),
            ltRow(['macOS', '12.0+', 'Apple Silicon', 'Yes']),
            ltRow(['Android', 'N/A', 'N/A', 'No']),
            ltRow(['Windows', 'N/A', 'N/A', 'No']),
            ltRow(['Linux', 'N/A', 'N/A', 'No']),
            ltRow(['Web', 'N/A', 'N/A', 'No']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: Camera integration ━━━━━━
  print('[lt-04] Section 4: Camera integration');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ltBanner('04', 'Camera Integration'),
      ltNote(
        'When the user taps the Live Text camera button, iOS opens a '
        'camera viewfinder overlay on top of the text field. The system '
        'handles all camera management — Flutter just provides the '
        'trigger via the text input configuration.',
      ),
      ltCard(
        'Camera UI Mockup',
        Container(
          width: double.infinity,
          height: 140,
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A2E),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.camera_alt, size: 32, color: coral.withValues(alpha: 0.5)),
                    const SizedBox(height: 6),
                    Container(
                      width: 200,
                      height: 2,
                      color: coral,
                    ),
                    const SizedBox(height: 6),
                    Text('Scanning for text...',
                        style: TextStyle(color: coral.withValues(alpha: 0.8), fontSize: 11)),
                  ],
                ),
              ),
              Positioned(
                bottom: 8,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _ltCameraBtn('Cancel', Icons.close, salmon),
                    const SizedBox(width: 20),
                    _ltCameraBtn('Insert', Icons.check, coral),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: Text recognition flow ━━━━━━
  print('[lt-05] Section 5: Recognition flow');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ltBanner('05', 'Text Recognition Flow'),
      ltNote(
        'The recognition pipeline runs entirely on-device using Apple\'s '
        'Vision framework. The camera captures frames, VisionKit identifies '
        'text regions, recognition runs per-line, and results are inserted '
        'into the focused text field.',
      ),
      ltCard(
        'Pipeline Steps',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: warmWhite,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              _ltPipeStep(1, 'Camera captures frame', 'AVFoundation', coral),
              _ltPipeStep(2, 'Detect text regions', 'VNDetectTextRequest', salmon),
              _ltPipeStep(3, 'Recognize characters', 'VNRecognizeTextRequest', rose),
              _ltPipeStep(4, 'User selects text', 'Highlight overlay', cherry),
              _ltPipeStep(5, 'Insert into field', 'TextInputConnection', deepCoral),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: LiveText button ━━━━━━
  print('[lt-06] Section 6: LiveText button');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ltBanner('06', 'The Live Text Camera Button'),
      ltNote(
        'Flutter\'s CupertinoTextField and TextField can show a camera button '
        'when Live Text is available. The button uses the standard Apple '
        'Live Text icon (a viewfinder with lines). Its visibility is '
        'controlled by LiveTextInputStatusNotifier.',
      ),
      ltCard(
        'Button Placement',
        Row(
          children: [
            Expanded(
              child: _ltButtonDemo('Keyboard toolbar', Icons.camera_alt, 'iOS keyboard bar', coral),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _ltButtonDemo('Context menu', Icons.document_scanner, 'Long-press menu', salmon),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _ltButtonDemo('Custom button', Icons.photo_camera, 'App-provided', cherry),
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: Configuration ━━━━━━
  print('[lt-07] Section 7: Configuration');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ltBanner('07', 'Configuration Options'),
      ltNote(
        'Live Text behavior is configured through the TextInputConfiguration '
        'provided when attaching to the text input system. The '
        'enableInteractiveSelection and readOnly properties affect whether '
        'Live Text insertion is allowed.',
      ),
      ltCard(
        'Configuration Matrix',
        Column(
          children: [
            ltRow(['Setting', 'Value', 'Effect'], isHeader: true),
            ltRow(['enableInteractiveSelection', 'true', 'Camera button shown']),
            ltRow(['enableInteractiveSelection', 'false', 'No camera button']),
            ltRow(['readOnly', 'true', 'No insertion allowed']),
            ltRow(['readOnly', 'false', 'Text can be inserted']),
            ltRow(['obscureText', 'true', 'Camera hidden (password)']),
            ltRow(['maxLines', '1', 'Single-line scanning']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 8: Supported languages ━━━━━━
  print('[lt-08] Section 8: Supported languages');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ltBanner('08', 'Supported Languages'),
      ltNote(
        'Apple\'s Live Text supports a growing list of languages for OCR '
        'recognition. The system automatically detects the language of '
        'scanned text. Recognition accuracy varies by language, script '
        'complexity, and image quality.',
      ),
      ltCard(
        'Language Support',
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            _ltLangChip('English', coral),
            _ltLangChip('French', salmon),
            _ltLangChip('German', rose),
            _ltLangChip('Spanish', cherry),
            _ltLangChip('Italian', deepCoral),
            _ltLangChip('Portuguese', terracotta),
            _ltLangChip('Chinese', coral),
            _ltLangChip('Japanese', salmon),
            _ltLangChip('Korean', rose),
            _ltLangChip('Ukrainian', cherry),
            _ltLangChip('Thai', deepCoral),
            _ltLangChip('Vietnamese', terracotta),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: Data detection ━━━━━━
  print('[lt-09] Section 9: Data detection');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ltBanner('09', 'Data Detection in Recognized Text'),
      ltNote(
        'Beyond plain text, Live Text can detect structured data: phone '
        'numbers, email addresses, URLs, physical addresses, dates, and '
        'flight numbers. Detected data becomes actionable — tap a phone '
        'number to call, tap a URL to open Safari.',
      ),
      ltCard(
        'Detectable Data Types',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ltDataType('Phone numbers', Icons.phone, '+1 (555) 123-4567', coral),
            _ltDataType('Email addresses', Icons.email, 'user@example.com', salmon),
            _ltDataType('URLs', Icons.link, 'https://flutter.dev', rose),
            _ltDataType('Addresses', Icons.location_on, '1 Infinite Loop, CA', cherry),
            _ltDataType('Dates', Icons.calendar_today, 'April 9, 2026', deepCoral),
            _ltDataType('Tracking numbers', Icons.local_shipping, '1Z999AA12345678', terracotta),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: Use cases ━━━━━━
  print('[lt-10] Section 10: Use cases');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ltBanner('10', 'Use Cases'),
      ltNote(
        'Live Text benefits many scenarios: scanning business cards, '
        'reading serial numbers, capturing Wi-Fi passwords from labels, '
        'copying text from whiteboards, scanning receipts, and entering '
        'addresses from physical mail.',
      ),
      ltCard(
        'Scenario Gallery',
        Column(
          children: [
            ltRow(['Scenario', 'Input', 'Output'], isHeader: true),
            ltRow(['Business card', 'Camera → card', 'Name, phone, email']),
            ltRow(['Serial number', 'Camera → label', 'Product code']),
            ltRow(['Wi-Fi password', 'Camera → sticker', 'Password string']),
            ltRow(['Whiteboard', 'Camera → board', 'Meeting notes']),
            ltRow(['Receipt', 'Camera → paper', 'Total amount']),
            ltRow(['Address label', 'Camera → envelope', 'Full address']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: TextField integration ━━━━━━
  print('[lt-11] Section 11: TextField integration');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ltBanner('11', 'TextField Integration'),
      ltNote(
        'CupertinoTextField and Material TextField both support Live Text '
        'automatically on iOS when the text field is editable and '
        'interactive selection is enabled. No special configuration is '
        'needed — Flutter adds the camera button when available.',
      ),
      ltCard(
        'Integration Diagram',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ltFlow(['TextField', 'EditableText', 'TextInputClient',
                'TextInputConnection', 'Live Text API']),
            const SizedBox(height: 10),
            ltRow(['Widget', 'Live Text Support', 'Notes'], isHeader: true),
            ltRow(['TextField', 'Automatic', 'Material design']),
            ltRow(['CupertinoTextField', 'Automatic', 'iOS style']),
            ltRow(['EditableText', 'Manual', 'Need custom setup']),
            ltRow(['SelectableText', 'No', 'Read-only']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: Permissions ━━━━━━
  print('[lt-12] Section 12: Permissions');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ltBanner('12', 'Camera Permissions'),
      ltNote(
        'Live Text requires camera access. iOS prompts for permission on '
        'first use. The NSCameraUsageDescription key must be in Info.plist. '
        'If permission is denied, the Live Text button disappears and '
        'LiveTextInputStatusNotifier reports disabled.',
      ),
      ltCard(
        'Permission States',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ltPermState('Not determined', 'Will prompt on first use', Icons.help_outline, Colors.grey),
            _ltPermState('Authorized', 'Camera button visible', Icons.check_circle, const Color(0xFF2E7D32)),
            _ltPermState('Denied', 'Button hidden', Icons.cancel, cherry),
            _ltPermState('Restricted', 'Parental controls / MDM', Icons.lock, deepCoral),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: Error handling ━━━━━━
  print('[lt-13] Section 13: Error handling');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ltBanner('13', 'Error Handling'),
      ltNote(
        'Live Text can fail due to poor lighting, camera obstruction, '
        'unsupported text scripts, or device overheating. The system '
        'handles errors gracefully by falling back to the regular '
        'keyboard. Apps should not crash on Live Text failures.',
      ),
      ltCard(
        'Failure Scenarios',
        Column(
          children: [
            ltRow(['Issue', 'Result', 'Recovery'], isHeader: true),
            ltRow(['No camera permission', 'Button hidden', 'Go to Settings']),
            ltRow(['Poor lighting', 'No text found', 'Improve lighting']),
            ltRow(['Unsupported script', 'Partial recognition', 'Manual entry']),
            ltRow(['Device too hot', 'Camera disabled', 'Cool down']),
            ltRow(['Camera in use', 'Can\'t open', 'Close other app']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: Cross-platform alternatives ━━━━━━
  print('[lt-14] Section 14: Cross-platform alternatives');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ltBanner('14', 'Cross-Platform Alternatives'),
      ltNote(
        'Live Text is Apple-only. For cross-platform text recognition, '
        'use Google ML Kit (Android + iOS), Firebase ML, or Tesseract OCR. '
        'These require additional package dependencies and more setup, '
        'but provide similar functionality on all platforms.',
      ),
      ltCard(
        'OCR Options Comparison',
        Column(
          children: [
            ltRow(['Solution', 'Platforms', 'On-device?', 'Free?'], isHeader: true),
            ltRow(['Live Text', 'Apple only', 'Yes', 'Yes']),
            ltRow(['ML Kit', 'Android + iOS', 'Yes', 'Yes']),
            ltRow(['Firebase ML', 'All via cloud', 'No', 'Quota']),
            ltRow(['Tesseract', 'All', 'Yes', 'Yes']),
            ltRow(['Google Vision API', 'All via cloud', 'No', 'Paid']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Testing ━━━━━━
  print('[lt-15] Section 15: Testing');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ltBanner('15', 'Testing Live Text'),
      ltNote(
        'Testing Live Text in Flutter is primarily done on physical '
        'iOS devices (simulators lack camera). Use LiveTextInputStatusNotifier '
        'in tests by creating a custom notifier that reports the status you '
        'want. Integration tests should test graceful degradation.',
      ),
      ltCard(
        'Test Strategy',
        Column(
          children: [
            ltRow(['Test Type', 'What', 'How'], isHeader: true),
            ltRow(['Unit', 'Status notifier', 'Mock notifier value']),
            ltRow(['Widget', 'Button visibility', 'Set notifier to enabled']),
            ltRow(['Integration', 'Camera flow', 'Physical device only']),
            ltRow(['Fallback', 'Unavailable device', 'Set notifier to disabled']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[lt-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ltBanner('16', 'Summary Dashboard'),
      ltCard(
        'LiveText — Complete',
        Column(
          children: [
            ltRow(['Topic', 'Section', 'Key Insight'], isHeader: true),
            ltRow(['What', 'S01', 'Apple VisionKit OCR in Flutter']),
            ltRow(['Notifier', 'S02', 'ValueNotifier for availability']),
            ltRow(['Platforms', 'S03', 'iOS 15+ / macOS 12+ only']),
            ltRow(['Camera', 'S04', 'System camera overlay']),
            ltRow(['Pipeline', 'S05', 'Capture → detect → recognize']),
            ltRow(['Button', 'S06', 'Camera icon in toolbar']),
            ltRow(['Config', 'S07', 'TextInput configuration']),
            ltRow(['Languages', 'S08', 'Growing language support']),
            ltRow(['Data', 'S09', 'Phone/email/URL detection']),
            ltRow(['Use cases', 'S10', 'Cards, labels, whiteboards']),
            ltRow(['TextField', 'S11', 'Automatic integration']),
            ltRow(['Permissions', 'S12', 'Camera access required']),
            ltRow(['Errors', 'S13', 'Graceful fallback']),
            ltRow(['Alternatives', 'S14', 'ML Kit, Tesseract']),
            ltRow(['Testing', 'S15', 'Mock notifier, physical device']),
          ],
        ),
      ),
      ltCard(
        'Coral / Peach Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _ltColorSwatch('Coral', coral),
            _ltColorSwatch('Peach', peach),
            _ltColorSwatch('Salmon', salmon),
            _ltColorSwatch('Rose', rose),
            _ltColorSwatch('Cherry', cherry),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [cherry, deepCoral],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('LiveText — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'From platform availability through camera integration, '
              'recognition pipeline, data detection, and testing — '
              'the full Live Text story for Flutter on Apple platforms.',
              style: TextStyle(color: peach, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[lt] palette: $terracotta, $warmWhite');
  print('[lt] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('LiveText — Camera Text Recognition'),
        backgroundColor: cherry,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFFFF8F6),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            section1, section2, section3, section4,
            section5, section6, section7, section8,
            section9, section10, section11, section12,
            section13, section14, section15, section16,
          ],
        ),
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════
// Top-level helpers
// ═══════════════════════════════════════════════════

Widget _ltFeatureItem(String label, String desc, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      fontSize: 11, fontWeight: FontWeight.bold, color: color)),
              Text(desc,
                  style: TextStyle(fontSize: 9, color: color.withValues(alpha: 0.7))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _ltStatusBox(String label, String desc, Color color, bool active) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: active ? color.withValues(alpha: 0.08) : Colors.grey.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(
          color: active ? color.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1)),
    ),
    child: Row(
      children: [
        Icon(active ? Icons.check_circle : Icons.cancel,
            size: 16, color: active ? color : Colors.grey),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      fontSize: 11, fontWeight: FontWeight.bold,
                      fontFamily: 'monospace', color: color)),
              Text(desc, style: TextStyle(fontSize: 9, color: color.withValues(alpha: 0.7))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _ltCameraBtn(String label, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 10, color: color)),
      ],
    ),
  );
}

Widget _ltPipeStep(int num, String action, String framework, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Center(
            child: Text('$num',
                style: const TextStyle(
                    color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Text(action,
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.w600, color: color)),
        ),
        Expanded(
          flex: 2,
          child: Text(framework,
              style: TextStyle(
                  fontSize: 9, fontFamily: 'monospace',
                  color: color.withValues(alpha: 0.7))),
        ),
      ],
    ),
  );
}

Widget _ltButtonDemo(String label, IconData icon, String desc, Color color) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.15)),
    ),
    child: Column(
      children: [
        Icon(icon, size: 24, color: color),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(
                fontSize: 9, fontWeight: FontWeight.bold, color: color),
            textAlign: TextAlign.center),
        Text(desc,
            style: TextStyle(fontSize: 8, color: color.withValues(alpha: 0.6)),
            textAlign: TextAlign.center),
      ],
    ),
  );
}

Widget _ltDataType(String label, IconData icon, String example, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        SizedBox(
          width: 100,
          child: Text(label,
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.bold, color: color)),
        ),
        Expanded(
          child: Text(example,
              style: TextStyle(
                  fontSize: 10, fontFamily: 'monospace',
                  color: color.withValues(alpha: 0.7))),
        ),
      ],
    ),
  );
}

Widget _ltLangChip(String lang, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Text(lang,
        style: TextStyle(
            fontSize: 9, fontWeight: FontWeight.w600, color: color)),
  );
}

Widget _ltPermState(String state, String desc, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        SizedBox(
          width: 100,
          child: Text(state,
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.bold, color: color)),
        ),
        Expanded(
          child: Text(desc,
              style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.7))),
        ),
      ],
    ),
  );
}

Widget _ltColorSwatch(String name, Color color) {
  return Column(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
      const SizedBox(height: 3),
      Text(name, style: const TextStyle(fontSize: 8)),
    ],
  );
}

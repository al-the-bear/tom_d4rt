// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — ContentInsertionConfiguration
// Demonstrates ContentInsertionConfiguration — the configuration
// class for handling rich content insertion (images, GIFs, stickers,
// etc.) from the soft keyboard into text input fields. Covers all
// properties, MIME types, platform behavior, and practical patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ContentInsertionConfiguration Deep Demo executing');

  // ============================================================
  // SECTION 1: What is ContentInsertionConfiguration?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.image,
      'title': 'Rich Content from Keyboards',
      'body': 'ContentInsertionConfiguration tells Flutter\'s text '
          'input system that your text field accepts rich content '
          'like images, GIFs, and stickers from the soft keyboard. '
          'Without it, the keyboard only sends plain text.',
      'accent': Colors.amber[800]!,
    },
    {
      'icon': Icons.tune,
      'title': 'Configuration, Not Widget',
      'body': 'It is not a widget itself. You pass it as a property '
          'to TextField or EditableText via the '
          'contentInsertionConfiguration parameter. It tells the '
          'framework what MIME types you accept and what callback '
          'to invoke when content arrives.',
      'accent': Colors.deepOrange[700]!,
    },
    {
      'icon': Icons.keyboard,
      'title': 'Keyboard-Driven Insertion',
      'body': 'Modern soft keyboards (Android Gboard, iOS keyboard, '
          'Windows touch keyboard) can send images, GIFs, and stickers '
          'directly into text fields. This API is the Flutter side of '
          'that capability — it bridges the platform keyboard API.',
      'accent': Colors.amber[700]!,
    },
    {
      'icon': Icons.security,
      'title': 'MIME-Type Filtering',
      'body': 'You declare which content types you accept via a list '
          'of MIME type strings. The keyboard uses this list to filter '
          'what content options to show. If you only accept "image/png", '
          'GIF stickers won\'t appear in the keyboard\'s content tray.',
      'accent': Colors.deepOrange[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Properties
  // ============================================================
  print('=== Section 2: Properties ===');

  final properties = <Map<String, dynamic>>[
    {
      'name': 'allowedMimeTypes',
      'type': 'List<String>',
      'icon': Icons.filter_list,
      'color': Colors.amber[800]!,
      'description': 'List of MIME types the text field accepts. '
          'Examples: "image/png", "image/jpeg", "image/gif", '
          '"image/webp". The keyboard filters its content tray to '
          'only show items matching these types. An empty list means '
          'accept all content types.',
    },
    {
      'name': 'onContentInserted',
      'type': 'ValueChanged<KeyboardInsertedContent>',
      'icon': Icons.call_received,
      'color': Colors.deepOrange[700]!,
      'description': 'Callback invoked when the user selects content '
          'from the keyboard. Receives a KeyboardInsertedContent '
          'object containing the MIME type, URI, and optional raw '
          'byte data. This is where you handle the inserted content.',
    },
  ];

  print('  Prepared ${properties.length} properties');

  // ============================================================
  // SECTION 3: KeyboardInsertedContent
  // ============================================================
  print('=== Section 3: InsertedContent ===');

  final contentFields = <Map<String, dynamic>>[
    {
      'name': 'mimeType',
      'type': 'String',
      'icon': Icons.description,
      'color': Colors.amber[800]!,
      'description': 'The MIME type of the inserted content, such as '
          '"image/png" or "image/gif". Use this to determine how to '
          'process the content (decode image, play animation, etc.).',
    },
    {
      'name': 'uri',
      'type': 'String',
      'icon': Icons.link,
      'color': Colors.deepOrange[700]!,
      'description': 'A URI pointing to the content. On Android, this '
          'is a content:// URI that can be read via platform channels. '
          'On iOS, it may be a file:// URI. The URI may be temporary '
          'and should be read promptly.',
    },
    {
      'name': 'hasData',
      'type': 'bool',
      'icon': Icons.data_usage,
      'color': Colors.amber[700]!,
      'description': 'Whether raw byte data is available. When true, '
          'the data property returns the content bytes directly. When '
          'false, you must use the URI to fetch the content. Prefer '
          'data when available for reliability.',
    },
    {
      'name': 'data',
      'type': 'Uint8List?',
      'icon': Icons.memory,
      'color': Colors.deepOrange[600]!,
      'description': 'The raw bytes of the inserted content. May be '
          'null if the platform only provides a URI. When non-null, '
          'these bytes can be used directly with Image.memory() or '
          'saved to a file.',
    },
  ];

  print('  Prepared ${contentFields.length} content fields');

  // ============================================================
  // SECTION 4: Common MIME Types
  // ============================================================
  print('=== Section 4: MIME Types ===');

  final mimeTypes = <Map<String, dynamic>>[
    {
      'mime': 'image/png',
      'label': 'PNG',
      'icon': Icons.image,
      'color': Colors.blue[600]!,
      'description': 'Lossless raster format. Screenshots, icons, '
          'graphics with transparency. Universally supported.',
      'use': 'Screenshots, diagrams, UI elements',
    },
    {
      'mime': 'image/jpeg',
      'label': 'JPEG',
      'icon': Icons.photo,
      'color': Colors.green[600]!,
      'description': 'Lossy compressed photos. Smaller file size than '
          'PNG for photographs. No transparency support.',
      'use': 'Photos, camera images, thumbnails',
    },
    {
      'mime': 'image/gif',
      'label': 'GIF',
      'icon': Icons.gif,
      'color': Colors.purple[600]!,
      'description': 'Animated image format. Keyboard GIF pickers '
          'send this type. Limited to 256 colors per frame.',
      'use': 'Animated stickers, reactions, memes',
    },
    {
      'mime': 'image/webp',
      'label': 'WebP',
      'icon': Icons.web,
      'color': Colors.orange[600]!,
      'description': 'Modern format supporting both lossy and lossless '
          'compression, animation, and transparency. Used by many '
          'sticker packs.',
      'use': 'Stickers, modern images, animated content',
    },
    {
      'mime': 'image/bmp',
      'label': 'BMP',
      'icon': Icons.grid_on,
      'color': Colors.grey[600]!,
      'description': 'Uncompressed bitmap. Rarely used from keyboards, '
          'but some clipboard operations may produce BMP data.',
      'use': 'Legacy compatibility, clipboard fallback',
    },
  ];

  print('  Prepared ${mimeTypes.length} MIME types');

  // ============================================================
  // SECTION 5: Platform Behavior
  // ============================================================
  print('=== Section 5: Platforms ===');

  final platforms = <Map<String, dynamic>>[
    {
      'name': 'Android',
      'icon': Icons.android,
      'color': Colors.green[700]!,
      'support': 'Full support (API 25+)',
      'details': [
        'Gboard shows GIF and sticker buttons in keyboard',
        'Content delivered as content:// URI',
        'Raw bytes usually available via ContentResolver',
        'MIME type filtering respected by most keyboards',
        'Samsung Keyboard and SwiftKey also support this',
      ],
    },
    {
      'name': 'iOS',
      'icon': Icons.phone_iphone,
      'color': Colors.blueGrey[700]!,
      'support': 'Partial support (iOS 15+)',
      'details': [
        'Native keyboard shows emoji suggestions',
        'Third-party keyboards may offer GIF/sticker insertion',
        'Content delivered as file:// URI to app sandbox',
        'Data bytes may require additional platform channel reads',
        'Sticker packs from iMessage available in some keyboards',
      ],
    },
    {
      'name': 'Web',
      'icon': Icons.language,
      'color': Colors.amber[700]!,
      'support': 'Limited support',
      'details': [
        'Browser clipboard API may provide image data',
        'No standard keyboard content insertion on web',
        'Consider drag-and-drop or paste for web image input',
        'Some progressive web apps use InputEvent API',
        'MIME type filtering not applicable on web',
      ],
    },
    {
      'name': 'Desktop',
      'icon': Icons.desktop_windows,
      'color': Colors.deepOrange[700]!,
      'support': 'Minimal support',
      'details': [
        'Windows touch keyboard can insert emoji and GIFs',
        'macOS: no keyboard content insertion API',
        'Linux: no keyboard content insertion API',
        'Desktop apps typically use paste or drag-and-drop',
        'Consider file picker as alternative input method',
      ],
    },
  ];

  print('  Prepared ${platforms.length} platforms');

  // ============================================================
  // SECTION 6: Code Patterns
  // ============================================================
  print('=== Section 6: Code Patterns ===');

  final codePatterns = <Map<String, dynamic>>[
    {
      'title': 'Basic Setup',
      'color': Colors.amber[800]!,
      'code': 'TextField(\n'
          '  controller: _controller,\n'
          '  contentInsertionConfiguration:\n'
          '    ContentInsertionConfiguration(\n'
          '      allowedMimeTypes: <String>[\n'
          '        \'image/png\',\n'
          '        \'image/jpeg\',\n'
          '        \'image/gif\',\n'
          '      ],\n'
          '      onContentInserted: (content) {\n'
          '        _handleContent(content);\n'
          '      },\n'
          '    ),\n'
          ')',
    },
    {
      'title': 'Handling Inserted Content',
      'color': Colors.deepOrange[700]!,
      'code': 'void _handleContent(KeyboardInsertedContent c) {\n'
          '  debugPrint(\'MIME: \${c.mimeType}\');\n'
          '  debugPrint(\'URI: \${c.uri}\');\n'
          '  if (c.hasData) {\n'
          '    // Use bytes directly\n'
          '    final bytes = c.data!;\n'
          '    setState(() {\n'
          '      _image = Image.memory(bytes);\n'
          '    });\n'
          '  } else {\n'
          '    // URI only — resolve via platform channel\n'
          '    _loadFromUri(c.uri);\n'
          '  }\n'
          '}',
    },
    {
      'title': 'Chat Input with Content Support',
      'color': Colors.amber[700]!,
      'code': 'class ChatInput extends StatefulWidget {\n'
          '  @override\n'
          '  State<ChatInput> createState() => _ChatInputState();\n'
          '}\n'
          '\n'
          'class _ChatInputState extends State<ChatInput> {\n'
          '  final _controller = TextEditingController();\n'
          '  Widget? _pendingImage;\n'
          '\n'
          '  void _onContent(KeyboardInsertedContent c) {\n'
          '    if (c.hasData && c.mimeType.startsWith(\'image/\')) {\n'
          '      setState(() {\n'
          '        _pendingImage = Image.memory(c.data!);\n'
          '      });\n'
          '    }\n'
          '  }\n'
          '}',
    },
    {
      'title': 'Accept All Content Types',
      'color': Colors.deepOrange[600]!,
      'code': '// Empty list = accept everything\n'
          'ContentInsertionConfiguration(\n'
          '  allowedMimeTypes: <String>[],\n'
          '  onContentInserted: (content) {\n'
          '    // Content type unknown upfront\n'
          '    switch (content.mimeType) {\n'
          '      case \'image/png\':\n'
          '      case \'image/jpeg\':\n'
          '        _addImage(content);\n'
          '        break;\n'
          '      case \'image/gif\':\n'
          '        _addGif(content);\n'
          '        break;\n'
          '      default:\n'
          '        debugPrint(\'Unknown: \${content.mimeType}\');\n'
          '    }\n'
          '  },\n'
          ')',
    },
  ];

  print('  Prepared ${codePatterns.length} code patterns');

  // ============================================================
  // SECTION 7: Integration Flow
  // ============================================================
  print('=== Section 7: Flow ===');

  final flowSteps = <Map<String, dynamic>>[
    {
      'step': 1,
      'label': 'Configure',
      'icon': Icons.settings,
      'description': 'Create ContentInsertionConfiguration with '
          'your allowed MIME types and onContentInserted callback. '
          'Pass it to TextField\'s contentInsertionConfiguration.',
    },
    {
      'step': 2,
      'label': 'Platform Handshake',
      'icon': Icons.handshake,
      'description': 'Flutter sends the allowed MIME types to the '
          'platform text input plugin. The platform tells the '
          'keyboard what content types are acceptable.',
    },
    {
      'step': 3,
      'label': 'Keyboard UI Update',
      'icon': Icons.keyboard,
      'description': 'The soft keyboard shows content buttons '
          '(GIF, sticker, image) based on the allowed MIME types. '
          'Users can browse and select content.',
    },
    {
      'step': 4,
      'label': 'User Selects Content',
      'icon': Icons.touch_app,
      'description': 'User taps a GIF, sticker, or image in the '
          'keyboard\'s content tray. The keyboard packages the '
          'content with its MIME type and URI.',
    },
    {
      'step': 5,
      'label': 'Platform Channel',
      'icon': Icons.swap_horiz,
      'description': 'The platform sends the content data through '
          'Flutter\'s platform channel to the text input system. '
          'KeyboardInsertedContent is created from the raw data.',
    },
    {
      'step': 6,
      'label': 'Callback Invoked',
      'icon': Icons.call_received,
      'description': 'Your onContentInserted callback fires with '
          'the KeyboardInsertedContent. Process the content: display '
          'the image, attach it to a message, save to storage, etc.',
    },
  ];

  print('  Prepared ${flowSteps.length} flow steps');

  // ============================================================
  // SECTION 8: Common Patterns
  // ============================================================
  print('=== Section 8: Common Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'name': 'Chat Messenger',
      'icon': Icons.chat,
      'color': Colors.amber[800]!,
      'description': 'Accept images and GIFs for inline message '
          'attachments. Show a preview thumbnail before sending. '
          'The keyboard GIF picker becomes an inline attachment picker.',
      'mimeTypes': 'image/png, image/jpeg, image/gif, image/webp',
    },
    {
      'name': 'Social Media Post',
      'icon': Icons.photo_camera,
      'color': Colors.deepOrange[700]!,
      'description': 'Accept high-quality images for post composition. '
          'Restrict to static formats (no GIFs) if the platform '
          'doesn\'t support animated content in posts.',
      'mimeTypes': 'image/png, image/jpeg, image/webp',
    },
    {
      'name': 'Notes App',
      'icon': Icons.note,
      'color': Colors.amber[700]!,
      'description': 'Accept all image types for inline note content. '
          'Store the image data with the note and display it inline '
          'between text paragraphs.',
      'mimeTypes': 'image/png, image/jpeg, image/gif, image/webp, image/bmp',
    },
    {
      'name': 'Sticker-Only Input',
      'icon': Icons.sticky_note_2,
      'color': Colors.deepOrange[600]!,
      'description': 'Only accept animated stickers (WebP and GIF) for '
          'a sticker-focused input. Static images are rejected. The '
          'keyboard shows only animated content options.',
      'mimeTypes': 'image/gif, image/webp',
    },
  ];

  print('  Prepared ${patterns.length} common patterns');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Use hasData Before data',
      'body': 'Always check hasData before accessing the data property. '
          'On some platforms, only a URI is provided without raw bytes. '
          'Fall back to URI-based loading when data is null.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'URIs May Be Temporary',
      'body': 'Content URIs (especially Android content:// URIs) may '
          'become invalid after the keyboard session ends. Read and '
          'cache the content immediately in onContentInserted. Do not '
          'store the URI for later use.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Validate Content Size',
      'body': 'Keyboards can send very large images. Check the data '
          'size before processing. Consider resizing or compressing '
          'images above a threshold (e.g., 5MB). Show a progress '
          'indicator for large content.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Not All Keyboards Support This',
      'body': 'Many keyboards ignore content insertion configuration '
          'entirely. Your app should always have an alternative way to '
          'insert images (file picker, camera, paste). Don\'t rely '
          'solely on keyboard content insertion.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'MIME Type Is Informational',
      'body': 'The MIME type comes from the keyboard and may not be '
          'accurate. Some keyboards report "image/png" for WebP content. '
          'If you need the exact format, inspect the raw bytes\' magic '
          'numbers rather than trusting the MIME type.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Combine With Paste Support',
      'body': 'ContentInsertionConfiguration handles keyboard-sourced '
          'content. For clipboard paste (Ctrl+V), you need separate '
          'handling via RawKeyboardListener or Actions. A complete '
          'rich input field supports both paths.',
      'severity': 'tip',
    },
  ];

  print('  Prepared ${tips.length} tips');

  // ============================================================
  // BUILD THE VISUAL LAYOUT
  // ============================================================
  print('=== Building visual layout ===');

  return Scaffold(
    backgroundColor: Colors.grey[50],
    appBar: AppBar(
      title: Text('ContentInsertionConfiguration'),
      backgroundColor: Colors.amber[800],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.amber[800]!, Colors.deepOrange[700]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.image, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'ContentInsertionConfiguration',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Configuration class for enabling rich content '
                  'insertion (images, GIFs, stickers) from soft '
                  'keyboards into text fields. Defines accepted MIME '
                  'types and the callback for handling inserted content.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 1: Concept ──
          _ciHead('1', 'What is ContentInsertionConfiguration?'),
          SizedBox(height: 12),
          ...conceptCards.map((c) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: c['accent'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(c['icon'] as IconData,
                            color: c['accent'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(c['title'] as String,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(c['body'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 2: Properties ──
          _ciHead('2', 'Properties'),
          SizedBox(height: 12),
          ...properties.map((p) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: p['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(p['icon'] as IconData,
                            color: p['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(p['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'monospace')),
                        ),
                        _ciTag(p['type'] as String, p['color'] as Color),
                      ]),
                      SizedBox(height: 8),
                      Text(p['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: KeyboardInsertedContent ──
          _ciHead('3', 'KeyboardInsertedContent'),
          SizedBox(height: 12),
          ...contentFields.map((cf) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: cf['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(cf['icon'] as IconData,
                            color: cf['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(cf['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  fontFamily: 'monospace')),
                        ),
                        _ciTag(cf['type'] as String, cf['color'] as Color),
                      ]),
                      SizedBox(height: 6),
                      Text(cf['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: MIME Types ──
          _ciHead('4', 'Common MIME Types'),
          SizedBox(height: 12),
          ...mimeTypes.map((m) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: (m['color'] as Color).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Icon(m['icon'] as IconData,
                              color: m['color'] as Color, size: 22),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Text(m['label'] as String,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                              SizedBox(width: 6),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 1),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(m['mime'] as String,
                                    style: TextStyle(
                                        fontFamily: 'monospace',
                                        fontSize: 9,
                                        color: Colors.grey[700])),
                              ),
                            ]),
                            SizedBox(height: 4),
                            Text(m['description'] as String,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[700],
                                    height: 1.3)),
                            SizedBox(height: 2),
                            Text('Use: ${m['use']}',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.amber[800],
                                    fontStyle: FontStyle.italic)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: Platforms ──
          _ciHead('5', 'Platform Behavior'),
          SizedBox(height: 12),
          ...platforms.map((pl) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: pl['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(pl['icon'] as IconData,
                            color: pl['color'] as Color, size: 22),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(pl['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                        _ciTag(
                            pl['support'] as String, pl['color'] as Color),
                      ]),
                      SizedBox(height: 8),
                      ...(pl['details'] as List<String>).map((detail) =>
                          Padding(
                            padding: EdgeInsets.only(bottom: 3),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('• ',
                                    style: TextStyle(
                                        color: pl['color'] as Color,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11)),
                                Expanded(
                                  child: Text(detail,
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey[700],
                                          height: 1.3)),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Code Patterns ──
          _ciHead('6', 'Code Patterns'),
          SizedBox(height: 12),
          ...codePatterns.map((cp) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: cp['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cp['title'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(cp['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: Colors.amber[200],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Integration Flow ──
          _ciHead('7', 'Integration Flow'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    offset: Offset(0, 1))
              ],
            ),
            child: Column(
              children: flowSteps.map((fs) => Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.amber[800]!,
                                Colors.deepOrange[700]!,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text('${fs['step']}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13)),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Icon(fs['icon'] as IconData,
                                    color: Colors.amber[800], size: 16),
                                SizedBox(width: 6),
                                Text(fs['label'] as String,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13)),
                              ]),
                              SizedBox(height: 4),
                              Text(fs['description'] as String,
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[700],
                                      height: 1.3)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
            ),
          ),

          SizedBox(height: 24),

          // ── Section 8: Common Patterns ──
          _ciHead('8', 'Common Use Cases'),
          SizedBox(height: 12),
          ...patterns.map((p) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: p['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(p['icon'] as IconData,
                            color: p['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(p['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(p['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                      SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        decoration: BoxDecoration(
                          color: (p['color'] as Color).withOpacity(0.08),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'MIME: ${p['mimeTypes']}',
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 9,
                              color: p['color'] as Color),
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _ciHead('9', 'Tips & Gotchas'),
          SizedBox(height: 12),
          ...tips.map((tip) {
            Color bgColor;
            Color borderColor;
            switch (tip['severity']) {
              case 'warning':
                bgColor = Colors.amber[50]!;
                borderColor = Colors.amber[400]!;
                break;
              case 'tip':
                bgColor = Colors.green[50]!;
                borderColor = Colors.green[400]!;
                break;
              default:
                bgColor = Colors.blue[50]!;
                borderColor = Colors.blue[300]!;
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border(
                      left: BorderSide(color: borderColor, width: 4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(tip['icon'] as IconData,
                          color: borderColor, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(tip['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.grey[900])),
                      ),
                    ]),
                    SizedBox(height: 6),
                    Text(tip['body'] as String,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[800],
                            height: 1.4)),
                  ],
                ),
              ),
            );
          }),

          SizedBox(height: 32),
          Center(
            child: Text(
              'End of ContentInsertionConfiguration Deep Demo',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[400],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    ),
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Section heading
// ──────────────────────────────────────────────────────────
Widget _ciHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.amber[800],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(number,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Text(title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900])),
      ),
    ],
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Type tag
// ──────────────────────────────────────────────────────────
Widget _ciTag(String text, Color color) {
  return Container(
    constraints: BoxConstraints(maxWidth: 160),
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: color,
            fontSize: 8,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace')),
  );
}

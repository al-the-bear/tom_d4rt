// Deep demo: BlockSemantics, ExcludeSemantics, MergeSemantics, Semantics
// BlockSemantics drops the semantics subtree below it when blocking is true.
// This prevents screen readers from seeing content behind modals, drawers, etc.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('[BlockSemantics Demo] Building deep demo');

  // -- colour palette --
  Color headerStart = Color(0xFF1A237E);
  Color headerEnd = Color(0xFF4A148C);
  Color sectionBg = Color(0xFFF3E5F5);
  Color blockedBg = Color(0xFFFFCDD2);
  Color unblockedBg = Color(0xFFC8E6C9);
  Color overlayColor = Color(0xCC000000);
  Color cardWhite = Color(0xFFFFFFFF);
  Color semanticsBlue = Color(0xFFBBDEFB);
  Color mergeGreen = Color(0xFFDCEDC8);
  Color excludeOrange = Color(0xFFFFE0B2);
  Color drawerPurple = Color(0xFFE1BEE7);
  Color accentPink = Color(0xFFE91E63);
  Color accentTeal = Color(0xFF00897B);
  Color darkText = Color(0xFF212121);
  Color lightText = Color(0xFFFFFFFF);
  Color dividerGrey = Color(0xFFBDBDBD);

  print('[BlockSemantics Demo] Colours initialised');

  // ===== Helper: header =====
  Widget headerWidget = Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 32, horizontal: 20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [headerStart, headerEnd],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'BlockSemantics Deep Demo',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: lightText,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Demonstrates BlockSemantics, ExcludeSemantics, MergeSemantics & Semantics',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xCCFFFFFF),
          ),
        ),
        SizedBox(height: 4),
        Text(
          'RenderBlockSemantics drops the semantics subtree when blocking is true',
          style: TextStyle(
            fontSize: 12,
            color: Color(0x99FFFFFF),
          ),
        ),
      ],
    ),
  );

  print('[BlockSemantics Demo] Header built');

  // ===== Helper function for section titles =====
  Widget buildSectionTitle(String title, Color startColor, Color endColor) {
    print('[BlockSemantics Demo] Section: $title');
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 24, bottom: 12, left: 16, right: 16),
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [startColor, endColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: lightText,
        ),
      ),
    );
  }

  // ===== Helper function for info cards =====
  Widget buildInfoCard(String text, Color bgColor) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: dividerGrey, width: 0.5),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 13, color: darkText),
      ),
    );
  }

  // ===== Helper: labelled semantics display =====
  Widget buildSemanticsIndicator(String label, Color color, IconData icon) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0x33000000), width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: darkText, size: 22),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: darkText),
            ),
          ),
        ],
      ),
    );
  }

  print('[BlockSemantics Demo] Helpers defined');

  // ========================================================
  // SECTION 1: BlockSemantics(blocking: true) - content blocked
  // ========================================================
  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle('1. BlockSemantics (blocking: true)', Color(0xFFD32F2F), Color(0xFFC62828)),
      buildInfoCard(
        'When blocking is true, the semantics subtree below this widget is dropped. '
        'Screen readers will NOT see the child content. This is the default behavior.',
        blockedBg,
      ),
      SizedBox(height: 8),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: blockedBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFFE57373), width: 2),
        ),
        child: BlockSemantics(
          blocking: true,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(Icons.block, size: 48, color: Color(0xFFD32F2F)),
                    SizedBox(height: 8),
                    Text(
                      'BLOCKED - Screen readers cannot see this',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD32F2F),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'This text is inside BlockSemantics(blocking: true). '
                      'Visually it appears, but semantics are dropped.',
                      style: TextStyle(fontSize: 13, color: darkText),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.visibility_off, color: Color(0xFFD32F2F)),
                        SizedBox(width: 8),
                        Text('Semantics: HIDDEN',
                            style: TextStyle(fontSize: 14, color: Color(0xFFD32F2F))),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  print('[BlockSemantics Demo] Section 1 built (blocking: true)');

  // ========================================================
  // SECTION 2: BlockSemantics(blocking: false) - content visible
  // ========================================================
  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle('2. BlockSemantics (blocking: false)', Color(0xFF2E7D32), Color(0xFF1B5E20)),
      buildInfoCard(
        'When blocking is false, the semantics subtree is preserved normally. '
        'Screen readers CAN see all child content. This is a pass-through mode.',
        unblockedBg,
      ),
      SizedBox(height: 8),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: unblockedBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFF66BB6A), width: 2),
        ),
        child: BlockSemantics(
          blocking: false,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(Icons.check_circle, size: 48, color: Color(0xFF2E7D32)),
                    SizedBox(height: 8),
                    Text(
                      'VISIBLE - Screen readers CAN see this',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'This text is inside BlockSemantics(blocking: false). '
                      'Semantics flow normally to screen readers.',
                      style: TextStyle(fontSize: 13, color: darkText),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.visibility, color: Color(0xFF2E7D32)),
                        SizedBox(width: 8),
                        Text('Semantics: VISIBLE',
                            style: TextStyle(fontSize: 14, color: Color(0xFF2E7D32))),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  print('[BlockSemantics Demo] Section 2 built (blocking: false)');

  // ========================================================
  // SECTION 3: Modal overlay pattern with BlockSemantics
  // ========================================================
  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle('3. Modal Overlay Pattern', Color(0xFF6A1B9A), Color(0xFF4A148C)),
      buildInfoCard(
        'BlockSemantics is commonly used behind modals and dialogs to block '
        'screen reader access to background content. The overlay blocks semantics '
        'while the modal dialog remains accessible.',
        sectionBg,
      ),
      SizedBox(height: 8),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFF9C27B0), width: 2),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Background content (would be blocked by semantics)
            BlockSemantics(
              blocking: true,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Color(0xFFE8EAF6),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Background Content',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkText)),
                    SizedBox(height: 8),
                    Text('This is background text that screen readers should NOT access.',
                        style: TextStyle(fontSize: 13, color: darkText)),
                    SizedBox(height: 4),
                    Text('Button below is also blocked from accessibility tree.',
                        style: TextStyle(fontSize: 13, color: darkText)),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Color(0xFF90CAF9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text('Background Button (blocked)',
                          style: TextStyle(fontSize: 13, color: darkText)),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.visibility_off, size: 16, color: Color(0xFFD32F2F)),
                        SizedBox(width: 4),
                        Text('Semantics blocked by overlay',
                            style: TextStyle(fontSize: 11, color: Color(0xFFD32F2F))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Semi-transparent overlay
            Container(
              width: double.infinity,
              height: double.infinity,
              color: overlayColor,
            ),
            // Modal dialog on top (semantics NOT blocked)
            Center(
              child: Container(
                width: 260,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: cardWhite,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x66000000),
                      blurRadius: 20,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.warning_amber_rounded, size: 40, color: Color(0xFFF57C00)),
                    SizedBox(height: 12),
                    Text('Modal Dialog',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkText)),
                    SizedBox(height: 8),
                    Text(
                      'This dialog is accessible to screen readers. '
                      'Background content is blocked.',
                      style: TextStyle(fontSize: 13, color: darkText),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: accentPink,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('Dismiss',
                          style: TextStyle(fontSize: 14, color: lightText),
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  print('[BlockSemantics Demo] Section 3 built (modal overlay pattern)');

  // ========================================================
  // SECTION 4: ExcludeSemantics comparison
  // ========================================================
  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle('4. ExcludeSemantics Comparison', Color(0xFFE65100), Color(0xFFBF360C)),
      buildInfoCard(
        'ExcludeSemantics removes the child from the semantics tree entirely. '
        'Unlike BlockSemantics which drops the subtree below, ExcludeSemantics '
        'removes the node and its children from the semantics tree completely.',
        excludeOrange,
      ),
      SizedBox(height: 8),
      // ExcludeSemantics(excluding: true)
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: excludeOrange,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFFFF9800), width: 2),
        ),
        child: ExcludeSemantics(
          excluding: true,
          child: Container(
            padding: EdgeInsets.all(14),
            child: Row(
              children: [
                Icon(Icons.cancel, color: Color(0xFFE65100), size: 28),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ExcludeSemantics(excluding: true)',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: darkText)),
                      SizedBox(height: 4),
                      Text('This content is completely excluded from semantics tree.',
                          style: TextStyle(fontSize: 12, color: darkText)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 4),
      // ExcludeSemantics(excluding: false)
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: unblockedBg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFF66BB6A), width: 2),
        ),
        child: ExcludeSemantics(
          excluding: false,
          child: Container(
            padding: EdgeInsets.all(14),
            child: Row(
              children: [
                Icon(Icons.check_circle_outline, color: Color(0xFF2E7D32), size: 28),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ExcludeSemantics(excluding: false)',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: darkText)),
                      SizedBox(height: 4),
                      Text('This content is NOT excluded. Semantics are normal.',
                          style: TextStyle(fontSize: 12, color: darkText)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 8),
      buildInfoCard(
        'Key difference: BlockSemantics blocks the subtree below the node. '
        'ExcludeSemantics excludes the node itself and all descendants.',
        cardWhite,
      ),
    ],
  );

  print('[BlockSemantics Demo] Section 4 built (ExcludeSemantics)');

  // ========================================================
  // SECTION 5: MergeSemantics comparison
  // ========================================================
  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle('5. MergeSemantics Comparison', Color(0xFF33691E), Color(0xFF1B5E20)),
      buildInfoCard(
        'MergeSemantics merges the semantics of its descendants into one node. '
        'This is the opposite of blocking -- it combines multiple semantic nodes '
        'into a single accessible element for screen readers.',
        mergeGreen,
      ),
      SizedBox(height: 8),
      // MergeSemantics example
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: mergeGreen,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFF8BC34A), width: 2),
        ),
        child: MergeSemantics(
          child: Container(
            padding: EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.merge_type, color: Color(0xFF33691E), size: 28),
                    SizedBox(width: 12),
                    Text('MergeSemantics',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkText)),
                  ],
                ),
                SizedBox(height: 10),
                Text('All these items are merged into ONE semantic node:',
                    style: TextStyle(fontSize: 13, color: darkText)),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, color: Color(0xFFFFC107), size: 20),
                    SizedBox(width: 6),
                    Text('Rating: 4.5 stars', style: TextStyle(fontSize: 13, color: darkText)),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.favorite, color: accentPink, size: 20),
                    SizedBox(width: 6),
                    Text('Liked by 1234 users', style: TextStyle(fontSize: 13, color: darkText)),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.share, color: Color(0xFF1976D2), size: 20),
                    SizedBox(width: 6),
                    Text('Shared 567 times', style: TextStyle(fontSize: 13, color: darkText)),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Screen reader reads this as a single group rather than individual items.',
                  style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: Color(0xFF616161)),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 4),
      // Without MergeSemantics for comparison
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Color(0xFFF1F8E9),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: dividerGrey, width: 1),
        ),
        child: Container(
          padding: EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Without MergeSemantics (separate nodes)',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: darkText)),
              SizedBox(height: 8),
              Text('Each item below is a separate semantic node:',
                  style: TextStyle(fontSize: 13, color: darkText)),
              SizedBox(height: 6),
              Semantics(
                label: 'Rating node',
                child: Row(
                  children: [
                    Icon(Icons.star, color: Color(0xFFFFC107), size: 20),
                    SizedBox(width: 6),
                    Text('Rating: 4.5 stars', style: TextStyle(fontSize: 13, color: darkText)),
                  ],
                ),
              ),
              SizedBox(height: 4),
              Semantics(
                label: 'Likes node',
                child: Row(
                  children: [
                    Icon(Icons.favorite, color: accentPink, size: 20),
                    SizedBox(width: 6),
                    Text('Liked by 1234 users', style: TextStyle(fontSize: 13, color: darkText)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  print('[BlockSemantics Demo] Section 5 built (MergeSemantics)');

  // ========================================================
  // SECTION 6: Semantics widget with various properties
  // ========================================================
  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle('6. Semantics Widget Properties', Color(0xFF0D47A1), Color(0xFF1565C0)),
      buildInfoCard(
        'The Semantics widget annotates the widget tree with accessibility information. '
        'It provides label, hint, value, and many other properties for screen readers.',
        semanticsBlue,
      ),
      SizedBox(height: 8),
      // Semantics with label
      Semantics(
        label: 'User profile image',
        hint: 'Double tap to view full profile',
        value: 'Active user',
        child: buildSemanticsIndicator(
          'Semantics(label: "User profile image", hint: "Double tap...", value: "Active")',
          semanticsBlue,
          Icons.person,
        ),
      ),
      // Semantics with button properties
      Semantics(
        label: 'Submit form button',
        hint: 'Double tap to submit the form',
        button: true,
        enabled: true,
        child: buildSemanticsIndicator(
          'Semantics(button: true, enabled: true, label: "Submit form")',
          semanticsBlue,
          Icons.send,
        ),
      ),
      // Semantics with header
      Semantics(
        label: 'Settings section header',
        header: true,
        child: buildSemanticsIndicator(
          'Semantics(header: true, label: "Settings section header")',
          semanticsBlue,
          Icons.settings,
        ),
      ),
      // Semantics with image role
      Semantics(
        label: 'Landscape photograph of mountains',
        image: true,
        child: buildSemanticsIndicator(
          'Semantics(image: true, label: "Landscape photograph")',
          semanticsBlue,
          Icons.image,
        ),
      ),
      // Semantics with readOnly and focusable
      Semantics(
        label: 'Read only information field',
        readOnly: true,
        focusable: true,
        child: buildSemanticsIndicator(
          'Semantics(readOnly: true, focusable: true)',
          semanticsBlue,
          Icons.info_outline,
        ),
      ),
      SizedBox(height: 8),
      // BlockSemantics blocking all the above semantics
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: blockedBg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFFE57373), width: 2),
        ),
        child: BlockSemantics(
          blocking: true,
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.block, color: Color(0xFFD32F2F), size: 24),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'BlockSemantics wrapping Semantics widgets',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFD32F2F)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Semantics(
                label: 'This label is blocked',
                child: Text('Semantics(label: "This label is blocked") - NOT accessible',
                    style: TextStyle(fontSize: 12, color: darkText)),
              ),
              SizedBox(height: 4),
              Semantics(
                label: 'This hint is also blocked',
                hint: 'Cannot be read',
                child: Text('Semantics(hint: "Cannot be read") - also blocked',
                    style: TextStyle(fontSize: 12, color: darkText)),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  print('[BlockSemantics Demo] Section 6 built (Semantics properties)');

  // ========================================================
  // SECTION 7: Drawer overlay pattern
  // ========================================================
  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle('7. Drawer Overlay Pattern', Color(0xFF7B1FA2), Color(0xFF6A1B9A)),
      buildInfoCard(
        'In a real app, when a drawer is open, BlockSemantics blocks the main content '
        'behind the drawer. This prevents screen readers from navigating to the '
        'background while the drawer is open.',
        drawerPurple,
      ),
      SizedBox(height: 8),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        height: 320,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFF9C27B0), width: 2),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Main content behind the drawer (blocked)
            BlockSemantics(
              blocking: true,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Color(0xFFFAFAFA),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.menu, color: darkText, size: 24),
                        SizedBox(width: 12),
                        Text('My App',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkText)),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text('Main Content Area',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: darkText)),
                    SizedBox(height: 8),
                    Text('This content is behind the drawer.',
                        style: TextStyle(fontSize: 13, color: Color(0xFF757575))),
                    Text('Screen readers cannot access this.',
                        style: TextStyle(fontSize: 13, color: Color(0xFF757575))),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text('Action Button (blocked)',
                          style: TextStyle(fontSize: 13, color: darkText)),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.block, size: 14, color: Color(0xFFD32F2F)),
                        SizedBox(width: 4),
                        Text('Blocked by drawer overlay',
                            style: TextStyle(fontSize: 11, color: Color(0xFFD32F2F))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Scrim overlay
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Color(0x88000000),
            ),
            // Drawer panel
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: 220,
              child: Container(
                decoration: BoxDecoration(
                  color: cardWhite,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x44000000),
                      blurRadius: 16,
                      offset: Offset(4, 0),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      color: Color(0xFF7B1FA2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.account_circle, size: 48, color: lightText),
                          SizedBox(height: 8),
                          Text('Navigation Drawer',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: lightText)),
                          Text('Accessible to readers',
                              style: TextStyle(fontSize: 12, color: Color(0xCCFFFFFF))),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Icon(Icons.home, size: 20, color: darkText),
                          SizedBox(width: 12),
                          Text('Home', style: TextStyle(fontSize: 14, color: darkText)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Icon(Icons.settings, size: 20, color: darkText),
                          SizedBox(width: 12),
                          Text('Settings', style: TextStyle(fontSize: 14, color: darkText)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Icon(Icons.help, size: 20, color: darkText),
                          SizedBox(width: 12),
                          Text('Help', style: TextStyle(fontSize: 14, color: darkText)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Icon(Icons.logout, size: 20, color: darkText),
                          SizedBox(width: 12),
                          Text('Logout', style: TextStyle(fontSize: 14, color: darkText)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  print('[BlockSemantics Demo] Section 7 built (drawer overlay)');

  // ========================================================
  // SECTION 8: Coloured overlays showing blocked vs visible
  // ========================================================
  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle('8. Visual Blocked vs Visible Indicators', accentTeal, Color(0xFF00695C)),
      buildInfoCard(
        'Side-by-side comparison using colour-coded overlays to visually indicate '
        'which regions are blocked (red) vs visible (green) to screen readers.',
        sectionBg,
      ),
      SizedBox(height: 8),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            // Left: blocked
            Expanded(
              child: BlockSemantics(
                blocking: true,
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFFCDD2), Color(0xFFEF9A9A)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xFFE57373), width: 2),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.block, size: 36, color: Color(0xFFD32F2F)),
                      SizedBox(height: 8),
                      Text('BLOCKED',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD32F2F),
                          )),
                      SizedBox(height: 4),
                      Text('blocking: true',
                          style: TextStyle(fontSize: 11, color: Color(0xFF757575))),
                      SizedBox(height: 8),
                      Text('Semantics hidden',
                          style: TextStyle(fontSize: 12, color: darkText),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            // Right: visible
            Expanded(
              child: BlockSemantics(
                blocking: false,
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFC8E6C9), Color(0xFFA5D6A7)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xFF66BB6A), width: 2),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.accessibility_new, size: 36, color: Color(0xFF2E7D32)),
                      SizedBox(height: 8),
                      Text('VISIBLE',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                          )),
                      SizedBox(height: 4),
                      Text('blocking: false',
                          style: TextStyle(fontSize: 11, color: Color(0xFF757575))),
                      SizedBox(height: 8),
                      Text('Semantics active',
                          style: TextStyle(fontSize: 12, color: darkText),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 12),
      // Additional visual indicators row
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: blockedBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Color(0xFFD32F2F),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text('Red = Blocked', style: TextStyle(fontSize: 12, color: darkText)),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: unblockedBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Color(0xFF2E7D32),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text('Green = Visible', style: TextStyle(fontSize: 12, color: darkText)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  print('[BlockSemantics Demo] Section 8 built (visual indicators)');

  // ========================================================
  // SECTION 9: Summary comparison table
  // ========================================================
  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle('9. Semantics Widgets Summary', Color(0xFF37474F), Color(0xFF263238)),
      SizedBox(height: 8),
      // Table header
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: Color(0xFF37474F),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text('Widget',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: lightText)),
            ),
            Expanded(
              flex: 3,
              child: Text('Effect on Semantics',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: lightText)),
            ),
          ],
        ),
      ),
      // Row 1
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        color: Color(0xFFF5F5F5),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text('BlockSemantics', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: darkText)),
            ),
            Expanded(
              flex: 3,
              child: Text('Drops semantics subtree below when blocking=true',
                  style: TextStyle(fontSize: 12, color: darkText)),
            ),
          ],
        ),
      ),
      // Row 2
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        color: cardWhite,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text('ExcludeSemantics', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: darkText)),
            ),
            Expanded(
              flex: 3,
              child: Text('Excludes node and all descendants from tree',
                  style: TextStyle(fontSize: 12, color: darkText)),
            ),
          ],
        ),
      ),
      // Row 3
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        color: Color(0xFFF5F5F5),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text('MergeSemantics', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: darkText)),
            ),
            Expanded(
              flex: 3,
              child: Text('Merges all descendant semantics into one node',
                  style: TextStyle(fontSize: 12, color: darkText)),
            ),
          ],
        ),
      ),
      // Row 4
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: cardWhite,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text('Semantics', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: darkText)),
            ),
            Expanded(
              flex: 3,
              child: Text('Annotates tree with label, hint, value, roles',
                  style: TextStyle(fontSize: 12, color: darkText)),
            ),
          ],
        ),
      ),
      SizedBox(height: 16),
      // Footer
      Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [headerStart, headerEnd],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text('End of BlockSemantics Deep Demo',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: lightText)),
            SizedBox(height: 4),
            Text('RenderBlockSemantics controls semantics tree visibility',
                style: TextStyle(fontSize: 12, color: Color(0xCCFFFFFF))),
          ],
        ),
      ),
      SizedBox(height: 32),
    ],
  );

  print('[BlockSemantics Demo] Section 9 built (summary)');

  // ========================================================
  // Assemble all sections
  // ========================================================
  print('[BlockSemantics Demo] Assembling all sections');

  Widget result = Scaffold(
    backgroundColor: Color(0xFFF5F5F5),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerWidget,
          section1,
          section2,
          section3,
          section4,
          section5,
          section6,
          section7,
          section8,
          section9,
        ],
      ),
    ),
  );

  print('[BlockSemantics Demo] Build complete - returning widget');
  return result;
}

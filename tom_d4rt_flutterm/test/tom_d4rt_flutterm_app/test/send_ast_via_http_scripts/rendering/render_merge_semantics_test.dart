// Deep demo: RenderMergeSemantics via MergeSemantics widget
// MergeSemantics merges descendant semantics nodes into one unit
// Screen readers announce merged children as a single item
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('[MergeSemantics] Building deep demo');

  // State variables for interactive demos
  bool settingWifi = true;
  bool settingBluetooth = false;
  bool settingLocation = true;
  bool settingNfc = false;
  bool checkboxA = true;
  bool checkboxB = false;
  bool checkboxC = true;
  bool favoriteStarred = false;
  bool bookmarkActive = true;

  print('[MergeSemantics] State initialized');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        _buildHeader(),
        SizedBox(height: 24.0),

        // Section 1: Basic Icon + Text merged
        _buildSectionTitle('1. MergeSemantics: Icon + Text as One Unit'),
        SizedBox(height: 8.0),
        _buildBasicIconTextMerged(),
        SizedBox(height: 24.0),

        // Section 2: List tile with icon, title, subtitle merged
        _buildSectionTitle('2. MergeSemantics: List Tile Composition'),
        SizedBox(height: 8.0),
        _buildListTileMerged(),
        SizedBox(height: 24.0),

        // Section 3: Before/After comparison
        _buildSectionTitle('3. Before vs After: Unmerged vs Merged'),
        SizedBox(height: 8.0),
        _buildBeforeAfterComparison(),
        SizedBox(height: 24.0),

        // Section 4: Settings toggle rows
        _buildSectionTitle('4. Settings-Style Toggle Rows'),
        SizedBox(height: 8.0),
        _buildSettingsToggles(settingWifi, settingBluetooth, settingLocation, settingNfc),
        SizedBox(height: 24.0),

        // Section 5: Interactive children
        _buildSectionTitle('5. MergeSemantics with Interactive Children'),
        SizedBox(height: 8.0),
        _buildInteractiveChildren(checkboxA, checkboxB, checkboxC, favoriteStarred, bookmarkActive),
        SizedBox(height: 24.0),

        // Section 6: Semantics labels for comparison
        _buildSectionTitle('6. Semantics Widget Labels Comparison'),
        SizedBox(height: 8.0),
        _buildSemanticsLabelsComparison(),
        SizedBox(height: 24.0),

        // Section 7: Practical patterns
        _buildSectionTitle('7. Practical Accessible Patterns'),
        SizedBox(height: 8.0),
        _buildPracticalPatterns(),
        SizedBox(height: 24.0),

        // Section 8: Visual diagram of semantics tree
        _buildSectionTitle('8. Visual Diagram: Semantics Tree Merging'),
        SizedBox(height: 8.0),
        _buildSemanticsDiagram(),
        SizedBox(height: 24.0),

        // Section 9: Accessible cards
        _buildSectionTitle('9. Accessible Card Patterns'),
        SizedBox(height: 8.0),
        _buildAccessibleCards(),
        SizedBox(height: 24.0),

        // Section 10: Accessible form rows
        _buildSectionTitle('10. Accessible Form Rows'),
        SizedBox(height: 8.0),
        _buildAccessibleFormRows(),
        SizedBox(height: 32.0),

        // Footer
        _buildFooter(),
      ],
    ),
  );
}

// Header with gradient styling
Widget _buildHeader() {
  print('[MergeSemantics] Building header');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA), Color(0xFFAB47BC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x406A1B9A),
          blurRadius: 12.0,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.merge_type, size: 48.0, color: Colors.white),
        SizedBox(height: 12.0),
        Text(
          'MergeSemantics Deep Demo',
          style: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Merges descendant semantics nodes into a single announcement for screen readers',
          style: TextStyle(fontSize: 15.0, color: Color(0xDDFFFFFF)),
        ),
      ],
    ),
  );
}

// Section title with gradient accent
Widget _buildSectionTitle(String title) {
  print('[MergeSemantics] Section: ' + title);
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF7B1FA2), Color(0xFFCE93D8)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    ),
  );
}

// Section 1: Basic Icon + Text merged as one unit
Widget _buildBasicIconTextMerged() {
  print('[MergeSemantics] Building basic icon+text merged');
  return Card(
    elevation: 3.0,
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Screen reader announces icon and text as a single item:',
            style: TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
          SizedBox(height: 12.0),
          // Merged: icon + text read as one
          MergeSemantics(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.email, color: Color(0xFF6A1B9A), size: 28.0),
                SizedBox(width: 10.0),
                Text('Inbox Messages', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          MergeSemantics(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.phone, color: Color(0xFF388E3C), size: 28.0),
                SizedBox(width: 10.0),
                Text('Recent Calls', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          MergeSemantics(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.calendar_today, color: Color(0xFFE65100), size: 28.0),
                SizedBox(width: 10.0),
                Text('Upcoming Events', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// Section 2: List tile with icon, title, subtitle merged
Widget _buildListTileMerged() {
  print('[MergeSemantics] Building list tile merged');
  return Card(
    elevation: 3.0,
    child: Column(
      children: [
        MergeSemantics(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xFF6A1B9A),
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text('Alice Johnson', style: TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text('Senior Developer - Engineering Team'),
            trailing: Icon(Icons.chevron_right, color: Colors.grey),
          ),
        ),
        Divider(height: 1.0),
        MergeSemantics(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xFF1565C0),
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text('Bob Martinez', style: TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text('Product Manager - Growth Team'),
            trailing: Icon(Icons.chevron_right, color: Colors.grey),
          ),
        ),
        Divider(height: 1.0),
        MergeSemantics(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xFF2E7D32),
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text('Carol Chen', style: TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text('UX Designer - Design Team'),
            trailing: Icon(Icons.chevron_right, color: Colors.grey),
          ),
        ),
      ],
    ),
  );
}

// Section 3: Before/After comparison
Widget _buildBeforeAfterComparison() {
  print('[MergeSemantics] Building before/after comparison');
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Without MergeSemantics
      Expanded(
        child: Card(
          elevation: 2.0,
          color: Color(0xFFFFF3E0),
          child: Padding(
            padding: EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFE65100),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text('UNMERGED', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11.0)),
                ),
                SizedBox(height: 10.0),
                Text('Each child announced separately:', style: TextStyle(fontSize: 12.0, color: Colors.grey)),
                SizedBox(height: 8.0),
                // No MergeSemantics - each is separate
                Row(
                  children: [
                    Semantics(label: 'Warning icon', child: Icon(Icons.warning, color: Color(0xFFE65100), size: 24.0)),
                    SizedBox(width: 8.0),
                    Semantics(label: 'Battery low text', child: Text('Battery Low', style: TextStyle(fontSize: 15.0))),
                  ],
                ),
                SizedBox(height: 6.0),
                Text('Reader: "Warning icon" then "Battery low text"', style: TextStyle(fontSize: 11.0, fontStyle: FontStyle.italic, color: Color(0xFFBF360C))),
              ],
            ),
          ),
        ),
      ),
      SizedBox(width: 12.0),
      // With MergeSemantics
      Expanded(
        child: Card(
          elevation: 2.0,
          color: Color(0xFFE8F5E9),
          child: Padding(
            padding: EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF2E7D32),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text('MERGED', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11.0)),
                ),
                SizedBox(height: 10.0),
                Text('All children read as one item:', style: TextStyle(fontSize: 12.0, color: Colors.grey)),
                SizedBox(height: 8.0),
                // With MergeSemantics - read as one
                MergeSemantics(
                  child: Row(
                    children: [
                      Icon(Icons.warning, color: Color(0xFFE65100), size: 24.0),
                      SizedBox(width: 8.0),
                      Text('Battery Low', style: TextStyle(fontSize: 15.0)),
                    ],
                  ),
                ),
                SizedBox(height: 6.0),
                Text('Reader: "Warning, Battery Low"', style: TextStyle(fontSize: 11.0, fontStyle: FontStyle.italic, color: Color(0xFF1B5E20))),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

// Section 4: Settings-style toggle rows
Widget _buildSettingsToggles(bool wifi, bool bluetooth, bool location, bool nfc) {
  print('[MergeSemantics] Building settings toggles');
  print('[MergeSemantics] wifi=' + wifi.toString() + ' bt=' + bluetooth.toString());
  return Card(
    elevation: 3.0,
    child: Column(
      children: [
        // WiFi toggle row
        MergeSemantics(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Icon(Icons.wifi, color: Color(0xFF1565C0), size: 26.0),
                SizedBox(width: 14.0),
                Expanded(
                  child: Text('Wi-Fi', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
                ),
                Switch(value: wifi, onChanged: (v) { print('[MergeSemantics] WiFi toggled: ' + v.toString()); }),
              ],
            ),
          ),
        ),
        Divider(height: 1.0),
        // Bluetooth toggle row
        MergeSemantics(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Icon(Icons.bluetooth, color: Color(0xFF0277BD), size: 26.0),
                SizedBox(width: 14.0),
                Expanded(
                  child: Text('Bluetooth', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
                ),
                Switch(value: bluetooth, onChanged: (v) { print('[MergeSemantics] Bluetooth toggled: ' + v.toString()); }),
              ],
            ),
          ),
        ),
        Divider(height: 1.0),
        // Location toggle row
        MergeSemantics(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Icon(Icons.location_on, color: Color(0xFF2E7D32), size: 26.0),
                SizedBox(width: 14.0),
                Expanded(
                  child: Text('Location Services', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
                ),
                Switch(value: location, onChanged: (v) { print('[MergeSemantics] Location toggled: ' + v.toString()); }),
              ],
            ),
          ),
        ),
        Divider(height: 1.0),
        // NFC toggle row
        MergeSemantics(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Icon(Icons.nfc, color: Color(0xFF6A1B9A), size: 26.0),
                SizedBox(width: 14.0),
                Expanded(
                  child: Text('NFC', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
                ),
                Switch(value: nfc, onChanged: (v) { print('[MergeSemantics] NFC toggled: ' + v.toString()); }),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// Section 5: Interactive children merged
Widget _buildInteractiveChildren(bool cbA, bool cbB, bool cbC, bool fav, bool bookmark) {
  print('[MergeSemantics] Building interactive children');
  return Card(
    elevation: 3.0,
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Checkboxes merged with labels:', style: TextStyle(fontSize: 14.0, color: Colors.grey)),
          SizedBox(height: 8.0),
          MergeSemantics(
            child: Row(
              children: [
                Checkbox(value: cbA, onChanged: (v) { print('[MergeSemantics] Checkbox A: ' + v.toString()); }),
                SizedBox(width: 4.0),
                Text('Accept Terms of Service', style: TextStyle(fontSize: 15.0)),
              ],
            ),
          ),
          MergeSemantics(
            child: Row(
              children: [
                Checkbox(value: cbB, onChanged: (v) { print('[MergeSemantics] Checkbox B: ' + v.toString()); }),
                SizedBox(width: 4.0),
                Text('Subscribe to newsletter', style: TextStyle(fontSize: 15.0)),
              ],
            ),
          ),
          MergeSemantics(
            child: Row(
              children: [
                Checkbox(value: cbC, onChanged: (v) { print('[MergeSemantics] Checkbox C: ' + v.toString()); }),
                SizedBox(width: 4.0),
                Text('Enable notifications', style: TextStyle(fontSize: 15.0)),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Text('Icon buttons merged with labels:', style: TextStyle(fontSize: 14.0, color: Colors.grey)),
          SizedBox(height: 8.0),
          Row(
            children: [
              MergeSemantics(
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(fav ? Icons.star : Icons.star_border, color: Color(0xFFFFA000), size: 30.0),
                      onPressed: () { print('[MergeSemantics] Favorite toggled'); },
                    ),
                    Text('Favorite', style: TextStyle(fontSize: 12.0)),
                  ],
                ),
              ),
              SizedBox(width: 24.0),
              MergeSemantics(
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(bookmark ? Icons.bookmark : Icons.bookmark_border, color: Color(0xFF1565C0), size: 30.0),
                      onPressed: () { print('[MergeSemantics] Bookmark toggled'); },
                    ),
                    Text('Bookmark', style: TextStyle(fontSize: 12.0)),
                  ],
                ),
              ),
              SizedBox(width: 24.0),
              MergeSemantics(
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.share, color: Color(0xFF2E7D32), size: 30.0),
                      onPressed: () { print('[MergeSemantics] Share pressed'); },
                    ),
                    Text('Share', style: TextStyle(fontSize: 12.0)),
                  ],
                ),
              ),
              SizedBox(width: 24.0),
              MergeSemantics(
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete_outline, color: Color(0xFFC62828), size: 30.0),
                      onPressed: () { print('[MergeSemantics] Delete pressed'); },
                    ),
                    Text('Delete', style: TextStyle(fontSize: 12.0)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// Section 6: Semantics labels comparison
Widget _buildSemanticsLabelsComparison() {
  print('[MergeSemantics] Building semantics labels comparison');
  return Card(
    elevation: 3.0,
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Using Semantics widget with explicit labels:', style: TextStyle(fontSize: 14.0, color: Colors.grey)),
          SizedBox(height: 12.0),
          // Explicit Semantics label
          Semantics(
            label: 'Download speed: 45 megabytes per second',
            child: Row(
              children: [
                Icon(Icons.download, color: Color(0xFF1565C0), size: 24.0),
                SizedBox(width: 8.0),
                Text('45 MB/s', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          SizedBox(height: 12.0),
          // MergeSemantics approach
          MergeSemantics(
            child: Row(
              children: [
                Icon(Icons.upload, color: Color(0xFF2E7D32), size: 24.0),
                SizedBox(width: 8.0),
                Text('Upload: ', style: TextStyle(fontSize: 16.0, color: Colors.grey)),
                Text('12 MB/s', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Color(0xFFF3E5F5),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Comparison Notes:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0)),
                SizedBox(height: 6.0),
                Text('- Semantics(label:) gives full control over announcement', style: TextStyle(fontSize: 12.0)),
                Text('- MergeSemantics concatenates child labels automatically', style: TextStyle(fontSize: 12.0)),
                Text('- Use Semantics for custom descriptions of complex widgets', style: TextStyle(fontSize: 12.0)),
                Text('- Use MergeSemantics when children already have good labels', style: TextStyle(fontSize: 12.0)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// Section 7: Practical accessible patterns
Widget _buildPracticalPatterns() {
  print('[MergeSemantics] Building practical patterns');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Accessible list items
      Text('Accessible List Items:', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600)),
      SizedBox(height: 8.0),
      Card(
        elevation: 2.0,
        child: Column(
          children: [
            MergeSemantics(
              child: ListTile(
                leading: Container(
                  width: 44.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFE8EAF6),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(Icons.article, color: Color(0xFF283593)),
                ),
                title: Text('Project Proposal.pdf'),
                subtitle: Text('2.4 MB - Modified yesterday'),
                trailing: Icon(Icons.more_vert),
              ),
            ),
            Divider(height: 1.0),
            MergeSemantics(
              child: ListTile(
                leading: Container(
                  width: 44.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(Icons.table_chart, color: Color(0xFF2E7D32)),
                ),
                title: Text('Budget_Q4.xlsx'),
                subtitle: Text('1.1 MB - Modified 3 days ago'),
                trailing: Icon(Icons.more_vert),
              ),
            ),
            Divider(height: 1.0),
            MergeSemantics(
              child: ListTile(
                leading: Container(
                  width: 44.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFF3E0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(Icons.image, color: Color(0xFFE65100)),
                ),
                title: Text('Design_Mockups.png'),
                subtitle: Text('5.7 MB - Modified last week'),
                trailing: Icon(Icons.more_vert),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 16.0),
      // Accessible badge rows
      Text('Accessible Badge Rows:', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600)),
      SizedBox(height: 8.0),
      MergeSemantics(
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Icon(Icons.verified, color: Color(0xFF1565C0), size: 22.0),
              SizedBox(width: 10.0),
              Text('Verified Account', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500)),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Color(0xFF1565C0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text('Active', style: TextStyle(color: Colors.white, fontSize: 12.0)),
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 8.0),
      MergeSemantics(
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFFFCE4EC),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Icon(Icons.security, color: Color(0xFFC62828), size: 22.0),
              SizedBox(width: 10.0),
              Text('Two-Factor Auth', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500)),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Color(0xFFC62828),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text('Disabled', style: TextStyle(color: Colors.white, fontSize: 12.0)),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

// Section 8: Visual diagram of semantics tree merging
Widget _buildSemanticsDiagram() {
  print('[MergeSemantics] Building semantics tree diagram');
  return Card(
    elevation: 3.0,
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Without MergeSemantics:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)),
          SizedBox(height: 8.0),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Color(0xFFFFB300), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SemanticsNode (Row)', style: TextStyle(fontFamily: 'monospace', fontSize: 13.0, fontWeight: FontWeight.bold)),
                Text('  |-- SemanticsNode: "star icon"', style: TextStyle(fontFamily: 'monospace', fontSize: 12.0, color: Color(0xFFE65100))),
                Text('  |-- SemanticsNode: "Rating"', style: TextStyle(fontFamily: 'monospace', fontSize: 12.0, color: Color(0xFFE65100))),
                Text('  |-- SemanticsNode: "4.5"', style: TextStyle(fontFamily: 'monospace', fontSize: 12.0, color: Color(0xFFE65100))),
                SizedBox(height: 4.0),
                Text('=> 3 separate announcements', style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFFBF360C))),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Text('With MergeSemantics:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)),
          SizedBox(height: 8.0),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Color(0xFF66BB6A), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SemanticsNode (MergeSemantics)', style: TextStyle(fontFamily: 'monospace', fontSize: 13.0, fontWeight: FontWeight.bold)),
                Text('  |-- merged: "star icon, Rating, 4.5"', style: TextStyle(fontFamily: 'monospace', fontSize: 12.0, color: Color(0xFF2E7D32))),
                SizedBox(height: 4.0),
                Text('=> 1 combined announcement', style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF1B5E20))),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          // Live example of the diagram
          Text('Live example:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)),
          SizedBox(height: 8.0),
          MergeSemantics(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star, color: Color(0xFFFFA000), size: 22.0),
                SizedBox(width: 6.0),
                Text('Rating: ', style: TextStyle(fontSize: 15.0, color: Colors.grey)),
                Text('4.5', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                Text(' / 5.0', style: TextStyle(fontSize: 13.0, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// Section 9: Accessible cards
Widget _buildAccessibleCards() {
  print('[MergeSemantics] Building accessible cards');
  return Column(
    children: [
      // Product card merged
      MergeSemantics(
        child: Card(
          elevation: 3.0,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 70.0,
                  height: 70.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF7B1FA2), Color(0xFFCE93D8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Icon(Icons.headphones, color: Colors.white, size: 36.0),
                ),
                SizedBox(width: 14.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Premium Headphones', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4.0),
                      Text('Noise cancelling, 30hr battery', style: TextStyle(fontSize: 13.0, color: Colors.grey)),
                      SizedBox(height: 6.0),
                      Text('\$299.99', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
                    ],
                  ),
                ),
                Icon(Icons.add_shopping_cart, color: Color(0xFF6A1B9A), size: 28.0),
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 10.0),
      // Notification card merged
      MergeSemantics(
        child: Card(
          elevation: 3.0,
          color: Color(0xFFFFF8E1),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFB300),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.notifications_active, color: Colors.white, size: 26.0),
                ),
                SizedBox(width: 14.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('System Update Available', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4.0),
                      Text('Version 3.2.1 is ready to install', style: TextStyle(fontSize: 13.0, color: Colors.grey)),
                    ],
                  ),
                ),
                Text('2m ago', style: TextStyle(fontSize: 12.0, color: Colors.grey)),
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 10.0),
      // Status card merged
      MergeSemantics(
        child: Card(
          elevation: 3.0,
          color: Color(0xFFE8F5E9),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF2E7D32),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check_circle_outline, color: Colors.white, size: 26.0),
                ),
                SizedBox(width: 14.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Backup Complete', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4.0),
                      Text('All 1,247 files backed up successfully', style: TextStyle(fontSize: 13.0, color: Colors.grey)),
                    ],
                  ),
                ),
                Icon(Icons.cloud_done, color: Color(0xFF2E7D32), size: 28.0),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

// Section 10: Accessible form rows
Widget _buildAccessibleFormRows() {
  print('[MergeSemantics] Building accessible form rows');
  return Card(
    elevation: 3.0,
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Form fields with merged semantics:', style: TextStyle(fontSize: 14.0, color: Colors.grey)),
          SizedBox(height: 12.0),
          // Username row
          MergeSemantics(
            child: Row(
              children: [
                Icon(Icons.person_outline, color: Color(0xFF6A1B9A), size: 24.0),
                SizedBox(width: 12.0),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                      hintText: 'Enter your username',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 14.0),
          // Email row
          MergeSemantics(
            child: Row(
              children: [
                Icon(Icons.email_outlined, color: Color(0xFF1565C0), size: 24.0),
                SizedBox(width: 12.0),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      hintText: 'example@mail.com',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 14.0),
          // Phone row
          MergeSemantics(
            child: Row(
              children: [
                Icon(Icons.phone_outlined, color: Color(0xFF2E7D32), size: 24.0),
                SizedBox(width: 12.0),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      hintText: '+1 (555) 000-0000',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          // Tip box
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Color(0xFFF3E5F5),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Color(0xFFCE93D8), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb_outline, color: Color(0xFF6A1B9A), size: 20.0),
                    SizedBox(width: 8.0),
                    Text('Accessibility Tip', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0, color: Color(0xFF6A1B9A))),
                  ],
                ),
                SizedBox(height: 8.0),
                Text(
                  'MergeSemantics merges all descendant semantics into one node. '
                  'This is useful when a group of widgets represents a single concept. '
                  'Screen readers will announce the merged content as a single item, '
                  'reducing verbosity and improving navigation speed.',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF4A148C)),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// Footer
Widget _buildFooter() {
  print('[MergeSemantics] Building footer');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFAB47BC), Color(0xFF8E24AA), Color(0xFF6A1B9A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        Icon(Icons.accessibility_new, color: Colors.white, size: 36.0),
        SizedBox(height: 10.0),
        Text(
          'MergeSemantics Deep Demo Complete',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 6.0),
        Text(
          'RenderMergeSemantics collapses the semantics tree so descendant nodes '
          'are announced as one cohesive unit by assistive technologies.',
          style: TextStyle(fontSize: 13.0, color: Color(0xDDFFFFFF)),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

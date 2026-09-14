// ignore_for_file: avoid_print
// D4rt deep demo: RestorationBucket — the hierarchical container that
// stores and restores widget state across process restarts via the
// Flutter state restoration framework.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Emerald / Jade palette ───
  const Color emerald = Color(0xFF047857);
  const Color jade = Color(0xFF6EE7B7);
  const Color deepEmerald = Color(0xFF065F46);
  const Color paleJade = Color(0xFFD1FAE5);
  const Color malachite = Color(0xFF059669);
  const Color mint = Color(0xFFA7F3D0);
  const Color viridian = Color(0xFF10B981);
  const Color forest = Color(0xFF064E3B);
  const Color seafoam = Color(0xFFECFDF5);
  const Color beryl = Color(0xFF34D399);

  print('[rb] ===== RESTORATION BUCKET DEEP DEMO =====');

  // ─── Local helpers ───

  Widget rbBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [forest, deepEmerald],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: forest.withValues(alpha: 0.35),
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
              color: malachite,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: jade, width: 1.5),
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

  Widget rbNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: seafoam,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: mint),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: forest.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget rbCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: jade.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: forest.withValues(alpha: 0.06),
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
              color: emerald.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: forest)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget rbRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? emerald.withValues(alpha: 0.06) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: jade.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? forest : deepEmerald)),
          );
        }).toList(),
      ),
    );
  }

  Widget rbFlow(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? forest : deepEmerald,
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
          child: Icon(Icons.arrow_forward, size: 12, color: malachite),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  // ━━━━━━ SECTION 1: What is RestorationBucket? ━━━━━━
  print('[rb-01] Section 1: What is RestorationBucket?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rbBanner('01', 'What Is RestorationBucket?'),
      rbNote(
        'RestorationBucket is the core storage container in Flutter\'s state '
        'restoration framework. It holds key-value pairs of serializable data '
        'that can be persisted by the engine and restored when the app process '
        'is restarted (e.g., after Android kills a background app).',
      ),
      rbCard(
        'Bucket Architecture',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            rbFlow(['Widget state', 'Register', 'Bucket stores',
                'Engine persists', 'Restore on restart']),
            const SizedBox(height: 10),
            _rbRoleBadge('Stores', 'Serializable state values', forest),
            _rbRoleBadge('Organizes', 'Hierarchical tree of buckets', deepEmerald),
            _rbRoleBadge('Notifies', 'Listeners on data changes', emerald),
            _rbRoleBadge('Restores', 'State from engine data', malachite),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 2: Bucket hierarchy ━━━━━━
  print('[rb-02] Section 2: Bucket hierarchy');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rbBanner('02', 'Bucket Hierarchy'),
      rbNote(
        'Buckets form a tree mirroring the widget tree. The root bucket is '
        'owned by the RestorationManager (from ServicesBinding). Each '
        'RestorationScope creates a child bucket. Child buckets are claimed '
        'via claimChild(), which creates or retrieves a named sub-bucket.',
      ),
      rbCard(
        'Bucket Tree',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _rbTreeNode('Root Bucket', 'RestorationManager', 0, forest),
            _rbTreeNode('App Bucket', 'MaterialApp scope', 1, deepEmerald),
            _rbTreeNode('Page Bucket', 'Route restoration', 2, emerald),
            _rbTreeNode('Widget Bucket', 'RestorableProperty host', 3, malachite),
            _rbTreeNode('Nested Bucket', 'Nested scope', 3, viridian),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: Storing primitives ━━━━━━
  print('[rb-03] Section 3: Storing primitives');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rbBanner('03', 'Storing Primitive Values'),
      rbNote(
        'Buckets store values via RestorableProperty subclasses. Flutter '
        'provides built-in types: RestorableInt, RestorableDouble, '
        'RestorableBool, RestorableString, RestorableNum. Each wraps a '
        'primitive and knows how to serialize/deserialize itself.',
      ),
      rbCard(
        'Built-in Restorable Types',
        Column(
          children: [
            rbRow(['Type', 'Dart Type', 'Default'], isHeader: true),
            rbRow(['RestorableInt', 'int', '0']),
            rbRow(['RestorableDouble', 'double', '0.0']),
            rbRow(['RestorableBool', 'bool', 'false']),
            rbRow(['RestorableString', 'String', '""']),
            rbRow(['RestorableNum', 'num', '0']),
            rbRow(['RestorableIntN', 'int?', 'null']),
            rbRow(['RestorableDoubleN', 'double?', 'null']),
            rbRow(['RestorableBoolN', 'bool?', 'null']),
            rbRow(['RestorableStringN', 'String?', 'null']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: Storing complex objects ━━━━━━
  print('[rb-04] Section 4: Complex objects');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rbBanner('04', 'Storing Complex Objects'),
      rbNote(
        'For non-primitive state, use RestorableValue<T> or create custom '
        'RestorableProperty subclasses. Flutter includes RestorableDateTime, '
        'RestorableTextEditingController, RestorableEnumN. Complex objects '
        'must serialize to primitives (int, double, String, bool, List, Map).',
      ),
      rbCard(
        'Complex Restorable Types',
        Column(
          children: [
            rbRow(['Type', 'Serializes As', 'Use Case'], isHeader: true),
            rbRow(['RestorableDateTime', 'int (milliseconds)', 'Date pickers']),
            rbRow(['RestorableDateTimeN', 'int?', 'Optional dates']),
            rbRow(['RestorableTextEditingController', 'String', 'Text fields']),
            rbRow(['RestorableEnum', 'String (name)', 'Enums']),
            rbRow(['RestorableEnumN', 'String?', 'Nullable enums']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: Restoration IDs ━━━━━━
  print('[rb-05] Section 5: Restoration IDs');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rbBanner('05', 'Restoration IDs'),
      rbNote(
        'Every value in a bucket is stored under a unique String key — '
        'the restoration ID. IDs must be unique within a bucket (not globally). '
        'The restorationId on widgets like Scaffold, TabBar, Navigator '
        'creates the scope under which state is stored.',
      ),
      rbCard(
        'ID Scope Rules',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _rbIdExample('restorationId: "home"', 'Scaffold scope', forest),
            _rbIdExample('  └ restorationId: "counter"', 'RestorableInt key', deepEmerald),
            _rbIdExample('  └ restorationId: "name"', 'RestorableString key', emerald),
            _rbIdExample('restorationId: "settings"', 'Another Scaffold', malachite),
            _rbIdExample('  └ restorationId: "counter"', 'Same name — OK, different scope', viridian),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: Claiming children ━━━━━━
  print('[rb-06] Section 6: Claiming children');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rbBanner('06', 'Claiming Child Buckets'),
      rbNote(
        'claimChild(restorationId) creates or retrieves a named child bucket. '
        'If the engine provided restoration data, the child bucket is '
        'pre-populated with the stored values. If not, it starts empty. '
        'Unclaimed children from previous sessions are discarded.',
      ),
      rbCard(
        'Claim Workflow',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            rbFlow(['Parent bucket', 'claimChild(id)',
                'Child exists?', 'Return / create', 'Ready']),
            const SizedBox(height: 10),
            _rbStepItem(1, 'Parent calls claimChild("counter")', forest),
            _rbStepItem(2, 'Bucket checks stored data for "counter"', deepEmerald),
            _rbStepItem(3, 'If found: return pre-filled child bucket', emerald),
            _rbStepItem(4, 'If not: return new empty child bucket', malachite),
            _rbStepItem(5, 'Child bucket linked to parent tree', viridian),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: Serialization ━━━━━━
  print('[rb-07] Section 7: Serialization');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rbBanner('07', 'Serialization Format'),
      rbNote(
        'Bucket data is serialized as nested Maps. The engine stores this '
        'as a binary blob. Only primitives are allowed: int, double, bool, '
        'String, Uint8List, Int32List, Int64List, Float32List, Float64List, '
        'List, and Map. No Dart objects.',
      ),
      rbCard(
        'Serialization Constraints',
        Column(
          children: [
            rbRow(['Type', 'Allowed?', 'Notes'], isHeader: true),
            rbRow(['int', 'Yes', 'No size limit specified']),
            rbRow(['double', 'Yes', 'IEEE 754']),
            rbRow(['bool', 'Yes', 'true / false']),
            rbRow(['String', 'Yes', 'UTF-8 encoded']),
            rbRow(['List', 'Yes', 'Of allowed types only']),
            rbRow(['Map', 'Yes', 'String keys, allowed values']),
            rbRow(['DateTime', 'No', 'Serialize as int (millis)']),
            rbRow(['Custom class', 'No', 'Must convert to primitives']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 8: Dispose lifecycle ━━━━━━
  print('[rb-08] Section 8: Dispose lifecycle');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rbBanner('08', 'Bucket Lifecycle & Dispose'),
      rbNote(
        'Buckets are created when scopes attach and disposed when scopes '
        'detach. Disposing a bucket removes it from the parent and discards '
        'its data. If the widget tree changes (e.g., navigation), unclaimed '
        'children are automatically cleaned up.',
      ),
      rbCard(
        'Lifecycle States',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _rbLifecycleState('Created', 'claimChild() or root init', Icons.add_circle_outline, forest),
            _rbLifecycleState('Active', 'Storing / reading values', Icons.check_circle_outline, emerald),
            _rbLifecycleState('Updated', 'Values changed, notify engine', Icons.sync, malachite),
            _rbLifecycleState('Disposed', 'Scope detached, data dropped', Icons.remove_circle_outline, viridian),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: RestorationScope ━━━━━━
  print('[rb-09] Section 9: RestorationScope');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rbBanner('09', 'RestorationScope Widget'),
      rbNote(
        'RestorationScope is the widget that creates a bucket in the tree. '
        'It claims a child bucket from its ancestor scope\'s bucket and '
        'makes it available to descendants via RestorationScope.of(context). '
        'Widgets use this to register their RestorationProperty instances.',
      ),
      rbCard(
        'Widget Tree Integration',
        Column(
          children: [
            rbRow(['Widget', 'Creates Scope?', 'Uses Bucket?'], isHeader: true),
            rbRow(['MaterialApp', 'Yes (root)', 'restorationScopeId']),
            rbRow(['Navigator', 'Yes', 'restorationScopeId']),
            rbRow(['Scaffold', 'Yes', 'restorationId']),
            rbRow(['RestorationScope', 'Yes', 'restorationId']),
            rbRow(['RestorableRouteFuture', 'Yes', 'Within navigator']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: Bucket nesting ━━━━━━
  print('[rb-10] Section 10: Nesting');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rbBanner('10', 'Bucket Nesting Patterns'),
      rbNote(
        'Deep widget trees produce deeply nested buckets. Each level adds '
        'isolation — a "counter" key in one scope doesn\'t conflict with '
        '"counter" in another. The tree structure is: root → app → navigator '
        '→ route → page → widget.',
      ),
      rbCard(
        'Nesting Visualization',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: seafoam,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _rbNestLine(0, '📦 Root Bucket', forest),
              _rbNestLine(1, '📦 "app" (MaterialApp)', deepEmerald),
              _rbNestLine(2, '📦 "nav" (Navigator)', emerald),
              _rbNestLine(3, '📦 "route-home" (Route)', malachite),
              _rbNestLine(4, '🔑 "counter" = 42', viridian),
              _rbNestLine(4, '🔑 "name" = "Alice"', beryl),
              _rbNestLine(3, '📦 "route-settings" (Route)', malachite),
              _rbNestLine(4, '🔑 "theme" = "dark"', viridian),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: Data change notification ━━━━━━
  print('[rb-11] Section 11: Data changes');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rbBanner('11', 'Data Change Notification'),
      rbNote(
        'When a value in a bucket changes, the bucket marks itself as '
        'needing serialization. The RestorationManager schedules a '
        'platform channel message to send the updated state to the engine. '
        'This is batched — not sent on every single change.',
      ),
      rbCard(
        'Change Propagation',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            rbFlow(['Value changes', 'Bucket dirty', 'Manager notified',
                'Batch send', 'Engine stores']),
            const SizedBox(height: 10),
            rbRow(['Step', 'Component', 'Action'], isHeader: true),
            rbRow(['1', 'RestorableProperty', 'value = newValue']),
            rbRow(['2', 'Bucket', 'Mark dirty']),
            rbRow(['3', 'RestorationManager', 'Schedule send']),
            rbRow(['4', 'Platform channel', 'Send serialized tree']),
            rbRow(['5', 'Engine', 'Persist to disk']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: Platform channel ━━━━━━
  print('[rb-12] Section 12: Platform channel');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rbBanner('12', 'Platform Channel Persistence'),
      rbNote(
        'The engine stores restoration data via platform-specific mechanisms: '
        'Android SavedInstanceState, iOS NSUserActivity. The data survives '
        'process death but not app uninstall. Web has no restoration support '
        'by default (no process death scenario).',
      ),
      rbCard(
        'Platform Storage',
        Column(
          children: [
            rbRow(['Platform', 'Storage', 'Limit'], isHeader: true),
            rbRow(['Android', 'SavedInstanceState Bundle', '~500KB typical']),
            rbRow(['iOS', 'NSUserActivity userInfo', 'Variable']),
            rbRow(['Web', 'None (no process death)', 'N/A']),
            rbRow(['Desktop', 'None (typically)', 'N/A']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: Dynamic registration ━━━━━━
  print('[rb-13] Section 13: Dynamic registration');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rbBanner('13', 'Dynamic Property Registration'),
      rbNote(
        'Properties are registered in restoreState() via registerForRestoration '
        '(property, restorationId). This is called when the bucket becomes '
        'available and on restoration. Unregistering removes the value from '
        'the bucket. Properties can be swapped dynamically.',
      ),
      rbCard(
        'Registration API',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: seafoam,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _rbCodeLine('@override', forest),
              _rbCodeLine('void restoreState(', forest),
              _rbCodeLine('    RestorationBucket? oldBucket,', deepEmerald),
              _rbCodeLine('    bool initialRestore) {', deepEmerald),
              _rbCodeLine('  registerForRestoration(', emerald),
              _rbCodeLine('    _counter, "counter");', emerald),
              _rbCodeLine('  registerForRestoration(', malachite),
              _rbCodeLine('    _name, "name");', malachite),
              _rbCodeLine('}', forest),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: Debugging ━━━━━━
  print('[rb-14] Section 14: Debugging');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rbBanner('14', 'Debugging Restoration'),
      rbNote(
        'Debug restoration by: (1) enabling "Don\'t Keep Activities" in '
        'Android dev options, (2) checking debugIsSerializableForRestoration, '
        '(3) printing bucket contents via debugFillProperties, (4) using '
        'RestorationManager.debugIsRestorationScheduled.',
      ),
      rbCard(
        'Debug Techniques',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _rbCheckItem('Enable "Don\'t Keep Activities" to simulate kill', forest),
            _rbCheckItem('Check restorationId is non-null on all scopes', deepEmerald),
            _rbCheckItem('Verify restoreState() is called on restart', emerald),
            _rbCheckItem('Print bucket.debugOwner for ownership tracking', malachite),
            _rbCheckItem('Watch for "restoration data too large" warnings', viridian),
            _rbCheckItem('Test by force-stopping app from Recent Apps', beryl),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Best practices ━━━━━━
  print('[rb-15] Section 15: Best practices');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rbBanner('15', 'Best Practices'),
      rbNote(
        'Keep restoration data small (< 100KB total). Only restore UI state, '
        'not app data. Use meaningful restoration IDs. Don\'t store sensitive '
        'data. Always test with "Don\'t Keep Activities" on Android and '
        'force-quit on iOS.',
      ),
      rbCard(
        'Do vs Don\'t',
        Column(
          children: [
            rbRow(['Do', 'Don\'t'], isHeader: true),
            rbRow(['Store scroll position', 'Store user token']),
            rbRow(['Store selected tab', 'Store API responses']),
            rbRow(['Store form input', 'Store images/files']),
            rbRow(['Store toggle state', 'Store database records']),
            rbRow(['Keep data < 100KB', 'Store large lists']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[rb-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rbBanner('16', 'Summary Dashboard'),
      rbCard(
        'RestorationBucket — Complete',
        Column(
          children: [
            rbRow(['Topic', 'Section', 'Key Insight'], isHeader: true),
            rbRow(['What', 'S01', 'Hierarchical state container']),
            rbRow(['Hierarchy', 'S02', 'Tree mirrors widget tree']),
            rbRow(['Primitives', 'S03', 'RestorableInt/Double/Bool/String']),
            rbRow(['Complex', 'S04', 'DateTime, Controller, Enum']),
            rbRow(['IDs', 'S05', 'Unique per bucket scope']),
            rbRow(['Claiming', 'S06', 'claimChild() for sub-buckets']),
            rbRow(['Serialization', 'S07', 'Primitives + List + Map only']),
            rbRow(['Lifecycle', 'S08', 'Create → active → disposed']),
            rbRow(['Scope widget', 'S09', 'RestorationScope.of(context)']),
            rbRow(['Nesting', 'S10', 'Root → app → nav → route → widget']),
            rbRow(['Change notify', 'S11', 'Batched platform sends']),
            rbRow(['Platform', 'S12', 'SavedInstanceState / NSUserActivity']),
            rbRow(['Registration', 'S13', 'registerForRestoration()']),
            rbRow(['Debug', 'S14', 'Don\'t Keep Activities + logging']),
            rbRow(['Practices', 'S15', 'Small UI state only']),
          ],
        ),
      ),
      rbCard(
        'Emerald / Jade Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _rbColorSwatch('Emerald', emerald),
            _rbColorSwatch('Jade', jade),
            _rbColorSwatch('Malachite', malachite),
            _rbColorSwatch('Viridian', viridian),
            _rbColorSwatch('Forest', forest),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [forest, deepEmerald],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('RestorationBucket — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'Flutter\'s hierarchical state restoration container: from '
              'primitive storage through nesting, serialization, platform '
              'persistence, lifecycle, and debugging practices.',
              style: TextStyle(color: paleJade, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[rb] palette: $beryl, $mint, $paleJade, $seafoam');
  print('[rb] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('RestorationBucket — State Persistence'),
        backgroundColor: forest,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF5FEFA),
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

Widget _rbRoleBadge(String role, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 70,
          child: Text(role,
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.bold, color: color)),
        ),
        Expanded(
          child: Text(desc,
              style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.8))),
        ),
      ],
    ),
  );
}

Widget _rbTreeNode(String name, String desc, int depth, Color color) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 20.0, bottom: 5),
    child: Row(
      children: [
        if (depth > 0)
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Icon(Icons.subdirectory_arrow_right, size: 12, color: color),
          ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: color.withValues(alpha: 0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(name,
                  style: TextStyle(
                      fontSize: 9, fontWeight: FontWeight.bold, color: color)),
              const SizedBox(width: 4),
              Text(desc,
                  style: TextStyle(
                      fontSize: 8, color: color.withValues(alpha: 0.7))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _rbIdExample(String id, String meaning, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(id,
              style: TextStyle(
                  fontSize: 9, fontFamily: 'monospace', color: color)),
        ),
        Expanded(
          flex: 2,
          child: Text(meaning,
              style: TextStyle(
                  fontSize: 9, color: color.withValues(alpha: 0.7))),
        ),
      ],
    ),
  );
}

Widget _rbStepItem(int num, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
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
          child: Text(desc,
              style: TextStyle(fontSize: 10, color: color)),
        ),
      ],
    ),
  );
}

Widget _rbLifecycleState(String name, String desc, IconData icon, Color color) {
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
              Text(name,
                  style: TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w600, color: color)),
              Text(desc,
                  style: TextStyle(
                      fontSize: 9, color: color.withValues(alpha: 0.7))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _rbNestLine(int depth, String text, Color color) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 16.0, bottom: 3),
    child: Text(text,
        style: TextStyle(
            fontSize: 10,
            fontFamily: 'monospace',
            color: color,
            height: 1.4)),
  );
}

Widget _rbCodeLine(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 2),
    child: Text(text,
        style: TextStyle(
            fontSize: 10,
            fontFamily: 'monospace',
            color: color,
            height: 1.3)),
  );
}

Widget _rbCheckItem(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Icon(Icons.check_circle_outline, size: 14, color: color),
        const SizedBox(width: 6),
        Expanded(
          child: Text(text,
              style: TextStyle(fontSize: 10, color: color)),
        ),
      ],
    ),
  );
}

Widget _rbColorSwatch(String name, Color color) {
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

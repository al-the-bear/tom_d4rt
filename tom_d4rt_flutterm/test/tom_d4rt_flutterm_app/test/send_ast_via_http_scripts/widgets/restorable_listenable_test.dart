// Deep visual test for RestorableListenable
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, unintended_html_in_doc_comment

import 'package:flutter/material.dart';

/// Deep visual exploration of RestorableListenable
/// An abstract base class for restorable Listenable properties.
///
/// RestorableListenable is a foundational piece of Flutter's restoration:
/// - Wraps any object that implements Listenable
/// - Auto-subscribes to the wrapped Listenable's notifications
/// - Triggers restoration data updates when Listenable fires
/// - Parent class for RestorableChangeNotifier
///
/// Perfect for wrapping custom Listenables that need state persistence.
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF1A1A2E),
    ),
    home: _RestorableListenableDemo(),
  );
}

// =============================================================================
// PALETTE: Indigo 700 / Deep Orange A400
// =============================================================================
const Color _kPrimary = Color(0xFF303F9F); // Indigo 700
const Color _kAccent = Color(0xFFFF3D00); // Deep Orange A400
const Color _kSurface = Color(0xFF252542);
const Color _kCardBg = Color(0xFF2D2D4A);
const Color _kTextPrimary = Color(0xFFE8E8F0);
const Color _kTextSecondary = Color(0xFFB0B0C8);
const Color _kDivider = Color(0xFF3A3A5C);
const Color _kSuccess = Color(0xFF66BB6A);
const Color _kWarning = Color(0xFFFF7043);
const Color _kMath = Color(0xFF26C6DA);
const Color _kHierarchy = Color(0xFFAB47BC);

// =============================================================================
// MAIN DEMO WIDGET
// =============================================================================
class _RestorableListenableDemo extends StatefulWidget {
  @override
  State<_RestorableListenableDemo> createState() => _RestorableListenableDemoState();
}

class _RestorableListenableDemoState extends State<_RestorableListenableDemo>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RestorableListenable Deep Dive'),
        backgroundColor: _kPrimary,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kTextSecondary,
          tabs: [
            Tab(icon: Icon(Icons.school), text: 'Theory'),
            Tab(icon: Icon(Icons.hearing), text: 'Listener Lab'),
            Tab(icon: Icon(Icons.account_tree), text: 'Hierarchy'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TheoryTab(),
          _ListenerLabTab(),
          _HierarchyTab(),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 1: THEORY
// =============================================================================
class _TheoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeroSection(),
          SizedBox(height: 24),
          _buildAbstractNatureSection(),
          SizedBox(height: 24),
          _buildListenablePatternSection(),
          SizedBox(height: 24),
          _buildAutoSubscriptionSection(),
          SizedBox(height: 24),
          _buildVsChangeNotifierSection(),
          SizedBox(height: 24),
          _buildImplementationRequirementsSection(),
          SizedBox(height: 24),
          _buildUseCasesSection(),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_kPrimary, _kPrimary.withOpacity(0.7)],
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
              Icon(Icons.hearing, color: _kAccent, size: 32),
              SizedBox(width: 12),
              Text(
                'RestorableListenable',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'An abstract base class for restorable properties that wrap Listenable objects. '
            'Auto-subscribes to the wrapped Listenable and triggers restoration updates '
            'whenever the Listenable notifies its listeners.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 15,
              height: 1.5,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _HeroBadge(icon: Icons.layers, label: 'Abstract'),
              SizedBox(width: 12),
              _HeroBadge(icon: Icons.hearing, label: 'Listenable'),
              SizedBox(width: 12),
              _HeroBadge(icon: Icons.sync, label: 'Auto-sync'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAbstractNatureSection() {
    return _TheoryCard(
      title: 'Abstract Class Nature',
      icon: Icons.layers,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RestorableListenable<T> is an abstract class that cannot be instantiated directly. '
            'You must extend it and implement the required methods:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kHierarchy.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'abstract class RestorableListenable<T extends Listenable>',
                  style: TextStyle(
                    color: _kHierarchy,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '    extends RestorableProperty<T>',
                  style: TextStyle(
                    color: _kTextSecondary,
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          _KeyPointRow(
            icon: Icons.block,
            text: 'Cannot create directly: new RestorableListenable() fails',
            color: _kWarning,
          ),
          SizedBox(height: 8),
          _KeyPointRow(
            icon: Icons.check_circle,
            text: 'Must subclass and implement T, fromPrimitives, toPrimitives',
            color: _kSuccess,
          ),
          SizedBox(height: 8),
          _KeyPointRow(
            icon: Icons.abc,
            text: 'Type parameter T must extend Listenable',
            color: _kMath,
          ),
        ],
      ),
    );
  }

  Widget _buildListenablePatternSection() {
    return _TheoryCard(
      title: 'The Listenable Pattern',
      icon: Icons.hearing,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Listenable is a core Flutter interface that objects implement to '
            'allow registration of callback listeners:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kAccent.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'abstract class Listenable {',
                  style: TextStyle(
                    color: _kAccent,
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
                Text(
                  '  void addListener(VoidCallback listener);',
                  style: TextStyle(
                    color: _kTextPrimary,
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
                Text(
                  '  void removeListener(VoidCallback listener);',
                  style: TextStyle(
                    color: _kTextPrimary,
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
                Text(
                  '}',
                  style: TextStyle(
                    color: _kAccent,
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Common Listenable implementations:',
            style: TextStyle(color: _kTextSecondary, fontSize: 13),
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _TypeChip('ChangeNotifier'),
              _TypeChip('ValueNotifier<T>'),
              _TypeChip('Animation<T>'),
              _TypeChip('AnimationController'),
              _TypeChip('ScrollController'),
              _TypeChip('TextEditingController'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAutoSubscriptionSection() {
    return _TheoryCard(
      title: 'Auto-Subscription Magic',
      icon: Icons.sync,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RestorableListenable automatically subscribes to the wrapped Listenable. '
            'When the Listenable notifies, RestorableListenable triggers a restoration update:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          _FlowStep(
            step: 1,
            title: 'Registration',
            desc: 'Property registered via registerForRestoration()',
          ),
          SizedBox(height: 8),
          _FlowStep(
            step: 2,
            title: 'initWithValue Called',
            desc: 'Adds notifyListeners() as listener to wrapped Listenable',
          ),
          SizedBox(height: 8),
          _FlowStep(
            step: 3,
            title: 'Listenable Changes',
            desc: 'Wrapped object calls its own notifyListeners()',
          ),
          SizedBox(height: 8),
          _FlowStep(
            step: 4,
            title: 'Restoration Sync',
            desc: 'RestorableListenable notifies RestorationMixin to save state',
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSuccess.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kSuccess.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.auto_fix_high, color: _kSuccess),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'The subscription is managed automatically - no manual listener setup needed!',
                    style: TextStyle(color: _kTextPrimary, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVsChangeNotifierSection() {
    return _TheoryCard(
      title: 'vs RestorableChangeNotifier',
      icon: Icons.compare_arrows,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RestorableChangeNotifier extends RestorableListenable with one key difference:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _kPrimary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _kPrimary.withOpacity(0.4)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'RestorableListenable',
                        style: TextStyle(
                          color: _kPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 8),
                      Icon(Icons.close, color: _kWarning, size: 24),
                      SizedBox(height: 4),
                      Text(
                        'Does NOT\nauto-dispose',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: _kTextSecondary, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _kSuccess.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _kSuccess.withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'RestorableChangeNotifier',
                        style: TextStyle(
                          color: _kSuccess,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 8),
                      Icon(Icons.check_circle, color: _kSuccess, size: 24),
                      SizedBox(height: 4),
                      Text(
                        'Auto-disposes\nwrapped object',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: _kTextSecondary, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kMath.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'When to use each:',
                  style: TextStyle(
                    color: _kMath,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '• RestorableListenable: Shared Listenable, external ownership',
                  style: TextStyle(color: _kTextPrimary, fontSize: 12),
                ),
                SizedBox(height: 4),
                Text(
                  '• RestorableChangeNotifier: Owned ChangeNotifier needing disposal',
                  style: TextStyle(color: _kTextPrimary, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImplementationRequirementsSection() {
    return _TheoryCard(
      title: 'Implementation Requirements',
      icon: Icons.build,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'To create a custom RestorableListenable subclass:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          _CodeSnippet(
            title: '1. createDefaultValue()',
            code: '@override\nT createDefaultValue() {\n  // Return fresh T instance\n  return MyListenable();\n}',
          ),
          SizedBox(height: 12),
          _CodeSnippet(
            title: '2. fromPrimitives(Object? data)',
            code: '@override\nT fromPrimitives(Object? data) {\n  // Deserialize from primitives\n  final map = data as Map;\n  return MyListenable.fromMap(map);\n}',
          ),
          SizedBox(height: 12),
          _CodeSnippet(
            title: '3. toPrimitives()',
            code: '@override\nObject? toPrimitives() {\n  // Serialize to primitives\n  return value.toMap();\n}',
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kWarning.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kWarning.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.warning, color: _kWarning),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Do NOT override dispose() in RestorableListenable subclasses - '
                    'the wrapped object is not owned and should not be disposed.',
                    style: TextStyle(color: _kTextPrimary, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUseCasesSection() {
    return _TheoryCard(
      title: 'Use Cases',
      icon: Icons.lightbulb,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _UseCaseItem(
            icon: Icons.animation,
            title: 'Animation Controllers',
            desc: 'Wrap AnimationController for progress restoration',
          ),
          SizedBox(height: 12),
          _UseCaseItem(
            icon: Icons.share,
            title: 'Shared Listenables',
            desc: 'Wrap Listenable provided by external dependency injection',
          ),
          SizedBox(height: 12),
          _UseCaseItem(
            icon: Icons.storage,
            title: 'State Management Integration',
            desc: 'Bridge reactive state objects with restoration system',
          ),
          SizedBox(height: 12),
          _UseCaseItem(
            icon: Icons.link,
            title: 'Multi-Widget Synchronized State',
            desc: 'Single Listenable restored and shared across widgets',
          ),
          SizedBox(height: 12),
          _UseCaseItem(
            icon: Icons.gamepad,
            title: 'Game State',
            desc: 'Game progress notifier with serializable state',
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 2: LISTENER LAB
// =============================================================================
class _ListenerLabTab extends StatefulWidget {
  @override
  State<_ListenerLabTab> createState() => _ListenerLabTabState();
}

class _ListenerLabTabState extends State<_ListenerLabTab> {
  final _CounterNotifier _counter = _CounterNotifier();
  final _LogNotifier _logNotifier = _LogNotifier();
  int _listenerCallCount = 0;
  bool _isListening = false;
  VoidCallback? _listener;

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  void _startListening() {
    if (_isListening) return;
    _listener = () {
      setState(() {
        _listenerCallCount++;
        _logNotifier.addLog(
          'Listener fired! Count now: ${_counter.count}',
        );
      });
    };
    _counter.addListener(_listener!);
    _isListening = true;
    _logNotifier.addLog('Listener attached to CounterNotifier');
  }

  void _stopListening() {
    if (!_isListening || _listener == null) return;
    _counter.removeListener(_listener!);
    _isListening = false;
    _logNotifier.addLog('Listener removed');
  }

  @override
  void dispose() {
    _stopListening();
    _counter.dispose();
    _logNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabHero(),
          SizedBox(height: 20),
          _buildCounterDisplay(),
          SizedBox(height: 20),
          _buildControlPanel(),
          SizedBox(height: 20),
          _buildListenerStatus(),
          SizedBox(height: 20),
          _buildNotificationLog(),
          SizedBox(height: 20),
          _buildListenerToggle(),
          SizedBox(height: 20),
          _buildSerializationDemo(),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildLabHero() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_kAccent.withOpacity(0.2), _kAccent.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kAccent.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.science, color: _kAccent, size: 28),
              SizedBox(width: 12),
              Text(
                'Listener Lab',
                style: TextStyle(
                  color: _kAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Interact with a ChangeNotifier and observe how listeners are notified. '
            'This simulates what RestorableListenable does internally: auto-subscribing '
            'to the wrapped Listenable and forwarding notifications.',
            style: TextStyle(color: _kTextPrimary, fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildCounterDisplay() {
    return ListenableBuilder(
      listenable: _counter,
      builder: (context, _) {
        return Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: _kCardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _kAccent.withOpacity(0.3),
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Text(
                'Counter Value',
                style: TextStyle(color: _kTextSecondary, fontSize: 14),
              ),
              SizedBox(height: 8),
              Text(
                '${_counter.count}',
                style: TextStyle(
                  color: _kAccent,
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                ),
              ),
              SizedBox(height: 8),
              Text(
                'ChangeNotifier state',
                style: TextStyle(color: _kTextSecondary, fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildControlPanel() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Control Counter',
            style: TextStyle(
              color: _kTextPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ControlButton(
                icon: Icons.remove,
                label: '-10',
                color: _kWarning,
                onTap: () => _counter.decrement(10),
              ),
              _ControlButton(
                icon: Icons.remove,
                label: '-1',
                color: _kWarning.withOpacity(0.7),
                onTap: () => _counter.decrement(1),
              ),
              _ControlButton(
                icon: Icons.refresh,
                label: 'Reset',
                color: _kTextSecondary,
                onTap: () => _counter.reset(),
              ),
              _ControlButton(
                icon: Icons.add,
                label: '+1',
                color: _kSuccess.withOpacity(0.7),
                onTap: () => _counter.increment(1),
              ),
              _ControlButton(
                icon: Icons.add,
                label: '+10',
                color: _kSuccess,
                onTap: () => _counter.increment(10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListenerStatus() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _isListening ? _kSuccess.withOpacity(0.1) : _kWarning.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isListening ? _kSuccess.withOpacity(0.3) : _kWarning.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            _isListening ? Icons.hearing : Icons.hearing_disabled,
            color: _isListening ? _kSuccess : _kWarning,
            size: 32,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isListening ? 'Listener Active' : 'Listener Detached',
                  style: TextStyle(
                    color: _isListening ? _kSuccess : _kWarning,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Listener callback invocations: $_listenerCallCount',
                  style: TextStyle(color: _kTextSecondary, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationLog() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notification Log',
                style: TextStyle(
                  color: _kTextPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _logNotifier.clear();
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _kSurface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Clear',
                    style: TextStyle(color: _kTextSecondary, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          ListenableBuilder(
            listenable: _logNotifier,
            builder: (context, _) {
              if (_logNotifier.logs.isEmpty) {
                return Container(
                  height: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _kSurface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'No notifications yet',
                    style: TextStyle(color: _kTextSecondary),
                  ),
                );
              }
              return Container(
                height: 160,
                decoration: BoxDecoration(
                  color: _kSurface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: _logNotifier.logs.length,
                  itemBuilder: (context, index) {
                    final log = _logNotifier.logs[_logNotifier.logs.length - 1 - index];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        '${_logNotifier.logs.length - index}. $log',
                        style: TextStyle(
                          color: log.contains('fired') ? _kAccent : _kTextSecondary,
                          fontFamily: 'monospace',
                          fontSize: 11,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListenerToggle() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Simulate Listener Lifecycle',
            style: TextStyle(
              color: _kTextPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'RestorableListenable manages listener lifecycle automatically. Here you can '
            'manually attach/detach to observe the effect.',
            style: TextStyle(color: _kTextSecondary, fontSize: 13),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _startListening();
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _isListening ? _kSuccess.withOpacity(0.2) : _kSuccess.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _isListening ? _kSuccess : _kSuccess.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.play_arrow, color: _kSuccess),
                        SizedBox(height: 4),
                        Text(
                          'Attach',
                          style: TextStyle(color: _kSuccess, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _stopListening();
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: !_isListening ? _kWarning.withOpacity(0.2) : _kWarning.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: !_isListening ? _kWarning : _kWarning.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.stop, color: _kWarning),
                        SizedBox(height: 4),
                        Text(
                          'Detach',
                          style: TextStyle(color: _kWarning, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kMath.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: _kMath, size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'When detached, counter changes won\'t trigger listener callbacks. '
                    'RestorableListenable handles this in initWithValue().',
                    style: TextStyle(color: _kTextPrimary, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSerializationDemo() {
    return ListenableBuilder(
      listenable: _counter,
      builder: (context, _) {
        final serialized = _counter.toPrimitives();
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kCardBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Serialization Preview',
                style: TextStyle(
                  color: _kTextPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'RestorableListenable subclasses implement toPrimitives() to serialize state:',
                style: TextStyle(color: _kTextSecondary, fontSize: 13),
              ),
              SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _kSurface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _kAccent.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'toPrimitives() =>',
                      style: TextStyle(
                        color: _kTextSecondary,
                        fontFamily: 'monospace',
                        fontSize: 11,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      serialized.toString(),
                      style: TextStyle(
                        color: _kAccent,
                        fontFamily: 'monospace',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// =============================================================================
// TAB 3: HIERARCHY
// =============================================================================
class _HierarchyTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHierarchyHero(),
          SizedBox(height: 24),
          _buildFullHierarchy(),
          SizedBox(height: 24),
          _buildListenableChain(),
          SizedBox(height: 24),
          _buildConcreteImplementations(),
          SizedBox(height: 24),
          _buildWhenToExtend(),
          SizedBox(height: 24),
          _buildRelatedClasses(),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildHierarchyHero() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_kHierarchy.withOpacity(0.2), _kHierarchy.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kHierarchy.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_tree, color: _kHierarchy, size: 28),
              SizedBox(width: 12),
              Text(
                'Class Hierarchy',
                style: TextStyle(
                  color: _kHierarchy,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Explore where RestorableListenable fits in Flutter\'s restoration hierarchy. '
            'Understanding the inheritance chain helps choose the right base class.',
            style: TextStyle(color: _kTextPrimary, fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildFullHierarchy() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Inheritance Chain',
            style: TextStyle(
              color: _kTextPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          _HierarchyNode(
            name: 'ChangeNotifier',
            desc: 'Base notification mixin',
            level: 0,
            isAbstract: false,
          ),
          _HierarchyNode(
            name: 'RestorableProperty<T>',
            desc: 'Root of restorable properties',
            level: 1,
            isAbstract: true,
          ),
          _HierarchyNode(
            name: 'RestorableListenable<T>',
            desc: 'Wraps Listenable objects',
            level: 2,
            isAbstract: true,
            isHighlighted: true,
          ),
          _HierarchyNode(
            name: 'RestorableChangeNotifier<T>',
            desc: 'Auto-disposes ChangeNotifier',
            level: 3,
            isAbstract: true,
          ),
          _HierarchyNode(
            name: 'RestorableTextEditingController',
            desc: 'Concrete text controller',
            level: 4,
            isAbstract: false,
          ),
        ],
      ),
    );
  }

  Widget _buildListenableChain() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The Listenable Chain',
            style: TextStyle(
              color: _kTextPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _ChainBox(
                title: 'Your Listenable',
                desc: 'Wrapped object',
                color: _kMath,
              ),
              _ChainArrow(),
              _ChainBox(
                title: 'Restorable\nListenable',
                desc: 'Auto-subscribes',
                color: _kHierarchy,
              ),
              _ChainArrow(),
              _ChainBox(
                title: 'Restoration\nMixin',
                desc: 'Saves state',
                color: _kAccent,
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'When your Listenable calls notifyListeners(), RestorableListenable '
              'receives the callback and forwards it to RestorationMixin, which '
              'then triggers toPrimitives() to save current state.',
              style: TextStyle(color: _kTextSecondary, fontSize: 12, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConcreteImplementations() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Framework Implementations',
            style: TextStyle(
              color: _kTextPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Flutter provides one concrete subclass of RestorableListenable:',
            style: TextStyle(color: _kTextSecondary, fontSize: 13),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kSuccess.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kSuccess.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.text_fields, color: _kSuccess, size: 24),
                    SizedBox(width: 12),
                    Text(
                      'RestorableTextEditingController',
                      style: TextStyle(
                        color: _kSuccess,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  'Extends RestorableChangeNotifier (which extends RestorableListenable). '
                  'Wraps a TextEditingController and restores text/selection state.',
                  style: TextStyle(color: _kTextPrimary, fontSize: 12, height: 1.5),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kMath.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: _kMath, size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'For custom Listenables, you create your own subclass.',
                    style: TextStyle(color: _kTextPrimary, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhenToExtend() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'When to Extend Which',
            style: TextStyle(
              color: _kTextPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          _DecisionRow(
            scenario: 'Own ChangeNotifier that should be disposed',
            recommendation: 'RestorableChangeNotifier',
            color: _kSuccess,
          ),
          SizedBox(height: 8),
          _DecisionRow(
            scenario: 'Shared/external Listenable (no auto-dispose)',
            recommendation: 'RestorableListenable',
            color: _kHierarchy,
          ),
          SizedBox(height: 8),
          _DecisionRow(
            scenario: 'Simple value (int, bool, String)',
            recommendation: 'RestorableValue subclasses',
            color: _kMath,
          ),
          SizedBox(height: 8),
          _DecisionRow(
            scenario: 'Route future with return value',
            recommendation: 'RestorableRouteFuture',
            color: _kWarning,
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedClasses() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Related Classes',
            style: TextStyle(
              color: _kTextPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _RelatedChip('RestorableProperty', 'Parent class'),
              _RelatedChip('RestorableChangeNotifier', 'Child class'),
              _RelatedChip('RestorableTextEditingController', 'Concrete'),
              _RelatedChip('RestorationMixin', 'Consumer'),
              _RelatedChip('RestorationBucket', 'Storage'),
              _RelatedChip('Listenable', 'Interface'),
              _RelatedChip('ChangeNotifier', 'Implementation'),
              _RelatedChip('ListenableBuilder', 'Consumer widget'),
            ],
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// HELPER WIDGETS
// =============================================================================

class _HeroBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  const _HeroBadge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 14),
          SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _TheoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  const _TheoryCard({required this.title, required this.icon, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: _kAccent, size: 20),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  color: _kTextPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _KeyPointRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  const _KeyPointRow({required this.icon, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: _kTextPrimary, fontSize: 13),
          ),
        ),
      ],
    );
  }
}

class _TypeChip extends StatelessWidget {
  final String name;
  const _TypeChip(this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kDivider),
      ),
      child: Text(
        name,
        style: TextStyle(
          color: _kTextPrimary,
          fontFamily: 'monospace',
          fontSize: 11,
        ),
      ),
    );
  }
}

class _FlowStep extends StatelessWidget {
  final int step;
  final String title;
  final String desc;
  const _FlowStep({required this.step, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: _kAccent,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$step',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: _kTextPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              SizedBox(height: 2),
              Text(
                desc,
                style: TextStyle(color: _kTextSecondary, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CodeSnippet extends StatelessWidget {
  final String title;
  final String code;
  const _CodeSnippet({required this.title, required this.code});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: _kAccent,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kSurface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            code,
            style: TextStyle(
              color: _kTextPrimary,
              fontFamily: 'monospace',
              fontSize: 10,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

class _UseCaseItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  const _UseCaseItem({required this.icon, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kPrimary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _kPrimary, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: _kTextPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 2),
              Text(
                desc,
                style: TextStyle(color: _kTextSecondary, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _ControlButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 18),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(color: color, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

class _HierarchyNode extends StatelessWidget {
  final String name;
  final String desc;
  final int level;
  final bool isAbstract;
  final bool isHighlighted;
  const _HierarchyNode({
    required this.name,
    required this.desc,
    required this.level,
    required this.isAbstract,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: level * 16.0, top: 8, bottom: 8),
      child: Row(
        children: [
          if (level > 0) ...[
            Container(
              width: 16,
              height: 2,
              color: _kDivider,
            ),
          ],
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isHighlighted ? _kHierarchy.withOpacity(0.2) : _kSurface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isHighlighted ? _kHierarchy : _kDivider,
                width: isHighlighted ? 2 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isAbstract)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: _kWarning.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'abstract',
                      style: TextStyle(
                        color: _kWarning,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                if (isAbstract) SizedBox(width: 6),
                Text(
                  name,
                  style: TextStyle(
                    color: isHighlighted ? _kHierarchy : _kTextPrimary,
                    fontFamily: 'monospace',
                    fontSize: 11,
                    fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          Text(
            desc,
            style: TextStyle(color: _kTextSecondary, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class _ChainBox extends StatelessWidget {
  final String title;
  final String desc;
  final Color color;
  const _ChainBox({required this.title, required this.desc, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              desc,
              style: TextStyle(color: _kTextSecondary, fontSize: 9),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChainArrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Icon(Icons.arrow_forward, color: _kDivider, size: 16),
    );
  }
}

class _DecisionRow extends StatelessWidget {
  final String scenario;
  final String recommendation;
  final Color color;
  const _DecisionRow({
    required this.scenario,
    required this.recommendation,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              scenario,
              style: TextStyle(color: _kTextPrimary, fontSize: 12),
            ),
          ),
          SizedBox(width: 12),
          Icon(Icons.arrow_forward, color: _kDivider, size: 16),
          SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                recommendation,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RelatedChip extends StatelessWidget {
  final String name;
  final String role;
  const _RelatedChip(this.name, this.role);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kDivider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: TextStyle(
              color: _kTextPrimary,
              fontFamily: 'monospace',
              fontSize: 10,
            ),
          ),
          SizedBox(width: 6),
          Text(
            '($role)',
            style: TextStyle(color: _kTextSecondary, fontSize: 9),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// MOCK LISTENABLE CLASSES FOR LAB
// =============================================================================

/// A simple ChangeNotifier that counts and can serialize
class _CounterNotifier extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment(int amount) {
    _count += amount;
    notifyListeners();
  }

  void decrement(int amount) {
    _count -= amount;
    notifyListeners();
  }

  void reset() {
    _count = 0;
    notifyListeners();
  }

  /// Simulates toPrimitives() from RestorableListenable
  Map<String, dynamic> toPrimitives() {
    return {'count': _count};
  }
}

/// Tracks log entries for the notification log
class _LogNotifier extends ChangeNotifier {
  final List<String> _logs = [];
  List<String> get logs => List.unmodifiable(_logs);

  void addLog(String message) {
    _logs.add(message);
    if (_logs.length > 50) _logs.removeAt(0);
    notifyListeners();
  }

  void clear() {
    _logs.clear();
    notifyListeners();
  }
}

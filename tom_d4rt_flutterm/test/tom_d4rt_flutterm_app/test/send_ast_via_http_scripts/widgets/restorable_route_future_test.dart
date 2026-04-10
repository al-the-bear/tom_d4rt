// Deep visual test for RestorableRouteFuture
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, unintended_html_in_doc_comment

import 'package:flutter/material.dart';

/// Deep visual exploration of RestorableRouteFuture
/// A RestorableProperty that manages route navigation and result futures.
///
/// RestorableRouteFuture<T> provides:
/// - State-restoration-aware route pushing
/// - Automatic re-attachment of onComplete callbacks after restoration
/// - Route lifecycle management through the restoration system
///
/// Essential for dialogs, pickers, and navigation with return values.
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF171728),
    ),
    home: _RestorableRouteFutureDemo(),
  );
}

// =============================================================================
// PALETTE: Indigo A200 / Teal A400
// =============================================================================
const Color _kPrimary = Color(0xFF536DFE); // Indigo A200
const Color _kAccent = Color(0xFF1DE9B6); // Teal A400
const Color _kSurface = Color(0xFF222240);
const Color _kCardBg = Color(0xFF2A2A4E);
const Color _kTextPrimary = Color(0xFFE8E8F0);
const Color _kTextSecondary = Color(0xFFB0B0C8);
const Color _kDivider = Color(0xFF3A3A5C);
const Color _kSuccess = Color(0xFF66BB6A);
const Color _kWarning = Color(0xFFFF7043);
const Color _kRoute = Color(0xFFFFD740);
const Color _kCallback = Color(0xFFE040FB);
const Color _kNavigator = Color(0xFF42A5F5);
const Color _kRestore = Color(0xFF26C6DA);

// =============================================================================
// MAIN DEMO WIDGET
// =============================================================================
class _RestorableRouteFutureDemo extends StatefulWidget {
  @override
  State<_RestorableRouteFutureDemo> createState() => _RestorableRouteFutureDemoState();
}

class _RestorableRouteFutureDemoState extends State<_RestorableRouteFutureDemo>
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
        title: Text('RestorableRouteFuture Deep Dive'),
        backgroundColor: _kPrimary.withOpacity(0.85),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kTextSecondary,
          tabs: [
            Tab(icon: Icon(Icons.school), text: 'Theory'),
            Tab(icon: Icon(Icons.route), text: 'Flow Lab'),
            Tab(icon: Icon(Icons.pattern), text: 'Patterns'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TheoryTab(),
          _FlowLabTab(),
          _PatternsTab(),
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
          _buildConstructorSection(),
          SizedBox(height: 24),
          _buildCallbacksSection(),
          SizedBox(height: 24),
          _buildKeyMethodsSection(),
          SizedBox(height: 24),
          _buildRestorationMechanism(),
          SizedBox(height: 24),
          _buildComparisonSection(),
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
          colors: [_kPrimary, _kPrimary.withOpacity(0.6)],
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
              Icon(Icons.route, color: _kAccent, size: 32),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'RestorableRouteFuture<T>',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Manages navigation routes that return values, with full state restoration. '
            'When the app is killed and restored, the route is found by its restoration '
            'scope ID and the onComplete callback is re-attached.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _HeroBadge(icon: Icons.navigation, label: 'Routes'),
              SizedBox(width: 12),
              _HeroBadge(icon: Icons.reply, label: 'Results'),
              SizedBox(width: 12),
              _HeroBadge(icon: Icons.restore, label: 'Restorable'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConstructorSection() {
    return _TheoryCard(
      title: 'Constructor',
      icon: Icons.build,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RestorableRouteFuture takes three parameters:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          _ParamCard(
            name: 'onPresent',
            type: 'RoutePresentationCallback',
            desc: 'Required. Called to push the route onto the navigator. '
                'Must use a restorable push method (e.g., restorablePush) '
                'so the route gets a restoration scope ID.',
            color: _kCallback,
            isRequired: true,
          ),
          SizedBox(height: 10),
          _ParamCard(
            name: 'onComplete',
            type: 'RouteCompletionCallback<T>?',
            desc: 'Optional. Called when the route pops and returns a value. '
                'This callback is re-attached after restoration, so the '
                'result is never lost.',
            color: _kAccent,
            isRequired: false,
          ),
          SizedBox(height: 10),
          _ParamCard(
            name: 'navigatorFinder',
            type: 'NavigatorFinderCallback',
            desc: 'Optional. Finds the Navigator from context. Defaults to '
                'Navigator.of(context). Override for nested navigators.',
            color: _kNavigator,
            isRequired: false,
          ),
        ],
      ),
    );
  }

  Widget _buildCallbacksSection() {
    return _TheoryCard(
      title: 'Callback Types',
      icon: Icons.call_made,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CallbackType(
            name: 'RoutePresentationCallback',
            signature: 'String Function(NavigatorState, Object?)',
            desc: 'Receives navigator + optional arguments. Must return '
                'the route\'s restoration ID (from restorablePush).',
            color: _kCallback,
          ),
          SizedBox(height: 12),
          _CallbackType(
            name: 'RouteCompletionCallback<T>',
            signature: 'void Function(T result)',
            desc: 'Called with the route\'s return value when it pops. '
                'Runs both on initial completion and after restoration.',
            color: _kAccent,
          ),
          SizedBox(height: 12),
          _CallbackType(
            name: 'NavigatorFinderCallback',
            signature: 'NavigatorState Function(BuildContext)',
            desc: 'Locates the Navigator to use when pushing routes. '
                'Default: Navigator.of(context).',
            color: _kNavigator,
          ),
        ],
      ),
    );
  }

  Widget _buildKeyMethodsSection() {
    return _TheoryCard(
      title: 'Key API',
      icon: Icons.api,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ApiItem(
            name: 'present([Object? arguments])',
            desc: 'Triggers onPresent to push the route. Pass optional arguments '
                'that the route builder can read.',
            returnType: 'void',
            color: _kPrimary,
          ),
          SizedBox(height: 10),
          _ApiItem(
            name: 'isPresent',
            desc: 'Whether a route is currently being shown (pushed but not yet popped).',
            returnType: 'bool',
            color: _kRoute,
          ),
          SizedBox(height: 10),
          _ApiItem(
            name: 'route',
            desc: 'The currently-active Route object, or null if no route is present.',
            returnType: 'Route<T>?',
            color: _kNavigator,
          ),
          SizedBox(height: 10),
          _ApiItem(
            name: 'enabled',
            desc: 'Returns false when no route is active (nothing to restore).',
            returnType: 'bool',
            color: _kSuccess,
          ),
        ],
      ),
    );
  }

  Widget _buildRestorationMechanism() {
    return _TheoryCard(
      title: 'Restoration Mechanism',
      icon: Icons.restore,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How route restoration works under the hood:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          _MechanismStep(
            num: 1,
            title: 'Store Route ID',
            desc: 'When present() is called, the route\'s restorationScopeId is stored '
                'via toPrimitives(). This is a String?.',
            color: _kRoute,
          ),
          SizedBox(height: 8),
          _MechanismStep(
            num: 2,
            title: 'App Killed / Restored',
            desc: 'System kills and later restores the app. The restoration framework '
                're-creates the Navigator and its routes.',
            color: _kRestore,
          ),
          SizedBox(height: 8),
          _MechanismStep(
            num: 3,
            title: 'Find Route by ID',
            desc: 'fromPrimitives() receives the stored route ID. The framework '
                'locates the matching route in the navigator stack.',
            color: _kNavigator,
          ),
          SizedBox(height: 8),
          _MechanismStep(
            num: 4,
            title: 'Re-Attach Callback',
            desc: 'onComplete is re-hooked to the restored route so when it '
                'eventually pops, the result flows back to the original State.',
            color: _kCallback,
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonSection() {
    return _TheoryCard(
      title: 'RestorableRouteFuture vs Regular Push',
      icon: Icons.compare_arrows,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _kSuccess.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _kSuccess.withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.check_circle, color: _kSuccess, size: 24),
                      SizedBox(height: 6),
                      Text(
                        'RestorableRouteFuture',
                        style: TextStyle(color: _kSuccess, fontSize: 10, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text('Route survives kill', style: TextStyle(color: _kTextSecondary, fontSize: 9)),
                      Text('Result delivered', style: TextStyle(color: _kTextSecondary, fontSize: 9)),
                      Text('State preserved', style: TextStyle(color: _kTextSecondary, fontSize: 9)),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _kWarning.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _kWarning.withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.cancel, color: _kWarning, size: 24),
                      SizedBox(height: 6),
                      Text(
                        'Navigator.push()',
                        style: TextStyle(color: _kWarning, fontSize: 10, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text('Route lost on kill', style: TextStyle(color: _kTextSecondary, fontSize: 9)),
                      Text('Result lost', style: TextStyle(color: _kTextSecondary, fontSize: 9)),
                      Text('State reset', style: TextStyle(color: _kTextSecondary, fontSize: 9)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 2: FLOW LAB
// =============================================================================
class _FlowLabTab extends StatefulWidget {
  @override
  State<_FlowLabTab> createState() => _FlowLabTabState();
}

class _FlowLabTabState extends State<_FlowLabTab> {
  int _currentStep = 0;
  String _lastResult = '(none)';
  bool _isRoutePresent = false;
  int _routeCount = 0;

  final List<_FlowStep> _steps = [
    _FlowStep(
      title: 'Idle',
      desc: 'No route is active',
      icon: Icons.radio_button_unchecked,
      color: _kTextSecondary,
    ),
    _FlowStep(
      title: 'present() called',
      desc: 'onPresent pushes route with restorablePush',
      icon: Icons.play_circle,
      color: _kPrimary,
    ),
    _FlowStep(
      title: 'Route Active',
      desc: 'isPresent = true, route is on the navigator stack',
      icon: Icons.fiber_manual_record,
      color: _kRoute,
    ),
    _FlowStep(
      title: 'User Interacts',
      desc: 'User fills form, picks option, etc.',
      icon: Icons.touch_app,
      color: _kAccent,
    ),
    _FlowStep(
      title: 'Route Pops',
      desc: 'Route completes with a result value',
      icon: Icons.call_received,
      color: _kCallback,
    ),
    _FlowStep(
      title: 'onComplete Fires',
      desc: 'Result is delivered to the originating State',
      icon: Icons.done_all,
      color: _kSuccess,
    ),
  ];

  void _simulatePresent() {
    setState(() {
      _currentStep = 2;
      _isRoutePresent = true;
      _routeCount++;
    });
  }

  void _simulateComplete(String result) {
    setState(() {
      _currentStep = 5;
      _isRoutePresent = false;
      _lastResult = result;
    });
  }

  void _resetFlow() {
    setState(() {
      _currentStep = 0;
      _isRoutePresent = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFlowHero(),
          SizedBox(height: 20),
          _buildStepTimeline(),
          SizedBox(height: 20),
          _buildSimulationControls(),
          SizedBox(height: 20),
          _buildStatusPanel(),
          SizedBox(height: 20),
          _buildResultHistory(),
          SizedBox(height: 20),
          _buildRestorationScenario(),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildFlowHero() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_kRoute.withOpacity(0.2), _kRoute.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kRoute.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.route, color: _kRoute, size: 28),
              SizedBox(width: 12),
              Text(
                'Flow Lab',
                style: TextStyle(
                  color: _kRoute,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Simulate the RestorableRouteFuture lifecycle step by step. '
            'Watch how the route is presented, active, and completes with a result.',
            style: TextStyle(color: _kTextPrimary, fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildStepTimeline() {
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
            'Route Lifecycle',
            style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          ..._steps.asMap().entries.map((entry) {
            final i = entry.key;
            final step = entry.value;
            final isActive = i == _currentStep;
            final isPast = i < _currentStep;
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: isActive
                          ? step.color.withOpacity(0.3)
                          : isPast
                              ? _kSuccess.withOpacity(0.15)
                              : _kSurface,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isActive ? step.color : isPast ? _kSuccess : _kDivider,
                        width: isActive ? 2 : 1,
                      ),
                    ),
                    child: Icon(
                      isActive ? step.icon : isPast ? Icons.check : Icons.circle_outlined,
                      color: isActive ? step.color : isPast ? _kSuccess : _kDivider,
                      size: 14,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step.title,
                          style: TextStyle(
                            color: isActive ? step.color : isPast ? _kTextPrimary : _kTextSecondary,
                            fontSize: 13,
                            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        if (isActive)
                          Text(
                            step.desc,
                            style: TextStyle(color: _kTextSecondary, fontSize: 10),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSimulationControls() {
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
            'Simulation Controls',
            style: TextStyle(color: _kTextPrimary, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: _isRoutePresent ? null : _simulatePresent,
                  child: Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: _isRoutePresent
                          ? _kDivider.withOpacity(0.3)
                          : _kPrimary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: _isRoutePresent ? _kDivider : _kPrimary.withOpacity(0.4),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.open_in_new, color: _isRoutePresent ? _kDivider : _kPrimary),
                        SizedBox(height: 4),
                        Text(
                          'present()',
                          style: TextStyle(
                            color: _isRoutePresent ? _kDivider : _kPrimary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: _isRoutePresent ? () => _simulateComplete('OK') : null,
                  child: Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: !_isRoutePresent
                          ? _kDivider.withOpacity(0.3)
                          : _kSuccess.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: !_isRoutePresent ? _kDivider : _kSuccess.withOpacity(0.4),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.done, color: !_isRoutePresent ? _kDivider : _kSuccess),
                        SizedBox(height: 4),
                        Text(
                          'Complete OK',
                          style: TextStyle(
                            color: !_isRoutePresent ? _kDivider : _kSuccess,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: _isRoutePresent ? () => _simulateComplete('Cancel') : null,
                  child: Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: !_isRoutePresent
                          ? _kDivider.withOpacity(0.3)
                          : _kWarning.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: !_isRoutePresent ? _kDivider : _kWarning.withOpacity(0.4),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.close, color: !_isRoutePresent ? _kDivider : _kWarning),
                        SizedBox(height: 4),
                        Text(
                          'Cancel',
                          style: TextStyle(
                            color: !_isRoutePresent ? _kDivider : _kWarning,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Center(
            child: GestureDetector(
              onTap: _resetFlow,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: _kSurface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('Reset', style: TextStyle(color: _kTextSecondary, fontSize: 12)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusPanel() {
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
            'Property Status',
            style: TextStyle(color: _kTextPrimary, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          _StatusRow(label: 'isPresent', value: '$_isRoutePresent', color: _isRoutePresent ? _kRoute : _kTextSecondary),
          _StatusRow(label: 'lastResult', value: _lastResult, color: _kAccent),
          _StatusRow(label: 'routeCount', value: '$_routeCount', color: _kPrimary),
          _StatusRow(label: 'enabled', value: '$_isRoutePresent', color: _isRoutePresent ? _kSuccess : _kTextSecondary),
          _StatusRow(label: 'currentStep', value: _steps[_currentStep].title, color: _steps[_currentStep].color),
        ],
      ),
    );
  }

  Widget _buildResultHistory() {
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
            'Result Delivery',
            style: TextStyle(color: _kTextPrimary, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.call_received, color: _kCallback, size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'onComplete callback:',
                        style: TextStyle(color: _kCallback, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        _lastResult == '(none)'
                            ? 'No route has completed yet'
                            : 'Received result: "$_lastResult"',
                        style: TextStyle(color: _kTextPrimary, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Text(
            'The onComplete callback fires after the route pops, delivering '
            'the return value. This works even after state restoration.',
            style: TextStyle(color: _kTextSecondary, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildRestorationScenario() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kRestore.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kRestore.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.restore, color: _kRestore, size: 20),
              SizedBox(width: 8),
              Text(
                'Restoration Scenario',
                style: TextStyle(color: _kRestore, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 12),
          _ScenarioStep(num: 1, text: 'User opens dialog via present()'),
          _ScenarioStep(num: 2, text: 'Android kills app (low memory)'),
          _ScenarioStep(num: 3, text: 'User reopens app → restoration'),
          _ScenarioStep(num: 4, text: 'Dialog appears again (restored)'),
          _ScenarioStep(num: 5, text: 'User closes dialog → onComplete fires'),
          _ScenarioStep(num: 6, text: 'Original State receives result'),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 3: PATTERNS
// =============================================================================
class _PatternsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPatternsHero(),
          SizedBox(height: 24),
          _buildDialogPattern(),
          SizedBox(height: 16),
          _buildFormPattern(),
          SizedBox(height: 16),
          _buildPickerPattern(),
          SizedBox(height: 24),
          _buildBestPractices(),
          SizedBox(height: 24),
          _buildPitfalls(),
          SizedBox(height: 24),
          _buildRelatedClasses(),
          SizedBox(height: 24),
          _buildDecisionGuide(),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildPatternsHero() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_kCallback.withOpacity(0.2), _kCallback.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kCallback.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.pattern, color: _kCallback, size: 28),
              SizedBox(width: 12),
              Text(
                'Common Patterns',
                style: TextStyle(
                  color: _kCallback,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Real-world usage patterns for RestorableRouteFuture, '
            'best practices, and common pitfalls to avoid.',
            style: TextStyle(color: _kTextPrimary, fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogPattern() {
    return _PatternCard(
      title: 'Dialog Result Pattern',
      icon: Icons.chat_bubble,
      color: _kPrimary,
      scenario: 'Show a confirmation dialog that returns true/false',
      steps: [
        'Declare RestorableRouteFuture<bool> field',
        'In onPresent: use navigator.restorablePush(dialogRoute)',
        'In onComplete: handle confirmed/cancelled',
        'Call present() when user taps a button',
      ],
      typeParam: 'bool',
    );
  }

  Widget _buildFormPattern() {
    return _PatternCard(
      title: 'Form Submission Pattern',
      icon: Icons.edit_note,
      color: _kAccent,
      scenario: 'Push a form screen that returns the submitted data',
      steps: [
        'Declare RestorableRouteFuture<Map<String, dynamic>> field',
        'In onPresent: push form page with restorablePushNamed',
        'In onComplete: process submitted data',
        'Arguments can pass initial data to the form',
      ],
      typeParam: 'Map<String, dynamic>',
    );
  }

  Widget _buildPickerPattern() {
    return _PatternCard(
      title: 'Picker Pattern',
      icon: Icons.color_lens,
      color: _kRoute,
      scenario: 'Open a color/file/date picker that returns the selection',
      steps: [
        'Declare RestorableRouteFuture<Color> or similar',
        'In onPresent: push picker route',
        'In onComplete: update state with selected value',
        'Picker remembers selection if app is restored',
      ],
      typeParam: 'Color',
    );
  }

  Widget _buildBestPractices() {
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
            children: [
              Icon(Icons.verified, color: _kSuccess, size: 20),
              SizedBox(width: 8),
              Text(
                'Best Practices',
                style: TextStyle(color: _kSuccess, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 16),
          _BestPractice(
            title: 'Always use restorable push methods',
            desc: 'restorablePush, restorablePushNamed, etc. Regular push '
                'methods don\'t generate restoration scope IDs.',
            icon: Icons.check_circle,
          ),
          SizedBox(height: 10),
          _BestPractice(
            title: 'Use static route builders',
            desc: 'Route builders passed to restorablePush must be static or '
                'top-level functions—not closures or instance methods.',
            icon: Icons.check_circle,
          ),
          SizedBox(height: 10),
          _BestPractice(
            title: 'Register in restoreState()',
            desc: 'Like all RestorableProperty, register via '
                'registerForRestoration() in the restoreState() override.',
            icon: Icons.check_circle,
          ),
          SizedBox(height: 10),
          _BestPractice(
            title: 'Handle null results',
            desc: 'Routes may pop with null (e.g., back button). Your onComplete '
                'should handle T being nullable or use a non-null default.',
            icon: Icons.check_circle,
          ),
        ],
      ),
    );
  }

  Widget _buildPitfalls() {
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
            children: [
              Icon(Icons.warning, color: _kWarning, size: 20),
              SizedBox(width: 8),
              Text(
                'Common Pitfalls',
                style: TextStyle(color: _kWarning, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 16),
          _PitfallItem(
            title: 'Calling present() when already present',
            desc: 'Throws if isPresent is already true. Check before calling.',
          ),
          SizedBox(height: 8),
          _PitfallItem(
            title: 'Using Navigator.push instead of restorablePush',
            desc: 'Route won\'t have a restoration ID and can\'t be restored.',
          ),
          SizedBox(height: 8),
          _PitfallItem(
            title: 'Closure route builders',
            desc: 'Non-static route builders can\'t be re-invoked after restoration.',
          ),
          SizedBox(height: 8),
          _PitfallItem(
            title: 'Forgetting navigatorFinder',
            desc: 'With nested navigators, the default Navigator.of(context) '
                'may find the wrong navigator.',
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
            style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _RelatedChip('RestorableProperty', 'Parent class'),
              _RelatedChip('RestorationMixin', 'Registration host'),
              _RelatedChip('Navigator', 'Route stack'),
              _RelatedChip('Route<T>', 'Route object'),
              _RelatedChip('RestorationScope', 'Scope provider'),
              _RelatedChip('RestorationBucket', 'Data storage'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDecisionGuide() {
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
            'When to Use RestorableRouteFuture',
            style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          _DecisionRow(
            scenario: 'Dialog returns a value',
            use: true,
            note: 'Confirmation, selection, input',
          ),
          SizedBox(height: 6),
          _DecisionRow(
            scenario: 'Navigation with return data',
            use: true,
            note: 'Form submit, picker, detail edit',
          ),
          SizedBox(height: 6),
          _DecisionRow(
            scenario: 'Multi-step wizard',
            use: true,
            note: 'Each step returns partial data',
          ),
          SizedBox(height: 6),
          _DecisionRow(
            scenario: 'Fire-and-forget navigation',
            use: false,
            note: 'Use Navigator.push instead',
          ),
          SizedBox(height: 6),
          _DecisionRow(
            scenario: 'No restoration needed',
            use: false,
            note: 'Use async Navigator.push',
          ),
          SizedBox(height: 6),
          _DecisionRow(
            scenario: 'Bottom sheets, snackbars',
            use: false,
            note: 'Not standard Route-based',
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// HELPER WIDGETS
// =============================================================================

class _FlowStep {
  final String title;
  final String desc;
  final IconData icon;
  final Color color;
  const _FlowStep({
    required this.title,
    required this.desc,
    required this.icon,
    required this.color,
  });
}

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
          Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
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
              Icon(icon, color: _kPrimary, size: 20),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
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

class _ParamCard extends StatelessWidget {
  final String name;
  final String type;
  final String desc;
  final Color color;
  final bool isRequired;
  const _ParamCard({
    required this.name,
    required this.type,
    required this.desc,
    required this.color,
    required this.isRequired,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                name,
                style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13),
              ),
              Spacer(),
              if (isRequired)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: _kWarning.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text('REQUIRED', style: TextStyle(color: _kWarning, fontSize: 8, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
          SizedBox(height: 4),
          Text(type, style: TextStyle(color: _kTextSecondary, fontFamily: 'monospace', fontSize: 10)),
          SizedBox(height: 6),
          Text(desc, style: TextStyle(color: _kTextPrimary, fontSize: 11, height: 1.3)),
        ],
      ),
    );
  }
}

class _CallbackType extends StatelessWidget {
  final String name;
  final String signature;
  final String desc;
  final Color color;
  const _CallbackType({required this.name, required this.signature, required this.desc, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
          SizedBox(height: 4),
          Text(signature, style: TextStyle(color: _kAccent, fontFamily: 'monospace', fontSize: 10)),
          SizedBox(height: 6),
          Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 11, height: 1.3)),
        ],
      ),
    );
  }
}

class _ApiItem extends StatelessWidget {
  final String name;
  final String desc;
  final String returnType;
  final Color color;
  const _ApiItem({required this.name, required this.desc, required this.returnType, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 10, height: 1.3)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(returnType, style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 9)),
          ),
        ],
      ),
    );
  }
}

class _MechanismStep extends StatelessWidget {
  final int num;
  final String title;
  final String desc;
  final Color color;
  const _MechanismStep({required this.num, required this.title, required this.desc, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
            child: Text('$num', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
              Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 10, height: 1.3)),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatusRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _StatusRow({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: TextStyle(color: _kTextSecondary, fontFamily: 'monospace', fontSize: 11)),
          ),
          Text(value, style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _ScenarioStep extends StatelessWidget {
  final int num;
  final String text;
  const _ScenarioStep({required this.num, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(color: _kRestore.withOpacity(0.3), shape: BoxShape.circle),
            child: Center(
              child: Text('$num', style: TextStyle(color: _kRestore, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(width: 10),
          Text(text, style: TextStyle(color: _kTextPrimary, fontSize: 12)),
        ],
      ),
    );
  }
}

class _PatternCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String scenario;
  final List<String> steps;
  final String typeParam;
  const _PatternCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.scenario,
    required this.steps,
    required this.typeParam,
  });

  @override
  Widget build(BuildContext context) {
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
            children: [
              Icon(icon, color: color, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _kSurface,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text('<$typeParam>', style: TextStyle(color: _kTextSecondary, fontFamily: 'monospace', fontSize: 9)),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(scenario, style: TextStyle(color: _kTextPrimary, fontSize: 12)),
          SizedBox(height: 12),
          ...steps.asMap().entries.map((e) => Padding(
            padding: EdgeInsets.symmetric(vertical: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${e.key + 1}.',
                  style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(e.value, style: TextStyle(color: _kTextSecondary, fontSize: 11)),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _BestPractice extends StatelessWidget {
  final String title;
  final String desc;
  final IconData icon;
  const _BestPractice({required this.title, required this.desc, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kSuccess.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: _kSuccess, size: 16),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: _kTextPrimary, fontSize: 12, fontWeight: FontWeight.w600)),
                SizedBox(height: 2),
                Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 10, height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PitfallItem extends StatelessWidget {
  final String title;
  final String desc;
  const _PitfallItem({required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kWarning.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kWarning.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber, color: _kWarning, size: 16),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: _kTextPrimary, fontSize: 12, fontWeight: FontWeight.w600)),
                SizedBox(height: 2),
                Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 10, height: 1.3)),
              ],
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
          Text(name, style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 10)),
          SizedBox(width: 6),
          Text('($role)', style: TextStyle(color: _kTextSecondary, fontSize: 9)),
        ],
      ),
    );
  }
}

class _DecisionRow extends StatelessWidget {
  final String scenario;
  final bool use;
  final String note;
  const _DecisionRow({required this.scenario, required this.use, required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: use ? _kSuccess.withOpacity(0.06) : _kSurface,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(
            use ? Icons.check_circle : Icons.remove_circle,
            color: use ? _kSuccess : _kTextSecondary,
            size: 16,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(scenario, style: TextStyle(color: _kTextPrimary, fontSize: 11)),
          ),
          Text(note, style: TextStyle(color: _kTextSecondary, fontSize: 9)),
        ],
      ),
    );
  }
}

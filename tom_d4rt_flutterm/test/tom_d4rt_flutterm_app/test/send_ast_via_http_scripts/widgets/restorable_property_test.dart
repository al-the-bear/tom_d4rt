// Deep visual test for RestorableProperty
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, unintended_html_in_doc_comment

import 'package:flutter/material.dart';

/// Deep visual exploration of RestorableProperty
/// The abstract base class for ALL restorable properties in Flutter.
///
/// RestorableProperty<T> provides:
/// - Serialization/deserialization contract via toPrimitives/fromPrimitives
/// - ChangeNotifier integration for automatic restoration updates
/// - Registration lifecycle with RestorationMixin
///
/// Every restorable type stems from this root.
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF1B1233),
    ),
    home: _RestorablePropertyDemo(),
  );
}

// =============================================================================
// PALETTE: Amber 700 / Blue A200
// =============================================================================
const Color _kPrimary = Color(0xFFFFA000); // Amber 700
const Color _kAccent = Color(0xFF448AFF); // Blue A200
const Color _kSurface = Color(0xFF242040);
const Color _kCardBg = Color(0xFF2E2950);
const Color _kTextPrimary = Color(0xFFE8E8F0);
const Color _kTextSecondary = Color(0xFFB0B0C8);
const Color _kDivider = Color(0xFF3A3658);
const Color _kSuccess = Color(0xFF66BB6A);
const Color _kWarning = Color(0xFFFF7043);
const Color _kAbstract = Color(0xFFAB47BC);
const Color _kConcrete = Color(0xFF26C6DA);
const Color _kNotifier = Color(0xFFEF5350);
const Color _kLifecycle = Color(0xFF9CCC65);

// =============================================================================
// MAIN DEMO WIDGET
// =============================================================================
class _RestorablePropertyDemo extends StatefulWidget {
  @override
  State<_RestorablePropertyDemo> createState() => _RestorablePropertyDemoState();
}

class _RestorablePropertyDemoState extends State<_RestorablePropertyDemo>
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
        title: Text('RestorableProperty Deep Dive'),
        backgroundColor: _kPrimary.withOpacity(0.85),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kTextSecondary,
          tabs: [
            Tab(icon: Icon(Icons.school), text: 'Contract'),
            Tab(icon: Icon(Icons.timeline), text: 'Lifecycle'),
            Tab(icon: Icon(Icons.grid_view), text: 'Catalog'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _ContractTab(),
          _LifecycleTab(),
          _CatalogTab(),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 1: CONTRACT
// =============================================================================
class _ContractTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeroSection(),
          SizedBox(height: 24),
          _buildAbstractMethods(),
          SizedBox(height: 24),
          _buildConcreteProperties(),
          SizedBox(height: 24),
          _buildChangeNotifierSection(),
          SizedBox(height: 24),
          _buildEnabledProperty(),
          SizedBox(height: 24),
          _buildTypeParameterSection(),
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
              Icon(Icons.foundation, color: Colors.white, size: 32),
              SizedBox(width: 12),
              Text(
                'RestorableProperty<T>',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'The abstract foundation for Flutter\'s state restoration system. '
            'Every restorable value—int, double, bool, string, enum, controller—'
            'inherits from this class.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 15,
              height: 1.5,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _HeroBadge(icon: Icons.architecture, label: 'Abstract'),
              SizedBox(width: 12),
              _HeroBadge(icon: Icons.notifications, label: 'Notifier'),
              SizedBox(width: 12),
              _HeroBadge(icon: Icons.code, label: 'Contract'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAbstractMethods() {
    return _ContractCard(
      title: 'Abstract Methods',
      icon: Icons.code,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Every RestorableProperty must implement these four methods:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          _MethodCard(
            name: 'T createDefaultValue()',
            desc: 'Returns the default value when no restoration data exists. '
                'Called once during initialization.',
            color: _kAbstract,
            icon: Icons.add_box,
          ),
          SizedBox(height: 10),
          _MethodCard(
            name: 'T fromPrimitives(Object? data)',
            desc: 'Deserializes restoration data back into T. The inverse of '
                'toPrimitives().',
            color: _kAccent,
            icon: Icons.download,
          ),
          SizedBox(height: 10),
          _MethodCard(
            name: 'void initWithValue(T value)',
            desc: 'Initializes property with a restored or default value. '
                'Called after createDefaultValue() or fromPrimitives().',
            color: _kSuccess,
            icon: Icons.play_arrow,
          ),
          SizedBox(height: 10),
          _MethodCard(
            name: 'Object? toPrimitives()',
            desc: 'Serializes the current value for storage. Must produce '
                'data consumable by fromPrimitives().',
            color: _kWarning,
            icon: Icons.upload,
          ),
        ],
      ),
    );
  }

  Widget _buildConcreteProperties() {
    return _ContractCard(
      title: 'Concrete Properties',
      icon: Icons.settings,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PropertyRow(
            name: 'bool get enabled',
            desc: 'If false, property is excluded from serialization',
            defaultVal: 'true',
          ),
          _PropertyRow(
            name: 'bool get isRegistered',
            desc: 'True after registration with RestorationMixin',
            defaultVal: 'dynamic',
          ),
          _PropertyRow(
            name: 'State get state',
            desc: 'The State this property is registered with',
            defaultVal: 'throws if unregistered',
          ),
        ],
      ),
    );
  }

  Widget _buildChangeNotifierSection() {
    return _ContractCard(
      title: 'ChangeNotifier Heritage',
      icon: Icons.notifications_active,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RestorableProperty extends ChangeNotifier, which means:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _NotifierFeature(
                  icon: Icons.add_alert,
                  title: 'addListener(callback)',
                  desc: 'Register for value change notifications',
                ),
                SizedBox(height: 10),
                _NotifierFeature(
                  icon: Icons.remove_circle,
                  title: 'removeListener(callback)',
                  desc: 'Unsubscribe from notifications',
                ),
                SizedBox(height: 10),
                _NotifierFeature(
                  icon: Icons.campaign,
                  title: 'notifyListeners()',
                  desc: 'Dispatch change to all subscribers',
                ),
                SizedBox(height: 10),
                _NotifierFeature(
                  icon: Icons.delete,
                  title: 'dispose()',
                  desc: 'Release resources and detach listeners',
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kNotifier.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: _kNotifier, size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'RestorationMixin automatically listens for notifications '
                    'and re-serializes the property when it changes.',
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

  Widget _buildEnabledProperty() {
    return _ContractCard(
      title: 'The enabled Property',
      icon: Icons.toggle_on,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Controls whether a property participates in restoration:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _kSuccess.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _kSuccess.withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.check_circle, color: _kSuccess, size: 28),
                      SizedBox(height: 8),
                      Text(
                        'enabled = true',
                        style: TextStyle(color: _kSuccess, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Value is serialized\nand restored',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: _kTextSecondary, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _kWarning.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _kWarning.withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.cancel, color: _kWarning, size: 28),
                      SizedBox(height: 8),
                      Text(
                        'enabled = false',
                        style: TextStyle(color: _kWarning, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Value is NOT\nserialized',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: _kTextSecondary, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Override enabled to conditionally skip serialization of certain properties.',
            style: TextStyle(color: _kTextSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeParameterSection() {
    return _ContractCard(
      title: 'Type Parameter T',
      icon: Icons.data_object,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'T represents the restorable value type. No constraints by default—'
            'subclasses refine it:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          _TypeConstraintRow(
            cls: 'RestorableProperty<T>',
            constraint: 'T (any)',
            color: _kPrimary,
          ),
          SizedBox(height: 6),
          _TypeConstraintRow(
            cls: 'RestorableValue<T>',
            constraint: 'T (any)',
            color: _kAccent,
          ),
          SizedBox(height: 6),
          _TypeConstraintRow(
            cls: 'RestorableNum<T>',
            constraint: 'T extends num',
            color: _kSuccess,
          ),
          SizedBox(height: 6),
          _TypeConstraintRow(
            cls: 'RestorableEnum<T>',
            constraint: 'T extends Enum',
            color: _kAbstract,
          ),
          SizedBox(height: 6),
          _TypeConstraintRow(
            cls: 'RestorableRouteFuture<T>',
            constraint: 'T (route result)',
            color: _kConcrete,
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 2: LIFECYCLE
// =============================================================================
class _LifecycleTab extends StatefulWidget {
  @override
  State<_LifecycleTab> createState() => _LifecycleTabState();
}

class _LifecycleTabState extends State<_LifecycleTab> {
  int _currentPhase = 0;
  final List<_Phase> _phases = [
    _Phase(
      title: 'Creation',
      desc: 'RestorableProperty instance is created with a default value.',
      icon: Icons.create_new_folder,
      color: _kPrimary,
      detail: 'The property exists but is not yet connected to any State. '
          'It holds its default value in memory.',
    ),
    _Phase(
      title: 'Registration',
      desc: 'registerForRestoration() in RestorationMixin binds the property.',
      icon: Icons.app_registration,
      color: _kAccent,
      detail: 'RestorationMixin calls registerForRestoration(property, "restorationId"). '
          'The property is now tracked and will be included in restoration data.',
    ),
    _Phase(
      title: 'Initialization',
      desc: 'Property receives its value (restored or default).',
      icon: Icons.play_arrow,
      color: _kSuccess,
      detail: 'If restoration data exists, fromPrimitives() is called. '
          'Otherwise, createDefaultValue() provides the initial value. '
          'Then initWithValue() completes setup.',
    ),
    _Phase(
      title: 'Active',
      desc: 'Property is in use—value changes trigger serialization.',
      icon: Icons.fiber_manual_record,
      color: _kLifecycle,
      detail: 'Any change triggers notifyListeners(), which causes '
          'RestorationMixin to re-serialize via toPrimitives(). '
          'The encoded data is stored by the restoration framework.',
    ),
    _Phase(
      title: 'Serialization',
      desc: 'System requests state data—toPrimitives() is called.',
      icon: Icons.save,
      color: _kWarning,
      detail: 'When the system needs to save state (e.g., app going to background), '
          'it calls toPrimitives() on all registered properties. '
          'The returned data must be a primitive type.',
    ),
    _Phase(
      title: 'Disposal',
      desc: 'Property is disposed when State is removed from tree.',
      icon: Icons.delete_forever,
      color: _kNotifier,
      detail: 'RestorationMixin calls dispose() on all registered properties. '
          'This releases listeners and notifier resources. '
          'The property must not be used after disposal.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLifecycleHero(),
          SizedBox(height: 24),
          _buildPhaseSelector(),
          SizedBox(height: 16),
          _buildPhaseDetail(),
          SizedBox(height: 24),
          _buildSequenceDiagram(),
          SizedBox(height: 24),
          _buildRegistrationFlow(),
          SizedBox(height: 24),
          _buildSerializationRoundtrip(),
          SizedBox(height: 24),
          _buildErrorScenarios(),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildLifecycleHero() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_kLifecycle.withOpacity(0.2), _kLifecycle.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kLifecycle.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.timeline, color: _kLifecycle, size: 28),
              SizedBox(width: 12),
              Text(
                'Lifecycle',
                style: TextStyle(
                  color: _kLifecycle,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Walk through the complete lifecycle of a RestorableProperty, '
            'from creation to disposal, including all framework interactions.',
            style: TextStyle(color: _kTextPrimary, fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildPhaseSelector() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tap a phase to explore:',
            style: TextStyle(color: _kTextSecondary, fontSize: 12),
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(_phases.length, (i) {
              final phase = _phases[i];
              final isSelected = i == _currentPhase;
              return GestureDetector(
                onTap: () => setState(() => _currentPhase = i),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? phase.color.withOpacity(0.2) : _kSurface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? phase.color : _kDivider,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(phase.icon, color: phase.color, size: 16),
                      SizedBox(width: 6),
                      Text(
                        phase.title,
                        style: TextStyle(
                          color: isSelected ? phase.color : _kTextPrimary,
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildPhaseDetail() {
    final phase = _phases[_currentPhase];
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: phase.color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: phase.color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: phase.color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(phase.icon, color: phase.color, size: 24),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Phase ${_currentPhase + 1}: ${phase.title}',
                      style: TextStyle(
                        color: phase.color,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      phase.desc,
                      style: TextStyle(color: _kTextSecondary, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            phase.detail,
            style: TextStyle(color: _kTextPrimary, fontSize: 13, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildSequenceDiagram() {
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
            'Restoration Sequence',
            style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          _SequenceStep(num: 1, actor: 'State', action: 'creates RestorableProperty', color: _kPrimary),
          _SequenceArrow(),
          _SequenceStep(num: 2, actor: 'Mixin', action: 'registerForRestoration()', color: _kAccent),
          _SequenceArrow(),
          _SequenceStep(num: 3, actor: 'Framework', action: 'checks for saved data', color: _kLifecycle),
          _SequenceArrow(),
          _SequenceStep(num: 4, actor: 'Property', action: 'fromPrimitives() or default', color: _kSuccess),
          _SequenceArrow(),
          _SequenceStep(num: 5, actor: 'Property', action: 'initWithValue(value)', color: _kSuccess),
          _SequenceArrow(),
          _SequenceStep(num: 6, actor: 'User', action: 'modifies value', color: _kConcrete),
          _SequenceArrow(),
          _SequenceStep(num: 7, actor: 'Property', action: 'notifyListeners()', color: _kWarning),
          _SequenceArrow(),
          _SequenceStep(num: 8, actor: 'Mixin', action: 'toPrimitives() → save', color: _kNotifier),
        ],
      ),
    );
  }

  Widget _buildRegistrationFlow() {
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
            'Registration Requirements',
            style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          _RequirementRow(
            icon: Icons.key,
            title: 'Unique restorationId',
            desc: 'Each property must have a unique ID within its State',
            isRequired: true,
          ),
          SizedBox(height: 8),
          _RequirementRow(
            icon: Icons.account_tree,
            title: 'RestorationMixin on State',
            desc: 'The State must mix in RestorationMixin',
            isRequired: true,
          ),
          SizedBox(height: 8),
          _RequirementRow(
            icon: Icons.label,
            title: 'Widget\'s restorationId',
            desc: 'The widget\'s restorationId must be non-null',
            isRequired: true,
          ),
          SizedBox(height: 8),
          _RequirementRow(
            icon: Icons.restore,
            title: 'restoreState() override',
            desc: 'Registration happens inside restoreState()',
            isRequired: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSerializationRoundtrip() {
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
            'Serialization Roundtrip',
            style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _RoundtripNode(label: 'T value', color: _kPrimary),
                    Icon(Icons.arrow_forward, color: _kDivider),
                    _RoundtripNode(label: 'toPrimitives()', color: _kWarning),
                    Icon(Icons.arrow_forward, color: _kDivider),
                    _RoundtripNode(label: 'Object?', color: _kNotifier),
                  ],
                ),
                SizedBox(height: 16),
                Container(height: 1, color: _kDivider),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _RoundtripNode(label: 'T value', color: _kPrimary),
                    Icon(Icons.arrow_back, color: _kDivider),
                    _RoundtripNode(label: 'fromPrimitives()', color: _kSuccess),
                    Icon(Icons.arrow_back, color: _kDivider),
                    _RoundtripNode(label: 'Object?', color: _kNotifier),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Data must survive the roundtrip: fromPrimitives(toPrimitives()) should '
            'yield an equivalent value.',
            style: TextStyle(color: _kTextSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorScenarios() {
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
            'Common Mistakes',
            style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          _MistakeCard(
            title: 'Missing Registration',
            desc: 'Accessing .state before registerForRestoration() throws',
            severity: 'Error',
            severityColor: _kNotifier,
          ),
          SizedBox(height: 8),
          _MistakeCard(
            title: 'Duplicate ID',
            desc: 'Two properties with the same restorationId within one State',
            severity: 'Error',
            severityColor: _kNotifier,
          ),
          SizedBox(height: 8),
          _MistakeCard(
            title: 'Not Disposed',
            desc: 'Forgetting to dispose properties in State.dispose()',
            severity: 'Leak',
            severityColor: _kWarning,
          ),
          SizedBox(height: 8),
          _MistakeCard(
            title: 'Wrong Primitives',
            desc: 'toPrimitives() returning non-serializable types',
            severity: 'Error',
            severityColor: _kNotifier,
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 3: CATALOG
// =============================================================================
class _CatalogTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCatalogHero(),
          SizedBox(height: 24),
          _buildHierarchyTree(),
          SizedBox(height: 24),
          _buildPrimitivesCategory(),
          SizedBox(height: 16),
          _buildNumericCategory(),
          SizedBox(height: 16),
          _buildEnumCategory(),
          SizedBox(height: 16),
          _buildControllersCategory(),
          SizedBox(height: 16),
          _buildNavigationCategory(),
          SizedBox(height: 24),
          _buildCountSummary(),
          SizedBox(height: 24),
          _buildCheatSheet(),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildCatalogHero() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_kAccent.withOpacity(0.25), _kAccent.withOpacity(0.05)],
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
              Icon(Icons.grid_view, color: _kAccent, size: 28),
              SizedBox(width: 12),
              Text(
                'Complete Catalog',
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
            'Every built-in RestorableProperty subclass in Flutter, organized '
            'by category. All stem from the abstract RestorableProperty<T> root.',
            style: TextStyle(color: _kTextPrimary, fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildHierarchyTree() {
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
            'Hierarchy Overview',
            style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          _TreeNode(name: 'RestorableProperty<T>', level: 0, color: _kPrimary, isRoot: true),
          _TreeNode(name: 'RestorableValue<T>', level: 1, color: _kAccent),
          _TreeNode(name: '_RestorablePrimitiveValueN<T>', level: 2, color: _kTextSecondary, isPrivate: true),
          _TreeNode(name: 'RestorableBoolN', level: 3, color: _kConcrete),
          _TreeNode(name: 'RestorableStringN', level: 3, color: _kConcrete),
          _TreeNode(name: 'RestorableDateTimeN', level: 3, color: _kConcrete),
          _TreeNode(name: 'RestorableNumN<T>', level: 3, color: _kConcrete),
          _TreeNode(name: '_RestorablePrimitiveValue<T>', level: 2, color: _kTextSecondary, isPrivate: true),
          _TreeNode(name: 'RestorableBool', level: 3, color: _kSuccess),
          _TreeNode(name: 'RestorableString', level: 3, color: _kSuccess),
          _TreeNode(name: 'RestorableDateTime', level: 3, color: _kSuccess),
          _TreeNode(name: 'RestorableNum<T>', level: 3, color: _kSuccess),
          _TreeNode(name: 'RestorableListenable<T>', level: 1, color: _kAbstract),
          _TreeNode(name: 'RestorableChangeNotifier<T>', level: 2, color: _kAbstract),
          _TreeNode(name: 'RestorableTextEditingController', level: 3, color: _kAbstract),
          _TreeNode(name: 'RestorableRouteFuture<T>', level: 1, color: _kWarning),
          _TreeNode(name: 'RestorableEnum<T>', level: 1, color: _kNotifier),
          _TreeNode(name: 'RestorableEnumN<T>', level: 1, color: _kNotifier),
        ],
      ),
    );
  }

  Widget _buildPrimitivesCategory() {
    return _CategoryCard(
      title: 'Primitives',
      icon: Icons.text_fields,
      color: _kSuccess,
      items: [
        _CatalogItem('RestorableBool', 'bool', 'Checkboxes, toggles'),
        _CatalogItem('RestorableBoolN', 'bool?', 'Tristate checkboxes'),
        _CatalogItem('RestorableString', 'String', 'Text fields, labels'),
        _CatalogItem('RestorableStringN', 'String?', 'Optional text input'),
        _CatalogItem('RestorableDateTime', 'DateTime', 'Date pickers'),
        _CatalogItem('RestorableDateTimeN', 'DateTime?', 'Optional dates'),
      ],
    );
  }

  Widget _buildNumericCategory() {
    return _CategoryCard(
      title: 'Numerics',
      icon: Icons.numbers,
      color: _kAccent,
      items: [
        _CatalogItem('RestorableNum<T>', 'num', 'Generic numeric base'),
        _CatalogItem('RestorableNumN<T>', 'num?', 'Nullable numeric base'),
        _CatalogItem('RestorableInt', 'int', 'Counters, indices'),
        _CatalogItem('RestorableIntN', 'int?', 'Optional ints'),
        _CatalogItem('RestorableDouble', 'double', 'Sliders, ratings'),
        _CatalogItem('RestorableDoubleN', 'double?', 'Optional doubles'),
      ],
    );
  }

  Widget _buildEnumCategory() {
    return _CategoryCard(
      title: 'Enums',
      icon: Icons.list_alt,
      color: _kAbstract,
      items: [
        _CatalogItem('RestorableEnum<T>', 'Enum', 'Segmented buttons, state'),
        _CatalogItem('RestorableEnumN<T>', 'Enum?', 'Nullable enums'),
      ],
    );
  }

  Widget _buildControllersCategory() {
    return _CategoryCard(
      title: 'Controllers',
      icon: Icons.gamepad,
      color: _kWarning,
      items: [
        _CatalogItem('RestorableTextEditingController', 'TextEditingController', 'Text field state'),
      ],
    );
  }

  Widget _buildNavigationCategory() {
    return _CategoryCard(
      title: 'Navigation',
      icon: Icons.navigation,
      color: _kNotifier,
      items: [
        _CatalogItem('RestorableRouteFuture<T>', 'Route result', 'Route push/pop results'),
      ],
    );
  }

  Widget _buildCountSummary() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kPrimary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kPrimary.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _SummaryCount(count: 16, label: 'Total Classes', color: _kPrimary),
          Container(width: 1, height: 40, color: _kDivider),
          _SummaryCount(count: 8, label: 'Non-Null', color: _kSuccess),
          Container(width: 1, height: 40, color: _kDivider),
          _SummaryCount(count: 5, label: 'Nullable', color: _kWarning),
          Container(width: 1, height: 40, color: _kDivider),
          _SummaryCount(count: 3, label: 'Special', color: _kAbstract),
        ],
      ),
    );
  }

  Widget _buildCheatSheet() {
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
            'Quick Reference',
            style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          _CheatRow(scenario: 'Simple int counter', answer: 'RestorableInt'),
          _CheatRow(scenario: 'Slider value', answer: 'RestorableDouble'),
          _CheatRow(scenario: 'Toggle / switch', answer: 'RestorableBool'),
          _CheatRow(scenario: 'Text field', answer: 'RestorableTextEditingController'),
          _CheatRow(scenario: 'Date picker', answer: 'RestorableDateTime'),
          _CheatRow(scenario: 'Tab / segment', answer: 'RestorableEnum'),
          _CheatRow(scenario: 'Optional field', answer: 'Use N-suffix variant'),
          _CheatRow(scenario: 'Dialog result', answer: 'RestorableRouteFuture'),
          _CheatRow(scenario: 'Custom object', answer: 'Extend RestorableProperty'),
        ],
      ),
    );
  }
}

// =============================================================================
// HELPER WIDGETS
// =============================================================================

class _Phase {
  final String title;
  final String desc;
  final IconData icon;
  final Color color;
  final String detail;
  const _Phase({
    required this.title,
    required this.desc,
    required this.icon,
    required this.color,
    required this.detail,
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

class _ContractCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  const _ContractCard({required this.title, required this.icon, required this.child});

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

class _MethodCard extends StatelessWidget {
  final String name;
  final String desc;
  final Color color;
  final IconData icon;
  const _MethodCard({required this.name, required this.desc, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 11, height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PropertyRow extends StatelessWidget {
  final String name;
  final String desc;
  final String defaultVal;
  const _PropertyRow({required this.name, required this.desc, required this.defaultVal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(color: _kAccent, fontFamily: 'monospace', fontSize: 10)),
                Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(defaultVal, style: TextStyle(color: _kTextPrimary, fontSize: 9)),
          ),
        ],
      ),
    );
  }
}

class _NotifierFeature extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  const _NotifierFeature({required this.icon, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: _kNotifier, size: 18),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 11)),
              Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
            ],
          ),
        ),
      ],
    );
  }
}

class _TypeConstraintRow extends StatelessWidget {
  final String cls;
  final String constraint;
  final Color color;
  const _TypeConstraintRow({required this.cls, required this.constraint, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 4, height: 20, color: color),
        SizedBox(width: 8),
        Expanded(
          child: Text(cls, style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 10)),
        ),
        Text(constraint, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
      ],
    );
  }
}

class _SequenceStep extends StatelessWidget {
  final int num;
  final String actor;
  final String action;
  final Color color;
  const _SequenceStep({required this.num, required this.actor, required this.action, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
            child: Text(
              '$num',
              style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(width: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(actor, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(action, style: TextStyle(color: _kTextPrimary, fontSize: 11)),
        ),
      ],
    );
  }
}

class _SequenceArrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 11, top: 2, bottom: 2),
      child: Container(width: 2, height: 12, color: _kDivider),
    );
  }
}

class _RequirementRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  final bool isRequired;
  const _RequirementRow({required this.icon, required this.title, required this.desc, required this.isRequired});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: isRequired ? _kWarning : _kTextSecondary, size: 18),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: _kTextPrimary, fontSize: 12, fontWeight: FontWeight.w600)),
                Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
              ],
            ),
          ),
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
    );
  }
}

class _RoundtripNode extends StatelessWidget {
  final String label;
  final Color color;
  const _RoundtripNode({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 9, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _MistakeCard extends StatelessWidget {
  final String title;
  final String desc;
  final String severity;
  final Color severityColor;
  const _MistakeCard({required this.title, required this.desc, required this.severity, required this.severityColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: severityColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: severityColor.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: severityColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(severity, style: TextStyle(color: severityColor, fontSize: 9, fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: _kTextPrimary, fontSize: 12, fontWeight: FontWeight.w600)),
                Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TreeNode extends StatelessWidget {
  final String name;
  final int level;
  final Color color;
  final bool isRoot;
  final bool isPrivate;
  const _TreeNode({
    required this.name,
    required this.level,
    required this.color,
    this.isRoot = false,
    this.isPrivate = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: level * 12.0, top: 3, bottom: 3),
      child: Row(
        children: [
          if (!isRoot) Container(width: 8, height: 1, color: _kDivider),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: isRoot ? color.withOpacity(0.2) : _kSurface,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: isRoot ? color : _kDivider),
            ),
            child: Text(
              name,
              style: TextStyle(
                color: isPrivate ? _kTextSecondary : color,
                fontFamily: 'monospace',
                fontSize: 9,
                fontStyle: isPrivate ? FontStyle.italic : FontStyle.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CatalogItem {
  final String name;
  final String type;
  final String useCase;
  const _CatalogItem(this.name, this.type, this.useCase);
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final List<_CatalogItem> items;
  const _CategoryCard({required this.title, required this.icon, required this.color, required this.items});

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
              Text(
                title,
                style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${items.length}',
                  style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          ...items.map((item) => Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    item.name,
                    style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 10),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    item.type,
                    style: TextStyle(color: color, fontSize: 9),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    item.useCase,
                    style: TextStyle(color: _kTextSecondary, fontSize: 9),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _SummaryCount extends StatelessWidget {
  final int count;
  final String label;
  final Color color;
  const _SummaryCount({required this.count, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$count',
          style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(label, style: TextStyle(color: _kTextSecondary, fontSize: 9)),
      ],
    );
  }
}

class _CheatRow extends StatelessWidget {
  final String scenario;
  final String answer;
  const _CheatRow({required this.scenario, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(Icons.arrow_right, color: _kDivider, size: 16),
          Expanded(
            child: Text(scenario, style: TextStyle(color: _kTextPrimary, fontSize: 11)),
          ),
          Text(
            answer,
            style: TextStyle(color: _kAccent, fontFamily: 'monospace', fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

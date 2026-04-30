// ignore_for_file: avoid_print
// D4rt deep demo: InheritedModelElement — the Element behind InheritedModel
// that enables fine-grained dependency tracking via "aspects". Unlike plain
// InheritedWidget which always notifies all dependents, InheritedModel only
// rebuilds dependents whose specific aspects actually changed.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Slate / Graphite palette ───
  const Color slate = Color(0xFF475569);
  const Color graphite = Color(0xFF334155);
  const Color deepSlate = Color(0xFF1E293B);
  const Color paleCloud = Color(0xFFF1F5F9);
  const Color steel = Color(0xFF64748B);
  const Color mist = Color(0xFFCBD5E1);
  const Color charcoal = Color(0xFF0F172A);
  const Color silver = Color(0xFF94A3B8);
  const Color pewter = Color(0xFFE2E8F0);
  const Color iron = Color(0xFF334155);

  print('===== INHERITED MODEL ELEMENT DEEP DEMO =====');

  // ─── Local helpers ───

  Widget sectionBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [charcoal, deepSlate],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: charcoal.withValues(alpha: 0.35),
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
              color: slate,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: silver, width: 1.5),
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

  Widget noteBox(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paleCloud,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: mist),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: deepSlate.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget infoCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: mist),
        boxShadow: [
          BoxShadow(
            color: slate.withValues(alpha: 0.07),
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
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
            decoration: BoxDecoration(
              color: paleCloud,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: charcoal)),
          ),
          Padding(padding: const EdgeInsets.all(12), child: content),
        ],
      ),
    );
  }

  Widget tag(String label, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label,
          style:
              TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
    );
  }

  Widget dataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: charcoal)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 12, color: deepSlate)),
          ),
        ],
      ),
    );
  }

  Widget colorSwatch(String name, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: charcoal.withValues(alpha: 0.15), width: 1),
            ),
          ),
          const SizedBox(height: 4),
          Text(name,
              style: TextStyle(fontSize: 9, color: charcoal),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget progressBar(String label, double fraction, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: TextStyle(fontSize: 11, color: charcoal)),
              Text('${(fraction * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: color)),
            ],
          ),
          const SizedBox(height: 3),
          Container(
            width: double.infinity,
            height: 7,
            decoration: BoxDecoration(
              color: silver.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(3.5),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: fraction.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget aspectChip(String label, bool active, Color activeColor) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: active ? activeColor.withValues(alpha: 0.15) : pewter,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: active ? activeColor : silver,
            width: active ? 2 : 1),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 11,
              fontWeight: active ? FontWeight.w700 : FontWeight.normal,
              color: active ? activeColor : steel)),
    );
  }

  Widget dependentWidget(String name, List<String> aspects, bool rebuilds, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: rebuilds ? color.withValues(alpha: 0.08) : Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
            color: rebuilds ? color : mist,
            width: rebuilds ? 2 : 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                rebuilds ? Icons.refresh : Icons.check_circle_outline,
                size: 14,
                color: rebuilds ? color : silver,
              ),
              const SizedBox(width: 6),
              Text(name,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: rebuilds ? color : steel)),
              const Spacer(),
              Text(rebuilds ? 'REBUILDS' : 'skipped',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: rebuilds ? color : silver)),
            ],
          ),
          const SizedBox(height: 4),
          Wrap(
            children: aspects
                .map((a) => aspectChip(a, rebuilds, color))
                .toList(),
          ),
        ],
      ),
    );
  }

  // ─── Section 1: Overview ───
  print('[Section 1] Overview');

  final section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('01', 'Overview & Purpose'),
      noteBox(
          'InheritedModelElement is the Element counterpart of InheritedModel. '
          'It extends InheritedElement to add aspect-based dependency '
          'tracking. When an InheritedModel changes, only dependents '
          'that declared interest in changed aspects are rebuilt — unlike '
          'InheritedWidget which rebuilds all dependents.'),
      infoCard(
          'Core Identity',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Type', 'InheritedElement subclass'),
              dataRow('Package', 'flutter/widgets'),
              dataRow('Widget pair', 'InheritedModel<T>'),
              dataRow('Key feature', 'Aspect-based selective rebuild'),
              dataRow('Performance', 'Avoids unnecessary rebuilds'),
            ],
          )),
      infoCard(
          'InheritedWidget vs InheritedModel',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('InheritedWidget', 'All dependents rebuild on change'),
              dataRow('InheritedModel', 'Only aspect-matched dependents'),
              dataRow('InheritedElement', 'No aspect awareness'),
              dataRow('InheritedModelElement', 'Tracks aspects per dependent'),
            ],
          )),
    ],
  );

  // ─── Section 2: What Are Aspects ───
  print('[Section 2] What Are Aspects');

  final section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('02', 'What Are Aspects'),
      noteBox(
          'An "aspect" is any value (typically an enum or string) that '
          'identifies a specific part of the model data. When a widget '
          'subscribes to an InheritedModel, it declares which aspects '
          'it cares about. Only changes to those aspects trigger rebuilds.'),
      infoCard(
          'Aspect Example: User Profile',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  aspectChip('name', true, slate),
                  aspectChip('email', false, slate),
                  aspectChip('avatar', false, slate),
                  aspectChip('theme', true, slate),
                  aspectChip('locale', false, slate),
                ],
              ),
              const SizedBox(height: 8),
              dataRow('Widget: NameDisplay', 'Depends on [name]'),
              dataRow('Widget: AvatarIcon', 'Depends on [avatar]'),
              dataRow('Widget: ThemeSwitch', 'Depends on [theme]'),
              const SizedBox(height: 4),
              dataRow('If name changes', 'Only NameDisplay rebuilds'),
              dataRow('If avatar changes', 'Only AvatarIcon rebuilds'),
              dataRow('ThemeSwitch', 'Untouched by name/avatar changes'),
            ],
          )),
    ],
  );

  // ─── Section 3: Dependency Registration ───
  print('[Section 3] Dependency Registration');

  final section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('03', 'Dependency Registration'),
      noteBox(
          'When a widget calls InheritedModel.inheritFrom<T>(context, '
          'aspect: anAspect), the InheritedModelElement records that '
          'this dependent needs rebuild only when that aspect changes.'),
      infoCard(
          'Registration Flow',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('1. Widget builds', 'Calls inheritFrom with aspect'),
              dataRow('2. Element records', 'dependent → {aspect} mapping'),
              dataRow('3. Model changes', 'Element checks each dependent'),
              dataRow('4. Aspect match?', 'Yes → rebuild, No → skip'),
            ],
          )),
      infoCard(
          'Null Aspect',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('inheritFrom(aspect: null)', 'Depends on everything'),
              dataRow('Any change', 'This dependent always rebuilds'),
              dataRow('Same as', 'InheritedWidget behavior'),
              dataRow('Use case', 'Widget needs the whole model'),
            ],
          )),
      infoCard(
          'Multiple Aspects',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Call inheritFrom twice', 'Two aspects registered'),
              dataRow('Widget depends on', '{name, email} for example'),
              dataRow('Either changes', 'Widget rebuilds'),
              dataRow('Other changes', 'Widget skipped'),
            ],
          )),
    ],
  );

  // ─── Section 4: Selective Rebuild Visualization ───
  print('[Section 4] Selective Rebuild');

  final section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('04', 'Selective Rebuild Visualization'),
      noteBox(
          'This visualizes what happens when specific aspects change. '
          'Notice how only widgets whose aspects match get rebuilt.'),
      infoCard(
          'Scenario: "name" Aspect Changes',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: deepSlate.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Icon(Icons.published_with_changes, size: 16, color: slate),
                    const SizedBox(width: 6),
                    Text('Changed aspect: name',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: slate)),
                  ],
                ),
              ),
              dependentWidget('NameDisplay', ['name'], true, slate),
              dependentWidget('AvatarIcon', ['avatar'], false, slate),
              dependentWidget('ThemeSwitch', ['theme'], false, slate),
              dependentWidget('FullProfile', ['name', 'email', 'avatar'], true, slate),
              dependentWidget('LocaleLabel', ['locale'], false, slate),
            ],
          )),
      infoCard(
          'Scenario: "theme" Aspect Changes',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: graphite.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Icon(Icons.published_with_changes, size: 16, color: graphite),
                    const SizedBox(width: 6),
                    Text('Changed aspect: theme',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: graphite)),
                  ],
                ),
              ),
              dependentWidget('NameDisplay', ['name'], false, graphite),
              dependentWidget('AvatarIcon', ['avatar'], false, graphite),
              dependentWidget('ThemeSwitch', ['theme'], true, graphite),
              dependentWidget('FullProfile', ['name', 'email', 'avatar'], false, graphite),
              dependentWidget('LocaleLabel', ['locale'], false, graphite),
            ],
          )),
    ],
  );

  // ─── Section 5: updateShouldNotifyDependent ───
  print('[Section 5] updateShouldNotifyDependent');

  final section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('05', 'updateShouldNotifyDependent'),
      noteBox(
          'InheritedModelElement overrides updateShouldNotifyDependent() '
          'to check whether the dependent\'s registered aspects match '
          'the aspects that actually changed. This is the core mechanism.'),
      infoCard(
          'Method Signature',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Method', 'updateShouldNotifyDependent(dependent, deps)'),
              dataRow('dependent', 'The widget element to check'),
              dataRow('deps', 'Set of aspects it registered'),
              dataRow('Returns', 'bool — should this dependent rebuild'),
            ],
          )),
      infoCard(
          'Decision Logic',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('deps is empty', 'Always notify (null aspect)'),
              dataRow('deps ∩ changed ≠ ∅', 'Notify — aspect overlap'),
              dataRow('deps ∩ changed = ∅', 'Skip — no relevant change'),
              dataRow('isSupportedAspect', 'Model validates aspect exists'),
            ],
          )),
    ],
  );

  // ─── Section 6: Element Lifecycle ───
  print('[Section 6] Element Lifecycle');

  final section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('06', 'Element Lifecycle'),
      noteBox(
          'InheritedModelElement follows the standard Element lifecycle '
          'but adds aspect management during the dependency notification phase.'),
      infoCard(
          'Lifecycle Phases',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('mount', 'Element enters tree'),
              dataRow('update', 'Widget configuration changed'),
              dataRow('notifyClients', 'Walks dependents, checks aspects'),
              dataRow('deactivate', 'Removed from tree temporarily'),
              dataRow('unmount', 'Permanently removed'),
            ],
          )),
      infoCard(
          'Notification Phase Detail',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('1. Widget rebuilds', 'New InheritedModel provided'),
              dataRow('2. updateShouldNotify', 'Global: did anything change?'),
              dataRow('3. If true', 'Walk all dependents'),
              dataRow('4. Per dependent', 'updateShouldNotifyDependent()'),
              dataRow('5. Match?', 'Mark dirty — will rebuild'),
            ],
          )),
    ],
  );

  // ─── Section 7: Use Cases ───
  print('[Section 7] Use Cases');

  final section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('07', 'Use Cases'),
      noteBox(
          'InheritedModel is ideal when a single model object holds '
          'multiple independent pieces of state and different widgets '
          'care about different pieces.'),
      infoCard(
          'Theme Configuration',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Aspects', 'brightness, primaryColor, textTheme'),
              dataRow('AppBar', 'Depends on primaryColor'),
              dataRow('Body text', 'Depends on textTheme'),
              dataRow('Background', 'Depends on brightness'),
              dataRow('Benefit', 'Changing fontSize won\'t rebuild AppBar'),
            ],
          )),
      infoCard(
          'Media Query',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Aspects', 'size, orientation, padding, textScale'),
              dataRow('Layout widget', 'Depends on size'),
              dataRow('Text widget', 'Depends on textScale'),
              dataRow('Safe area', 'Depends on padding'),
              dataRow('Benefit', 'Keyboard showing only rebuilds padding'),
            ],
          )),
      infoCard(
          'App State',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Aspects', 'user, cart, notifications, settings'),
              dataRow('Profile page', 'Depends on user'),
              dataRow('Cart badge', 'Depends on cart'),
              dataRow('Bell icon', 'Depends on notifications'),
              dataRow('Benefit', 'Adding cart item won\'t rebuild profile'),
            ],
          )),
    ],
  );

  // ─── Section 8: Performance Comparison ───
  print('[Section 8] Performance Comparison');

  final section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('08', 'Performance Comparison'),
      noteBox(
          'The performance benefit of InheritedModel over InheritedWidget '
          'grows with the number of dependents and aspects.'),
      infoCard(
          'Rebuild Count Comparison',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Scenario: 5 dependents, 1 aspect changed',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: charcoal)),
              const SizedBox(height: 8),
              progressBar('InheritedWidget: 5/5 rebuilt', 1.0, const Color(0xFFEF4444)),
              progressBar('InheritedModel: 1/5 rebuilt', 0.2, const Color(0xFF22C55E)),
              const SizedBox(height: 12),
              Text('Scenario: 20 dependents, 2 aspects changed',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: charcoal)),
              const SizedBox(height: 8),
              progressBar('InheritedWidget: 20/20 rebuilt', 1.0, const Color(0xFFEF4444)),
              progressBar('InheritedModel: 4/20 rebuilt', 0.2, const Color(0xFF22C55E)),
            ],
          )),
      infoCard(
          'When to Use Which',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('InheritedWidget', 'Single value or always-together data'),
              dataRow('InheritedModel', 'Multi-field model, independent parts'),
              dataRow('Provider', 'Complex state, multiple notifiers'),
              dataRow('Riverpod', 'Fine-grained reactivity at library level'),
            ],
          )),
    ],
  );

  // ─── Section 9: Relationship to MediaQuery ───
  print('[Section 9] MediaQuery Example');

  final section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('09', 'Real-World: MediaQuery'),
      noteBox(
          'MediaQuery in Flutter uses InheritedModel internally. When you '
          'call MediaQuery.sizeOf(context), you register a dependency on '
          'the "size" aspect only.'),
      infoCard(
          'MediaQuery Aspects',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  aspectChip('size', true, slate),
                  aspectChip('devicePixelRatio', false, slate),
                  aspectChip('textScaler', false, slate),
                  aspectChip('padding', false, slate),
                  aspectChip('viewInsets', true, slate),
                  aspectChip('viewPadding', false, slate),
                  aspectChip('orientation', false, slate),
                  aspectChip('platformBrightness', false, slate),
                ],
              ),
              const SizedBox(height: 8),
              dataRow('MediaQuery.of(context)', 'Depends on ALL aspects'),
              dataRow('MediaQuery.sizeOf(context)', 'Only size aspect'),
              dataRow('MediaQuery.paddingOf(context)', 'Only padding aspect'),
              dataRow('Keyboard opens', 'Only viewInsets changes'),
            ],
          )),
      infoCard(
          'Optimization Impact',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Before (MediaQuery.of)', 'Every widget rebuilt on keyboard'),
              dataRow('After (sizeOf/paddingOf)', 'Only relevant widgets rebuild'),
              dataRow('Savings', 'Often 80-90% fewer rebuilds'),
            ],
          )),
    ],
  );

  // ─── Section 10: Creating Custom InheritedModel ───
  print('[Section 10] Custom InheritedModel');

  final section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('10', 'Creating Custom InheritedModel'),
      noteBox(
          'To create your own InheritedModel, subclass InheritedModel<T> '
          'where T is your aspect type (usually an enum), and implement '
          'updateShouldNotify and updateShouldNotifyDependent.'),
      infoCard(
          'Steps to Create',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('1. Define aspects', 'enum AppModelAspect { user, cart, theme }'),
              dataRow('2. Extend InheritedModel', 'InheritedModel<AppModelAspect>'),
              dataRow('3. Override methods', 'updateShouldNotify + Dependent'),
              dataRow('4. Static accessor', 'of(context, {aspect})'),
            ],
          )),
      infoCard(
          'Aspect Enum Design',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Granularity', 'One aspect per independent field'),
              dataRow('Too few aspects', 'Loses optimization benefit'),
              dataRow('Too many aspects', 'Overhead > rebuild savings'),
              dataRow('Sweet spot', '3-10 aspects per model'),
            ],
          )),
    ],
  );

  // ─── Section 11: Element Internal State ───
  print('[Section 11] Element Internal State');

  final section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('11', 'Element Internal State'),
      noteBox(
          'InheritedModelElement maintains a map from dependent elements '
          'to their registered aspects. This map is updated every time '
          'a dependent rebuilds and re-registers its aspects.'),
      infoCard(
          'Dependency Map',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Structure', 'Map<Element, Set<T>>'),
              dataRow('Key', 'Dependent element'),
              dataRow('Value', 'Set of aspects it subscribed to'),
              dataRow('Updated', 'Each time dependent builds'),
              dataRow('Cleaned', 'When dependent unmounts'),
            ],
          )),
      infoCard(
          'Map Visualization',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 4),
                decoration: BoxDecoration(
                  color: paleCloud,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: mist),
                ),
                child: Row(
                  children: [
                    Text('NameDisplay →',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: slate)),
                    const SizedBox(width: 8),
                    aspectChip('name', true, slate),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 4),
                decoration: BoxDecoration(
                  color: paleCloud,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: mist),
                ),
                child: Row(
                  children: [
                    Text('CartBadge →',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: slate)),
                    const SizedBox(width: 8),
                    aspectChip('cart', true, slate),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: paleCloud,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: mist),
                ),
                child: Row(
                  children: [
                    Text('FullProfile →',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: slate)),
                    const SizedBox(width: 8),
                    aspectChip('name', true, slate),
                    aspectChip('email', true, slate),
                    aspectChip('avatar', true, slate),
                  ],
                ),
              ),
            ],
          )),
    ],
  );

  // ─── Section 12: Comparison with Other Patterns ───
  print('[Section 12] Comparison with Patterns');

  final section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('12', 'Comparison with Other Patterns'),
      noteBox(
          'InheritedModel sits between InheritedWidget (simple) and full '
          'state management solutions (complex). Understanding the spectrum '
          'helps choose the right tool.'),
      infoCard(
          'Spectrum Table',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('InheritedWidget', 'One value, all rebuild'),
              dataRow('InheritedModel', 'Multi-aspect, selective rebuild'),
              dataRow('ChangeNotifier', 'Listeners, manual dispose'),
              dataRow('Provider', 'InheritedWidget + convenience'),
              dataRow('Riverpod', 'Provider graph, auto-dispose'),
              dataRow('BLoC', 'Stream-based, events/states'),
            ],
          )),
      infoCard(
          'InheritedModel Strengths',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('No packages', 'Built into Flutter framework'),
              dataRow('Zero overhead', 'No streams, no listeners'),
              dataRow('Compile-time safe', 'Aspect types enforced'),
              dataRow('Familiar API', 'Just like .of(context)'),
            ],
          )),
    ],
  );

  // ─── Section 13: Edge Cases ───
  print('[Section 13] Edge Cases');

  final section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('13', 'Edge Cases'),
      noteBox(
          'There are several subtle behaviors when working with '
          'InheritedModelElement that can cause unexpected rebuilds.'),
      infoCard(
          'Common Pitfalls',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Null aspect', 'Rebuilds on ANY change'),
              dataRow('Aspect in build()', 'Re-registers every build'),
              dataRow('Hot reload', 'Dependency map may reset'),
              dataRow('Wrong model type', 'Falls back to full rebuild'),
            ],
          )),
      infoCard(
          'Aspect Registration Timing',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('During build', 'Correct — standard pattern'),
              dataRow('During initState', 'Too early — no build context'),
              dataRow('In callback', 'Creates dependency but may miss'),
              dataRow('Conditional', 'Aspect changes between builds'),
            ],
          )),
    ],
  );

  // ─── Section 14: Testing ───
  print('[Section 14] Testing');

  final section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('14', 'Testing'),
      noteBox(
          'Testing InheritedModel requires verifying that changing one '
          'aspect only rebuilds the correct dependents.'),
      infoCard(
          'Test Strategies',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Build counter', 'Track builds per widget'),
              dataRow('Change one aspect', 'Assert only matching rebuild'),
              dataRow('Pump frame', 'After setState, verify build count'),
              dataRow('Null aspect', 'Assert always rebuilds'),
            ],
          )),
      infoCard(
          'Test Setup',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Create model', 'With known aspects'),
              dataRow('Build dependents', 'Each watching different aspect'),
              dataRow('Track builds', 'Counter in each dependent'),
              dataRow('Change model', 'Modify one aspect'),
              dataRow('Verify', 'Only expected counter incremented'),
            ],
          )),
    ],
  );

  // ─── Section 15: Debugging ───
  print('[Section 15] Debugging');

  final section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('15', 'Debugging'),
      noteBox(
          'When selective rebuilds don\'t work as expected, debugging '
          'the aspect registration and notification is key.'),
      infoCard(
          'Debug Techniques',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('print in build()', 'See which widgets rebuild'),
              dataRow('debugPrintRebuildDirtyWidgets', 'Framework-level flag'),
              dataRow('DevTools', 'Widget inspector rebuild highlights'),
              dataRow('Override notifyClients', 'Log aspect matching'),
            ],
          )),
      infoCard(
          'Common Issues',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Everything rebuilds', 'Using .of() without aspect'),
              dataRow('Nothing rebuilds', 'updateShouldNotify returns false'),
              dataRow('Wrong dependents', 'Aspect enum mismatch'),
              dataRow('Memory leak', 'Dependent not unmounting'),
            ],
          )),
    ],
  );

  // ─── Section 16: Visual Dashboard ───
  print('[Section 16] Visual Dashboard');

  final section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('16', 'Visual Dashboard'),
      noteBox('Complete overview of the InheritedModelElement deep demo.'),
      infoCard(
          'Demo Color Palette',
          Wrap(
            children: [
              colorSwatch('Slate', slate),
              colorSwatch('Graphite', graphite),
              colorSwatch('Deep Slate', deepSlate),
              colorSwatch('Pale Cloud', paleCloud),
              colorSwatch('Steel', steel),
              colorSwatch('Mist', mist),
              colorSwatch('Charcoal', charcoal),
              colorSwatch('Silver', silver),
              colorSwatch('Pewter', pewter),
              colorSwatch('Iron', iron),
            ],
          )),
      infoCard(
          'Section Coverage',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Overview', 1.0, slate),
              progressBar('Aspects', 1.0, graphite),
              progressBar('Dependency Registration', 1.0, steel),
              progressBar('Selective Rebuild', 1.0, iron),
              progressBar('updateShouldNotifyDependent', 1.0, slate),
              progressBar('Element Lifecycle', 1.0, graphite),
              progressBar('Use Cases', 1.0, steel),
              progressBar('Performance', 1.0, iron),
              progressBar('MediaQuery Example', 1.0, slate),
              progressBar('Custom InheritedModel', 1.0, graphite),
              progressBar('Internal State', 1.0, steel),
              progressBar('Comparison', 1.0, iron),
              progressBar('Edge Cases', 1.0, slate),
              progressBar('Testing', 1.0, graphite),
              progressBar('Debugging', 1.0, steel),
              progressBar('Dashboard', 1.0, iron),
            ],
          )),
      infoCard(
          'Statistics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Total sections', '16'),
              dataRow('Theme', 'Slate / Graphite'),
              dataRow('Palette colors', '10'),
            ],
          )),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          tag('InheritedModelElement', slate, Colors.white),
          tag('Aspect Tracking', graphite, Colors.white),
          tag('Selective Rebuild', steel, Colors.white),
          tag('Dependency Map', iron, Colors.white),
          tag('Performance', silver, charcoal),
          tag('MediaQuery', charcoal, Colors.white),
        ],
      ),
    ],
  );

  print('===== END INHERITED MODEL ELEMENT DEEP DEMO =====');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        section1,
        section2,
        section3,
        section4,
        section5,
        section6,
        section7,
        section8,
        section9,
        section10,
        section11,
        section12,
        section13,
        section14,
        section15,
        section16,
      ],
    ),
  );
}

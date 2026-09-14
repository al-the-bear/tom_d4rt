// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// =============================================================================
// InheritedModel.inheritFrom<T> — Visual Deep Demo
// =============================================================================
//
// This file is a long-form, hand-written visual study of Flutter's
// `InheritedModel.inheritFrom<T>(BuildContext, {Object? aspect})` static API
// — the surgical-strike cousin of `InheritedWidget.dependOnInheritedWidgetOf
// ExactType`. Where the InheritedWidget version says "rebuild me whenever
// *anything* in this ancestor changes", `InheritedModel.inheritFrom<T>` lets
// a descendant whisper "rebuild me only when the *aspect I named* has
// actually moved".
//
// The whole point of `InheritedModel<A>` is that one model can carry many
// independent slices of state (colour, density, font-scale, accent…) and a
// descendant can subscribe to exactly the slices it consumes. The model
// decides — via the polymorphic `updateShouldNotifyDependent(T old,
// Set<A> aspects)` — whether each subscriber should actually be rebuilt.
//
// All cards on this page are STATIC. We don't subscribe at runtime, we
// *describe* what would happen, with diagrams, code listings and side-by-
// side panels. Treat this as the manual you wish was glued to the inside
// cover of the InheritedModel doc.
//
// Sections:
//   1.  Hero banner — "the surgeon's tool" framing
//   2.  Anatomy of `InheritedModel.inheritFrom<T>` (signature + behaviour)
//   3.  Sample model — full _AspectModel listing as code, plus its fields
//   4.  Side-by-side aspect-subscriber cards (colour vs fontScale)
//   5.  ASCII-style propagation diagram — who rebuilds, who naps
//   6.  InheritedWidget vs InheritedModel — comparison table
//   7.  updateShouldNotifyDependent walkthrough
//   8.  updateShouldNotify — the gate before the gate
//   9.  Aspect identity rules — == / hashCode / null aspect
//   10. Pitfalls (the ones you only learn after a bug bash)
//   11. Performance reasoning — why this saves frames
//   12. Footer
// =============================================================================

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette — a "lab notebook" feel: warm cream paper, deep teal accent,
// rust for warnings. Deliberately distinct from the InteractiveViewer demo.
// ---------------------------------------------------------------------------

const Color labInk = Color(0xFF1B2430);
const Color labInkSoft = Color(0xFF455065);
const Color labInkFaint = Color(0xFF8A93A4);
const Color labCream = Color(0xFFF7F1E1);
const Color labCreamDeep = Color(0xFFEEE3C8);
const Color labRule = Color(0xFFD7C9A2);
const Color labTeal = Color(0xFF0B6E6E);
const Color labTealSoft = Color(0xFFB8E3DD);
const Color labTealDeep = Color(0xFF064848);
const Color labRust = Color(0xFFB14627);
const Color labRustSoft = Color(0xFFF7D6C5);
const Color labMoss = Color(0xFF4F7942);
const Color labMossSoft = Color(0xFFD8E7CB);
const Color labBerry = Color(0xFF8E2A4B);
const Color labBerrySoft = Color(0xFFF4CFD9);
const Color labOcher = Color(0xFFB58A1A);
const Color labOcherSoft = Color(0xFFF7E5A8);
const Color labSlate = Color(0xFF324A5A);
const Color labSlateSoft = Color(0xFFCCD8DF);

// ---------------------------------------------------------------------------
// Aspect tokens — the strings the descendants subscribe to. Defined once
// here so that the rest of the file consistently references them.
// ---------------------------------------------------------------------------

const String aspectColorTone = 'colorTone';
const String aspectFontScale = 'fontScale';
const String aspectDensity = 'density';
const String aspectIsAccent = 'isAccent';

// ---------------------------------------------------------------------------
// Typography — small set, deliberate weights. No theme magic.
// ---------------------------------------------------------------------------

const TextStyle styleHeroTitle = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.w800,
  color: labInk,
  letterSpacing: -0.6,
  height: 1.05,
);

const TextStyle styleHeroSubtitle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w500,
  color: labInkSoft,
  height: 1.45,
);

const TextStyle styleSectionTitle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w700,
  color: labInk,
  letterSpacing: -0.3,
);

const TextStyle styleSectionLead = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w500,
  color: labInkSoft,
  height: 1.5,
);

const TextStyle styleBody = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w400,
  color: labInk,
  height: 1.45,
);

const TextStyle styleBodySoft = TextStyle(
  fontSize: 12.5,
  fontWeight: FontWeight.w400,
  color: labInkSoft,
  height: 1.45,
);

const TextStyle styleCode = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12,
  color: labInk,
  height: 1.4,
);

const TextStyle styleCodeFaint = TextStyle(
  fontFamily: 'monospace',
  fontSize: 11.5,
  color: labInkSoft,
  height: 1.4,
);

const TextStyle styleCodeMono = TextStyle(
  fontFamily: 'monospace',
  fontSize: 11,
  color: labInk,
  height: 1.35,
);

const TextStyle styleCardTitle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w700,
  color: labInk,
);

const TextStyle styleCardLabel = TextStyle(
  fontSize: 11,
  fontWeight: FontWeight.w700,
  color: labTealDeep,
  letterSpacing: 1.2,
);

const TextStyle styleTag = TextStyle(
  fontSize: 10,
  fontWeight: FontWeight.w700,
  color: Colors.white,
  letterSpacing: 0.8,
);

const TextStyle styleAspectTag = TextStyle(
  fontSize: 10.5,
  fontWeight: FontWeight.w800,
  color: labTealDeep,
  letterSpacing: 0.6,
  fontFamily: 'monospace',
);

// ---------------------------------------------------------------------------
// Sample model — declared at file scope. Demonstrates the API but is NOT
// mounted anywhere; the demo's build() is fully static.
// ---------------------------------------------------------------------------

class _AspectModel extends InheritedModel<String> {
  const _AspectModel({
    required this.colorTone,
    required this.fontScale,
    required this.density,
    required this.isAccent,
    required super.child,
  });

  final Color colorTone;
  final double fontScale;
  final double density;
  final bool isAccent;

  static _AspectModel? maybeOf(BuildContext context, String aspect) {
    return InheritedModel.inheritFrom<_AspectModel>(context, aspect: aspect);
  }

  @override
  bool updateShouldNotify(_AspectModel old) {
    return colorTone != old.colorTone ||
        fontScale != old.fontScale ||
        density != old.density ||
        isAccent != old.isAccent;
  }

  @override
  bool updateShouldNotifyDependent(
    _AspectModel old,
    Set<String> aspects,
  ) {
    if (aspects.contains(aspectColorTone) && colorTone != old.colorTone) {
      return true;
    }
    if (aspects.contains(aspectFontScale) && fontScale != old.fontScale) {
      return true;
    }
    if (aspects.contains(aspectDensity) && density != old.density) {
      return true;
    }
    if (aspects.contains(aspectIsAccent) && isAccent != old.isAccent) {
      return true;
    }
    return false;
  }
}

// ---------------------------------------------------------------------------
// MAIN ENTRY
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'InheritedModel.inheritFrom — Deep Demo',
    home: Scaffold(
      backgroundColor: labCream,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              heroBanner(),
              SizedBox(height: 28),
              anatomySection(),
              SizedBox(height: 28),
              sampleModelSection(),
              SizedBox(height: 28),
              aspectSubscribersSection(),
              SizedBox(height: 28),
              propagationDiagramSection(),
              SizedBox(height: 28),
              compareWithInheritedWidgetSection(),
              SizedBox(height: 28),
              updateShouldNotifyDependentSection(),
              SizedBox(height: 28),
              updateShouldNotifySection(),
              SizedBox(height: 28),
              aspectIdentitySection(),
              SizedBox(height: 28),
              pitfallsSection(),
              SizedBox(height: 28),
              performanceReasoningSection(),
              SizedBox(height: 28),
              footerSection(),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    ),
  );
}

// ===========================================================================
// SECTION 1 — HERO
// ===========================================================================

Widget heroBanner() {
  return Container(
    padding: EdgeInsets.fromLTRB(32, 30, 32, 30),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: labRule, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 28,
          offset: Offset(0, 10),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: labTealSoft,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'WIDGET STUDY  ·  ASPECT-SCOPED INHERITANCE',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: labTealDeep,
                    letterSpacing: 1.4,
                  ),
                ),
              ),
              SizedBox(height: 14),
              Text('InheritedModel.inheritFrom<T>', style: styleHeroTitle),
              SizedBox(height: 8),
              Text(
                'A surgical version of dependOnInheritedWidgetOfExactType. The '
                'descendant names an "aspect" it cares about; the model decides '
                'which aspects propagate. Subscribers to a quiet aspect skip '
                'the rebuild entirely.',
                style: styleHeroSubtitle,
              ),
              SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  heroChip('static <T extends InheritedModel<A>>'),
                  heroChip('BuildContext context'),
                  heroChip('Object? aspect'),
                  heroChip('returns T?'),
                  heroChip('updateShouldNotify'),
                  heroChip('updateShouldNotifyDependent'),
                  heroChip('Set<A> aspects'),
                  heroChip('per-dependent rebuild gate'),
                  heroChip('aspect == null  =>  subscribe to all'),
                  heroChip('aspect identity = ==/hashCode'),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 24),
        Expanded(
          flex: 4,
          child: AspectRatio(
            aspectRatio: 1.25,
            child: heroSurgeryGraphic(),
          ),
        ),
      ],
    ),
  );
}

Widget heroChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: labCreamDeep,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: labRule, width: 0.8),
    ),
    child: Text(label, style: styleCodeFaint),
  );
}

Widget heroSurgeryGraphic() {
  // Ancestor model at the top, four descendants below — three with
  // tinted aspect tags, one with a struck-out tag to mean "skipped".
  return Container(
    decoration: BoxDecoration(
      color: labCreamDeep,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: labRule, width: 1),
    ),
    padding: EdgeInsets.all(18),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: labTealDeep,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.account_tree, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  '_AspectModel',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              Text(
                'colorTone · fontScale · density · isAccent',
                style: TextStyle(
                  color: labTealSoft,
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 14),
        Row(
          children: <Widget>[
            Expanded(child: heroBranchLine(true)),
            Expanded(child: heroBranchLine(true)),
            Expanded(child: heroBranchLine(true)),
            Expanded(child: heroBranchLine(true)),
          ],
        ),
        SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: heroSubscriber('Header', 'colorTone', labTealSoft, true)),
            SizedBox(width: 6),
            Expanded(child: heroSubscriber('Title', 'fontScale', labOcherSoft, true)),
            SizedBox(width: 6),
            Expanded(child: heroSubscriber('Card', 'density', labMossSoft, false)),
            SizedBox(width: 6),
            Expanded(child: heroSubscriber('Cta', 'isAccent', labBerrySoft, true)),
          ],
        ),
      ],
    ),
  );
}

Widget heroBranchLine(bool active) {
  return Container(
    height: 18,
    alignment: Alignment.center,
    child: Container(
      width: 1.5,
      height: 18,
      color: active ? labTealDeep : labInkFaint,
    ),
  );
}

Widget heroSubscriber(String name, String aspect, Color tone, bool rebuilt) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: labRule, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: tone,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(aspect, style: styleAspectTag),
        ),
        SizedBox(height: 4),
        Text(name, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: labInk)),
        SizedBox(height: 2),
        Container(
          width: 28,
          height: 4,
          decoration: BoxDecoration(
            color: rebuilt ? labMoss : labInkFaint.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(height: 2),
        Text(
          rebuilt ? 'rebuild' : 'skipped',
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w700,
            color: rebuilt ? labMoss : labInkFaint,
            letterSpacing: 0.6,
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 2 — ANATOMY
// ===========================================================================

Widget anatomySection() {
  return sectionContainer(
    label: 'ANATOMY',
    title: 'The static API: inheritFrom<T>(context, {aspect})',
    lead: 'It looks like a normal lookup, but it does two things: register the '
        'caller as a dependent of T (just like dependOnInheritedWidgetOfExact'
        'Type), and tag that registration with an aspect token. The model '
        'later inspects those tokens to decide who really needs to rebuild.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        codeBlock(<String>[
          '// Static method on InheritedModel<A>:',
          'static T? inheritFrom<T extends InheritedModel<Object>>(',
          '  BuildContext context, {',
          '  Object? aspect,',
          '})',
          '',
          '// Behaviour:',
          '//',
          '//   1. Walks up the element tree, finding the nearest T ancestor.',
          '//   2. Registers `context` as a dependent of that T.',
          '//   3. Stores `aspect` alongside the registration. If the same',
          '//      context inheritFrom\'s twice with different aspects, BOTH',
          '//      aspects are remembered — the registered Set<A> grows.',
          '//   4. Returns the T instance, or null if no ancestor exists.',
          '//',
          '// What happens at update time (parent rebuilds with a new T):',
          '//',
          '//   a. Framework calls newT.updateShouldNotify(oldT).',
          '//      If false: nobody rebuilds, full stop.',
          '//   b. If true, for EACH dependent context the framework calls',
          '//      newT.updateShouldNotifyDependent(oldT, registeredAspects).',
          '//      If true for that dependent: rebuild it.',
          '//      If false: skip it.',
          '//',
          '// Subscribing to *all* aspects is `aspect: null` (the default).',
          '//   InheritedModel.inheritFrom<MyModel>(context); // == aspect:null',
          '//   The framework hands updateShouldNotifyDependent an empty set,',
          '//   and the model is expected to treat empty == "everything".',
        ]),
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: anatomyBullet('aspect', 'Anything Object?. By convention a String, an enum, or a record. Equality matters: aspects are stored in a Set keyed by ==.')),
            SizedBox(width: 12),
            Expanded(child: anatomyBullet('Set<A>', 'A is the type parameter on InheritedModel<A>. The same dependent\'s aspects pile up into one Set<A>; the model gets the union on update.')),
            SizedBox(width: 12),
            Expanded(child: anatomyBullet('return T?', 'Null when no matching ancestor was found. inheritFrom does NOT throw — be ready for null at call sites.')),
          ],
        ),
      ],
    ),
  );
}

Widget anatomyBullet(String title, String body) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: labCreamDeep,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: labRule, width: 0.8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: styleCardLabel),
        SizedBox(height: 4),
        Text(body, style: styleBodySoft),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 3 — SAMPLE MODEL
// ===========================================================================

Widget sampleModelSection() {
  return sectionContainer(
    label: 'SAMPLE MODEL',
    title: 'A four-aspect _AspectModel',
    lead: 'A typical InheritedModel carries multiple, *independent* slices of '
        'state. Here we use four: colorTone (a Color), fontScale (a double), '
        'density (a double), and isAccent (a bool). Every descendant subscribes '
        'to exactly the slice it actually reads.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        codeBlock(<String>[
          'class _AspectModel extends InheritedModel<String> {',
          '  const _AspectModel({',
          '    required this.colorTone,',
          '    required this.fontScale,',
          '    required this.density,',
          '    required this.isAccent,',
          '    required super.child,',
          '  });',
          '',
          '  final Color  colorTone;',
          '  final double fontScale;',
          '  final double density;',
          '  final bool   isAccent;',
          '',
          '  // Convenience access — the public surface for descendants.',
          '  static _AspectModel? maybeOf(BuildContext context, String aspect) {',
          '    return InheritedModel.inheritFrom<_AspectModel>(context, aspect: aspect);',
          '  }',
          '',
          '  @override',
          '  bool updateShouldNotify(_AspectModel old) {',
          '    // Cheap, conservative: if ANY field has moved, *consider* propagating.',
          '    return colorTone != old.colorTone ||',
          '           fontScale != old.fontScale ||',
          '           density   != old.density   ||',
          '           isAccent  != old.isAccent;',
          '  }',
          '',
          '  @override',
          '  bool updateShouldNotifyDependent(_AspectModel old, Set<String> aspects) {',
          '    if (aspects.contains(\'colorTone\') && colorTone != old.colorTone) return true;',
          '    if (aspects.contains(\'fontScale\') && fontScale != old.fontScale) return true;',
          '    if (aspects.contains(\'density\')   && density   != old.density)   return true;',
          '    if (aspects.contains(\'isAccent\')  && isAccent  != old.isAccent)  return true;',
          '    return false;',
          '  }',
          '}',
        ]),
        SizedBox(height: 16),
        Row(
          children: <Widget>[
            Expanded(child: aspectFieldCard('colorTone', 'Color', 'painted backgrounds, dividers, glyphs', labTealSoft)),
            SizedBox(width: 10),
            Expanded(child: aspectFieldCard('fontScale', 'double', 'multiplier on Text.style.fontSize', labOcherSoft)),
            SizedBox(width: 10),
            Expanded(child: aspectFieldCard('density', 'double', 'padding/spacing scale (compact vs roomy)', labMossSoft)),
            SizedBox(width: 10),
            Expanded(child: aspectFieldCard('isAccent', 'bool', 'whether to render the accent stripe', labBerrySoft)),
          ],
        ),
      ],
    ),
  );
}

Widget aspectFieldCard(String name, String type, String role, Color tone) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: tone,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: labRule, width: 0.8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(name, style: styleAspectTag),
        SizedBox(height: 4),
        Text(type, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: labInk, fontFamily: 'monospace')),
        SizedBox(height: 6),
        Text(role, style: styleBodySoft),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 4 — ASPECT SUBSCRIBERS, SIDE BY SIDE
// ===========================================================================

Widget aspectSubscribersSection() {
  return sectionContainer(
    label: 'SUBSCRIBERS',
    title: 'Two descendants, two aspects',
    lead: 'Same ancestor model, two different consumers. The left widget reads '
        'only colorTone; the right widget reads only fontScale. When colorTone '
        'changes, only the left widget rebuilds. When fontScale changes, only '
        'the right one. This is the entire selling point.',
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: subscriberCard(
            title: 'TonedHeader — depends on colorTone',
            tone: labTealSoft,
            tag: 'colorTone',
            code: <String>[
              'class TonedHeader extends StatelessWidget {',
              '  const TonedHeader({super.key});',
              '',
              '  @override',
              '  Widget build(BuildContext context) {',
              '    final model = _AspectModel.maybeOf(context, \'colorTone\');',
              '    final color = model?.colorTone ?? Colors.black;',
              '    return Container(',
              '      height: 36,',
              '      color: color,',
              '      alignment: Alignment.centerLeft,',
              '      padding: EdgeInsets.symmetric(horizontal: 12),',
              '      child: Text(\'Header\',',
              '        style: TextStyle(color: Colors.white)),',
              '    );',
              '  }',
              '}',
            ],
            footer: 'Reads colorTone only. Will skip rebuilds when fontScale, '
                'density or isAccent change.',
          ),
        ),
        SizedBox(width: 14),
        Expanded(
          child: subscriberCard(
            title: 'ScaledTitle — depends on fontScale',
            tone: labOcherSoft,
            tag: 'fontScale',
            code: <String>[
              'class ScaledTitle extends StatelessWidget {',
              '  const ScaledTitle(this.text, {super.key});',
              '  final String text;',
              '',
              '  @override',
              '  Widget build(BuildContext context) {',
              '    final model = _AspectModel.maybeOf(context, \'fontScale\');',
              '    final scale = model?.fontScale ?? 1.0;',
              '    return Text(',
              '      text,',
              '      style: TextStyle(fontSize: 16 * scale),',
              '    );',
              '  }',
              '}',
            ],
            footer: 'Reads fontScale only. Skips rebuilds when colorTone, '
                'density or isAccent change.',
          ),
        ),
      ],
    ),
  );
}

Widget subscriberCard({
  required String title,
  required Color tone,
  required String tag,
  required List<String> code,
  required String footer,
}) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: labRule, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: tone,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(tag, style: styleAspectTag),
            ),
            SizedBox(width: 8),
            Expanded(child: Text(title, style: styleCardTitle)),
          ],
        ),
        SizedBox(height: 10),
        codeBlock(code),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: labCreamDeep,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: labRule, width: 0.8),
          ),
          child: Text(footer, style: styleBodySoft),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 5 — PROPAGATION DIAGRAM
// ===========================================================================

Widget propagationDiagramSection() {
  return sectionContainer(
    label: 'PROPAGATION',
    title: 'Who rebuilds when which aspect changes',
    lead: 'Mentally trace each row: the ancestor mutated one slice, the framework '
        'consults updateShouldNotifyDependent for every registered subscriber, '
        'and only those whose Set<String> contains the changed aspect rebuild. '
        'A single mutation never causes a cascade beyond the subscribers that '
        'asked for it.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        propagationLegend(),
        SizedBox(height: 14),
        propagationRow(
          changed: 'colorTone',
          changedTone: labTealSoft,
          subscribers: <SubFlag>[
            SubFlag('TonedHeader', 'colorTone', true),
            SubFlag('ScaledTitle', 'fontScale', false),
            SubFlag('SpacedCard', 'density', false),
            SubFlag('AccentCta', 'isAccent', false),
          ],
        ),
        SizedBox(height: 10),
        propagationRow(
          changed: 'fontScale',
          changedTone: labOcherSoft,
          subscribers: <SubFlag>[
            SubFlag('TonedHeader', 'colorTone', false),
            SubFlag('ScaledTitle', 'fontScale', true),
            SubFlag('SpacedCard', 'density', false),
            SubFlag('AccentCta', 'isAccent', false),
          ],
        ),
        SizedBox(height: 10),
        propagationRow(
          changed: 'density',
          changedTone: labMossSoft,
          subscribers: <SubFlag>[
            SubFlag('TonedHeader', 'colorTone', false),
            SubFlag('ScaledTitle', 'fontScale', false),
            SubFlag('SpacedCard', 'density', true),
            SubFlag('AccentCta', 'isAccent', false),
          ],
        ),
        SizedBox(height: 10),
        propagationRow(
          changed: 'isAccent',
          changedTone: labBerrySoft,
          subscribers: <SubFlag>[
            SubFlag('TonedHeader', 'colorTone', false),
            SubFlag('ScaledTitle', 'fontScale', false),
            SubFlag('SpacedCard', 'density', false),
            SubFlag('AccentCta', 'isAccent', true),
          ],
        ),
        SizedBox(height: 14),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFFBF6E6),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: labRule, width: 0.8),
          ),
          child: codeBlock(<String>[
            '// ASCII view of the same idea',
            '',
            '   _AspectModel(colorTone, fontScale, density, isAccent)',
            '   |',
            '   |--- TonedHeader      [colorTone]   <- rebuilds only on colorTone',
            '   |--- ScaledTitle      [fontScale]   <- rebuilds only on fontScale',
            '   |--- SpacedCard       [density]     <- rebuilds only on density',
            '   |--- AccentCta        [isAccent]    <- rebuilds only on isAccent',
            '   |--- LegacyConsumer   [<all>]       <- null aspect, rebuilds on any',
            '',
            '   colorTone changed:    [X][ ][ ][ ][X]',
            '   fontScale changed:    [ ][X][ ][ ][X]',
            '   density   changed:    [ ][ ][X][ ][X]',
            '   isAccent  changed:    [ ][ ][ ][X][X]',
            '',
            '   X = rebuild,  blank = skipped',
          ]),
        ),
      ],
    ),
  );
}

Widget propagationLegend() {
  return Row(
    children: <Widget>[
      legendDot(labMoss, 'rebuilds'),
      SizedBox(width: 14),
      legendDot(labInkFaint, 'skipped'),
      SizedBox(width: 14),
      legendDot(labRust, 'changed aspect'),
      Spacer(),
      Text(
        'one row per aspect mutation',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: labInkSoft,
          letterSpacing: 0.4,
        ),
      ),
    ],
  );
}

Widget legendDot(Color c, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: c, shape: BoxShape.circle),
      ),
      SizedBox(width: 6),
      Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: labInkSoft)),
    ],
  );
}

class SubFlag {
  const SubFlag(this.name, this.aspect, this.rebuilt);
  final String name;
  final String aspect;
  final bool rebuilt;
}

Widget propagationRow({
  required String changed,
  required Color changedTone,
  required List<SubFlag> subscribers,
}) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: labRule, width: 0.8),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 110,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: changedTone,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('CHANGED', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 1, color: labInk)),
              SizedBox(height: 2),
              Text(changed, style: styleAspectTag),
            ],
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Row(
            children: <Widget>[
              for (int i = 0; i < subscribers.length; i++) ...<Widget>[
                Expanded(child: propagationCell(subscribers[i])),
                if (i < subscribers.length - 1) SizedBox(width: 6),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

Widget propagationCell(SubFlag flag) {
  final Color bg = flag.rebuilt ? labMossSoft : labCreamDeep;
  final Color bar = flag.rebuilt ? labMoss : labInkFaint.withValues(alpha: 0.35);
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: labRule, width: 0.8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(flag.name, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: labInk)),
        SizedBox(height: 2),
        Text('aspect: ${flag.aspect}', style: TextStyle(fontSize: 10, color: labInkSoft, fontFamily: 'monospace')),
        SizedBox(height: 6),
        Container(
          height: 4,
          decoration: BoxDecoration(
            color: bar,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(height: 4),
        Text(
          flag.rebuilt ? 'REBUILT' : 'skipped',
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w800,
            color: flag.rebuilt ? labMoss : labInkFaint,
            letterSpacing: 0.8,
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 6 — InheritedWidget vs InheritedModel
// ===========================================================================

Widget compareWithInheritedWidgetSection() {
  return sectionContainer(
    label: 'COMPARE',
    title: 'dependOnInheritedWidgetOfExactType vs InheritedModel.inheritFrom<T>',
    lead: 'They look almost identical at the call site. Their semantics — the '
        'volume of rebuilds they trigger — could not be more different.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: comparePane(
                title: 'InheritedWidget',
                accent: labSlate,
                accentSoft: labSlateSoft,
                rows: <List<String>>[
                  <String>['Lookup', 'context.dependOnInheritedWidgetOfExactType<T>()'],
                  <String>['Granularity', 'all-or-nothing — one bit per ancestor'],
                  <String>['Gate', 'updateShouldNotify(oldWidget) -> bool'],
                  <String>['Per-dependent', 'none — every dependent rebuilds'],
                  <String>['Aspect concept', 'absent'],
                  <String>['Best for', 'small, single-purpose contexts'],
                  <String>['Worst for', 'fat models with many fields and readers'],
                ],
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: comparePane(
                title: 'InheritedModel<A>',
                accent: labTealDeep,
                accentSoft: labTealSoft,
                rows: <List<String>>[
                  <String>['Lookup', 'InheritedModel.inheritFrom<T>(context, aspect: x)'],
                  <String>['Granularity', 'per-aspect — many bits per ancestor'],
                  <String>['Gate 1', 'updateShouldNotify(old) -> bool (model-wide)'],
                  <String>['Gate 2', 'updateShouldNotifyDependent(old, Set<A>) -> bool'],
                  <String>['Aspect concept', 'first-class — Set<A> per dependent'],
                  <String>['Best for', 'fat models read by specialised consumers'],
                  <String>['Worst for', 'tiny single-field state'],
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        codeBlock(<String>[
          '// At a glance — same shape, very different cost:',
          '',
          'final t = Theme.of(context);                                  // InheritedWidget',
          'final m = _AspectModel.maybeOf(context, \'colorTone\');         // InheritedModel',
          '',
          '// Theme.of rebuilds you on EVERY ThemeData change.',
          '// _AspectModel.maybeOf(...colorTone) rebuilds you only on colorTone changes.',
        ]),
      ],
    ),
  );
}

Widget comparePane({
  required String title,
  required Color accent,
  required Color accentSoft,
  required List<List<String>> rows,
}) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: labRule, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: accentSoft,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                title.toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: accent,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            SizedBox(width: 8),
            Container(width: 30, height: 1, color: labRule),
          ],
        ),
        SizedBox(height: 8),
        for (final List<String> row in rows) ...<Widget>[
          compareRow(row[0], row[1]),
          Container(height: 1, color: labRule.withValues(alpha: 0.5)),
        ],
      ],
    ),
  );
}

Widget compareRow(String key, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 110,
          child: Text(
            key,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: labInkSoft,
              letterSpacing: 0.4,
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(child: Text(value, style: styleBody)),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 7 — updateShouldNotifyDependent
// ===========================================================================

Widget updateShouldNotifyDependentSection() {
  return sectionContainer(
    label: 'GATE 2',
    title: 'updateShouldNotifyDependent(old, Set<A> aspects)',
    lead: 'This is the per-subscriber gate. The framework calls it once per '
        'dependent context, passing the Set<A> of aspects that context '
        'previously requested. Return true to schedule that dependent for '
        'rebuild; false to leave it at peace.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        codeBlock(<String>[
          '@override',
          'bool updateShouldNotifyDependent(_AspectModel old, Set<String> aspects) {',
          '  // The "diagonal" pattern — one branch per aspect.',
          '  if (aspects.contains(\'colorTone\') && colorTone != old.colorTone) return true;',
          '  if (aspects.contains(\'fontScale\') && fontScale != old.fontScale) return true;',
          '  if (aspects.contains(\'density\')   && density   != old.density)   return true;',
          '  if (aspects.contains(\'isAccent\')  && isAccent  != old.isAccent)  return true;',
          '  return false;',
          '}',
        ]),
        SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: dependentBullet('one call per dependent', 'If five widgets subscribed, this method runs five times — but each call gets only that widget\'s aspects, not the union.')),
            SizedBox(width: 12),
            Expanded(child: dependentBullet('aspects is a Set<A>', 'A is the type parameter on InheritedModel<A>. We chose String, but enums or sealed-class tokens are usually a better idea in production.')),
            SizedBox(width: 12),
            Expanded(child: dependentBullet('aspects can be empty', 'Empty set means the dependent registered with `aspect: null` — i.e. "subscribe to everything". By contract you should treat that as "all aspects matter".')),
          ],
        ),
        SizedBox(height: 14),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: labOcherSoft,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: labRule, width: 0.8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.lightbulb_outline, color: labInk, size: 18),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Treat updateShouldNotifyDependent as "fast & true". It runs once per '
                  'dependent on every model rebuild — so do not allocate, do not log, '
                  'do not call expensive equality. Plain field comparison only.',
                  style: styleBody,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: labRustSoft,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: labRule, width: 0.8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.error_outline, color: labRust, size: 18),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Returning true for an aspect that did NOT change is a silent '
                  'over-rebuild bug — it negates the whole point of using '
                  'InheritedModel. Always pair `aspects.contains(x)` with `x != old.x`.',
                  style: styleBody,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget dependentBullet(String title, String body) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: labCreamDeep,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: labRule, width: 0.8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title.toUpperCase(), style: styleCardLabel),
        SizedBox(height: 4),
        Text(body, style: styleBodySoft),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 8 — updateShouldNotify
// ===========================================================================

Widget updateShouldNotifySection() {
  return sectionContainer(
    label: 'GATE 1',
    title: 'updateShouldNotify(old) — the model-wide cutoff',
    lead: 'Before consulting per-subscriber aspects, the framework asks the '
        'model itself: "did anything I should care about move?". If this '
        'returns false, the framework stops there — updateShouldNotifyDependent '
        'is not called for anyone, and the dependent set keeps its current build.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        codeBlock(<String>[
          '@override',
          'bool updateShouldNotify(_AspectModel old) {',
          '  // Conservative OR — if ANY field has moved, return true so that',
          '  // the per-aspect gate gets a chance to filter.',
          '  return colorTone != old.colorTone ||',
          '         fontScale != old.fontScale ||',
          '         density   != old.density   ||',
          '         isAccent  != old.isAccent;',
          '}',
        ]),
        SizedBox(height: 12),
        Row(
          children: <Widget>[
            Expanded(child: gateCard('false  ->  zero rebuilds', 'No dependent is touched, even those subscribed to every aspect. Useful when the model has fields that are NOT aspects (e.g. caches, debug-only data).', labMossSoft)),
            SizedBox(width: 12),
            Expanded(child: gateCard('true  ->  ask each dependent', 'updateShouldNotifyDependent runs once per registered context. Each dependent then individually returns rebuild/skip.', labTealSoft)),
            SizedBox(width: 12),
            Expanded(child: gateCard('always-true (return true)', 'Skips Gate 1 entirely and forces the per-aspect gate to do all filtering. Acceptable, but you lose a cheap early-out.', labOcherSoft)),
          ],
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFFBF6E6),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: labRule, width: 0.8),
          ),
          child: Text(
            'Mental model: Gate 1 is the model asking "is there anything '
            'worth talking about?". Gate 2 is the model asking, for each '
            'subscriber, "is the thing you asked about the thing that '
            'changed?". You need both to keep rebuilds tight.',
            style: styleBody,
          ),
        ),
      ],
    ),
  );
}

Widget gateCard(String title, String body, Color tone) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: tone,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: labRule, width: 0.8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: labInk, fontFamily: 'monospace')),
        SizedBox(height: 6),
        Text(body, style: styleBodySoft),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 9 — ASPECT IDENTITY RULES
// ===========================================================================

Widget aspectIdentitySection() {
  return sectionContainer(
    label: 'IDENTITY',
    title: 'How aspects are compared',
    lead: 'Aspects live inside a Set<A>. Set membership uses == and hashCode. '
        'If two distinct objects compare equal, they collapse into one aspect. '
        'If two equal-looking objects do NOT compare equal, they live as two '
        'aspects and either may trigger a rebuild — usually not what you want.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: identityCard(
                heading: 'String literals',
                tone: labTealSoft,
                ok: true,
                code: <String>[
                  '_AspectModel.maybeOf(ctx, \'colorTone\');',
                  '_AspectModel.maybeOf(ctx, \'colorTone\');',
                  '// Same constant string, canonicalised.',
                  '// Set has 1 element. Safe.',
                ],
                comment: 'String constants are canonical — perfect aspect tokens.',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: identityCard(
                heading: 'Enums',
                tone: labMossSoft,
                ok: true,
                code: <String>[
                  'enum Aspect { colorTone, fontScale, density }',
                  '_AspectModel.maybeOf(ctx, Aspect.colorTone);',
                  '// Singleton instances per value — == is identity.',
                  '// Type-safe, IDE-friendly, recommended.',
                ],
                comment: 'The most robust choice in production code.',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: identityCard(
                heading: 'Custom class without ==',
                tone: labRustSoft,
                ok: false,
                code: <String>[
                  'class Aspect { const Aspect(this.id); final String id; }',
                  'maybeOf(ctx, Aspect(\'colorTone\'));',
                  'maybeOf(ctx, Aspect(\'colorTone\'));',
                  '// Two instances, identity equality.',
                  '// Set has 2 elements. Confusing rebuilds.',
                ],
                comment: 'Always override == and hashCode on a custom aspect type.',
              ),
            ),
          ],
        ),
        SizedBox(height: 14),
        codeBlock(<String>[
          '// Special case: aspect == null',
          '',
          'InheritedModel.inheritFrom<T>(context);              // aspect: null implicitly',
          'InheritedModel.inheritFrom<T>(context, aspect: null); // explicit',
          '',
          '// The framework registers the dependent without adding any aspect',
          '// to its Set<A>. By convention you treat that empty set as',
          '// "subscribe to every aspect" — the default updateShouldNotifyDependent',
          '// implementation in the SDK does exactly that for the common case.',
          '',
          '// Mixed null + named:',
          'InheritedModel.inheritFrom<T>(context, aspect: \'colorTone\');',
          'InheritedModel.inheritFrom<T>(context);',
          '// Same context now has aspects = {\'colorTone\'} but ALSO is registered',
          '// as a "no-aspect" dependent — most implementations escalate to rebuild',
          '// on any change. Don\'t mix null and named on the same context.',
        ]),
      ],
    ),
  );
}

Widget identityCard({
  required String heading,
  required Color tone,
  required bool ok,
  required List<String> code,
  required String comment,
}) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: tone,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: labRule, width: 0.8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              ok ? Icons.check_circle : Icons.cancel_outlined,
              color: ok ? labMoss : labRust,
              size: 16,
            ),
            SizedBox(width: 6),
            Expanded(child: Text(heading, style: styleCardTitle)),
          ],
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: labRule, width: 0.8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (final String l in code)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1),
                  child: Text(
                    l,
                    style: l.startsWith('//') ? styleCodeFaint : styleCodeMono,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(comment, style: styleBodySoft),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 10 — PITFALLS
// ===========================================================================

Widget pitfallsSection() {
  return sectionContainer(
    label: 'PITFALLS',
    title: 'Things that go wrong on the way',
    lead: 'A short list of failure modes that are very obvious in hindsight '
        'and very subtle while you are writing them.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        pitfall(
          title: 'Forgetting to override updateShouldNotifyDependent',
          body: 'The default behaviour of InheritedModel\'s parent class is '
              'still InheritedWidget — meaning every dependent rebuilds on any '
              'change. The performance gain only materialises when you '
              'override the per-aspect gate.',
          tone: labRustSoft,
        ),
        pitfall(
          title: 'Aspect stored in a State field',
          body: 'If a State recomputes its aspect on every build, '
              '`maybeOf(context, freshObjectThatChangesEachBuild)` registers a '
              'new aspect on every build. The Set<A> grows, then leaks until '
              'the dependent unmounts. Always use stable, canonical aspect '
              'values (constants, enums).',
          tone: labRustSoft,
        ),
        pitfall(
          title: 'Mutating fields in the model',
          body: 'InheritedModel is supposed to be immutable. If you mutate '
              'colorTone in place and rebuild a fresh _AspectModel, '
              'updateShouldNotifyDependent will compare the mutated value '
              'against itself and return false. No rebuild. Always allocate '
              'a brand-new instance with the new value.',
          tone: labRustSoft,
        ),
        pitfall(
          title: 'Reading aspects you did not subscribe to',
          body: 'A descendant that calls inheritFrom with aspect: \'colorTone\' '
              'and then reads model.fontScale will appear to work — but it '
              'will not rebuild when fontScale changes. The compiler cannot '
              'protect you. Discipline: one subscription per aspect read.',
          tone: labOcherSoft,
        ),
        pitfall(
          title: 'A null InheritedModel ancestor',
          body: 'inheritFrom<T> returns T? — it is null when no ancestor T '
              'exists. Don\'t bang it (`!`); have a sensible default at the '
              'call site, or assert at the model boundary so the failure '
              'mode is explicit.',
          tone: labOcherSoft,
        ),
        pitfall(
          title: 'Aspects with mutable equality',
          body: 'If your aspect type implements == in terms of fields that '
              'change after the object is added to the Set<A>, the Set\'s '
              'internal hash bucket points to a stale entry. The aspect '
              'becomes unfindable. Aspects must be value-stable.',
          tone: labRustSoft,
        ),
        pitfall(
          title: 'Calling inheritFrom from outside build',
          body: 'Like dependOnInheritedWidgetOfExactType, this method is only '
              'safe during build (or didChangeDependencies). Calling it from '
              'initState fails the framework\'s assertion. Move the call '
              'into build, or use the static getElementForInheritedWidgetOf'
              'ExactType for read-only access.',
          tone: labOcherSoft,
        ),
        pitfall(
          title: 'Mixing aspect:null with named aspects',
          body: 'On the same context, a no-aspect registration is treated as '
              '"all aspects" by most updateShouldNotifyDependent implementations '
              '— and an additional named aspect on the same context becomes '
              'redundant. Pick one mode per context.',
          tone: labOcherSoft,
        ),
      ],
    ),
  );
}

Widget pitfall({required String title, required String body, required Color tone}) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: tone,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: labRule, width: 1),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.warning_amber_rounded, size: 20, color: labInk),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: styleCardTitle),
              SizedBox(height: 4),
              Text(body, style: styleBodySoft),
            ],
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 11 — PERFORMANCE REASONING
// ===========================================================================

Widget performanceReasoningSection() {
  return sectionContainer(
    label: 'WHY IT IS FASTER',
    title: 'Counting the rebuilds you avoid',
    lead: 'A back-of-envelope calculation. Imagine a screen with 200 leaf '
        'widgets, each one reading exactly one of four aspects. With a plain '
        'InheritedWidget, every aspect mutation rebuilds all 200. With an '
        'InheritedModel, only the ~50 that subscribed to that aspect rebuild. '
        'Times the average frame budget, times the number of mutations per '
        'second, that is real money.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(child: perfStat('200', 'leaf widgets')),
            SizedBox(width: 12),
            Expanded(child: perfStat('4', 'independent aspects')),
            SizedBox(width: 12),
            Expanded(child: perfStat('~50', 'rebuilds per aspect change')),
            SizedBox(width: 12),
            Expanded(child: perfStat('75%', 'fewer build() calls')),
          ],
        ),
        SizedBox(height: 14),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: labCreamDeep,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: labRule, width: 0.8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              perfBar('InheritedWidget', 1.00, labSlate, '200 / 200 rebuild'),
              SizedBox(height: 6),
              perfBar('InheritedModel — colorTone changed', 0.25, labTeal, '50 / 200 rebuild'),
              SizedBox(height: 6),
              perfBar('InheritedModel — fontScale changed', 0.25, labOcher, '50 / 200 rebuild'),
              SizedBox(height: 6),
              perfBar('InheritedModel — density changed', 0.25, labMoss, '50 / 200 rebuild'),
              SizedBox(height: 6),
              perfBar('InheritedModel — isAccent changed', 0.25, labBerry, '50 / 200 rebuild'),
            ],
          ),
        ),
        SizedBox(height: 14),
        codeBlock(<String>[
          '// The savings come from TWO short-circuits:',
          '//',
          '//   1. updateShouldNotify() returning false skips the entire walk',
          '//      over dependents. Cost: O(1).',
          '//',
          '//   2. updateShouldNotifyDependent() returning false for a',
          '//      dependent skips that dependent\'s rebuild. Cost: one bool',
          '//      per dependent — much cheaper than running build().',
          '//',
          '// Caveat: BOTH gates must be cheap. If your gate computation costs',
          '// 0.5 ms per dependent and you have 1000 dependents, you have',
          '// reintroduced the cost you tried to avoid. Field comparison only.',
        ]),
      ],
    ),
  );
}

Widget perfStat(String value, String label) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: labRule, width: 0.8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: labTealDeep,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 2),
        Text(label, style: styleBodySoft),
      ],
    ),
  );
}

Widget perfBar(String label, double fraction, Color color, String trailing) {
  return Row(
    children: <Widget>[
      SizedBox(
        width: 200,
        child: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: labInk)),
      ),
      SizedBox(width: 8),
      Expanded(
        child: Stack(
          children: <Widget>[
            Container(
              height: 14,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: labRule, width: 0.6),
              ),
            ),
            FractionallySizedBox(
              widthFactor: fraction.clamp(0.0, 1.0),
              child: Container(
                height: 14,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(width: 8),
      SizedBox(
        width: 110,
        child: Text(
          trailing,
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: labInkSoft),
        ),
      ),
    ],
  );
}

// ===========================================================================
// SECTION 12 — Footer
// ===========================================================================

Widget footerSection() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 22, vertical: 18),
    decoration: BoxDecoration(
      color: labInk,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: labTeal,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(Icons.hub_outlined, color: Colors.white, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'InheritedModel.inheritFrom<T> — aspect-scoped dependency at the framework level.',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14),
              ),
              SizedBox(height: 2),
              Text(
                'Two gates (updateShouldNotify, updateShouldNotifyDependent) and a Set<A> per dependent — that\'s the whole machine.',
                style: TextStyle(color: Color(0xFFB6BFCB), fontWeight: FontWeight.w400, fontSize: 12),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text('flutter / widgets', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1)),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SHARED PRIMITIVES
// ===========================================================================

Widget sectionContainer({
  required String label,
  required String title,
  required String lead,
  required Widget child,
}) {
  return Container(
    padding: EdgeInsets.fromLTRB(22, 22, 22, 22),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: labRule, width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x0A000000),
          blurRadius: 16,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: labTealSoft,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: labTealDeep,
                  letterSpacing: 1.4,
                ),
              ),
            ),
            SizedBox(width: 10),
            Container(height: 1, width: 40, color: labRule),
          ],
        ),
        SizedBox(height: 10),
        Text(title, style: styleSectionTitle),
        SizedBox(height: 6),
        Text(lead, style: styleSectionLead),
        SizedBox(height: 16),
        child,
      ],
    ),
  );
}

Widget codeBlock(List<String> lines) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Color(0xFFFBF6E6),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: labRule, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (final String l in lines)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1),
            child: Text(
              l.isEmpty ? ' ' : l,
              style: l.startsWith('//') ? styleCodeFaint : styleCode,
            ),
          ),
      ],
    ),
  );
}

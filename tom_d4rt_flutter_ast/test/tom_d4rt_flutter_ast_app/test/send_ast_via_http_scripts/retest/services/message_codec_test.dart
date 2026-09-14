// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
//  MessageCodec<T> deep-demo - manually authored, fully-static widget tree.
//  Subject: Flutter `package:flutter/services.dart` codec family.
//
//  This file is interpreted by the D4rt analyzer-free interpreter. The tree
//  is deliberately static: no StatefulWidget, no Timer, no Future, no Stream,
//  no scroll listeners. Durations are Duration.zero. Animations, where they
//  appear, use AlwaysStoppedAnimation<double>(value).
//
//  Layout overview (top -> bottom):
//    1.  _HeroHeaderSection
//    2.  _FamilyTreeSection
//    3.  _PerCodecCardsSection
//    4.  _StandardTypeTableSection
//    5.  _MethodEnvelopeSection
//    6.  _SnippetSection
//    7.  _ChannelMatrixSection
//    8.  _PitfallsSection
//    9.  _MigrationCheatSection
//   10.  _FooterSection
//
//  Gradients used (>= 6):
//    - hero banner          (top-left -> bottom-right, indigo -> purple)
//    - family tree backdrop (left -> right, teal -> cyan)
//    - per-codec card head  (top -> bottom, slate -> blue)
//    - type-table header    (top-right -> bottom-left, amber -> deep orange)
//    - envelope band        (linear, green -> teal)
//    - snippet panel        (top -> bottom, near-black -> dark grey)
//    - matrix header        (left -> right, deep purple -> pink)
//    - pitfalls band        (top -> bottom, red -> orange)
//    - cheat sheet band     (left -> right, blue -> indigo)
//    - footer band          (top -> bottom, grey -> blueGrey)
// -----------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'MessageCodec<T> Deep Demo',
    theme: ThemeData(
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: const Color(0xFFF5F6FA),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontFamily: 'Roboto', fontSize: 14),
      ),
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _HeroHeaderSection(),
            SizedBox(height: 28),
            _FamilyTreeSection(),
            SizedBox(height: 28),
            _PerCodecCardsSection(),
            SizedBox(height: 28),
            _StandardTypeTableSection(),
            SizedBox(height: 28),
            _MethodEnvelopeSection(),
            SizedBox(height: 28),
            _SnippetSection(),
            SizedBox(height: 28),
            _ChannelMatrixSection(),
            SizedBox(height: 28),
            _PitfallsSection(),
            SizedBox(height: 28),
            _MigrationCheatSection(),
            SizedBox(height: 28),
            _FooterSection(),
            SizedBox(height: 48),
          ],
        ),
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// 1) Hero header
// -----------------------------------------------------------------------------

class _HeroHeaderSection extends StatelessWidget {
  const _HeroHeaderSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(28, 36, 28, 36),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF1A237E),
            Color(0xFF311B92),
            Color(0xFF4A148C),
          ],
          stops: <double>[0.0, 0.55, 1.0],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0x33FFFFFF),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  border: Border.all(color: const Color(0x55FFFFFF), width: 1),
                ),
                child: const Icon(
                  Icons.swap_horiz,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'MessageCodec<T>',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'package:flutter/services.dart - platform channel encoding',
                      style: TextStyle(
                        color: Color(0xCCFFFFFF),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0x22FFFFFF),
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  border: Border.all(color: const Color(0x55FFFFFF), width: 1),
                ),
                child: const Text(
                  'flutter/services',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            'Codecs translate Dart values to/from ByteData frames that flow '
            'across the Flutter platform channels. Every channel is parameterised '
            'by a codec; choosing the right codec determines which Dart types '
            'survive the boundary, how big the payload is, and whether tooling '
            'can decode it.',
            style: TextStyle(
              color: Color(0xEEFFFFFF),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              _HeroBadge(label: 'Binary', icon: Icons.memory),
              _HeroBadge(label: 'UTF-8', icon: Icons.text_fields),
              _HeroBadge(label: 'JSON', icon: Icons.data_object),
              _HeroBadge(label: 'Standard', icon: Icons.account_tree),
              _HeroBadge(label: 'Method', icon: Icons.call_split),
              _HeroBadge(label: 'Event', icon: Icons.sensors),
            ],
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0x22000000),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: const Color(0x33FFFFFF), width: 1),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.lightbulb_outline, color: Colors.amberAccent, size: 20),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Rule of thumb: prefer StandardMessageCodec for new code; it '
                    'is the default for BasicMessageChannel/MethodChannel/EventChannel '
                    'and supports the broadest Dart-to-platform type set.',
                    style: TextStyle(
                      color: Color(0xFFFFE082),
                      fontSize: 13,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  final String label;
  final IconData icon;
  const _HeroBadge({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0x22FFFFFF),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: const Color(0x55FFFFFF), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 2) Family tree
// -----------------------------------------------------------------------------

class _FamilyTreeSection extends StatelessWidget {
  const _FamilyTreeSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            Color(0xFF004D40),
            Color(0xFF00695C),
            Color(0xFF00838F),
          ],
        ),
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
                child: const Text(
                  'SECTION 2',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Codec family tree',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Padding(
            padding: EdgeInsets.only(left: 2, top: 2),
            child: Text(
              'Inheritance and channel relationships at a glance.',
              style: TextStyle(
                color: Color(0xCCFFFFFF),
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(height: 18),
          _TreeRoot(),
          const SizedBox(height: 18),
          _TreeLegend(),
        ],
      ),
    );
  }
}

class _TreeRoot extends StatelessWidget {
  const _TreeRoot();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _TreeNode(
          title: 'MessageCodec<T>',
          subtitle: 'abstract: encode/decode ByteData <-> T',
          color: Color(0xFF263238),
          accent: Color(0xFFFFD54F),
        ),
        _TreeArrow(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: _TreeNode(
                title: 'BinaryCodec',
                subtitle: 'pass-through ByteData',
                color: Color(0xFF1B5E20),
                accent: Color(0xFFB9F6CA),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _TreeNode(
                title: 'StringCodec',
                subtitle: 'UTF-8 String',
                color: Color(0xFF0D47A1),
                accent: Color(0xFF82B1FF),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _TreeNode(
                title: 'JSONMessageCodec',
                subtitle: 'JSON text via StringCodec',
                color: Color(0xFFE65100),
                accent: Color(0xFFFFD180),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _TreeNode(
                title: 'StandardMessageCodec',
                subtitle: 'tagged binary',
                color: Color(0xFF6A1B9A),
                accent: Color(0xFFE1BEE7),
              ),
            ),
          ],
        ),
        SizedBox(height: 24),
        _TreeBracketLabel('MethodCodec extends MessageCodec layout'),
        _TreeArrow(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: _TreeNode(
                title: 'JSONMethodCodec',
                subtitle: 'method calls as JSON maps',
                color: Color(0xFFBF360C),
                accent: Color(0xFFFFAB91),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _TreeNode(
                title: 'StandardMethodCodec',
                subtitle: 'method calls as standard frames',
                color: Color(0xFF4A148C),
                accent: Color(0xFFCE93D8),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TreeNode extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final Color accent;
  const _TreeNode({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: accent, width: 1.5),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: accent,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _TreeArrow extends StatelessWidget {
  const _TreeArrow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 2,
            height: 16,
            color: Colors.white.withValues(alpha: 0.6),
          ),
          Icon(
            Icons.arrow_drop_down,
            color: Colors.white.withValues(alpha: 0.8),
            size: 22,
          ),
        ],
      ),
    );
  }
}

class _TreeBracketLabel extends StatelessWidget {
  final String label;
  const _TreeBracketLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _TreeLegend extends StatelessWidget {
  const _TreeLegend();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.25),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            'Legend',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 14,
            runSpacing: 8,
            children: <Widget>[
              _LegendDot(color: Color(0xFFB9F6CA), label: 'Binary family'),
              _LegendDot(color: Color(0xFF82B1FF), label: 'Text family'),
              _LegendDot(color: Color(0xFFFFD180), label: 'JSON family'),
              _LegendDot(color: Color(0xFFE1BEE7), label: 'Standard family'),
              _LegendDot(color: Color(0xFFFFD54F), label: 'Abstract root'),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// 3) Per-codec cards
// -----------------------------------------------------------------------------

class _PerCodecCardsSection extends StatelessWidget {
  const _PerCodecCardsSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionHeader(
            tag: 'SECTION 3',
            title: 'Per-codec cards',
            subtitle:
                'Encoding model, supported types, and constructor signature.',
            accent: Color(0xFF1565C0),
          ),
          const SizedBox(height: 16),
          _CodecCard(
            name: 'BinaryCodec',
            tagline: 'identity codec - returns the ByteData unchanged',
            modelLabel: 'BINARY',
            modelColor: Color(0xFF2E7D32),
            constructor: 'const BinaryCodec()',
            supportedTypes: <String>['ByteData', '<null>'],
            notes:
                'Used when the platform side already controls the byte layout. '
                'Useful for raw blobs (images, archives, custom protocols).',
            iconLeft: Icons.memory,
            accent: Color(0xFF2E7D32),
          ),
          const SizedBox(height: 14),
          _CodecCard(
            name: 'StringCodec',
            tagline: 'UTF-8 String <-> ByteData',
            modelLabel: 'TEXT',
            modelColor: Color(0xFF1565C0),
            constructor: 'const StringCodec()',
            supportedTypes: <String>['String', '<null>'],
            notes:
                'Encodes Strings as UTF-8 bytes. Pairs naturally with '
                'BasicMessageChannel<String> for textual protocols (logging '
                'channels, simple IPC).',
            iconLeft: Icons.text_fields,
            accent: Color(0xFF1565C0),
          ),
          const SizedBox(height: 14),
          _CodecCard(
            name: 'JSONMessageCodec',
            tagline: 'JSON text encoded as UTF-8',
            modelLabel: 'TEXT/JSON',
            modelColor: Color(0xFFEF6C00),
            constructor: 'const JSONMessageCodec()',
            supportedTypes: <String>[
              'null',
              'bool',
              'num',
              'String',
              'List',
              'Map<String, dynamic>',
            ],
            notes:
                'Internally delegates to dart:convert json.encode/decode and '
                'then StringCodec. Lowest common denominator for cross-language '
                'tooling; not great for binary payloads.',
            iconLeft: Icons.data_object,
            accent: Color(0xFFEF6C00),
          ),
          const SizedBox(height: 14),
          _CodecCard(
            name: 'JSONMethodCodec',
            tagline: 'MethodCall <-> JSON map { method, args }',
            modelLabel: 'METHOD/JSON',
            modelColor: Color(0xFFBF360C),
            constructor: 'const JSONMethodCodec()',
            supportedTypes: <String>[
              'method: String',
              'args: JSONMessageCodec-compatible',
              'envelope: list of 1 (success) or 3 (error)',
            ],
            notes:
                'Wraps a JSONMessageCodec to encode MethodCall objects and '
                'success/error envelopes. Used when bridging to JS, browser '
                'plugins, or any side that prefers JSON.',
            iconLeft: Icons.call_split,
            accent: Color(0xFFBF360C),
          ),
          const SizedBox(height: 14),
          _CodecCard(
            name: 'StandardMessageCodec',
            tagline: 'tagged binary - the Flutter default',
            modelLabel: 'BINARY/TAGGED',
            modelColor: Color(0xFF6A1B9A),
            constructor: 'const StandardMessageCodec()',
            supportedTypes: <String>[
              'null',
              'bool',
              'int (varies by host)',
              'double',
              'String',
              'Uint8List',
              'Int32List',
              'Int64List',
              'Float32List',
              'Float64List',
              'List',
              'Map',
            ],
            notes:
                'Compact, fast, supports the broadest set of Dart values that '
                'cross the boundary. Each value is preceded by a 1-byte type tag. '
                'Used by default in BasicMessageChannel and MethodChannel.',
            iconLeft: Icons.account_tree,
            accent: Color(0xFF6A1B9A),
          ),
          const SizedBox(height: 14),
          _CodecCard(
            name: 'StandardMethodCodec',
            tagline: 'MethodCall + envelopes over StandardMessageCodec',
            modelLabel: 'METHOD/BINARY',
            modelColor: Color(0xFF4527A0),
            constructor: 'const StandardMethodCodec([StandardMessageCodec()])',
            supportedTypes: <String>[
              'method: String',
              'args: StandardMessageCodec-compatible',
              'success envelope: 0x00 + value',
              'error envelope: 0x01 + code + message + details',
            ],
            notes:
                'The default for MethodChannel and EventChannel. Encodes a leading '
                'envelope byte: 0x00 = success, 0x01 = error. The error frame '
                'carries a String code, optional String message, and optional '
                'standard-encoded details.',
            iconLeft: Icons.account_balance_wallet,
            accent: Color(0xFF4527A0),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String tag;
  final String title;
  final String subtitle;
  final Color accent;
  const _SectionHeader({
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        // Flutter requires uniform-coloured borders when borderRadius is
        // set; the original design wanted a coloured 5-px left accent bar
        // plus thin alpha-0.1 sides on top/right/bottom, which is
        // non-uniform. We drop borderRadius (the corners stay square) so
        // the multi-coloured Border stays visible. This was the
        // _SectionHeader card, instantiated once per section, which
        // produced one `A borderRadius can only be given on borders with
        // uniform colors.` error per instance (~7 in this demo).
        border: Border(
          left: BorderSide(color: accent, width: 5),
          top: BorderSide(color: accent.withValues(alpha: 0.1)),
          right: BorderSide(color: accent.withValues(alpha: 0.1)),
          bottom: BorderSide(color: accent.withValues(alpha: 0.1)),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: const BorderRadius.all(Radius.circular(6)),
            ),
            child: Text(
              tag,
              style: TextStyle(
                color: accent,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF1F2933),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF52606D),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CodecCard extends StatelessWidget {
  final String name;
  final String tagline;
  final String modelLabel;
  final Color modelColor;
  final String constructor;
  final List<String> supportedTypes;
  final String notes;
  final IconData iconLeft;
  final Color accent;

  const _CodecCard({
    required this.name,
    required this.tagline,
    required this.modelLabel,
    required this.modelColor,
    required this.constructor,
    required this.supportedTypes,
    required this.notes,
    required this.iconLeft,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  accent.withValues(alpha: 0.95),
                  accent.withValues(alpha: 0.75),
                ],
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
                  ),
                  child: Icon(iconLeft, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        tagline,
                        style: const TextStyle(
                          color: Color(0xEEFFFFFF),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: modelColor,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
                  ),
                  child: Text(
                    modelLabel,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _CardLabel('Constructor signature'),
                const SizedBox(height: 6),
                _CodeLine(constructor),
                const SizedBox(height: 12),
                _CardLabel('Supported types'),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: supportedTypes
                      .map((String t) => _TypeChip(label: t, accent: accent))
                      .toList(),
                ),
                const SizedBox(height: 12),
                _CardLabel('Notes'),
                const SizedBox(height: 6),
                Text(
                  notes,
                  style: const TextStyle(
                    color: Color(0xFF3E4C59),
                    fontSize: 13,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CardLabel extends StatelessWidget {
  final String label;
  const _CardLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: const TextStyle(
        color: Color(0xFF7B8794),
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.3,
      ),
    );
  }
}

class _CodeLine extends StatelessWidget {
  final String text;
  const _CodeLine(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF263238),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFFB2EBF2),
          fontSize: 12.5,
          fontFamily: 'monospace',
          fontFamilyFallback: <String>['Courier'],
          height: 1.4,
        ),
      ),
    );
  }
}

class _TypeChip extends StatelessWidget {
  final String label;
  final Color accent;
  const _TypeChip({required this.label, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.1),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        border: Border.all(color: accent.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: accent,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 4) StandardMessageCodec type-table
// -----------------------------------------------------------------------------

class _StandardTypeTableSection extends StatelessWidget {
  const _StandardTypeTableSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionHeader(
            tag: 'SECTION 4',
            title: 'StandardMessageCodec type table',
            subtitle: 'Binary tag byte -> Dart type -> wire format.',
            accent: Color(0xFFEF6C00),
          ),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: <Color>[
                        Color(0xFFFFA000),
                        Color(0xFFFF6F00),
                        Color(0xFFE65100),
                      ],
                    ),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: Row(
                    children: const <Widget>[
                      Icon(Icons.table_chart, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'Wire-format tag table',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
                _TypeTableHeader(),
                _TypeTableRow(
                  tag: '0x00', dartType: 'null',
                  wire: '(no payload)',
                  zebra: false,
                ),
                _TypeTableRow(
                  tag: '0x01', dartType: 'true',
                  wire: '(no payload)',
                  zebra: true,
                ),
                _TypeTableRow(
                  tag: '0x02', dartType: 'false',
                  wire: '(no payload)',
                  zebra: false,
                ),
                _TypeTableRow(
                  tag: '0x03', dartType: 'int (32-bit)',
                  wire: '4 bytes LE int32',
                  zebra: true,
                ),
                _TypeTableRow(
                  tag: '0x04', dartType: 'int (64-bit)',
                  wire: '8 bytes LE int64',
                  zebra: false,
                ),
                _TypeTableRow(
                  tag: '0x05', dartType: 'BigInt (removed)',
                  wire: 'legacy: hex-string',
                  zebra: true,
                ),
                _TypeTableRow(
                  tag: '0x06', dartType: 'double',
                  wire: 'aligned 8 bytes LE IEEE-754',
                  zebra: false,
                ),
                _TypeTableRow(
                  tag: '0x07', dartType: 'String',
                  wire: 'size + UTF-8 bytes',
                  zebra: true,
                ),
                _TypeTableRow(
                  tag: '0x08', dartType: 'Uint8List',
                  wire: 'size + raw bytes',
                  zebra: false,
                ),
                _TypeTableRow(
                  tag: '0x09', dartType: 'Int32List',
                  wire: 'aligned size + LE int32 elements',
                  zebra: true,
                ),
                _TypeTableRow(
                  tag: '0x0A', dartType: 'Int64List',
                  wire: 'aligned size + LE int64 elements',
                  zebra: false,
                ),
                _TypeTableRow(
                  tag: '0x0B', dartType: 'Float64List',
                  wire: 'aligned size + LE float64 elements',
                  zebra: true,
                ),
                _TypeTableRow(
                  tag: '0x0C', dartType: 'List',
                  wire: 'size + recursively-encoded items',
                  zebra: false,
                ),
                _TypeTableRow(
                  tag: '0x0D', dartType: 'Map',
                  wire: 'size + alternating key/value pairs',
                  zebra: true,
                ),
                _TypeTableRow(
                  tag: '0x0E', dartType: 'Float32List',
                  wire: 'aligned size + LE float32 elements',
                  zebra: false,
                ),
                _TypeTableTail(),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _SizeEncodingPanel(),
        ],
      ),
    );
  }
}

class _TypeTableHeader extends StatelessWidget {
  const _TypeTableHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        border: Border(
          bottom: BorderSide(color: const Color(0xFFFFCC80), width: 1),
        ),
      ),
      child: Row(
        children: const <Widget>[
          SizedBox(
            width: 70,
            child: Text(
              'TAG',
              style: TextStyle(
                color: Color(0xFFE65100),
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
          SizedBox(
            width: 160,
            child: Text(
              'DART TYPE',
              style: TextStyle(
                color: Color(0xFFE65100),
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'WIRE FORMAT',
              style: TextStyle(
                color: Color(0xFFE65100),
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TypeTableRow extends StatelessWidget {
  final String tag;
  final String dartType;
  final String wire;
  final bool zebra;
  const _TypeTableRow({
    required this.tag,
    required this.dartType,
    required this.wire,
    required this.zebra,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: zebra ? const Color(0xFFFFFBF5) : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFFFE0B2).withValues(alpha: 0.7),
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 70,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFE65100).withValues(alpha: 0.1),
                borderRadius: const BorderRadius.all(Radius.circular(4)),
              ),
              alignment: Alignment.center,
              child: Text(
                tag,
                style: const TextStyle(
                  color: Color(0xFFE65100),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 160,
            child: Text(
              dartType,
              style: const TextStyle(
                color: Color(0xFF1F2933),
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              wire,
              style: const TextStyle(
                color: Color(0xFF52606D),
                fontSize: 12.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TypeTableTail extends StatelessWidget {
  const _TypeTableTail();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
      decoration: const BoxDecoration(
        color: Color(0xFFFFF8E1),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Icon(Icons.info_outline, color: Color(0xFFE65100), size: 16),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Aligned-list payloads (Int32List, Int64List, Float32List, '
              'Float64List) include padding bytes so the element array starts '
              'on its natural alignment in the buffer.',
              style: TextStyle(
                color: Color(0xFF6D4C41),
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SizeEncodingPanel extends StatelessWidget {
  const _SizeEncodingPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: const Color(0xFFFFE0B2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            'Size encoding',
            style: TextStyle(
              color: Color(0xFFE65100),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Lengths < 254  -> 1 byte (the value itself)\n'
            'Lengths < 65536  -> 1 byte (0xFE) + 2 bytes LE uint16\n'
            'Otherwise       -> 1 byte (0xFF) + 4 bytes LE uint32',
            style: TextStyle(
              color: Color(0xFF3E4C59),
              fontSize: 13,
              fontFamily: 'monospace',
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 5) StandardMethodCodec envelopes
// -----------------------------------------------------------------------------

class _MethodEnvelopeSection extends StatelessWidget {
  const _MethodEnvelopeSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionHeader(
            tag: 'SECTION 5',
            title: 'StandardMethodCodec envelopes',
            subtitle: 'Method call, success reply, error reply frames.',
            accent: Color(0xFF00796B),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Color(0xFF1B5E20),
                  Color(0xFF2E7D32),
                  Color(0xFF00695C),
                ],
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _EnvelopeBlock(
                  title: 'MethodCall frame (invocation)',
                  description:
                      'Sent from client to handler. No envelope byte - the '
                      'frame is a Standard-encoded String followed by a '
                      'Standard-encoded arguments value.',
                  bytes: <_ByteCell>[
                    _ByteCell(tag: '07', label: 'String tag', tone: _ByteTone.tag),
                    _ByteCell(tag: 'NN', label: 'len(name)', tone: _ByteTone.size),
                    _ByteCell(tag: '..', label: 'UTF-8 method name', tone: _ByteTone.payload),
                    _ByteCell(tag: 'TT', label: 'args type tag', tone: _ByteTone.tag),
                    _ByteCell(tag: '..', label: 'standard-encoded args', tone: _ByteTone.payload),
                  ],
                ),
                const SizedBox(height: 14),
                _EnvelopeBlock(
                  title: 'Success reply envelope',
                  description:
                      'Returned to the caller when the handler completes '
                      'normally. Leading 0x00 byte tells the caller "this is a '
                      'value, not an error".',
                  bytes: <_ByteCell>[
                    _ByteCell(tag: '00', label: 'success', tone: _ByteTone.success),
                    _ByteCell(tag: 'TT', label: 'value type tag', tone: _ByteTone.tag),
                    _ByteCell(tag: '..', label: 'standard-encoded value', tone: _ByteTone.payload),
                  ],
                ),
                const SizedBox(height: 14),
                _EnvelopeBlock(
                  title: 'Error reply envelope',
                  description:
                      'Carries a structured PlatformException equivalent: '
                      'String code, optional message, and an optional '
                      'standard-encoded details value.',
                  bytes: <_ByteCell>[
                    _ByteCell(tag: '01', label: 'error', tone: _ByteTone.error),
                    _ByteCell(tag: 'TT', label: 'code String tag', tone: _ByteTone.tag),
                    _ByteCell(tag: '..', label: 'UTF-8 error code', tone: _ByteTone.payload),
                    _ByteCell(tag: 'TT', label: 'message tag', tone: _ByteTone.tag),
                    _ByteCell(tag: '..', label: 'UTF-8 message or null', tone: _ByteTone.payload),
                    _ByteCell(tag: 'TT', label: 'details tag', tone: _ByteTone.tag),
                    _ByteCell(tag: '..', label: 'details or null', tone: _ByteTone.payload),
                  ],
                ),
                const SizedBox(height: 14),
                _EnvelopeBlock(
                  title: 'Not-implemented reply',
                  description:
                      'Special case sent when the handler returns null or '
                      'throws MissingPluginException. The wire format is a '
                      'zero-length ByteData buffer.',
                  bytes: <_ByteCell>[
                    _ByteCell(tag: '--', label: 'empty buffer (length 0)', tone: _ByteTone.empty),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum _ByteTone { tag, size, payload, success, error, empty }

class _ByteCell {
  final String tag;
  final String label;
  final _ByteTone tone;
  const _ByteCell({required this.tag, required this.label, required this.tone});
}

class _EnvelopeBlock extends StatelessWidget {
  final String title;
  final String description;
  final List<_ByteCell> bytes;
  const _EnvelopeBlock({
    required this.title,
    required this.description,
    required this.bytes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.25),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(
              color: Color(0xDDFFFFFF),
              fontSize: 12,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: bytes.map(_renderCell).toList(),
          ),
        ],
      ),
    );
  }

  Widget _renderCell(_ByteCell cell) {
    Color bg;
    Color border;
    Color textColor;
    switch (cell.tone) {
      case _ByteTone.tag:
        bg = const Color(0xFF26C6DA);
        border = const Color(0xFFB2EBF2);
        textColor = Colors.black;
        break;
      case _ByteTone.size:
        bg = const Color(0xFFFFCA28);
        border = const Color(0xFFFFE082);
        textColor = Colors.black;
        break;
      case _ByteTone.payload:
        bg = const Color(0xFF7E57C2);
        border = const Color(0xFFD1C4E9);
        textColor = Colors.white;
        break;
      case _ByteTone.success:
        bg = const Color(0xFF66BB6A);
        border = const Color(0xFFC8E6C9);
        textColor = Colors.black;
        break;
      case _ByteTone.error:
        bg = const Color(0xFFEF5350);
        border = const Color(0xFFFFCDD2);
        textColor = Colors.white;
        break;
      case _ByteTone.empty:
        bg = const Color(0xFF455A64);
        border = const Color(0xFFCFD8DC);
        textColor = Colors.white;
        break;
    }
    return Container(
      width: 130,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        border: Border.all(color: border, width: 1.2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            cell.tag,
            style: TextStyle(
              color: textColor,
              fontSize: 13,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            cell.label,
            style: TextStyle(
              color: textColor.withValues(alpha: 0.85),
              fontSize: 10.5,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 6) Code snippets
// -----------------------------------------------------------------------------

class _SnippetSection extends StatelessWidget {
  const _SnippetSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionHeader(
            tag: 'SECTION 6',
            title: 'Encode / decode snippets',
            subtitle: 'Practical usage cribsheet.',
            accent: Color(0xFF37474F),
          ),
          const SizedBox(height: 14),
          _SnippetCard(
            title: 'StandardMessageCodec',
            language: 'Dart',
            code:
                "const codec = StandardMessageCodec();\n"
                "// Encode a value:\n"
                "final ByteData? bytes = codec.encodeMessage(<String, Object?>{\n"
                "  'id': 42,\n"
                "  'tags': <String>['platform', 'codec'],\n"
                "  'payload': Uint8List.fromList(<int>[0xCA, 0xFE]),\n"
                "});\n"
                "// Decode it again:\n"
                "final Object? value = codec.decodeMessage(bytes);",
          ),
          const SizedBox(height: 12),
          _SnippetCard(
            title: 'StandardMethodCodec',
            language: 'Dart',
            code:
                "const codec = StandardMethodCodec();\n"
                "final ByteData call = codec.encodeMethodCall(\n"
                "  const MethodCall('open', <String, Object?>{'path': '/tmp/x'}),\n"
                ");\n"
                "// Success envelope (server side):\n"
                "final ByteData ok = codec.encodeSuccessEnvelope(<String>['done']);\n"
                "// Error envelope (server side):\n"
                "final ByteData err = codec.encodeErrorEnvelope(\n"
                "  code: 'IO_ERROR',\n"
                "  message: 'cannot read',\n"
                "  details: <String, Object?>{'errno': 13},\n"
                ");",
          ),
          const SizedBox(height: 12),
          _SnippetCard(
            title: 'BinaryCodec / StringCodec',
            language: 'Dart',
            code:
                "const binary = BinaryCodec();\n"
                "final ByteData? raw = binary.encodeMessage(\n"
                "  ByteData.view(Uint8List.fromList(<int>[1,2,3]).buffer),\n"
                ");\n"
                "\n"
                "const text = StringCodec();\n"
                "final ByteData? hello = text.encodeMessage('hi');\n"
                "final String? back = text.decodeMessage(hello);",
          ),
          const SizedBox(height: 12),
          _SnippetCard(
            title: 'JSONMessageCodec / JSONMethodCodec',
            language: 'Dart',
            code:
                "const jsonMsg = JSONMessageCodec();\n"
                "final ByteData? raw = jsonMsg.encodeMessage(<String, Object?>{\n"
                "  'event': 'tap', 'count': 3,\n"
                "});\n"
                "\n"
                "const jsonMethod = JSONMethodCodec();\n"
                "final ByteData? frame = jsonMethod.encodeMethodCall(\n"
                "  const MethodCall('ping'),\n"
                ");",
          ),
        ],
      ),
    );
  }
}

class _SnippetCard extends StatelessWidget {
  final String title;
  final String language;
  final String code;
  const _SnippetCard({
    required this.title,
    required this.language,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xFF0D1117),
            Color(0xFF161B22),
            Color(0xFF1F2937),
          ],
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: const Color(0xFF263238)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.04),
              border: Border(
                bottom: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF5F56),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFBD2E),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFF27C93F),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF26C6DA).withValues(alpha: 0.18),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    border: Border.all(
                      color: const Color(0xFF26C6DA).withValues(alpha: 0.5),
                    ),
                  ),
                  child: Text(
                    language,
                    style: const TextStyle(
                      color: Color(0xFFB2EBF2),
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Text(
              code,
              style: const TextStyle(
                color: Color(0xFFE3F2FD),
                fontSize: 12.5,
                fontFamily: 'monospace',
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 7) Channel x Codec matrix
// -----------------------------------------------------------------------------

class _ChannelMatrixSection extends StatelessWidget {
  const _ChannelMatrixSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionHeader(
            tag: 'SECTION 7',
            title: 'Channel x Codec matrix',
            subtitle: 'Which channel ships with which codec by default.',
            accent: Color(0xFFAD1457),
          ),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[
                        Color(0xFF6A1B9A),
                        Color(0xFFAD1457),
                        Color(0xFFEC407A),
                      ],
                    ),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: Row(
                    children: const <Widget>[
                      Icon(Icons.view_module, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'Channels and their codecs',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                _MatrixHeaderRow(),
                _MatrixRow(
                  channel: 'BasicMessageChannel<T>',
                  defaultCodec: 'depends on T',
                  alt: 'StandardMessage / String / JSONMessage / Binary',
                  zebra: false,
                ),
                _MatrixRow(
                  channel: 'MethodChannel',
                  defaultCodec: 'StandardMethodCodec',
                  alt: 'JSONMethodCodec',
                  zebra: true,
                ),
                _MatrixRow(
                  channel: 'OptionalMethodChannel',
                  defaultCodec: 'StandardMethodCodec',
                  alt: 'JSONMethodCodec',
                  zebra: false,
                ),
                _MatrixRow(
                  channel: 'EventChannel',
                  defaultCodec: 'StandardMethodCodec',
                  alt: 'JSONMethodCodec',
                  zebra: true,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFCE4EC),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(12)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Icon(Icons.tips_and_updates, color: Color(0xFFAD1457)),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'BasicMessageChannel<T> selects a codec via its '
                          'generic parameter: BasicMessageChannel<String> '
                          'defaults to StringCodec, BasicMessageChannel<dynamic> '
                          'to StandardMessageCodec, etc.',
                          style: TextStyle(
                            color: Color(0xFF880E4F),
                            fontSize: 12.5,
                            height: 1.45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MatrixHeaderRow extends StatelessWidget {
  const _MatrixHeaderRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: const BoxDecoration(
        color: Color(0xFFFCE4EC),
        border: Border(
          bottom: BorderSide(color: Color(0xFFF8BBD0)),
        ),
      ),
      child: Row(
        children: const <Widget>[
          SizedBox(
            width: 200,
            child: Text(
              'CHANNEL',
              style: TextStyle(
                color: Color(0xFFAD1457),
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
          SizedBox(
            width: 180,
            child: Text(
              'DEFAULT CODEC',
              style: TextStyle(
                color: Color(0xFFAD1457),
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'ALTERNATIVES',
              style: TextStyle(
                color: Color(0xFFAD1457),
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MatrixRow extends StatelessWidget {
  final String channel;
  final String defaultCodec;
  final String alt;
  final bool zebra;
  const _MatrixRow({
    required this.channel,
    required this.defaultCodec,
    required this.alt,
    required this.zebra,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: zebra ? const Color(0xFFFFF5F8) : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFF8BBD0).withValues(alpha: 0.6),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 200,
            child: Text(
              channel,
              style: const TextStyle(
                color: Color(0xFF1F2933),
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: 'monospace',
              ),
            ),
          ),
          SizedBox(
            width: 180,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFAD1457).withValues(alpha: 0.1),
                borderRadius: const BorderRadius.all(Radius.circular(6)),
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                defaultCodec,
                style: const TextStyle(
                  color: Color(0xFFAD1457),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              alt,
              style: const TextStyle(
                color: Color(0xFF52606D),
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 8) Pitfalls
// -----------------------------------------------------------------------------

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionHeader(
            tag: 'SECTION 8',
            title: 'Common pitfalls',
            subtitle: 'Things that bite when crossing the boundary.',
            accent: Color(0xFFC62828),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color(0xFFB71C1C),
                  Color(0xFFD84315),
                  Color(0xFFE65100),
                ],
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _PitfallTile(
                  icon: Icons.block,
                  title: 'No custom types',
                  body:
                      'StandardMessageCodec does not serialize arbitrary Dart '
                      'classes. Either flatten to Maps/Lists or subclass the '
                      'codec and override writeValue / readValueOfType.',
                ),
                const SizedBox(height: 10),
                _PitfallTile(
                  icon: Icons.delete_forever,
                  title: 'BigInt removed (Flutter 2)',
                  body:
                      'Tag 0x05 (BigInt) was removed because most host '
                      'platforms have no native counterpart. Use String or '
                      'split into hi/lo ints if you need 128-bit values.',
                ),
                const SizedBox(height: 10),
                _PitfallTile(
                  icon: Icons.compare_arrows,
                  title: 'Endianness',
                  body:
                      'All numbers are little-endian on the wire regardless of '
                      'host architecture. ByteData provides Endian.little - '
                      'do not switch it.',
                ),
                const SizedBox(height: 10),
                _PitfallTile(
                  icon: Icons.copy_all,
                  title: 'ByteData ownership',
                  body:
                      'Buffers returned by encodeMessage are owned by the '
                      'caller; do not mutate them after handing them to the '
                      'channel.',
                ),
                const SizedBox(height: 10),
                _PitfallTile(
                  icon: Icons.warning_amber,
                  title: 'int width is platform-dependent',
                  body:
                      'On 32-bit platforms ints exceeding 2^31 are encoded as '
                      'tag 0x04 (int64). On the JS web host, all ints become '
                      'doubles - watch for precision loss.',
                ),
                const SizedBox(height: 10),
                _PitfallTile(
                  icon: Icons.linear_scale,
                  title: 'List of mixed types',
                  body:
                      'Each element carries its own type tag, so heterogeneous '
                      'lists work but cost an extra byte per element. Prefer '
                      'typed lists (Int32List, Float64List) for hot paths.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PitfallTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  const _PitfallTile({
    required this.icon,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.25),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  body,
                  style: const TextStyle(
                    color: Color(0xEEFFFFFF),
                    fontSize: 12.5,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 9) Migration / cheat sheet
// -----------------------------------------------------------------------------

class _MigrationCheatSection extends StatelessWidget {
  const _MigrationCheatSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SectionHeader(
            tag: 'SECTION 9',
            title: 'Migration / interop cheat sheet',
            subtitle: 'When to pick which codec.',
            accent: Color(0xFF1565C0),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Color(0xFF0D47A1),
                  Color(0xFF1565C0),
                  Color(0xFF283593),
                ],
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.22),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _CheatRow(
                  scenario: 'New Flutter plugin',
                  pick: 'StandardMethodCodec',
                  reason:
                      'Default everywhere. Smallest payload, broadest type '
                      'support, no extra dependencies.',
                ),
                const SizedBox(height: 10),
                _CheatRow(
                  scenario: 'Bridge to JavaScript / web',
                  pick: 'JSONMethodCodec',
                  reason:
                      'JS handlers usually parse JSON natively; avoids the '
                      'tag-byte machinery.',
                ),
                const SizedBox(height: 10),
                _CheatRow(
                  scenario: 'Raw binary blob (image, audio)',
                  pick: 'BinaryCodec',
                  reason:
                      'No reinterpretation - the ByteData is forwarded as-is, '
                      'zero copy on most platforms.',
                ),
                const SizedBox(height: 10),
                _CheatRow(
                  scenario: 'Plain UTF-8 string protocol',
                  pick: 'StringCodec',
                  reason:
                      'Minimal: just UTF-8 bytes. Pairs with BasicMessageChannel'
                      '<String>.',
                ),
                const SizedBox(height: 10),
                _CheatRow(
                  scenario: 'Need to send custom domain object',
                  pick: 'Subclass StandardMessageCodec',
                  reason:
                      'Override writeValue / readValueOfType, pick an unused '
                      'tag byte (>= 128 by convention).',
                ),
                const SizedBox(height: 10),
                _CheatRow(
                  scenario: 'Maximum interop with shell scripts',
                  pick: 'JSONMessageCodec',
                  reason:
                      'Anything that can read a UTF-8 JSON string can '
                      'consume the payload.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CheatRow extends StatelessWidget {
  final String scenario;
  final String pick;
  final String reason;
  const _CheatRow({
    required this.scenario,
    required this.pick,
    required this.reason,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.22),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 130,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
            ),
            child: Text(
              scenario,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.arrow_forward, color: Colors.white70, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD54F),
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Text(
                    pick,
                    style: const TextStyle(
                      color: Color(0xFF1A237E),
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  reason,
                  style: const TextStyle(
                    color: Color(0xEEFFFFFF),
                    fontSize: 12,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 10) Footer
// -----------------------------------------------------------------------------

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 22),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xFF455A64),
            Color(0xFF37474F),
            Color(0xFF263238),
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.menu_book, color: Colors.white70, size: 20),
              SizedBox(width: 10),
              Text(
                'References',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _FooterLink(
            label: 'flutter/services - MessageCodec',
            target: 'api.flutter.dev/flutter/services/MessageCodec-class.html',
          ),
          _FooterLink(
            label: 'flutter/services - StandardMessageCodec',
            target:
                'api.flutter.dev/flutter/services/StandardMessageCodec-class.html',
          ),
          _FooterLink(
            label: 'flutter/services - StandardMethodCodec',
            target:
                'api.flutter.dev/flutter/services/StandardMethodCodec-class.html',
          ),
          _FooterLink(
            label: 'Engine source - standard_message_codec.cc',
            target: 'github.com/flutter/engine - shell/platform/common',
          ),
          const SizedBox(height: 14),
          const Divider(color: Color(0x55FFFFFF), height: 1),
          const SizedBox(height: 12),
          const Text(
            'Generated as part of the D4rt flutter-ast deep-demo set. '
            'All widgets are static; no animation controllers, timers, '
            'or futures are used.',
            style: TextStyle(
              color: Color(0xCCFFFFFF),
              fontSize: 12,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'fully-static  -  analyzer-clean  -  D4rt-interpretable',
            style: TextStyle(
              color: Color(0xFFB0BEC5),
              fontSize: 11,
              fontStyle: FontStyle.italic,
              letterSpacing: 0.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String label;
  final String target;
  const _FooterLink({required this.label, required this.target});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(Icons.link, color: Color(0xFF80DEEA), size: 14),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  target,
                  style: const TextStyle(
                    color: Color(0xFF80DEEA),
                    fontSize: 11.5,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// End of file
// -----------------------------------------------------------------------------

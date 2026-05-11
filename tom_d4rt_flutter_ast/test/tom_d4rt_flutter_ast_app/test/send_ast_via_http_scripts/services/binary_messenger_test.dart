// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';

/// Visual deep demo for [BinaryMessenger] from package:flutter/services.dart.
///
/// BinaryMessenger is the low-level transport that moves ByteData payloads
/// between Dart and the host platform via named channels. This demo renders
/// the full mental model: class anatomy, channel architecture, message
/// envelopes, codec layering, background isolate flow, test helpers,
/// patterns and pitfalls.
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'BinaryMessenger Deep Demo',
    theme: ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: const Color(0xFFF4F5FA),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('BinaryMessenger — Deep Demo'),
        backgroundColor: const Color(0xFF1A237E),
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            _HeroBannerSection(),
            SizedBox(height: 28),
            _ClassAnatomySection(),
            SizedBox(height: 28),
            _ChannelArchitectureSection(),
            SizedBox(height: 28),
            _MessageEnvelopeSection(),
            SizedBox(height: 28),
            _ChannelCodecTableSection(),
            SizedBox(height: 28),
            _BackgroundIsolateSection(),
            SizedBox(height: 28),
            _TestHelpersSection(),
            SizedBox(height: 28),
            _CommonPatternsSection(),
            SizedBox(height: 28),
            _PitfallsSection(),
            SizedBox(height: 28),
            _FooterSection(),
            SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}

class _HeroBannerSection extends StatelessWidget {
  const _HeroBannerSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A237E),
            Color(0xFF3949AB),
            Color(0xFF5C6BC0),
          ],
          stops: [0.0, 0.55, 1.0],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1A237E).withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.35),
                    width: 1.5,
                  ),
                ),
                child: const Icon(
                  Icons.swap_horiz,
                  color: Colors.white,
                  size: 36,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BinaryMessenger',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.98),
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'package:flutter/services.dart',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 14,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'The low-level transport that carries opaque ByteData payloads'
            ' between Dart and the host platform across named channels.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.92),
              fontSize: 16,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const [
              _HeroChip(label: 'send()', icon: Icons.upload),
              _HeroChip(label: 'setMessageHandler()', icon: Icons.call_received),
              _HeroChip(label: 'handlePlatformMessage()', icon: Icons.history),
              _HeroChip(label: 'ByteData ↔ ByteData?', icon: Icons.data_object),
              _HeroChip(label: 'Channel-keyed', icon: Icons.tag),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.label, required this.icon});
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class _ClassAnatomySection extends StatelessWidget {
  const _ClassAnatomySection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      title: 'Class Anatomy',
      subtitle: 'Abstract surface, lifecycle methods, and ServicesBinding default',
      icon: Icons.account_tree,
      accent: const Color(0xFF1565C0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          _MethodCard(
            signature: "Future<ByteData?> send(String channel, ByteData? message)",
            kind: 'Dart → Platform',
            description:
                'Outbound. Encodes nothing; sends raw bytes. Returns the reply '
                'envelope (null = no response / void method).',
            color: Color(0xFF1565C0),
          ),
          SizedBox(height: 12),
          _MethodCard(
            signature: "void setMessageHandler(String channel, MessageHandler? handler)",
            kind: 'Platform → Dart',
            description:
                'Inbound. Installs the receive callback for the channel. Passing '
                'null clears the handler. Each channel has at most one handler.',
            color: Color(0xFF2E7D32),
          ),
          SizedBox(height: 12),
          _MethodCard(
            signature: "Future<void> handlePlatformMessage(String channel, ByteData? data, PlatformMessageResponseCallback? callback)",
            kind: 'Legacy entrypoint',
            description:
                'Pre-1.17 entrypoint kept for compatibility. Newer code uses the '
                'binary messenger directly; tests typically go through '
                'TestDefaultBinaryMessenger.handlePlatformMessage instead.',
            color: Color(0xFF6A1B9A),
          ),
          SizedBox(height: 12),
          _MethodCard(
            signature: "typedef MessageHandler = Future<ByteData?> Function(ByteData? message)",
            kind: 'Handler typedef',
            description:
                'Always async — even synchronous-looking handlers must yield via '
                'Future. Returned ByteData becomes the reply envelope.',
            color: Color(0xFFC62828),
          ),
          SizedBox(height: 12),
          _MethodCard(
            signature: "BinaryMessenger get defaultBinaryMessenger",
            kind: 'ServicesBinding accessor',
            description:
                'The root-isolate singleton. MethodChannel/EventChannel default '
                'to this instance unless explicitly overridden in the constructor.',
            color: Color(0xFFEF6C00),
          ),
          SizedBox(height: 12),
          _MethodCard(
            signature: "class BackgroundIsolateBinaryMessenger extends BinaryMessenger",
            kind: 'Non-root isolate variant',
            description:
                'Created via ensureInitialized(rootIsolateToken). Tunnels binary '
                'messages back through the root isolate so platform plugins keep '
                'working off the main isolate.',
            color: Color(0xFF00838F),
          ),
        ],
      ),
    );
  }
}

class _MethodCard extends StatelessWidget {
  const _MethodCard({
    required this.signature,
    required this.kind,
    required this.description,
    required this.color,
  });
  final String signature;
  final String kind;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  kind,
                  style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E2D),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              signature,
              style: const TextStyle(
                color: Color(0xFFB5E0FF),
                fontFamily: 'monospace',
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
              color: Colors.black.withValues(alpha: 0.78),
              fontSize: 13.5,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionFrame extends StatelessWidget {
  const _SectionFrame({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.child,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: accent.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      accent,
                      accent.withValues(alpha: 0.6),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A237E),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black.withValues(alpha: 0.55),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}

class _ChannelArchitectureSection extends StatelessWidget {
  const _ChannelArchitectureSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      title: 'Channel Architecture',
      subtitle: 'Dart side ↔ engine ↔ platform handler',
      icon: Icons.hub,
      accent: const Color(0xFF00897B),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE0F2F1),
              Color(0xFFB2DFDB),
            ],
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: const [
            _ArchNode(
              title: 'Dart UI Code',
              subtitle: 'MethodChannel.invokeMethod(...)',
              color: Color(0xFF1565C0),
              icon: Icons.flutter_dash,
            ),
            _ArchArrow(label: 'encode → ByteData'),
            _ArchNode(
              title: 'MessageCodec / MethodCodec',
              subtitle: 'StandardMessageCodec, JSONMessageCodec, ...',
              color: Color(0xFF6A1B9A),
              icon: Icons.transform,
            ),
            _ArchArrow(label: 'BinaryMessenger.send(channel, bytes)'),
            _ArchNode(
              title: 'BinaryMessenger',
              subtitle: 'ServicesBinding.defaultBinaryMessenger',
              color: Color(0xFF00897B),
              icon: Icons.swap_horiz,
            ),
            _ArchArrow(label: 'embedder IPC'),
            _ArchNode(
              title: 'Flutter Engine',
              subtitle: 'C++ shell, platform thread',
              color: Color(0xFFEF6C00),
              icon: Icons.memory,
            ),
            _ArchArrow(label: 'platform message dispatch'),
            _ArchNode(
              title: 'Host Platform Handler',
              subtitle: 'Android/iOS/Web/Desktop plugin',
              color: Color(0xFFC62828),
              icon: Icons.devices,
            ),
          ],
        ),
      ),
    );
  }
}

class _ArchNode extends StatelessWidget {
  const _ArchNode({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
  });
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.45), width: 1.4),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.black.withValues(alpha: 0.7),
                    fontSize: 12.5,
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

class _ArchArrow extends StatelessWidget {
  const _ArchArrow({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          const SizedBox(width: 20),
          Container(
            width: 2,
            height: 22,
            color: Colors.black.withValues(alpha: 0.35),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.black.withValues(alpha: 0.15),
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11.5,
                color: Colors.black.withValues(alpha: 0.65),
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageEnvelopeSection extends StatelessWidget {
  const _MessageEnvelopeSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      title: 'Message Envelope',
      subtitle: 'A ByteData snapshot of a StandardMethodCodec call',
      icon: Icons.data_object,
      accent: const Color(0xFF6A1B9A),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          _HexBlock(
            offset: '0x00',
            bytes: '07 0E 67 65 74 50 6C 61 74 66 6F 72 6D 56 65 72',
            ascii: '..getPlatformVer',
            annotation: 'method name: tag=0x07 (string), len=0x0E (14)',
            color: Color(0xFF1565C0),
          ),
          SizedBox(height: 8),
          _HexBlock(
            offset: '0x10',
            bytes: '73 69 6F 6E 00 00 00 00',
            ascii: 'sion....',
            annotation: 'method name continued + alignment padding',
            color: Color(0xFF1565C0),
          ),
          SizedBox(height: 8),
          _HexBlock(
            offset: '0x18',
            bytes: '00',
            ascii: '.',
            annotation: 'argument value: tag=0x00 (null)',
            color: Color(0xFF2E7D32),
          ),
          SizedBox(height: 14),
          _EnvelopeLegend(),
          SizedBox(height: 14),
          _ReplyEnvelopeBlock(),
        ],
      ),
    );
  }
}

class _HexBlock extends StatelessWidget {
  const _HexBlock({
    required this.offset,
    required this.bytes,
    required this.ascii,
    required this.annotation,
    required this.color,
  });
  final String offset;
  final String bytes;
  final String ascii;
  final String annotation;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2D),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color.withValues(alpha: 0.45),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  offset,
                  style: TextStyle(
                    color: color,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  bytes,
                  style: const TextStyle(
                    color: Color(0xFFB5E0FF),
                    fontFamily: 'monospace',
                    fontSize: 13,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                ascii,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '↳ ' + annotation,
            style: TextStyle(
              color: color.withValues(alpha: 0.95),
              fontSize: 11.5,
              fontStyle: FontStyle.italic,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class _EnvelopeLegend extends StatelessWidget {
  const _EnvelopeLegend();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF3E5F5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _LegendRow(tag: '0x00', meaning: 'null'),
          _LegendRow(tag: '0x01', meaning: 'true'),
          _LegendRow(tag: '0x02', meaning: 'false'),
          _LegendRow(tag: '0x03', meaning: 'int32'),
          _LegendRow(tag: '0x04', meaning: 'int64'),
          _LegendRow(tag: '0x06', meaning: 'float64'),
          _LegendRow(tag: '0x07', meaning: 'string (utf-8)'),
          _LegendRow(tag: '0x08', meaning: 'uint8 list'),
          _LegendRow(tag: '0x0C', meaning: 'list'),
          _LegendRow(tag: '0x0D', meaning: 'map'),
        ],
      ),
    );
  }
}

class _LegendRow extends StatelessWidget {
  const _LegendRow({required this.tag, required this.meaning});
  final String tag;
  final String meaning;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 56,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFF6A1B9A).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              tag,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Color(0xFF6A1B9A),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            meaning,
            style: const TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _ReplyEnvelopeBlock extends StatelessWidget {
  const _ReplyEnvelopeBlock();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF2E7D32).withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Reply envelope (success):',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(0xFF1B5E20),
              fontSize: 13,
            ),
          ),
          SizedBox(height: 6),
          Text(
            '0x00 <result encoded with StandardMessageCodec>',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              color: Color(0xFF1B5E20),
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Reply envelope (error):',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(0xFFB71C1C),
              fontSize: 13,
            ),
          ),
          SizedBox(height: 6),
          Text(
            '0x01 <code:String> <message:String?> <details:dynamic?>',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              color: Color(0xFFB71C1C),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChannelCodecTableSection extends StatelessWidget {
  const _ChannelCodecTableSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      title: 'Channel × Codec Layer',
      subtitle: 'Which channel uses which codec on top of BinaryMessenger',
      icon: Icons.grid_on,
      accent: const Color(0xFFEF6C00),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          _CodecTableHeader(),
          _CodecRow(
            channel: 'BasicMessageChannel<T>',
            codec: 'MessageCodec<T>',
            payload: 'arbitrary T',
            replyMode: 'reply',
            color: Color(0xFF1565C0),
          ),
          _CodecRow(
            channel: 'MethodChannel',
            codec: 'StandardMethodCodec',
            payload: 'method + args',
            replyMode: 'success / error',
            color: Color(0xFF6A1B9A),
          ),
          _CodecRow(
            channel: 'OptionalMethodChannel',
            codec: 'StandardMethodCodec',
            payload: 'method + args',
            replyMode: 'silently null if missing',
            color: Color(0xFFAD1457),
          ),
          _CodecRow(
            channel: 'EventChannel',
            codec: 'StandardMethodCodec',
            payload: 'listen / cancel',
            replyMode: 'broadcast Stream',
            color: Color(0xFF00897B),
          ),
          _CodecRow(
            channel: 'BasicMessageChannel<String>',
            codec: 'StringCodec',
            payload: 'utf-8 string',
            replyMode: 'reply',
            color: Color(0xFF2E7D32),
          ),
          _CodecRow(
            channel: 'BasicMessageChannel<ByteData>',
            codec: 'BinaryCodec',
            payload: 'raw bytes',
            replyMode: 'reply',
            color: Color(0xFFEF6C00),
          ),
          _CodecRow(
            channel: 'BasicMessageChannel<dynamic>',
            codec: 'JSONMessageCodec',
            payload: 'JSON-ish tree',
            replyMode: 'reply',
            color: Color(0xFF5D4037),
          ),
          _CodecRow(
            channel: 'BasicMessageChannel<dynamic>',
            codec: 'StandardMessageCodec',
            payload: 'rich Dart tree',
            replyMode: 'reply',
            color: Color(0xFF455A64),
          ),
        ],
      ),
    );
  }
}

class _CodecTableHeader extends StatelessWidget {
  const _CodecTableHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFEF6C00), Color(0xFFFF9800)],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
      ),
      child: Row(
        children: const [
          Expanded(flex: 3, child: _CodecHeaderText('Channel')),
          Expanded(flex: 3, child: _CodecHeaderText('Codec')),
          Expanded(flex: 2, child: _CodecHeaderText('Payload')),
          Expanded(flex: 2, child: _CodecHeaderText('Reply mode')),
        ],
      ),
    );
  }
}

class _CodecHeaderText extends StatelessWidget {
  const _CodecHeaderText(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w800,
        fontSize: 12.5,
        letterSpacing: 0.4,
      ),
    );
  }
}

class _CodecRow extends StatelessWidget {
  const _CodecRow({
    required this.channel,
    required this.codec,
    required this.payload,
    required this.replyMode,
    required this.color,
  });
  final String channel;
  final String codec;
  final String payload;
  final String replyMode;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withValues(alpha: 0.06),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              channel,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
                fontSize: 12.5,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              codec,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              payload,
              style: TextStyle(
                fontSize: 12.5,
                color: Colors.black.withValues(alpha: 0.7),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              replyMode,
              style: TextStyle(
                fontSize: 12.5,
                color: Colors.black.withValues(alpha: 0.7),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundIsolateSection extends StatelessWidget {
  const _BackgroundIsolateSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      title: 'Background Isolate Path',
      subtitle: 'BackgroundIsolateBinaryMessenger.ensureInitialized()',
      icon: Icons.merge_type,
      accent: const Color(0xFF00838F),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFE0F7FA),
              Color(0xFFB2EBF2),
              Color(0xFFE0F7FA),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: const [
            _IsolateBox(
              title: 'Root isolate',
              subtitle: 'has ServicesBinding & defaultBinaryMessenger',
              icon: Icons.account_circle,
              color: Color(0xFF00838F),
            ),
            SizedBox(height: 10),
            _IsolateConnector(label: 'RootIsolateToken.instance'),
            SizedBox(height: 10),
            _IsolateBox(
              title: 'Spawned isolate',
              subtitle: 'no Binding — needs ensureInitialized(token)',
              icon: Icons.cloud_circle,
              color: Color(0xFF6A1B9A),
            ),
            SizedBox(height: 10),
            _IsolateConnector(label: 'BackgroundIsolateBinaryMessenger'),
            SizedBox(height: 10),
            _IsolateBox(
              title: 'Tunneled message',
              subtitle: 'forwarded to root isolate → platform handler',
              icon: Icons.swap_calls,
              color: Color(0xFFEF6C00),
            ),
          ],
        ),
      ),
    );
  }
}

class _IsolateBox extends StatelessWidget {
  const _IsolateBox({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color, width: 1.4),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
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

class _IsolateConnector extends StatelessWidget {
  const _IsolateConnector({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.arrow_downward, size: 16, color: Color(0xFF00838F)),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color(0xFF00838F).withValues(alpha: 0.4),
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Color(0xFF006064),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _TestHelpersSection extends StatelessWidget {
  const _TestHelpersSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      title: 'Test Helpers',
      subtitle: 'TestDefaultBinaryMessenger.setMockMessageHandler',
      icon: Icons.science,
      accent: const Color(0xFFC62828),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          _CodeSnippet(
            title: 'Install a mock handler for a MethodChannel',
            code: '''
final messenger = TestDefaultBinaryMessengerBinding
    .instance.defaultBinaryMessenger;
messenger.setMockMessageHandler(
  'com.example/battery',
  (ByteData? message) async {
    final call = const StandardMethodCodec().decodeMethodCall(message!);
    if (call.method == 'getBatteryLevel') {
      return const StandardMethodCodec().encodeSuccessEnvelope(42);
    }
    return null;
  },
);
''',
          ),
          SizedBox(height: 12),
          _CodeSnippet(
            title: 'Drive a platform message into Dart side',
            code: '''
await messenger.handlePlatformMessage(
  'flutter/lifecycle',
  const StringCodec().encodeMessage('AppLifecycleState.paused'),
  (ByteData? reply) {},
);
''',
          ),
          SizedBox(height: 12),
          _CodeSnippet(
            title: 'Clear all mock handlers between tests',
            code: '''
tearDown(() {
  TestDefaultBinaryMessengerBinding
      .instance.defaultBinaryMessenger
      .setMockMessageHandler('com.example/battery', null);
});
''',
          ),
          SizedBox(height: 16),
          _ReplayPanel(),
        ],
      ),
    );
  }
}

class _CodeSnippet extends StatelessWidget {
  const _CodeSnippet({required this.title, required this.code});
  final String title;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFFC62828),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E2D),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            code.trim(),
            style: const TextStyle(
              color: Color(0xFFB5E0FF),
              fontFamily: 'monospace',
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }
}

class _ReplayPanel extends StatelessWidget {
  const _ReplayPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFEBEE), Color(0xFFFFCDD2)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Fake replay log',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Color(0xFFB71C1C),
              fontSize: 14,
            ),
          ),
          SizedBox(height: 8),
          _ReplayLine(time: '00.001', dir: '→', payload: 'getBatteryLevel()'),
          _ReplayLine(time: '00.003', dir: '←', payload: 'success(42)'),
          _ReplayLine(time: '00.018', dir: '→', payload: 'getCharging()'),
          _ReplayLine(time: '00.020', dir: '←', payload: 'success(true)'),
          _ReplayLine(time: '00.044', dir: '→', payload: 'getUnknown()'),
          _ReplayLine(time: '00.046', dir: '←', payload: 'error("unimplemented")'),
        ],
      ),
    );
  }
}

class _ReplayLine extends StatelessWidget {
  const _ReplayLine({
    required this.time,
    required this.dir,
    required this.payload,
  });
  final String time;
  final String dir;
  final String payload;

  @override
  Widget build(BuildContext context) {
    final Color dirColor = dir == '→'
        ? const Color(0xFF1565C0)
        : const Color(0xFF2E7D32);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            time,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Colors.black.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            dir,
            style: TextStyle(
              color: dirColor,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              payload,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CommonPatternsSection extends StatelessWidget {
  const _CommonPatternsSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      title: 'Common Patterns',
      subtitle: 'Mock handler, error envelope, oneway send',
      icon: Icons.auto_awesome,
      accent: const Color(0xFF2E7D32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          _PatternCard(
            badge: 'A',
            title: 'Mock handler in a widget test',
            body: 'Use TestDefaultBinaryMessengerBinding to install a handler '
                'that intercepts a real plugin channel and returns a canned '
                'reply. Always clear it in tearDown to avoid leaks across tests.',
            color: Color(0xFF2E7D32),
          ),
          SizedBox(height: 10),
          _PatternCard(
            badge: 'B',
            title: 'Error envelope from native side',
            body: 'Return MethodCodec.encodeErrorEnvelope(code: ..., message: ..., '
                'details: ...). On the Dart side this surfaces as a '
                'PlatformException — handle it in invokeMethod call sites.',
            color: Color(0xFFC62828),
          ),
          SizedBox(height: 10),
          _PatternCard(
            badge: 'C',
            title: 'Oneway send (no reply expected)',
            body: 'send(channel, message) returns Future<ByteData?>. Native '
                'side may simply not reply; the future resolves to null. '
                'Useful for fire-and-forget telemetry channels.',
            color: Color(0xFF1565C0),
          ),
          SizedBox(height: 10),
          _PatternCard(
            badge: 'D',
            title: 'Per-channel custom messenger override',
            body: 'MethodChannel takes an optional BinaryMessenger argument. '
                'Inject a test instance to make a single channel mockable '
                'without touching the global ServicesBinding default.',
            color: Color(0xFF6A1B9A),
          ),
          SizedBox(height: 10),
          _PatternCard(
            badge: 'E',
            title: 'Reply forwarding & inspection',
            body: 'Wrap an existing BinaryMessenger to log every send/handle. '
                'Forward the call, capture the result, return it unchanged — '
                'great for diagnostic builds and integration captures.',
            color: Color(0xFFEF6C00),
          ),
          SizedBox(height: 10),
          _PatternCard(
            badge: 'F',
            title: 'Per-handler codec scoping',
            body: 'Decode messages with the same codec used to encode them. '
                'Mixing StandardMessageCodec on one side and JSONMessageCodec '
                'on the other yields opaque, hard-to-debug failures.',
            color: Color(0xFF00838F),
          ),
        ],
      ),
    );
  }
}

class _PatternCard extends StatelessWidget {
  const _PatternCard({
    required this.badge,
    required this.title,
    required this.body,
    required this.color,
  });
  final String badge;
  final String title;
  final String body;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withValues(alpha: 0.65)],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              badge,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.45,
                    color: Colors.black.withValues(alpha: 0.78),
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

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      title: 'Pitfalls',
      subtitle: 'Where BinaryMessenger usage goes silently wrong',
      icon: Icons.warning_amber,
      accent: const Color(0xFFB71C1C),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFF3E0),
              Color(0xFFFFE0B2),
              Color(0xFFFFCCBC),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            _PitfallTile(
              icon: Icons.error_outline,
              title: 'Forgetting to install the handler',
              body: 'send() returns null forever. There is no exception — only '
                  'silence. Always call setMessageHandler before triggering '
                  'inbound messages in tests.',
            ),
            _PitfallTile(
              icon: Icons.lock_clock,
              title: 'Blocking the platform thread',
              body: 'Long-running synchronous work inside a handler stalls the '
                  'engine. Offload heavy work to an isolate and respond '
                  'asynchronously.',
            ),
            _PitfallTile(
              icon: Icons.cancel_presentation,
              title: 'Mismatched codecs',
              body: 'Encoding with JSONMessageCodec but decoding with '
                  'StandardMessageCodec produces FormatException or garbage '
                  'shaped data. Pin the codec at the channel constructor.',
            ),
            _PitfallTile(
              icon: Icons.timer_off,
              title: 'Awaiting a reply that never comes',
              body: 'Native side that never calls reply leaks the Dart-side '
                  'completer. Always invoke the PlatformMessageResponseCallback '
                  'exactly once, even when the result is conceptually null.',
            ),
            _PitfallTile(
              icon: Icons.shuffle,
              title: 'Channel name collisions',
              body: 'Two plugins choosing the same channel name silently fight '
                  'for the single handler slot. Namespace channels with the '
                  'plugin package id.',
            ),
            _PitfallTile(
              icon: Icons.flip_camera_android,
              title: 'Using a foreground messenger off the root isolate',
              body: 'On non-root isolates, defaultBinaryMessenger is not '
                  'available. You must build a BackgroundIsolateBinaryMessenger '
                  'with ensureInitialized(rootIsolateToken).',
            ),
            _PitfallTile(
              icon: Icons.bug_report,
              title: 'Test handler leaking across tests',
              body: 'Forgetting to clear a mock handler in tearDown will '
                  'interfere with later tests, often manifesting as flaky '
                  'platform exception assertions.',
            ),
          ],
        ),
      ),
    );
  }
}

class _PitfallTile extends StatelessWidget {
  const _PitfallTile({
    required this.icon,
    required this.title,
    required this.body,
  });
  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFB71C1C).withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFFB71C1C), size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFB71C1C),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: TextStyle(
                    fontSize: 12.8,
                    height: 1.45,
                    color: Colors.black.withValues(alpha: 0.78),
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

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF263238),
            Color(0xFF37474F),
            Color(0xFF455A64),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.menu_book,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'References',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.95),
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Where to read more about BinaryMessenger',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const _ReferenceLine(
            label: 'flutter/services/binary_messenger.dart',
            note: 'abstract class BinaryMessenger',
          ),
          const _ReferenceLine(
            label: 'flutter/services/binding.dart',
            note: 'ServicesBinding.defaultBinaryMessenger',
          ),
          const _ReferenceLine(
            label: 'flutter/services/background_isolate_binary_messenger.dart',
            note: 'BackgroundIsolateBinaryMessenger',
          ),
          const _ReferenceLine(
            label: 'flutter_test/test_default_binary_messenger.dart',
            note: 'TestDefaultBinaryMessenger / setMockMessageHandler',
          ),
          const _ReferenceLine(
            label: 'flutter/services/platform_channel.dart',
            note: 'MethodChannel, EventChannel, BasicMessageChannel',
          ),
          const _ReferenceLine(
            label: 'flutter/services/message_codec.dart',
            note: 'StandardMessageCodec, JSONMessageCodec, StringCodec',
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.18),
              ),
            ),
            child: Text(
              'BinaryMessenger is the thinnest possible abstraction: a named '
              'channel mapping String → (ByteData? → Future<ByteData?>). '
              'Everything above it — codecs, MethodChannel ergonomics, '
              'event streams — is built from this single primitive.',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 13,
                height: 1.5,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReferenceLine extends StatelessWidget {
  const _ReferenceLine({required this.label, required this.note});
  final String label;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.95),
                    fontFamily: 'monospace',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  note,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
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


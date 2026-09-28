// SCD170's source census: every socket-acquiring native call in the `dart:io`
// bridges has a `NetworkPermission` gate above it.
//
// SPLIT OUT OF `scd170_network_permission_gate_test.dart` (SCE212). This case
// reads `lib/src/stdlib/io/*.dart` by path, so it is single-copy by
// construction — `tom_d4rt_exec` has no stdlib of its own — while the
// behaviour cases beside it port verbatim. In one file, the census made the
// whole file unportable and exec measured none of the gate's behaviour.
//
// The behavioural cases can only cover entry points somebody remembered to
// list; this census is what notices an adapter added later.

import 'dart:io' as io;

import 'package:test/test.dart';

/// The bridge sources that acquire sockets.
const _gatedSources = <String>[
  'lib/src/stdlib/io/socket.dart',
  'lib/src/stdlib/io/http.dart',
  'lib/src/stdlib/io/websocket.dart',
];

/// Native calls that acquire a socket, and therefore must be gated.
final RegExp _socketAcquiring = RegExp(
  r'\b(?:Socket|RawSocket|ServerSocket|RawServerSocket|RawDatagramSocket|'
  r'HttpServer|WebSocket)\.(?:connect|startConnect|bind|bindSecure|listenOn)\('
  r'|\(target as HttpClient\)\.\w+\(',
);

final RegExp _gateCall = RegExp(r'checkNetwork\w+Permission\(');

/// `HttpClient` members the bridge calls that acquire NO socket.
///
/// The census matches every `(target as HttpClient).x(` and then subtracts
/// this set, rather than listing the fourteen that DO connect. The polarity is
/// the point: a method added to the bridge later is required to be gated by
/// default and has to be exempted deliberately, whereas a hand-list of
/// connecting methods would let a new one through in silence — which is the
/// shape of the defect this whole file exists for.
///
/// `close` tears a client down, and the two credential methods populate a
/// local store consulted when a request is later made; that request goes
/// through `open`/`openUrl`, which are gated.
const _httpClientNonConnecting = <String>{
  'addCredentials',
  'addProxyCredentials',
  'close',
};

final RegExp _httpClientCall = RegExp(r'\(target as HttpClient\)\.(\w+)\(');

void main() {
  group('SCD170: every socket-acquiring bridge is gated', () {
    test('F-SCD170-1: every socket-acquiring native call in the bridge '
        'sources has a gate above it [2026-09-15] (PASS)', () {
      // Anti-vacuity AND the structural half: the behavioural cases below can
      // only cover entry points somebody remembered to list, so the census is
      // what notices an adapter added later.
      final ungated = <String>[];
      final exempted = <String>{};
      var scanned = 0;
      for (final path in _gatedSources) {
        final lines = io.File(path).readAsLinesSync();
        expect(lines, isNotEmpty, reason: '$path is empty or missing');
        for (var i = 0; i < lines.length; i++) {
          if (!_socketAcquiring.hasMatch(lines[i])) continue;
          final httpClient = _httpClientCall.firstMatch(lines[i]);
          if (httpClient != null &&
              _httpClientNonConnecting.contains(httpClient.group(1))) {
            exempted.add(httpClient.group(1)!);
            continue;
          }
          scanned++;
          final from = i - 12 < 0 ? 0 : i - 12;
          final window = lines.sublist(from, i).join('\n');
          if (!_gateCall.hasMatch(window)) {
            ungated.add('$path:${i + 1}: ${lines[i].trim()}');
          }
        }
      }
      expect(
        scanned,
        greaterThanOrEqualTo(20),
        reason:
            'only $scanned socket-acquiring calls found — the scan is not '
            'seeing the bridge surface, so the check below is vacuous',
      );
      // No exemption outlives its cause: a name left here after the bridge
      // stopped calling it would silently widen what the census ignores.
      expect(
        exempted,
        equals(_httpClientNonConnecting),
        reason:
            'the non-connecting exemption list no longer matches what the '
            'bridge calls — remove the entries that are gone, and check '
            'whether anything new needs gating',
      );
      expect(
        ungated,
        isEmpty,
        reason:
            'These acquire a socket with no NetworkPermission check above '
            'them. A partial gate reads as a working sandbox and is worse '
            'than none: add a checkNetwork*Permission call from '
            'lib/src/stdlib/io/network_permission_helper.dart.',
      );
    });
  });
}

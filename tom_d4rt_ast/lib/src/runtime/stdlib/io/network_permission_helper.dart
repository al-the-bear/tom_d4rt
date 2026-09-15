/// Per-operation `NetworkPermission` gate for the `dart:io` bridges.
///
/// The `dart:io` IMPORT gate is keyed on `FilesystemPermission`, so before
/// these checks existed a script granted filesystem access silently received
/// unrestricted inbound and outbound network access — and a script granted
/// `NetworkPermission` but not `FilesystemPermission` could not import
/// `dart:io` at all, and so could not use the permission it had been given.
/// Both directions were wrong, and the quest's standing constraint is that the
/// interpreter "must remain fully sandboxed — no uncontrolled access to host
/// system".
///
/// EVERY POINT THAT ACQUIRES A SOCKET CALLS IN HERE, which is the only useful
/// scope. A partial gate is worse than none because it reads as a working
/// sandbox: gating `HttpServer.bind` alone is bypassable with
/// `ServerSocket.bind` + `HttpServer.listenOn`, and gating `HttpClient.getUrl`
/// alone is bypassable with `HttpClient.open`, or with `Socket.connect`
/// underneath all of it.
///
/// THE HOST AND PORT ARE PASSED THROUGH, so the granularity
/// `NetworkPermission` already models is honoured. The single gate that existed
/// before this file took a `host` parameter and then dropped it, asking only
/// `{'type': 'network', 'connect': true}` — so `NetworkPermission.connectTo`
/// behaved exactly like `NetworkPermission.connect`.
///
/// Twin of `tom_d4rt/lib/src/stdlib/io/network_permission_helper.dart`.
/// The two differ only in how they reach the permission set, exactly as the
/// filesystem helpers beside them do: the analyzer tree holds a nullable
/// `D4rt` on its module loader, whereas here the [ModuleContext] interface
/// owns `checkPermission` and is permissive by default when no checker is
/// configured.
///
/// WHICH FLAG EACH OPERATION ASKS FOR is deliberately one flag, never a
/// combination. `NetworkPermission.allows` requires every requested flag to be
/// granted, so asking for `bind` and `listen` together would make
/// `NetworkPermission.bind` unusable for the operation it is named after.
/// Client connects ask `connect`, socket binds ask `bind`, and serving on an
/// already-bound socket asks `listen`.
library;

import 'dart:io';

import 'package:tom_d4rt_ast/runtime.dart';

/// Asserts the script may open an outbound connection to [host]:[port].
void checkNetworkConnectPermission(
  InterpreterVisitor visitor,
  Object? host,
  Object? port, {
  required String operation,
}) => _check(
  visitor,
  host,
  port,
  operation: operation,
  connect: true,
  listen: false,
  bind: false,
);

/// Asserts the script may bind a socket to [host]:[port].
void checkNetworkBindPermission(
  InterpreterVisitor visitor,
  Object? host,
  Object? port, {
  required String operation,
}) => _check(
  visitor,
  host,
  port,
  operation: operation,
  connect: false,
  listen: false,
  bind: true,
);

/// Asserts the script may serve on a socket it has already bound.
void checkNetworkListenPermission(
  InterpreterVisitor visitor,
  Object? host,
  Object? port, {
  required String operation,
}) => _check(
  visitor,
  host,
  port,
  operation: operation,
  connect: false,
  listen: true,
  bind: false,
);

/// The host as `NetworkPermission` records it.
///
/// A bridged call may hand over a `String` or an `InternetAddress`; the grant
/// is written with a string, so an `InternetAddress` that never resolved to one
/// would silently never match a host-scoped grant.
String? _hostOf(Object? host) {
  if (host == null) return null;
  if (host is String) return host;
  if (host is InternetAddress) return host.host;
  return host.toString();
}

void _check(
  InterpreterVisitor visitor,
  Object? host,
  Object? port, {
  required String operation,
  required bool connect,
  required bool listen,
  required bool bind,
}) {
  final resolvedHost = _hostOf(host);
  final allowed = visitor.moduleContext.checkPermission({
    'type': 'network',
    'host': resolvedHost,
    'port': port is int ? port : null,
    'connect': connect,
    'listen': listen,
    'bind': bind,
  });
  if (allowed) return;

  final where = [?resolvedHost, if (port is int) '$port'].join(':');
  throw RuntimeD4rtException(
    'Network permission denied for $operation${where.isEmpty ? '' : ' on "$where"'}. '
    'Grant an appropriate NetworkPermission '
    '(e.g. d4rt.grant(NetworkPermission.any)) to allow network access.',
  );
}

/// The stdlib member audit of the runtime this package interprets with,
/// under the name tom_d4rt's tool has (`tool/stdlib_member_diff.dart`), so
/// the ports that read it (`test/dart313b1_sdk_313_members_test.dart`)
/// import it exactly as the reference tests do.
///
/// The audit is a TOOL of `tom_d4rt_ast` (`tool/stdlib_member_audit.dart`),
/// not library code, so no `package:` URI reaches it; this file is the one
/// place in exec that names its path. It is the same design as tom_d4rt's
/// audit over this line's registry, with the three names the ports use.
/// Importing tom_d4rt's tool instead would measure the other interpreter
/// while appearing to measure this one.
library;

export '../../tom_d4rt_ast/tool/stdlib_member_audit.dart'
    show
        auditSdkFloor,
        buildFullyRegisteredEnvironment,
        sdkMembersNewerThanFloor;

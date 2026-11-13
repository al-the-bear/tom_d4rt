/// The stdlib member audit of the runtime this package interprets with, for
/// the ports that read it (`dart313b1_sdk_313_members_test.dart`).
///
/// The audit is a TOOL of `tom_d4rt_ast`, not library code, so no `package:`
/// URI reaches it; this file is the one place in exec that names its path.
/// A port imports this file rather than the path, so a copy of the port
/// anywhere else fails to compile instead of measuring another tree (SCE191),
/// and `port_recipe.dart` pairs it with the reference's
/// `../tool/stdlib_member_diff.dart`.
library;

export '../../tom_d4rt_ast/tool/stdlib_member_audit.dart'
    show
        auditSdkFloor,
        buildFullyRegisteredEnvironment,
        sdkMembersNewerThanFloor;

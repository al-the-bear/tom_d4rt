/// Web has no process working directory — and no filesystem, so no filesystem
/// operation can reach the scope matcher in the first place. Returning the
/// root keeps [currentDirectoryPath] total: a relative permission path still
/// canonicalizes to *something* absolute, and comparisons stay self-consistent
/// because both sides go through the same function.
String currentDirectoryPath() => '/';

/// Web has no symlinks — and no filesystem to hold them — so the real path of
/// [path] is [path]. Identity keeps the scope matcher's shape identical on both
/// platforms instead of forking its logic on a capability that cannot vary
/// here: there is nothing to resolve, and nothing to escape into.
String resolveRealPath(String path) => path;

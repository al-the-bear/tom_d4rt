/// Web has no process working directory — and no filesystem, so no filesystem
/// operation can reach the scope matcher in the first place. Returning the
/// root keeps [currentDirectoryPath] total: a relative permission path still
/// canonicalizes to *something* absolute, and comparisons stay self-consistent
/// because both sides go through the same function.
String currentDirectoryPath() => '/';

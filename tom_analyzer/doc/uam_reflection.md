# UAM Reflection Generator Results

Analysis and code generation for `tom_uam_server` and all `tom_*` dependencies using `ReflectionGenerator`.

## Configuration

**Entry Points Analyzed:**
- `tom_uam_server/bin/aa_server_start.dart`
- `tom_uam_codespec/lib/tom_uam_codespec.dart`
- `tom_core_kernel/lib/tom_core_kernel.dart`
- `tom_reflection/lib/tom_reflection.dart`
- `tom_basics/lib/tom_basics.dart`
- `tom_crypto/lib/tom_crypto.dart`

**Dependency Configuration:**
- Type annotations: enabled, transitive, external, include argument types
- Marker annotations: `tomReflection`, `TomReflectionInfo`

## Summary

| Category | Count |
|----------|-------|
| Classes | 599 |
| Enums | 3 |
| Mixins | 0 |
| Extensions | 0 |
| Global Functions | 40 |
| Global Variables | 46 |

## Generated Code Statistics

| Metric | Value |
|--------|-------|
| File size | 3.4 MB |
| Characters | 3,560,566 |
| Lines | 123,640 |
| Generation time | ~23 seconds |
| Analyzer parse time | ~1.4 seconds |

## Generated File

- **Generated code**: [uam_generated.r.dart](uam_generated.r.dart)
- **Tabular output**: [uam_reflection.txt](uam_reflection.txt)

## Notes

The generated `.r.dart` file contains:
- Import prefixes for all referenced libraries
- Type indices for all classes/enums
- Invoker functions for methods, constructors, getters, setters
- Class type list with superclass/interface relationships
- Field/method metadata arrays

The generated file has 3,697 analyzer issues when analyzed standalone (missing imports/context) but is designed to be included as part of a package.

# Build Instructions

To build the `tom_dartscript_bridges` (d4rt) tool, follow these steps:

1. **Build Prerequisites**: Ensure that `tom_d4rt_dcli` has been built first, as it contains the base bridges and VS Code integration required by this project.
2. **Delete generated files**: Delete all `*.g.dart` files in the project to ensure a clean build.
   ```bash
   find . -name "*.g.dart" -delete
   ```
3. **Generate bridges**: Run the build runner to generate the necessary target bridges.
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
4. **Compile**: Compile the tool using the workspace build tools.

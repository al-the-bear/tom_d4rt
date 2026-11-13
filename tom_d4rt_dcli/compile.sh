#!/bin/zsh
# Compile the dcli binary into the binaries layer: $TOM_BINARY_PATH/{platform}/
#
# Usage: ./compile.sh
#
# This script:
# 1. Runs dart pub get
# 2. Runs d4rtgen to regenerate bridges (configured in buildkit.yaml)
# 3. Compiles the dcli binary

set -e

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# Detect platform
case "$(uname -s)" in
    Darwin)
        case "$(uname -m)" in
            arm64) PLATFORM="darwin-arm64" ;;
            x86_64) PLATFORM="darwin-x64" ;;
            *) echo "Unsupported Mac architecture: $(uname -m)"; exit 1 ;;
        esac
        ;;
    Linux)
        case "$(uname -m)" in
            aarch64|arm64) PLATFORM="linux-arm64" ;;
            x86_64) PLATFORM="linux-x64" ;;
            *) echo "Unsupported Linux architecture: $(uname -m)"; exit 1 ;;
        esac
        ;;
    MINGW*|MSYS*|CYGWIN*)
        PLATFORM="win32-x64"
        ;;
    *)
        echo "Unsupported OS: $(uname -s)"
        exit 1
        ;;
esac

# Target directory: the binaries layer (tom_binaries/tom), as TOM_BINARY_PATH
# names it. Nothing is installed under ~/.tom/bin.
if [[ -z "${TOM_BINARY_PATH:-}" ]]; then
    echo "TOM_BINARY_PATH is not set: it names the binaries layer (tom_binaries/tom)."
    exit 1
fi
TARGET_DIR="$TOM_BINARY_PATH/$PLATFORM"
OUTPUT="$TARGET_DIR/dcli"

# Ensure target directory exists
mkdir -p "$TARGET_DIR"

echo "=== DCLI Binary Compiler ==="
echo "Platform: $PLATFORM"
echo "Target: $OUTPUT"
echo ""

# Get dependencies
echo "📦 Getting dependencies..."
dart pub get
echo ""

# Regenerate bridges with d4rtgen, which reads the `d4rtgen:` block of
# buildkit.yaml. There is no build_runner step: the builder-era output it
# produced is gone, and the generator is a dev dependency for this command.
echo "🔧 Running d4rtgen..."
dart run tom_d4rt_generator:d4rtgen -p .
echo ""

# Compile
echo "📦 Compiling dcli..."
if dart compile exe bin/dcli.dart -o "$OUTPUT"; then
    echo "✅ Successfully compiled: $OUTPUT"
else
    echo "❌ Compilation failed"
    exit 1
fi
echo ""

# Check PATH
if [[ ":$PATH:" != *":$TARGET_DIR:"* ]]; then
    echo "⚠️  Warning: $TARGET_DIR is not in your PATH"
    echo ""
    echo "Add this to your ~/.zshrc or ~/.bashrc:"
    echo ""
    echo "  export PATH=\"\$TOM_BINARY_PATH/$PLATFORM:\$PATH\""
    echo ""
fi

# Show version
echo "Testing binary..."
"$OUTPUT" --version

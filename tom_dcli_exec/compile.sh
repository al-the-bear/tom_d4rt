#!/bin/zsh
# Compile dcli binary to ~/.tom/bin/{platform}/
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

# Target directory
TARGET_DIR="$HOME/.tom/bin/$PLATFORM"
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
echo "📦 Compiling dclie..."
if dart compile exe bin/dclie.dart -o "$OUTPUT"; then
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
    echo "  export PATH=\"\$HOME/.tom/bin/$PLATFORM:\$PATH\""
    echo ""
fi

# Show version
echo "Testing binary..."
"$OUTPUT" --version

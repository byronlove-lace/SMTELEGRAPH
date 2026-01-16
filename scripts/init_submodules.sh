PROJECT_ROOT="$(git rev-parse --show-toplevel)"
TARGET_PATH="$PROJECT_ROOT/lib/STM32CubeF4"
git clone https://github.com/STMicroelectronics/STM32CubeF4.git "$TARGET_PATH"
cd "$TARGET_PATH"
git submodule update --init --recursive

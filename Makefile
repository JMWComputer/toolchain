
SOURCE_DIR = tools
OUTPUT_DIR = bin

AS_ROOT = $(SOURCE_DIR)\assembler
AS_BUILD_DIR = $(AS_ROOT)\target\release
AS_BUILD_FILE = $(AS_BUILD_DIR)\assembler.exe

# LD_ROOT = linker

EMU_ROOT = $(SOURCE_DIR)\emulator
EMU_BUILD_DIR = $(EMU_ROOT)\build
EMU_BUILD_FILE = $(EMU_BUILD_DIR)\Debug\x69Emulator.exe

# CMP_ROOT = compiler

ASSEMBLER = $(OUTPUT_DIR)\as.exe
# LINKER = $(OUTPUT_DIR)\ld.exe
EMULATOR = $(OUTPUT_DIR)\emu.exe
# COMPILER = $(OUTPUT_DIR)\ccomp.exe

ALL: $(EMULATOR)

$(EMULATOR): $(ASSEMBLER)
	cmake -S $(EMU_ROOT) -B $(EMU_BUILD_DIR) 
	cmake --build $(EMU_BUILD_DIR)
	copy /n /b $(EMU_BUILD_FILE) $(EMULATOR)

$(ASSEMBLER): UPDATE_SUBMODULES
	cargo build --release --manifest-path $(AS_ROOT)\Cargo.toml
	copy /n /b $(AS_BUILD_FILE) $(ASSEMBLER)

UPDATE_SUBMODULES: CLEAN
	git submodule update --recursive --remote
	 
CLEAN:
	-rmdir /s /q $(OUTPUT_DIR)
	mkdir $(OUTPUT_DIR)


SOURCE_FOLDER = ./src/
BUILD_FOLDER = ./build/

SOURCE_FILE = $(SOURCE_FOLDER)main
OUTPUT_EXEC = $(BUILD_FOLDER)main

NASM_FLAGS = -f elf64
LD_FLAGS = -m elf_i386

all: mkdir_build clean $(OUTPUT_EXEC)
$(SOURCE_FILE).o: $(SOURCE_FILE).asm
	nasm $(NASM_FLAGS) -o $@ $<
$(OUTPUT_EXEC): $(SOURCE_FILE).o
	ld -o $@ $<

mkdir_build:
	mkdir -p $(BUILD_FOLDER)

clean:
	rm -f $(OUTPUT_EXEC) $(SOURCE_FILE).o

run: all
	./build/main
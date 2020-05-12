# Matrix Options
QEMU_IRIX ?= ./qemu-irix
IDO ?= 7.1
OPT ?= O2
MIPS_SET ?= mips2

ifeq ($(OPT),O2)
	OPT_FLAG := -O2
else
ifeq ($(OPT),g)
	OPT_FLAG := -g
else
	$(error Unsupported OPT value $(OPT))
endif
endif

ifneq (,$(filter mips1 mips2 mips3,$(MIPS_SET)))
	MIPS_FLAG = -$(MIPS_SET)
else
	$(error Unsupported MIPS_SET value $(MIPS_SET))
endif

ifeq (,$(filter 7.1 5.3,$(IDO)))
	$(error Unsupported IDO version $(IDO))
endif

## Toolchain
IDO_PATH := ido$(IDO)_compiler/
BUILD_BASE := build
BUILD_DIR := $(BUILD_BASE)/ido_$(IDO)_$(OPT)_$(MIPS_SET)
RM := rm
SED := sed
CPP := mips64-elf-cpp -P -Wno-trigraphs
LD := mips64-elf-ld

ELF := $(BUILD_DIR)/output_$(IDO)_$(OPT)_$(MIPS_SET).elf
MAP := $(ELF:.elf=.map)
TARGET := $(ELF:.elf=.bin)

CC := $(QEMU_IRIX) -L $(IDO_PATH) $(IDO_PATH)usr/bin/cc
CFLAGS := -Wab,-r4300_mul -G 0 -non_shared -Xcpluscomm -Xfullwarn -signed -nostdinc -32
CFLAGS += $(OPT_FLAG)
CFLAGS += $(MIPS_FLAG)
CFLAGS += -Iinclude

## Sources
C_SRC_DIR := src
C_FILES := $(wildcard $(C_SRC_DIR)/*.c)
DEP_FILES := $(foreach file,$(C_FILES),$(BUILD_DIR)/$(file:.c=.d))
OBJ_FILES := $(foreach file,$(C_FILES),$(BUILD_DIR)/$(file:.c=.o))

LD_SCRIPT := linker.ld
BUILD_LD_SCRIPT := $(BUILD_DIR)/$(LD_SCRIPT)

### Create all directories before building
ALL_DIRS := $(BUILD_DIR) $(addprefix $(BUILD_DIR)/,$(C_SRC_DIR))
DUMMY != mkdir -p $(ALL_DIRS)

all: $(ELF)

$(BUILD_DIR)/%.d: %.c
	@$(CC) -M $(CFLAGS) $< | \
	$(SED) 's,\($(notdir $*)\)\.o[ :]*,$(dir $@)\1.o $@: ,g' > $@; 

$(BUILD_DIR)/%.o: %.c
	$(CC) -c $(CFLAGS) -o $@ $< 

$(BUILD_LD_SCRIPT): $(LD_SCRIPT)
	$(CPP) -MMD -MP -MT $@ -MF $@.d -DBUILD_DIR=$(BUILD_DIR) -o $@ $<

$(ELF): $(BUILD_LD_SCRIPT) $(OBJ_FILES)
	$(LD) -T $(BUILD_LD_SCRIPT) $(OBJ_FILES) -Map $(MAP) -o $@

#$(TARGET)

clean:
	$(RM) -rf $(DEP_FILES) $(BUILD_BASE)

include $(DEP_FILES)

.PHONY: clean all

print-% : ; $(info $* is a $(flavor $*) variable set to [$($*)]) @true

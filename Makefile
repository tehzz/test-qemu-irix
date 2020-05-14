# Matrix Options
QEMU_IRIX ?= qemu-irix
IDO ?= 7.1
OPT ?= O2
MIPS_SET ?= mips2

ifneq (,$(filter g O1 O2 O3,$(OPT)))
	OPT_FLAG := -$(OPT)
else
	$(error Unsupported OPT value $(OPT))
endif

ifneq (,$(filter mips1 mips2,$(MIPS_SET)))
	MIPS_FLAG = -$(MIPS_SET)
else
	$(error Unsupported MIPS_SET value $(MIPS_SET))
endif

ifeq (,$(filter 7.1 5.3,$(IDO)))
	$(error Unsupported IDO version $(IDO))
endif

## Toolchain
IDO_PATH := ido$(IDO)_compiler
RM := rm
SED := sed
LD := mips64-elf-ld
OBJCOPY := mips64-elf-objcopy

CPP := mips64-elf-cpp
CPPFLAGS := -P -Wno-trigraphs

CC := $(QEMU_IRIX) -L $(IDO_PATH) $(IDO_PATH)/usr/bin/cc
CDEFS := 
ifeq ($(MIPS_SET),mips1)
  # mips1 does not have the sqrt/sqrtf intrinsics
  CDEFS += -DMIPS1_FIX
endif
CFLAGS := -Wab,-r4300_mul -G 0 -non_shared -Xcpluscomm -signed -nostdinc -32
ifneq ($(OPT),O3)
  CFLAGS += -Xfullwarn
endif
CFLAGS += $(OPT_FLAG)
CFLAGS += $(MIPS_FLAG)
CFLAGS += -Iinclude
CFLAGS += $(CDEFS)

## Sources
C_SRC_DIR := src
C_FILES := $(wildcard $(C_SRC_DIR)/*.c)
LD_SCRIPT := linker.ld

## Outputs
BUILD_BASE := build
BUILD_DIR := $(BUILD_BASE)/ido_$(IDO)_$(OPT)_$(MIPS_SET)
DEP_FILES := $(foreach file,$(C_FILES),$(BUILD_DIR)/$(file:.c=.d))
OBJ_FILES := $(foreach file,$(C_FILES),$(BUILD_DIR)/$(file:.c=.o))
BUILD_LD_SCRIPT := $(BUILD_DIR)/$(LD_SCRIPT)
ELF := $(BUILD_DIR)/output_$(IDO)_$(OPT)_$(MIPS_SET).elf
MAP := $(ELF:.elf=.map)
TARGET := $(ELF:.elf=.bin)

## Recipes
### Create all directories before building
ALL_DIRS := $(BUILD_DIR) $(addprefix $(BUILD_DIR)/,$(C_SRC_DIR))
DUMMY != mkdir -p $(ALL_DIRS)

all: $(TARGET)

clean:
	$(RM) -rf $(DEP_FILES) $(BUILD_BASE)

$(BUILD_DIR)/%.d: %.c
	@$(CC) -M $(CFLAGS) $< | \
	$(SED) 's,\($(notdir $*)\)\.o[ :]*,$(dir $@)\1.o $@: ,g' > $@; 

$(BUILD_DIR)/%.o: %.c
	$(CC) -c $(CFLAGS) -o $@ $< 

$(BUILD_LD_SCRIPT): $(LD_SCRIPT)
	$(CPP) $(CPPFLAGS) -MMD -MP -MT $@ -MF $@.d -DBUILD_DIR=$(BUILD_DIR) -o $@ $<

$(ELF): $(BUILD_LD_SCRIPT) $(OBJ_FILES)
	$(LD) -T $(BUILD_LD_SCRIPT) -Map $(MAP) $(OBJ_FILES) -o $@

$(TARGET): $(ELF)
	$(OBJCOPY) $< $@ -O binary

ifneq ($(MAKECMDGOALS),clean)
include $(DEP_FILES)
endif

.PHONY: clean all

print-% : ; $(info $* is a $(flavor $*) variable set to [$($*)]) @true

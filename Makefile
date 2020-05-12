
QEMU_IRIX ?= ./qemu-irix
IDO ?=7.1
IDO_PATH := ido$(IDO)_compiler/
BUILD_DIR := build
RM := rm
AWK := awk

CC := $(QEMU_IRIX) -L $(IDO_PATH) $(IDO_PATH)usr/bin/cc
CFLAGS := -Wab,-r4300_mul -non_shared -Iinclude

C_SRC_DIR := src
C_FILES := $(wildcard $(C_SRC_DIR)/*.c)
DEP_FILES := $(foreach file,$(C_FILES),$(BUILD_DIR)/$(file:.c=.d))
OBJ_FILES := $(foreach file,$(C_FILES),$(BUILD_DIR)/$(file:.c=.o))

ALL_DIRS := $(BUILD_DIR) $(addprefix $(BUILD_DIR)/,$(C_SRC_DIR))
DUMMY != mkdir -p $(ALL_DIRS)

all: $(OBJ_FILES)

$(BUILD_DIR)/%.d: %.c
	@$(CC) -M $(CFLAGS) $< | \
	sed 's,\($(notdir $*)\)\.o[ :]*,$(dir $@)\1.o $@: ,g' > $@; 

$(BUILD_DIR)/%.o: %.c
	$(CC) -c $(CFLAGS) -o $@ $< 

clean:
	$(RM) -rf $(O_FILES) $(DEP_FILES) $(BUILD_DIR)

include $(DEP_FILES)

.PHONY: clean all

print-% : ; $(info $* is a $(flavor $*) variable set to [$($*)]) @true

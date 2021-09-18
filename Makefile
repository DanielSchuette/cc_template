# This is a template to start C/C++ projects from. You _are_ allowed to remove
# this copyright notice, even though it says otherwise. That is because I use
# this notice to copy it into every source file, but it _does not_ apply to
# this sample project! If you see this copyright notice in any other context,
# you're legally required to follow it, though. Beware!
#
# Sample Project Copyright (C) 2021 Daniel Schuette
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.
.DELETE_ON_ERROR:
.EXPORT_ALL_VARIABLES:
SRC_DIR         = src
BUILD_DIR       = build
BIN_DIR         = bin
TESTS_DIR       = tests
BIN             = prog
TESTS_BIN       = test_suite
BIN_FLAGS       = # here, we would provide command line arguments to BIN
TESTS_BIN_FLAGS = # here, we would provide command line arguments to TEST_BIN
LIB_NAME        = libsample.a
GPROF_OUTPUT    = analysis.txt
G2D_OUTPUT      = call_graph.pdf

SHELL = /bin/bash

# We specify globally applicable compiler options right here. They are exported
# to all recursively called Makefiles.
CC      = gcc
CCFLAGS = -Werror -Wall -Wpedantic -Wextra -Wwrite-strings -Warray-bounds \
	 	  -Weffc++ -fno-exceptions --std=c++20 -Og
LDFLAGS = -lm -dl -lstdc++

# For release builds, set DEBUG to anything but "yes".
DEBUG = yes
ifeq ($(DEBUG), yes)
	# to remove <cassert>'s assertions, add -DNDEBUG below
	CCFLAGS += -ggdb -pg -fno-eliminate-unused-debug-symbols
	LDFLAGS += -ggdb -pg
endif

# We are depending on a few programs being available on the user's system. This
# function and the `check' target aren't strictly necessary, they just give
# convenient error messages if a certain program isn't there. If we are never
# actually using a certain target that requires such a program, we can simply
# remove `check_for_prog' and the `check' target and get away with it.
define check_for_prog
	@if ! command -v $(1) >/dev/null 2>&1; then \
		printf "%s \`%s' %s %s.\n" \
			"The program" $(1) "isn't available, please install it or change" \
			"the configuration (see main \`Makefile' at the specified line)"; \
			exit 1; fi
endef

.PHONY: all $(BIN) install run tests archive \
		clean help debug leak_test check prof

all: check dirs $(BIN)

check:
	$(call check_for_prog, $(SHELL))
	$(call check_for_prog, $(CC))
	$(call check_for_prog, ctags)
	$(call check_for_prog, gdb)
	$(call check_for_prog, valgrind)
	$(call check_for_prog, gprof)
	$(call check_for_prog, gprof2dot)
	$(call check_for_prog, dot)

dirs: $(BUILD_DIR) $(BIN_DIR)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

$(BIN):
	ctags -R .
	cd $(SRC_DIR) && $(MAKE)

install: all
	cp $(BUILD_DIR)/$(BIN) $(BIN_DIR)

run: all
	./$(BUILD_DIR)/$(BIN) $(BIN_FLAGS)

archive: all
	ar rcs $(BUILD_DIR)/$(LIB_NAME) $(BUILD_DIR)/*.o

# @NOTE: imcomplete!
tests: archive
	cd $(TESTS_DIR) && $(MAKE)
	./$(TESTS_DIR)/$(TESTS_BIN) $(TESTS_BIN_FLAGS)

# @NOTE: Targets DEBUG, LEAK_TEST and PROF require debugging information to
# work correctly. Thus, DEBUG=yes is required.
debug: all
	gdb -q -tui -args ./$(BUILD_DIR)/$(BIN) $(BIN_FLAGS)

leak_test: all
	valgrind -s --leak-check=full ./$(BUILD_DIR)/$(BIN) $(BIN_FLAGS)

prof: all
	- ./$(BUILD_DIR)/$(BIN) $(BIN_FLAGS)
	gprof ./$(BUILD_DIR)/$(BIN) gmon.out > $(GPROF_OUTPUT)
	gprof2dot -f prof $(GPROF_OUTPUT) | dot -Tpdf -o $(G2D_OUTPUT)

# Since _all_ build artifacts are created in the build directory, we don't need
# to recursively call any subdirectory's Makefile for cleanup. We check whether
# the binary was installed in the base directory, because that might sometimes
# be useful.
clean:
	rm -f tags gmon.out $(GPROF_OUTPUT) $(G2D_OUTPUT)
	rm -rf $(BUILD_DIR)
	[[ '$(BIN_DIR)' != '.' ]] && rm -rf $(BIN_DIR) || rm -f $(BIN)
	cd $(TESTS_DIR) && $(MAKE) clean

help:
	@printf "The following targets are available:\n"
	@printf " all:\t\tBuild \`%s'.\n" $(BIN)
	@printf " install:\tBuild and install \`%s' to \`%s'.\n" $(BIN) $(BIN_DIR)
	@printf " run:\t\tBuild and execute \`%s'.\n" $(BIN)
	@printf " tests:\t\tBuild and execute the test suite.\n"
	@printf " archive:\tBuild \`%s'.\n" $(LIB_NAME)
	@printf " clean:\t\tRemove all build artifacts.\n"
	@printf " debug:\t\tCompile the program and enter gdb.\n"
	@printf " leak_test:\tCompile the program and enter valgrind.\n"
	@printf " prof:\t\tCompile the program and profile it.\n"
	@printf "To enable debugging, add the additional argument \`DEBUG=yes'.\n"
	@printf "This argument is required by targets DEBUG, LEAK_TEST and PROF.\n"

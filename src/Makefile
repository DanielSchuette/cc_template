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
SRCS = $(wildcard *.cc)
OBJS = $(SRCS:.cc=.o)
DEPS = $(SRCS:.cc=.d)

# Since we create all build artifacts in a dedicated build directory, we must
# reconstruct an absolute path for every object file and the resulting binary.
# Also, for them to work, dependency files must be in the same directory as the
# related object file.
BUILD_DIR_PATH = ../$(BUILD_DIR)
BIN_PATH       = $(BUILD_DIR_PATH)/$(BIN)
OBJS_PATH      = $(addprefix $(BUILD_DIR_PATH)/,$(OBJS))
DEPS_PATH      = $(addprefix $(BUILD_DIR_PATH)/,$(DEPS))

.PHONY: all

all: $(BIN_PATH)

# The resulting binary is created in the build directory. The main Makefile can
# then go and place it wherever it might seem appropriate.
$(BIN_PATH): $(OBJS_PATH)
	$(CC) $(LDFLAGS) -o $@ $^

# We create all object files directly in the build directory.
$(OBJS_PATH): $(BUILD_DIR_PATH)/%.o: %.cc
	$(CC) $(CCFLAGS) -MMD -MP -c -o $@ $<

-include $(DEPS_PATH)

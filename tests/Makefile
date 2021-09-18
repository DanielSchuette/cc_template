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

# We don't want to mix build artifacts that belong to our test suite with
# object files that were generated when building the library or user program.
# Thus, we keep everything in our test directory. That's why we have a CLEAN
# target in here!
BUILD_DIR_PATH = ../$(BUILD_DIR)
LIB_PATH       = $(BUILD_DIR_PATH)/$(LIB_NAME)

.PHONY: all clean

# When running this Makefile, the main Makefile must ensure that an archive
# exists at LIB_PATH which provides all the symbols that our test cases use.
all: $(TESTS_BIN)

# The resulting binary is also created in the tests directory. We need to make
# sure that we list the library last, because we want the linker to include the
# main function of our test suite, not that of our library (if it has one, that
# is).
$(TESTS_BIN): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^ $(LIB_PATH)

$(OBJS): %.o: %.cc
	$(CC) $(CCFLAGS) -MMD -MP -c -o $@ $<

clean:
	rm -f *.o *.d $(TESTS_BIN)

-include $(DEPS_PATH)

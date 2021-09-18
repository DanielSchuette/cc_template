# C++ Template
This repository is a template to start `C++` (and with little modification,
`C`) projects from. A top-level [`Makefile`](./Makefile) kicks off compilation
when the user types

```bash
make all     # to build the executable file, or
make run     # to compile & run the executable file, or
make install # to install that binary into the specified BIN_DIR, or
make tests   # to create an archive of the library and run the test suite

# There are a few more targets. To display a list of all of them, run:
make help
```

All source code is supposed to go into `src/`, using a flat directory
hierarchy by default. If deeper nesting is required, `src/Makefile` simply
needs to execute another, similar `Makefile` further down the hierarchy.

Usually, I put headers that (almost) every source file needs into a shared
header `src/common.hh`, that's not a must, though. If you want to get started
with a `C++` project right away, just

```bash
git clone https://github.com/DanielSchuette/cc_template.git <your_proj_name>
```

Now, you should definitely change/update/remove the following files
- this [README.md](./README.md) file
- anything in `src/*` since that's the place to put code you're writing
- `src/common.hh` should be updated (or even removed), according to your needs
- compiler and linker flags in the main [`Makefile`](./Makefile)
- some targets in the main [`Makefile`](./Makefile), see comments below
- you might want to delete `.git/` to initialize your own git repository

Things should be fairly self-explanatory from here. Please consult the main
`Makefile` and its comments for additional explanations of how compilation
works.

A small, last comment regarding some of the `Makefile` targets: I use a bunch
of targets, that are very particular to my tooling, e.g. the `PERF` or `DEBUG`
targets. To not forget to install the necessary dependencies on a new system,
the `Makefile` validates their installation and displays an appropriate error
message if e.g. `gdb` or `valgrind` are not available. You don't have to use
those, of course. Just delete the line that generates the error message (and
maybe the target, so that you don't get confused why it is there in 6 months
from now). But let me say this: on a reasonable Linux distro, all those
programs are just one package manager invocation away, anyways :)

# Incomplete Parts of the Template
This template can be used to quickly get going with a `C++` (or after simple
modifications, `C`) project. It anticipates the workflow I typically establish
for most of my projects of a certain size, that's mainly:

- recompiling source files that changed
- running a binary target with specific command line options for testing
- debugging and profiling the resulting binary
- packaging object files into an archive
- testing of classes/methods/functions in a library

Currently, the last part is what's really lacking. The directory structure and
`Makefile`s facilitate the development of a test suite under `tests`, but I _do
not_ include a testing framework. Usually, I develop one according to specific
project requirements. In the future, I might include a simple test runner in
this repository, along with basic logging facilities and commonly used I/O
functions. We'll see.

# License
This project includes a [GPLv3](./LICENSE.md) license, but every user is
_explicitly_ allowed to remove/add/replace this license when using the code in
this repository. You are also _explicitly_ allowed to remove the copyright
notice from `src/main.cc` if you want to do so in the context of your own
project.

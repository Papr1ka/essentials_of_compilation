# python-student-support-code

Support code for students (Python version).

The `runtime.c` file needs to be compiled by doing the following
```
   gcc -c -g -std=c99 runtime.c
```
This will produce a file named `runtime.o`. The -g flag is to tell the
compiler to produce debug information that you may need to use
the gdb (or lldb) debugger.

On a Mac with an M1 (ARM) processor, use the `-arch x86_64` flag to
compile the runtime:
```
   gcc -c -g -std=c99 -arch x86_64 runtime.c
```

# Using the Racket x86 interpreters (starting from the Tuples compiler)

This section describes how you can use `racket_interp_x86` and
`racket_interp_pseudo_x86` interpreters defined in the
[`racket_interp_x86.py`](racket_interp_x86.py) file. The x86 interpreter defined
in the [`interp_x86`](interp_x86) directory doesn't support the x86-like
languages generated by the select instructions pass of every compiler starting
from the chapter on tuples. The interpreters in
[`racket_interp_x86.py`](racket_interp_x86.py) will help you interpret these
x86-like languages along with actual x86 code. As the name suggests, these
interpreters run using the x86 interpreter in the Racket version of this
repository.

## Setup instructions

1. Install Racket from [here](https://racket-lang.org/download/).

1. Clone the [Racket version of this
   repository](https://github.com/IUCompilerCourse/public-student-support-code)
   into the **parent directory** of this repository. The directory into which
   you clone the repository is important because `racket_interp_x86.py` is
   hardcoded to look for the Racket version of the x86 interpreter in the parent
   directory.

1. Add `racket_interp_pseudo_x86` interpreter to your `interp_dict` for passes
   before assign homes. For the remaining passes, use `racket_interp_x86`.

## Caveats

* Since your x86 code is interpreted in Racket, any errors occurring during
  interpretation will show up in the output diff and not as a Python exception.
* When implementing the languages up to Ltuple, add the `num_root_spills` field to the
  `X86Program` object. Initialize the field `num_root_spills` to the number
  of tuple variables that have been spilled into the root stack.
* When implementing the languages beginning with Lfun and after,  add the following fields to every `FunctionDef` object:
  - `num_root_spills`: Initialize this field to the number
    of tuple variables that have been spilled into the root stack.
  - `num_params`: Initialize this field to the number of parameters that the function
    had after the limit functions pass but before the select instructions pass.
  

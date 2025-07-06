# C++ Project Build Tutorial

This tutorial explains the steps involved in building a C++ project from source, especially when it has external dependencies. We'll use your `AbaqusBatchProcessor2` project as an example.

## 1. The C++ Build Process: Compilation and Linking

Building a C++ application is a two-stage process:

1.  **Compilation:** The C++ compiler (in our case, `g++`) takes each of your `.cpp` source files and translates it into an "object file" (`.o`). Object files contain machine code, but they aren't yet a complete program. If the compiler can't find a function or variable declaration, you'll get a *compilation error*.

2.  **Linking:** The linker takes all the object files generated in the previous step and "links" them together to create a single executable file (e.g., `batchgenerator.exe`). The linker's job is to resolve references between your object files and also to link any external libraries your code uses. If the linker can't find the implementation of a function (which might be in another object file or in a library), you'll get a *linker error*.

## 2. The `build.bat` Script

A build script automates the compilation and linking process. Our `build.bat` script does the following:

*   **Sets up environment variables:** It defines shortcuts for the compiler (`CXX`), the final executable name (`EXECUTABLE`), and the paths to all the libraries we need.
*   **Compiles each `.cpp` file:** It runs `g++ -c` for each source file, creating a corresponding `.o` file. The `-c` flag tells `g++` to compile only, not link.
*   **Links the object files:** After all files are compiled, it runs `g++` one last time to link all the `.o` files and the external libraries into the final `.exe`.
*   **Cleans up:** It deletes the intermediate `.o` files.

## 3. Header Files and Include Paths (`-I`)

*   **Header Files (`.h`):** These files contain function, class, and variable *declarations*. They tell the compiler *what* is available, but not *how* it's implemented. When you `#include` a file, you're essentially pasting its content into your `.cpp` file.

*   **The `-I` Flag:** This flag tells the compiler where to look for header files. For example, `-I C:/Users/crist/git/spdlog/include` tells `g++` to search for headers in that directory. We needed to add include paths for:
    *   `.` and `./geometry2d`: For your own project's headers.
    *   `gmsh`, `spdlog`, `eigen`, and `Qt`: For the external libraries.

## 4. Library Files and Linker Flags (`-L` and `-l`)

*   **Library Files (`.a`, `.lib`):** These files contain the pre-compiled *implementations* of the functions and classes declared in the header files. They are the "other half" of the headers.

*   **The `-L` Flag:** This flag tells the linker where to look for library files. For example, `-L C:/Users/crist/git/spdlog/build` tells the linker to search for libraries in that directory.

*   **The `-l` Flag:** This flag tells the linker *which* library to link. For example, `-lspdlog` tells the linker to find and link the `spdlog` library. The linker will look for a file named `libspdlog.a` (on MinGW/Linux) or `spdlog.lib` (on MSVC) in the paths specified by the `-L` flags.

The "cannot find -l..." errors we saw were because the linker couldn't find the library files in the specified `-L` paths.

## 5. Building Third-Party Libraries with CMake

Libraries like `gmsh` and `spdlog` are often distributed as source code. Before you can use them, you need to build them for your specific system and compiler. This is where a build system generator like **CMake** comes in.

*   **`CMakeLists.txt`:** This is a configuration file that contains instructions on how to build a project.
*   **`cmake .. -G "MinGW Makefiles"`:** This command reads the `CMakeLists.txt` and generates the actual build files (in this case, `Makefile`s for MinGW).
*   **`mingw32-make`:** This command runs the build process using the generated `Makefile`s, which compiles the library source code and creates the final library files (`.a` or `.lib`).

We had to do this for both `gmsh` and `spdlog` because you had their source code but not the compiled libraries that the linker needed.

By following these steps, we were able to correctly configure the build script to compile your code, link it with the necessary libraries, and produce the final executable.

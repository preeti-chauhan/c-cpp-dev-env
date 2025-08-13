## Verified running from the terminal:

**1) Navigate to the project folder:**
```bash
cd vscode-env
```

**2) Build a C Program**
```bash
./build.sh src/hello.c
```
- Compiles src/hello.c with clang
- Outputs binary to build/c/hello

**3) Run a C Program**
```bash
./build/c/hello
```

**Similarly for C++:**

```bash
./build.sh src/hello.cpp
```
- Compiles src/hello.cpp with clang++
- Outputs binary to build/cpp/hello

Run it:
```bash
./build/cpp/hello
```

**4) Clean Builds**
Remove all compiled binaries:
```bash
rm -rf build
```

## VS Code Setup

Since the terminal workflow works, next is to setup VS Code such that `F5` does the same thing automatically and launches the debugger.
The folder `vscode-env` contains `.vscode/` and `build.sh`.

```bash
cd vscode-env
code .
```






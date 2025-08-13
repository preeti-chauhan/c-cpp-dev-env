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

## Folder Structure

```bash
vscode-env/
│
├── .vscode/                # VS Code project configuration
│   ├── launch.json            # Debug configs (C & C++)
│   └── tasks.json             # Build tasks calling build.sh
│
├── src/                       # Source files (C / C++)
│   ├── hello.c
│   └── hello.cpp
│
├── build/                   # Auto-created by build.sh (normally NOT committed)
│   ├── c/                   # C binaries
│   │   └── hello               # compiled hello.c binary
│   └── cpp/                    # C++ binaries
│       └── hello               # compiled hello.cpp binary
│
├── build.sh                   # Build script (C & C++)
└── README.md                  # Project documentation
```

**Notes:**

- `build/` will only exist after you compile something with `build.sh` or press `F5` in VS Code — you don’t manually create it.

- All compiled binaries go into `build/c/` or `build/cpp/` — never in `src/`.

- `.vscode/` contains only the JSON config files for VS Code — no code files go there.

- You commit `build.sh`, `.vscode/`, `src/`, and `README.md` to GitHub. You normally gitignore `build/.`



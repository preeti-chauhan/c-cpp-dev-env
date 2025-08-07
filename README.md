# c-cpp-dev-env

A scaffolded C/C++ development repository providing two parallel workflows:

1. **Docker Environment** (`docker-env/`)  
   Ubuntu 24.04 container with GCC, GDB and Valgrind for reproducible Linux builds and memory checking.

2. **VS Code Environment** (`vscode-env/`)  
   Native macOS build & debug setup using VS Code’s tasks and launch configurations.

---

## Repository Layout

```
c-cpp-dev-env/
├── docker-env/        # Dockerfile and sample source
└── vscode-env/
    └── .vscode/       # tasks.json & launch.json for VS Code
```

---

## Prerequisites

- Docker Desktop (Linux container mode)  
- Visual Studio Code with the **C/C++** extension by Microsoft  
- Git installed and configured (SSH keys or HTTPS credentials)

---

## Automated Setup

A global script (`init-all.sh`) can fully bootstrap your local clone: [readme]()


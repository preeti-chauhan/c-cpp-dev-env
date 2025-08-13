# C/C++ Dev Environment Setup

This guide explains how to organize your development workspace and use the global script to scaffold a new C/C++ project with both Docker and VS Code workflows.

## Directory Layout

```
~/Dev/dev_c_cpp
├── scripts
│   └── init-all.sh            # Global automation script
└── projects
    └── c-cpp-dev-env          # Cloned project directory
        ├── docker-env         # Docker-based environment
        └── vscode-env         # VS Code configuration
```

## Prerequisites

- **Docker Desktop** installed and running  
- **Visual Studio Code** installed with the **C/C++** extension  
- **SSH keys** set up for GitHub (or use HTTPS clone URLs)
- **Remote c-cpp-dev-env.git** already present

## Scaffold a New Project

1. **Ensure your global script is in place**  
   ```bash
   mkdir -p ~/Dev/dev_c_cpp/scripts
   # Copy or create init-all.sh under scripts/
   chmod +x ~/Dev/dev_c_cpp/scripts/init-all.sh
   ```

2. **Run the script**  
   ```bash
   mkdir -p ~/Dev/dev_c_cpp/projects
   cd ~/Dev/dev_c_cpp/projects
   ~/Dev/dev_c_cpp/scripts/init-all.sh https://github.com/your-username/c-cpp-dev-env.git
   ```

   This will:
   - Clone `c-cpp-dev-env` into `~/Dev/dev_c_cpp/projects/`  
   - Create `docker-env/` with a ready-to-use Dockerfile  
   - Create `vscode-env/.vscode/` with `tasks.json` and `launch.json`  
   - Commit the scaffolded files

## Docker Workflow

1. **Build the Docker image**  
   ```bash
   cd ~/Dev/dev_c_cpp/projects/c-cpp-dev-env/docker-env
   docker build -t c-env .
   ```
2. **Run a shell in the container**
    ```bash
    docker run --rm -it -v "$(pwd)":/workspace c-env bash
    ```
    `warning: Error disabling address space randomization: Operation not permitted`
    
    This warning means GDB couldn’t turn off ASLR (address space layout randomization) inside the container. To get rid of it and allow full GDB functionality (including setting breakpoints at fixed addresses), re‐run your container with the following extra flags:
    
    ```bash
    docker run --rm -it \
      --cap-add SYS_PTRACE \
      --security-opt seccomp=unconfined \
      -v "$(pwd)":/workspace \
      c-env bash
    ```
  
 - `cap-add SYS_PTRACE` grants the container permission to trace processes.

 - `security-opt seccomp=unconfined` lifts the default syscall restrictions so GDB can tweak ASLR.

3. **Inside the container, create and run the sample program**
    **3.1) Create hello.c**
    
    ```bash
    cat > hello.c << 'EOF'
    #include <stdio.h>

    int main() {
        printf("Hello, Docker C/C++!\n");
        return 0;
    }
    EOF
    ```
    
    ```txt
    Edit on your Mac, then in the container just compile and run. That keeps workflow fast and container lightweight.
    ```
    
    ```C++
    #include <stdio.h>

    int main() {
        printf("Hello, Docker C/C++!\n");
        return 0;
    }
    ```

    **3.2) Compile**
    ```bash
    gcc -g -O0 hello.c -o hello
    ```

    **3.3) Run**
    ```bash
    ./hello
    ```
    To Exit the container shell:
    - At the container’s shell prompt (e.g. root@…:/workspace#), type: exit
    - or press Ctrl-D

    **3.4) Debug**
    ```bash
    gdb ./hello
    ```
    
    To Quit GDB: 
    - At the (gdb) prompt, type: quit 
    - or press Ctrl-D

    **3.5) Memory check**
    ```bash
    valgrind --leak-check=full ./hello
    ```


## VS Code Workflow

```bash
code ~/Dev/dev_c_cpp/projects/c-cpp-dev-env/vscode-env
```
- Press **⌘⇧B** to build your current file.  
- Press **F5** to debug with GDB.

### Note:

```txt
⌘⇧B (Command + Shift + B) is the keyboard shortcut in Visual Studio Code on macOS for running the “Run Build Task” command. By default, it invokes the build task defined in your .vscode/tasks.json—in our setup, that compiles the current C/C++ file with GCC.
```

## Resume Work

```bash
cd ~/Dev/dev_c_cpp/projects/c-cpp-dev-env
```

### Docker:

```bash
docker build -t c-env docker-env
docker run --rm -it -v "$(pwd)/docker-env":/workspace c-env bash
```

Or if plan to launch GDB:

```bash
docker run --rm -it \
  --cap-add SYS_PTRACE \
  --security-opt seccomp=unconfined \
  -v "$(pwd)":/workspace \
  c-env bash
```

### Visual Studio Code (VS Code):

```bash
# VS Code:
code vscode-env
```

([readme_vscode](https://github.com/preeti-chauhan/c-cpp-dev-env-macos/blob/main/scripts_ref/readme_vscode.md) Further setup required for C/C++ to work.)

## GitHub Quick Help:

### 1. Make sure the local repository is up to date
git pull

### 2. Stage all changes (new files, edits, deletions)
git add .

### 3. Commit with a descriptive message
git commit -m "something descriptive"

### 4. Push to remote ‘main’ branch
git push -u origin main



#!/usr/bin/env bash
set -euo pipefail

# init-all.sh
# Automates cloning and scaffolding of C/C++ Docker and VS Code environments.
# Usage: ./init-all.sh [github-username | full-git-repo-url]

# 1. Read input (username or URL)
if [[ $# -ge 1 ]]; then
  INPUT="$1"
else
  read -p "Enter GitHub username or repo URL: " INPUT
fi

# 2. Determine REPO_URL
if [[ "$INPUT" =~ ^[A-Za-z0-9_-]+$ ]]; then
  # Only username provided; assume standard repo name
  # REPO_URL="git@github.com:${INPUT}/c-cpp-dev-env.git"
  REPO_URL="https://github.com/${INPUT}/c-cpp-dev-env.git"
else
  # Full URL provided
  REPO_URL="$INPUT"
fi

# 3. Extract repository name
REPO_NAME="$(basename -s .git "$REPO_URL")"

# 4. Clone and enter
git clone "$REPO_URL"
cd "$REPO_NAME"

# 5. Create environment directories
mkdir -p docker-env vscode-env/.vscode

# 6. Generate Dockerfile
cat > docker-env/Dockerfile << 'EOF'
# Base: Ubuntu 24.04
FROM ubuntu:24.04

# Install C/C++ toolchain, gdb, and Valgrind
RUN apt-get update && \\
    apt-get install -y --no-install-recommends \\
      build-essential gdb valgrind && \\
    rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
CMD ["bash"]
EOF

# 7. Generate VS Code build task
cat > vscode-env/.vscode/tasks.json << 'EOF'
{
  "version": "2.0.0",
  "tasks": [{
    "label": "Build",
    "type": "shell",
    "command": "gcc -g -O0 \${file} -o \${fileBasenameNoExtension}"
  }]
}
EOF

# 8. Generate VS Code debug config
cat > vscode-env/.vscode/launch.json << 'EOF'
{
  "version": "0.2.0",
  "configurations": [{
    "name": "Debug",
    "type": "cppdbg",
    "request": "launch",
    "program": "\${fileDirname}/\${fileBasenameNoExtension}",
    "cwd": "\${workspaceFolder}",
    "MIMode": "gdb"
  }]
}
EOF

# 9. Stage and commit
git add docker-env vscode-env
git commit -m "scaffold docker-env & vscode-env"

# 10. Prompt next step
echo "Scaffold complete. Run: git push -u origin main"

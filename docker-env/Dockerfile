# Base: Ubuntu 24.04
FROM ubuntu:24.04

# Install C/C++ toolchain, gdb, and Valgrind
RUN apt-get update && \\
    apt-get install -y --no-install-recommends \\
      build-essential gdb valgrind && \\
    rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
CMD ["bash"]

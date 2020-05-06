#!/bin/bash

echo "Begin to build stage1 of clang"
echo "Do initial bootstrap compiler activation ..."
conda-build -c local -m cbc_boot_from.yaml clang_bootstrap_osx-64-feedstock
echo "Now we can start to do standard ...dev builds for new version"
conda-build -c local -m cbc_boot_from.yaml llvmdev-feedstock
conda-build -c local -m cbc_boot_from2.yaml clangdev-feedstock
echo "First runtime library"
conda-build -c local -m cbc_boot_from2.yaml libcxx-feedstock
conda-build -c local -m cbc_boot_from2.yaml tapi-feedstock
echo "Now we attempt to eat our own food ..."
conda-build -c local -e ../conda_build_config.yaml cctools-and-ld64-feedstock
conda-build -c local -e ../conda_build_config.yaml compiler-rt-feedstock
conda-build -c local -e ../conda_build_config.yaml clang-compiler-activation-feedstock
echo "Hurray, we reached initial state ... now next stage"


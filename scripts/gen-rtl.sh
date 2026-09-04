#!/bin/bash
set -euo pipefail

# Generate RTL (Verilog) for the RISC-V core.
# Output goes to rtl/RiscvCore.v

cd "$(dirname "$0")/.."

sbt -batch "runMain rv32c.RiscvCoreGen"

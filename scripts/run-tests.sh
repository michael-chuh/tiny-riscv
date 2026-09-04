#!/bin/bash
set -euo pipefail

# Run all unit / simulation tests.

cd "$(dirname "$0")/.."

sbt -batch test

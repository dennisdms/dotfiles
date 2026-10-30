#!/bin/bash
set -e

# Pi packages
command -v pi &>/dev/null || exit 0
pi install npm:@ollama/pi-web-search

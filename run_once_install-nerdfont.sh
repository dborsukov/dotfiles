#!/bin/bash

sudo apt update && sudo apt install -y curl

curl -fsSL https://raw.githubusercontent.com/getnf/getnf/main/install.sh | bash

~/.local/bin/getnf -i IosevkaTerm

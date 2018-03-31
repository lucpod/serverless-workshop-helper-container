#!/usr/bin/env bash
set -e

# Banner
printf '\e[94m _                            _ \e[0m\n'
printf '\e[94m| |_   _  ___ _ __   ___   __| |\e[0m\n'
printf '\e[94m| | | | |/ __| ._ \ / _ \ / _` |\e[0m\n'
printf '\e[94m| | |_| | (__| |_) | (_) | (_| |\e[0m\n'
printf '\e[94m|_|\__,_|\___| .__/ \___/ \__,_|\e[0m\n'
printf '\e[94m             |_|                \e[0m\n'
printf '\e[94m                                \e[0m\n'
printf '\e[94m   https://github.com/lucpod    \e[0m\n'
printf '\n'

# System info
printf '  ● Node.js:   \e[94m%s\e[0m\n' $(node --version | cut -d'v' -f2)
printf '  ● NPM:       \e[94m%s\e[0m\n' $(npm --version)
printf '  ● Python:    \e[94m%s\e[0m\n' $(python --version 2>&1 | cut -d' ' -f2)
printf '  ● PIP:       \e[94m%s\e[0m\n' $(pip --version | cut -d' ' -f2)
printf '  ● Go:        \e[94m%s\e[0m\n' $(go version | cut -d' ' -f3 | cut -d'g' -f2 | cut -d'o' -f2)
printf '  ● SAM local: \e[94m%s\e[0m\n' $(aws-sam-local --version | cut -d' ' -f3)
printf '  ● AWS CLI:   \e[94m%s\e[0m\n' $(aws --version 2>&1 | cut -d' ' -f1 | cut -d'/' -f2)

# Configures AWS CLI
# TODO

# Run custom command or bash
if [ -z "$1" ]; then
  exec bash
else
  exec "$@"
fi

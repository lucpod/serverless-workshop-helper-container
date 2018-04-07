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
printf '  ● Docker:    \e[94m%s\e[0m\n' $(docker --version | cut -d' ' -f3 | cut -d',' -f1)
printf '  ● Node.js:   \e[94m%s\e[0m\n' $(node --version | cut -d'v' -f2)
printf '  ● NPM:       \e[94m%s\e[0m\n' $(npm --version)
printf '  ● Python:    \e[94m%s\e[0m\n' $(python --version 2>&1 | cut -d' ' -f2)
printf '  ● PIP:       \e[94m%s\e[0m\n' $(pip --version | cut -d' ' -f2)
printf '  ● SAM:       \e[94m%s\e[0m\n' $(sam --version | head -n 1 | cut -d' ' -f3)
printf '  ● AWS CLI:   \e[94m%s\e[0m\n' $(aws --version 2>&1 | cut -d' ' -f1 | cut -d'/' -f2)
printf '\n\n\n'

# Configures AWS CLI
if [[ -z "$AWS_ACCESS_KEY_ID" ]] || [[ -z "$AWS_SECRET_ACCESS_KEY" ]] ; then
    printf "\e[94m\033[1m--------------------------------\033[0m\n"
    printf "\e[94m\033[1mWARNING\033[0m: AWS CLI not congifured!\e[0m\n"
    printf "\e[94m\033[1m--------------------------------\033[0m\n\n"
    printf "Run '\033[1maws configure\033[0m' or restart the container with the following environment variables\e[0m\n"
    printf "\e[94m  - \033[1mAWS_ACCESS_KEY_ID\033[0m: AWS access id for your user\e[0m\n"
    printf "\e[94m  - \033[1mAWS_SECRET_ACCESS_KEY\033[0m: AWS secret access key for your user\e[0m\n"
    printf "\e[94m  - \033[1mAWS_REGION\033[0m: (optional) The AWS region (default: 'eu-west-1')\e[0m\n"
    printf "\e[94m  - \033[1mAWS_OUTPUT_FORMAT\033[0m: (optional) The AWS console preferred output (default: 'json')\e[0m\n"
    printf '\n\n\n'
else
    AWS_REGION=${AWS_REGION:-'eu-west-1'}
    AWS_OUTPUT_FORMAT=${AWS_OUTPUT_FORMAT:-'json'}
    mkdir -p "/root/.aws"
    sed -e "s;%AWS_ACCESS_KEY_ID%;${AWS_ACCESS_KEY_ID};g" -e "s;%AWS_SECRET_ACCESS_KEY%;${AWS_SECRET_ACCESS_KEY};g" "/root/templates/aws_credentials.tpl" > "/root/.aws/credentials"
    sed -e "s;%AWS_REGION%;${AWS_REGION};g" -e "s;%AWS_OUTPUT_FORMAT%;${AWS_OUTPUT_FORMAT};g" "/root/templates/aws_config.tpl" > "/root/.aws/config"
fi

# Run custom command or bash
if [ -z "$1" ]; then
  exec bash
else
  exec "$@"
fi

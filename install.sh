#!/usr/bin/env bash

set -euo pipefail

[[ "${TRACE:-0}" == 1 ]] && set -x

# shellcheck disable=SC1091
readonly DISTRO=$(. /etc/os-release && echo "$ID")
readonly COLOR_ERROR="\033[0;31m"
readonly COLOR_SUCCESS="\033[0;32m"
readonly NO_COLOR="\033[0m"

install-git() {
	if [[ $(git --version) ]]; then
  	configure-git
	else
		if [[ "$DISTRO" == "ubuntu" ]]; then
			echo "==> Installing git"
			apt-get update && apt-get -qq -y install git && configure-git
		fi
	fi
}

configure-git() {
	local clone tmpdir copy

	echo "==> Setting Git"
	printf "==> Clone settings in gist... "

	tmpdir="/tmp/git$(date +"%s")"
	clone=$(git clone -q https://gist.github.com/adb278d1ce8b3db2207b7817a81be8f5.git "$tmpdir")

	if [[ "$clone" -eq 0 ]]; then
		message-success
		printf "==> Copy settings... "

		copy=$(cp "$tmpdir/gitSettings" "$HOME/.gitconfig")

		if [[ "$copy" -eq 0 ]]; then
			message-success
			rm -rf "$tmpdir"
		else
			message-error
		fi
	else
		message-error
	fi
}

message-success () {
	echo -e "${COLOR_SUCCESS}OK${NO_COLOR}"
}

message-error () {
	echo -e "${COLOR_ERROR}ERROR${NO_COLOR}"
	exit 1
}

main() {
	echo -e "${COLOR_SUCCESS}START${NO_COLOR}"
	echo ""

	install-git

	echo ""
	echo -e "${COLOR_SUCCESS}END${NO_COLOR}"
	exit 0
}

main "$@"
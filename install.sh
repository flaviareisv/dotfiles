#!/usr/bin/env bash

set -euo pipefail

[[ "${TRACE:-0}" == 1 ]] && set -x

# shellcheck disable=SC1091
readonly DISTRO=$(. /etc/os-release && echo "$ID_LIKE")
readonly COLOR_ERROR="\033[0;31m"
readonly COLOR_SUCCESS="\033[0;32m"
readonly NO_COLOR="\033[0m"

install-git() {
	local igit

	echo "==> Setting Git"

	if [[ $(git --version) ]]; then
  		configure-git
	else
		printf "Installing git... "

		igit=$(sudo -E apt-get -qq update && sudo -E apt-get -qq -y install git)

		if [[ "$igit" ]]; then
			message-success
			configure-git
		else
			message-error
		fi
	fi
}

install-profile() {
	local filebash isconfig fileconfig

	echo "==> Setting profile"

	filebash="$HOME/.bashrc"
	fileconfig="$HOME/dotfiles/bashrc"

	if [[ -f $filebash ]]; then
		printf "==> Inject profile config in file... "

		isconfig=$(grep -c "$fileconfig" "$filebash")

		if [[ $isconfig ]]; then
			echo -e "${COLOR_ERROR}config already exists.${NO_COLOR}"
		else
			echo ". $fileconfig" >> "$filebash"
			message-success
		fi
	else
		echo -e "${COLOR_ERROR}.bashrc not found${NO_COLOR}"
	fi
}

install-ssh() {
	local tmpdir clone

	echo "==> Setting ssh config"

	if [[ -e "$HOME/.ssh/config" ]]; then
		echo -e "${COLOR_ERROR}==> File ssh config already exists <==${NO_COLOR}"
	else
		tmpdir="/tmp/ssh$(date +"%s")"

		printf "==> Clone settings from gist... "

		clone=$(git clone -q https://gist.github.com/3698de13b1973fadc70229bef53ce322.git "$tmpdir")

		if [[ "$clone" -eq 0 ]]; then
			message-success
			printf "==> Copy settings... "

			if [[ -d "$HOME/.ssh" ]]; then
				configure-ssh "$tmpdir"
			else
				if [[ $(mkdir "$HOME/.ssh") ]]; then
					configure-ssh "$tmpdir"
				else
					echo -e "${COLOR_ERROR}Error create folder .ssh${NO_COLOR}"
					exit 1
				fi
			fi
		else
			message-error
		fi
	fi
}

configure-git() {
	local clone tmpdir copy

	printf "==> Clone settings from gist... "

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

configure-ssh() {
	local copy

	if ! [[ -z "$1" ]]; then
		copy=$(cp "$1/sshConfig" "$HOME/.ssh/config")

		if [[ "$copy" -eq 0 ]]; then
			message-success
			rm -rf "$1"
		else
			message-error
		fi
	else
		echo -e "${COLOR_ERROR}file config not found${NO_COLOR}"
	fi
}

init() {
	echo "==> Start <=="
	echo ""
}

end() {
	echo ""
	echo "==> Finalized <=="
}

message-success() {
	echo -e "${COLOR_SUCCESS}OK${NO_COLOR}"
}

message-error() {
	echo -e "${COLOR_ERROR}ERROR${NO_COLOR}"
	exit 1
}

main() {
	init

	if [[ "$DISTRO" == "debian" ]]; then
		install-git
		install-profile
		install-ssh

		end
		exit 0
	else
		echo -e "${COLOR_ERROR}System not distribution .deb${NO_COLOR}"

		end
		exit 1
	fi
}

main "$@"
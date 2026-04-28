case ${EAPI} in
		8) ;;
		*) die "${ECLASS}: EAPI ${EAPI:-0} not supported"
esac

if [[ -z ${_SHELL_COMPLETION_ECLASS} ]]; then
_SHELL_COMPLETION_ECLASS=1

# @FUNCTION: dobashcomp
# @USAGE: <file> [...]
# @DESCRIPTION:
# Install bash-completion files passed as args. Has EAPI-dependent failure
# behavior (like doins).
dobashcomp() {
		debug-print-function ${FUNCNAME} "$@"

		(
				insopts -m 0644
				insinto "/usr/share/bash-completion/completions"
				doins "${@}"
		)
}

# @FUNCTION: newbashcomp
# @USAGE: <file> <newname>
# @DESCRIPTION:
# Install bash-completion file under a new name. Has EAPI-dependent failure
# behavior (like newins).
newbashcomp() {
		debug-print-function ${FUNCNAME} "$@"

		(
				insopts -m 0644
				insinto "/usr/share/bash-completion/completions"
				newins "${@}"
		)
}


# @FUNCTION: dozshcomp
# @USAGE: <file...>
# @DESCRIPTION:
# Install zsh completion files passed as args.
dozshcomp() {
    debug-print-function ${FUNCNAME} "$@"

    (
				insopts -m 0644
				insinto "/usr/share/zsh/site-functions"
				doins "${@}"
    )
}

# @FUNCTION: newzshcomp
# @USAGE: <file> <newname>
# @DESCRIPTION:
# Install zsh file under a new name.
newzshcomp() {
		debug-print-function ${FUNCNAME} "$@"

		(
				insopts -m 0644
				insinto "/usr/share/zsh/site-functions"
				newins "${@}"
		)
}

fi

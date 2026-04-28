EAPI=8

LICENSE=""

# Short one-line description of this package.
DESCRIPTION="A small build system with a focus on speed."

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://ninja-build.org/"

# Point to any required sources; these will be automatically downloaded by
# Portage.
SRC_URI="https://github.com/ninja-build/ninja/archive/v${PV}/ninja-${PV}.tar.gz"
#S="${WORKDIR}/${P}"

SLOT="0"

KEYWORDS="amd64"

IUSE="-test"

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""

# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"

# Build-time dependencies that are executed during the emerge process
BDEPEND="dev-lang/python"

src_configure() { :; }

src_compile() {
	python3 configure.py --bootstrap --verbose || die
}

src_install() {
    dobin ninja

    insinto /usr/share/bash-completion/completions
    doins misc/bash-completion
    newins misc/bash-completion ninja

    insinto /usr/share/zsh/site-functions
    newins misc/zsh-completion _ninja
}

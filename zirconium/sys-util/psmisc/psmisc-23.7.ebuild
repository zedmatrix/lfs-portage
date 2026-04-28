EAPI=8
DESCRIPTION="The Psmisc package contains programs for displaying information about running processes."

HOMEPAGE="https://gitlab.com/psmisc/psmisc"

SRC_URI="https://sourceforge.net/projects/psmisc/files/psmisc/psmisc-${PV}.tar.xz"
#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="-test"

# Run-time Dependencies.
RDEPEND=""

# Build-time Dependencies that need to be binary compatible with the system
# being built (CHOST).
DEPEND="${RDEPEND}"

# Build-time dependencies that are executed during the emerge process, and
# only need to be present in the native build system (CBUILD). Example:
BDEPEND=""

src_configure() {
	econf
}

src_compile() {
	emake
}

src_test() {
	emake check
}

src_install() {
	emake DESTDIR="${D}" install
}

pkg_postinst() {
    ldconfig
}

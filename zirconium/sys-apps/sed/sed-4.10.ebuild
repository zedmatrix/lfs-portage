EAPI=8
DESCRIPTION="The Sed package contains a stream editor."

HOMEPAGE="https://www.gnu.org/software/sed/"

SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/sed/sed-${PV}.tar.xz "
#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="-test"

# Run-time Dependencies.
RDEPEND="sys-libs/glibc"

# Dependencies
DEPEND="${RDEPEND}"

# Build-time dependencies.
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

EAPI=8
LICENSE=""
# Short one-line description of this package.
DESCRIPTION=" "
# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://www.gnu.org/software/libunistring/"

SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/libunistring/libunistring-${PV}.tar.xz"
#S="${WORKDIR}/${P}"

SLOT="0"
KEYWORDS="amd64"
IUSE=""
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""
# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"
# Build-time dependencies that are executed during the emerge process
BDEPEND=""

src_configure() {
	econf --prefix=/usr --disable-static --docdir=/usr/share/doc/libunistring-${PV}
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

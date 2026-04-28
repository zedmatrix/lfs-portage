EAPI=8

DESCRIPTION="A portable, high level programming interface to various calling conventions."

HOMEPAGE="https://sourceware.org/libffi/"

SRC_URI="https://github.com/libffi/libffi/releases/download/v${PV}/libffi-${PV}.tar.gz"

#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""

# Build-time dependencies that need to be binary compatible with the system
DEPEND=""

# Build-time dependencies that are executed during the emerge process, and
BDEPEND=""

src_configure() {
	econf --prefix=/usr \
	      --disable-static \
	      --with-gcc-arch=native
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

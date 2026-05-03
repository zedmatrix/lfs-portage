EAPI=8

DESCRIPTION="The Zlib package contains compression and decompression routines used by some programs."

HOMEPAGE="https://zlib.net/"

SRC_URI="https://zlib.net/fossils/zlib-${PV}.tar.gz"
#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""
#RESTRICT="strip"
RDEPEND=""
DEPEND="${RDEPEND}
    sys-libs/glibc
"

# Build-time dependencies that are executed during the emerge process, and
# only need to be present in the native build system (CBUILD). Example:
BDEPEND=""

src_configure() {
    ${S}/configure --prefix=/usr
}

src_compile() {
    emake
}

src_install() {
    emake DESTDIR="${D}" install
}

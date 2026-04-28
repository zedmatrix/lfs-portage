EAPI=8

DESCRIPTION="The File package contains a utility for determining the type of a given file or files."

HOMEPAGE="https://www.darwinsys.com/file/"

SRC_URI="https://astron.com/pub/file/file-${PV}.tar.gz"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}
    sys-libs/glibc
"
BDEPEND=""

src_configure() {
	econf --prefix=/usr
}

src_compile() {
	emake
}

src_install() {
    emake DESTDIR="${D}" install
}

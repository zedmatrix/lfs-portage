EAPI=8
DESCRIPTION="The Gzip package contains programs for compressing and decompressing files."

HOMEPAGE="https://www.gnu.org/software/gzip/"

SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/gzip/gzip-${PV}.tar.xz"

#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="-test"

RDEPEND=""
DEPEND="${RDEPEND}"
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

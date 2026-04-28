EAPI=8

DESCRIPTION="The M4 package contains a macro processor."

HOMEPAGE="https://www.gnu.org/software/m4/"

SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/m4/m4-${PV}.tar.xz"
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
BDEPEND=""

src_configure() {
	${S}/configure --prefix=/usr || die
}

src_compile() {
	emake
}

src_install() {
    emake DESTDIR="${D}" install
}

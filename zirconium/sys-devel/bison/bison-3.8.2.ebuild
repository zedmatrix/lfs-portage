EAPI=8

DESCRIPTION="The Bison package contains a parser generator."

HOMEPAGE="https://www.gnu.org/software/bison/"

SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/bison/bison-${PV}.tar.xz"
#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""
#RESTRICT="strip"
RDEPEND=""
DEPEND="${RDEPEND}
    >=sys-devel/m4-1.4.16
    sys-devel/gettext
"
BDEPEND=""

src_configure() {
	econf --docdir=/usr/share/doc/bison-${PV}
}

src_compile() {
	emake
}

src_install() {
    emake DESTDIR="${D}" install
}

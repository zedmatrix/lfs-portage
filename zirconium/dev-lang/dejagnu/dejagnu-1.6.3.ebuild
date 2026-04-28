EAPI=8

DESCRIPTION="The DejaGnu package contains a framework for running test suites on GNU tools."
HOMEPAGE="https://www.gnu.org/software/dejagnu/"

SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/dejagnu/dejagnu-${PV}.tar.gz"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""
#RESTRICT="strip"

RDEPEND=""
DEPEND="${RDEPEND}
    dev-lang/tcl
    dev-lang/expect
"
BDEPEND=""

src_configure() {
    mkdir -p "${WORKDIR}/build"
    cd "${WORKDIR}/build" || die
    ${S}/configure --prefix=/usr || die
}

src_compile() {
    cd "${WORKDIR}/build" || die
    emake
    makeinfo --html --no-split -o doc/dejagnu.html ${S}/doc/dejagnu.texi || die
    makeinfo --plaintext       -o doc/dejagnu.txt  ${S}/doc/dejagnu.texi || die
}

src_install() {
    cd "${WORKDIR}/build" || die
    emake DESTDIR="${D}" install
    docinto /usr/share/doc/dejagnu-${PV}
    dodoc doc/dejagnu.html doc/dejagnu.txt
}

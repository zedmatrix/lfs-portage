EAPI=8

DESCRIPTION="The Gettext package contains utilities for internationalization and localization."

HOMEPAGE="https://www.gnu.org/software/gettext/"

SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/gettext/gettext-${PV}.tar.xz"
#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""
#RESTRICT="strip"
RDEPEND=""
DEPEND="${RDEPEND}
    sys-libs/ncurses
"
BDEPEND=""

src_configure() {
	econf --docdir=/usr/share/doc/gettext-${PV}
}

src_compile() {
	emake
}

src_install() {
    emake DESTDIR="${D}" install
}

pkg_postinst() {
    ldconfig
}

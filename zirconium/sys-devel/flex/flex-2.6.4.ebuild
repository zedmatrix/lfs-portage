EAPI=8

DESCRIPTION="The Flex package contains a utility for generating programs that recognize patterns in text."

HOMEPAGE="https://github.com/westes/flex"

SRC_URI="https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz"
#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""
#RESTRICT="strip"
RDEPEND=""
DEPEND="${RDEPEND}
    sys-devel/gettext
    sys-devel/bison
"
BDEPEND=""

src_configure() {
	econf
}

src_compile() {
	emake
}

src_install() {
    emake DESTDIR="${D}" install
    dosym flex   /usr/bin/lex
    dosym flex.1 /usr/share/man/man1/lex.1
}

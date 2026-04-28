EAPI=8

DESCRIPTION="The Bc package contains an arbitrary precision numeric processing language."

HOMEPAGE="https://github.com/gavinhoward"

SRC_URI="https://github.com/gavinhoward/bc/releases/download/${PV}/bc-${PV}.tar.xz"
#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""
#RESTRICT="strip"
RDEPEND=""
DEPEND="${RDEPEND}
    sys-devel/m4
    sys-libs/readline
"

BDEPEND=""

src_configure() {
    CC='gcc -std=c99' \
    ${S}/configure --prefix=/usr -G -O3 -r || die
}

src_compile() {
	emake || die
}

src_install() {
    emake DESTDIR="${D}" install
}

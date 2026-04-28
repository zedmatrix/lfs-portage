EAPI=8
DESCRIPTION="The Less package contains a text file viewer."

HOMEPAGE="https://www.greenwoodsoftware.com/less/"

SRC_URI="https://www.greenwoodsoftware.com/less/less-${PV}.tar.gz"
#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="-test"

DEPEND="
	>=sys-libs/ncurses-5.2
	sys-libs/pcre2
"
RDEPEND="${DEPEND}"
BDEPEND=" test? ( dev-util/pkgconfig ) "

src_configure() {
	econf --prefix=/usr --sysconfdir=/etc
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install

}

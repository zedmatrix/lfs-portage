EAPI=8
DESCRIPTION="The Attr package contains utilities to administer the extended attributes of filesystem objects."

HOMEPAGE="https://savannah.nongnu.org/projects/attr"

SRC_URI="https://download.savannah.gnu.org/releases/attr/attr-${PV}.tar.gz"
#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="test"

#RESTRICT="strip"
RDEPEND=""

DEPEND="${RDEPEND}"

BDEPEND="sys-devel/gettext"

src_configure() {
	econf --prefix=/usr \
	      --disable-static \
          --sysconfdir=/etc \
          --docdir=/usr/share/doc/attr-${PV}
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

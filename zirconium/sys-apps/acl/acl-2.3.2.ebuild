EAPI=8
DESCRIPTION="The Acl package contains utilities to administer Access Control Lists for files and directories."

HOMEPAGE="https://savannah.nongnu.org/projects/acl"

SRC_URI="https://download.savannah.gnu.org/releases/acl/acl-2.3.2.tar.xz"

#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="test"

#RESTRICT="strip"

RDEPEND=">=sys-apps/attr-2.4.47"

DEPEND="${RDEPEND}"

BDEPEND="sys-devel/gettext"

src_configure() {
	econf --prefix=/usr \
	      --disable-static \
	      --docdir=/usr/share/doc/acl-${PV}
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install

}

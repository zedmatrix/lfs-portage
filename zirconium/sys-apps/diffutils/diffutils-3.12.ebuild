EAPI=8
DESCRIPTION="The Diffutils package contains programs that show the differences between files or directories."

HOMEPAGE="https://www.gnu.org/software/diffutils/"

SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/diffutils/diffutils-${PV}.tar.xz"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="-test"

#RESTRICT="strip"
#RESTRICT="!test? ( test )"

RDEPEND="sys-libs/glibc"
DEPEND="${RDEPEND}"
BDEPEND="sys-devel/gettext"

src_configure() {
	econf
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install

}

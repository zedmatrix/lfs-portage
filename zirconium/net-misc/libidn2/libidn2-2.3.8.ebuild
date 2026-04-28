EAPI=8
LICENSE=""
# Short one-line description of this package.
DESCRIPTION="A package designed for internationalized string handling based on standards from the Internet Engineering Task Force."
# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="
	https://www.gnu.org/software/libidn/#libidn2
	https://gitlab.com/libidn/libidn2/
"
SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/libidn/libidn2-${PV}.tar.gz"
#S="${WORKDIR}/${P}"

SLOT="0"
KEYWORDS="amd64"
IUSE="nls"
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="dev-libs/libunistring"
# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"
# Build-time dependencies that are executed during the emerge process
BDEPEND="
	dev-lang/perl
	nls? ( sys-devel/gettext )
"

src_configure() {
	econf --prefix=/usr --disable-static
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

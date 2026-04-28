EAPI=8
LICENSE=""
# Short one-line description of this package.
DESCRIPTION="A utility useful for non-interactive downloading of files from the Web."
# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://www.gnu.org/software/wget/"

SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/wget/wget-${PV}.tar.gz"
#S="${WORKDIR}/${P}"

SLOT="0"
KEYWORDS="amd64"
IUSE="nls"
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""
# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}
	net-misc/libidn2
	net-misc/libpsl
	sys-libs/pcre2
	dev-libs/openssl
	sys-apps/util-linux
	app-arch/zlib
"
# Build-time dependencies that are executed during the emerge process
BDEPEND="
	app-arch/xz
	dev-lang/perl
	sys-apps/texinfo
	dev-util/pkgconf
	nls? ( sys-devel/gettext )
"

src_configure() {
	econf --prefix=/usr --sysconfdir=/etc --with-ssl=openssl
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

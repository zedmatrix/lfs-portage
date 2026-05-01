EAPI=8
LICENSE=""
# Short one-line description of this package.
DESCRIPTION="A multi-platform support library with a focus on asynchronous I/O."
# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://github.com/libuv/libuv"

SRC_URI="https://dist.libuv.org/dist/v${PV}/libuv-v${PV}.tar.gz"
S="${WORKDIR}/${PN}-v${PV}"

SLOT="0"
KEYWORDS="amd64"
IUSE=""
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""
# Build-time dependencies that need to be binary compatible with the system
DEPEND="
	sys-libs/glibc
	dev-build/autoconf
"
# Build-time dependencies that are executed during the emerge process
BDEPEND="
	dev-build/libtool
	dev-util/pkgconf
"

src_configure() {
	sh autogen.sh || die "autogen failure"
	econf --prefix=/usr --disable-static
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

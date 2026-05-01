EAPI=8
LICENSE=""
# Short one-line description of this package.
DESCRIPTION="Package contains a low-level cryptographic library that is designed to fit easily in many contexts."
# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://www.lysator.liu.se/~nisse/nettle"

SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/nettle/nettle-4.0.tar.gz"
#S="${WORKDIR}/${P}"

SLOT="0"
KEYWORDS="amd64"
IUSE=""
# Build-time dependencies that need to be binary compatible with the system
DEPEND="
	sys-libs/glibc
	>=dev-libs/gmp-6.1
"
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="${DEPEND}"

# Build-time dependencies that are executed during the emerge process
BDEPEND="
	sys-devel/m4
	sys-apps/texinfo
"

src_configure() {
	econf --prefix=/usr --disable-static
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install

	insopts 755 /usr/lib/libhogweed.so
	insopts 755 /usr/lib/libnettle.so
	dodoc nettle.html nettle.pdf
}

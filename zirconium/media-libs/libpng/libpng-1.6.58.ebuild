EAPI=8
LICENSE=""
# Short one-line description of this package.
DESCRIPTION="The libpng package contains libraries used by other programs for reading and writing PNG files."
# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://www.libpng.org/"

SRC_URI="https://downloads.sourceforge.net/libpng/libpng-${PV}.tar.xz"
#S="${WORKDIR}/${P}"

PATCHES=(
	"${FILESDIR}/libpng-1.6.57-apng.patch"
)
SLOT="0"
KEYWORDS="amd64"
IUSE=""
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="app-arch/zlib"
# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"
# Build-time dependencies that are executed during the emerge process
BDEPEND=""

src_configure() {
	${S}/configure --prefix=/usr --disable-static || die "configure failure"
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc README libpng-manual.txt
}

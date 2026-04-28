EAPI=8
LICENSE=""

DESCRIPTION="The Man-pages package contains over 2,400 man pages."

HOMEPAGE="https://www.kernel.org/doc/man-pages/"

SRC_URI="https://www.kernel.org/pub/linux/docs/man-pages/man-pages-${PV}.tar.xz"
#S="${WORKDIR}/${P}"

SLOT="0"

KEYWORDS="amd64"

IUSE=""
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""
# Build-time dependencies that need to be binary compatible with the system
DEPEND=""
# Build-time dependencies that are executed during the emerge process
BDEPEND=""

src_configure() {
	export prefix="${EPREFIX}/usr"
	export GIT=false
}

src_compile() {
	rm -v man3/crypt* || die
	rm -v man/man5/passwd.5 || die
 }

src_test() { :; }

src_install() {
	emake -R DESTDIR="${D}" install
}

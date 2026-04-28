EAPI=8
LICENSE=""

DESCRIPTION="The Man-DB package contains programs for finding and viewing man pages."

HOMEPAGE="https://www.nongnu.org/man-db/"

SRC_URI="https://download.savannah.gnu.org/releases/man-db/man-db-${PV}.tar.xz"
#S="${WORKDIR}/${P}"

SLOT="0"

KEYWORDS="amd64"

IUSE=""
CDEPEND="
	>=dev-libs/libpipeline-1.5.0
	>=sys-apps/groff-1.20.0
	sys-libs/gdbm
	sys-libs/libseccomp
	app-arch/zlib
"
# Build-time dependencies that need to be binary compatible with the system
DEPEND="${CDEPEND}"
# Build-time dependencies that are executed during the emerge process
BDEPEND="
	app-arch/xz
	sys-devel/gettext
"
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="${CDEPEND}"

src_configure() {
	econf --prefix=/usr \
	      --sysconfdir=/etc \
          --disable-setuid \
          --enable-cache-owner=bin \
          --with-browser=/usr/bin/lynx \
          --with-vgrind=/usr/bin/vgrind \
          --with-grap=/usr/bin/grap \
          --docdir=/usr/share/doc/man-db-${PV}
}

src_compile() {
	emake
}

src_test() { :; }

src_install() {
	emake DESTDIR="${D}" install
}

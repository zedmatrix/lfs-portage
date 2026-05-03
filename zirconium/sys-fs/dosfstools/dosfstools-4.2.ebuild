EAPI=8
LICENSE=""

# Short one-line description of this package.
DESCRIPTION="Contains various utilities for use with the FAT family of file systems."
# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://github.com/dosfstools/dosfstools"

SRC_URI="https://github.com/dosfstools/dosfstools/releases/download/v${PV}/dosfstools-${PV}.tar.gz"
#S="${WORKDIR}/${P}"

SLOT="0"
KEYWORDS="amd64"
IUSE=""
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""
# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"
# Build-time dependencies that are executed during the emerge process
BDEPEND=""

src_configure() {
	econf --prefix=/usr \
	      --mandir=/usr/share/man \
	      --enable-compat-symlinks \
          --docdir=/usr/share/doc/dosfstools-${PV}
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

EAPI=8
LICENSE=""
# Short one-line description of this package.
DESCRIPTION="A data compression library which is suitable for data decompression and compression in real-time."
# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://www.oberhumer.com/opensource/lzo"

SRC_URI="https://www.oberhumer.com/opensource/lzo/download/lzo-${PV}.tar.gz"
#S="${WORKDIR}/${P}"

SLOT="0"
KEYWORDS="amd64"
IUSE=""

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="sys-libs/glibc"
# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"
# Build-time dependencies that are executed during the emerge process
BDEPEND=""

src_configure() {
	econf --prefix=/usr \
	      --enable-shared \
	      --disable-static \
          --docdir=/usr/share/doc/lzo-${PV}
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

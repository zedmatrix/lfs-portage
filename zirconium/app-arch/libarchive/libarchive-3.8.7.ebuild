EAPI=8
LICENSE=""

DESCRIPTION="Library provides a single interface for reading/writing various compression formats."

HOMEPAGE="https://www.libarchive.org/"

SRC_URI="https://github.com/libarchive/libarchive/releases/download/v${PV}/libarchive-${PV}.tar.xz"
#S="${WORKDIR}/${P}"

SLOT="0"
KEYWORDS="amd64"
IUSE="lzo nettle"
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="
	app-arch/bzip2
	app-arch/zlib
	sys-apps/acl
	dev-libs/expat
	dev-libs/openssl
	app-arch/lz4
	app-arch/xz
	app-arch/zstd
	lzo? ( app-arch/lzo )
	nettle? ( dev-libs/nettle )
"
# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"

# Build-time dependencies that are executed during the emerge process
BDEPEND=""

src_configure() {
	econf --prefix=/usr --disable-static --without-xml2
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install

	dosym bsdcpio /usr/bin/cpio
	dosym bsdunzip /usr/bin/unzip

	dosym bsdcpio.1 /usr/share/man/man1/cpio.1
	dosym bsdunzip.1 /usr/share/man/man1/unzip.1
}

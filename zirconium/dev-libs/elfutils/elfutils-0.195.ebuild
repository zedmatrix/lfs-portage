EAPI=8

DESCRIPTION="Libelf is a library for handling ELF (Executable and Linkable Format) files."

HOMEPAGE="https://sourceware.org/elfutils/"

SRC_URI="https://sourceware.org/ftp/elfutils/${PV}/elfutils-${PV}.tar.bz2"

#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""

# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"

# Build-time dependencies that are executed during the emerge process, and
BDEPEND=""

src_configure() {
	econf --prefix=/usr \
	      --disable-debuginfod \
	      --enable-libdebuginfod=dummy
}

src_compile() {
	emake -C lib
	emake -C libelf
}

src_install() {
	emake DESTDIR="${D}" -C libelf install
	insinto /usr/lib/pkgconfig
	doins config/libelf.pc
}

EAPI=8

DESCRIPTION="The Binutils package contains a linker, an assembler, and other tools for handling object files."

HOMEPAGE="https://www.gnu.org/software/binutils/"

SRC_URI="https://sourceware.org/pub/binutils/releases/binutils-${PV}.tar.xz"
#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""
#RESTRICT="strip"
RDEPEND=""
DEPEND="${RDEPEND}"

BDEPEND="
    sys-devel/gettext
    dev-lang/dejagnu
    sys-devel/bc
"

src_configure() {
    mkdir -p "${WORKDIR}/build"
    cd "${WORKDIR}/build" || die
	${S}/configure --prefix=/usr \
	      --sysconfdir=/etc \
	      --enable-ld=default \
          --enable-plugins \
          --enable-shared \
          --disable-werror \
          --enable-64-bit-bfd \
          --enable-new-dtags \
          --with-system-zlib \
          --with-pkgversion="Zirconium ${PV}" \
          --enable-default-hash-style=gnu
}

src_compile() {
    cd "${WORKDIR}/build" || die
	emake tooldir=/usr
}

src_install() {
    cd "${WORKDIR}/build" || die
    emake DESTDIR="${D}" tooldir=/usr install
}

pkg_postinst() {
    ldconfig
}

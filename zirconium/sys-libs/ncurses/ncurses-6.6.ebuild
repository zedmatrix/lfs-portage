EAPI=8

DESCRIPTION="The Ncurses package contains libraries for terminal-independent handling of character screens."

HOMEPAGE="https://www.gnu.org/software/ncurses/"

SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/ncurses/ncurses-${PV}.tar.gz"
#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
    sys-libs/glibc
"
BDEPEND=""

src_configure() {
	${S}/configure --prefix=/usr \
	               --with-shared \
	               --with-cxx-shared \
	               --without-debug \
	               --without-normal \
	               --enable-pc-files \
	               --mandir=/usr/share/man \
                   --with-pkg-config-libdir=/usr/lib/pkgconfig || die
}

src_compile() {
	emake
}

src_install() {
    emake DESTDIR="${D}" install

    for lib in ncurses form panel menu; do
        dosym lib${lib}w.so /usr/lib/lib${lib}.so
        dosym ${lib}w.pc /usr/lib/pkgconfig/${lib}.pc
    done
    dosym libncursesw.so /usr/lib/libcurses.so

    docinto /usr/share/doc/ncurses-${PV}
    dodoc -r doc/
}

pkg_postinst() {
    ldconfig
}


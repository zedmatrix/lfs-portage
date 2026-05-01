EAPI=8

DESCRIPTION="The Readline package is a set of libraries that offer command-line editing and history capabilities."

HOMEPAGE="https://tiswww.case.edu/php/chet/readline/rltop.html"

SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/readline/readline-${PV}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""
#RESTRICT="strip"

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}
    >=sys-libs/glibc-2.42
    >=sys-apps/file-5.46
"
BDEPEND=""

src_prepare() {
    default
    sed -i '/MV.*old/d' Makefile.in
    sed -i '/{OLDSUFF}/c:' support/shlib-install
    sed -i 's/-Wl,-rpath,[^ ]*//' support/shobj-conf

}

src_configure() {
    export LDFLAGS="${LDFLAGS} -Wl,--no-as-needed -lncursesw"
    econf --prefix=/usr \
          --enable-static \
          --enable-shared \
          --with-curses \
          --docdir=/usr/share/doc/readline-${PV}
}

src_compile() {
    emake SHLIB_LIBS="-lncursesw"
}

src_install() {
    emake DESTDIR="${D}" install
    docinto /usr/share/doc/readline-${PV}
    dodoc doc/*.{ps,pdf,html,dvi}
}

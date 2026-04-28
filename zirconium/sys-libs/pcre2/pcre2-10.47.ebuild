EAPI=8

DESCRIPTION="The pcre2 package contains a new generation of the Perl Compatible Regular Expression libraries."

HOMEPAGE="https://github.com/PCRE2Project/pcre2/"

SRC_URI="https://github.com/PCRE2Project/pcre2/releases/download/pcre2-${PV}/pcre2-${PV}.tar.bz2"
#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""
#RESTRICT="strip"
RDEPEND=""
DEPEND="${RDEPEND}
    >=sys-libs/readline-8.3
    >=app-arch/zlib-1.3.1
    >=app-arch/bzip2-1.0.8
    >=app-arch/zstd-1.5.7
    sys-libs/glibc
"
BDEPEND=""

src_configure() {
    econf --prefix=/usr \
          --disable-static \
          --enable-jit \
          --enable-unicode \
          --enable-pcre2-16 \
          --enable-pcre2-32 \
          --enable-pcre2grep-libz \
          --enable-pcre2grep-libbz2 \
          --enable-pcre2test-libreadline \
          --docdir=/usr/share/doc/pcre2-${PV} || die
}

src_compile() {
    emake
}

src_install() {
    emake DESTDIR="${D}" install
}

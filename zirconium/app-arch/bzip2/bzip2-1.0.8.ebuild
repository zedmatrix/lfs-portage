EAPI=8

DESCRIPTION="High-quality data compressor used by portage"
HOMEPAGE="https://sourceware.org/bzip2/"
SRC_URI="https://www.sourceware.org/pub/bzip2/bzip2-${PV}.tar.gz"

SLOT="0"
KEYWORDS="amd64"

PATCHES=(
    "${FILESDIR}/${P}-install_docs-1.patch"
)
RDEPEND="sys-libs/glibc"

src_prepare() {
    default

    sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile || die
    sed -i 's@(PREFIX)/man@(PREFIX)/share/man@g' Makefile || die
}

src_compile() {
    emake -f Makefile-libbz2_so
    emake clean
    emake
}

src_install() {
	emake PREFIX="${D}/usr" install
	install -Dm755 bzip2-shared "${D}/usr/bin/bzip2"
	cp -av libbz2.so* "${D}/usr/lib/"
}

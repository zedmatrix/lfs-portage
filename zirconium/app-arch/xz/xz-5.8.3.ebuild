EAPI=8
DESCRIPTION="The Xz package contains programs for compressing and decompressing files."
HOMEPAGE="https://tukaani.org/xz"

SRC_URI="https://github.com//tukaani-project/xz/releases/download/v${PV}/xz-${PV}.tar.xz"
#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="test"

#RESTRICT="strip"
RDEPEND="sys-libs/glibc"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/gettext
"

src_configure() {
	econf --prefix=/usr \
	      --enable-shared \
	      --enable-static \
          --docdir=/usr/share/doc/xz-${PV}
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install

}

pkg_postinst() {
    ldconfig
}

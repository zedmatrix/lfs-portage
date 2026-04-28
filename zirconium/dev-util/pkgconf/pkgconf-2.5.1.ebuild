EAPI=8

DESCRIPTION="A program which helps to configure compiler and linker flags for development libraries."

HOMEPAGE="https://github.com/pkgconf/pkgconf"

SRC_URI="https://distfiles.ariadne.space/pkgconf/pkgconf-${PV}.tar.xz"
#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""
#RESTRICT="strip"

RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND=""

src_configure() {
	econf --docdir=/usr/share/doc/pkgconf-${PV}
}

src_compile() {
	emake
}

src_install() {
    emake DESTDIR="${D}" install
    dosym pkgconf   /usr/bin/pkg-config
    dosym pkgconf.1 /usr/share/man/man1/pkg-config.1
}

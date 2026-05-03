EAPI=8

DESCRIPTION="The Expat package contains a stream oriented C library for parsing XML."

HOMEPAGE="https://libexpat.github.io/"

SRC_URI="https://github.com/libexpat/libexpat/releases/download/R_${PV//\./_}/expat-${PV}.tar.xz"

#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="-test"

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="sys-libs/glibc"

# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"

# Build-time dependencies that are executed during the emerge process, and
BDEPEND=""

src_configure() {
	econf --prefix=/usr \
	      --disable-static \
          --docdir=/usr/share/doc/expat-${PV}
}

src_compile() {
	emake
}

src_test() {
	emake check
}

src_install() {
	emake DESTDIR="${D}" install
	docinto /usr/share/doc/expat-${PV}
	dodoc doc/*.{html,css}
}

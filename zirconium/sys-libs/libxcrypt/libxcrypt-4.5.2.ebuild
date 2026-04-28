EAPI=8
DESCRIPTION="The Libxcrypt package contains a modern library for one-way hashing of passwords."

HOMEPAGE="https://github.com/besser82/libxcrypt/"

SRC_URI="https://github.com/besser82/libxcrypt/releases/download/v${PV}/libxcrypt-${PV}.tar.xz"
#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="-test"

#RESTRICT="strip"

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="!<sys-apps/man-pages-6.16"

DEPEND="${RDEPEND}"

BDEPEND="dev-lang/perl"

src_prepare() {
	default
	sed -i '/strchr/s/const//' lib/crypt-{sm3,gost}-yescrypt.c
}

src_configure() {
	econf --prefix=/usr \
	      --disable-static \
	      --enable-hashes=strong,glibc \
          --enable-obsolete-api=no \
          --disable-failure-tokens
}

src_compile() {
	emake
}

src_test() {
	emake check
}

src_install() {
	emake DESTDIR="${D}" install
}

pkg_postinst() {
    ldconfig
}

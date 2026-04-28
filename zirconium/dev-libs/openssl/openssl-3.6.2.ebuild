EAPI=8

DESCRIPTION="The OpenSSL package contains management tools and libraries relating to cryptography."

HOMEPAGE="https://www.openssl-library.org/"

SRC_URI="https://github.com/openssl/openssl/releases/download/openssl-${PV}/openssl-${PV}.tar.gz"

#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""

# Build-time dependencies that need to be binary compatible with the system
DEPEND="dev-lang/perl"

# Build-time dependencies that are executed during the emerge process, and
BDEPEND=""

src_configure() {
	perl ${S}/Configure --prefix=/usr \
		   --libdir=lib \
	       shared \
	       zlib-dynamic \
	       --openssldir=/etc/ssl || die "config failed"
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" MANSUFFIX=ssl install
	# rename doc dir to versioned
    mv "${D}"/usr/share/doc/openssl "${D}"/usr/share/doc/openssl-${PV}

    # install additional docs from source
    docinto /usr/share/doc/openssl-${PV}
    dodoc -r doc/*
}

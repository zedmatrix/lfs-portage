EAPI=8

DESCRIPTION="Class::Inspector allows you to get information about a loaded class."

HOMEPAGE="https://metacpan.org/pod/Class::Inspector"

SRC_URI="https://cpan.metacpan.org/authors/id/P/PL/PLICEASE/Class-Inspector-${PV}.tar.gz"
#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""

BDEPEND=""

DEPEND="dev-lang/perl"

src_configure() {
	einfo "perl Makefile.PL" "$@"
	perl Makefile.PL || die
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

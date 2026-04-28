EAPI=8

DESCRIPTION="The XML::Parser module is a Perl interface to James Clarks XML parser, Expat."

HOMEPAGE="https://metacpan.org/pod/XML::Parser"

SRC_URI="https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-2.58.tar.gz"

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
BDEPEND="dev-perl/File-ShareDir"

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


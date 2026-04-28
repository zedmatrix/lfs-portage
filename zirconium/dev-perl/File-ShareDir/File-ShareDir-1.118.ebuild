EAPI=8

DESCRIPTION="allows you to access data files which have been installed by File::ShareDir::Install"

HOMEPAGE="https://metacpan.org/pod/File::ShareDir"

SRC_URI="https://cpan.metacpan.org/authors/id/R/RE/REHSACK/File-ShareDir-${PV}.tar.gz"

#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""

# Build-time dependencies that need to be binary compatible with the system
DEPEND="
	dev-lang/perl
"

# Build-time dependencies that are executed during the emerge process, and
BDEPEND="
	dev-perl/Class-Inspector
	dev-perl/File-ShareDir-Install
"

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

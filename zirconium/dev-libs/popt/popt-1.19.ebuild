EAPI=8
LICENSE=""
# Short one-line description of this package.
DESCRIPTION="The popt package contains the popt libraries which are used by some programs to parse command-line options."
# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://github.com/rpm-software-management/popt"

SRC_URI="https://ftp.osuosl.org/pub/rpm/popt/releases/popt-1.x/popt-${PV}.tar.gz"
#S="${WORKDIR}/${P}"

SLOT="0"
KEYWORDS="amd64"
IUSE=""
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""
# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"

# Build-time dependencies that are executed during the emerge process
BDEPEND=">=sys-devel/gettext-0.19.8"

src_configure() {
	${S}/configure --prefix=/usr --disable-static || die "configure failure"
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

EAPI=8
LICENSE=""

# Short one-line description of this package.
DESCRIPTION="The Libpipeline package contains a library for manipulating pipelines of subprocesses in a flexible and convenient way."
# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://libpipeline.nongnu.org/"

SRC_URI="https://download.savannah.gnu.org/releases/libpipeline/libpipeline-1.5.8.tar.gz"
#S="${WORKDIR}/${P}"

SLOT="0"

KEYWORDS="amd64"

IUSE=""

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""

# Build-time dependencies that need to be binary compatible with the system
DEPEND=""

# Build-time dependencies that are executed during the emerge process
BDEPEND=""

src_configure() {
	econf --prefix=/usr
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
	find "${ED}" -type f -name "*.la" -delete || die
}

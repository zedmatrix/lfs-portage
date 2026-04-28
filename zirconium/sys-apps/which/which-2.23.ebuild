EAPI=8
LICENSE=""

# Short one-line description of this package.
DESCRIPTION="Prints out location of specified executables that are in your path"
# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://carlowood.github.io/which/"

# Point to any required sources; these will be automatically downloaded by
# Portage.
SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/which/which-${PV}.tar.gz"
#S="${WORKDIR}/${P}"

SLOT="0"
KEYWORDS="amd64"
IUSE=""
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""
# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"
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
}

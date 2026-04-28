EAPI=8
DESCRIPTION="The Grep package contains programs for searching through the contents of files."
HOMEPAGE="https://www.gnu.org/software/grep/"

SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/grep/grep-${PV}.tar.xz"

#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="-test"

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""

# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"

# Build-time dependencies that are executed during the emerge process, and
# only need to be present in the native build system (CBUILD). Example:
BDEPEND=""

src_configure() {
	default
	sed -i "s/echo/#echo/" src/egrep.sh

	econf
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

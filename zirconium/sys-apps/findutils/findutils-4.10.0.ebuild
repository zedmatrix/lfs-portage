EAPI=8
LICENSE=""

# Short one-line description of this package.
DESCRIPTION="Programs are provided to search through all the files in a directory tree and to create, maintain, and search a database."

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://www.gnu.org/software/findutils/"

# Point to any required sources; these will be automatically downloaded by
# Portage.
SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/findutils/findutils-${PV}.tar.xz"

#S="${WORKDIR}/${P}"

SLOT="0"

KEYWORDS="amd64"

IUSE="-test"

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""

# Build-time dependencies that need to be binary compatible with the system
DEPEND=""

# Build-time dependencies that are executed during the emerge process
BDEPEND=""

src_configure() {
    econf --prefix=/usr --localstatedir=/var/lib/locate
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

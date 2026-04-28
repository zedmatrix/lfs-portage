EAPI=8
LICENSE=""

# Short one-line description of this package.
DESCRIPTION="A program for controlling the generation of executables and other non-source files of a package from source files. "

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://www.gnu.org/software/make/"

SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/make/make-${PV}.tar.gz"
#S="${WORKDIR}/${P}"

SLOT="0"

KEYWORDS="amd64"

IUSE="+nls"
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""
# Build-time dependencies that need to be binary compatible with the system
DEPEND=""
# Build-time dependencies that are executed during the emerge process
BDEPEND="nls? ( sys-devel/gettext )"

src_configure() {
	econf --prefix=/usr
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

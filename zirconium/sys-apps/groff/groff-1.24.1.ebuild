EAPI=8
LICENSE=""

# Short one-line description of this package.
DESCRIPTION="The Groff package contains programs for processing and formatting text and images."

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://www.gnu.org/software/groff/"

# Point to any required sources; these will be automatically downloaded by
# Portage.
SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/groff/groff-${PV}.tar.gz"
#S="${WORKDIR}/${P}"

SLOT="0"

KEYWORDS="amd64"

IUSE="-test"

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""

# Build-time dependencies that need to be binary compatible with the system
DEPEND=""

# Build-time dependencies that are executed during the emerge process
BDEPEND="
		dev-lang/perl
		sys-apps/texinfo
		sys-devel/m4
"

src_configure() {
		export PAGE=A4
	econf --prefix=/usr
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

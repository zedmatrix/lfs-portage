EAPI=8
LICENSE=""

# Short one-line description of this package.
DESCRIPTION="The Texinfo package contains programs for reading, writing, and converting info pages."

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://www.gnu.org/software/texinfo/"

# Point to any required sources; these will be automatically downloaded by
# Portage.
SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/texinfo/texinfo-${PV}.tar.xz"

#S="${WORKDIR}/${P}"

SLOT="0"

KEYWORDS="amd64"

IUSE="-test"

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="
	>=sys-libs/ncurses-5.2
	>=dev-lang/perl-5.8.1
"

# Build-time dependencies that need to be binary compatible with the system
DEPEND=""

# Build-time dependencies that are executed during the emerge process
BDEPEND="
	>=sys-devel/gettext-0.19.6
"

src_configure() {
	sed 's/! $output_file eq/$output_file ne/' -i tp/Texinfo/Convert/*.pm
	econf --prefix=/usr
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
	emake DESTDIR="${D}" TEXMF=/usr/share/texmf install-tex
}

EAPI=8
LICENSE=""

# Short one-line description of this package.
DESCRIPTION="The ability to create archives as well as perform various other kinds of archive manipulation."

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://www.gnu.org/software/tar/"

SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/tar/tar-1.35.tar.xz"
#S="${WORKDIR}/${P}"

SLOT="0"

KEYWORDS="amd64"

IUSE=""

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="sys-apps/acl"

# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}
	sys-apps/attr
"

# Build-time dependencies that are executed during the emerge process
BDEPEND="sys-devel/gettext"

src_configure() {
	FORCE_UNSAFE_CONFIGURE=1 econf --prefix=/usr --enable-nls
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
	dosym tar /usr/bin/gtar
}

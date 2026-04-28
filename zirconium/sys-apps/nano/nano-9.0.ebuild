EAPI=8
LICENSE=""

# Short one-line description of this package.
DESCRIPTION="A small, simple text editor which aims to replace Pico, the default editor in the Pine package."

HOMEPAGE="https://www.nano-editor.org/"

SRC_URI="https://www.nano-editor.org/dist/v9/nano-9.0.tar.xz"
#S="${WORKDIR}/${P}"

SLOT="0"

KEYWORDS="amd64"

IUSE="-test"

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="
	sys-apps/file
	>=sys-libs/ncurses-5.9
"

# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"

# Build-time dependencies that are executed during the emerge process
BDEPEND="sys-devel/gettext"

src_configure() {
	econf --prefix=/usr \
		  --sysconfdir=/etc \
          --enable-utf8 \
          --docdir=/usr/share/doc/nano-${PV}
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
	docinto /usr/share/doc/nano-${PV}
	dodoc doc/nano.html doc/sample.nanorc
	insinto /etc
	doins "${FILESDIR}/nanorc"
}

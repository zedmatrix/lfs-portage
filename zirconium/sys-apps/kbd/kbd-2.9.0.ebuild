EAPI=8
LICENSE=""

# Short one-line description of this package.
DESCRIPTION="The Kbd package contains key-table files, console fonts, and keyboard utilities."

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://kbd-project.org/"

# Point to any required sources; these will be automatically downloaded by
# Portage.
SRC_URI="https://www.kernel.org/pub/linux/utils/kbd/kbd-${PV}.tar.xz"

patches=(
	"${FILESDIR}/kbd-${PV}-backspace-1.patch"
)
#S="${WORKDIR}/${P}"

SLOT="0"

KEYWORDS="amd64"

IUSE="-test"

# Build-time dependencies that need to be binary compatible with the system
DEPEND="
	app-arch/bzip2
	app-arch/xz
	app-arch/gzip
	app-arch/zlib
	app-arch/zstd
"

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="${DEPEND}"

# Build-time dependencies that are executed during the emerge process
BDEPEND="sys-devel/flex"

src_configure() {
	sed -i '/RESIZECONS_PROGS=/s/yes/no/' configure
	sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in
	econf --prefix=/usr \
		  --disable-tests \
	      --disable-vlock \
	      --disable-memcheck \
	      --disable-werror
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
	docinto /usr/share/doc/kbd-${PV}
	dodoc -r docs/doc
}

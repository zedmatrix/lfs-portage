EAPI=8
LICENSE=""

# Short one-line description of this package.
DESCRIPTION="efivar package provides tools and libraries to manipulate EFI variables."

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://github.com/rhboot/efivar"

# Point to any required sources; these will be automatically downloaded by
# Portage.
SRC_URI="https://github.com/rhboot/efivar/archive/${PV}/efivar-${PV}.tar.gz"

PATCHES=(
	"${FILESDIR}/efivar-${PV}-upstream_fixes-1.patch"
)
#S="${WORKDIR}/${P}"
SLOT="0"
KEYWORDS="amd64"
IUSE="efi"

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="dev-libs/popt"

# Build-time dependencies that need to be binary compatible with the system
DEPEND=""

# Build-time dependencies that are executed during the emerge process
BDEPEND=""

src_configure() {
	export ERRORS=
	export PREFIX="${EPREFIX}/usr"
	export LIBDIR="${EPREFIX}/usr/lib"
}

src_compile() {
	emake ENABLE_DOCS=0
}

src_install() {
	emake DESTDIR="${D}" ENABLE_DOCS=0 LIBDIR=/usr/lib install
	doman docs/efivar.1
	doman docs/*.3
}

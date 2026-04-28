EAPI=8
LICENSE=""

# Short one-line description of this package.
DESCRIPTION="efibootmgr package provides tools and libraries to manipulate EFI variables."

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://github.com/rhinstaller/efibootmgr"

SRC_URI="https://github.com/rhboot/efibootmgr/archive/${PV}/efibootmgr-${PV}.tar.gz"

#S="${WORKDIR}/${P}"
SLOT="0"
KEYWORDS="amd64"
IUSE="-test efi"

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="
	dev-libs/popt
	sys-apps/pciutils
	>=sys-boot/efivar-37
"

# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"

# Build-time dependencies that are executed during the emerge process
BDEPEND=""

src_configure() {
	sed -i 's/-Werror //' Make.defaults || die
	export EFIDIR=ZLFS
	export EFI_LOADER=grubx64.efi
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

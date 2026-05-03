EAPI=8
LICENSE=""
# Short one-line description of this package.
DESCRIPTION="Contains a set of programs for listing PCI devices, inspecting their status and setting their configuration registers."
# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://mj.ucw.cz/sw/pciutils/  https://git.kernel.org/?p=utils/pciutils/pciutils.git"

# Point to any required sources; these will be automatically downloaded by
# Portage.
SRC_URI="https://mj.ucw.cz/download/linux/pci/pciutils-${PV}.tar.gz"
#S="${WORKDIR}/${P}"

SLOT="0"
KEYWORDS="amd64"
IUSE=""
# Build-time dependencies that need to be binary compatible with the system
DEPEND="
	sys-apps/kmod
	app-arch/zlib
"
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="
	${DEPEND}
	sys-apps/hwdata
"

# Build-time dependencies that are executed during the emerge process
BDEPEND="
	>=sys-devel/binutils-2.37
"

src_configure() { :; }

src_compile() {
	sed -r '/INSTALL/{/PCI_IDS|update-pciids /d; s/update-pciids.8//}' -i Makefile

	emake PREFIX=/usr SHAREDIR=/usr/share/hwdata SHARED=yes
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr SHAREDIR=/usr/share/hwdata SHARED=yes install install-lib
	fperms 755 /usr/lib/libpci.so
}

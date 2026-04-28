EAPI=8
LICENSE=""
# Short one-line description of this package.
DESCRIPTION="The package management and distribution system for Zirconium"
# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Portage"

SRC_URI="https://github.com/gentoo/portage/archive/refs/tags/portage-${PV}.tar.gz"
S="${WORKDIR}/portage-${P}"

SLOT="0"
KEYWORDS="amd64"
IUSE=""
EPYTHON="python3.14"
# Build-time dependencies that are executed during the emerge process
BDEPEND="
	>=app-arch/tar-1.27
	>=dev-build/meson-1.3.0
	>=sys-apps/sed-4.0.5
	sys-devel/patch
"
RDEPEND="
	>=app-arch/tar-1.27
	app-arch/zstd
	>=sys-util/pax-utils-0.1.17
	dev-lang/python
	>=sys-apps/findutils-4.9
	>=app-shells/bash-5.3
	>=sys-apps/sed-4.0.5
	sys-apps/util-linux
"
# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"

src_configure() {
	local emesonargs=(
		--prefix=/usr
		--sysconfdir=/etc
		--localstatedir=/var
		-Dcode-only=true
		-Dportage-bindir="/usr/lib/portage/${EPYTHON}"
		-Ddocdir="/usr/share/doc/${P}"
     )
     meson setup build ${emesonargs[@]} || die "meson setup failure"
}

src_compile() {
	ninja -C build
}

src_install() {
	DESTDIR="${D}" ninja -C build install
}

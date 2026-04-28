EAPI=8
LICENSE=""
## inherit .. detect_version .. kernel-2
# Short one-line description of this package.
DESCRIPTION="The Linux package contains the Linux kernel."
# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://www.kernel.org"

MY_P="linux-${PV}"
SRC_URI="https://cdn.kernel.org/pub/linux/kernel/v${PV:0:1}.x/linux-${PV}.tar.xz"
S="${WORKDIR}/${MY_P}"

SLOT="0"
KEYWORDS="amd64"
IUSE=""
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="
	sys-devel/bc
	sys-libs/binutils
	sys-devel/bison
	dev-libs/elfutils
	sys-devel/flex
	dev-build/make
	sys-libs/ncurses
	dev-lang/perl
	dev-util/pkgconf
"
# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"
# Build-time dependencies that are executed during the emerge process
BDEPEND=""

export ARCH=x86
src_prepare() {
    default
    emake mrproper
    zcat /proc/config.gz > "${S}/.config" || die "failed to get config"
}

src_configure() {
    emake olddefconfig
}

src_compile() {
    emake
}

src_install() {
    # install modules
    emake INSTALL_MOD_PATH="${D}" modules_install

    # install kernel, system map and config to /boot
    insinto /boot
    newins arch/x86/boot/bzImage vmlinuz-${PV}
    newins System.map System.map-${PV}
    newins .config config-${PV}

    # install kernel source to /usr/src
    insinto /usr/src/${MY_P}
    doins -r "${S}"/.

    # symlink /usr/src/linux to current kernel
    dosym ${MY_P} /usr/src/linux
}

pkg_postinst() {
    # update grub config
    elog "Update grub with:"
    elog "  grub-mkconfig -o /boot/grub/grub.cfg"
}

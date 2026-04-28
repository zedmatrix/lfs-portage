EAPI=8
LICENSE=""

# Short one-line description of this package.
DESCRIPTION="programs for controlling the startup, running, and shutdown of the system."

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://systemd.io/"

SRC_URI="https://github.com/systemd/systemd/archive/v${PV}/systemd-${PV}.tar.gz"
#S="${WORKDIR}/${P}"

SLOT="0"

KEYWORDS="amd64"

IUSE=""
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""

# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"

# Build-time dependencies that are executed during the emerge process
BDEPEND="
	dev-python/markupsafe
	dev-python/jinja2
	dev-python/pyelftools
"

src_configure() {
	sed -e 's/GROUP="render"/GROUP="video"/' -e 's/GROUP="sgx", //' -i rules.d/50-udev-default.rules.in || die
    meson setup build --prefix=/usr --buildtype=release -D default-dnssec=no -D firstboot=false \
        -D install-tests=false -D ldconfig=false -D sysusers=false -D rpmmacrosdir=no -D homed=disabled \
        -D man=disabled -D mode=release -D pamconfdir=no -D dev-kvm-mode=0660 -D nobody-group=nogroup \
        -D sysupdate=disabled -D ukify=disabled -D docdir=/usr/share/doc/systemd-${PV} \
        -D efi=true -D bootloader=enabled -D sbat-distro="zlfs" -D sbat-distro-summary="Zirconium" \
        -D sbat-distro-url="https://zedmatrix.github.io/ZirconiumOS/" || die "meson failed"
}

src_compile() {
	ninja -C build || die "ninja compile failed"
}

src_install() {
	DESTDIR="${D}" ninja -C build install || die "ninja install failure"
}

pkg_postinst() {
	elog "Setting up systemd for first time boot"
	systemd-machine-id-setup

	systemctl preset-all

}

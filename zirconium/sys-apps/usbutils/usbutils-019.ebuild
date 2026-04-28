EAPI=8
LICENSE=""
# Short one-line description of this package.
DESCRIPTION="utilities used to display information about USB buses in the system and the devices connected to them."

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://www.kernel.org/pub/linux/utils/usb/usbutils/"

SRC_URI="https://kernel.org/pub/linux/utils/usb/usbutils/usbutils-019.tar.xz"
#S="${WORKDIR}/${P}"

SLOT="0"
KEYWORDS="amd64"
IUSE=""
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="
	sys-apps/hwdata
	dev-libs/libusb
"
# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"
# Build-time dependencies that are executed during the emerge process
BDEPEND=""

src_configure() {
	meson setup build --prefix=/usr --buildtype=release || die "meson failure"
}

src_compile() {
	ninja -C build || die "ninja compile failure"
}

src_install() {
	DESTDIR="${D}" ninja -C build install || die "ninja install failure"
}

EAPI=8
LICENSE=""
# Short one-line description of this package.
DESCRIPTION="The libusb package contains a library used by some applications for USB device access."
# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://libusb.info/ https://github.com/libusb/libusb"

SRC_URI="https://github.com/libusb/libusb/releases/download/v${PV}/libusb-${PV}.tar.bz2"
#S="${WORKDIR}/${P}"

SLOT="0"
KEYWORDS="amd64"
IUSE=""
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="sys-apps/systemd"
# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"
# Build-time dependencies that are executed during the emerge process
BDEPEND=""

src_configure() {
	${S}/configure --prefix=/usr --disable-static || die
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

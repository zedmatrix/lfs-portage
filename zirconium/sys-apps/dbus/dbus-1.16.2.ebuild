EAPI=8
LICENSE=""

DESCRIPTION="A message bus system, a simple way for applications to talk to one another."

HOMEPAGE="https://www.freedesktop.org/wiki/Software/dbus"

SRC_URI="https://dbus.freedesktop.org/releases/dbus/dbus-${PV}.tar.xz"
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
	meson setup build --prefix=/usr --buildtype=release --wrap-mode=nofallback || die "meson failure"
}

src_compile() {
	ninja -C build || die "ninja compile failure"
}

src_install() {
	DESTDIR="${D}" ninja -C build install || die "ninja install failure"
	dosym /etc/machine-id /var/lib/dbus/machine-id
}

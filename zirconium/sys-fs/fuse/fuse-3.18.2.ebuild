EAPI=8
LICENSE=""

DESCRIPTION="FUSE (Filesystem in Userspace) is a simple interface for userspace programs to export a virtual filesystem to the Linux kernel."

HOMEPAGE="https://github.com/libfuse/libfuse"

SRC_URI="https://github.com/libfuse/libfuse/releases/download/fuse-${PV}/fuse-${PV}.tar.gz"
#S="${WORKDIR}/${P}"

SLOT="0"
KEYWORDS="amd64"
IUSE=""
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""
# Build-time dependencies that need to be binary compatible with the system
DEPEND=""
# Build-time dependencies that are executed during the emerge process
BDEPEND=""

src_configure() {
	sed -i '/^udev/,$ s/^/#/' util/meson.build
	meson setup build --prefix=/usr --buildtype=release || die "meson configure failure"
}

src_compile() {
	ninja -C build || die "ninja build failure"
}

src_install() {
	DESTDIR="${D}" ninja -C build install || die "ninja install failure"
	insopts u+s /usr/bin/fusermount3
}

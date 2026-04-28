EAPI=8
LICENSE=""
# Short one-line description of this package.
DESCRIPTION="User-land utilities for LVM2 (device-mapper) software"
# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://sourceware.org/lvm2/"

SRC_URI="https://sourceware.org/ftp/lvm2/${PN^^}.${PV}.tgz"
S="${WORKDIR}/${PN^^}.${PV}"

SLOT="0"
KEYWORDS="amd64"
IUSE=""
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""
# Build-time dependencies that need to be binary compatible with the system
DEPEND="
	dev-libs/libaio
	>=sys-apps/util-linux-2.24
	sys-libs/readline
	>=sys-apps/systemd-234
"
# Build-time dependencies that are executed during the emerge process
BDEPEND=""

src_configure() {
	export PKG_CONFIG_PATH=/usr/lib64/pkgconfig
	econf --prefix=/usr \
	      --enable-cmdlib \
	      --enable-pkgconfig \
	      --enable-udev_sync \
	      --with-thin-check= \
		  --with-thin-dump=  \
		  --with-thin-repair= \
		  --with-thin-restore= \
		  --with-cache-check= \
		  --with-cache-dump= \
		  --with-cache-repair= \
		  --with-cache-restore=
}

src_compile() {
	emake V=1
}

src_install() {
	emake DESTDIR="${D}" install
	rm ${D}/usr/lib/udev/rules.d/69-dm-lvm.rules

}

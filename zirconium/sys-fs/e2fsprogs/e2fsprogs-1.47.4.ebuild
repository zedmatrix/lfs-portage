EAPI=8
LICENSE=""

DESCRIPTION="Package contains the utilities for handling the ext2, ext3 and ext4 journaling file systems."

HOMEPAGE="http://e2fsprogs.sourceforge.net/"

# Point to any required sources; these will be automatically downloaded by
# Portage.
SRC_URI="https://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v${PV}/e2fsprogs-${PV}.tar.gz"
#S="${WORKDIR}/${P}"

SLOT="0"
KEYWORDS="amd64"
IUSE=""

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="
	sys-libs/glibc
	app-arch/libarchive
	sys-fs/fuse
	sys-fs/lvm2
"

# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}
	sys-apps/util-linux
	sys-apps/texinfo
"

# Build-time dependencies that are executed during the emerge process
BDEPEND="
	dev-build/make
	dev-build/autoconf
	dev-build/automake
"

src_configure() {
	export PKG_CONFIG_PATH=/usr/lib64/pkgconfig
	mkdir -p ${WORKDIR}/build
	cd ${WORKDIR}/build || die "Cant cd to build dir"
	${S}/configure --prefix=/usr \
	      --sysconfdir=/etc \
	      --with-pthread \
	      --enable-largefile \
	      --enable-fuse2fs \
	      --enable-elf-shlibs \
          --disable-libblkid \
          --disable-libuuid \
          --disable-uuidd \
          --disable-fsck \
          --disable-lto
}

src_compile() {
	cd ${WORKDIR}/build || die "Cant cd to build dir"
	emake
}

src_install() {
	cd ${WORKDIR}/build || die "Cant cd to build dir"
	emake STRIP=':' V=1 DESTDIR="${D}" install

	makeinfo -o "${WORKDIR}/build/doc/com_err.info" "${S}/lib/et/com_err.texinfo" || die
    doinfo "${WORKDIR}/build/doc/com_err.info"
}

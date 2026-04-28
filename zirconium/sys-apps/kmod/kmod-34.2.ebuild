EAPI=8
LICENSE=""

# Short one-line description of this package.
DESCRIPTION="Contains libraries and utilities for loading kernel modules"

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://github.com/kmod-project/kmod"

SRC_URI="https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-${PV}.tar.xz"

#S="${WORKDIR}/${P}"
SLOT="0"
KEYWORDS="amd64"
IUSE="-test"

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="
	>=app-arch/xz-5.0.4
	>=dev-libs/openssl-1.1.0
	>=app-arch/zlib-1.2.6
	>=app-arch/zstd-1.5.2
"

# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"

# Build-time dependencies that are executed during the emerge process
BDEPEND="
	>=dev-build/meson-1.7.0
	dev-build/ninja
"

src_configure() {
   	meson setup build \
   	      --prefix=/usr \
   	      --buildtype=release \
   	      -Dmanpages=false || die
}

src_compile() {
	ninja -C build || die
}

src_install() {
	DESTDIR="${D}" ninja -C build install
}

EAPI=8
LICENSE=""
# Short one-line description of this package.
DESCRIPTION="provides a library for accessing and resolving information from the Public Suffix List (PSL)."
# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://github.com/rockdaboot/libpsl"

SRC_URI="https://github.com/rockdaboot/libpsl/releases/download/${PV}/libpsl-${PV}.tar.gz"
#S="${WORKDIR}/${P}"

SLOT="0"
KEYWORDS="amd64"
IUSE=""
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="
	dev-libs/libunistring
	net-misc/libidn2
"
# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"
# Build-time dependencies that are executed during the emerge process
BDEPEND="
	sys-devel/gettext
"

src_configure() {
	meson setup build --prefix=/usr \
	                  --buildtype=release \
	                  -Druntime=libidn2 \
	                  -Dbuiltin=true || die "meson configure failure"
}

src_compile() {
	ninja -C build || die "ninja build failure"
}

src_install() {
	DESTDIR="${D}" ninja -C build install || die "ninja install failure"
}

EAPI=8
LICENSE=""
# Short one-line description of this package.
DESCRIPTION="Package contains libraries and utilities used for parsing XML files."
# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://gitlab.gnome.org/GNOME/libxml2/-/wikis/home"

SRC_URI="https://download.gnome.org/sources/libxml2/2.15/libxml2-${PV}.tar.xz"
#S="${WORKDIR}/${P}"
SLOT="0"
KEYWORDS="amd64"
IUSE=""
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="
	app-arch/zlib
	dev-libs/icu
	sys-libs/readline
"
# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"
# Build-time dependencies that are executed during the emerge process
BDEPEND=""

src_configure() {
	sed -i "/'git'/,+3d" meson.build || die "no git patch"
	meson setup build --prefix=/usr \
	                  --buildtype=release \
	                  -Dhistory=enabled \
	                  -Dicu=enabled || die "meson failure"
}

src_compile() {
	ninja -C build || die "ninja build failure"
}

src_install() {
	DESTDIR="${D}" ninja -C build install || die "ninja install failure"
}

pkg_postinst() {
	einfo "patching xml2-config"
	sed "s/--static/--shared/" -i /usr/bin/xml2-config
}

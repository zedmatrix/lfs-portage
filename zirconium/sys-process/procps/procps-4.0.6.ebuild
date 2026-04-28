EAPI=8
LICENSE=""

DESCRIPTION="The Procps-ng package contains programs for monitoring processes."

HOMEPAGE="https://gitlab.com/procps-ng/procps/"

SRC_URI="https://sourceforge.net/projects/${PN}-ng/files/Production/${PN}-ng-${PV}.tar.xz"
S="${WORKDIR}/${PN}-ng-${PV}"

SLOT="0"

KEYWORDS="amd64"

IUSE=""

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""

# Build-time dependencies that need to be binary compatible with the system
DEPEND="
	>=sys-libs/ncurses-5.7
	sys-apps/systemd
"

# Build-time dependencies that are executed during the emerge process
BDEPEND=""

src_configure() {
	export PKG_CONFIG_PATH=/usr/lib64/pkgconfig
	econf --prefix=/usr \
		  --disable-static \
		  --disable-kill \
		  --enable-watch8bit \
	      --docdir=/usr/share/doc/procps-ng-${PV} \
          --with-systemd
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

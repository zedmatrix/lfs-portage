EAPI=8
LICENSE=""

# Short one-line description of this package.
DESCRIPTION="Package contains utilities for handling file systems, consoles, partitions, and messages."

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://www.kernel.org/pub/linux/utils/util-linux/"

SRC_URI="https://www.kernel.org/pub/linux/utils/util-linux/v${PV:0:4}/util-linux-${PV}.tar.xz"
#S="${WORKDIR}/${P}"

SLOT="0"

KEYWORDS="amd64"

IUSE=""
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="
	sys-libs/libcap
	sys-libs/ncurses
	sys-libs/pcre2
	sys-libs/readline
	sys-apps/systemd
"
# Build-time dependencies that need to be binary compatible with the system
DEPEND=""
# Build-time dependencies that are executed during the emerge process
BDEPEND="sys-devel/gettext"

src_configure() {
    export PKG_CONFIG_PATH=/usr/lib64/pkgconfig
	econf --bindir=/usr/bin \
	      --libdir=/usr/lib \
	      --runstatedir=/run \
	      --sbindir=/usr/sbin \
          --disable-chfn-chsh \
          --disable-login \
          --disable-nologin \
          --disable-su \
          --disable-setpriv \
          --disable-runuser \
          --disable-pylibmount \
          --disable-liblastlog2 \
          --disable-static \
          --disable-tests \
          --without-python \
          ADJTIME_PATH=/var/lib/hwclock/adjtime \
          --docdir=/usr/share/doc/util-linux-${PV}
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

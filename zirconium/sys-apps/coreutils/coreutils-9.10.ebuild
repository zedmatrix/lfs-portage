EAPI=8
LICENSE=""

# Short one-line description of this package.
DESCRIPTION="Contains the basic utility programs needed by every operating system."

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://www.gnu.org/software/coreutils/"

# Point to any required sources; these will be automatically downloaded by
# Portage.
SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/coreutils/coreutils-${PV}.tar.xz"
#S="${WORKDIR}/${P}"

PATCHES=(
		"${FILESDIR}/coreutils-${PV}-i18n-1.patch"
)

SLOT="0"

KEYWORDS="amd64"

IUSE="-test"

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""

# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}
	sys-apps/acl
	sys-libs/libcap
"

# Build-time dependencies that are executed during the emerge process
BDEPEND="
	app-arch/xz
	dev-lang/perl
"

src_prepare() {
	autoreconf -fv || die "autoreconf failed"
	default
	automake -af || die "automake failed"

}

src_configure() {
	export FORCE_UNSAFE_CONFIGURE=1
	econf --prefix=/usr \
          --enable-no-install-program=kill,uptime

}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
	# move chroot from bin to sbin
    dodir /usr/sbin
    mv "${D}"/usr/bin/chroot "${D}"/usr/sbin/chroot

    # move and fix chroot man page from man1 to man8
    dodir /usr/share/man/man8
    mv "${D}"/usr/share/man/man1/chroot.1 "${D}"/usr/share/man/man8/chroot.8
    sed -i 's/"1"/"8"/' "${D}"/usr/share/man/man8/chroot.8
}

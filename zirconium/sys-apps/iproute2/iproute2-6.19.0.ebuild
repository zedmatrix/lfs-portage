EAPI=8
LICENSE=""

# Short one-line description of this package.
DESCRIPTION="The IPRoute2 package contains programs for basic and advanced IPV4-based networking."

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://www.kernel.org/pub/linux/utils/net/iproute2/"

# Point to any required sources; these will be automatically downloaded by
# Portage.
SRC_URI="https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-${PV}.tar.xz"
#S="${WORKDIR}/${P}"

SLOT="0"

KEYWORDS="amd64"

IUSE="nfs"

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="
	sys-libs/libcap
	nfs? ( net-libs/libtirpc:= )
	dev-libs/elfutils
"
# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"

# Build-time dependencies that are executed during the emerge process
BDEPEND="
	app-arch/xz
	>=sys-devel/bison-2.4
	sys-devel/flex
"

src_configure() {
	sed -i /ARPD/d Makefile
	rm -fv man/man8/arpd.8
}

src_compile() {
	emake NETNS_RUN_DIR=/run/netns
}

src_install() {
	emake DESTDIR="${D}" SBINDIR=/usr/sbin install
	docinto /usr/share/doc/iproute2-${PV}
	dodoc COPYING README*
}

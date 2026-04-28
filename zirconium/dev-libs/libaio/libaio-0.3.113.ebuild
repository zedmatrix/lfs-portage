EAPI=8
LICENSE=""

DESCRIPTION="Asynchronous input/output library that uses the kernels native interface"
# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://pagure.io/libaio"

SRC_URI="https://pagure.io/libaio/archive/libaio-${PV}/libaio-${PV}.tar.gz"
#S="${WORKDIR}/${P}"

SLOT="0"
KEYWORDS="amd64"
IUSE="-test"
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""
# Build-time dependencies that need to be binary compatible with the system
DEPEND=""
# Build-time dependencies that are executed during the emerge process
BDEPEND=""
src_configure() {
	sed -i '/install.*libaio.a/s/^/#/' src/Makefile || die "configure failure"
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

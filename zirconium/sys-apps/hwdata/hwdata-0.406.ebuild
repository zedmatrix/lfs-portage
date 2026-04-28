EAPI=8
LICENSE=""
# Short one-line description of this package.
DESCRIPTION="The hwdata package contains current PCI and vendor id data."
# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://github.com/vcrhonek/hwdata"

SRC_URI="https://github.com/vcrhonek/hwdata/archive/v${PV}/hwdata-${PV}.tar.gz"
#S="${WORKDIR}/${P}"

SLOT="0"
KEYWORDS="amd64"
IUSE=""
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""
# Build-time dependencies that need to be binary compatible with the system
DEPEND=""
# Build-time dependencies that are executed during the emerge process
BDEPEND=""

src_configure() {
	${S}/configure --prefix=/usr --disable-blacklist || die
}

src_install() {
	emake DESTDIR="${D}" install
}

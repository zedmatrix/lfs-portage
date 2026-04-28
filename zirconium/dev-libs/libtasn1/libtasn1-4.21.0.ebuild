EAPI=8
LICENSE=""
# Short one-line description of this package.
DESCRIPTION="a highly portable C library that encodes and decodes DER/BER data following an ASN.1 schema."
# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://www.gnu.org/software/libtasn1/"

SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/libtasn1/libtasn1-4.21.0.tar.gz"
#S="${WORKDIR}/${P}"

SLOT="0"
KEYWORDS="amd64"
IUSE=""
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""
# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"
# Build-time dependencies that are executed during the emerge process
BDEPEND=""

src_configure() {
	econf --prefix=/usr --disable-static || die
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

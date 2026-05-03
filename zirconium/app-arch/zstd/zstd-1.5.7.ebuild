EAPI=8

DESCRIPTION="Zstandard is a real-time compression algorithm, providing high compression ratios, with a wide range of compression"

HOMEPAGE=" "

SRC_URI="https://github.com/facebook/zstd/releases/download/v${PV}/zstd-${PV}.tar.gz"

LICENSE=""

SLOT="0"
KEYWORDS="amd64"
IUSE=""

# Run-time dependencies.
RDEPEND="sys-libs/glibc"

DEPEND="${RDEPEND}"

BDEPEND=""

src_compile() {
    emake prefix=/usr || die
}

src_install() {
    emake DESTDIR="${D}" prefix=/usr install || die
}

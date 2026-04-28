EAPI=8

DESCRIPTION="Lz4 is a lossless compression algorithm, providing compression speed greater than 500 MB/s per core"

HOMEPAGE=" "

SRC_URI="https://github.com/lz4/lz4/releases/download/v${PV}/lz4-${PV}.tar.gz"

LICENSE=""

SLOT="0"

KEYWORDS="amd64"

IUSE=""

#RESTRICT="strip"

# Run-time dependencies.
RDEPEND=""

DEPEND="${RDEPEND}"

BDEPEND=""

src_compile() {
    emake PREFIX=/usr || die
}

src_install() {
    emake DESTDIR="${D}" PREFIX=/usr install || die
}

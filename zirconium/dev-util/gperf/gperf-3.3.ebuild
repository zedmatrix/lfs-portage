EAPI=8
DESCRIPTION="Gperf generates a perfect hash function from a key set."
SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/gperf/gperf-${PV}.tar.gz"

SLOT="0"
KEYWORDS="amd64"


src_configure() {
    econf --prefix=/usr --docdir=/usr/share/doc/gperf-3.3
}

src_compile() {
    emake
}

src_install() {
    emake DESTDIR="${D}" install
}

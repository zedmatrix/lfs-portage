EAPI=8

DESCRIPTION="The Libcap package implements the userspace interface to the POSIX 1003.1e capabilities available in Linux kernels."
SRC_URI="https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-${PV}.tar.xz"

IUSE="-test"
SLOT="0"
KEYWORDS="amd64"

RDEPEND=""

DEPEND="${RDEPEND}"

BDEPEND=""

src_prepare() {
    default

    sed -i '/install -m.*STA/d' libcap/Makefile
}

src_compile() {
    emake prefix=/usr lib=lib
}

src_install() {
    emake prefix=/usr lib=lib install
}

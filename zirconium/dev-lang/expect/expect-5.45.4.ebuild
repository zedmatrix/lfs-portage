EAPI=8

DESCRIPTION="Expect is a tool for automating interactive applications such as telnet, ftp, passwd, fsck, rlogin, tip, etc."

HOMEPAGE="https://core.tcl.tk/expect/"

SRC_URI="https://prdownloads.sourceforge.net/expect/expect${PV}.tar.gz"
MY_P="${PN}${PV}"
SPARENT="${WORKDIR}/${MY_P}"
S="${SPARENT}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""
#RESTRICT="strip"
RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND="dev-lang/tcl"

PATCHES=(
    "${FILESDIR}/expect-5.45.4-gcc15-1.patch"
)

src_configure() {
	econf --disable-rpath \
          --with-tcl=/usr/lib \
          --with-tclinclude=/usr/include
}

src_compile() {
	emake
}

src_install() {
    emake DESTDIR="${D}" install
    dosym expect${PV}/libexpect${PV}.so /usr/lib/libexpect${PV}.so
}

pkg_postinst() {
    ldconfig
}

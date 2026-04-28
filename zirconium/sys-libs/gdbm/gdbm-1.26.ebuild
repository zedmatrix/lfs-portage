EAPI=8
DESCRIPTION="The GNU Database Manager is a library of database functions that uses extensible hashing and works like the standard UNIX dbm."

HOMEPAGE="https://www.gnu.org/software/gdbm/"

SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/gdbm/gdbm-${PV}.tar.gz"
#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="-test"

RDEPEND="
	${DEPEND}
	dev-build/libtool
"

DEPEND="sys-libs/readline"

BDEPEND="
	test? ( dev-util/dejagnu )
"

src_configure() {
	econf --prefix=/usr \
	      --disable-static \
	      --enable-libgdbm-compat

}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install

}

pkg_postinst() {
    ldconfig
}

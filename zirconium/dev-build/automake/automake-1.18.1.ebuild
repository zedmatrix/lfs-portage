EAPI=8
DESCRIPTION="The Automake package contains programs for generating Makefiles for use with Autoconf."

HOMEPAGE="https://www.gnu.org/software/automake/"
SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/automake/automake-${PV}.tar.xz"

#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="-test"

RDEPEND="
	>=dev-lang/perl-5.10
	>=dev-build/autoconf-2.69
"

BDEPEND="
	app-arch/gzip
	dev-build/autoconf
	test? (
		dev-lang/dejagnu
		sys-devel/bison
		sys-devel/flex
	)
"

src_configure() {
	econf --prefix=/usr \
	      --docdir=/usr/share/doc/automake-${PKGVER}
}

src_compile() {
	emake
}

src_test() {
    emake -j$(($(nproc)>4?$(nproc):4)) check || true
}

src_install() {
	emake DESTDIR="${D}" install

}

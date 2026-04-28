EAPI=8
DESCRIPTION="The MPC package contains a library for the arithmetic of complex numbers with arbitrarily high precision and correct rounding of the result."

HOMEPAGE="https://www.multiprecision.org/"

SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/mpc/mpc-${PV}.tar.xz"
#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="test"

#RESTRICT="strip"
RESTRICT="!test? ( test )"
DEPEND="
	>=dev-libs/gmp-5.0.0
	>=dev-libs/mpfr-4.1.0
"
RDEPEND="${DEPEND}"
BDEPEND="
	test? ( dev-lang/dejagnu )
"

src_configure() {
	econf --prefix=/usr \
	      --disable-static \
	      --docdir=/usr/share/doc/mpc-${PV}
}

src_compile() {
	emake
	emake html
}

src_test() {
    emake check 2>&1 | tee "${T}/${P}-check-log"

    elog "Test summary:"
    elog "PASS: $(awk '/# PASS:/{total+=$3} END{print total}' "${T}/${P}-check-log")"
    elog "FAIL: $(awk '/# FAIL:/{total+=$3} END{print total}' "${T}/${P}-check-log")"

}

src_install() {
	emake DESTDIR="${D}" install
	emake DESTDIR="${D}" install-html

}

pkg_postinst() {
    ldconfig
}

EAPI=8
DESCRIPTION="The MPFR package contains functions for multiple precision math."

HOMEPAGE="https://www.mpfr.org/"

SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/mpfr/mpfr-${PV}.tar.xz"
#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="test"

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=">=dev-libs/gmp-5.0.0"

DEPEND="${RDEPEND}"

BDEPEND="
	app-arch/xz
	sys-devel/m4
	test? ( dev-lang/dejagnu )
"

src_configure() {
	econf --prefix=/usr \
	      --disable-static \
	      --enable-thread-safe \
          --docdir=/usr/share/doc/mpfr-${PV}
}

src_compile() {
	emake
	emake html
}

src_test() {
    emake check 2>&1 | tee "${T}/${P}-check-log"
   	if [[ -f "${T}/${P}-check-log" ]]; then
		elog "Test summary:"
		elog "PASS: $(awk '/# PASS:/{total+=$3} END{print total}' "${T}/${P}-check-log")"
	fi
}

src_install() {
	emake DESTDIR="${D}" install
	emake DESTDIR="${D}" install-html
}

pkg_postinst() {
    ldconfig
}

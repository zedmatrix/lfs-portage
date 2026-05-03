EAPI=8
DESCRIPTION="The GMP package contains math libraries. These have useful functions for arbitrary precision arithmetic."
HOMEPAGE="https://www.gnu.org/software/gmp/"
SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/gmp/gmp-6.3.0.tar.xz"

#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="test"

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""

# Build-time dependencies that need to be binary compatible with the system
# being built (CHOST).
DEPEND="${RDEPEND}"

# Build-time dependencies that are executed during the emerge process, and
# only need to be present in the native build system (CBUILD). Example:
BDEPEND="
	app-arch/xz
	sys-devel/m4
	test? ( dev-lang/dejagnu )
"

src_configure() {
	sed -i '/long long t1;/,+1s/()/(...)/' configure
	econf --prefix=/usr \
	      --enable-cxx \
	      --disable-static \
	      --docdir=/usr/share/doc/gmp-${PV}
}

src_compile() {
	emake
	emake html
}

src_test() {
    emake check 2>&1 | tee "${T}/check-log"
}

src_install() {
	emake DESTDIR="${D}" install
	emake DESTDIR="${D}" install-html
}

pkg_postinst() {
	if [[ -f "${T}/${P}-check-log" ]]; then
		einfo "Test summary:"
		einfo "PASS: $(awk '/# PASS:/{total+=$3} END{print total}' "${T}/${P}-check-log")"
	fi

    ldconfig
}

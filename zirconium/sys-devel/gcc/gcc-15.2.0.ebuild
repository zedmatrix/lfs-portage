EAPI=8
DESCRIPTION="The GNU compiler collection which includes the C and C++ compilers."

HOMEPAGE="https://gcc.gnu.org/"

SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/gcc/gcc-${PV}/gcc-${PV}.tar.xz"
#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="sys-libs/glibc"

DEPEND="${RDEPEND}"

BDEPEND="
	dev-libs/gmp
	dev-libs/mpfr
	dev-libs/mpc
"
PDEPEND="sys-apps/shadow"

src_prepare() {
	default
	sed -i 's/char [*]q/const &/' libgomp/affinity-fmt.c
	sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64
    mkdir -v ${WORKDIR}/build
}
src_configure() {
	cd ${WORKDIR}/build || die
	${S}/configure --prefix=/usr LD=ld \
	               --enable-languages=c,c++ \
                   --enable-default-pie \
                   --enable-default-ssp \
                   --enable-host-pie \
                   --disable-multilib \
                   --disable-bootstrap \
                   --disable-fixincludes \
                   --with-pkgversion="Andromeda ${PV}" \
                   --with-system-zlib || die "configure failed"
}

src_compile() {
	cd ${WORKDIR}/build || die
	emake
}

src_test() {
	cd ${WORKDIR}/build || die
	ulimit -s -H unlimited;
	sed -e '/cpython/d' -i ../gcc/testsuite/gcc.dg/plugin/plugin.exp
	emake -k check
}

src_install() {
	cd ${WORKDIR}/build || die
	emake DESTDIR="${D}" install
	dosym /usr/bin/cpp /usr/lib/cpp
	dosym gcc.1 /usr/share/man/man1/cc.1
	dosym ../../libexec/gcc/$(gcc -dumpmachine)/${PV}/liblto_plugin.so /usr/lib/bfd-plugins/liblto_plugin.so
	dodir /usr/share/gdb/auto-load/usr/lib
    mv "${D}"/usr/lib/*gdb.py "${D}"/usr/share/gdb/auto-load/usr/lib/
}

pkg_postinst() {
    ldconfig
}

EAPI=8

DESCRIPTION="The Glibc package contains the main C library"

HOMEPAGE="https://www.gnu.org/software/libc/"

SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/glibc/glibc-${PV}.tar.xz"

LICENSE=""

SLOT="0"

KEYWORDS="amd64"
RESTRICT="strip"
IUSE=""

RDEPEND="sys-libs/tzdata"
DEPEND="${RDEPEND}"
BDEPEND="
    >=sys-util/pax-utils-1.3.3
"
PATCHES=(
	"${FILESDIR}/${PN}-fhs-1.patch"
	"${FILESDIR}/${PN}-macro-guard.patch"
)

src_configure() {
    mkdir -p "${WORKDIR}/build"
    cd "${WORKDIR}/build" || die

    "${S}"/configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --localstatedir=/var \
        --libdir=/usr/lib \
        --mandir=/usr/share/man \
        --infodir=/usr/share/info \
        --enable-kernel=5.4 \
        --enable-stack-protector=strong \
        --enable-bind-now \
        --enable-fortify-source \
        --disable-nscd \
        --disable-werror \
        libc_cv_rootsbindir=/usr/sbin \
        libc_cv_slibdir=/usr/lib \
        || die "configure failed"

}

src_compile() {
	emake -C "${WORKDIR}/build" || die
}

src_install() {
    sed '/test-installation/s@$(PERL)@echo not running@' \
        -i "${WORKDIR}/build/Makefile" || die

    emake -C "${WORKDIR}/build" install_root="${D}" install || die

    # locale data
    emake -C "${S}/localedata" objdir="${WORKDIR}/build" install_root="${D}" install-locales || die
    touch "${ED}/etc/ld.so.conf" || die
    sed '/RTLDLIST=/s@/usr@@g' -i "${ED}/usr/bin/ldd" || die

    insinto /etc
    doins "${FILESDIR}/nsswitch.conf"
}

pkg_postinst() {
    ldconfig || die
    env-update || warn "env-update failed"
}

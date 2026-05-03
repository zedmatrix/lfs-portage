EAPI=8
DESCRIPTION="The Perl package contains the Practical Extraction and Report Language."

HOMEPAGE="https://www.perl.org/"

SRC_URI="https://www.cpan.org/src/5.0/perl-${PV}.tar.xz"
#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="gdbm -test"

#RESTRICT="strip"

RDEPEND="
	app-arch/bzip2
	gdbm? ( sys-libs/gdbm )
	>=app-arch/zlib-1.2.12
	sys-apps/less
"
DEPEND="${RDEPEND}"
BDEPEND="${RDEPEND}"

src_configure() {
	export BUILD_ZLIB=False
    export BUILD_BZIP2=0
	bash ${S}/Configure -des -D prefix=/usr \
	                         -D vendorprefix=/usr \
	                         -D useshrplib \
                             -D usethreads \
                             -D privlib=/usr/lib/perl5/5.42/core_perl \
                             -D archlib=/usr/lib/perl5/5.42/core_perl \
                             -D sitelib=/usr/lib/perl5/5.42/site_perl \
                             -D sitearch=/usr/lib/perl5/5.42/site_perl \
                             -D vendorlib=/usr/lib/perl5/5.42/vendor_perl \
                             -D vendorarch=/usr/lib/perl5/5.42/vendor_perl \
                             -D man1dir=/usr/share/man/man1 \
                             -D man3dir=/usr/share/man/man3 \
                             -D pager="/usr/bin/less -isR"
}

src_compile() {
	emake
}

src_test() {
	if [[ ${EUID} == 0 ]] ; then
		ewarn "Test fails with a sandbox error (#328793) if run as root. Skipping tests..."
		return 0
	fi
	TEST_JOBS=$(nproc) make test_harness || true
}

src_install() {
	emake DESTDIR="${D}" install

}

pkg_postinst() {
    ldconfig
}

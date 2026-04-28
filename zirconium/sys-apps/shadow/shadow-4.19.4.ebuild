EAPI=8
DESCRIPTION="The Shadow package contains programs for handling passwords in a secure way."

HOMEPAGE="https://github.com/shadow-maint/shadow/"

SRC_URI="https://github.com/shadow-maint/shadow/releases/download/${PV}/shadow-${PV}.tar.xz"
#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND=""

DEPEND="
	${RDEPEND}
	sys-apps/acl
	!<sys-libs/glibc-2.38
"

BDEPEND="
	app-arch/xz
	sys-devel/gettext
"

src_prepare() {
	default
	find man -name Makefile.in -exec sed -i 's/getspnam\.3 / /' {} \;
    find man -name Makefile.in -exec sed -i 's/passwd\.5 / /'   {} \;
    sed -e 's:#ENCRYPT_METHOD DES:ENCRYPT_METHOD YESCRYPT:' \
        -e 's:/var/spool/mail:/var/mail:' \
        -e '/PATH=/{s@/sbin:@@;s@/bin:@@}' \
        -i etc/login.defs
    touch /usr/bin/passwd
}

src_configure() {
	econf --sysconfdir=/etc \
	      --disable-static \
	      --with-{b,yes}crypt \
          --without-libbsd \
          --disable-logind \
          --with-group-name-max-length=32
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" exec_prefix=/usr install
	emake -C man DESTDIR="${D}" install-man
}

pkg_postinst() {
	if [[ ${EUID} == 0 ]] ; then
		einfo "Inside chroot converting password and group files"
		pwconv
		grpconv
		mkdir -p /etc/default
		useradd -D --gid 999
		sed -i '/MAIL/s/yes/no/' /etc/default/useradd
	fi
    einfo "As per LFS rules set a root password: passwd root"
}

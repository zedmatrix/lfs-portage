EAPI=8
LICENSE=""
# Short one-line description of this package.
DESCRIPTION="Port of OpenBSD's free SSH release"
# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://www.openssh.com/"

inherit systemd

PARCH=${P/_}
SRC_URI="https://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/${PARCH}.tar.gz"
S="${WORKDIR}/${PARCH}"

SLOT="0"
KEYWORDS="amd64"
IUSE=""
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=">=dev-libs/openssl-1.1.1"

# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"

# Build-time dependencies that are executed during the emerge process
BDEPEND=""

pkg_preinst() {
    # create sshd group if it doesn't exist
    if ! getent group sshd >/dev/null; then
		elog "Created sshd group"
        groupadd -g 50 sshd || die
    fi

    # create sshd user if it doesn't exist
    if ! getent passwd sshd >/dev/null; then
		elog "Created sshd user"
        useradd \
            -c 'sshd PrivSep' \
            -d /var/lib/sshd \
            -g sshd \
            -s /bin/false \
            -u 50 sshd || die
    fi
}

src_configure() {
	${S}/configure --prefix=/usr \
	               --sysconfdir=/etc/ssh \
	               --with-privsep-path=/var/lib/sshd \
                   --with-default-path=/usr/bin \
                   --with-superuser-path=/usr/sbin:/usr/bin \
                   --with-pid-dir=/run || die "configure failure"
}

src_compile() {
	emake
}

src_install() {
	emake install DESTDIR="${D}"

	fperms 600 /etc/ssh/sshd_config

	diropts -m 700
    keepdir /var/lib/sshd
    fowners root:sys /var/lib/sshd

	dobin contrib/ssh-copy-id
	doman contrib/ssh-copy-id.1

	dodoc ChangeLog CREDITS OVERVIEW README* TODO sshd_config
	systemd_dounit "${FILESDIR}"/sshd.socket
	systemd_dounit "${FILESDIR}"/sshd.service
	systemd_newunit "${FILESDIR}"/sshdat.service 'sshd@.service'
}

pkg_postinst() {
    # fix ownership on live system after merge
    chown root:sys /var/lib/sshd
    chmod 700 /var/lib/sshd
    ldconfig
    elog "Start at boot: systemctl enable sshd"
    elog "Start sshd with: systemctl start sshd"
}

EAPI=8
LICENSE=""

# Short one-line description of this package.
DESCRIPTION="Updated config.sub and config.guess file from GNU"

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="Updated config.sub and config.guess file from GNU"

SRC_URI="https://dev.gentoo.org/~sam/distfiles/sys-devel/${PN}/${P}.tar.xz"

S="${WORKDIR}"

SLOT="0"

KEYWORDS="amd64"

src_install() {
	insinto /usr/share/${PN}
    doins config.{sub,guess}
    fperms +x /usr/share/${PN}/config.{sub,guess}
    dodoc ChangeLog

}

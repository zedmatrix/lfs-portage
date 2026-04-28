EAPI=8

DESCRIPTION="Provides an easy to use and platform independent interface to the Linux kernel's syscall filtering mechanism."
SRC_URI="https://github.com/seccomp/libseccomp/releases/download/v2.6.0/libseccomp-${PV}.tar.gz"

SLOT="0"
KEYWORDS="amd64"

DEPEND="
    dev-util/gperf
"

src_configure() {
    econf --prefix=/usr --disable-static
}

src_compile() {
    emake
}

install() {
    emake DESTDIR="${D}" install
}

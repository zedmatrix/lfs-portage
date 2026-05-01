EAPI=8

DESCRIPTION="The Bash package contains the Bourne-Again Shell."

HOMEPAGE="https://www.gnu.org/software/bash/"

SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/bash/bash-${PV}.tar.gz"

#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="sys-libs/glibc"

# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"

# Build-time dependencies that are executed during the emerge process,
BDEPEND=""

src_configure() {
	econf --prefix=/usr \
	      --without-bash-malloc \
          --with-installed-readline \
          --docdir=/usr/share/doc/bash-${PV}
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

pkg_postinst() {
    ldconfig
    einfo "Replace the shell that is currently being run with a new one"
    einfo "exec /usr/bin/bash --login"
}

EAPI=8

DESCRIPTION="The Inetutils package contains programs for basic networking."

HOMEPAGE="https://www.gnu.org/software/inetutils/"

SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/inetutils/inetutils-${PV}.tar.gz"

# The default value for S is ${WORKDIR}/${P}
# If you don't need to change it, leave the S= line out of the ebuild
# to keep it tidy.
#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="-test"

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""

# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"

# Build-time dependencies that are executed during the emerge process, and
BDEPEND=""

src_configure() {
	default
	sed -i 's/def HAVE_TERMCAP_TGETENT/ 1/' telnet/telnet.c

	econf --prefix=/usr \
	      --bindir=/usr/bin \
	      --localstatedir=/var \
	      --disable-logger \
          --disable-whois \
          --disable-rcp \
          --disable-rexec \
          --disable-rlogin \
          --disable-rsh \
          --disable-servers
}

src_compile() {
	emake
}

src_test() {
	emake check
}

src_install() {
	emake DESTDIR="${D}" install
	mv -v ${D}/usr/{,s}bin/ifconfig
}

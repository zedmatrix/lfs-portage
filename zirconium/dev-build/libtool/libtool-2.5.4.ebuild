EAPI=8
DESCRIPTION="GNU generic library support script, to make use of shared libraries simpler with a consistent, portable interface."

HOMEPAGE="https://www.gnu.org/software/libtool/"

SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/libtool/libtool-${PV}.tar.xz"

# The default value for S is ${WORKDIR}/${P}
# If you don't need to change it, leave the S= line out of the ebuild
# to keep it tidy.
#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="-test"

#RESTRICT="strip"

RDEPEND="
	>=dev-build/autoconf-2.69
    >=dev-build/automake-1.13
"
DEPEND=""
BDEPEND=""

src_configure() {
	econf
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

pkg_postinst() {
    ldconfig
}

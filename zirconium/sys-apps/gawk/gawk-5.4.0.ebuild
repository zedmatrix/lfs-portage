EAPI=8
LICENSE=""

# Short one-line description of this package.
DESCRIPTION="The Gawk package contains programs for manipulating text files."

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://www.gnu.org/software/gawk/"

# Point to any required sources; these will be automatically downloaded by
# Portage.
SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/gawk/gawk-${PV}.tar.xz"
#S="${WORKDIR}/${P}"

SLOT="0"

KEYWORDS="amd64"

IUSE="-test"

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""

# Build-time dependencies that need to be binary compatible with the system
DEPEND=""

# Build-time dependencies that are executed during the emerge process
BDEPEND=""

src_configure() {
    sed -i 's/extras//' Makefile.in
    econf --prefix=/usr
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install

	dosym gawk.1 /usr/share/man/man1/awk.1
	docinto /usr/share/doc/gawk-${PV}
	dodoc doc/awkforai.txt doc/*.eps doc/*.pdf doc/*.jpg
}

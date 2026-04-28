EAPI=8
DESCRIPTION="Programs for producing shell scripts that can automatically configure source code."

HOMEPAGE="https://www.gnu.org/software/autoconf/"

SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/autoconf/autoconf-2.72.tar.xz"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="-test"

BDEPEND="
	>=dev-lang/perl-5.10
    >=sys-devel/m4-1.4.16
"
RDEPEND="${BDEPEND}"

src_configure() {
	econf
}

src_compile() {
	emake
}

src_test() {
	emake check
}

src_install() {
	emake DESTDIR="${D}" install
}

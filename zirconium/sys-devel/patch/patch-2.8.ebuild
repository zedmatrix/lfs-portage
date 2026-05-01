EAPI=8
LICENSE=""

DESCRIPTION="A program for modifying or creating files by applying a patch file typically created by the diff program."

HOMEPAGE="https://savannah.gnu.org/projects/patch/"

SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/patch/patch-2.8.tar.xz"
#S="${WORKDIR}/${P}"

SLOT="0"

KEYWORDS="amd64"

IUSE="-test"

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="
	sys-libs/glibc
	sys-apps/attr
"

# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"

# Build-time dependencies that are executed during the emerge process
BDEPEND="dev-build/make"

src_configure() {
	econf --prefix=/usr
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

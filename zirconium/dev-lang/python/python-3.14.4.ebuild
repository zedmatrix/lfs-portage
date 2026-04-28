EAPI=8

DESCRIPTION="An interpreted, interactive, object-oriented programming language"

HOMEPAGE="https://www.python.org/"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

MY_P="Python-${PV}"
SRC_URI="https://www.python.org/ftp/python/${PV}/${MY_P}.tar.xz"
S="${WORKDIR}/${MY_P}"

PATCHES=(
    "${FILESDIR}/${MY_P}-security_fixes-2.patch"
)
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="
	app-arch/bzip2
	app-arch/xz
	app-arch/zstd
	app-arch/zlib
	>=dev-libs/expat-2.1
	dev-libs/libffi
	>=sys-libs/ncurses-5.2
	>=sys-libs/readline-4.1
	>=dev-db/sqlite-3.3.8
	>=dev-libs/openssl-1.1.1
"

# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"

# Build-time dependencies that are executed during the emerge process, and
BDEPEND=""

src_configure() {
	econf --prefix=/usr \
          --enable-shared \
          --with-system-expat \
          --enable-optimizations \
          --without-static-libpython
}

src_compile() {
	emake
}

src_test() {
	if [[ ${EUID} == 0 ]] ; then
		ewarn "Test fails with a sandbox error - if run as root. Skipping tests..."
		return 0
	fi
	emake test TESTOPTS="--timeout 120"
}

src_install() {
	emake DESTDIR="${D}" install
}

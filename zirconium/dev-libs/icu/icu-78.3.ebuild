EAPI=8
LICENSE=""
# Short one-line description of this package.
DESCRIPTION="International Components for Unicode (ICU) package is a mature, widely used set of C/C++ libraries"
# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://icu.unicode.org/"

SRC_URI="https://github.com/unicode-org/icu/releases/download/release-${PV}/icu4c-${PV}-sources.tgz"
S="${WORKDIR}"/${PN}/source

SLOT="0"
KEYWORDS="amd64"
IUSE=""
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""
# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"
# Build-time dependencies that are executed during the emerge process
BDEPEND="
	dev-build/autoconf
	sys-libs/glibc
	sys-devel/gcc
	dev-lang/python
	app-shells/bash
"

src_configure() {
	econf --prefix=/usr
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

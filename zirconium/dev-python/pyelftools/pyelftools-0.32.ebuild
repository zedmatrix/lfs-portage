EAPI=8

DESCRIPTION="pure-Python library for analyzing ELF files and DWARF debugging information"

HOMEPAGE="
    https://pypi.org/project/pyelftools/
    https://github.com/eliben/pyelftools/
"

SRC_URI="
    https://github.com/eliben/pyelftools/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz
"

LICENSE=""

SLOT="0"

KEYWORDS="amd64"

IUSE=""

#RESTRICT="strip"

RDEPEND=""
DEPEND=""
BDEPEND=""

src_compile() {
    pip3 wheel \
        -w dist \
        --no-cache-dir \
        --no-build-isolation \
        --no-deps \
        "${S}" || die
}

src_install() {
    pip3 install \
        --root="${D}" \
        --no-index \
        --find-links dist \
        pyelftools || die
}


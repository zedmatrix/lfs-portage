EAPI=8

DESCRIPTION="Is the distribution-building parts of Flit (a packaging tool for simple Python modules)."

HOMEPAGE="https://pypi.org/project/flit-core/"

LICENSE=""

MY_PN="${PN//-/_}"
MY_P="${MY_PN}-${PV}"
SRC_URI="https://pypi.org/packages/source/${PN:0:1}/${PN}/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

SLOT="0"
KEYWORDS="amd64"
IUSE=""

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND=""

# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"

# Build-time dependencies that are executed during the emerge process, and
BDEPEND="dev-lang/python"

src_configure() { :; }

src_compile() {
	HOME="${T}" pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD
}

src_install() {
	HOME="${T}" pip3 install \
        --no-index \
        --no-user \
        --find-links dist \
        --root "${D}" \
        --prefix=/usr \
        --ignore-installed \
        flit_core || die

}

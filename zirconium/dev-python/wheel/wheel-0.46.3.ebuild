EAPI=8

DESCRIPTION="a Python library that is the reference implementation of the Python wheel packaging standard."

HOMEPAGE="https://pypi.org/project/wheel/"

LICENSE=""

# MY_PN="${PN//-/_}"
MY_P="${PN}-${PV}"
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
	pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD
}

src_install() {
	pip3 install \
        --no-index \
        --no-user \
        --no-deps \
        --ignore-installed \
        --find-links dist \
        --root "${D}" \
        --prefix=/usr \
        wheel || die
}

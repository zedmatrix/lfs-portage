EAPI=8

DESCRIPTION="an open source build system designed to be both extremely fast and as user friendly as possible."

HOMEPAGE="https://pypi.org/project/meson/"

inherit shell-completion

LICENSE=""

SRC_URI="https://github.com/mesonbuild/meson/releases/download/${PV}/meson-${PV}.tar.gz"

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
    pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD || die
}

src_install() {
	pip3 install --no-index --find-links dist \
         --no-user --no-deps \
         --ignore-installed \
         --root "${D}" \
         --prefix=/usr \
         meson || die

    dobashcomp data/shell-completions/bash/meson
    dozshcomp data/shell-completions/zsh/_meson
}

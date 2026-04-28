EAPI=8

DESCRIPTION="Small utility to modify the dynamic linker and RPATH of ELF executables"

HOMEPAGE="https://github.com/NixOS/patchelf"

SRC_URI="https://github.com/NixOS/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""
#RESTRICT="strip"

RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND="
    dev-build/autoconf
    dev-build/automake
"

src_prepare() {
    rm src/elf.h || die
	default
	sed -i -e 's:-Werror::g' configure.ac || die
	bash bootstrap.sh || die "bootstrap failed"
}

src_configure() {
	econf
}

src_compile() {
	emake
}

src_install() {
    emake DESTDIR="${D}" install
}

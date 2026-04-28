EAPI=8

DESCRIPTION="ELF related utils for ELF 32/64 binaries"

HOMEPAGE="https://wiki.gentoo.org/wiki/Hardened/PaX_Utilities"

SRC_URI="https://dev.gentoo.org/~sam/distfiles/app-misc/pax-utils/pax-utils-${PV}.tar.xz"

LICENSE=" "

SLOT="0"

KEYWORDS="amd64"

IUSE=" "

RDEPEND="
	>=sys-libs/libcap-2.24
	dev-python/pyelftools
"

DEPEND="${RDEPEND}"

BDEPEND=""

src_configure() {
    emesonargs=(
    	--prefix=/usr
        -Dlddtree_implementation=sh
        -Dtests=false
        -Duse_fuzzing=false
    )
	meson setup build "${emesonargs[@]}" || die
}

src_compile() {
    ninja -C build || die
}

src_install() {
    DESTDIR="${D}" ninja -C build install || die
}

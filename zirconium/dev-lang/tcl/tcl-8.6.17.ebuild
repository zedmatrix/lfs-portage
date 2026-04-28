EAPI=8

DESCRIPTION="The Tcl package contains the Tool Command Language, a robust general-purpose scripting language."

HOMEPAGE="https://tcl.sourceforge.net/"

SRC_URI="https://downloads.sourceforge.net/tcl/tcl${PV}-src.tar.gz"

MY_P="${PN}${PV}"
SPARENT="${WORKDIR}/${MY_P}"
S="${SPARENT}"/unix

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""
#RESTRICT="strip"

RDEPEND="app-arch/zlib"
DEPEND="${RDEPEND}"
BDEPEND=""


src_configure() {
	econf
}

src_compile() {
	emake
	sed -e "s|${SPARENT}/unix|/usr/lib|" -e "s|${SPARENT}|/usr/include|" -i tclConfig.sh
    sed -e "s|${SPARENT}/unix/pkgs/tdbc1.1.12|/usr/lib/tdbc1.1.12|" \
        -e "s|${SPARENT}/pkgs/tdbc1.1.12/generic|/usr/include|" \
        -e "s|${SPARENT}/pkgs/tdbc1.1.12/library|/usr/lib/tcl8.6|" \
        -e "s|${SPARENT}/pkgs/tdbc1.1.12|/usr/include|" -i pkgs/tdbc1.1.12/tdbcConfig.sh

    sed -e "s|${SPARENT}/unix/pkgs/itcl4.3.4|/usr/lib/itcl4.3.4|" \
        -e "s|${SPARENT}/pkgs/itcl4.3.4/generic|/usr/include|" \
        -e "s|${SPARENT}/pkgs/itcl4.3.4|/usr/include|" -i pkgs/itcl4.3.4/itclConfig.sh
}

src_install() {
    emake DESTDIR="${D}" install

    # private headers
    emake DESTDIR="${D}" install-private-headers
    insinto /usr/include

    fperms 755 /usr/lib/libtcl8.6.so
    fperms 644 /usr/lib/libtclstub8.6.a

    dosym tclsh8.6 /usr/bin/tclsh
    mv "${D}"/usr/share/man/man3/{Thread,Tcl_Thread}.3
}

pkg_postinst() {
    ldconfig
}

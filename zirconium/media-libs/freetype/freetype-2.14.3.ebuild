EAPI=8
LICENSE=""
# Short one-line description of this package.
DESCRIPTION="FreeType2 package contains a library which allows applications to properly render TrueType fonts."
# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://www.freetype.org/"

SRC_URI="https://downloads.sourceforge.net/freetype/freetype-${PV}.tar.xz"
#S="${WORKDIR}/${P}"

SLOT="0"
KEYWORDS="amd64"
IUSE="brotli svg xorg"
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="
	svg? ( >=media-libs/librsvg-2.46.0 )
	brotli? ( app-arch/brotli )
	xorg? ( >=x11-libs/libX11-1.6.2 )
	>=app-arch/bzip2-1.0.6
	>=media-libs/libpng-1.2.51
"

# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"

# Build-time dependencies that are executed during the emerge process
BDEPEND="dev-util/pkgconf"

src_configure() {
	sed -ri "s:.*(AUX_MODULES.*valid):\1:" modules.cfg
	sed -r "s:.*(#.*SUBPIXEL_RENDERING) .*:\1:" -i include/freetype/config/ftoption.h
	${S}/configure --prefix=/usr \
	               --with-harfbuzz=dynamic \
                   --enable-freetype-config \
                   --disable-static || die "configure failure"
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

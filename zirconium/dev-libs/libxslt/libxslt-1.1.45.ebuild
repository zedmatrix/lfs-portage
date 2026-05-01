EAPI=8
LICENSE=""
# Short one-line description of this package.
DESCRIPTION="Package contains XSLT libraries used for extending libxml2 libraries to support XSLT files."
# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://gitlab.gnome.org/GNOME/libxslt"

SRC_URI="https://download.gnome.org/sources/libxslt/1.1/libxslt-${PV}.tar.xz"
#S="${WORKDIR}/${P}"
SLOT="0"
KEYWORDS="amd64"
IUSE=""
# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="
	>=dev-libs/libxml2-2.15.1
"

# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"

# Build-time dependencies that are executed during the emerge process
BDEPEND=""

src_configure() {
	econf --prefix=/usr \
	      --disable-static \
          --docdir=/usr/share/doc/libxslt-${PV}
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

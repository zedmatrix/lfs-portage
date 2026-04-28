EAPI=8

DESCRIPTION="The Intltool is an internationalization tool used for extracting translatable strings from source files."

HOMEPAGE="https://freedesktop.org/wiki/Software/intltool"

SRC_URI="https://launchpad.net/intltool/trunk/${PV}/+download/intltool-${PV}.tar.gz"

#S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

# Build-time dependencies that are executed during the emerge process, and
BDEPEND="
	dev-lang/perl
	dev-perl/XML-Parser
"

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="${BDEPEND}
	sys-devel/gettext"

src_configure() {
	sed -i 's:\\\${:\\\$\\{:' intltool-update.in
	econf
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
	docinto /usr/share/doc/intltool-${PV}
	dodoc doc/I18N-HOWTO
}

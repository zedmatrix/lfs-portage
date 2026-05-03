EAPI=8

DESCRIPTION="A software library that implements a self-contained, serverless, zero-configuration, transactional SQL database engine."

HOMEPAGE="https://sqlite.org/"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="icu"

my_pv() {
    local major minor patch build
    major=$(ver_cut 1)
    minor=$(ver_cut 2)
    patch=$(ver_cut 3)
    build=$(ver_cut 4)
    printf "%d%02d%02d%02d" ${major} ${minor} ${patch} ${build:-0}
}

SRC_URI="https://sqlite.org/2026/sqlite-autoconf-$(my_pv).tar.gz"
S="${WORKDIR}/sqlite-autoconf-$(my_pv)"

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="
	sys-libs/readline
	dev-lang/tcl
	app-arch/zlib
	icu? ( dev-libs/icu )
"

# Build-time dependencies that need to be binary compatible with the system
DEPEND="${RDEPEND}"

# Build-time dependencies that are executed during the emerge process, and
BDEPEND="sys-devel/gcc"

src_configure() {
	econf --prefix=/usr \
	      --disable-static \
	      --enable-fts{4,5} \
          CPPFLAGS="-D SQLITE_ENABLE_COLUMN_METADATA=1 \
                    -D SQLITE_ENABLE_UNLOCK_NOTIFY=1 \
                    -D SQLITE_ENABLE_DBSTAT_VTAB=1 \
                    -D SQLITE_SECURE_DELETE=1"
}

src_compile() {
	emake LDFLAGS.rpath=""
}

src_install() {
	emake DESTDIR="${D}" install
}

EAPI=8

DESCRIPTION="Timezone data for use by programs that need it"
HOMEPAGE="https://www.iana.org/time-zones"
SRC_URI="https://data.iana.org/time-zones/releases/tzdata${PV}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"

S="${WORKDIR}"
RDEPEND=""
DEPEND=""

src_configure() { :; }
src_compile() { :; }

src_install() {
    local zoneinfo="${D}/usr/share/zoneinfo"
    mkdir -pv "${zoneinfo}"/{posix,right}

    for tz in etcetera southamerica northamerica europe africa antarctica \
              asia australasia backward; do
        zic -L /dev/null   -d "${zoneinfo}"       "${S}/${tz}"
        zic -L /dev/null   -d "${zoneinfo}/posix" "${S}/${tz}"
        zic -L leapseconds -d "${zoneinfo}/right" "${S}/${tz}"
    done

    cp -v "${S}"/zone.tab "${S}"/zone1970.tab "${S}"/iso3166.tab "${zoneinfo}"
    zic -d "${zoneinfo}" -p America/New_York

    insinto /usr/share/zoneinfo
}

pkg_postinst() {
    if [[ ! -e /etc/localtime ]]; then
        einfo "Set your timezone with:"
        einfo "  ln -sfv /usr/share/zoneinfo/<region>/<city> /etc/localtime"
    fi
}

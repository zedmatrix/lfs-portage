EAPI=8
LICENSE=""

inherit shell-completion toolchain-funcs

# Short one-line description of this package.
DESCRIPTION="The GRUB package contains the GRand Unified Bootloader."
# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://www.gnu.org/software/grub/"

SRC_URI="https://mirror.csclub.uwaterloo.ca/gnu/grub/grub-${PV}.tar.xz"

DEJAVU_VER=2.37
DEJAVU=dejavu-fonts-ttf-${DEJAVU_VER}
UNIFONT=unifont-17.0.02
SRC_URI+="
	fonts? (
		https://unifoundry.com/pub/unifont/${UNIFONT}/font-builds/${UNIFONT}.pcf.gz
	)
	themes? ( https://downloads.sourceforge.net/project/dejavu/dejavu/${DEJAVU_VER}/${DEJAVU}.tar.bz2 )
"

#S="${WORKDIR}/${P}"
SLOT="0"

KEYWORDS="amd64"

IUSE="device-mapper fonts themes truetype mount nls coreboot efi"

# Build-time dependencies that need to be binary compatible with the system
DEPEND="
	app-arch/xz
	>=sys-libs/ncurses-5.2
	device-mapper? ( >=sys-fs/lvm2-2.02.45 )
	mount? ( sys-fs/fuse3 )
	truetype? ( media-libs/freetype )
"

# Build-time dependencies that are executed during the emerge process
BDEPEND="
	>=sys-devel/flex-2.5.35
	sys-devel/bison
	sys-apps/texinfo
	fonts? ( media-libs/freetype )
	themes? ( media-libs/freetype )
"

# Run-time dependencies. Must be defined to whatever this depends on to run.
RDEPEND="${DEPEND}
	efi? ( sys-boot/efibootmgr )
	nls? ( sys-devel/gettext )
"

QA_EXECSTACK="usr/bin/grub-* usr/sbin/grub-* usr/lib/grub/*"
QA_PRESTRIPPED="usr/lib/grub/*"
QA_MULTILIB_PATHS="usr/lib/grub/*"
QA_WX_LOAD="usr/lib/grub/*"
src_prepare() {
	default
    if use fonts; then
        gunzip -c "${DISTDIR}/${UNIFONT}.pcf.gz" > ${S}/unifont.pcf || die "no unifont.pcf"
    fi
    if use themes; then
		cp "${WORKDIR}/${DEJAVU}/ttf/DejaVuSans.ttf" ${S}/DejaVuSans.ttf
    fi
}

src_configure() {
	# We don't want to leak flags onto boot code.
	export HOST_CCASFLAGS=${CCASFLAGS}
	export HOST_CFLAGS=${CFLAGS}
	export HOST_CPPFLAGS=${CPPFLAGS}
	export HOST_LDFLAGS=${LDFLAGS}
	unset CCASFLAGS CFLAGS CPPFLAGS LDFLAGS
	sed 's/--image-base/--nonexist-linker-option/' -i configure || die "Can Not Patch configure"
	echo depends bli part_gpt > ${S}/grub-core/extra_deps.lst || die "Can Not add extras"
	local econfargs=(
        --prefix=/usr
        --sysconfdir=/etc
        --disable-efiemu
        --disable-werror
        $(use_enable themes grub-themes)
    )
    # build EFI version
    if use efi; then
        "${S}/configure" "${econfargs[@]}" \
            --with-platform=efi \
            --target=x86_64 || die "configure efi failure"
    elif use coreboot; then
		# build BIOS/coreboot version
	    "${S}/configure" "${econfargs[@]}" || die "configure bios failure"
	else
		eerror "missing grub platforms"
		die "add use flages to make.conf"
	fi

}

src_compile() {
	unset CCASFLAGS CFLAGS CPPFLAGS LDFLAGS
    emake
}

src_install() {
    emake DESTDIR="${D}" install
    dostrip -x /usr/lib/grub

    if use fonts; then
		insinto /usr/share/grub
        doins ascii.h widthspec.h *.pf2
    fi
    use mount && install -vDm755 grub-mount "${D}/usr/bin/grub-mount"
}

pkg_postinst() {
    if use efi; then
        elog "To install GRUB for EFI systems:"
        elog "  grub-install --target=x86_64-efi --efi-directory=/boot/efi"
    else
        elog "To install GRUB for BIOS systems:"
	    elog "  grub-install /dev/sdX"
    fi
    elog ""
    elog "Then generate grub.cfg with:"
    elog "  grub-mkconfig -o /boot/grub/grub.cfg"
}

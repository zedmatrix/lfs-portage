# Linux From Scratch - Portage Build

### lfs-portage

### Chapter 5 
+ 01-binutils-2.46.0-pass1.yaml
+ 02-gcc-15.2.0-pass1.yaml
+ 03-linux-headers-7.0.3.yaml
+ 04-glibc-2.43-pass1.yaml
+ 05-libstdcpp-15.2.0.yaml

### Chapter 6
+ 06-m4-1.4.21-temp.yaml
+ 07-ncurses-6.6-temp.yaml
+ 08-bash-5.3-temp.yaml
+ 09-coreutils-9.11-temp.yaml
+ 10-diffutils-3.12-temp.yaml
+ 11-file-5.47-temp.yaml
+ 12-findutils-4.10.0-temp.yaml
+ 13-gawk-5.4.0-temp.yaml
+ 14-grep-3.12-temp.yaml
+ 15-gzip-1.14-temp.yaml
+ 16-make-4.4.1-temp.yaml
+ 17-patch-2.8-temp.yaml
+ 18-sed-4.10-temp.yaml
+ 19-tar-1.35-temp.yaml
+ 20-xz-5.8.3-temp.yaml
+ 21-binutils-2.46.0-pass2.yaml
+ 22-gcc-15.2.0-pass2.yaml

### Chapter 7
+ Create $LFS/usr/sbin/Zlfs-chroot
+ $LFS/usr/sbin/Zlfs-chroot
+ 701-creating-dirs-both.sh
+ 702-create-files_sysv-and-systemd.sh
+ 24-gettext-1.0-temp.yaml
+ 25-nano-9.0-temp.yaml
+ 26-bison-3.8.2-temp.yaml
+ 27-perl-5.42.2-temp.yaml
+ 28-zlib-1.3.2.yaml
+ 29-bzip2-1.0.8.yaml
+ 30-openssl-3.6.2.yaml
+ 31-texinfo-7.3-temp.yaml
+ 32-python-3.14.4-temp.yaml
  - Create /etc/pip.conf
+ 33-util-linux-2.42-temp.yaml
+ 34-libarchive-3.8.7-temp.yaml
+ 35-expat-2.8.0.yaml
+ 36-cmake-4.3.2.yaml
+ 37-ninja-1.13.2.yaml
+ 38-flit-core-3.12.0.yaml
+ 39-packaging-26.2.yaml
+ 40-wheel-0.46.3.yaml
+ 41-setuptools-82.0.1.yaml
+ 42-meson-1.11.1.yaml
+ 43-libcap-2.78.yaml
+ 44-gperf-3.3.yaml
+ 45-libseccomp-2.6.0.yaml
+ 46-pyelftools-0.32.yaml
+ 47-pax-utils-1.3.9.yaml
+ 48-portage-3.0.77.yaml

### Chapter 8 - Using Portage to build Linux From Scratch:
+ Install baselayout
	> may need some adjustments
+ emerge -v @world
+ Edit /etc/portage/make.conf
	- `USE="lzo nettle nls efi device-mapper fonts themes"`
+ emerge grub
+ emerge linux
+ emerge iproute2

### Rebooting
+ Create /etc/fstab
+ Create /boot/grub/grub.cfg
+ Set root password
+ Install bash startup scripts 
    > like the zlfs-scripts

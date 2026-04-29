MODE=755
DIRMODE=754
CONFMODE=644
RELEASE ?= "zirconium"
EAPI ?= 8
REPO = /var/db/repos/$(RELEASE)

all: install-dirs install-files

install-dirs:
	install -m ${DIRMODE} -d /etc/profile.d
	install -m $(DIRMODE) -d /etc/portage/repos.conf
	install -m $(DIRMODE) -d /usr/share/portage/config/sets
	install -m $(DIRMODE) -d /var/tmp/portage
	install -m $(DIRMODE) -d /var/cache/binpkgs
	install -m $(DIRMODE) -d /var/cache/packages
	install -m $(DIRMODE) -d $(REPO)/metadata
	install -m $(DIRMODE) -d $(REPO)/profiles
	install -m $(DIRMODE) -d $(REPO)/profiles/default/linux

install-files:
	@echo $(RELEASE) > /etc/hostname
	@echo $(RELEASE) > $(REPO)/profiles/repo_name
	install -m $(CONFMODE) etc/protocols /etc/protocols
	install -m $(CONFMODE) etc/services  /etc/services
	install -m $(CONFMODE) etc/make.conf /etc/portage/make.conf
	install -m $(CONFMODE) etc/0path-functions.sh   /etc/profile.d/0path-functions.sh
	install -m $(CONFMODE) etc/zirconium.conf /etc/portage/repos.conf/zirconium.conf
	install -m $(CONFMODE) share/make.globals /usr/share/portage/config/make.globals
	install -m $(CONFMODE) var/layout.conf $(REPO)/metadata/layout.conf
	install -m $(CONFMODE) var/eapi $(REPO)/profiles/default/linux/eapi
	install -m $(CONFMODE) var/profiles.desc $(REPO)/profiles/profiles.desc
	install -m $(CONFMODE) var/make.defaults $(REPO)/profiles/default/linux/make.defaults
	ln -sfv $(REPO)/profiles/default/linux/amd64 /etc/portage/make.profile

install-etc:
	@echo "Installing LFS and BLFS /etc files"
	install -m $(CONFMODE) etc/adjtime        /etc/adjtime
	install -m $(CONFMODE) etc/bashrc         /etc/bashrc
	install -m $(CONFMODE) etc/hosts          /etc/hosts
	install -m $(CONFMODE) etc/inputrc        /etc/inputrc
	install -m $(CONFMODE) etc/issue          /etc/issue
	install -m $(CONFMODE) etc/locale.conf    /etc/locale.conf
	install -m $(CONFMODE) etc/profile        /etc/profile
	install -m $(CONFMODE) etc/shells         /etc/shells
	install -m $(CONFMODE) etc/vconsole.conf  /etc/vconsole.conf

.PHONY: all install-dirs install-files

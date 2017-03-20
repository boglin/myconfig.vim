#  Make behaviour
SHELL:=/bin/bash

# Standard Directories
TEMP_DIR=/tmp/devenv
DL_DIR:=$(TEMP_DIR)/downloads

# Verify external args
ifndef TARGET_DIR
$(error "TARGET_DIR must be specified externally")
endif

##############################################################################
# Applications
#
APPS:=\
	$(TARGET_DIR)/bin/vim \
	$(TARGET_DIR)/bin/tmux \
	$(TARGET_DIR)/bin/mutt

VIM_PLUGINS:=\
	$(TARGET_DIR)/share/vim/vim80/pack/scrooloose/opt/nerdtree \
	$(TARGET_DIR)/share/vim/vim80/pack/sjl/opt/gundo.vim \
	$(TARGET_DIR)/share/vim/vim80/pack/altercation/opt/vim-colors-solarized \
	$(TARGET_DIR)/share/vim/vim80/pack/tpope/opt/vim-fugitive \
	$(TARGET_DIR)/share/vim/vim80/pack/itchyny/opt/lightline.vim \
	$(TARGET_DIR)/share/vim/vim80/pack/boglin/opt/myconfig.vim \
	$(TARGET_DIR)/share/vim/vim80/pack/christoomey/opt/vim-tmux-navigator \
	$(TARGET_DIR)/share/vim/vim80/pack/tpope/opt/vim-eunuch \
	$(TARGET_DIR)/share/vim/vim80/pack/tpope/opt/vim-speeddating \
	$(TARGET_DIR)/share/vim/vim80/pack/tpope/opt/vim-surround \
	$(TARGET_DIR)/share/vim/vim80/pack/ap/opt/vim-css-color \
	$(TARGET_DIR)/share/vim/vim80/pack/maralla/opt/validator.vim \
	$(TARGET_DIR)/share/vim/vim80/pack/reedes/opt/vim-pencil \
	$(TARGET_DIR)/share/vim/vim80/pack/edkolev/opt/tmuxline.vim

.PHONY all:
all: $(TARGET_DIR)/activate $(APPS) $(VIM_PLUGINS)

# Dependencies
$(TARGET_DIR)/bin/vim: $(TARGET_DIR)/bin/python2.7 $(TARGET_DIR)/bin/python3.6
$(TARGET_DIR)/bin/tmux: $(TARGET_DIR)/lib/libevent.dylib
$(TARGET_DIR)/lib/libevent.dylib: $(TARGET_DIR)/lib/libssl.dylib
$(TARGET_DIR)/bin/mutt: $(TARGET_DIR)/lib/libkyotocabinet.dylib $(TARGET_DIR)/lib/libssl.dylib

##############################################################################
#
# Downloads original source
#

define download

$(DL_DIR)/$(1).tgz:
	mkdir -p $$(dir $$@)
	curl --silent --output "$$@" -O -L "$(2)"

endef

$(eval $(call download,bin/mutt,https://github.com/neomutt/neomutt/releases/download/neomutt-20170306/neomutt-20170306.tar.gz))
$(eval $(call download,bin/python2.7,https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz))
$(eval $(call download,bin/python3.6,https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tgz))
$(eval $(call download,bin/tmux,https://github.com/tmux/tmux/releases/download/2.3/tmux-2.3.tar.gz))
$(eval $(call download,bin/vim,https://codeload.github.com/vim/vim/tar.gz/v8.0.0336))
$(eval $(call download,lib/libevent.dylib,https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz))
$(eval $(call download,lib/libssl.dylib,https://github.com/openssl/openssl/archive/OpenSSL_1_0_2k.tar.gz))
$(eval $(call download,lib/libkyotocabinet.dylib,http://fallabs.com/kyotocabinet/pkg/kyotocabinet-1.2.76.tar.gz))

# notmuch:
#  https://notmuchmail.org/releases/notmuch-0.23.7.tar.gz
#
# Installed into:
# /Users/dave/experiments/cli/tools/share/vim/vim80/pack/<author>/opt/<module>
# --
# powerline/fonts
# https://github.com/powerline/fonts/tree/a44abd0e742ad6e7fd8d8bc4c3cad5155c9f3a92
#
#
$(eval $(call download,share/vim/vim80/pack/scrooloose/opt/nerdtree,https://codeload.github.com/scrooloose/nerdtree/zip/281701021c5001332a862da80175bf585d24e2e8))
$(eval $(call download,share/vim/vim80/pack/sjl/opt/gundo.vim,https://github.com/sjl/gundo.vim/archive/v2.6.2.tar.gz))
$(eval $(call download,share/vim/vim80/pack/altercation/opt/vim-colors-solarized,https://codeload.github.com/altercation/vim-colors-solarized/zip/528a59f26d12278698bb946f8fb82a63711eec21))
$(eval $(call download,share/vim/vim80/pack/tpope/opt/vim-fugitive,https://codeload.github.com/tpope/vim-fugitive/zip/f44845e4408aae03e018e98afb7fbf0c2ee87dd5))
$(eval $(call download,share/vim/vim80/pack/itchyny/opt/lightline.vim,https://codeload.github.com/itchyny/lightline.vim/zip/a63a00d548fd20457a4f31d31fb9c8fe8a7ebc2a))
# --> needs some fonts and config
$(eval $(call download,share/vim/vim80/pack/boglin/opt/myconfig.vim,https://codeload.github.com/boglin/myconfig.vim/zip/master))
$(eval $(call download,share/vim/vim80/pack/christoomey/opt/vim-tmux-navigator,https://codeload.github.com/christoomey/vim-tmux-navigator/zip/1b24c5a4626e5a0032920cd44d118086aa0305cd))
# --> Requires tmux config
# --> Needs to run tmux - which needs a DYLD_LIBRARY_PATH
$(eval $(call download,share/vim/vim80/pack/tpope/opt/vim-eunuch,https://codeload.github.com/tpope/vim-eunuch/zip/7eeb681ff3caedc1c01e50966bc293951f7b3e21))
$(eval $(call download,share/vim/vim80/pack/tpope/opt/vim-speeddating,https://codeload.github.com/tpope/vim-speeddating/zip/426c792e479f6e1650a6996c683943a09344c21e))
$(eval $(call download,share/vim/vim80/pack/tpope/opt/vim-surround,https://codeload.github.com/tpope/vim-surround/zip/e49d6c2459e0f5569ff2d533b4df995dd7f98313))
$(eval $(call download,share/vim/vim80/pack/ap/opt/vim-css-color,https://codeload.github.com/ap/vim-css-color/zip/2411b84298eb6db034001f35ce7cc32c36f9b43b))
$(eval $(call download,share/vim/vim80/pack/maralla/opt/validator.vim,https://codeload.github.com/maralla/validator.vim/zip/96031d2273060a48e4bf363d121924ad810338a6))
# : Need flake8 + external linters
$(eval $(call download,share/vim/vim80/pack/reedes/opt/vim-pencil,https://github.com/reedes/vim-pencil/archive/v1.4.tar.gz))
$(eval $(call download,share/vim/vim80/pack/edkolev/opt/tmuxline.vim,https://codeload.github.com/edkolev/tmuxline.vim/zip/master))

##############################################################################
# Builders
#
# Standard compilation flags
CPPFLAGS:="-I$(TARGET_DIR)/include"
LDFLAGS:="-L$(TARGET_DIR)/lib"
DYLD_LIBRARY_PATH:=$(TARGET_DIR)/lib
PKG_CONFIG_LIBDIR:="$(TARGET_DIR)/lib/pkgconfig"

# GNU builder
$(TARGET_DIR)/bin/%: $(DL_DIR)/bin/%.tgz
	# Working dir
	mkdir -p $(TEMP_DIR)/$@
	# Extract
	tar -C $(TEMP_DIR)/$@ -xf $<
	cd $(TEMP_DIR)/$@/* && env \
		CPPFLAGS=$(CPPFLAGS) \
		LDFLAGS=$(LDFLAGS) \
		PKG_CONFIG_LIBDIR=$(PKG_CONFIG_LIBDIR) \
		DYLD_LIBRARY_PATH=$(DYLD_LIBRARY_PATH) \
		./configure \
		--prefix=$(TARGET_DIR)
	make -C $(TEMP_DIR)/$@/* -j8
	make -C $(TEMP_DIR)/$@/* install

$(TARGET_DIR)/lib/%: $(DL_DIR)/lib/%.tgz
	# Working dir
	mkdir -p $(TEMP_DIR)/$@
	# Extract
	tar -C $(TEMP_DIR)/$@ -xf $<
	cd $(TEMP_DIR)/$@/* && env \
		CPPFLAGS=$(CPPFLAGS) \
		LDFLAGS=$(LDFLAGS) \
		PKG_CONFIG_LIBDIR=$(PKG_CONFIG_LIBDIR) \
		DYLD_LIBRARY_PATH=$(DYLD_LIBRARY_PATH) \
		./configure \
		--prefix=$(TARGET_DIR)
	make -C $(TEMP_DIR)/$@/* -j8
	make -C $(TEMP_DIR)/$@/* install


# OpenSSL builder
$(TARGET_DIR)/lib/libssl.dylib: $(DL_DIR)/lib/libssl.dylib.tgz
	# Working dir
	mkdir -p $(TEMP_DIR)/$@
	# Extract
	tar -C $(TEMP_DIR)/$@ -xf $<
	cd $(TEMP_DIR)/$@/* && ./Configure darwin64-x86_64-cc shared --prefix=$(TARGET_DIR)
	make -C $(TEMP_DIR)/$@/* -j8
	make -C $(TEMP_DIR)/$@/* install

# neomutt builder
$(TARGET_DIR)/bin/mutt: $(DL_DIR)/bin/mutt.tgz
	# Working dir
	mkdir -p $(TEMP_DIR)/$@
	# Extract
	tar -C $(TEMP_DIR)/$@ -xf $<
	cd $(TEMP_DIR)/$@/* && env \
		CPPFLAGS=$(CPPFLAGS) \
		LDFLAGS=$(LDFLAGS) \
		PKG_CONFIG_LIBDIR=$(PKG_CONFIG_LIBDIR) \
		DYLD_LIBRARY_PATH=$(DYLD_LIBRARY_PATH) \
		./configure \
		--prefix=$(TARGET_DIR) \
		--with-homespool \
		--disable-dependency-tracking \
		--disable-warnings \
		--with-ssl \
		--with-kyotocabinet \
		--enable-sidebar
	make -C $(TEMP_DIR)/$@/* -j8
	make -C $(TEMP_DIR)/$@/* install

# KyotoCabinet builder
$(TARGET_DIR)/lib/libkyotocabinet.dylib: $(DL_DIR)/lib/libkyotocabinet.dylib.tgz
	# Working dir
	mkdir -p $(TEMP_DIR)/$@
	# Extract
	tar -C $(TEMP_DIR)/$@ -xf $<
	cd $(TEMP_DIR)/$@/* && env \
		CPPFLAGS="$(CPPFLAGS) -D__GXX_EXPERIMENTAL_CXX0X__" \
		LDFLAGS=$(LDFLAGS) \
		PKG_CONFIG_LIBDIR=$(PKG_CONFIG_LIBDIR) \
		DYLD_LIBRARY_PATH=$(DYLD_LIBRARY_PATH) \
		./configure \
		--prefix=$(TARGET_DIR)
	make -C $(TEMP_DIR)/$@/* -j8
	make -C $(TEMP_DIR)/$@/* install

# Build Vim Plugin
$(TARGET_DIR)/share/vim/vim80/pack/%: $(DL_DIR)/share/vim/vim80/pack/%.tgz
	# Working dir
	mkdir -p $@
	# Extract
	tar -C $@ --strip-components=1 -xf $<

# vim builder
$(TARGET_DIR)/bin/vim: $(DL_DIR)/bin/vim.tgz
	# Working dir
	mkdir -p $(TEMP_DIR)/$@
	# Extract
	tar -C $(TEMP_DIR)/$@ -xf $<
	cd $(TEMP_DIR)/$@/* && env \
		PATH=$(TARGET_DIR)/bin:$(PATH) \
		CPPFLAGS="$(CPPFLAGS)" \
		LDFLAGS=$(LDFLAGS) \
		PKG_CONFIG_LIBDIR=$(PKG_CONFIG_LIBDIR) \
		DYLD_LIBRARY_PATH=$(DYLD_LIBRARY_PATH) \
		./configure \
		--prefix=$(TARGET_DIR) \
		--enable-pythoninterp \
		--enable-python3interp
	make -C $(TEMP_DIR)/$@/* -j8
	make -C $(TEMP_DIR)/$@/* install

# Activate script
$(TARGET_DIR)/activate:
	mkdir -p $(dir $@)
	echo PATH=$(TARGET_DIR)/bin:\$${PATH} > $@
	echo DYLD_LIBRARY_PATH=$(DYLD_LIBRARY_PATH):\$${DYLD_LIBRARY_PATH} >> $@
	chmod a+x $@

# Python builder
$(TARGET_DIR)/bin/python2.7: $(DL_DIR)/bin/python2.7.tgz
	# Working dir
	mkdir -p $(TEMP_DIR)/$@
	# Extract
	tar -C $(TEMP_DIR)/$@ -xf $<
	cd $(TEMP_DIR)/$@/* && env \
		PATH=$(TARGET_DIR)/bin:$(PATH) \
		CPPFLAGS="$(CPPFLAGS)" \
		LDFLAGS=$(LDFLAGS) \
		PKG_CONFIG_LIBDIR=$(PKG_CONFIG_LIBDIR) \
		DYLD_LIBRARY_PATH=$(DYLD_LIBRARY_PATH) \
		./configure \
		--prefix=$(TARGET_DIR) \
		--enable-shared
	make -C $(TEMP_DIR)/$@/* -j8
	make -C $(TEMP_DIR)/$@/* install

$(TARGET_DIR)/bin/python3.6: $(DL_DIR)/bin/python3.6.tgz
	# Working dir
	mkdir -p $(TEMP_DIR)/$@
	# Extract
	tar -C $(TEMP_DIR)/$@ -xf $<
	cd $(TEMP_DIR)/$@/* && env \
		PATH=$(TARGET_DIR)/bin:$(PATH) \
		CPPFLAGS="$(CPPFLAGS)" \
		LDFLAGS=$(LDFLAGS) \
		PKG_CONFIG_LIBDIR=$(PKG_CONFIG_LIBDIR) \
		DYLD_LIBRARY_PATH=$(DYLD_LIBRARY_PATH) \
		./configure \
		--prefix=$(TARGET_DIR) \
		--enable-shared
	make -C $(TEMP_DIR)/$@/* -j8
	make -C $(TEMP_DIR)/$@/* install


# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/neovim/neovim-0.0.0_pre20150505.ebuild,v 1.1 2015/05/06 13:53:55 yngwin Exp $

EAPI=5
inherit cmake-utils flag-o-matic

DESCRIPTION="Vim's rebirth for the 21st century"
HOMEPAGE="https://github.com/neovim/neovim"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://github.com/neovim/neovim.git"
else
	SRC_URI="http://dev.gentoo.org/~yngwin/distfiles/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="Apache-2.0 vim"
SLOT="0"
IUSE="perl python"

CDEPEND="dev-lang/luajit:2
	>=dev-libs/libtermkey-0.17
	dev-libs/libvterm-neovim
	>=dev-libs/unibilium-1.1.1
	>=dev-libs/libuv-1.2.0
	>=dev-libs/msgpack-0.6.0_pre20150220
	dev-lua/lpeg
	dev-lua/messagepack"
DEPEND="${CDEPEND}
	virtual/libiconv
	virtual/libintl"
RDEPEND="${CDEPEND}
	perl? ( dev-lang/perl )
	python? ( dev-python/neovim-python-client )"

src_prepare() {
	# use our system vim dir
	sed -e '/^# define SYS_VIMRC_FILE/s|$VIM|'"${EPREFIX}"'/etc/vim|' \
		-i src/nvim/os_unix_defs.h || die
	cmake-utils_src_prepare
}

src_configure() {
	export USE_BUNDLED_DEPS=OFF
	append-cflags "-Wno-error"
	append-cppflags "-DNDEBUG -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1"
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DLIBUNIBILIUM_USE_STATIC=OFF
		-DLIBTERMKEY_USE_STATIC=OFF
		-DLIBVTERM_USE_STATIC=OFF
		)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	# install a default configuration file
	insinto /etc/vim
	doins "${FILESDIR}"/nvimrc
}

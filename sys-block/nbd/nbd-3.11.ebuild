# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/nbd/nbd-3.11.ebuild,v 1.6 2015/06/11 19:10:41 maekke Exp $

EAPI="4"

inherit toolchain-funcs

DESCRIPTION="Userland client/server for kernel network block device"
HOMEPAGE="http://nbd.sourceforge.net/"
SRC_URI="mirror://sourceforge/nbd/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~ppc ppc64 ~sparc x86"
IUSE="debug zlib"

RDEPEND=">=dev-libs/glib-2.0
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	econf \
		--enable-lfs \
		--enable-syslog \
		$(use_enable debug) \
		$(use_enable zlib gznbd)
}

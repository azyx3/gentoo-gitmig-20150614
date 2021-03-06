# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libp11/libp11-0.2.8.ebuild,v 1.16 2015/06/06 19:17:36 jlec Exp $

EAPI="4"

inherit autotools libtool

DESCRIPTION="A library implementing a layer on top of PKCS#11 API to make using PKCS#11 implementations easier"
HOMEPAGE="https://github.com/opensc/libp11/wiki"
SRC_URI="mirror://sourceforge/opensc/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE="doc"

# Drop the libtool dep once libltdl goes stable.
RDEPEND="dev-libs/openssl:0
	|| ( dev-libs/libltdl:0 <sys-devel/libtool-2.4.3-r2:2 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"

if [[ "${PV}" = "9999" ]]; then
	DEPEND="${DEPEND}
		app-text/docbook-xsl-stylesheets
		dev-libs/libxslt"
fi

src_prepare() {
	[[ "${PV}" = "9999" ]] && eautoreconf

	elibtoolize
}

src_configure() {
	econf \
		--docdir="/usr/share/doc/${PF}" \
		--htmldir="/usr/share/doc/${PF}/html" \
		--enable-shared --disable-static \
		--enable-doc \
		$(use_enable doc api-doc)
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	find "${D}" -name '*.la' -delete
}

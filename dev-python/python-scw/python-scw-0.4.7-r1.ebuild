# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-scw/python-scw-0.4.7-r1.ebuild,v 1.1 2015/01/06 02:32:57 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit python-r1

DESCRIPTION="Python binding for Scw"
HOMEPAGE="http://scwwidgets.googlepages.com/"
SRC_URI="http://scwwidgets.googlepages.com/${P}.tar.gz "

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/pygtk-2.4[${PYTHON_USEDEP}]
	>=x11-libs/scw-0.4.0"
RDEPEND="${DEPEND}"

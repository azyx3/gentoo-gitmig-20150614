# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-neon/gst-plugins-neon-0.10.23-r1.ebuild,v 1.7 2014/08/25 11:01:44 ago Exp $

EAPI="5"

GST_ORG_MODULE=gst-plugins-bad
inherit gstreamer

KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE=""

RDEPEND=">=net-libs/neon-0.30.0[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"

src_prepare() {
	# Allow building with neon-0.30 and avoid eautoreconf
	# https://bugzilla.gnome.org/show_bug.cgi?id=705812
	sed -e 's#neon <= 0.29.99#neon <= 0.30.99#' -i configure{.ac,} || die
}

# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/xlrd/xlrd-0.9.3.ebuild,v 1.5 2015/04/08 08:05:04 mgorny Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit distutils-r1

DESCRIPTION="Library for developers to extract data from Microsoft Excel (tm) spreadsheet files"
HOMEPAGE="http://www.python-excel.org/
	https://github.com/python-excel/xlrd/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86 ~ppc-aix ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~x86-linux ~sparc-solaris ~x86-solaris"

python_prepare_all() {
	# Remove this if examples get reintroduced
	sed -i -e "s/test_names_demo/_&/" tests/test_open_workbook.py || die

	distutils-r1_python_prepare_all
}

python_test() {
	"${PYTHON}" -m unittest discover || die "Test failed with ${EPYTHON}"
}

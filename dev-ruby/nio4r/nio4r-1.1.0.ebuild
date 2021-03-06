# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/nio4r/nio4r-1.1.0.ebuild,v 1.2 2015/03/24 16:20:14 graaff Exp $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21 ruby22"

RUBY_FAKEGEM_RECIPE_TEST="rspec3"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGES.md README.md"

inherit ruby-fakegem

DESCRIPTION="A high performance selector API for monitoring IO objects"
HOMEPAGE="https://github.com/celluloid/nio4r"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64"
IUSE=""

# Note that nio4r bundles a patched copy of libev, and without these
# patches the tests fail: https://github.com/celluloid/nio4r/issues/15

all_ruby_prepare() {
	sed -i -e '/[Cc]overalls/d' -e '/[Bb]undler/d' spec/spec_helper.rb || die
	sed -e '/extension/ s:^:#:' -i Rakefile || die
}

each_ruby_configure() {
	${RUBY} -Cext/${PN} extconf.rb || die
}

each_ruby_compile() {
	emake V=1 -Cext/${PN}
	cp ext/${PN}/*$(get_modname) lib/ || die
}

# vim: ts=2:sts=2:sw=2

stow:
	@stow --verbose --target=$HOME --restow */

unstow:
	@stow --verbose --target=$HOME --delete */

[private]
gen-packages:
	sed '/^#/d;s/+//;s/^[[:space:]]*//;/^[[:space:]]*$/d' packages.md > /tmp/pkglist

install-packages: gen-packages
	paru -S --noconfirm - < /tmp/pkglist

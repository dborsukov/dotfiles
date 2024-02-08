all:
	stow --verbose --target=$$HOME --restow */

delete:
	stow --verbose --target=$$HOME --delete */

pkgs:
	sed '/^#/d;s/+//;s/^[[:space:]]*//' packages.md > /tmp/pkglist

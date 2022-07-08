#! /bin/sh

apt-get --yes update
apt-get --yes install wget equivs curl git

git config --global --add safe.directory /home/travis/build/Nitrux/nx-maui-desktop-apps

deps=$(sed -e '/^#.*$/d; /^$/d; /^\s*$/d' package/dependencies | paste -sd ,)
git_commit=$(git rev-parse --short HEAD)

> configuration printf "%s\n" \
	"Section: misc" \
	"Priority: optional" \
	"Homepage: https://nxos.org" \
	"Package: nx-maui-desktop-apps" \
	"Version: 0.0.1-$git_commit" \
	"Maintainer: Uri Herrera <uri_herrera@nxos.org>" \
	"Depends: $deps" \
	"Conflicts: nx-desktop-apps, nx-desktop-apps-legacy, nx-desktop-apps-minimal, nx-desktop-apps-legacy-minimal" \
	"Architecture: amd64" \
	"Description: Meta-package to install third-party software in Nitrux."

equivs-build configuration

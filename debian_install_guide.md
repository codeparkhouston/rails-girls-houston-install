# Debian Install Guide

For Debian-backed distributions. Should work flawlessly in Unbuntu, Linux Mint and any Debian based on Testing or Sid. If you are running another flavor of Linux, or are running Debian Stable, please speak with a coach or see the note below.

Otherwise, simply open a terminal and enter the following command to get started!

    bash < <(curl -s https://raw.github.com/codeparkhouston/rails-girls-houston-install/master/debian_install_script.sh)


### Debian Stable Note

Debian Stable (Wheezy) does not yet have a package for nodejs, which is used by parts of Rails to make your life easier when dealing with large numbers of JavaScript files (normal for even a medium-sized website).

The most reiable way to get nodejs on Debian Stable is to simply build it following the instructions here:
[https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager](https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager)

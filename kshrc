alias ls='colorls -GF'
alias doas='doas '
alias poweroff='doas halt -p'

set -A complete_rcctl_1 -- disable enable get ls order set
set -A complete_rcctl_2 -- $(ls /etc/rc.d)
set -A complete_make_1 -- install clean repackage reinstall
set -A complete_ifconfig_1 -- $(ifconfig | grep ^[a-z] | cut -d: -f1)
PKG_LIST=$(ls -1 /var/db/pkg)
set -A complete_pkg_delete -- $PKG_LIST
set -A complete_pkg_info -- $PKG_LIST
set -A complete_mixerctl_1 -- $(mixerctl | cut -d= -f 1)
set -A complete_git_1 -- pull push mpull mpush clone checkout status commit

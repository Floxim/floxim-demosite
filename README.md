floxim-demosite
===============

Clone this repo to get ready-to-use Floxim instance (with installer, demo site and everything).
Floxim itself comes as submodule, so to set up demo site to /var/www/mysitename.com you should do:

    cd /var/www
    git clone https://github.com/Floxim/floxim-demosite.git mysitename.com
    git submodule init
    git submodule update

Clone psr0 branch:

    git clone  --recursive  --branch psr0 --origin psr0 https://github.com/Floxim/floxim-demosite.git "mysitename.com"
    cd mysitename.com
    find . -type f -exec chmod 666 {} \;
    find . -type d -exec chmod 777 {} \;

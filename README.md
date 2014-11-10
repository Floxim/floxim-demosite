Floxim demosite repository
===============

Clone this repo to get ready-to-use Floxim instance (with installer, demo site and everything).
Floxim itself comes as submodule, so to set up demo site to /var/www/mysitename.com you should do:

    cd /var/www
    git clone --depth 1 https://github.com/Floxim/floxim-demosite.git mysitename.com
    cd mysitename.com
    git submodule update --init

Load dependencies with composer:

    composer install

Then open mysitename.com in browser to run installer script. 
